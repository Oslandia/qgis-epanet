# -*- coding: UTF-8 -*-

from EpanetAlgorithmProvider import EpanetAlgorithmProvider
from processing.core.Processing import Processing

class Dummy:

    def __init__(self):
        pass
    
    def initGui(self):
        print "here"
        self.provider = EpanetAlgorithmProvider()
        print self.provider 
        Processing.addProvider(self.provider, True)
    
    def unload(self):
        Processing.removeProvider(self.provider)

def classFactory(iface):
    return Dummy()

