const controller = require('../app/controllers/disease')
const post = require('../app/controllers/post')

function initRoutes(app) {
  app.get('/disease-list/internal', controller().diseaseListInternal)
  app.get('/singleDisease/:title', controller().singleDisease)
  app.get('/disease-list/external', controller().diseaseListExternal)
  app.get('/post/:title', post().getpost)
  app.get('/post/upvote/:id', post().upvotee)
  app.get('/post/downvote/:id', post().downvotee)
  app.post('/makepost', post().makepost)
  app.get('/getpost', post().givepost)
}

module.exports = initRoutes
