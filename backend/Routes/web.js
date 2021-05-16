const controller = require('../app/controllers/disease')


function initRoutes(app) {
  app.get('/disease-list/internal', controller().diseaseListInternal)
  app.get('/singleDisease/:title', controller().singleDisease)
  app.get('/disease-list/external', controller().diseaseListExternal)
  app.get('/post/:title', post().getpost)

}

module.exports = initRoutes
