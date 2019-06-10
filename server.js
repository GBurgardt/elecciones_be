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
            const idMesa = req.params.idMesa;
            const idCategoria = req.params.idCategoria;

            cb(null, `mesa-${idMesa}_categoria-${idCategoria}_date-${Date.now()}`)
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

/**
 * Filtro las categorias DE ESA MESA que ya se han votado
 *  */
app.get(
    '/punto_muestral/:idPuntoMuestral/mesas/:idMesa/categorias',
    (req, res) => 

        knex('categoria').select('idcategoria').distinct()
            .join('candidato', 'candidato.idcategoria', '=', 'categoria.id')
            .join('mesa_candidato', function () {
                this
                    .on('mesa_candidato.idcandidato', '=', 'candidato.id')
                    .andOn('mesa_candidato.idmesa', '=', req.params.idMesa)
            })
            .join('mesa', 'mesa.id', '=', 'mesa_candidato.idmesa')
            .where(function () {
                this
                    .where('mesa.id', req.params.idMesa)
                    .andWhere('mesa.idpuntomuestral', req.params.idPuntoMuestral)
            })
            .then(
                categoriasCargadas => 
                    knex('categoria').select('*')
                        .whereNotIn('id', categoriasCargadas)
                        .then(
                            resp => res.send(resp)
                        )
            )
        
//     select distinct categoria.id from categoria
//         inner join candidato 
//             on candidato.idcategoria = categoria.id
//         inner join mesa_candidato
//             on (
//                 mesa_candidato.idcandidato = candidato.id and
//                 mesa_candidato.idmesa = 1
//             )
//         inner join mesa 
//             on mesa.id = mesa_candidato.idmesa
//     where     
//         mesa.id = 1 and 
//         mesa.idpuntomuestral = 1

    

    

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


app.post(
    '/mesa-candidato/:idMesa/:idCategoria',
    (req, res, next) => {

        // Primero checkeo que se suba bien la foto. Caso contrario cancelo todo
        upload.single('attachment')(req, res, function (err) {
            if (err instanceof multer.MulterError) {
                return res.status('404'.send(err))
            } else if (err) {
                return res.status('500'.send(err))
            }

            /**
             * Mapeo el body a un array de promises (todos los insert a la db) que despues resuelvo todos juntos
             */
            const mesasCandidatos = JSON.parse(req.body['mesasCandidatos'])
                .map(
                    mc => ({
                        idmesa: mc.mesa.id,
                        idcandidato: mc.candidato.id,
                        cantidadvotos: mc.cantidadVotos
                    })
                )
                .map(
                    m => knex('mesa_candidato').insert(m)
                )


            Promise.all(mesasCandidatos)
                .then(
                    resp => res.send({
                        status: 'ok'
                    })
                )
                .catch(
                    err => res.status(404).send({
                        status: 'error',
                        body: err
                    })
                )

        })


    }
)


/**
 * Fin endpoints
 */

app.listen(PORT, () => {
    console.log(`Listening on port: ${PORT}`);
});
