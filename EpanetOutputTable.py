# -*- coding: utf-8 -*-

"""
***************************************************************************
    EpanetOutputTable.py
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

from PyQt4.QtCore import *

from EpanetTableWriter import EpanetTableWriter
from processing.core.outputs import OutputTable
from processing.tools.system import *


class EpanetOutputTable(OutputTable):

    def getTableWriter(self, fields):
        """Returns a suitable writer to which records can be added as a
        result of the algorithm. Use this to transparently handle
        output values instead of creating your own method.

        @param fields   a list of QgsField

        @return writer  instance of the table writer class
        """

        if self.encoding is None:
            settings = QSettings()
            self.encoding = settings.value('/Processing/encoding', 'System')

        return EpanetTableWriter(self.value, self.encoding, fields)
