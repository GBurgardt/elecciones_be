const environment = process.env.ENVIRONMENT || 'development'
const config = require('../knexfile.js')[environment];
console.log('config')
console.log(config)
module.exports = require('knex')(config);