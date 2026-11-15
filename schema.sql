-- Collabdeal: реєстрації на пробний етап
-- Запустіть цей файл один раз у Supabase → SQL Editor → New query → Run.

create extension if not exists pgcrypto;

create table if not exists public.signups (
  id            uuid primary key default gen_random_uuid(),
  created_at    timestamptz not null default now(),
  role          text not null check (role in ('business', 'creator')),
  name          text not null check (char_length(name) between 2 and 120),
  email         text not null check (email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$' and char_length(email) <= 200),
  country       text check (country in ('PL', 'UA', 'CZ', 'LT', 'LV', 'EE', 'DE', 'OTHER')),
  city          text check (char_length(city) <= 80),
  works_online  boolean not null default false,
  platforms     text[] not null default '{}',
  handle        text check (char_length(handle) <= 200),
  niche         text check (char_length(niche) <= 120),
  creator_type  text check (creator_type in ('human', 'ai')),
  wants_ongoing boolean not null default false,
  ui_lang       text check (ui_lang in ('en', 'pl', 'uk')),
  ref           text check (char_length(ref) <= 60),
  consent       boolean not null check (consent = true)
);

-- Один email = одна реєстрація
create unique index if not exists signups_email_unique on public.signups (lower(email));

-- Безпека: відвідувачі сайту можуть лише ДОДАТИ свою заявку, але не читати чужі
alter table public.signups enable row level security;

drop policy if exists "anyone can sign up" on public.signups;
create policy "anyone can sign up"
  on public.signups for insert
  to anon
  with check (consent = true);

grant insert on public.signups to anon;
revoke select, update, delete on public.signups from anon;

-- Лічильник для сайту: показує тільки кількість, без жодних даних
create or replace function public.signup_count()
returns integer
language sql
security definer
set search_path = public
as $$ select count(*)::int from public.signups $$;

revoke all on function public.signup_count() from public;
grant execute on function public.signup_count() to anon;

-- Перегляд заявок (для вас, у SQL Editor):
-- select created_at, role, name, email, country, city, works_online, platforms, handle, creator_type
-- from public.signups order by created_at desc;
