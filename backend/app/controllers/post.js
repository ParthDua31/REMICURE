const Post = require('../models/post')
const Disease = require('../models/disease')

function post() {
  return {
    async upvotee(req, res) {
      const postId = req.params.id
      const post = await Post.findById(postId)
      post.upvote = post.upvote + 1
      post.totalvotes = post.totalvotes + 1
      post.save()
      res.json(post)
    },
    getpost(req, res) {
      const title = req.params.title

      Post.find({ title: title })
        .sort('-upvote')
        .then((post) => {
          console.log(post)
          return res.json(post)
        })
    },
    async downvotee(req, res) {
      const postId = req.params.id
      const post = await Post.findById(postId)
      post.upvote = post.upvote - 1
      post.totalvotes = post.totalvotes + 1

      post.save()
      res.json(post)
    },
    async makepost(req, res) {
      console.log('request accepted')
      const title = req.body.title
      const body = req.body.body
      const category = req.body.category
      const usermail = req.body.usermail
      let diseas = await Disease.find({ title: title })
      console.log(diseas)
      if (diseas.length === 0) {
        const diseasee = await Disease.insertMany([
          {
            title,
            category
          }
        ])
        console.log(diseasee)
      }
      const post = new Post({
        title,
        body,
        category,
        usermail,
        upvote: 0,
        downvote: 0,
        totalvotes: 0,
        verified: false
      })
      post.save()
      res.json(post)
    },
    givepost(req, res) {
      Post.find({}).then((post) => {
        console.log(post[0])
        return res.json(post[0])
      })
    }
  }
}

module.exports = post
