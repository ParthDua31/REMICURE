const express = require('express')
const mongoose = require('mongoose')

const app = express()
app.use(express.json())

mongoose.connect(process.env.MONGO_URL, {
  useNewUrlParser: true,
  useCreateIndex: true,
  useUnifiedTopology: true,
  useFindAndModify: false
})

const connection = mongoose.connection

connection.once('open', () => {
  console.log('Database connection established')
})

// routes
// home
app.get('/', (req, res) => {
  res.json({
    connected: true
  })
})

require('./Routes/web')(app)

app.listen(process.env.PORT, () => {
  console.log(`Server up on port ${process.env.PORT}`)
})
