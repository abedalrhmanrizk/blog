<template>
  <nav
    class="mx-auto top-0 z-10 sticky mb-6 flex w-full max-w-7xl justify-center px-4 py-6 sm:px-8 lg:px-12"
  >
    <ul
      class="flex rounded-full bg-white/90 px-3 py-1 text-sm font-medium text-zinc-800 shadow-lg shadow-zinc-800/5 ring-1 ring-blue-200 ring-zinc-900/5 backdrop-blur"
    >
      <li
        v-for="link in links"
        :key="link.name"
      >
        <NuxtLink
          :to="link.href"
          class="relative block px-3 py-2 text-zinc-600 transition hover:text-blue-500"
        >
          {{ link.name }}
        </NuxtLink>
      </li>
    </ul>
  </nav>
</template>

<style scoped></style>

<script lang="ts" setup></script>
