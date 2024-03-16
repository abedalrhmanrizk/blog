<template>
  <div class="mb-4 mt-16 px-4 sm:px-8 lg:px-12">
    <header class="max-w-2xl">
      <h1 class="text-4xl font-bold tracking-tight text-zinc-800 sm:text-5xl">
        {{ title }}
      </h1>
      <p class="mt-6 text-base text-zinc-600">{{ intro }}</p>
    </header>

    <div class="mt-16 sm:mt-20"><slot /></div>
  </div>
</template>

<script setup lang="ts">
  defineProps<{
    title: string
    intro: string
  }>()
</script>
