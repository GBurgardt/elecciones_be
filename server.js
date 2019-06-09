const express = require('express');
const PORT = process.env.PORT || 3001;
const knex = require('./knex/knex.js');
const cors = require('cors')
const app = express();


/**
 * Config multer
 */
const multer = require('multer');

const upload = multer({
    storage: multer.diskStorage({
        destination: function (req, file, cb) {
            console.log("Dest");
            cb(null, 'upload/')
        },
        filename: function (req, file, cb) {
            cb(null, file.fieldname + '-' + Date.now())
        }
    })
})

/**
 * Configura las CORS
 */
app.use(cors())

/**
 * Arrancan endpoints
 */

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


app.get(
    '/punto_muestral/:idPuntoMuestral/mesas',
    (req, res) =>
        knex('mesa').select('*')
            .where('idpuntomuestral', req.params.idPuntoMuestral)
            .then(
                resp => res.send(resp)
            )
);


app.get(
    '/categoria',
    (req, res) =>
        knex('categoria').select('*')
            .then(
                resp => res.send(resp)
            )
);

app.get(
    '/categoria/:idCategoria/candidatos',
    (req, res) =>
        knex('candidato').select('*')
            .where('idcategoria', req.params.idCategoria)
            .then(
                resp => res.send(resp)
            )
);


app.post('/test-upload', upload.single('attachment'), (req, res, next) => {
    res.send({ status: 'ok' })
})


/**
 * Fin endpoints
 */

app.listen(PORT, () => {
    console.log(`Listening on port: ${PORT}`);
});
