<template>
  <nav
    class="mt-16 flex items-center justify-between bg-white py-3 md:mt-32"
    aria-label="Pagination"
  >
    <div class="hidden sm:block">
      <p class="text-sm text-gray-700">
        Showing
        <span class="font-medium">{{ page * perPage - (perPage - 1) }}</span>
        to
        <span class="font-medium">{{
          page * perPage > totalItems ? totalItems : page * perPage
        }}</span>
        of
        <span class="font-medium">{{ totalItems }}</span>
        {{ totalItems > 1 ? 'Articles' : 'Article' }}
      </p>
    </div>
    <div class="flex flex-1 justify-between sm:justify-end">
      <button
        @click="$emit('getPerviousPage')"
        :disabled="page <= 1"
        class="relative inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-blue-500 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus-visible:outline-offset-0 disabled:cursor-not-allowed disabled:bg-zinc-200 disabled:text-zinc-500"
      >
        Previous
      </button>

      <button
        @click="$emit('getNextPage')"
        :disabled="page === totalPages"
        class="relative ml-3 inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-blue-500 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus-visible:outline-offset-0 disabled:cursor-not-allowed disabled:bg-zinc-300 disabled:text-zinc-500"
      >
        Next
      </button>
    </div>
  </nav>
</template>

<script setup lang="ts">
  defineProps<{
    page: number
    perPage: number
    totalItems: number
    totalPages: number
  }>()
</script>
