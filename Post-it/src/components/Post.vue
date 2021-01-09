<template>
  <div>
    <div class="container mb-5">
      <nav class="navbar navbar-expand-sm bg-dark text-white  justify-content-between" >
            <h1 class="Title">{{ title }}</h1>
            <!-- Ajouter un nouveau post-it-->
          <button type="button" class="btn btn-primary" @click="addedPost = true">Ajouter un Post</button>
        <div v-if="addedPost" class="mt-1">
            <input type="text" v-model="temp" @keyup.enter="addPost(notes, temp), temp = '', addedPost = false">
          </div>
      </nav>
      <div class="row">
        <div class="col-sm-2">
        </div>
      </div>
    </div>
    <p v-if="!notes.length">Pas de post-it !</p>
    <div class="container-fluid" v-if="notes.length">
      <div class="row">
        <div class="col-sm-2" v-for="(post, index) in notes" :key="post._id">
          <div class="card text-white bg-dark mb-3" style="max-width: 30rem;">
            <div class="card-header bg-primary">{{post.title}}</div>
            <div class="card-body" v-for="(cont) in post.content" :key="cont">
              <p class="card-text text-dark bg-light rounded text-left pl-2">{{cont}}</p>
              <button @click="delNote(post.content, cont, post)" class="btn btn-danger mt-1">Supprimer</button>
            </div>
            <div v-if=" success == index">
              <textarea type="text" class="m-3" v-model="temp"></textarea><br>
                <button @click="addTask(post, temp), temp = '', success = null" class="btn btn-primary">Ajouter tâche</button>
              
            </div>
            <button type="button" class="btn btn-secondary mt-5" @click="success = index">Ajouter tâche</button>
            <button @click="editPost(index)" class="btn btn-danger mt-1">Modifier</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
/* eslint-disable */
export default {
/* eslint-disable */
    name: 'Post',
    data() {
      return {
        title: 'Post-It',
        success: null,
        addedPost: false,
        temp: '',
        notes: [],
        error: ''
      }
    },
    created() {
      this.getFetch();

    },
    mounted() {
      
    },
    methods: {
      async getFetch() {
    
          var myHeaders = new Headers({'Content-Type': 'application/json'});
          const response = await fetch("http://postit.wac.under-wolf.eu/notes" ,{
          method:'GET',
          headers: myHeaders });
          if(response.status == 200) {
          const data = await response.json();
          this.notes = data.notes;
          return this.notes;
          }
      },
      async postFetch(newPost) {

        var myHeaders = new Headers({'Content-Type': 'application/json'});
        const response = await fetch("http://postit.wac.under-wolf.eu/notes",{
        method:'POST',
        headers: myHeaders,
        body: JSON.stringify({
          "title" : newPost.title,
          "content" : newPost.content
         })})
         if(response.status == 200) {        
        let result = response.json(); 
        }
      },
      async putFetch(post) {

        var myHeaders = new Headers({'Content-Type': 'application/json'});
        const response = await fetch("http://postit.wac.under-wolf.eu/notes/"+ post._id,{
        method:'PUT',
        headers: myHeaders,
        body: JSON.stringify({
          "title" : post.title,
          "content" : post.content
         })}) 
         if(response.status == 200) {       
        let result = response.json();
        }
      },   
      addPost(notes, temp) {     
        const newPost = {
          title: temp,
          content: []
        };
        notes.push(newPost);
        this.postFetch(newPost);
        this.getFetch()
        
      },

      addTask(post, temp) {
        let test = post.content
        test.push(temp);
        this.putFetch(post)
      },

      editPost(index) {
        let test = this.notes[index];
        this.$router.push({name: 'Note', params:{ id: test._id}})       
      },

      delNote(post_content, count, post) {
        let cible = post_content.findIndex(target => target == count)
        post_content.splice(cible, 1)
        this.putFetch(post)
      }
    }
  }

</script>

<style scoped>
 
</style>