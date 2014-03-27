create schema epanet

-- [JUNCTIONS]
create view epanet.junctions as
select 'junction_'||id::varchar, altitude_dtm as elevation, ID_DEMAND_PATERN
FROM distribution.od_node;
-- od_meter could contain anual consumption data 
-- and od_subscriber and od_subscribertype could contain curve type

-- [RESERVOIRS]
create view epanet.reservoirs as
select 'reservoir_'||id::varchar, head, head_pattern
from distribution.OD_RESERVOIR;
-- maybe cistern, but then missing fields

-- [TANKS]
create view epanet.tanks as
select 'tank_'||id::varchar, altitude_apron as bottom_elevation, INITIAL_WATER_LEVEL, 0 as minimum_water_level, altitude_overflow - altitude_apron as maximum_water_level, NOMINAL_DIAMETER as nominal_diameter, MINIMUM_VOLUME as minimum_volume, ID_VOLUME_CURVE as id_volume_curve
from distribution.od_installation_tank

-- [PIPES]
create view epanet.pipes as
select 'pipe_'||p.id as id, 'junction_'||p.id_node_a, p.id_node_b, p._lenght3d as lenght, as pm.diameter as diameter, ROUGHNESS as roughness, MINOR_LOSS_COEFFICIENT as minor_loss_coefficient, STATUS as status
from distribution.od_pipe as p 
inner join distribution.vl_pipe_material as pm
on p.id_material = pm.id;
-- roughness can be in vl_pipe_material

-- [PUMPS]
create table epanet._pumps(id integer primary key, power float, id_head_curve integer, speed float, id_pattern integer);
create view epanet.pumps as
select 'pump_'||p.id as id, p.INFLOW_NODE as node_start, p.OUTFLOW_NODE as node_end, 
(select ' HEAD '|| _p.id_curve from epanet._pumps as _p where _p.id = p.id and _p.id_curve is not null)
||
(select ' POWER '|| _p.power from epanet._pumps as _p where _p.id = p.id and _p.power is not null)
||
(select ' SPEED '|| _p.speed from epanet._pumps as _p where _p.id = p.id and _p.speed is not null)
||
(select ' PATTERN '|| _p.id_pattern from epanet._pumps as _p where _p.id = p.id and _p.id_pattern is not null)
as properties
from distribution.od_pump as p;
-- pumps have a direction, so node modelisation is not really appropriate

-- [VALVES]
create table epanet._valve_type (id integer primary key, valve_type varchar);
create table epanet._valve_properties (id integer primary key, valve_setting varchar, minor_loss_coefficient float);
create view epanet.valves as
select v.id, p.INFLOW_NODE as start_node, p.OUTFLOW_NODE as end_node, v.diameter_nominal as diameter, 
(select _vt.valve_type from epanet._valve_type as _vt where _vt.id = v.id ) as valve_type, 
(select _vp.valve_setting from epanet._valve_properties as _vp where _vp_id = v.id) as valve_setting, 
(select _vp.minor_loss_coefficient from epanet._valve_properties as _vp where _pv.id = v.id) as minor_loss_coefficient 
from distribution.od_valve as v
inner join 
-- like pumps, valves have direction, two nodes necessary

-- [EMITTERS]
create table epanet._emitters (id integer primary key, flow_coefficient float);
create view epanet.emitters as
select * from epanet._emitters;

-- [CURVES]
create table epanet._curves (id integer, x float, y float, description varchar);
create view epanet.curves as
select id, x, y from epanet._curves;

-- [PATTERNS]
create table epanet._patterns (id integer, time float, multiplier float);
-- time intervals should follow simulation times
-- if we want something more general, we must change the view
-- and interpolate
-- 
-- we could have the id as a pk and store data as a 2xn array instead
-- of one line per point with ordering by time
create view epanet.paterns as
select id, multiplier
from epanet._patterns
order by time asc;

-- [ENERGY]
create table epanet._energy (simulation_title varchar primary key, "global effic" float, "global pattern" integer, "global price" float, "demand charge" float);
create view epanet.energy as
select * from epanet._energy;

-- [STATUS]
create table epanet._link_status (id integer
