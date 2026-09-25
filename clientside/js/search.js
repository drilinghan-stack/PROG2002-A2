const API_BASE = 'http://localhost:3000/api';


document.addEventListener('DOMContentLoaded', async () => {
  await loadCategories();
  await searchEvents();
});


async function loadCategories() {
  try {
    const res = await fetch(`${API_BASE}/categories`);
    const categories = await res.json();
    const select = document.getElementById('category');
    categories.forEach(c => {
      const opt = document.createElement('option');
      opt.value = c.category_id;
      opt.textContent = c.category_name;
      select.appendChild(opt);
    });
  } catch (err) {
    console.error('Failed to load categories:', err);
  }
}


async function searchEvents() {
  const resultsDiv = document.getElementById('results');
  const errorMsg = document.getElementById('error-msg');
  errorMsg.textContent = '';
  resultsDiv.innerHTML = 'Loading...';

  const date = document.getElementById('date').value;
  const location = document.getElementById('location').value.trim();
  const category = document.getElementById('category').value;

  const params = new URLSearchParams();
  if (date) params.append('date', date);
  if (location) params.append('location', location);
  if (category) params.append('category', category);

  try {
    const res = await fetch(`${API_BASE}/events/search?${params.toString()}`);
    if (!res.ok) throw new Error('Search failed');
    const events = await res.json();

    if (events.length === 0) {
      resultsDiv.innerHTML = '<p>No events found matching your criteria.</p>';
      return;
    }

    resultsDiv.innerHTML = events.map(ev => `
      <div class="event-card">
        <h3>${ev.event_name}</h3>
        <p><strong>Category:</strong> ${ev.category_name}</p>
        <p><strong>Date:</strong> ${new Date(ev.event_date).toLocaleDateString()}</p>
        <p><strong>Location:</strong> ${ev.location}</p>
        <p><strong>Ticket:</strong> $${ev.ticket_price}</p>
        <a href="event.html?id=${ev.event_id}" class="btn">View Details</a>
      </div>
    `).join('');
  } catch (err) {
    resultsDiv.innerHTML = '';
    errorMsg.textContent = 'Error: ' + err.message;
  }
}


document.getElementById('search-form').addEventListener('submit', e => {
  e.preventDefault();
  searchEvents();
});


document.getElementById('clear-btn').addEventListener('click', () => {
  document.getElementById('date').value = '';
  document.getElementById('location').value = '';
  document.getElementById('category').value = '';
  document.getElementById('error-msg').textContent = '';
  searchEvents();
});