<template>
  <h1>{{ id }}</h1>
</template>

<script setup lang="ts">
import { useHead } from "@vueuse/head";
defineProps(['id'])
useHead({
  title: 'this is it',
  meta: [
    { name: "omma", content: "lllll" }

  ]
})
</script>