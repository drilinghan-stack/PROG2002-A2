const API_BASE = 'http://localhost:3000/api';

async function loadEvents() {
  const container = document.getElementById('event-list');
  try {
    const res = await fetch(`${API_BASE}/events`);
    if (!res.ok) throw new Error('Failed to fetch events');
    const events = await res.json();

    if (events.length === 0) {
      container.innerHTML = '<p>No upcoming events.</p>';
      return;
    }

    container.innerHTML = events.map(ev => `
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
    container.innerHTML = `<p class="error">Error: ${err.message}</p>`;
  }
}

loadEvents();