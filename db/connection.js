const {
  Pool
} = require('pg');

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'cq_db',
  password: 'Lcgnrse78!', // od postgres || Lcgnrse78
  port: 5432,
});

module.exports = {
  pool
};