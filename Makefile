package: epanet.png metadata.txt timeplot.svg EpanetAlgorithm.py EpanetAlgorithmProvider.py EpanetOutputTable.py EpanetTableWriter.py gui.py __init__.py
	rm -rf qgis_epanet
	mkdir qgis_epanet
	cp $^ qgis_epanet/
	rm -f qgis_epanet.zip
	zip  -r qgis_epanet.zip qgis_epanet
	rm -r qgis_epanet
