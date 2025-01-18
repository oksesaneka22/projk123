const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());

// Allow requests from frontend IP or URL
app.use(cors({
    origin: 'http://192.168.0.122',  // Change this to your frontend's IP or URL
    methods: ['GET', 'POST', 'DELETE'],
    credentials: true
}));

const db = mysql.createConnection({
    host: 'mysql',
    user: 'root',
    password: 'password',
    database: 'todo_db',
});

setTimeout(() => {
    db.connect((err) => {
        if (err) {
            console.error('Database connection failed:', err);
        } else {
            console.log('Connected to MySQL database.');
        }
    });
}, 3000); // Delay of 15 seconds to ensure DB is ready

app.get('/tasks', (req, res) => {
    db.query('SELECT * FROM tasks', (err, results) => {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(results);
        }
    });
});

app.post('/tasks', (req, res) => {
    const { title } = req.body;
    db.query('INSERT INTO tasks (title) VALUES (?)', [title], (err, result) => {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json({ id: result.insertId, title });
        }
    });
});

app.delete('/tasks/:id', (req, res) => {
    const { id } = req.params;
    db.query('DELETE FROM tasks WHERE id = ?', [id], (err) => {
        if (err) {
            res.status(500).send(err);
        } else {
            res.sendStatus(200);
        }
    });
});

app.listen(3000, () => {
    console.log('Server is running on http://localhost:3000');
});
