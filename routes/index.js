var express = require('express');
var router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const { getQrcodes, getUsers, getSPM, createSPSS, gefQr, getSPSS, getLog, endSPSS, getTime, currSPSS, addUser } = require("../db/dbInterface");

/* GET home page. */
router.get('/', function (req, res, next) {
  res.render('index', { title: 'Express' });
});
router.get('/spielmodus', async function (req, res, next) {
  res.send(await getSPM());
});

router.get('/qrcodes', async function (req, res, next) {
  res.send(await getQrcodes());
});

router.post('/qrcodes/gefunden', async function (req, res, next) {
  console.log(req.body);
  res.send(await gefQr({ sessid: req.body.sessid, uid: req.body.uid, qid: req.body.qid }));
});

router.post('/login', async function (req, res, next) {
  // try {
  const allUsers = await getUsers();
  const currUser = allUsers.filter(el => el.username == req.body.username);
  try {
    //Wenn ein user mit dem Username gefunden wird:
    if (allUsers.filter(el => el.username == req.body.username).length != 0) {
      // Password wird gehasht und verglichen
      if (bcrypt.compareSync(req.body.password, currUser[0].password)) {
        //token zur auth wird erstellt
        const token = jwt.sign({
          userID: currUser[0].uid
        }, 'secretkey');

        //Sucessful login:
        return res.status(200).json({
          title: 'login success',
          token: token,
          user: [currUser[0].uid, currUser[0].username]
        })
      } else {
        return res.status(401).json({
          title: 'login failed',
          message: 'daten stimmen nicht'
        })
      }
    } else {
      //FIX ME: ?
      return res.status(400).send({ error: "://" })
    }
  } catch (error) {
    return res.status(404).send("Error:" + error);
  }
  // res.send(await getUser());
});

router.post('/spielsession', async function (req, res, next) {
  const spss = { spmid: req.body.spmid, uid: parseInt(req.body.uid) }
  res.send(await createSPSS(spss));
});

router.post('/spielsession/ende', async function (req, res, next) {
  const spss = { sessid: req.body.sessid, uid: parseInt(req.body.uid), punkte: req.body.punkte }
  res.send(await endSPSS(spss));
});

router.get('/spielsession/:id/:spmid', async function (req, res, next) {
  console.log(req.params.id, req.params.spmid)
  res.send(await getSPSS(req.params.id, req.params.spmid));
});

router.get('/spielsession/curr/:id/:sessid', async function (req, res, next) {
  console.log(req.params.id, req.params.sessid)
  res.send(await currSPSS(req.params.id, req.params.sessid));
});

router.get('/history/:sessid/:uid', async function (req, res, next) {
  res.send(await getLog({ uid: parseInt(req.params.uid), sessid: parseInt(req.params.sessid) }));
});

router.get('/qrcodes/found/time/:id/:sessid', async function (req, res, next) {
  res.send(await getTime(req.params.id, req.params.sessid));
});

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


module.exports = router;
