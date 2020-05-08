const {
    pool
} = require('./connection');


//Kriegt alle user
const getUsers = async () => {
    const client = await pool.connect();
    try {
        const res = await client.query("SELECT * FROM users");
        // console.log(res.rows);
        return res.rows;
    } catch (error) {

    }
}
//Fügt users hinzu
const addUser = async (uD) => {
    const client = await pool.connect();

    try {
        await client.query("INSERT INTO users values (DEFAULT, $1,$2,$3)", [uD.username, uD.email, uD.password]);
        const res = await client.query("SELECT * FROM users");
        return res.rows
    } catch (error) {

    }
}

//Kriegt alle Spielmodi
const getSPM = async () => {
    const client = await pool.connect();
    try {
        const res = await client.query("SELECT * FROM spielmodus");
        // console.log(res.rows);
        return res.rows;
    } catch (error) {

    }
}

//Erstellt ein neuen spielsession
const createSPSS = async (spss) => {
    const client = await pool.connect();
    try {
        await client.query("INSERT INTO spielsession values (DEFAULT, $1,$2,DEFAULT, 0, false)", [spss.spmid, spss.uid]);
        const res = await client.query("SELECT sessid FROM spielsession where uid = $1 order by time desc limit 1", [spss.uid]);
        return res.rows
    } catch (error) {
        console.log(error);
    }
}

//Kriegt alle spielsessions von einem spieler
const getSPSS = async (id, spmid) => {
    const client = await pool.connect();
    try {
        console.log(id)
        const res = await client.query("SELECT * FROM spielsession where uid=$1 and spmid = $2 order by time desc limit 1", [id, spmid]);
        // console.log(res.rows);
        return res.rows;
    } catch (error) {
        console.log(error);
    }
}

const currSPSS = async (id, sessid) => {
    const client = await pool.connect();
    try {
        console.log(id)
        const res = await client.query("SELECT * FROM spielsession where uid=$1 and sessid = $2 order by time desc limit 1", [id, sessid]);
        console.log(res.rows);
        return res.rows;
    } catch (error) {
        console.log(error);
    }
}

const endSPSS = async (spss) => {
    const client = await pool.connect();
    try {
        await client.query("Update spielsession set punkte = $1, fertig = true where sessid = $2 and uid= $3", [spss.punkte, spss.sessid, spss.uid]);
        const res = await client.query("SELECT * FROM spielsession where uid = $1 and sessid = $2", [spss.uid, spss.sessid]);
        return res.rows
    } catch (error) {
        console.log(error);
    }
}

// Gibt alle QR Codes
const getQrcodes = async () => {
    const client = await pool.connect();
    try {
        const res = await client.query("SELECT * FROM qrcodes");
        // console.log(res.rows);
        return res.rows;
    } catch (error) {
        console.log(error)
    }
}



const gefQr = async (gqr) => {
    const client = await pool.connect();

    try {
        await client.query("INSERT INTO userfound values ($1,$2,$3,now())", [gqr.sessid, gqr.uid, gqr.qid]);
        const res = await client.query("SELECT * FROM userfound where uid=$1 and sessid=$2", [gqr.uid, gqr.sessid]);
        return res.rows
    } catch (error) {
        console.log(error);
    }
}

const getLog = async (gqr) => {
    const client = await pool.connect();

    try {
        const res = await client.query("SELECT * FROM userfound where uid=$1 and sessid=$2", [gqr.uid, gqr.sessid]);
        return res.rows
    } catch (error) {
        console.log(error)
    }
}

const getTime = async (uid, sessid) => {
    const client = await pool.connect();

    try {
        const res = await client.query("Select (Select time from userfound where uid=$1 and qid=2 and sessid=$2)-(select time from userfound where uid=$1 and qid=1 and sessid=$2) as timediff from userfound limit 1;", [uid, sessid]);
        return res.rows
    } catch (error) {
        console.log(error);
    }
}



module.exports = {
    getUsers,
    addUser,
    getQrcodes,
    getTime,
    getSPM,
    createSPSS,
    gefQr,
    getSPSS,
    getLog,
    endSPSS,
    currSPSS
}