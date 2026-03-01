const express = require('express');
const cors = require('cors');
const pool = require('./db');


const app = express();
app.use(cors());
app.use(express.json());


app.post('/api/users', async (req, res) => {
    try {
        const { email, password, id_role } = req.body;

        await pool.query(
            'INSERT INTO users(email, password_hash, id_role) VALUES($1, $2, $3)',
            [email, password, id_role]
        );

        res.json({ success: true });

    } catch (err) {
        res.status(500).send("POST : " + err.message);
    }
});



app.get('/api/users', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM users ORDER BY id DESC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});





async function testConnection() {
  try {
    const res = await pool.query('SELECT NOW()');
    console.log("Connexion réussie :", res.rows[0]);
  } catch (error) {
    console.error("Erreur de connexion :", error);
  }
}

testConnection();

app.listen(3000, () => {
    console.log('Backend démarré sur http://localhost:3000');
});