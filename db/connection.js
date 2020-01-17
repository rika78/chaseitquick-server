const {
  Pool
} = require('pg');

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'cq_db',
  password: 'T1csl786!', // od postgres || Lcgnrse78
  port: 5432,
});

module.exports = {
  pool
};