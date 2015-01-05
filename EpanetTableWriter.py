# -*- coding: utf-8 -*-

"""
***************************************************************************
    TableWriter.py
    ---------------------
    Date                 : Febuary 2014
    Copyright            : (C) 2014 by Vincent Mora
    Email                : vincent dot mora at oslandia dot com
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
__date__ = 'Febuary 2014'
__copyright__ = '(C) 2014, Oslandia'

# This will get replaced with a git SHA1 when you do a git archive

__revision__ = '$Format:%H$'

import csv
import codecs
import cStringIO
from processing.tools.vector import TableWriter, UnicodeWriter


class EpanetTableWriter(TableWriter):

    def __init__(self, fileName, encoding, fields):
        """
        @param fields   a list of QgsField
        """
        TableWriter.__init__(self, fileName, encoding, [f.name() for f in fields] )

        if len(fields) != 0:
            with open(self.fileName[:-4]+'.csvt', 'wb') as csvtFile:
                writer = UnicodeWriter(csvtFile, encoding=self.encoding)
                writer.writerow([f.typeName() for f in fields])

