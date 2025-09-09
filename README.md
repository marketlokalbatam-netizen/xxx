# BukuWarung POS - Local Development Setup

## 📋 Overview
Aplikasi Point of Sale (POS) dan pencatatan keuangan untuk UMKM dengan fitur multi-toko, manajemen inventori, tracking utang pelanggan, dan laporan keuangan.

## 🏗️ Architecture
- **Frontend**: React + TypeScript + Vite + Tailwind CSS
- **Backend**: Node.js + Express + TypeScript  
- **Database**: PostgreSQL (Cloud Neon)
- **ORM**: Drizzle ORM
- **UI Components**: Radix UI + shadcn/ui

## 🌍 Cloud Database Connection

### Database Details
- **Provider**: Replit PostgreSQL (Neon backend)
- **Host**: `helium`
- **Connection**: Cloud database dengan akses real-time

### Environment Variables
File `.env` sudah tersedia dengan konfigurasi yang benar:
```env
# Database Configuration
DATABASE_URL=postgresql://postgres:password@helium/heliumdb?sslmode=disable

# Server Configuration  
PORT=5000
NODE_ENV=development

# Database Connection Details
PGHOST=helium
PGPORT=5432
PGUSER=postgres
PGPASSWORD=password
PGDATABASE=heliumdb
```

**✅ SIAP PAKAI**: Environment sudah dikonfigurasi untuk akses database cloud.

## 🚀 Local Development Setup

### Prerequisites
- Node.js 18+ 
- npm atau yarn
- Git

### Installation Steps

1. **Clone/Extract Backup**
```bash
cd backup-production
```

2. **Install Dependencies**
```bash
# Install semua dependencies
npm install
```

3. **Setup Environment**
```bash
# Copy dan edit file environment
cp .env.example .env
# Edit .env dengan database credentials yang benar
```

4. **Database Setup**
```bash
# Generate database client
npm run db:generate

# Push schema ke database (jika belum ada)
npm run db:push
```

5. **Start Development Servers**

**Terminal 1 - Backend Server:**
```bash
# Start backend server di port 5000
npm run dev:server
```

**Terminal 2 - Frontend Dev Server:**
```bash  
# Start frontend server di port 3000
npm run dev:client
```

6. **Access Application**
- Frontend: http://localhost:3000
- Backend API: http://localhost:5000/api

## 📁 Project Structure
```
backup-production/
├── client/                 # React Frontend
│   ├── src/
│   │   ├── components/     # UI Components
│   │   ├── pages/          # Page Components
│   │   ├── hooks/          # Custom Hooks
│   │   ├── lib/            # Utilities
│   │   └── ...
├── server/                 # Express Backend
│   ├── routes.ts           # API Routes
│   ├── storage.ts          # Database Operations
│   ├── auth-routes.ts      # Authentication
│   └── ...
├── shared/                 # Shared Code
│   └── schema.ts           # Database Schema
├── docs/                   # Documentation
├── database/              # Database Files
└── README.md              # This file
```

## 🔑 Authentication
**Demo User:**
- Email: `admin@pos.com`
- Password: `admin123`

## 🏪 Multi-Store Features
- Aplikasi sudah memiliki 2 toko demo:
  - **Toko Sumber Rejeki** (Jakarta)
  - **Warung Bu Siti** (Bandung)
- Switch toko menggunakan dropdown di kiri atas
- Data terpisah per toko (products, customers, transactions)

## 📊 Database Schema
Database memiliki tabel utama:
- `stores` - Data toko
- `products` - Data produk per toko
- `customers` - Data pelanggan per toko  
- `cash_flow_entries` - Transaksi keuangan
- `debts` - Data piutang pelanggan
- `users` - Data user dan akses toko

## 🔧 Available Scripts

### Development
```bash
npm run dev          # Start both frontend & backend
npm run dev:client   # Start frontend only  
npm run dev:server   # Start backend only
```

### Database
```bash
npm run db:generate  # Generate database client
npm run db:push      # Sync schema to database
npm run db:studio    # Open Drizzle Studio
```

### Build
```bash
npm run build        # Build for production
npm run build:client # Build frontend only
npm run build:server # Build backend only
```

## 🔍 API Endpoints

### Stores
- `GET /api/stores` - List all stores
- `POST /api/stores` - Create new store
- `PUT /api/stores/:id` - Update store

### Products
- `GET /api/stores/:storeId/products` - Get products by store
- `POST /api/stores/:storeId/products` - Create product
- `PUT /api/products/:id` - Update product
- `DELETE /api/products/:id` - Delete product

### Customers  
- `GET /api/stores/:storeId/customers` - Get customers by store
- `POST /api/stores/:storeId/customers` - Create customer
- `PUT /api/customers/:id` - Update customer

### Cash Flow
- `GET /api/stores/:storeId/cashflow` - Get cash flow by store
- `POST /api/stores/:storeId/cashflow` - Create cash flow entry

## 🐛 Troubleshooting

### Database Connection Issues
1. Pastikan `DATABASE_URL` di `.env` benar
2. Cek koneksi internet untuk akses cloud database
3. Verifikasi IP whitelist di Neon dashboard

### Build Errors
1. Hapus `node_modules` dan `package-lock.json`
2. Run `npm install` ulang
3. Pastikan Node.js version 18+

### Port Conflicts
1. Ganti port di `vite.config.ts` (frontend)
2. Ganti `PORT` di `.env` (backend)

## 📞 Support
Jika ada masalah dengan setup lokal:
1. Cek log error di terminal
2. Pastikan semua environment variables ter-set
3. Verifikasi database cloud dapat diakses

## 🔄 Sync dengan Cloud
Database tetap menggunakan cloud Neon, jadi:
- Data real-time sync otomatis
- Tidak perlu backup database manual
- Multiple developer bisa akses data sama
- Production-ready setup

---
*Generated: ${new Date().toISOString()}*