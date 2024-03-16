<template>
  <div class="mx-auto w-full max-w-7xl px-4 sm:px-8 lg:px-12">
    <NuxtLayout>
      <div class="mt-10 text-center">
        <div class="text-2xl font-bold">
          <p>Opps...!</p>
          <p class="mt-5">The Page you are looking for does not exist!</p>
        </div>
        <NuxtLink
          class="mt-12 block text-blue-500"
          to="/"
          >Go home</NuxtLink
        >
      </div>
    </NuxtLayout>
  </div>
</template>
<script setup lang="ts">
  definePageMeta({
    layout: 'default',
  })
</script>
