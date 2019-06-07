const express = require('express');
const PORT = process.env.PORT || 3001;
const knex = require('./knex/knex.js');
const cors = require('cors')
const app = express();

/**
 * Configura las CORS
 */
app.use(cors())


/**
 * Arrancan endpoints
 */
app.get(
    '/categorias', 
    (req, res) => 
        knex('categoria').select('*')
            .then(
                resp => res.send(resp)
            )
);

app.get(
    '/mesas', 
    (req, res) => 
        knex('mesa').select('*')
            .then(
                resp => res.send(resp)
            )
);

app.listen(PORT, () => {
    console.log(`Listening on port: ${PORT}`);
});
