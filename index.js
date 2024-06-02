const express = require('express');
const moment = require('moment-timezone');
const os = require('os');

const app = express();

const port = 8081;

const author = "Jakub Sikora";

app.use((req, res, next) => {
    console.log(`Serwer uruchomiony o ${new Date()} na porcie ${port} przez ${author}`);
    next();
});

app.get('/', (req, res) => {
    const ip = req.ip.replace('::ffff:', '');
    const timez = 'Europe/Warsaw';

    res.send(`<h3>Adres IP: ${ip}</h3><br> <h3>Data i godzina: ${moment().tz(timez).format('HH:mm:ss YYYY-MM-DD')}</h3>`);
});

app.listen(port, () => {
  console.log(`Serwer pracuje na porcie ${port}`);
});