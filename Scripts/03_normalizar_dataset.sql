DROP TABLE meta_fncer__raw;
-- crecacion de la tabla para traerla desde cvs y empezar a normalizar
create table meta_fncer__raw(
	id 						serial,
	Proyecto				text,
	tipo					text,
	capacidad				float,
	departamento			text,
	municipio				text,
	codigo_departamento		integer,
	codigo_municipio		integer,
	fecha_estimada_fpo		timestamp,
	energia_kwhdia			float,
	usuarios				integer,
	inversion_estimada_cop	numeric,
	empleos_estimados		integer,
	emisiones_co2_tonano	float,
	primary key(id)
);

--2. Crear tablas para empeza a normalizar datos.
create table departamentos(
	id						serial,
	departamento			varchar(128) unique not null,
	codigo_departamento		integer unique not null,
	primary KEY(id)
);

CREATE TABLE municipios(
	id						serial,
	municipio				varchar(128) not null,
	codigo_municipio		integer not null,
	id_departamento			integer not null,
	PRIMARY KEY(id),
	foreign key(id_departamento) references departamentos(id) on delete cascade,
	unique(codigo_municipio, id_departamento)
);

create table tipos_proyectos(
	id						serial,
	nombre_tipo				varchar(32) unique not null,
	primary key(id)
);

create table proyectos(
	id							serial primary key,
	proyecto					varchar(128) unique not null,
	capacidad					float not null,
	fecha_estimada_fpo			date not null,
	energia_kwhdia				float not null,
	usuarios					integer not null,
	inversion_estimada_cop		numeric not null,
	empleos_estimados			integer not null,
	emisiones_co2_tonano		float not null,
	id_tipo						integer not null,
	foreign key(id_tipo) references tipos_proyectos(id) on delete cascade
);
	
create table proyectos_municipios(
	id_proyecto  				integer not null,
    id_municipio 				integer not null,
    foreign key (id_proyecto) references proyectos(id) on delete cascade,
    foreign key (id_municipio) references municipios(id) on delete cascade,
    primary key (id_proyecto, id_municipio)
);

--3. iniciar la insercion de datos de la tabla cruda hacia las tablas que etan para normalizar
insert into departamentos (departamento, codigo_departamento)
select distinct departamento, codigo_departamento 
from meta_fncer__raw
where departamento is not null and codigo_departamento is not null;

insert into municipios (municipio, codigo_municipio, id_departamento)
select distinct mfr.municipio,
				mfr.codigo_municipio,
				d.id
from meta_fncer__raw mfr
join departamentos d on mfr.codigo_departamento = d.codigo_departamento
where mfr.municipio is not null and mfr.codigo_municipio is not null and mfr.codigo_departamento is not null;

insert into tipos_proyectos (nombre_tipo)
select distinct tipo 
from meta_fncer__raw
where tipo is not null;

insert into proyectos (proyecto, capacidad, fecha_estimada_fpo,energia_kwhdia, usuarios, inversion_estimada_cop, empleos_estimados,emisiones_co2_tonano, id_tipo)
select mfr.proyecto,
		mfr.capacidad,
		mfr.fecha_estimada_fpo,
		mfr.energia_kwhdia,
		mfr.usuarios,
		mfr.inversion_estimada_cop,
		mfr.empleos_estimados,
		mfr.emisiones_co2_tonano,
		tp.id
from meta_fncer__raw mfr
join tipos_proyectos tp on tp.nombre_tipo = mfr.tipo
where mfr.proyecto is not null and mfr.capacidad is not null 
	and mfr.fecha_estimada_fpo is not null and mfr.energia_kwhdia is not null 
	and mfr.usuarios is not null and mfr.inversion_estimada_cop is not null 
	and mfr.empleos_estimados is not null and mfr.emisiones_co2_tonano is not null;

insert into proyectos_municipios (id_municipio, id_proyecto)
select distinct d.id as id_proyectos,
				m.id as id_municipios
from meta_fncer__raw mfr
join proyectos p  on mfr.proyecto = p.proyecto
join departamentos d on mfr.codigo_departamento = d.codigo_departamento
join municipios m on mfr.codigo_municipio = m.codigo_municipio
		and m.id = d.id
where mfr.proyecto is not null and mfr.municipio is not null;

-- Se utiliza para eliminar duplicado de proyecto ya que la validar se obtinene los mismos datos en todo sentido
select * 
from meta_fncer__raw 
where proyecto = 'DULIMA PARTE 2';

delete from meta_fncer__raw 
where id in (
    select id
    from (
        select 
            id,
            row_number() over (partition by proyecto order by id) AS row_num
        from meta_fncer__raw
    ) as sub
    where row_num > 1
);

5. se crea una vista de la tabla meta_fncer para ahorra espacio
create view meta_fncer as
select 
    p.id as proyecto_id,
    p.proyecto,
    p.capacidad,
    p.fecha_estimada_fpo,
    p.energia_kwhdia,
    p.usuarios,
    p.inversion_estimada_cop,
    p.empleos_estimados,
    p.emisiones_co2_tonano,
    tp.nombre_tipo AS tipo_proyecto,
    m.municipio,
    m.codigo_municipio,
    d.departamento,
    d.codigo_departamento
from proyectos p
join tipos_proyectos tp on p.id_tipo = tp.id
join proyectos_municipios pm on p.id = pm.id_proyecto
join municipios m on pm.id_municipio = m.id
join departamentos d on m.id_departamento = d.id;

--6. actualizar datos vacios en tabla municipio
update municipios
set municipio = 'CALI'
where (municipio IS NULL OR municipio = '""')
  and codigo_municipio = 76;

update municipios
set municipio = 'CUCUTA'
where (municipio IS NULL OR municipio = '""')
  and codigo_municipio = 54;

update municipios
set municipio = 'MONTERIA'
where (municipio IS NULL OR municipio = '""')
  and codigo_municipio = 23;
	