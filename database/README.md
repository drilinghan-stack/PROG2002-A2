# Database

This folder contains the MySQL database schema and sample data for the Charity Events website.

## File

- `charityevents_db.sql` — Full database export (structure + data)

## Tables

- `organisations` — Charitable organisations
- `categories` — Event categories
- `events` — Charity events

## How to import

```bash
mysql -u root -p < charityevents_db.sql