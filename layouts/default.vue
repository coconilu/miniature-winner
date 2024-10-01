<template>
  <div class="column">
    <slot />
  </div>
</template>
<style scoped>
.column {
  display: flex;
  flex-direction: column;
  align-items: stretch;
}
</style>
