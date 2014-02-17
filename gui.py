# -*- coding: UTF-8 -*-

from SpatialiteAlgorithmProvider import SpatialiteAlgorithmProvider
from EpanetAlgorithmProvider import EpanetAlgorithmProvider
from processing.core.Processing import Processing

from PyQt4.QtCore import *
from PyQt4.QtGui import *
import os

class Gui:

    def __init__(self, iface):
        self.iface = iface
        self.actions = []
        pass
    
    def initGui(self):

        self.actions.append( QAction(
            QIcon(os.path.dirname(__file__) + "/timeplot.svg"),
            u"timeplot", self.iface.mainWindow()) )
        self.actions[-1].setWhatsThis("timeplot")
        self.actions[-1].triggered.connect(self.timeplot)

        for a in self.actions:
            self.iface.addToolBarIcon(a)

        print "here"
        self.epanetAlgoProvider = EpanetAlgorithmProvider()
        print self.epanetAlgoProvider 
        Processing.addProvider(self.epanetAlgoProvider, True)
        self.spatialiteAlgorithmProvider = SpatialiteAlgorithmProvider()
        Processing.addProvider(self.spatialiteAlgorithmProvider, True)
    
    def unload(self):
        Processing.removeProvider(self.spatialiteAlgorithmProvider)
        Processing.removeProvider(self.epanetAlgoProvider)
        # Remove the plugin menu item and icon
        for a in self.actions:
            self.iface.removeToolBarIcon(a)

    def timeplot(self):
        pass
