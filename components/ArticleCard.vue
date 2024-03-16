<template>
  <article class="flex gap-20">
    <NuxtLink
      :to="`/articles/${article.id}`"
      class="group relative -inset-x-4 -inset-y-6 flex w-full flex-col items-start rounded-md px-6 py-6 transition hover:bg-blue-50 sm:rounded-2xl"
    >
      <h2 class="text-base font-semibold tracking-tight text-zinc-800">
        {{ article.title }}
      </h2>

      <time
        class="relative z-10 order-first mb-3 flex items-center pl-3.5 text-sm text-blue-400 md:hidden"
        :datetime="formatDate(article.created)"
      >
        <span
          class="absolute left-0 flex items-center"
          aria-hidden="true"
        >
          <span class="h-4 w-0.5 rounded-full bg-blue-200"></span>
        </span>
        {{ formatDate(article.created) }}</time
      >

      <p class="relative mt-2 text-sm text-zinc-600">
        {{ article.description }}
      </p>
      <div
        aria-hidden="true"
        class="relative mt-4 flex items-center text-sm font-medium text-blue-500"
      >
        <span>Read article</span>
        <ChevronRightIcon
          class="ml-1 h-3 w-3 stroke-current transition group-hover:translate-x-1"
        />
      </div>
    </NuxtLink>

    <time
      class="order-first mb-3 mt-1 hidden w-48 text-sm text-zinc-400 md:block"
      :datetime="formatDate(article.created)"
      >{{ formatDate(article.created) }}</time
    >
  </article>
</template>

<script lang="ts" setup>
  import { ChevronRightIcon } from '@heroicons/vue/24/solid'

  defineProps<{
    article: {
      articleContent: string
      created: string
      description: string
      id: string
      title: string
      updated: string
    }
  }>()
</script>
