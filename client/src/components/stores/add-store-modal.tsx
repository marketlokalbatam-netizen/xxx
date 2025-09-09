import { useState } from 'react';
import { Store, MapPin, Phone, Globe } from 'lucide-react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { useToast } from '@/hooks/use-toast';

const storeSchema = z.object({
  name: z.string().min(1, 'Nama toko harus diisi'),
  address: z.string().optional(),
  phone: z.string().optional(),
  timezone: z.string().default('Asia/Jakarta'),
  currency: z.string().default('IDR'),
  lowStockThreshold: z.number().min(1, 'Minimal 1').default(5),
});

type StoreFormData = z.infer<typeof storeSchema>;

interface AddStoreModalProps {
  isOpen: boolean;
  onClose: () => void;
  onStoreAdded: (store: any) => void;
}

export function AddStoreModal({ isOpen, onClose, onStoreAdded }: AddStoreModalProps) {
  const [loading, setLoading] = useState(false);
  const { toast } = useToast();

  const {
    register,
    handleSubmit,
    formState: { errors },
    reset,
    setValue,
    watch,
  } = useForm<StoreFormData>({
    resolver: zodResolver(storeSchema),
    defaultValues: {
      timezone: 'Asia/Jakarta',
      currency: 'IDR',
      lowStockThreshold: 5,
    },
  });

  const onSubmit = async (data: StoreFormData) => {
    setLoading(true);
    
    try {
      const response = await fetch('/api/stores', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
      });

      if (response.ok) {
        const newStore = await response.json();
        
        // Update user's store access
        const currentUser = JSON.parse(localStorage.getItem('currentUser') || '{}');
        if (currentUser.id) {
          // In a real app, you'd call an API to add store to user's access
          console.log('Store added:', newStore);
        }
        
        toast({
          title: 'Berhasil!',
          description: 'Toko baru berhasil ditambahkan',
        });
        
        onStoreAdded(newStore);
        reset();
      } else {
        const error = await response.json();
        toast({
          title: 'Gagal!',
          description: error.message || 'Gagal menambahkan toko',
          variant: 'destructive',
        });
      }
    } catch (error) {
      console.error('Error adding store:', error);
      toast({
        title: 'Error!',
        description: 'Terjadi kesalahan saat menambahkan toko',
        variant: 'destructive',
      });
    } finally {
      setLoading(false);
    }
  };

  const handleClose = () => {
    reset();
    onClose();
  };

  return (
    <Dialog open={isOpen} onOpenChange={handleClose}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <Store className="h-5 w-5 text-blue-600" />
            Tambah Toko Baru
          </DialogTitle>
          <DialogDescription>
            Buat toko baru untuk mengelola bisnis Anda
          </DialogDescription>
        </DialogHeader>

        <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="name">Nama Toko *</Label>
            <Input
              id="name"
              placeholder="Masukkan nama toko"
              {...register('name')}
              className={errors.name ? 'border-red-500' : ''}
            />
            {errors.name && (
              <p className="text-sm text-red-500">{errors.name.message}</p>
            )}
          </div>

          <div className="space-y-2">
            <Label htmlFor="address">Alamat</Label>
            <Textarea
              id="address"
              placeholder="Masukkan alamat lengkap toko"
              rows={3}
              {...register('address')}
              className="resize-none"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="phone">Nomor Telepon</Label>
            <Input
              id="phone"
              placeholder="Contoh: 021-12345678"
              {...register('phone')}
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label>Zona Waktu</Label>
              <Select 
                defaultValue="Asia/Jakarta" 
                onValueChange={(value) => setValue('timezone', value)}
              >
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="Asia/Jakarta">Asia/Jakarta (WIB)</SelectItem>
                  <SelectItem value="Asia/Makassar">Asia/Makassar (WITA)</SelectItem>
                  <SelectItem value="Asia/Jayapura">Asia/Jayapura (WIT)</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <Label>Mata Uang</Label>
              <Select 
                defaultValue="IDR" 
                onValueChange={(value) => setValue('currency', value)}
              >
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="IDR">IDR (Rupiah)</SelectItem>
                  <SelectItem value="USD">USD (Dollar)</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>

          <div className="space-y-2">
            <Label htmlFor="lowStockThreshold">Batas Stok Minimum</Label>
            <Input
              id="lowStockThreshold"
              type="number"
              min="1"
              {...register('lowStockThreshold', { valueAsNumber: true })}
              className={errors.lowStockThreshold ? 'border-red-500' : ''}
            />
            <p className="text-xs text-gray-500">
              Sistem akan memberikan peringatan jika stok produk kurang dari nilai ini
            </p>
            {errors.lowStockThreshold && (
              <p className="text-sm text-red-500">{errors.lowStockThreshold.message}</p>
            )}
          </div>

          <DialogFooter className="gap-2 pt-4">
            <Button type="button" variant="outline" onClick={handleClose}>
              Batal
            </Button>
            <Button type="submit" disabled={loading}>
              {loading ? 'Menyimpan...' : 'Simpan Toko'}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}