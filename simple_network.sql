-- for spatialite
-- A simple example of a reservoir emtying into a pipe


-- column order is important for the following tables
CREATE TABLE junctions (
    id_node TEXT, 
    altitude REAL, 
    base_demand REAL, 
    modulation_curve TEXT);
SELECT AddGeometryColumn('junctions', 'GEOMETRY', 2154, 'POINT', 'XY');
INSERT INTO junctions VALUES ('node0', 0, .1, '', ST_GeomFromText('POINT(100 0)', 2154));

CREATE TABLE tanks (
    id_node TEXT,
    altitude REAL,
    init_level REAL,
    min_level REAL, 
    max_level REAL,
    diameter REAL, 
    min_volume REAL, 
    volume_curve TEXT);
SELECT AddGeometryColumn('tanks', 'GEOMETRY', 2154, 'POINT', 'XY');
INSERT INTO tanks VALUES ('tank0', 10, 9, 0, 10, 5, 0, '', ST_GeomFromText('POINT(0 100)', 2154));

CREATE TABLE pipes (
    id_arc TEXT, 
    start_node TEXT,
    end_node TEXT,
    length REAL, 
    diameter REAL,
    rugosity REAL,
    minor_loss REAL,
    status TEXT);
SELECT AddGeometryColumn('pipes', 'GEOMETRY', 2154, 'LINESTRING', 'XY');
INSERT INTO pipes VALUES ('pipe0', 'tank0', 'node0', 141.42, .1, 150, 0., '', ST_GeomFromText('LINESTRING(100 0,0 100)', 2154));

-- column names is important for the following tables
CREATE TABLE times(
 "simulation title"     TEXT,
 duration TEXT,
 "hydraulic timestep" 	TEXT,
 "quality timestep"   	TEXT,
 "pattern timestep"   	TEXT,
 "pattern start"      	TEXT, 
 "report timestep"    	TEXT,
 "report start"       	TEXT,
 "start clocktime"    	TEXT,
 statistic          	TEXT);
INSERT INTO times VALUES(
'Epanet Simulation',
'48:00',
'0:05',
'0:05',
'0:05',
'0:00',
'0:05',
'0:00',
'12:00 AM',
'None');

CREATE TABLE report(
    "simulation title"   TEXT,
    "status" TEXT,
    "summary" TEXT,   	
    nodes TEXT,      
    links TEXT,        
    "demand" TEXT,
    "head" TEXT,
    "pressure" TEXT,
    "Quality." TEXT,
    "length" TEXT,
    "diameter" TEXT,
    "flow" TEXT,
    "velocity" TEXT,
    "headloss" TEXT,
    "position" TEXT,
    "setting" TEXT,
    "reaction" TEXT,
    "F-Factor" TEXT,
    "Demand	BELOW" REAL,
    "Head	BELOW" REAL,
    "Pressure	BELOW" REAL,
    "Quality	BELOW" REAL,
    "Length	BELOW" REAL,
    "Diameter	BELOW" REAL,
    "Flow	BELOW" REAL,
    "Velocity	BELOW" REAL,
    "Headloss	BELOW" REAL,
    "Position	BELOW" REAL,
    "Setting	BELOW" REAL,
    "Reaction	BELOW" REAL,
    "F-Factor	BELOW" REAL,
    "Demand	ABOVE" REAL,
    "Head	ABOVE" REAL,
    "Pressure	ABOVE" REAL,
    "Quality	ABOVE" REAL,
    "Length	ABOVE" REAL,
    "Diameter	ABOVE" REAL,
    "Flow	ABOVE" REAL,
    "Velocity	ABOVE" REAL,
    "Headloss	ABOVE" REAL,
    "Position	ABOVE" REAL,
    "Setting	ABOVE" REAL,
    "Reaction	ABOVE" REAL,
    "F-Factor	ABOVE" REAL,
    "Demand	PRECISION" INTEGER,
    "Head	PRECISION" INTEGER,
    "Pressure	PRECISION" INTEGER,
    "Quality	PRECISION" INTEGER,
    "Length	PRECISION" INTEGER,
    "Diameter	PRECISION" INTEGER,
    "Flow	PRECISION" INTEGER,
    "Velocity	PRECISION" INTEGER,
    "Headloss	PRECISION" INTEGER,
    "Position	PRECISION" INTEGER,
    "Setting	PRECISION" INTEGER,
    "Reaction	PRECISION" INTEGER,
    "F-Factor	PRECISION" INTEGER);
INSERT INTO report("simulation title",  "status", "summary", nodes, links) 
             VALUES ('Epanet Simulation', 'Full',   'No',      'ALL',   'ALL'); 

