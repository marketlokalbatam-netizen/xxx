import { useState, useEffect } from 'react';
import { Store, ChevronDown, Plus } from 'lucide-react';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuGroup,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { AddStoreModal } from './add-store-modal';
import { useCurrentStore } from '@/hooks/useCurrentStore';

interface Store {
  id: string;
  name: string;
  address?: string;
  phone?: string;
}

export function StoreSelector() {
  const [stores, setStores] = useState<Store[]>([]);
  const [showAddModal, setShowAddModal] = useState(false);
  const [loading, setLoading] = useState(true);
  const { currentStore, setCurrentStore } = useCurrentStore();

  // Load stores from API
  const loadStores = async () => {
    try {
      const response = await fetch('/api/stores');
      if (response.ok) {
        const storesData = await response.json();
        setStores(storesData);
        
        // Set first store as current if none selected and no saved store
        const savedStoreId = localStorage.getItem('currentStoreId');
        if (savedStoreId) {
          const savedStore = storesData.find(s => s.id === savedStoreId);
          if (savedStore) {
            setCurrentStore(savedStore);
          } else if (storesData.length > 0) {
            // Saved store not found, use first available
            setCurrentStore(storesData[0]);
            localStorage.setItem('currentStoreId', storesData[0].id);
          }
        } else if (storesData.length > 0 && !currentStore) {
          setCurrentStore(storesData[0]);
          localStorage.setItem('currentStoreId', storesData[0].id);
        }
      }
    } catch (error) {
      console.error('Failed to load stores:', error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadStores();
  }, []);

  // Load current store from localStorage on mount
  useEffect(() => {
    const savedStoreId = localStorage.getItem('currentStoreId');
    if (savedStoreId && stores.length > 0) {
      const store = stores.find(s => s.id === savedStoreId);
      if (store) {
        setCurrentStore(store);
      }
    } else if (stores.length > 0 && !currentStore) {
      // If no saved store, use first available store
      setCurrentStore(stores[0]);
      localStorage.setItem('currentStoreId', stores[0].id);
    }
  }, [stores, currentStore]);

  const handleStoreChange = (store: Store) => {
    setCurrentStore(store);
    // Refresh page to update data for new store
    window.location.reload();
  };

  const handleStoreAdded = (newStore: Store) => {
    setStores(prev => [...prev, newStore]);
    setCurrentStore(newStore);
    setShowAddModal(false);
    // Refresh page to update data for new store
    window.location.reload();
  };

  if (loading) {
    return (
      <div className="flex items-center gap-2">
        <Store className="h-5 w-5 text-gray-400" />
        <span className="text-sm text-gray-400">Loading...</span>
      </div>
    );
  }

  return (
    <>
      <DropdownMenu>
        <DropdownMenuTrigger asChild>
          <Button variant="ghost" className="flex items-center gap-2 h-auto p-2">
            <Store className="h-5 w-5 text-blue-600" />
            <div className="flex flex-col items-start">
              <span className="text-sm font-medium text-gray-900">
                {currentStore?.name || 'Pilih Toko'}
              </span>
              {currentStore && (
                <span className="text-xs text-gray-500 truncate max-w-32">
                  {stores.length} toko tersedia
                </span>
              )}
            </div>
            <ChevronDown className="h-4 w-4 text-gray-400" />
          </Button>
        </DropdownMenuTrigger>

        <DropdownMenuContent align="start" className="w-64">
          <DropdownMenuLabel className="flex items-center justify-between">
            Pilih Toko
            <Badge variant="secondary" className="text-xs">
              {stores.length}
            </Badge>
          </DropdownMenuLabel>
          
          <DropdownMenuSeparator />
          
          <DropdownMenuGroup>
            {stores.map((store) => (
              <DropdownMenuItem
                key={store.id}
                onClick={() => handleStoreChange(store)}
                className="flex flex-col items-start p-3 cursor-pointer"
              >
                <div className="flex items-center gap-2 w-full">
                  <Store className="h-4 w-4 text-blue-600" />
                  <div className="flex-1">
                    <p className="font-medium text-sm">{store.name}</p>
                    {store.address && (
                      <p className="text-xs text-gray-500 truncate">{store.address}</p>
                    )}
                  </div>
                  {currentStore?.id === store.id && (
                    <Badge variant="default" className="text-xs">
                      Aktif
                    </Badge>
                  )}
                </div>
              </DropdownMenuItem>
            ))}
          </DropdownMenuGroup>

          <DropdownMenuSeparator />
          
          <DropdownMenuItem 
            onClick={() => setShowAddModal(true)}
            className="flex items-center gap-2 p-3 cursor-pointer text-blue-600"
          >
            <Plus className="h-4 w-4" />
            <span className="font-medium">Tambah Toko Baru</span>
          </DropdownMenuItem>
        </DropdownMenuContent>
      </DropdownMenu>

      <AddStoreModal
        isOpen={showAddModal}
        onClose={() => setShowAddModal(false)}
        onStoreAdded={handleStoreAdded}
      />
    </>
  );
}