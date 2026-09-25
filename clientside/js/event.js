const API_BASE = 'http://localhost:3000/api';


const params = new URLSearchParams(window.location.search);
const eventId = params.get('id');

async function loadEvent() {
  const container = document.getElementById('event-detail');
  const errorMsg = document.getElementById('error-msg');

  if (!eventId) {
    container.innerHTML = '';
    errorMsg.textContent = 'No event ID provided.';
    return;
  }

  try {
    const res = await fetch(`${API_BASE}/events/${eventId}`);
    if (!res.ok) throw new Error('Event not found');
    const ev = await res.json();

    const progress = ev.goal_amount > 0
      ? Math.min(100, (ev.current_amount / ev.goal_amount) * 100).toFixed(1)
      : 0;

    container.innerHTML = `
      <div class="event-detail-card">
        <h2>${ev.event_name}</h2>
        <p class="category">${ev.category_name} — organised by ${ev.org_name}</p>

        <div class="detail-row"><strong>Date:</strong> ${new Date(ev.event_date).toLocaleDateString()}</div>
        <div class="detail-row"><strong>Time:</strong> ${ev.event_time || 'TBA'}</div>
        <div class="detail-row"><strong>Location:</strong> ${ev.location}</div>
        <div class="detail-row"><strong>Ticket Price:</strong> ${ev.ticket_price > 0 ? '$' + ev.ticket_price : 'Free'}</div>

        <h3>About this event</h3>
        <p>${ev.description}</p>

        <h3>Goal vs Progress</h3>
        <div class="progress-bar">
          <div class="progress-fill" style="width: ${progress}%"></div>
        </div>
        <p>$${ev.current_amount} raised of $${ev.goal_amount} goal (${progress}%)</p>

        <button id="register-btn" class="btn">Register</button>
      </div>
    `;

    document.getElementById('register-btn').addEventListener('click', () => {
      document.getElementById('modal').style.display = 'flex';
    });
  } catch (err) {
    container.innerHTML = '';
    errorMsg.textContent = 'Error: ' + err.message;
  }
}


document.getElementById('close-modal').addEventListener('click', () => {
  document.getElementById('modal').style.display = 'none';
});

loadEvent();