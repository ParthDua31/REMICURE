const express = require('express')
const mongoose = require('mongoose')
var multer = require('multer')

const app = express()
app.use(express.json())

var storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads')
  },
  filename: (req, file, cb) => {
    cb(null, file.fieldname + '-' + Date.now())
  }
})

var upload = multer({ storage: storage })

mongoose.connect(process.env.MONGO_URL, {
  useNewUrlParser: true,
  useCreateIndex: true,
  useUnifiedTopology: true,
  useFindAndModify: false
})

const connection = mongoose.connection

connection.once('open', () => {
  console.log('Established')
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
  console.log('Node connected')
})
