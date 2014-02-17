# -*- coding: utf-8 -*-

"""
***************************************************************************
    SpatialiteAlgorithmProvider.py
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
from PyQt4.QtGui import *
from processing.core.AlgorithmProvider import AlgorithmProvider
from processing.core.ProcessingConfig import ProcessingConfig, Setting
from processing.core.ProcessingLog import ProcessingLog
from SpatialiteAlgorithm import SpatialiteAlgorithm

class SpatialiteAlgorithmProvider(AlgorithmProvider):

    def __init__(self):
        AlgorithmProvider.__init__(self)
        self.activate = True

    def getDescription(self):
        return 'Spatialite (Drinking water flow simulation/'

    def getName(self):
        return 'spatialite'

    def getIcon(self):
        return QIcon(os.path.dirname(__file__) + '/spatialite.svg')

    def initializeSettings(self):
        AlgorithmProvider.initializeSettings(self)

    def unload(self):
        AlgorithmProvider.unload(self)

    def _loadAlgorithms(self):
        print "loading algo"
        try:
            self.algs.append(SpatialiteAlgorithm())
        except Exception, e:
            print "error"
            raise e
            ProcessingLog.addToLog(ProcessingLog.LOG_ERROR, 
                'Could not create Spatialite algorithm')

