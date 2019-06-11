module.exports = {
    development: {
        client: 'mssql',
        connection: {
            // host: '165.22.198.233',
            // host: '192.168.254.115',
            host: 'localhost',
            user: 'SA',
            // password: 'Hesoyam666',
            password: 'Alberdi11',
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