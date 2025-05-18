export default defineNuxtPlugin((nuxtApp) => {
  // 获取Vue实例
  const vueApp = nuxtApp.vueApp;
  
  // 打印Vue实例到控制台
  console.log('Vue全局实例，createApp:', vueApp);
  
  // 如果需要在组件中访问
  return {
    provide: {
      vueInstance: vueApp
    }
  }
}); 