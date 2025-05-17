<template>
  <div class="index-page">
    <h1>欢迎使用我们的应用</h1>
    <div class="navigation">
      <NuxtLink 
        v-for="(entry, index) in entries" 
        :key="index" 
        :to="entry.path" 
        class="nav-link"
      >
        {{ entry.title }}
      </NuxtLink>
    </div>
    <p class="description">
      这是应用的首页。您可以通过上面的链接导航到不同的页面。
    </p>
  </div>
</template>

<script setup lang="ts">
import { useCommonStore } from '@stores/common'

// 使用 Pinia store
const commonStore = useCommonStore()
const entries = commonStore.getEntries
</script>

<style scoped>
.index-page {
  max-width: 800px;
  margin: 0 auto;
  padding: 2rem;
  text-align: center;
}

h1 {
  font-size: 2rem;
  margin-bottom: 2rem;
  color: #2c3e50;
}

.navigation {
  display: flex;
  justify-content: center;
  gap: 1rem;
  margin-bottom: 2rem;
}

.nav-link {
  display: inline-block;
  padding: 0.75rem 1.5rem;
  background-color: #3498db;
  color: white;
  text-decoration: none;
  border-radius: 4px;
  font-weight: bold;
  transition: background-color 0.3s;
}

.nav-link:hover {
  background-color: #2980b9;
}

.description {
  font-size: 1.1rem;
  color: #7f8c8d;
  line-height: 1.6;
}
</style>
