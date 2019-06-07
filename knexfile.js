module.exports = {
    development: {
        client: 'mssql',
        connection: {
            host: '165.22.198.233',
            user: 'SA',
            password: 'Hesoyam666',
            database: 'elecciones_db'
        },
        migrations: {
            directory: __dirname + '/knex/migrations',
        },
        seeds: {
            directory: __dirname + '/knex/seeds'
        }
    }
  }