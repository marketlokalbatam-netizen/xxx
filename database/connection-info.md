# Database Connection Information

## Current Cloud Database (Replit/Neon)
- **Provider**: Replit PostgreSQL (Neon backend)
- **Host**: `helium`
- **Port**: `5432`
- **Database**: `heliumdb`
- **Username**: `postgres`
- **Password**: `password`

## Connection String
```
postgresql://postgres:password@helium/heliumdb?sslmode=disable
```

## Tables Structure
- `stores` - Data toko (id, name, address, phone, dll)
- `users` - Data user dan autentikasi
- `products` - Data produk per toko
- `customers` - Data pelanggan per toko
- `cash_flow_entries` - Transaksi keuangan
- `debts` - Data piutang pelanggan

## Sample Data
Database sudah terisi dengan:
- 2 Toko: Toko Sumber Rejeki & Warung Bu Siti
- 14 Produk per toko (7 default + test data)
- 10+ Customer per toko
- Demo user: admin@pos.com / admin123

## Backup/Restore
File backup.sql berisi struktur dan data lengkap untuk restore lokal jika diperlukan.