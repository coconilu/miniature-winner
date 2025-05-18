// VDOM检查工具

/**
 * 递归分析VNode结构并返回简化的描述
 */
function inspectVNode(vnode: any, depth = 0, maxDepth = 3): any {
  if (!vnode) return null;
  if (depth > maxDepth) return '(达到最大深度)';
  
  // 提取基本信息
  const result: any = {
    type: typeof vnode.type === 'string' 
      ? vnode.type 
      : (vnode.type?.name || vnode.type?.displayName || '(组件)'),
    key: vnode.key,
    ref: vnode.ref !== undefined ? '(有ref)' : undefined,
  };
  
  // 提取props
  if (vnode.props) {
    result.props = Object.keys(vnode.props).slice(0, 5);
    if (Object.keys(vnode.props).length > 5) {
      result.props.push('...(更多)');
    }
  }
  
  // 处理子节点
  if (Array.isArray(vnode.children) && vnode.children.length > 0) {
    result.children = vnode.children.slice(0, 3).map((child: any) => 
      typeof child === 'object' ? inspectVNode(child, depth + 1, maxDepth) : String(child).substring(0, 20)
    );
    
    if (vnode.children.length > 3) {
      result.children.push(`...(还有${vnode.children.length - 3}个子节点)`);
    }
  } else if (vnode.children && typeof vnode.children === 'object') {
    result.children = inspectVNode(vnode.children, depth + 1, maxDepth);
  } else if (vnode.children) {
    result.children = String(vnode.children).substring(0, 20);
    if (String(vnode.children).length > 20) result.children += '...';
  }
  
  // 其他有用的信息
  if (vnode.component) {
    result.componentInstance = '(有组件实例)';
  }
  
  // 移除undefined的属性
  Object.keys(result).forEach(key => {
    if (result[key] === undefined) {
      delete result[key];
    }
  });
  
  return result;
}

// 导出工具函数
export default defineNuxtPlugin(() => {
  return {
    provide: {
      inspectVNode
    }
  };
}); 