# 🚀 SETUP INSTRUCTIONS - BukuWarung POS

## 📥 Langkah Setup (5 Menit)

### 1. Download/Extract Folder
```bash
# Masuk ke folder backup-production
cd backup-production
```

### 2. Install Dependencies
```bash
# Install semua dependencies
npm install
```

### 3. Start Application
```bash
# Start frontend & backend bersamaan
npm run dev
```

### 4. Akses Aplikasi
- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:5000/api
- **Login**: admin@pos.com / admin123

## ✅ Yang Sudah Dikonfigurasi

- ✅ Database cloud connection (Replit PostgreSQL)
- ✅ Environment variables (.env)
- ✅ Package.json dengan scripts lengkap
- ✅ Tailwind CSS & UI components
- ✅ TypeScript configuration
- ✅ Vite build system
- ✅ Sample data (2 toko, produk, customer)

## 🎯 Fitur Utama

### Multi-Store Management
- Switch toko via dropdown header kiri atas
- Data terpisah per toko
- Tambah toko baru dengan modal form

### Inventory & Sales
- Manajemen produk (CRUD)
- Tracking stok real-time
- POS system dengan keranjang
- Multiple payment methods

### Customer & Finance
- Database pelanggan
- Sistem piutang/utang
- Cash flow tracking
- Laporan keuangan

## 🛠️ Commands Reference

```bash
# Development
npm run dev              # Start both servers
npm run dev:client       # Frontend only
npm run dev:server       # Backend only

# Database  
npm run db:push          # Sync schema
npm run db:studio        # DB admin UI

# Build
npm run build           # Production build
npm run start           # Production start
```

## 🌐 Database Cloud Access

Database menggunakan **Replit PostgreSQL Cloud** yang:
- ✅ Tersedia 24/7 dari mana saja
- ✅ Backup otomatis
- ✅ Akses multi-user
- ✅ Data real-time sync
- ✅ Production-ready

## 📁 File Structure

```
backup-production/
├── README.md              # Dokumentasi lengkap
├── SETUP-INSTRUCTIONS.md  # Panduan setup (file ini)
├── package.json           # Dependencies & scripts
├── .env                   # Database config (SIAP PAKAI)
├── vite.config.ts         # Frontend build config
├── tsconfig.json          # TypeScript config
├── tailwind.config.ts     # Styling config
│
├── client/                # React Frontend
│   ├── src/components/    # UI Components
│   ├── src/pages/         # Page Components  
│   ├── src/hooks/         # Custom Hooks
│   └── src/lib/           # Utilities
│
├── server/                # Express Backend
│   ├── index.ts           # Server entry point
│   ├── routes.ts          # API routes
│   ├── storage.ts         # Database operations
│   └── auth-routes.ts     # Authentication
│
├── shared/                # Shared Code
│   └── schema.ts          # Database schema
│
├── database/              # Database Files
│   ├── backup.sql         # Database backup
│   └── connection-info.md # Connection details
│
└── docs/                  # Documentation
    ├── features.md        # Feature documentation
    └── local-setup.md     # Setup guide
```

## 🆘 Butuh Bantuan?

1. **Port sudah digunakan**: 
   - Frontend: http://localhost:3001, 3002, dst
   - Backend: Ganti PORT di .env

2. **Database error**: 
   - Cek koneksi internet
   - Verifikasi file .env

3. **Build error**: 
   - `rm -rf node_modules && npm install`
   - Update Node.js ke versi 18+

---
**🎉 Ready to use! Enjoy coding!**