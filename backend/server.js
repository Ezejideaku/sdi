const express = require('express');
const cors = require('cors');
const pool = require('./db');


const app = express();
app.use(cors());
app.use(express.json());


app.get('/api/users', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM messages ORDER BY id DESC');
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