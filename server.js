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

app.get(
    '/punto_muestral/:celular', 
    (req, res) => {

        const celular = req.params ? req.params.celular : null;

        // Si SI tiene celular, filtro por el. Caso contrario, busco todos los punto_muestral
        if (celular) {
            return knex('punto_muestral').select('*')
                .where('celular', celular)
                .then(
                    resp => res.send(resp)
                )

        } else {
            return knex('mesa').select('*')
                .then(
                    resp => res.send(resp)
                )
        }

    }
);

app.listen(PORT, () => {
    console.log(`Listening on port: ${PORT}`);
});
