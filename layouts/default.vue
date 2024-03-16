<template>
  <div class="fixed inset-0 flex justify-center px-4 sm:px-8 lg:px-12">
    <div class="flex w-full max-w-7xl lg:px-8">
      <div class="w-full bg-white ring-1 ring-blue-200" />
    </div>
  </div>
  <div class="relative flex min-h-screen w-full flex-col px-4 sm:px-8 lg:px-12">
    <Navbar />
    <main><slot /></main>
    <Footer />
  </div>
</template>

<style scoped></style>

<script lang="ts" setup>
  useHead({
    titleTemplate: (titleChunk) => {
      return titleChunk ? `${titleChunk} - PocketBase Blog` : 'PocketBase Blog'
    },
  })
</script>
