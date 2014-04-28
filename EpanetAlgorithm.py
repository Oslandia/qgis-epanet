# -*- coding: utf-8 -*-

"""
***************************************************************************
    EpanetAlgorithm.py
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
from operator import itemgetter
from numpy import mean

from qgis.core import *
from PyQt4.QtCore import *
from PyQt4.QtGui import *

from processing.core.GeoAlgorithm import GeoAlgorithm
from processing.core.GeoAlgorithmExecutionException import \
        GeoAlgorithmExecutionException
from processing.core.ProcessingLog import ProcessingLog
from processing.parameters.ParameterVector import ParameterVector
from processing.parameters.ParameterTable import ParameterTable
from processing.parameters.ParameterString import ParameterString
from processing.parameters.ParameterNumber import ParameterNumber
from processing.parameters.ParameterFile import ParameterFile
from processing.parameters.Parameter import Parameter
from processing.outputs.OutputVector import OutputVector
from EpanetOutputTable import EpanetOutputTable
from processing.core.ProcessingConfig import ProcessingConfig
from processing.tools import dataobjects

class ParameterTimeWithUnits(Parameter):
    def  __init__(self, name='', description='', default=''):
        Parameter.__init__(self, name, description)
        self.default = default

    def setValue(self, obj):
        """Sets the value of the parameter.

        Returns true if the value passed is correct for the type
        of parameter.
        """
        if obj is None:
            self.value = self.default
            return True
        [val,unit] = str(obj).split(' ')
        try:
            float(val)
        except:
            return False

        self.value = str(obj)
        return True

class EpanetAlgorithm(GeoAlgorithm):

    TITLE      = 'TITLE'
    
    # layers
    JUNCTIONS  = 'JUNCTIONS'
    RESERVOIRS = 'RESERVOIRS'
    TANKS      = 'TANKS'
    PIPES      = 'PIPES'
    PUMPS      = 'PUMPS'
    VALVES     = 'VALVES'
    EMITTERS   = 'EMITTERS'
    SOURCES    = 'SOURCES'

    # tables
    DEMANDS     = 'DEMANDS'
    STATUS      = 'STATUS'
    PATTERNS    = 'PATTERNS'
    CURVES      = 'CURVES'
    CONTROLS    = 'CONTROLS'
    QUALITY     = 'QUALITY'
    MIXING      = 'MIXING'
    RULES       = 'RULES'

    # key values
    ENERGY      = 'ENERGY'
    REACTIONS   = 'REACTIONS'
    TIMES       = 'TIMES'
    REPORT      = 'REPORT'
    OPTIONS     = 'OPTIONS'

    #NODE_OUTPUT = 'NODE_OUTPUT'
    #LINK_OUTPUT = 'LINK_OUTPUT'
    NODE_TABLE_OUTPUT = 'NODE_TABLE_OUTPUT'
    TIME_AGREGATE_NODE_TABLE_OUTPUT = 'TIME_AGREGATE_NODE_TABLE_OUTPUT'
    LINK_TABLE_OUTPUT = 'LINK_TABLE_OUTPUT'
    TIME_AGREGATE_LINK_TABLE_OUTPUT = 'TIME_AGREGATE_LINK_TABLE_OUTPUT'
    
    # everything else
    ADDITIONAL_FILE = 'ADDITIONAL_FILE'

    def __init__(self):
        GeoAlgorithm.__init__(self)

    def getIcon(self):
        return QIcon(os.path.dirname(__file__) + '/epanet.png')

    def helpFile(self):
       return None 

    def commandLineName(self):
        return 'epanet:simulation'

    def defineCharacteristics(self):
        self.name = 'Simulate flow in drinking water network'
        self.group = 'Simulation'

        self.addParameter(ParameterString(self.TITLE, 'Title', 'Epanet Simulation'))
        self.addParameter(ParameterVector(self.JUNCTIONS, 'Junctions layer',
                          [ParameterVector.VECTOR_TYPE_POINT]))
        self.addParameter(ParameterVector(self.PIPES, 'Pipes layer',
                          [ParameterVector.VECTOR_TYPE_LINE]))
        self.addParameter(ParameterVector(self.RESERVOIRS, 'Reservoir layer',
                          [ParameterVector.VECTOR_TYPE_POINT], True))
        self.addParameter(ParameterVector(self.TANKS, 'Tanks layer',
                          [ParameterVector.VECTOR_TYPE_POINT], True))
        self.addParameter(ParameterVector(self.PUMPS, 'Pumps layer',
                          [ParameterVector.VECTOR_TYPE_POINT], True))
        self.addParameter(ParameterVector(self.VALVES, 'Valves layer',
                          [ParameterVector.VECTOR_TYPE_POINT], True))
        self.addParameter(ParameterVector(self.EMITTERS, 'Emiters layer',
                          [ParameterVector.VECTOR_TYPE_POINT], True))
        self.addParameter(ParameterTable(self.DEMANDS  , 'Demands   table', True))
        self.addParameter(ParameterTable(self.STATUS   , 'Status    table', True))  
        self.addParameter(ParameterTable(self.PATTERNS , 'Patterns  table', True)) 
        self.addParameter(ParameterTable(self.CURVES   , 'Curves    table', True))
        self.addParameter(ParameterTable(self.CONTROLS , 'Controls  table', True))
        self.addParameter(ParameterTable(self.QUALITY  , 'Quality   table', True))
        self.addParameter(ParameterTable(self.MIXING   , 'Mixing    table', True))

        #self.addParameter(ParameterFile(self.ADDITIONAL_FILE, 'Epanet config file'))
        self.addParameter(ParameterTable(self.TIMES, 'Simulation Time'))
        self.addParameter(ParameterTable(self.RULES, 'Control rules', True))
        self.addParameter(ParameterTable(self.ENERGY, 'Energy ', True))
        self.addParameter(ParameterTable(self.REACTIONS, 'Reaction', True))
        self.addParameter(ParameterTable(self.REPORT, 'Report options', True))
        self.addParameter(ParameterTable(self.OPTIONS, 'Options', True))

        #self.addOutput(OutputVector(self.NODE_OUTPUT, 'Node output layer'))
        #self.addOutput(OutputVector(self.LINK_OUTPUT, 'Link output layer'))
        self.addOutput(EpanetOutputTable(self.NODE_TABLE_OUTPUT, 'Node output table'))
        self.addOutput(EpanetOutputTable(self.LINK_TABLE_OUTPUT, 'Link output table'))
        self.addOutput(EpanetOutputTable(self.TIME_AGREGATE_NODE_TABLE_OUTPUT, 'Node output table (time agregates)'))
        self.addOutput(EpanetOutputTable(self.TIME_AGREGATE_LINK_TABLE_OUTPUT, 'Link output table (time agregates)'))
        pass

    def checkBeforeOpeningParametersDialog(self):
        if not ProcessingConfig.getSetting('Epanet_CLI'):
            return 'Epanet command line tool is not configured.\n\
                Please configure it before running Epanet algorithms.'
        layers = dataobjects.getVectorLayers()
        for p in self.parameters:
            for layer in layers:
                if layer.name().lower() == p.name.lower() :
                    self.setParameterValue(p.name, layer )


        return None
        
    def epanetTable(self, table_name):
        uri = self.getParameterValue(table_name)
        if not uri: return u''
        layer = dataobjects.getObjectFromUri(uri)
        pkidx = layer.dataProvider().pkAttributeIndexes()
        fields = ""
        for i,field in enumerate(layer.dataProvider().fields()): 
            if not i in pkidx: fields+=field.name()+"\t"

        tbl =u'['+table_name+']\n'\
            ';'+fields+'\n'
        for feature in layer.getFeatures():
            for i,v in enumerate(feature):
                if not i in pkidx: 
                    if str(v) != 'NULL': tbl += str(v)+'\t'
                    else: tbl += '\t'
            tbl += '\n'
        tbl += '\n'
        return tbl;

    def epanetKeyVal(self, table_name, simul_title):
        uri = self.getParameterValue(table_name)
        if not uri: return u''
        layer = dataobjects.getObjectFromUri(uri)
        fields = []
        for i,field in enumerate(layer.dataProvider().fields()): 
            fields.append(field.name())

        tbl =u'['+table_name+']\n'
        found = False
        for feature in layer.getFeatures():
            if str(feature[0]) == simul_title:
                for i,v in enumerate(feature):
                    if i and str(v) != 'NULL': tbl += fields[i].upper()+'\t'+str(v)+'\n'
                    elif i : tbl += '\t'
                found = True
                tbl += '\n'
        tbl += '\n'
        if not found:
            raise GeoAlgorithmExecutionException(
                    "No simulation named '"+simul_title+"' in "+table_name)
        return tbl;

    def processAlgorithm(self, progress):
        epanet_cli = os.path.abspath(ProcessingConfig.getSetting('Epanet_CLI'))
        if not epanet_cli:
            raise GeoAlgorithmExecutionException(
                    'Epanet command line toom is not configured.\n\
                     Please configure it before running Epanet algorithms.')
        folder = ProcessingConfig.getSetting(ProcessingConfig.OUTPUT_FOLDER)
        filename = os.path.join(folder, 'epanet.inp')
        f = codecs.open(filename,'w',encoding='utf-8')
        f.write('[TITLE]\n')
        f.write(self.getParameterValue(self.TITLE)+'\n\n')

        f.write(self.epanetTable(self.JUNCTIONS  ))
        f.write(self.epanetTable(self.RESERVOIRS ))
        f.write(self.epanetTable(self.TANKS      ))
        f.write(self.epanetTable(self.PIPES      ))
        f.write(self.epanetTable(self.PUMPS      ))
        f.write(self.epanetTable(self.VALVES     ))
        f.write(self.epanetTable(self.EMITTERS   ))
        f.write(self.epanetTable(self.SOURCES    ))
        f.write(self.epanetTable(self.DEMANDS    ))
        f.write(self.epanetTable(self.STATUS     ))
        f.write(self.epanetTable(self.PATTERNS   ))
        f.write(self.epanetTable(self.CURVES     ))
        f.write(self.epanetTable(self.CONTROLS   ))
        f.write(self.epanetTable(self.QUALITY    ))
        f.write(self.epanetTable(self.MIXING     ))
        f.write(self.epanetTable(self.RULES      ))

        f.write(self.epanetKeyVal(self.TIMES, self.getParameterValue(self.TITLE) ))
        f.write(self.epanetKeyVal(self.OPTIONS, self.getParameterValue(self.TITLE) ))
        f.write(self.epanetKeyVal(self.REPORT, self.getParameterValue(self.TITLE) ))
        f.write(self.epanetKeyVal(self.REACTIONS, self.getParameterValue(self.TITLE) ))
        f.write(self.epanetKeyVal(self.ENERGY, self.getParameterValue(self.TITLE) ))

        f.write('\n[END]\n')

        f.close()

        outfilename = os.path.join(folder,'epanet.out')
        progress.setText('running simulation')
        log=""
        error = False
        proc = subprocess.Popen(
            [epanet_cli, filename, outfilename],
            #shell=True,
            stdout=subprocess.PIPE,
            stdin=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            universal_newlines=False,
            ).stdout
        for line in iter(proc.readline, ''):
            log+=line
            if line.find('There are errors') != -1:
                error = True
        if error:
            o = open(outfilename,'r')
            ProcessingLog.addToLog(ProcessingLog.LOG_ERROR, o.read())
            o.close()
            raise GeoAlgorithmExecutionException(
                    "There are errors, please check processing logs or open file "+
                    outfilename+" for details")
        ProcessingLog.addToLog(ProcessingLog.LOG_INFO, log)
        progress.setText('postprocessing output')

        # here we create output layers
        # it's a python implementation of a join
        # on the identifyer field between the results an the JUNCTIONS or PIPES
        # geometries
        total_size = os.path.getsize(outfilename)
        total_read = 0
        o = codecs.open(outfilename,'r',encoding='utf-8')
        # get nodes results
        in_link = False 
        in_node = False 
        time = ''
        date = datetime.datetime.now().strftime("%Y-%m-%d")
        line = o.readline()
        link_table = []
        node_table = []
        while line:
            line = line.rstrip()
            if (in_node or in_link) and not line: 
                in_node = False
                in_link = False
            if re.search('^  Node Results', line): 
                in_node = True
                time = re.search('at (\S+) ', line).group(1)
                for i in range(5): line = o.readline()
                line = line.rstrip()
            if re.search('^  Link Results', line): 
                in_link = True
                time = re.search('at (\S+) ', line).group(1)
                for i in range(5): line = o.readline()
                line = line.rstrip()
            if in_node:
                #feature = QgsFeature(node_fields)
                tbl = re.findall(r"\S+(?:\s\S+)*", line)
                if len(tbl) >= 4:
                    node_table.append(tbl[0:4]+[date+' '+time])
            if in_link:
                #feature = QgsFeature(link_fields)
                tbl = re.findall(r"\S+(?:\s\S+)*", line)
                if len(tbl) >= 4:
                    link_table.append(tbl[0:4]+[date+' '+time])
            line = o.readline()
            total_read += len(line)
            progress.setPercentage(int(100*total_read/total_size))

        o.close()

        progress.setText('writing output tables')

        node_fields = [
            QgsField('Node', QVariant.String, 'String'),
            QgsField('Demand', QVariant.Double, 'Real'),
            QgsField('Head', QVariant.Double, 'Real'),
            QgsField('Pressure', QVariant.Double, 'Real'),
            QgsField('Time', QVariant.String, 'String')]
        node_table_writer = self.getOutputFromName(
                self.NODE_TABLE_OUTPUT).getTableWriter( node_fields )
        node_table_writer.addRecords( node_table )

        link_fields = [
            QgsField('Link', QVariant.String, 'String'),
            QgsField('Flow', QVariant.Double, 'Real'),
            QgsField('Velocity', QVariant.Double, 'Real'),
            QgsField('Headloss', QVariant.Double, 'Real'),
            QgsField('Time', QVariant.String, 'String')]
        link_table_writer = self.getOutputFromName(
                self.LINK_TABLE_OUTPUT).getTableWriter( link_fields )
        #        self.LINK_TABLE_OUTPUT).getTableWriter(['Link','Flow','Velocity','Headloss','Time'])
        link_table_writer.addRecords( link_table )

        progress.setText('computing times agregates')
        # low speed (stagnation)
        # high and low pressure (risk of breakage, unhappy consumer)
        # lack of level variation in reservoirs (stagnation)
        # negative pressure (empty reservoir) highlighted in red in the software
        # reservoir overflow highlighted in blue
        # abnormal pressure (typical of error in the altitude of a node in the model)
        # flow direction
        # pressure variations


        # computes time aggregates for nodes
        agr_node_fields = [
            QgsField('Node', QVariant.String, 'String'),
            QgsField('MaxPressure', QVariant.Double, 'Real'),
            QgsField('MinPressure', QVariant.Double, 'Real'),
            QgsField('MaxHead', QVariant.Double, 'Real'),
            QgsField('MinHead', QVariant.Double, 'Real')
            ]
        time_agr_node_table_writer = self.getOutputFromName(
                self.TIME_AGREGATE_NODE_TABLE_OUTPUT).getTableWriter( agr_node_fields )
        sorted_res = sorted(node_table,key=itemgetter(0))
        key = ""
        node_res = []
        agr_node_table = []
        progress.setText('computing time agregates for nodes')
        total_size = len(sorted_res)
        total_read = 0
        for r in sorted_res:
            if key != r[0] and node_res: # new stuff, we create and aggregate
                agr_node_table.append( [key, 
                    max([row[3] for row in node_res]),
                    min([row[3] for row in node_res]),
                    max([row[2] for row in node_res]),
                    min([row[2] for row in node_res]),
                    ] )
                key = r[0]
                node_res = []
            elif key != r[0]:
                key = r[0]
            else: 
                node_res.append(r)
            total_read += 1
            progress.setPercentage(int(100*total_read/total_size))

        if key and node_res: # last aggregate not agregated in loop
            agr_node_table.append( [key, 
                max([row[3] for row in node_res]),
                min([row[3] for row in node_res]),
                max([row[2] for row in node_res]),
                min([row[2] for row in node_res]),
                ] )

        time_agr_node_table_writer.addRecords( agr_node_table )

        # computes time aggregates for links
        agr_link_fields = [
            QgsField('Link', QVariant.String, 'String'),
            QgsField('AvgVelocity', QVariant.Double, 'Real')
            ]
        time_agr_link_table_writer = self.getOutputFromName(
                self.TIME_AGREGATE_LINK_TABLE_OUTPUT).getTableWriter( agr_link_fields )
        sorted_res = sorted(link_table,key=itemgetter(0))
        key = ""
        link_res = []
        agr_link_table = []
        progress.setText('computing time agregates for links')
        total_size = len(sorted_res)
        total_read = 0
        for r in sorted_res:
            if key != r[0] and link_res: # new stuff, we create and aggregate
                agr_link_table.append( [key, 
                    mean([float(row[3]) for row in link_res])
                    ] )
                key = r[0]
                link_res = []
            elif key != r[0]:
                key = r[0]
            else: 
                link_res.append(r)
            total_read += 1
            progress.setPercentage(int(100*total_read/total_size))

        if key and link_res: # last aggregate not agregated in loop
            agr_link_table.append( [key, 
                mean([float(row[3]) for row in link_res])
                ] )

        time_agr_link_table_writer.addRecords( agr_link_table )

