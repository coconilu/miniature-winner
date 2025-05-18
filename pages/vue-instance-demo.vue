<template>
  <div>
    <h1>Vue实例演示</h1>
    <v-btn @click="printVueInstance" color="primary" class="mr-4">打印Vue实例</v-btn>
    <v-btn @click="printVdom" color="success" class="mr-4">打印VDOM信息</v-btn>
    <v-btn @click="inspectFullVdom" color="info">检查全部VDOM</v-btn>
    
    <v-card class="mt-4 pa-4">
      <v-card-title>VDOM展示区域</v-card-title>
      <div ref="demoRef">
        <p>这是一个测试元素</p>
        <span>用于展示VDOM</span>
        <v-list>
          <v-list-item v-for="i in 3" :key="i">
            列表项 {{ i }}
          </v-list-item>
        </v-list>
      </div>
    </v-card>
    
    <v-card v-if="vdomInfo" class="mt-4 pa-4">
      <v-card-title>VDOM分析结果</v-card-title>
      <pre class="overflow-auto pa-2 bg-grey-lighten-4">{{ JSON.stringify(vdomInfo, null, 2) }}</pre>
    </v-card>
  </div>
</template>

<script setup lang="ts">
import { getCurrentInstance, ref, nextTick, onMounted, reactive } from 'vue';

// 创建一个引用，用于获取DOM元素
const demoRef = ref(null);
// 存储VDOM信息
const vdomInfo = ref<any>(null);

// 方法一：使用getCurrentInstance()获取当前实例
const instance = getCurrentInstance();
const printVueInstance = () => {
  // 打印当前组件实例
  console.log('当前组件实例:', instance);
  
  // 打印全局Vue应用实例
  console.log('全局Vue应用实例:', instance?.appContext.app);
  
  // 使用插件提供的Vue实例
  const { $vueInstance } = useNuxtApp();
  console.log('插件提供的Vue实例:', $vueInstance);
};

// 打印VDOM相关信息
const printVdom = async () => {
  // 确保DOM已更新
  await nextTick();
  
  if (instance) {
    // 获取组件的vnode
    const vnode = instance.vnode;
    console.log('当前组件的VNode:', vnode);
    
    // 获取子树信息
    console.log('组件子树:', instance.subTree);
    
    // 不是所有内部属性都能直接访问，需要使用类型断言
    console.log('组件实例内部:', instance.proxy);
    
    // 获取DOM元素对应的VNode
    if (demoRef.value) {
      console.log('DOM元素:', demoRef.value);
      // 使用类型断言解决类型问题
      console.log('DOM元素内部HTML:', (demoRef.value as HTMLElement).innerHTML);
    }
    
    // 获取应用实例中的一些内部信息
    const nuxtApp = useNuxtApp();
    const vueApp = nuxtApp.vueApp;
    // 尝试访问一些Vue内部属性（注意：这些是内部实现，可能会改变）
    console.log('Vue应用实例内部组件:', (vueApp as any)._component);
    console.log('Vue应用挂载点:', (vueApp as any)._container);
    
    // 尝试获取更多内部信息（使用类型断言）
    const vueContext = (vueApp as any)._context || {};
    console.log('Vue应用内部属性:', {
      components: vueContext.components,
      directives: vueContext.directives,
      mixins: vueContext.mixins,
      provides: vueContext.provides
    });
  }
};

// 使用VDOM检查工具检查整个应用的VDOM
const inspectFullVdom = async () => {
  await nextTick();
  
  const nuxtApp = useNuxtApp();
  const { $inspectVNode } = nuxtApp;
  
  if (instance && $inspectVNode) {
    try {
      // 检查当前组件的VNode
      // 使用类型断言处理类型问题
      const inspectFn = $inspectVNode as (vnode: any, depth?: number, maxDepth?: number) => any;
      const componentVNodeInfo = inspectFn(instance.vnode, 0, 4);
      console.log('组件VNode详细结构:', componentVNodeInfo);
      
      // 检查应用程序根VNode
      const vueApp = nuxtApp.vueApp;
      const rootVNode = (vueApp as any)._instance?.subTree;
      
      if (rootVNode) {
        console.log('应用程序根VNode:', rootVNode);
        const rootVNodeInfo = inspectFn(rootVNode, 0, 5);
        console.log('应用程序根VNode详细结构:', rootVNodeInfo);
        
        // 在UI中显示
        vdomInfo.value = {
          component: componentVNodeInfo,
          application: rootVNodeInfo
        };
      } else {
        console.log('无法访问应用程序根VNode');
        vdomInfo.value = { component: componentVNodeInfo };
      }
    } catch (error) {
      console.error('检查VDOM时出错:', error);
    }
  }
};

onMounted(() => {
  console.log('组件已挂载，DOM元素:', demoRef.value);
});
</script>

<style scoped>
pre {
  max-height: 400px;
  white-space: pre-wrap;
}
</style> 