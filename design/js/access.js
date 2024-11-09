const express = require("express");
const client = require("./db");
const router = express.Router();


async function getEspecialesByDoctor(id_usuario) {
    const query=`
        SELECT de.id_especialidad 
        FROM doctor_especialidad de
        WHERE de.id_doctor = (SELECT id_doctor FROM doctor WHERE id_usuario = ${id_usuario})
    `;
    const result = await client.query(query);

    return result.rows.map(row => row.id_especialidad);
}



// Obtener el listado de accesos que un usuario aun no ha solicitado
router.get("/list/faltantes/usuario/:id_usuario/paciente/:id_paciente", async (req, res) => {
    const { id_usuario, id_paciente } = req.params;

    try {
        
    const query = `
        SELECT acc.id_acessos as id_accesos, acc.modulo, acc.estado, acc.id_especialidad
        FROM accesos acc
        LEFT JOIN accesos_usuario au ON acc.id_acessos = au.id_accesos AND au.id_usuario = ${id_usuario} AND au.id_paciente = ${id_paciente}
        WHERE au.id_accesos IS NULL
        ORDER BY acc.modulo ASC
    `;

    const result = await client.query(query);

        res.json(result.rows);
    } catch (error) {
        console.error("Error al obtener el listado de accesos:", error);
        res.status(500).send("Error al obtener el listado de accesos");
    }
});



// Obtener el listado de accesos que un usuario ya ha solicitado
router.get("/list/solicitadas/usuario/:id_usuario/paciente/:id_paciente", async (req, res) => {
    const { id_usuario, id_paciente } = req.params;
    const accesos_usuario = []

    try {
        const query_accesos_solicitados = `
            SELECT au.id_acc_usuario, au.id_accesos, au.estado, acc.modulo, acc.id_especialidad, MAX(con.fecha_hora) AS fecha_ultima_consulta
            FROM accesos_usuario au
            JOIN accesos acc ON au.id_accesos = acc.id_acessos
            LEFT JOIN consulta con ON con.id_especialidad = acc.id_especialidad AND con.id_paciente = ${id_paciente}
            WHERE au.id_usuario = ${id_usuario} AND au.id_paciente = ${id_paciente}
            GROUP BY au.id_acc_usuario, au.id_accesos, acc.id_especialidad, acc.modulo
        `;
        const result_accesos_solicitados = await client.query(query_accesos_solicitados);

        accesos_usuario.push(...result_accesos_solicitados.rows)

        const especialidades_by_user = await getEspecialesByDoctor(id_usuario);
        const especialidad_is_included = result_accesos_solicitados.rows.some((acceso_usuario)=> especialidades_by_user.includes(acceso_usuario.id_especialidad) )
        
        if (especialidades_by_user.length > 0 && !especialidad_is_included) {
            
            const query_accesos_by_user_especiality = `
                SELECT a.*, MAX(con.fecha_hora) AS fecha_ultima_consulta
                FROM accesos a
                LEFT JOIN consulta con ON con.id_especialidad = a.id_especialidad AND con.id_paciente = ${id_paciente}
                WHERE a.id_especialidad IN ( ${especialidades_by_user.join(",")} ) 
                GROUP BY a.id_acessos
            `;
            const result_accesos_by_user_especiality = await client.query(query_accesos_by_user_especiality);
            
            const accesos_by_user = result_accesos_by_user_especiality.rows.map(( acceso ) => {
                return { id_acc_usuario: null, estado: true, id_accesos: acceso.id_acessos, id_especialidad: acceso.id_especialidad, modulo: acceso.modulo, fecha_ultima_consulta: acceso.fecha_ultima_consulta }
            })

            accesos_usuario.unshift(...accesos_by_user)
        }
        

        res.json(accesos_usuario);
    } catch (error) {
        console.error("Error al obtener el listado de accesos:", error);
        res.status(500).send("Error al obtener el listado de accesos");
    }
});



// Obtener las solicitudes que aun no se han aceptado o rechazado
router.get("/solicitudes", async (req, res) => {
    const query = `
        SELECT au.id_acc_usuario, au.id_accesos, au.id_usuario, au.id_paciente, au.motivo, au.estado, acc.modulo, u.nombre AS nombre_doctor, u.apellido AS apellido_doctor, p.nombre AS nombre_paciente, p.apellido AS apellido_paciente
        FROM accesos_usuario au
        JOIN accesos acc ON acc.id_acessos = au.id_accesos
        JOIN usuario u ON u.id_usuario = au.id_usuario
        JOIN paciente p ON p.id_paciente = au.id_paciente
        WHERE au.estado IS NULL
    `;

    try {
        const result = await client.query(query);

        res.json(result.rows);
    } catch (error) {
        console.error("Error al obtener las solicidudes de accesos:", error);
        res.status(500).send("Error al obtener las solicidudes de accesos");
    }
});



// Enviar solicitud de acceso
router.post("/solicitudes", async (req, res) => {
    const { motivo, id_accesos, id_usuario, id_paciente } = req.body;

    if (!motivo) {
        return res.status(400).json({ error: "Debe de ingresar el motivo de su solicitud." });
    }

    try {
        const query = `
            INSERT INTO accesos_usuario (id_accesos, id_usuario, id_paciente, estado, motivo)
            VALUES ($1, $2, $3, $4, $5) RETURNING *
        `;

        const values = [id_accesos, id_usuario, id_paciente, null, motivo];
        const result = await client.query(query, values);

        if (result.rows.length > 0) {
        res.status(200).json({ message: "Solicitud de acceso enviada correctamente" });
        } else {
        res.status(400).json({ message: "Error al enviar la solicitud." });
        }
    } catch (error) {
        console.log("error ", error);
        
        console.error("Error al registrar la solicidud de accesos:", error);
        res.status(500).send("Error al obtener las solicidudes de accesos");
    }
});



// aceptar o denegar una solicitud de acceso
router.put("/solicitudes/:id_acc_usuario", async (req, res) => {
    const { id_acc_usuario } = req.params;
    const { estado } = req.body;

    try {
        const query = `
            UPDATE accesos_usuario
            SET estado=${estado}
            WHERE id_acc_usuario=${id_acc_usuario};
        `;
        
        const result = await client.query(query);

        if (result.rowCount > 0) {
        res.status(200).json({ message: `Solicitud de acceso ${estado ? 'Aceptada' : 'Denegada' } correctamente` });
        } else {
        res.status(400).json({ message: "Error al modificar la solicitud." });
        }
    } catch (error) {
        console.log("error ", error);
        
        console.error("Error al modificar la solicitud de accesos:", error);
        res.status(500).send("Error al modificar la solicitud de accesos");
    }
});

module.exports = router;
