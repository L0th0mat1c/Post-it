import Vue from 'vue'
import Router from 'vue-router'
import Post from '@/components/Post'
import Note from '@/components/Note'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Post',
      component: Post
    },
    {
      path: '/notes/:id',
      name: 'Note',
      component: Note
    }
  ]
})
