<template>
  <v-layout class="rounded rounded-md">
    <v-navigation-drawer>
      <v-list>
        <v-list-item title="Navigation drawer"></v-list-item>
      </v-list>
    </v-navigation-drawer>

    <v-app-bar title="Application bar"></v-app-bar>

    <v-main class="d-flex align-stretch mt-6" style="min-height: 300px">
      <v-expansion-panels>
        <v-expansion-panel
          title="Title"
          text="Lorem ipsum dolor sit amet consectetur adipisicing elit. Commodi, ratione debitis quis est labore voluptatibus! Eaque cupiditate minima"
        >
        </v-expansion-panel>
      </v-expansion-panels>
    </v-main>
  </v-layout>
</template>
