-- ============================================================
-- JAI GURU JI SALARY APP v2 — SUPABASE SQL
-- Supabase Dashboard → SQL Editor mein paste karke Run karo
-- ============================================================

-- 1. Employees table
create table if not exists employees (
  id          text primary key,
  name        text not null,
  desig       text,
  machine     text default 'Normal',
  saltype     text default 'fixed',
  fixed       numeric default 0,
  daily       numeric default 0,
  created_at  timestamptz default now()
);

-- 2. Attendance table (har din ka record)
create table if not exists attendance (
  id          bigserial primary key,
  emp_id      text references employees(id) on delete cascade,
  att_date    date not null,
  shift       text default 'day',   -- 'day' or 'night'
  status      text default 'A',     -- P, A, H, 1.5X, OT
  ot_hours    numeric default 0,
  unique(emp_id, att_date, shift)
);

-- 3. Advances table
create table if not exists advances (
  id          bigserial primary key,
  emp_id      text references employees(id) on delete cascade,
  adv_date    date not null,
  amount      numeric default 0,
  note        text,
  created_at  timestamptz default now()
);

-- 4. Row Level Security
alter table employees enable row level security;
alter table attendance enable row level security;
alter table advances enable row level security;

drop policy if exists "Allow all" on employees;
drop policy if exists "Allow all" on attendance;
drop policy if exists "Allow all" on advances;

create policy "Allow all" on employees for all using (true) with check (true);
create policy "Allow all" on attendance for all using (true) with check (true);
create policy "Allow all" on advances for all using (true) with check (true);
