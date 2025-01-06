const express = require('express');
const path = require('path');
const {existsSync} = require("node:fs");
const axios = require("axios");

const server = express();
const PORT = 3000;
const publicPath = path.join(__dirname, 'public');


if (existsSync(publicPath)) {
    console.log('Sirviendo archivos estáticos desde "public".');
    server.use(express.static(publicPath));
} else {
    console.log('No se encontró la carpeta "public". ¡Estás en la API!.');

    server.get('/api', (req, res) => {
        res.send('API corriendo en EC2!');
    });

    server.get('/api/users', async (req, res) => {
        try {
            const response = await axios.get('https://jsonplaceholder.typicode.com/users');
            const users = await response.data;
            res.json(users);
        } catch (error) {
            console.error('Error fetching users:', error);
            res.status(500).json({ error: 'Error fetching users' });
        }
    });

    server.get('/api/users/:id', async (req, res) => {
        try {
            const { id } = req.params;
            const response = await axios.get(`https://jsonplaceholder.typicode.com/users/${id}`);
            if (response.status !== 200) {
                return res.status(404).json({ error: 'User not found' });
            }
            const user = await response.data;
            res.json(user);
        } catch (error) {
            console.error('Error fetching user:', error);
            res.status(500).json({ error: 'Error fetching user' });
        }
    });

    server.get('/api/posts', async (req, res) => {
        try {
            const response = await axios.get('https://jsonplaceholder.typicode.com/posts');
            const posts = await response.data;
            res.json(posts);
        } catch (error) {
            console.error('Error fetching posts:', error);
            res.status(500).json({ error: 'Error fetching posts' });
        }
    });

    server.get('/api/posts/:id', async (req, res) => {
        try {
            const { id } = req.params;
            const response = await axios.get(`https://jsonplaceholder.typicode.com/posts/${id}`);
            if (response.status !== 200) {
                return res.status(404).json({ error: 'Post not found' });
            }
            const post = await response.data;
            res.json(post);
        } catch (error) {
            console.error('Error fetching post:', error);
            res.status(500).json({ error: 'Error fetching post' });
        }
    });

}

server.use((req, res) => {
    res.status(404).send('404 Not Found');
});
server.listen(PORT, '0.0.0.0', () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});

