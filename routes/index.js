var express = require('express');
var router = express.Router();
const {
  getUsers,
  addUser,
  getQrcodes,
  addLog,
  getLog,
  getTime
} = require('../db/dbInterface');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

/* GET home page. */
router.get('/', function (req, res, next) {
  res.render('index', {
    title: 'Express'
  });
});

router.get('/alle', async function (req, res, next) {
  res.send(await getUsers());
});

router.get('/qrcodes/alle', async function (req, res, next) {
  res.send(await getQrcodes());
});

router.post('/qrcodes/gefunden', async function (req, res, next) {
  let user = await getUsers()
  let cuser = user.filter(el => el.username == req.body.username);
  console.log(cuser[0].uid);
  console.log(req.body.qid)
  let p = {
    uid: cuser[0].uid,
    qid: req.body.qid
  }
  res.send(await addLog(p));
});

router.post('/qrcodes/found', async function (req, res, next) {
  let user = await getUsers();
  let cuser = user.filter(el => el.username == req.body.username);
  res.send(await getLog(cuser[0].uid));
});

router.post('/qrcodes/found/time', async function (req, res, next) {
  let user = await getUsers();
  let cuser = user.filter(el => el.username == req.body.username);
  res.send(await getTime(cuser[0].uid));
});


//Funktioniert
router.post('/registrieren', async function (req, res, next) {
  const userData = {
    username: req.body.username,
    email: req.body.email,
    password: req.body.password,
  }


  const allUsers = await getUsers();
  console.log(allUsers.map(el => el.email != userData.email));
  try {
    //bcrypt muss heruntergeladen werden 
    //checked ob user vorhanden
    if (allUsers.map(el => el.email != userData.email)) {
      //Hashed das password
      bcrypt.hash(req.body.password, 10, (err, hash) => {
        userData.password = hash

        //User wird hinzugefügt
        addUser(userData).then(res.json({
            status: userData.email + ' Registered!'
          }))
          .catch(err => {
            res.send('error: ' + err)
          })
      })
    } else {
      res.json({
        error: 'User already exists'
      })
    }

  } catch (err) {
    res.send('error: ' + err);
  }

});

router.post('/anmelden', async function (req, res, next) {
  console.log('hi');
  const allUsers = await getUsers();
  const user = allUsers.filter(el => el.username == req.body.username);

  try {
    if (allUsers.map(el => el.username == req.body.username)) {
      //passwort wird gehasht
      if (bcrypt.compareSync(req.body.password, user[0].password)) {
        //token zur auth wird erstellt
        let token = jwt.sign({
          userID: user[0].uid
        }, 'secretkey');
        return res.status(200).json({
          title: 'login success',
          token: token
        })
      } else {
        return res.status(401).json({
          title: 'login failed',
          error: 'daten stimmen nicht'
        })
      }
    } else {
      res.status(400).json({
        error: 'User does not exist'
      })
    }
  } catch (err) {
    res.send('error: ' + err);
  }

});

router.get('/profil', async function (req, res, next) {
  const allUsers = await getUsers();
  let token = req.headers.token;


  jwt.verify(token, 'secretkey', (err, decoded) => {
    if (err) return res.status(401).json({
      title: 'unautherized',
    });
    //if token valid
    const vUser = allUsers.filter(el => el.uid == decoded.userID);
    if (vUser[0].uid == decoded.userID) {
      return res.status(200).json({
        title: 'user',
        user: {
          username: vUser[0].username,
          email: vUser[0].email,
        }
      })
    } else {
      console.log(err);
    }

  });

});


module.exports = router;