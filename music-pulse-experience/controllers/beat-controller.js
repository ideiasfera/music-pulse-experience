const mysql = require('../mysql').pool;

exports.getBeat = (req, res, next) => {
    mysql.getConnection((error, conn) => {
        if (error) { return res.status(500).send({ error: error }) }
        conn.query( `SELECT * FROM beat;`,
            (error, result, fields) => {
                if (error) { return res.status(500).send({ error: error }) }
                const response = {
                    beats: result.map(beat => {
                        return {
                            beatId: beat.beatId,
                            beatperminute: beat.beatperminute,
                            users: beat.users,
                            dateregister: beat.dateregister
                        }
                    })
                }
                return res.status(200).send(response);
            }
        )
    });
};

exports.postBeat = (req, res, next) => {

    mysql.getConnection((error, conn) => {
        if (error) { return res.status(500).send({ error: error }) }
        conn.query('SELECT * FROM users WHERE userId = ?',
        [req.body.users],
        (error, result, field) => {
            if (error) { return res.status(500).send({ error: error }) }
            if (result.length == 0) {
                return res.status(404).send({
                    message: 'Usuário não encontrado'
                })
            }
			
			const dataautal = new Date().toISOString().replace(/T/, ' ').replace(/\..+/, '');
            conn.query(
                'INSERT INTO beat (beatperminute, users, dateregister) VALUES (?,?,?)',
                [req.body.beatperminute, req.body.users, dataautal],

                (error, result, field) => {
                    conn.release();
                    if (error) { return res.status(500).send({ error: error }) }
                    const response = {
                        message: 'Batimento inserido com sucesso',
                        createdBeat: {
                            beatId: result.insertId,
                            beatperminute : req.body.beatperminute,
                            users: req.body.users,
                            dateregister: dataautal
                        }
                    }
                    return res.status(201).send(response);
                }
            )

        })
    });
};

exports.getBeatDetail = (req, res, next)=> {
    mysql.getConnection((error, conn) => {
        if (error) { return res.status(500).send({ error: error }) }
        conn.query(
            'SELECT * FROM beat WHERE beatId = ?;',
            [req.params.beatId],
            (error, result, fields) => {
                if (error) { return res.status(500).send({ error: error }) }
                if (result.length == 0) {
                    return res.status(404).send({
                        message: 'Não foi encontrado batimento com este ID'
                    })
                }
                const response = {
                    beat: {
                        beatId: result[0].beatId,
                        beatperminute: result[0].beatperminute,
                        users: result[0].users,
                        dateregister: result[0].dateregister
                    }
                }
                return res.status(200).send(response);
            }
        )
    });
};

exports.putBeat = (req, res, next) => {

    mysql.getConnection((error, conn) => {
        if (error) { return res.status(500).send({ error: error }) }
        conn.query('SELECT * FROM users WHERE userId = ?',
        [req.body.users],
        (error, result, field) => {
            if (error) { return res.status(500).send({ error: error }) }
            if (result.length == 0) {
                return res.status(404).send({
                    message: 'Usuário não encontrado'
                })
            }
			
			const dataautal = new Date().toISOString().replace(/T/, ' ').replace(/\..+/, '');
            conn.query(
                'UPDATE beat SET beatperminute = ?, users = ?, dateregister = ? WHERE beat.beatId = ?;',
                [req.body.beatperminute, req.body.users, dataautal, req.params.beatId],
                (error, result, field) => {
                    conn.release();
                    if (error) { return res.status(500).send({ error: error }) }
                    const response = {
                        message: 'Batimento atualizado com sucesso',
                        updateBeat: {
                            beatId: req.params.beatId,
                            beatperminute : req.body.beatperminute,
                            users: req.body.users,
                            dateregister: dataautal
                        }
                    }
                    return res.status(201).send(response);
                }
            )

        })
    });
};

exports.deleteBeat = (req, res, next) => {
    mysql.getConnection((error, conn) => {
        if (error) { return res.status(500).send({ error: error }) }
        conn.query(
            `DELETE FROM beat WHERE beatId = ?`, [req.params.beatId],
            (error, result, field) => {
                conn.release();
                if (error) { return res.status(500).send({ error: error }) }
                const response = {
                    message: 'Batimento removido com sucesso'
                }
                return res.status(202).send(response);
            }
        )
    });
};
