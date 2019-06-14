const express = require('express');
const PORT = process.env.PORT || 3001;
const knex = require('./knex/knex.js');
const cors = require('cors')
const app = express();


const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());


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
            const idMesa = req.params.descripcionMesa;
            const idCategoria = req.params.descripcionCategoria;

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
                .catch(
                    err => {
                        console.log('Celular:' + celular);
                        console.log('ERROR')
                        console.log(err)
                    }
                )

        } else {
            return knex('mesa').select('*')
                .then(
                    resp => res.send(resp)
                )
        }

    }
);



app.post(
    '/punto_muestral/:celular',
    (req, res) => 
        knex('punto_muestral')
            .update('registro_ingreso', req.body.registroIngreso)
            .update('horapresencia', knex.raw('GETDATE()'))
            .where('celular', req.params.celular)
            .then(
                resp => res.send({ 
                    status: 'Ok',
                    body: 'Presencia reportada correctamente'
                })
            )
            .catch(
                err => res.status(404).send({ 
                    status: 'Error',
                    body: err
                })
            )
    
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
            .join('candidato', 'candidato.idcategoria', 'categoria.id')
            .join('mesa_candidato', function () {
                this.on('mesa_candidato.idcandidato', '=', 'candidato.id')
                    .andOn('mesa_candidato.idmesa', '=', knex.raw('?', [req.params.idMesa]))
            })
            .join('mesa', 'mesa.id', 'mesa_candidato.idmesa')
            .where(function () {
                this
                    .where('mesa.id', knex.raw('?', [req.params.idMesa]))
                    .andWhere('mesa.idpuntomuestral', knex.raw('?', [req.params.idPuntoMuestral]))
            })
            .then(
                categoriasCargadas => {
                    const categoriasArray = categoriasCargadas.map(a => a.idcategoria);

                    return knex('categoria').select('*')
                        .whereNotIn('id', categoriasArray)
                        .then(
                            resp => res.send(resp)
                        )
                }
            )
            .catch(
                err => console.log(err)
            )
);


/**
 * Retorna TODAS las categorias
 */
app.get(
    '/categorias',
    (req, res) =>
        knex('categoria').select('*')
            .then(
                resp => res.send(resp)
            )
);

/**
 * Retorna TODOS las mesas
 */
app.get(
    '/mesas',
    (req, res) =>
        knex('mesa').select('*')
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


app.post(
    '/mesa-candidato/:descripcionMesa/:descripcionCategoria',
    (req, res, next) => {

        // Primero checkeo que se suba bien la foto. Caso contrario cancelo todo
        upload.single('attachment')(req, res, function (err) {
            if (err instanceof multer.MulterError) {
                console.log(err)
                return res.status('404'.send(err))
            } else if (err) {
                console.log(err)
                return res.status('500'.send(err))
            }

            /**
             * Mapeo el body a un array de promises (todos los insert a la db) que despues resuelvo todos juntos
             */
            const mesasCandidatos = JSON.parse(req.body['mesasCandidatos']);

            const mesasCandidatosPromises = mesasCandidatos
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


            Promise.all(mesasCandidatosPromises)
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


app.get(
    '/resultados/:idCategoria/:idMesa',
    (req, res) =>
        knex.raw(`calculaProyeccion ${req.params.idCategoria}, ${req.params.idMesa}`).then(function(result) {
            res.send(result)
        })
);


app.get(
    '/puntos-informados/:idCategoria',
    (req, res) =>
        knex.raw(`puntosInformadosTotal ${req.params.idCategoria}`).then(function(result) {
            res.send(result)
        })
);

app.get(
    '/admin-sp/:spName',
    (req, res) => { 
        console.log(req.params.spName);

        
        knex.raw(`${req.params.spName}`)
            .then(function(result) {
                res.send(result)
            })
            .catch(function(err) {
                res.status(404).send(err)
            })
    }
);


/**
 * Fin endpoints
 */

app.listen(PORT, () => {
    console.log(`Listening on port: ${PORT}`);
});
