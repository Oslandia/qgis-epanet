# -*- coding: utf-8 -*-

"""
***************************************************************************
    EpanetAlgorithmProvider.py
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
from EpanetAlgorithm import EpanetAlgorithm

class EpanetAlgorithmProvider(AlgorithmProvider):

    def __init__(self):
        AlgorithmProvider.__init__(self)
        self.activate = True

    def getDescription(self):
        return 'Epanet (Drinking water flow simulation)'

    def getName(self):
        return 'epanet'

    def getIcon(self):
        return QIcon(os.path.dirname(__file__) + '/epanet.png')

    def initializeSettings(self):
        AlgorithmProvider.initializeSettings(self)
        ProcessingConfig.addSetting(Setting(self.getDescription(),
                                    'Epanet_CLI',
                                    'Epanet command line tool',
                                     ''))

    def unload(self):
        AlgorithmProvider.unload(self)
        ProcessingConfig.removeSetting('Epanet_CLI')

    def _loadAlgorithms(self):
        print "loading algo"
        try:
            self.algs.append(EpanetAlgorithm())
        except Exception, e:
            print "error"
            raise e
            ProcessingLog.addToLog(ProcessingLog.LOG_ERROR, 
                'Could not create Epanet algorithm')

