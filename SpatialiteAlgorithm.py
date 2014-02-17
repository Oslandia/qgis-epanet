# -*- coding: utf-8 -*-

"""
***************************************************************************
    SpatialiteAlgorithm.py
    ---------------------
    Date                 : December 2013
    Copyright            : (C) 2013 by Vincent Mora
    Email                : vincent dot mora dot mtl at gmail dot com
***************************************************************************
*                                                                         *
*   This program is free software; you can redistribute it and/or modify  *
*   it under the terms of the GNU General Public License as published by  *
*   the Free Software Foundation; either version 2 of the License, or     *
*   (at your option) any later version.                                   *
*                                                                         *
***************************************************************************
"""

__author__ = 'Vincent Mora'
__date__ = 'December 2013'
__copyright__ = '(C) 2013, Oslandia'

# This will get replaced with a git SHA1 when you do a git archive

__revision__ = '$Format:%H$'

import os
import re
import datetime
import codecs
import subprocess
from qgis.core import *
from PyQt4.QtCore import *
from PyQt4.QtGui import *

from pyspatialite import dbapi2

from processing.core.GeoAlgorithm import GeoAlgorithm
from processing.core.GeoAlgorithmExecutionException import \
        GeoAlgorithmExecutionException
from processing.core.ProcessingLog import ProcessingLog
from processing.parameters.ParameterTable import ParameterTable
from processing.parameters.ParameterString import ParameterString
from processing.parameters.Parameter import Parameter
from EpanetOutputTable import EpanetOutputTable
from processing.core.ProcessingConfig import ProcessingConfig
from processing.tools import dataobjects


class SpatialiteAlgorithm(GeoAlgorithm):


    INPUT_TABLE = 'INPUT_TABLE'
    OUTPUT_TABLE = 'OUTPUT_TABLE'
    QUERY = 'QUERY'

    def __init__(self):
        GeoAlgorithm.__init__(self)

    def getIcon(self):
        return QIcon(os.path.dirname(__file__) + '/spatialite.svg')

    def helpFile(self):
       return None 

    def commandLineName(self):
        return 'spatialite:query'

    def defineCharacteristics(self):
        self.name = 'Return result of an SQL query on any layer'
        self.group = 'Filtering'

        self.addParameter(ParameterString(self.QUERY, 'SQL Query', 'SELECT * FROM input'))
        self.addParameter(ParameterTable(self.INPUT_TABLE  , 'Input table'))
        self.addOutput(EpanetOutputTable(self.OUTPUT_TABLE, 'Output table'))
        pass

    def checkBeforeOpeningParametersDialog(self):
        return None

    def processAlgorithm(self, progress):
        folder = '/tmp' #ProcessingConfig.getSetting(ProcessingConfig.OUTPUT_FOLDER)
        query = self.getParameterValue(self.QUERY)

        outfilename = folder+'/test.out'

        uri = self.getParameterValue(self.INPUT_TABLE)
        layer = dataobjects.getObjectFromUri(uri)
        
        types = { 
            QVariant.LongLong : 'BIGINT',
            QVariant.DateTime : 'TEXT',
            QVariant.Date     : 'TEXT',
            QVariant.Time     : 'TEXT',
            QVariant.String   : 'TEXT',
            QVariant.Int      : 'INTEGER',
            QVariant.Double   : 'REAL'}
        # create a sqlite db (in memory if possible)
        # create a table with corresponding field names and types
        # insert data
        # execute query
        # create table from query results
        with dbapi2.connect(':memory:') as conn:
            progress.setText('converting to spatialite')
            curr = conn.cursor()
            cols = []
            quote = []
            for f in layer.pendingFields():
                if not f.type() in types: raise RuntimeError("Cannot convert type")
                name = '"'+f.name()+'"' if f.name().find(' ') else f.name()
                cols.append(name+' '+types[f.type()])
                quote.append( types[f.type()]  == 'TEXT' )

            curr.execute("DROP TABLE IF EXISTS input")
            curr.execute("CREATE TABLE input ("+','.join(cols)+")")
            i = 0
            total_size = layer.featureCount()
            for f in layer.getFeatures():
                i += 1
                vals = [ "'"+str(a)+"'" if quote[i] else str(a) for i,a in enumerate(f.attributes())]
                sql = "INSERT INTO input VALUES ("+','.join(vals)+")"
                curr.execute(sql)
                progress.setPercentage(int(100*i/total_size))
                

            progress.setText('executing query')
            curr.execute(query)
            print  curr.description
            progress.setText('saving output')
            fields = [ QgsField( d[0],  QVariant.String) for d in  curr.description ]
            node_table_writer = self.getOutputFromName(
                self.OUTPUT_TABLE).getTableWriter( fields )
            node_table_writer.addRecords( curr.fetchall() )


        # TODO ticket processing to have algo as starting point in pipeline

