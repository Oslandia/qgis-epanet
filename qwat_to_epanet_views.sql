create schema epanet;

-- NOTE: on a versionned db, distribution is the replaced by name of a versionned schema view
--       e.g. distribution_trunk_rev_head or distribution_mybranch_rev_45

-- [JUNCTIONS]
create table epanet._junctions_demand_pattern ( id integer primary key, id_pattern integer );
create view epanet.junctions as
select n.id, n.altitude as elevation, (select _jdp.id_pattern from epanet._junctions_demand_pattern as _jdp where _jdp.id = n.id ) as id_demand_patern, n.geometry
FROM qwat_od.node as n;
-- od_meter could contain anual consumption data 
-- and od_subscriber and od_subscribertype could contain curve type

-- TODO exclude nodes that are in RESERVOIRS or TANKS from the view
-- the exclusion could also be achieved by doing an inner join with epanet._junctions_demand_pattern
-- but in this case some demand pattern will be null

-- [RESERVOIRS]
create view epanet.reservoirs as
select fk_node, head, head_pattern, geometry
from distribution.OD_RESERVOIR;
-- maybe cistern, but then missing fields

-- [TANKS]
create table epanet._tanks (fk_node integer primary key, initial_water_level float, minimum_water_level float, nominal_diameter float, minimum_volume float, id_volume_curve integer);
create view epanet.tanks as
select t.fk_node, t.altitude_apron as bottom_elevation, _t.initial_water_level, _t.minimum_water_level, altitude_overflow - altitude_apron as maximum_water_level, _t.nominal_diameter, _t.minimum_volume, _t.id_volume_curve, t.geometry
from qwat_od.installation_tank as t
inner join epanet._tanks as _t
on _t.fk_node = t.fk_node;

-- [PIPES]
create table epanet._pipes (id integer references qwat_od.pipe(id), roughness float, minor_loss_coefficient float, status varchar);
create view epanet.pipes as
select 'pipe_'||p.id::varchar as id, p.fk_node_a, p.fk_node_b, p._length3d as length, pm.diameter as diameter, _p.roughness, _p.minor_loss_coefficient, _p.status, p.geometry
from qwat_od.pipe as p 
inner join qwat_vl.pipe_material as pm
on p.fk_material = pm.id
inner join epanet._pipes as _p
on p.id = _p.id;
-- roughness can be in qwat_vl.pipe_material
-- 
-- the 'pipe_' qualified id is necessary for status specification and result processing
-- this is not necessary for nodes since tanks and reservoirs have corresponding nodes 
--
-- we could use the notion of a link in the network the same way we use nodes

-- [PUMPS]
create table epanet._pumps(id integer references qwat_od.installation_pump(id), power float, id_head_curve integer, speed float, id_pattern integer);
create view epanet.pumps as
select 'pump_'||p.id::varchar as id, p.fk_pipe_in as node_start, p.fk_pipe_out as node_end, 
(select ' HEAD '|| _p.id_head_curve from epanet._pumps as _p where _p.id = p.id and _p.id_head_curve is not null)
||
(select ' POWER '|| _p.power from epanet._pumps as _p where _p.id = p.id and _p.power is not null)
||
(select ' SPEED '|| _p.speed from epanet._pumps as _p where _p.id = p.id and _p.speed is not null)
||
(select ' PATTERN '|| _p.id_pattern from epanet._pumps as _p where _p.id = p.id and _p.id_pattern is not null)
as properties,
geometry
from qwat_od.installation_pump as p;
-- pumps have a direction, so node modelisation is not really appropriate

-- [VALVES]
create table epanet._valve_type (id integer references qwat_vl.valve_type(id), valve_type varchar);
create table epanet._valve_properties (id integer references qwat_od.valve(id), valve_setting varchar, minor_loss_coefficient float);
create view epanet.valves as
select v.id, p.fk_pipe_in as start_node, p.fk_pipe_out as end_node, v.diameter_nominal as diameter, 
(select _vt.valve_type from epanet._valve_type as _vt where _vt.id = v.id ) as valve_type, 
(select _vp.valve_setting from epanet._valve_properties as _vp where _vp_id = v.id) as valve_setting, 
(select _vp.minor_loss_coefficient from epanet._valve_properties as _vp where _pv.id = v.id) as minor_loss_coefficient,
geometry 
from qwat_od.valve as v;
-- like pumps, valves have direction, two nodes necessary
-- 
-- we could use inner joins on epanet._valve_type and epanet._valve_properties

-- [EMITTERS]
create table epanet._emitters (fk_node integer references qwat_od.node(id), flow_coefficient float);
create view epanet.emitters as
select e.fk_node, e.flow_coefficient, n.geometry
from epanet._emitters as e
inner join qwat_od.node as n
on e.id = n.id;

-- [CURVES]
create table epanet._curves (id integer, x float, y float, description varchar);
create view epanet.curves as
select id, x, y from epanet._curves 
order by x asc;

-- [PATTERNS]
create table epanet._patterns (id integer, time float, multiplier float);
create view epanet.patterns as
select id, multiplier
from epanet._patterns
order by time asc;
-- time intervals should follow simulation times
-- if we want something more general, we must change the view
-- and interpolate
-- 
-- we could have the id as a pk and store data as a 2xn array instead
-- of one line per point with ordering by time

-- [ENERGY]
create table epanet.energy (
    simulation_title varchar primary key, 
    "global effic" float, 
    "global pattern" integer, 
    "global price" float, 
    "demand charge" float
);

-- [STATUS]
create table epanet.link_status (id_link varchar primary key, status_or_setting varchar);

-- [CONTROLS]
create table epanet.controls (control varchar);

-- [RULES]
create table epanet.rules (rule varchar);

-- [DEMANDS]
create table epanet.demands (id integer references qwat_od.node(id), base_demand float, id_pattern integer, category varchar);
-- category must begin with a semicolumn

-- [QUALITY]
create table epanet.quality (id integer references qwat_od.node(id), initial_quality float);

-- [REACTIONS]
create table epanet.reactions (
    simulation_title varchar primary key, 
    "order bulk" float, 
    "order tank" float, 
    "order wall" float, 
    "global bulk" float, 
    "global wall" float, 
    "limiting potential" float, 
    "roughness correlation" float
);

-- [SOURCES]
create table epanet.sources (id integer references qwat_od.node(id), source_type varchar, baseline_source_strength float, id_pattern integer);

-- [MIXING]
create table epanet._mixing(id integer references qwat_od.installation_tank(id), mixing_model varchar, compartment_volume_fraction float);
create view epanet.mixing as
select t.fk_node, _m.mixing_model, _m.compartment_volume_fraction
from epanet._mixing as _m
inner join qwat_od.installation_tank as t
on _m.id = t.id;

-- [OPTIONS]
create table epanet._options ( 
    simulation_title varchar primary key, 
    "units" varchar, headloss varchar, 
    "specific gravity" float, 
    "viscosity" float, 
    "trials" integer, 
    "accuracy" float, 
    "unbalanced" varchar, 
    "pattern" varchar, 
    "demand multiplier" float, 
    "emitter exponent" float, 
    "quality" varchar, 
    "diffusivity" float, 
    "tolerance" float
);

-- [TIMES]
CREATE TABLE epanet."TIMES"(
 simulation_title varchar primary key,
 "duration"           varchar,
 "hydraulic timestep"  time,
 "quality timestep"    time,
 "pattern timestep"    time,
 "pattern start"       time, 
 "report timestep"     time,
 "report start"        time,
 "start clocktime"     time,
 "statistic"           varchar
);

-- [REPORT]
create table epanet.report(
    simulation_title varchar primary key,
    "status" varchar,
    "summary" varchar,    
    "nodes" varchar,      
    "links" varchar,        
    "demand" varchar,
    "head" varchar,
    "pressure" varchar,
    "quality." varchar,
    "length" varchar,
    "diameter" varchar,
    "flow" varchar,
    "velocity" varchar,
    "headloss" varchar,
    "position" varchar,
    "setting" varchar,
    "reaction" varchar,
    "f-factor" varchar,
    "demand below" float,
    "head below" float,
    "pressure below" float,
    "quality below" float,
    "length below" float,
    "diameter below" float,
    "flow below" float,
    "velocity below" float,
    "headloss below" float,
    "position below" float,
    "setting below" float,
    "reaction below" float,
    "f-factor below" float,
    "demand above" float,
    "head above" float,
    "pressure above" float,
    "quality above" float,
    "length above" float,
    "diameter above" float,
    "flow above" float,
    "velocity above" float,
    "headloss above" float,
    "position above" float,
    "setting above" float,
    "reaction above" float,
    "f-factor above" float,
    "demand precision" integer,
    "head precision" integer,
    "pressure precision" integer,
    "quality precision" integer,
    "length precision" integer,
    "diameter precision" integer,
    "flow precision" integer,
    "velocity precision" integer,
    "headloss precision" integer,
    "position precision" integer,
    "setting precision" integer,
    "reaction precision" integer,
    "f-factor precision" integer
);
