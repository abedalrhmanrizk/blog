<template>
  <div class="mx-auto w-full max-w-7xl px-4 sm:px-8 lg:px-12">
    <SimpleLayout
      title="Latest Articles"
      intro=""
    >
      <div v-if="pending">
        <p>Loading...</p>
      </div>
      <div v-else-if="error">
        <p>Opps! something error happen</p>
      </div>
      <div v-else>
        <div class="md:border-l md:border-zinc-100 md:pl-6">
          <div class="flex max-w-3xl flex-col space-y-2">
            <ArticleCard
              v-for="article in articles"
              :key="article.id"
              :article="article"
            />
          </div>
        </div></div
    ></SimpleLayout>
  </div>
</template>

<style scoped></style>

<script lang="ts" setup>
  useHead({
    title: 'Latest Articles',
  })

  const {
    data: articles,
    pending,
    error,
  } = useAsyncData('articles', async () =>
    (await pb.collection('articles').getFullList({ sort: '-created' })).slice(0, 3)
  )
</script>
