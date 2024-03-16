<template>
  <footer class="mx-auto mt-auto w-full max-w-7xl flex-none px-4 lg:px-8">
    <div class="border-t border-zinc-100 px-4 pb-16 pt-10 sm:px-8 lg:px-12">
      <div class="flex flex-col items-center justify-between gap-6 md:flex-row">
        <nav>
          <ul
            class="flex flex-wrap justify-center gap-x-6 gap-y-1 text-sm font-medium text-zinc-800"
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

        <p class="text-sm text-zinc-400">
          &copy; {{ new Date().getFullYear() }} PocketBase Blog All rights reserved.
        </p>
      </div>
    </div>
  </footer>
</template>
