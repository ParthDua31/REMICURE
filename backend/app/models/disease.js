const mongoose = require('mongoose')

const Schema = mongoose.Schema

const diseaseSchema = Schema({
  title: { type: String, required: true },
  category: { type: String, required: true },
  description: { type: String, default: 'aa' },
  link: { type: String, default: 'aa' }
})

const Disease = mongoose.model('Disease', diseaseSchema)

module.exports = Disease
