<template>
  <div class="mx-auto w-full max-w-7xl px-4 sm:px-8 lg:px-12">
    <div
      class="mt-10 text-center text-2xl font-bold"
      v-if="pending"
    >
      Loading...
    </div>
    <div
      class="mt-10 text-center"
      v-else-if="error"
    >
      <div class="text-2xl font-bold">
        <p>Opps...!</p>
        <p class="mt-5">The article you are looking for does not exist!</p>
      </div>
      <NuxtLink
        class="mt-12 block text-blue-500"
        to="/"
        >Go home</NuxtLink
      >
    </div>
    <div
      v-else
      class="relative"
    >
      <div class="mx-auto max-w-2xl">
        <button
          @click="router.back()"
          type="button"
          aria-label="Go back to articles"
          class="group mb-8 flex h-10 w-10 items-center justify-center rounded-full bg-white shadow-md shadow-zinc-800/5 ring-1 ring-zinc-900/5 transition lg:absolute lg:-left-9 lg:-mt-2 lg:mb-0 xl:-top-1.5 xl:left-0 xl:mt-0"
        >
          <ArrowLongLeftIcon
            class="h-4 w-4 stroke-blue-500 transition group-hover:stroke-blue-700"
          />
        </button>
        <article>
          <header class="flex flex-col">
            <h1 class="mt-6 text-4xl font-bold tracking-tight text-zinc-800 sm:text-5xl">
              {{ article.title }}
            </h1>
            <time
              dateTime="{{article.created}}"
              class="order-first flex items-center text-base text-zinc-400"
            >
              <span class="h-4 w-0.5 rounded-full bg-zinc-200" />
              <span class="ml-3">{{ formatDate(article.created) }}</span>
            </time>
          </header>
          <div
            class="content my-10"
            v-html="article.content"
          ></div>
        </article>
      </div>
    </div>
  </div>
</template>

<style scoped></style>

<script lang="ts" setup>
  import { ArrowLongLeftIcon } from '@heroicons/vue/24/solid'

  const router = useRouter()
  const route = useRoute()

  const { id } = route.params

  const {
    data: article,
    error,
    pending,
  } = useLazyAsyncData(
    `articles/${id}`,
    async () => await pb.collection('articles').getOne(String(id))
  )
</script>
