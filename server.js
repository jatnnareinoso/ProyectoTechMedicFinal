const express = require('express');
const session = require('express-session');
const path = require('path');
const multer = require('multer');
const bodyParser = require('body-parser');
const client = require('./design/js/db');
const userRoutes = require('./design/js/userRoutes');
const login = require('./design/js/login');
const {registrarPaciente, buscarPacientePorCedula} = require('./design/js/registroPaciente');
const { obtenerPerfilesPacientes, actualizarPaciente, buscarPacientes, buscarPacientesCitas } = require('./design/js/listaPacientes');
const changePassword = require('./design/js/change-password');
const doctorRoutes = require('./design/js/doctor');
const citaRoutes = require('./design/js/cita');
const asistenteDoctorRoutes = require('./design/js/asistente-doctor');
const access = require('./design/js/access');
const usuarioRouter = require('./design/js/usuario'); 
const  {buscarUsuarios } = require('./design/js/listaUsuarios');
const consultaRoutes = require('./design/js/consulta');
const historialRoutes = require('./design/js/historial-paciente');
const notificacionesRoutes = require('./design/js/mensajes');
const diagnosticoRoutes = require('./design/js/diagnostico');
const recetaRoutes = require('./design/js/recetas.js');

const app = express();
const port = 3003;
    
app.use(express.static(__dirname));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(session({
  secret: 'tecnologiamedicinal',
  resave: false,
  saveUninitialized: true,
  cookie: {
      secure: false, 
      sameSite: 'lax'
  }
}));

app.post('/api/logout', (req, res) => {
  req.session.destroy((err) => {
      if (err) {
          return res.status(500).json({ error: 'Error al cerrar sesión' });
      }
      res.clearCookie('connect.sid');  
      return res.json({ message: 'Sesión cerrada exitosamente' });
  });
});

app.use('/api', userRoutes(client)); 

app.use('/api/usuario', usuarioRouter);

app.use('/api/notificacion', notificacionesRoutes);

app.use('/api/diagnostico', diagnosticoRoutes);

app.use('/api/recetas', recetaRoutes);

app.get('/api/pacientes', async (req, res) => {
    try {
      const pacientes = await obtenerPerfilesPacientes();
      res.json(pacientes);
    } catch (err) {
      console.error('Error al obtener perfiles:', err);
      res.status(500).json({ error: 'Error al obtener los perfiles de pacientes.' });
    }
});

app.get('/api/buscarPaciente', async (req, res) => {
  const searchQuery = req.query.query;

  if (!searchQuery) {
    return res.status(400).json({ error: 'Parámetro de búsqueda faltante' });
  }

  const resultados = await buscarPacientes(searchQuery);

  if (resultados.length > 0) {
    res.json(resultados);
  } else {
    res.status(404).json({ mensaje: 'No se encontraron pacientes' });
  }
});

app.get('/api/buscarUsuarios', async (req, res) => {
  const searchQuery = req.query.query;

  if (!searchQuery) {
    return res.status(400).json({ error: 'Parámetro de búsqueda faltante' });
  }

  const resultados = await buscarUsuarios(searchQuery);

  if (resultados.length > 0) {
    res.json(resultados);
  } else {
    res.status(404).json({ mensaje: 'No se encontraron usuarios' });
  }
});

app.get('/api/buscarPacientesCitas', async (req, res) => {
    const { nombre, cedula } = req.query;

    const searchQuery = nombre ? nombre : cedula;

    try {
        const pacientes = await buscarPacientesCitas(searchQuery);
        res.json(pacientes);
    } catch (error) {
        console.error('Error al buscar pacientes:', error.message);
        res.status(500).send('Error al buscar pacientes');
    }
});


app.put('/api/pacientes/:id', async (req, res) => {
    const { id } = req.params;
    const datosActualizados = req.body;
    
    const resultado = await actualizarPaciente(id, datosActualizados);
    
    if (resultado.error) {
      return res.status(400).json({ error: resultado.error });
    }
    
    res.status(200).json({ mensaje: resultado.mensaje });
});

app.post('/api/registerPaciente', registrarPaciente);  

app.get('/api/buscarCedula/:cedula', async (req, res) => {
  const { cedula } = req.params;

  try {
      const paciente = await buscarPacientePorCedula(cedula);
      res.json(paciente);
  } catch (error) {
      console.error('Error al buscar paciente por cédula:', error.message);
      res.status(500).json({ error: 'Error al buscar paciente' });
  }
});

app.get('/api/verificar-correo', async (req, res) => {
    const { correo } = req.query;

    try {
        const result = await client.query('SELECT COUNT(*) FROM usuario WHERE correo = $1', [correo]);
        const enUso = result.rows[0].count > 0;
        res.json({ enUso });
    } catch (err) {
        console.error('Error al verificar el correo:', err);
        res.status(500).json({ error: 'Error al verificar el correo' });
    }
});

app.get('/api/verificar-cedula', async (req, res) => {
    const { cedula } = req.query;

    try {
        const result = await client.query('SELECT COUNT(*) FROM usuario WHERE cedula = $1', [cedula]);
        const enUso = result.rows[0].count > 0;
        res.json({ enUso });
    } catch (err) {
        console.error('Error al verificar el usuario:', err);
        res.status(500).json({ error: 'Error al verificar el usuario' });
    }
});

app.post('/api/login', login.login); 

app.use('/api', changePassword);

app.use('/api/doctor', doctorRoutes);

app.use('/api/cita', citaRoutes);

app.use('/api/consulta', consultaRoutes);

app.use('/api/historial', historialRoutes);

app.use('/api/', asistenteDoctorRoutes);

app.use('/api/accesos', access);

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
      cb(null, 'uploads/'); 
  },
  filename: function (req, file, cb) {
      cb(null, Date.now() + path.extname(file.originalname)); 
  }
});

const upload = multer({ storage: storage });

app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, './pages/login.html'));
});

app.listen(port, (
  
) => {
    console.log(`Servidor escuchando en http://localhost:${port}`);
});
