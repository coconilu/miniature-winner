import { fileURLToPath } from "url";
import vuetify, { transformAssetUrls } from "vite-plugin-vuetify";

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: "2024-04-03",
  devtools: { enabled: true },
  alias: {
    "@": fileURLToPath(new URL("./src", import.meta.url)),
    imgs: fileURLToPath(new URL("./src/assets/imgs", import.meta.url)),
    "@stores": fileURLToPath(new URL("./stores", import.meta.url)),
  },
  build: {
    transpile: ["vuetify"],
  },
  modules: [
    "@sentry/nuxt/module",
    "@pinia/nuxt",
    (_options: any, nuxt: any) => {
      nuxt.hooks.hook("vite:extendConfig", (config: any) => {
        config.plugins.push(vuetify({ autoImport: true }));
      });
    },
    //...
  ],
  vite: {
    vue: {
      template: {
        transformAssetUrls,
      },
    },
  },
  nitro: {
    // @ts-ignore - 忽略类型检查错误
    unixSocketPath: false,
  },
});
