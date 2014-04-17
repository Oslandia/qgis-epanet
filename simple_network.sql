-- for spatialite
CREATE TABLE junctions (
    id_node TEXT, 
    altitude REAL, 
    base_demand REAL, 
    modulation_curve TEXT);
SELECT AddGeometryColumn('junctions', 'GEOMETRY', 2154, 'POINT', 'XY');
INSERT INTO junctions VALUES ('node0', 0, 1, 'DOM', ST_GeomFromText('POINT(1 0)', 2154));

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
INSERT INTO tanks VALUES ('tank0', 10, 5, 0, 10, 5, 0, '', ST_GeomFromText('POINT(0 1)', 2154));

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
INSERT INTO pipes VALUES ('pipe0', 'tank0', 'node0', 1.4142, 1., 0.1, 0, '', ST_GeomFromText('LINESTRING(1 0,0 1)', 2154));

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

CREATE TABLE patterns (
    id_modulation TEXT,
    multiplier REAL);
INSERT INTO patterns VALUES ('DOM', 0.519634309 );
INSERT INTO patterns VALUES ('DOM', 0.433028591 );
INSERT INTO patterns VALUES ('DOM', 0.259817154 );
INSERT INTO patterns VALUES ('DOM', 0.173211436 );
INSERT INTO patterns VALUES ('DOM', 0.262206278 );
INSERT INTO patterns VALUES ('DOM', 0.348811996 );
INSERT INTO patterns VALUES ('DOM', 0.262206278 );
INSERT INTO patterns VALUES ('DOM', 0.262206278 );
INSERT INTO patterns VALUES ('DOM', 0.175600559 );
INSERT INTO patterns VALUES ('DOM', 0.172489722 );
INSERT INTO patterns VALUES ('DOM', 0.25909544  );
INSERT INTO patterns VALUES ('DOM', 0.389004017 );
INSERT INTO patterns VALUES ('DOM', 0.778729749 );
INSERT INTO patterns VALUES ('DOM', 0.860587346 );
INSERT INTO patterns VALUES ('DOM', 0.947193064 );
INSERT INTO patterns VALUES ('DOM', 1.077101641 );
INSERT INTO patterns VALUES ('DOM', 0.710166888 );
INSERT INTO patterns VALUES ('DOM', 1.257587198 );
INSERT INTO patterns VALUES ('DOM', 2.00925266  );
INSERT INTO patterns VALUES ('DOM', 1.796674988 );
INSERT INTO patterns VALUES ('DOM', 1.623463552 );
INSERT INTO patterns VALUES ('DOM', 1.64478693  );
INSERT INTO patterns VALUES ('DOM', 1.471575493 );
INSERT INTO patterns VALUES ('DOM', 2.164421238 );
INSERT INTO patterns VALUES ('DOM', 1.514878353 );
INSERT INTO patterns VALUES ('DOM', 1.424664063 );
INSERT INTO patterns VALUES ('DOM', 1.381361204 );
INSERT INTO patterns VALUES ('DOM', 1.294755486 );
INSERT INTO patterns VALUES ('DOM', 0.926681184 );
INSERT INTO patterns VALUES ('DOM', 0.710166888 );
INSERT INTO patterns VALUES ('DOM', 1.441504064 );
INSERT INTO patterns VALUES ('DOM', 1.298364057 );
INSERT INTO patterns VALUES ('DOM', 1.255061198 );
INSERT INTO patterns VALUES ('DOM', 1.298364057 );
INSERT INTO patterns VALUES ('DOM', 1.255061198 );
INSERT INTO patterns VALUES ('DOM', 1.126540533 );
INSERT INTO patterns VALUES ('DOM', 1.169843392 );
INSERT INTO patterns VALUES ('DOM', 1.126540533 );
INSERT INTO patterns VALUES ('DOM', 1.559569124 );
INSERT INTO patterns VALUES ('DOM', 1.472963406 );
INSERT INTO patterns VALUES ('DOM', 1.460749779 );
INSERT INTO patterns VALUES ('DOM', 1.088345191 );
INSERT INTO patterns VALUES ('DOM', 0.568710882 );
INSERT INTO patterns VALUES ('DOM', 1.250313078 );
INSERT INTO patterns VALUES ('DOM', 1.207010219 );
INSERT INTO patterns VALUES ('DOM', 1.120404501 );
INSERT INTO patterns VALUES ('DOM', 0.993603784 );
INSERT INTO patterns VALUES ('DOM', 0.603878053 );

/*
CREATE TABLE epanet.pumps ("id arc" varchar, "noeudasp" varchar, "NoeudDéch" varchar, "Paramètres" varchar);
INSERT INTO epanet.pumps VALUES ('PMP_DELL1', '3', 'N18a5', 'HEAD PMP_DELL1');
INSERT INTO epanet.pumps VALUES ('PMP_ROCHER', 'N1848', 'N18a3', 'HEAD PMP_ROCHER');
INSERT INTO epanet.pumps VALUES ('PMP_ST_MICHEL', 'N18ab', 'N18b2', 'HEAD PMP_ST_MICHEL');
INSERT INTO epanet.pumps VALUES ('PMP_DELL_2', '3', 'N18a9', 'HEAD PMP_DELL_2');
--ALTER TABLE epanet.pumps ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.pumps ADD COLUMN geom geometry(POINT,27582);
CREATE TABLE epanet.valves ("id arc" varchar, "noeudamont" varchar, "nodeaval" varchar, "Diamètre" float, "type" varchar, "consigne" float, "pertsing" float);
INSERT INTO epanet.valves VALUES ('Poire600', 'N1806', '1', 150         , 'TCV', 0           , 0           );
INSERT INTO epanet.valves VALUES ('1', 'N1865', 'N1908', 200         , 'TCV', 0           , 0           );
INSERT INTO epanet.valves VALUES ('6', 'N182e', '4', 200         , 'TCV', 5000        , 0           );
INSERT INTO epanet.valves VALUES ('7', 'N17ea', 'N17eb', 150         , 'TCV', 1650        , 0           );
INSERT INTO epanet.valves VALUES ('8', '5', 'N183f', 200         , 'TCV', 0           , 0           );
INSERT INTO epanet.valves VALUES ('15', 'N17d4', '6', 150         , 'TCV', 1000000000  , 0           );
--ALTER TABLE epanet.valves ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.valves ADD COLUMN geom geometry(POINT,27582);
CREATE TABLE epanet.demands ("id noeud" varchar, "demande base" float, "courbe modulation" varchar, "Catégorie" varchar);
INSERT INTO epanet.demands VALUES ('N18b2', 0.0813466016266977 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18b2', 0.069596    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18b1', 0.079274869621886 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18b1', 0.197173    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18b0', 0.0790759211085484 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18b0', 0.196588    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18af', 0.177576552650623 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18af', 0.32456     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18ae', 0.00633523198896266, 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18ae', 0.014155    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18ad', 0.0684560716954715 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18ad', 0.152952    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18ac', 0           , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18ac', 0           , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18ab', 0           , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18ab', 0           , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18aa', 0.0202527363689259 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18aa', 0.010516    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a9', 0.0202527363689259 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a9', 0.010516    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a8', 0.0175063577295001 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a8', 0.00909     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a7', 0.088530976991023 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a7', 0.045967    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a6', 0.139617398594651 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a6', 0.072493    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a5', 0.0335800638741278 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a5', 0.017436    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a4', 0.0491480629038471 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a4', 0.427671    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a3', 0.0111133306416908 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a3', 0.096701    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a2', 0.00886710189613054 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a2', 0.077157    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a1', 0.00573727500474127 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a1', 0.049926    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a0', 0.0526391091630281 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N18a0', 0.458053    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1899', 0.016769470219205 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1899', 0.008746    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1898', 0.159318858636116 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1898', 0.083095    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1897', 0.931700339732566 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1897', 0.123434    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1896', 0.0590421392487148 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1896', 0.035707    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1895', 0.297204627153784 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1895', 0.086281    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1894', 0.0106387439646229 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1894', 0.002523    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1893', 1.34969116625486 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1893', 0.436902    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1892', 0.0044957918237463 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1892', 0.001066    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1891', 0.0025407614608366 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1891', 0.022139    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1890', 0.0125148617887227 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1890', 0.109024    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N188f', 0.202881914391799 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N188f', 0.263954    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N188e', 0.443702976843815 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N188e', 0.22687     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N188d', 0.200500089452791 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N188d', 0.180713    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('PIOrne', 0.046619527329305 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('PIOrne', 0.030934    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N188b', 0           , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N188b', 0           , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N188a', 0.0827192352243062 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N188a', 0.074556    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1889', 0           , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1889', 0           , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1888', 0           , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1888', 0           , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1887', 0.123997161687128 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1887', 0.066856    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1886', 0.133472295423079, 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1886', 0.104201    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1884', 0.225869914958065 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1884', 0.193242    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1883', 0.136468677151716 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1883', 0.095598    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1882', 0.164448173658759 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1882', 0.116053    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1881', 0.467004404676904 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1881', 0.175339    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1880', 0.0551298556344782 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1880', 0.123175    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N187f', 0.00403120814455571 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N187f', 0.010319    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N187e', 0.00854256018722228 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N187e', 0.021868    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N187d', 0.0181265435978933 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N187d', 0.046401    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N187c', 0.00108032377074942 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N187c', 0.002766    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N187b', 0.0140219801355707 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N187b', 0.035896    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N187a', 0.0123403650479741 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N187a', 0.031588    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1879', 0.0062196417912693 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1879', 0.01592     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1878', 0.00211618977315524 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1878', 0.005416    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1877', 0.0115556854367096 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1877', 0.029578    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1876', 0.00230068951178117 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1876', 0.002122    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1875', 0.00208506933531473 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1875', 0.001922    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1874', 0.157468304028814 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1874', 0.119422    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1873', 0.104578008474645 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1873', 0.076675    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1872', 0.00198726224495881 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1872', 0.0012      , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1871', 0.0402654007887963 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1871', 0.024316    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1870', 0.0121391936462193 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1870', 0.011192    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N186f', 0.0334811453395633 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N186f', 0.030869    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N186e', 0.0440320852117076 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N186e', 0.040597    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N186d', 0.113140574657621 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N186d', 0.072546    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N186c', 0.0022862407370695 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N186c', 0.002109    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N186b', 0.0222722304959338 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N186b', 0.020535    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N186a', 0.0460371305640039 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N186a', 0.017665    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1869', 0.196952359538972 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1869', 0.090449    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1868', 0.315922459070647 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1868', 0.120304    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1867', 0.0988085015878542 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1867', 0.068336    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1866', 0.0661976170636168 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1866', 0.151505    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1865', 0.0177731043395617 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1865', 0.046372    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1863', 0.0365209452500568 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1863', 0.022055    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1862', 0.0666599778543902 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1862', 0.040256    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1861', 0.0225878806511733 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1861', 0.013438    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1860', 0.0145343559157306 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1860', 0.004797    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N185f', 0.00590954885707271 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N185f', 0.00195     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N185e', 0.0318995602307399 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N185e', 0.010529    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N185d', 0.16347788286466 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N185d', 0.068444    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('Villerupt', 0.0121747598608942 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('Villerupt', 0.004555    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N185b', 0.195523042286725 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N185b', 0.087815    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N185a', 0.00446911716274015 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N185a', 0.006306    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1859', 0.11162011898027 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1859', 0.157448    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1858', 0.116089236143011 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1858', 0.163754    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1857', 0.0153690505163817 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1857', 0.040098    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1856', 0.0735965011602 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1856', 0.101139    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1855', 0.00688650831642326 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1855', 0.009715    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1854', 0.1         , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1854', 0           , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1853', 0           , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1853', 0.1         , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1852', 0.13        , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1852', 0.03        , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1851', 0.11        , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1851', 0.9         , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1850', 0.05        , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1850', 0.11        , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N184f', 0           , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N184f', 0           , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N184e', 0           , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N184e', 0           , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N184d', 0           , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N184d', 0           , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N184c', 0           , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N184c', 0           , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N184b', 0.0558667431447733 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N184b', 0.030121    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N184a', 0.151852176442809 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N184a', 0.081874    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1848', 0.00171829274648005 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1848', 0.001711    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1847', 0.0279328158502824 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1847', 0.011921    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1846', 0.0266935555577046 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1846', 0.011392    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1845', 0.0101908319485612 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1845', 0.039743    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1844', 0.00559501014604176 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1844', 0.003283    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1843', 0.110313060590969 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1843', 0.064731    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1842', 0.0608226728708758 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1842', 0.03569     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1841', 0.258338534623603 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1841', 0.124107    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1840', 0.187962998779896 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1840', 0.078183    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N183f', 0.099362000803732 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N183f', 0.055854    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N183e', 0.000102252867190274 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N183e', 0.000228    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N183d', 0.136188593211151 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N183d', 0.047991    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N183c', 0.227846062760938 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N183c', 0.05106     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N183b', 0.156745865293231 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N183b', 0.093922    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1839', 0.1773664896952 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1839', 0.117429    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1838', 0.20608954237779 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1838', 0.098358    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1837', 0.316031380603089 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1837', 0.130426    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1836', 0.0712369051053636 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1836', 0.03264     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1835', 0.114714379656985 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1835', 0.058152    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1834', 0.321087340307965 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1834', 0.132257    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1833', 0.0527713710238503 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1833', 0.040184    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1832', 0.00548164283676558 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1832', 0.012247    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1831', 0.0245551369003775 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1831', 0.005617    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1830', 0.0772653784927554 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1830', 0.051173    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N182f', 0.153753857483706 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N182f', 0.045645    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N182e', 0.367694641750975, 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N182e', 1.843748    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N182d', 0.303565422359544 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N182d', 0.104905    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N182c', 0.0457992815033656 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N182c', 0.015189    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N182b', 0.337885708076593 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N182b', 0.144201    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N182a', 0.197724813263942 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N182a', 0.057043    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1829', 0.180726385537767 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1829', 0.128794    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1828', 0.0345214571188035 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1828', 0.07713     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1827', 0.074263367685354 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1827', 0.176058    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1826', 0.454536223544942 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1826', 0.230904    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1825', 0.270369918181589 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1825', 0.063278    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1824', 0.0467529006343358 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1824', 0.038761    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1823', 0.283688354133122 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1823', 0.074585    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1822', 0.368106987552362 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1822', 0.121724    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1821', 0.082017913928686 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1821', 0.115691    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('PIMacDO', 0.149289186097801 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('PIMacDO', 0.122765    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N181e', 0.0685049752406495 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N181e', 0.036969    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N181d', 0.410905369692535 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N181d', 0.137401    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N181c', 0           , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N181c', 0           , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N181b', 0.133219925730007, 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N181b', 1.74418     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N181a', 0.0254965301450532 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N181a', 0.008455    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1819', 0.0971791243780614 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1819', 0.032228    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1818', 0.22285456682016, 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1818', 1.773906    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1817', 0.179626055771263 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1817', 0.121377    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1816', 0.214166407441613 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1816', 0.159037    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1814', 0.150066085599605 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1814', 0.101403    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1813', 0.476556156205525 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1813', 0.193092    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1812', 0.0492625416573319 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1812', 0.033534    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1811', 0.0636757501543262 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1811', 0.070428    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1810', 0.398358276021763 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1810', 0.125954    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N180f', 0.076989710108488, 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N180f', 0.066776    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N180e', 0.478226656851036 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N180e', 0.156645    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N180d', 0.627810375664113 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N180d', 0.191132    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N180c', 0           , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N180c', 0           , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N180b', 0.27818781674481 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N180b', 0.076318    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N180a', 0.291531815913141 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N180a', 0.111862    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1809', 0.0453091346073775 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1809', 0.063911    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1808', 0.0740555276183477 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1808', 0.10446     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1807', 0.00710212849288971 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1807', 0.005916    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1806', 0.118861177999234 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1806', 0.099015    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1805', 0.139557380607387 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1805', 0.109468    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1804', 0.0220699476499704 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1804', 0.015058    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1803', 0.00835583756017916 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1803', 0.001911    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1802', 0.00406455147081341 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1802', 0.000929    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1800', 0.0031598358850212 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1800', 0.000723    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17fe', 0.279861651722947 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17fe', 0.104705    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17fd', 0.0240038605729169 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17fd', 0.008981    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17fc', 0.042095949400344 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17fc', 0.015133    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17fb', 0.329883309774746 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17fb', 0.078214    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17fa', 0.711028649338076 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17fa', 0.16857     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f9', 0.148771253096598, 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f9', 1.749336    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f8', 0.331045880416931, 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f8', 1.809784    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f7', 0.456443461806882, 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f7', 1.854554    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f6', 0.0043301866366664 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f6', 0.001437    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f5', 0.0233570000435176 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f5', 0.007746    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f4', 0.0517066074720212 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f4', 0.047241    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f3', 0.357095909777862 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f3', 0.145004    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f2', 0.00624520500806687 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f2', 0.005732    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f1', 0.771091094370277 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f1', 0.291888    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f0', 0.310866499365772 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17f0', 0.19198     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17ef', 0.335885108501131 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17ef', 0.125352    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17ee', 0.385314366789752 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17ee', 0.178914    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17ed', 0.284423018755 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17ed', 0.15409     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17ec', 0.181586643355216 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17ec', 0.112945    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17eb', 0.273526419733984 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17eb', 0.137651    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17ea', 0.293830282536505 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17ea', 0.126228    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e9', 0.625466339828197, 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e9', 0.061835    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e8', 0.0256843642163049 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e8', 0.012375    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e7', 0.128032815608518 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e7', 0.046316    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e6', 0.220401609451802 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e6', 0.065305    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e5', 0.0165082808301864 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e5', 0.036884    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e4', 0.0331454891885692 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e4', 0.074056    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e3', 0.0985073002073263 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e3', 0.220091    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e2', 0.261321650879458 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e2', 0.150036    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e1', 0.300517842339591 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17e1', 0.157844    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17df', 0.0354928593571111 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17df', 0.0793      , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17de', 0.209394977454136 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17de', 0.062008    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17dd', 0.111585664209804 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17dd', 0.143021    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17dc', 0.635801659523875 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17dc', 0.18359     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17db', 0.0552043223964537 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17db', 0.025539    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17da', 0.0124526209130417 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17da', 0.031996    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d9', 0.574937863217281 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d9', 0.114092    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d8', 0.0158125167556091 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d8', 0.078704    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d7', 0.369378479726989 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d7', 0.203937    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d6', 0.108927089662857 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d6', 0.021267    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d5', 0.20184049116835 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d5', 0.091552    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d4', 0.459294316201915 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d4', 0.098345    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('PIChateau', 0.19614211671091 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('PIChateau', 0.08842     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d2', 0.0558422913721843 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d2', 0.028291    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d1', 0.422728913183515 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d1', 0.123298    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d0', 0.120742853044377 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17d0', 0.06287     , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17cf', 0.242302617582067, 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17cf', 0.046167    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17ce', 0.219773643473949 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17ce', 0.099409    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17cd', 0.114298332847118, 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17cd', 0.113107    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17cc', 0.0173474212076718 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17cc', 0.013015    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17cb', 0.100482336565991 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17cb', 0.056466    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17ca', 0.044456656899389 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17ca', 0.019874    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17c9', 1.04816857835071 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17c9', 0.1666      , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17c8', 0.22311963115364, 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17c8', 0.024676    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17c7', 0.0658108344790275 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17c7', 0.051219    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17c6', 0.0768119092556507 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17c6', 0.034337    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17c5', 0.0482444587622635 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17c5', 0.034609    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17c4', 0.118885629771823 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17c4', 0.066189    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17c3', 0.172004882832962 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17c3', 0.089161    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17c2', 0.121633119855457 , 'DOM_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N17c2', 0.049592    , 'PERTES_AUDUN', '');
INSERT INTO epanet.demands VALUES ('N1918', 0.050081444479844 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1918', 0.02284     , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1916', 0.0605789984355094 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1916', 0.027629    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1915', 0.00662622954355315 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1915', 0.003023    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1914', 0.00662622954355315 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1914', 0.003023    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1913', 0.0258238220950692 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1913', 0.011777    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1912', 0.37940264325642 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1912', 0.013464    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1911', 0.149588939099224 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1911', 0.052431    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1910', 0.015841909274793 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1910', 0.000562    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N190f', 0.0485104256935179 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N190f', 0.015461    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N190e', 0.0195750868406639 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N190e', 0.002789    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N190d', 0.000607203579991052 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N190d', 0.000087    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N190c', 0.00733784643756382 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N190c', 0.001045    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N190b', 0.0175976593089999 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N190b', 0.002506    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N190a', 0.0893906476702171 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N190a', 0.006155    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1909', 0.128944017379528 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1909', 0.02536     , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1908', 0.0785396948055622 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1908', 0.011189    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1907', 0.0164041348118218 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1907', 0.025413    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1906', 0.0106630088994196 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1906', 0.01652     , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1905', 0.0127175416475904 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1905', 0.019701    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1904', 0.00744868518629235 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1904', 0.01154     , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1903', 0.0074197707301023 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1903', 0.011496    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1902', 0.121166028664405 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1902', 0.025422    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1901', 0.00180875987055536 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1901', 0.000218    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N1900', 0.039073068464821 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N1900', 0.004708    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18fe', 0.0613661141873497 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18fe', 0.008623    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18fd', 0.0777397281843041 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18fd', 0.008688    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18fc', 0.0952024533644172 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18fc', 0.007534    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18fb', 0.0125135340955828 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18fb', 0.003208    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18fa', 0.0457426696926593 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18fa', 0.006107    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f9', 0.0883625781167931 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f9', 0.006916    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f8', 0.0393606066680443 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f8', 0.004871    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f7', 0.00410264006163266 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f7', 0.001858    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f6', 0.0479851464060654 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f6', 0.010415    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f5', 0.0240761038542484 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f5', 0.006803    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f4', 0.352385296664172 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f4', 0.021093    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f3', 0.00409621462692376 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f3', 0.000245    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f2', 0.288787950274157 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f2', 0.017286    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f1', 0.0757173226096779 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f1', 0.014748    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f0', 0.111171264974711 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18f0', 0.050702    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18ef', 0.00189068416309383 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18ef', 0.000862    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18ee', 0.112019422356286 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18ee', 0.051088    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18ed', 0.0872140316625772 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18ed', 0.011733    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18ec', 0.599356517852808 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18ec', 0.021271    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18eb', 1.02842777140902 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18eb', 0.045136    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18ea', 0.0700436637617191 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18ea', 0.00998     , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e9', 0.00128669330045723 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e9', 0.000183    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e8', 0.0080751650704101 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e8', 0.001151    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e7', 0.0242897495583193 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e7', 0.003461    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e6', 0.0412994815914549 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e6', 0.005884    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e5', 0.225714276812917 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e5', 0.024022    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e4', 0.0382072411377968 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e4', 0.003509    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e3', 0.0847225693542012 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e3', 0.01117     , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e2', 0.0355696001897933 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e2', 0.004373    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e1', 0.00717399785248687 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e1', 0.000427    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e0', 0.190188048307409 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18e0', 0.013642    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18df', 0.0571092636927034 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18df', 0.006971    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18de', 0.000983091510461703 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18de', 0.000449    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18dd', 0.0774714662852076 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18dd', 0.035333    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18dc', 0.185980994931757 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18dc', 0.040434    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18db', 0.132884415214761 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18db', 0.01622     , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18da', 0.0209340662815963 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18da', 0.002953    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d9', 0.217113832455055 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d9', 0.015893    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d8', 0           , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d8', 0           , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d7', 0.0351214261188475 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d7', 0.004231    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d6', 0.0383502070600698 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d6', 0.004748    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d5', 0.0860783360777791 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d5', 0.008866    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d4', 0.0492043726420791 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d4', 0.007177    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d3', 0.0509376336548049 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d3', 0.00745     , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d2', 0.0301031616111966 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d2', 0.008101    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d1', 0.0924427291569446 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d1', 0.015338    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d0', 0.0484301077596567 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18d0', 0.011943    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18cf', 0.0467498565832793 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18cf', 0.008209    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18ce', 0.0435772981957599 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18ce', 0.007687    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18cd', 0.153073131070125 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18cd', 0.003938    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18cc', 0.0058069866181684 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18cc', 0.003681    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18cb', 0.0667538411907623 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18cb', 0.004089    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18ca', 0.358547288550007 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18ca', 0.03015     , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c9', 0.168309443123604 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c9', 0.013595    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c8', 0.0107931239522748 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c8', 0.006816    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c7', 0.00907913924367573 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c7', 0.005728    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c6', 0.1591194651312 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c6', 0.013172    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c5', 0.119389395967394 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c5', 0.010301    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c4', 0.354460712075147 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c4', 0.023884    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c3', 0.0379277347279596 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c3', 0.00347     , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c2', 0.0532829173235534 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c2', 0.004338    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c1', 0.0525472050493844 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c1', 0.035069    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c0', 0.0343343103670073 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18c0', 0.009841    , 'PERTES_RUS', '');
INSERT INTO epanet.demands VALUES ('N18bf', 0.0239267124972665 , 'DOM_RUS', '');
INSERT INTO epanet.demands VALUES ('N18bf', 0.031891    , 'PERTES_RUS', '');
CREATE TABLE epanet.status ("id arc" varchar, "État/Consigne" varchar);
INSERT INTO epanet.status VALUES ('1', 'Closed');
INSERT INTO epanet.status VALUES ('6', 'Closed');
INSERT INTO epanet.status VALUES ('7', 'Open');
INSERT INTO epanet.status VALUES ('8', 'Open');
INSERT INTO epanet.status VALUES ('15', 'Closed');
CREATE TABLE epanet.curves ("id courbe" varchar, "valeur x" float, "valeur y" float);
INSERT INTO epanet.curves VALUES ('PMP_DELL1', 37.8        , 22);
INSERT INTO epanet.curves VALUES ('PMP_ROCHER', 10          , 46);
INSERT INTO epanet.curves VALUES ('PMP_ST_MICHEL', 92          , 91);
INSERT INTO epanet.curves VALUES ('PMP_DELL_2', 11          , 38);
CREATE TABLE epanet.emitters ("id noeud" varchar, "coefficient" float);
--ALTER TABLE epanet.emitters ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.emitters ADD COLUMN geom geometry(POINT,27582);
CREATE TABLE epanet.quality ("id noeud" varchar, "Qualité Initiale" float);
INSERT INTO epanet.quality VALUES ('FORAGE_ST_MICHE', 0);
CREATE TABLE epanet.sources ("id noeud" varchar, "type" float, "Qualité" float, "courbe modul" float);
--ALTER TABLE epanet.sources ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.sources ADD COLUMN geom geometry(POINT,27582);
CREATE TABLE epanet.mixing ("ID Réservoir" varchar, "Modèle" varchar, "Fraction Mélange" varchar);
INSERT INTO epanet.mixing VALUES ('LA_DELL', 'FIFO');

UPDATE epanet.reservoirs AS d SET geom = ('SRID=27582;POINT('||c."coord x"||' '||c."coord y"||')')::geometry FROM epanet.coordinates AS c WHERE d."id noeud" = c."id noeud";
UPDATE epanet.tanks AS d SET geom = ('SRID=27582;POINT('||c."coord x"||' '||c."coord y"||')')::geometry FROM epanet.coordinates AS c WHERE d."id noeud" = c."id noeud";
UPDATE epanet.pumps AS d SET geom = ('SRID=27582;POINT('||c."coord x"||' '||c."coord y"||')')::geometry FROM epanet.coordinates AS c WHERE d."noeudasp" = c."id noeud";
UPDATE epanet.valves AS d SET geom = ('SRID=27582;POINT('||c."coord x"||' '||c."coord y"||')')::geometry FROM epanet.coordinates AS c WHERE d."noeudamont" = c."id noeud";
UPDATE epanet.emitters AS d SET geom = ('SRID=27582;POINT('||c."coord x"||' '||c."coord y"||')')::geometry FROM epanet.coordinates AS c WHERE d."id noeud" = c."id noeud";
UPDATE epanet.sources AS d SET geom = ('SRID=27582;POINT('||c."coord x"||' '||c."coord y"||')')::geometry FROM epanet.coordinates AS c WHERE d."id noeud" = c."id noeud";
UPDATE epanet.pipes AS d SET geom=(SELECT ('SRID=27582;LINESTRING('||array_to_string(array_agg("coord x"||' '||"coord y"),',')||')')::geometry FROM epanet.vertices AS s WHERE d."id arc" = s."id arc" AND (SELECT COUNT(*) FROM epanet.vertices AS v WHERE d."id arc" = v."id arc") > 3);

CREATE TABLE epanet.times(
 "simulation title"     varchar,
 "duration"           	varchar,
 "hydraulic timestep" 	time,
 "quality timestep"   	time,
 "pattern timestep"   	time,
 "pattern start"      	time, 
 "report timestep"    	time,
 "report start"       	time,
 "start clocktime"    	time,
 "statistic"          	varchar
);
INSERT INTO epanet.times VALUES(
'Epanet Simulation',
'48:00',
'0:05',
'0:05',
'0:05',
'0:00',
'0:05',
'0:00',
'12:00 AM',
'None'
);

CREATE TABLE epanet.rules (
    Rule varchar
);
INSERT INTO epanet.rules VALUES(
'Rule 1		
If system clocktime >= 0:00		
and system clocktime < 6:00		
and tank KATZENBERG level below 3.51		
then pump PMP_ST_MICHEL status is open
');
INSERT INTO epanet.rules VALUES(
'Rule 2		
If system clocktime >= 0:00		
and system clocktime < 6:00		
and tank KATZENBERG level above 4.09		
then pump PMP_ST_MICHEL status is closed		
');
INSERT INTO epanet.rules VALUES(
'Rule 3		
If system clocktime >= 6:00
and system clocktime < 22:00
and tank KATZENBERG level below 2.72
then pump PMP_ST_MICHEL status is open
');
INSERT INTO epanet.rules VALUES(
'Rule 4
If system clocktime >= 6:00
and system clocktime < 22:00
and tank KATZENBERG level above 3.18
then pump PMP_ST_MICHEL status is closed
');
INSERT INTO epanet.rules VALUES(
'Rule 5
If system clocktime >= 22:00
and system clocktime < 23:59
and tank KATZENBERG level below 3.51
then pump PMP_ST_MICHEL status is open
');
INSERT INTO epanet.rules VALUES(
'Rule 6
If system clocktime >= 22:00
and system clocktime < 23:59
and tank KATZENBERG level above 4.07
then pump PMP_ST_MICHEL status is closed
');
INSERT INTO epanet.rules VALUES(
'Rule 7
If tank LA_DELL level above 3.94
then valve Poire600 setting is 100000000
');
INSERT INTO epanet.rules VALUES(
'Rule 8
If tank LA_DELL level below 3.939
and tank LA_DELL level above 3.92
then valve Poire600 setting is 5000000
');
INSERT INTO epanet.rules VALUES(
'Rule 9
If tank LA_DELL level below 3.92
and tank LA_DELL level above 3.87
then valve Poire600 setting is 30000
');
INSERT INTO epanet.rules VALUES(
'Rule 8
If tank LA_DELL level below 3.869
and tank LA_DELL level above 3.72
then valve Poire600 setting is 5000
');
INSERT INTO epanet.rules VALUES(
'Rule 8
If tank LA_DELL level below 3.72
then valve Poire600 setting is 1
');
INSERT INTO epanet.rules VALUES(
'rule 10
If tank RUSSANGE level above 3.01
then valves 1 setting is closed
');
INSERT INTO epanet.rules VALUES(
'Rule 11
If tank RUSSANGE level below 2.50
and tank RUSSANGE level above 2
then valve 1 setting is open
');

CREATE TABLE epanet.energy(
    "simulation title"     varchar,
    "global efficiency" float,
    "global price"     float,
    "demand charge"    float
);
INSERT INTO epanet.energy VALUES (
    'Epanet Simulation',
    75,
    0,
    0
);

CREATE TABLE epanet.options(
    "simulation title"   varchar,
    "units"              varchar,
    "headloss"           varchar,
    "specific gravity"   float,
    "viscosity"          float,
    "trials"             integer,
    "accuracy"           float,
    "unbalanced"         varchar,
    "pattern"            varchar,
    "demand multiplier"  float,
    "emitter exponent"   float,
    "quality"            varchar,
    "diffusivity"        float,
    "tolerance"          float
);
INSERT INTO epanet.options VALUES (
    'Epanet Simulation',
    'CMH',
    'D-W',
    1,
    1,
    50,
    0.001,
    'Stop',
    '1',
    1.0,
    0.5,
    'None mg/l',
    1,
    0.01
);

CREATE TABLE epanet.report(
    "simulation title"   varchar,
    "status" varchar,
    "summary" varchar,   	
    nodes varchar,      
    links varchar,        
    "demand" varchar,
    "head" varchar,
    "pressure" varchar,
    "Quality." varchar,
    "length" varchar,
    "diameter" varchar,
    "flow" varchar,
    "velocity" varchar,
    "headloss" varchar,
    "position" varchar,
    "setting" varchar,
    "reaction" varchar,
    "F-Factor" varchar,
    "Demand	BELOW" float,
    "Head	BELOW" float,
    "Pressure	BELOW" float,
    "Quality	BELOW" float,
    "Length	BELOW" float,
    "Diameter	BELOW" float,
    "Flow	BELOW" float,
    "Velocity	BELOW" float,
    "Headloss	BELOW" float,
    "Position	BELOW" float,
    "Setting	BELOW" float,
    "Reaction	BELOW" float,
    "F-Factor	BELOW" float,
    "Demand	ABOVE" float,
    "Head	ABOVE" float,
    "Pressure	ABOVE" float,
    "Quality	ABOVE" float,
    "Length	ABOVE" float,
    "Diameter	ABOVE" float,
    "Flow	ABOVE" float,
    "Velocity	ABOVE" float,
    "Headloss	ABOVE" float,
    "Position	ABOVE" float,
    "Setting	ABOVE" float,
    "Reaction	ABOVE" float,
    "F-Factor	ABOVE" float,
    "Demand	PRECISION" integer,
    "Head	PRECISION" integer,
    "Pressure	PRECISION" integer,
    "Quality	PRECISION" integer,
    "Length	PRECISION" integer,
    "Diameter	PRECISION" integer,
    "Flow	PRECISION" integer,
    "Velocity	PRECISION" integer,
    "Headloss	PRECISION" integer,
    "Position	PRECISION" integer,
    "Setting	PRECISION" integer,
    "Reaction	PRECISION" integer,
    "F-Factor	PRECISION" integer
);

INSERT INTO epanet.report("simulation title",  "status", "summary", nodes, links) 
             VALUES ('Epanet Simulation', 'Full',   'No',      'ALL',   'ALL'); 

CREATE TABLE epanet.reactions (
    "simulation title"   varchar,
    "order bulk" float,
    "order tank" float,
    "order wall" float,
    "global bulk" float,
    "global wall" float,
    "limiting potential" float,
    "roughness correlation" float
);
INSERT INTO epanet.reactions VALUES (
    'Epanet Simulation',
    1,
    1,
    1,
    0,
    0,
    0,
    0
);

ALTER TABLE epanet.junctions ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.reservoirs ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.tanks ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.pipes ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.pumps ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.valves ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.demands ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.status ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.patterns ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.curves ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.emitters ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.quality ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.sources ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.mixing ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.coordinates ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.vertices ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.labels ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.times ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.rules ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.energy ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.options ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.report ADD COLUMN fid serial PRIMARY KEY;
ALTER TABLE epanet.reactions ADD COLUMN fid serial PRIMARY KEY;
COMMIT;
*/
