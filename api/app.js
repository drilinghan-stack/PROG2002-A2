const express = require('express');
const cors = require('cors');
const db = require('./event_db');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());


app.get('/api/events', async (req, res) => {
  try {
    const sql = `
      SELECT e.event_id, e.event_name, e.description, e.event_date, e.event_time,
             e.location, e.ticket_price, e.goal_amount, e.current_amount,
             e.image_url, c.category_name, o.org_name
      FROM events e
      JOIN categories c ON e.category_id = c.category_id
      JOIN organisations o ON e.org_id = o.org_id
      WHERE e.status = 'active' AND e.event_date >= CURDATE()
      ORDER BY e.event_date ASC
    `;
    const [rows] = await db.query(sql);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


app.get('/api/categories', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM categories');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


app.get('/api/events/search', async (req, res) => {
  try {
    const { date, location, category } = req.query;
    let sql = `
      SELECT e.event_id, e.event_name, e.event_date, e.location,
             e.ticket_price, e.image_url, c.category_name
      FROM events e
      JOIN categories c ON e.category_id = c.category_id
      WHERE e.status = 'active'
    `;
    const params = [];

    if (date) {
      sql += ' AND e.event_date = ?';
      params.push(date);
    }
    if (location) {
      sql += ' AND e.location LIKE ?';
      params.push(`%${location}%`);
    }
    if (category) {
      sql += ' AND e.category_id = ?';
      params.push(category);
    }
    sql += ' ORDER BY e.event_date ASC';

    const [rows] = await db.query(sql, params);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


app.get('/api/events/:id', async (req, res) => {
  try {
    const sql = `
      SELECT e.*, c.category_name, o.org_name, o.contact_email, o.contact_phone
      FROM events e
      JOIN categories c ON e.category_id = c.category_id
      JOIN organisations o ON e.org_id = o.org_id
      WHERE e.event_id = ?
    `;
    const [rows] = await db.query(sql, [req.params.id]);
    if (rows.length === 0) {
      return res.status(404).json({ error: 'Event not found' });
    }
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`API server running at http://localhost:${PORT}`);
});