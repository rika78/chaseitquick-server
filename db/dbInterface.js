const {
    pool
} = require('./connection');


//Funktioniert
const getUsers = async () => {
    const client = await pool.connect();
    try {
        const res = await client.query("SELECT * FROM users");
        // console.log(res.rows);
        return res.rows;
    } catch (error) {

    }
}
//Funktioniert
const addUser = async (uD) => {
    const client = await pool.connect();

    try {
        await client.query("INSERT INTO users values (DEFAULT, $1,$2,$3)", [uD.username, uD.email, uD.password]);
        const res = await client.query("SELECT * FROM users");
        return res.rows
    } catch (error) {

    }
}

const getQrcodes = async () => {
    const client = await pool.connect();
    try {
        const res = await client.query("SELECT * FROM qrcodes");
        // console.log(res.rows);
        return res.rows;
    } catch (error) {

    }
}

const addLog = async (p) => {
    const client = await pool.connect();

    try {
        await client.query("INSERT INTO userfound values ($1,$2,now())", [p.uid, p.qid]);
        const res = await client.query("SELECT * FROM userfound where uid=$1", [uid]);
        return res.rows
    } catch (error) {

    }
}

const getLog = async (uid) => {
    const client = await pool.connect();

    try {
        const res = await client.query("SELECT * FROM userfound where uid=$1", [uid]);
        return res.rows
    } catch (error) {

    }
}

const getTime = async (uid) => {
    const client = await pool.connect();

    try {
        const res = await client.query("select to_char(uhzreit, 'HH24:MI') from userfound where uid =$1", [uid]);
        return res.rows
    } catch (error) {

    }
}


module.exports = {
    getUsers,
    addUser,
    getQrcodes,
    addLog,
    getLog,
    getTime,
}