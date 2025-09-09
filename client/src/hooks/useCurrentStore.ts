import { useState, useEffect } from 'react';

interface Store {
  id: string;
  name: string;
  address?: string;
  phone?: string;
}

// Global store untuk current store state
let globalCurrentStore: Store | null = null;
const listeners: Set<(store: Store | null) => void> = new Set();

function notifyListeners() {
  listeners.forEach(listener => listener(globalCurrentStore));
}

export function getCurrentStore(): Store | null {
  return globalCurrentStore;
}

export function setCurrentStore(store: Store | null) {
  globalCurrentStore = store;
  if (store) {
    localStorage.setItem('currentStoreId', store.id);
  } else {
    localStorage.removeItem('currentStoreId');
  }
  notifyListeners();
}

export function useCurrentStore() {
  const [currentStore, setCurrentStoreState] = useState<Store | null>(globalCurrentStore);

  useEffect(() => {
    const listener = (store: Store | null) => {
      setCurrentStoreState(store);
    };
    
    listeners.add(listener);
    
    return () => {
      listeners.delete(listener);
    };
  }, []);

  // Initialize from localStorage if not set
  useEffect(() => {
    if (!globalCurrentStore) {
      const savedStoreId = localStorage.getItem('currentStoreId');
      if (savedStoreId) {
        // Try to fetch store info
        fetch('/api/stores')
          .then(res => res.json())
          .then(stores => {
            const store = stores.find((s: Store) => s.id === savedStoreId);
            if (store) {
              setCurrentStore(store);
            }
          })
          .catch(console.error);
      }
    }
  }, []);

  return {
    currentStore,
    setCurrentStore
  };
}