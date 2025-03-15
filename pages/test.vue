<template>
  <div class="test-page">
    <h1>测试页面</h1>
    <p>这是一个简单的测试页面，用于验证路由系统是否正常工作。</p>
    <div class="links">
      <NuxtLink to="/" class="link">返回首页</NuxtLink>
      <NuxtLink to="/overview" class="link">前往概览页</NuxtLink>
    </div>
  </div>
</template>

<style scoped>
.test-page {
  max-width: 800px;
  margin: 0 auto;
  padding: 2rem;
  text-align: center;
}

h1 {
  color: #2c3e50;
  margin-bottom: 1rem;
}

.links {
  display: flex;
  justify-content: center;
  gap: 1rem;
  margin-top: 2rem;
}

.link {
  display: inline-block;
  padding: 0.5rem 1rem;
  background-color: #3498db;
  color: white;
  text-decoration: none;
  border-radius: 4px;
}
</style>
