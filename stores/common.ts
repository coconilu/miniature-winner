import { defineStore } from 'pinia'

interface Entry {
  title: string
  path: string
}

export const useCommonStore = defineStore('entries', {
  state: () => ({
    entries: [
      { title: '概览', path: '/overview' },
      { title: '仪表盘', path: '/dashboard' }
    ] as Entry[]
  }),
  
  getters: {
    getEntries: (state) => state.entries
  },
  
  actions: {
    addEntry(entry: Entry) {
      this.entries.push(entry)
    },
    removeEntry(index: number) {
      this.entries.splice(index, 1)
    }
  }
}) 