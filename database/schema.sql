create table roles (
  id uuid primary key default gen_random_uuid(),
  name text unique not null
);

insert into roles (name) values
('Manager'),
('Officer'),
('Senior Supervisor'),
('Supervisor'),
('Equipment Operator');

create table staff (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  rc_number text unique not null,
  role_id uuid references roles(id),
  is_active boolean default true
);

create table capabilities (
  id uuid primary key default gen_random_uuid(),
  name text unique not null
);

insert into capabilities (name) values
('BUS'),
('BT'),
('ECT'),
('CT'),
('GATE');

create table staff_capabilities (
  staff_id uuid references staff(id) on delete cascade,
  capability_id uuid references capabilities(id) on delete cascade,
  primary key (staff_id, capability_id)
);

create table roster (
  id uuid primary key default gen_random_uuid(),
  staff_id uuid references staff(id),
  date date not null,
  start_time time,
  end_time time,
  is_off boolean default false
);

create table area_assignments (
  id uuid primary key default gen_random_uuid(),
  staff_id uuid references staff(id),
  area text,
  start_time timestamptz default now(),
  end_time timestamptz
);
