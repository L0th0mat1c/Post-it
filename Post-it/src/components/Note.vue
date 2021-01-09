<template>
  <div>  
      <div class="container mb-5">
          <nav class="navbar navbar-expand-sm bg-dark text-white justify-content-between" >
              <h1 class="Title">Post-it</h1>
              <router-link to="/" class="nav-link"><h3>Accueil</h3></router-link>
          </nav>
          <div class="container-fluid">
            <div class="row">
              <div class="justify-content-between" style="width: 100%">
                <p class="h2" style="text-align: left">Votre Post-it :</p>
                <div class="card text-white bg-dark mb-3" style="width: 100%;">
                  <div class="card-header bg-primary">{{this.notes.title}}</div>
                    <button @click="delNote()" class="btn btn-danger mt-1">Supprimer le Post-it</button>
                    <div v-if="success == 'ok'"> 
                        <input v-model="modTitle" type="text" class="m-2 col-sm-5" placeholder="Entrer votre nouveau titre">
                        <button @click="updateNote(modTitle), modTitle ='', success = null" class="btn btn-success mt-1">Changer le titre</button>
                    </div>
                        <button v-else @click="success = 'ok'" class="btn btn-success mt-1">Mettre à jour le titre</button>
                </div>
                  <div class="card-body">
                    <p class="h3" style="text-align: left">Vos tâches :</p>
                    <div class="row">
                      <div class="bg-dark" v-for="(task, index) in notes.content" :key="task" style="width:100%">
                        <div class="card-body text-dark bg-light">{{ task }}</div><br>
                        <div v-if="success == index">
                        <textarea placceholder="Entrer votre nouvelle tâche" v-model="modTask" type="text" class="m-2" style="width:80%"></textarea>
                        <button @click="updateTask(modTask, index, notes.content, task), modTask ='', success = null" class="btn btn-success mt-1">Mettre à jour votre tâche</button>
                        </div>
                        <button v-else @click="success = index" class="btn btn-success mt-1">Modifier</button>
                      </div>
                    </div>
                  </div>            
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
  name: 'Note',

  data () {
    return {
      dataNote: [],
      temp: '',
      success: null,
      notes: [],
      param: '',
      modTask: '',
      modTitle: ''
    }
  },
  created() {
    this.param = this.$route.params;
    this.getFetch(this.param.id)
  },

  methods: {
    async getFetch(param) {

        var myHeaders = new Headers({'Content-Type': 'application/json'});
        const response = await fetch("http://postit.wac.under-wolf.eu/notes/" + param,{
        method:'GET',
        headers: myHeaders });
        const data = await response.json();
        this.notes = data.note;       
        return this.notes;
    },
    async delFetch(note) {

        var myHeaders = new Headers({'Content-Type': 'application/json'});
        const response = await fetch("http://postit.wac.under-wolf.eu/notes/"+ note._id,{
        method:'DELETE',
        headers: myHeaders });
        const data = await response.json();    
        this.$router.push('/')

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
        let result = response.json();

      },
      async putFetch(post) {
        
        var myHeaders = new Headers({'Content-Type': 'application/json'});
        const response = await fetch("http://postit.wac.under-wolf.eu/notes/" + post._id,{
        method:'PUT',
        headers: myHeaders,
        body: JSON.stringify({
          "title" : post.title,
          "content" : post.content
         })})        
        let result = response.json();
      },
    updateNote () {

      this.$router.push({name: 'Post', params:{data:JSON.stringify(this.notes)}})
    },
    delNote() {

      this.$delete(this.notes, 0)
      this.delFetch(this.notes)
      },
      updateTask(mod, index, note_content, task) {

        note_content.splice(index, 1, mod)
        this.putFetch(this.notes)

        return
      },
      updateNote(modTitle) {

        this.$set(this.notes, 'title', modTitle)
        this.putFetch(this.notes)
      }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>