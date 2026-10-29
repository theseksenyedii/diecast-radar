-- Diecast Radar / Supabase PostgreSQL schema v1
-- Run in Supabase SQL Editor. Catalog data is not bundled with this schema.
create extension if not exists pgcrypto;
create table if not exists public.hw_variants (
  id uuid primary key default gen_random_uuid(),
  casting text not null,
  model_name text not null,
  release_year smallint not null check (release_year between 1968 and 2100),
  color text not null,
  series text not null,
  toy_number text,
  rarity text not null default 'Unknown',
  source_url text,
  source_verified boolean not null default false,
  created_at timestamptz not null default now(),
  unique (model_name, release_year, color, series, toy_number)
);
create index if not exists hw_variants_model_name_idx on public.hw_variants (model_name);
create index if not exists hw_variants_release_year_idx on public.hw_variants (release_year);
create table if not exists public.price_observations (
  id uuid primary key default gen_random_uuid(),
  variant_id uuid not null references public.hw_variants(id) on delete cascade,
  marketplace text not null,
  amount_try numeric(12,2) not null check(amount_try > 0),
  condition text not null default 'unknown',
  status text not null check(status in ('active_listing','sold_verified','user_reported')),
  observed_at timestamptz not null default now(),
  source_url text,
  verified boolean not null default false
);
create index if not exists price_observations_variant_idx on public.price_observations (variant_id,observed_at desc);
alter table public.hw_variants enable row level security;
alter table public.price_observations enable row level security;
drop policy if exists "public verified catalog read" on public.hw_variants;
create policy "public verified catalog read" on public.hw_variants for select to anon,authenticated using (source_verified = true);
drop policy if exists "public verified prices read" on public.price_observations;
create policy "public verified prices read" on public.price_observations for select to anon,authenticated using (verified = true);
-- No public insert/update/delete policy: entries must be reviewed by an administrator.
