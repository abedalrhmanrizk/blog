<template>
  <div class="mx-auto w-full max-w-7xl px-4 sm:px-8 lg:px-12">
    <SimpleLayout
      title="Articles"
      intro=""
    >
      <div
        class="mt-10 text-center text-2xl font-bold"
        v-if="pending"
      >
        Loading...
      </div>
      <div
        class="mt-10 text-center text-2xl font-bold"
        v-else-if="error"
      >
        Opps!...
      </div>
      <div v-else="articles">
        <div class="md:border-l md:border-zinc-100 md:pl-6">
          <div class="flex max-w-3xl flex-col space-y-2">
            <ArticleCard
              v-for="article in articles.items"
              :key="article.id"
              :article="article"
            />
          </div>
        </div>
        <Pagination
          @getNextPage="page++"
          @getPerviousPage="page--"
          :page="page"
          :perPage="perPage"
          :totalItems="articles.totalItems"
          :totalPages="articles.totalPages"
        />
      </div>
    </SimpleLayout>
  </div>
</template>

<style scoped></style>

<script lang="ts" setup>
  const page = ref(1)
  const perPage = ref(3)

  const {
    data: articles,
    pending,
    error,
  } = useAsyncData(
    `articles/${page.value}`,
    async () =>
      await pb
        .collection('articles')
        .getList(page.value, perPage.value, { sort: '-created' }),
    { watch: [page, perPage] }
  )
</script>
