module.exports = {
    development: {
        client: 'mssql',
        connection: {
            host: '192.168.254.115',
            // host: 'localhost',
            user: 'SA',
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