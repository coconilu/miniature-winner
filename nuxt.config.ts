import { fileURLToPath } from "url";

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: "2024-04-03",
  devtools: { enabled: true },
  alias: {
    "@": fileURLToPath(new URL("./src", import.meta.url)),
    imgs: fileURLToPath(new URL("./src/assets/imgs", import.meta.url)),
  },
});
