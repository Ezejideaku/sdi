const API_URL = 'http://localhost:5000/api';

async function apiCall(endpoint, method = 'GET', body = null) {
    const token = localStorage.getItem('token');
    const headers = { 'Content-Type': 'application/json' };
    if (token) headers['Authorization'] = `Bearer ${token}`;
    const options = { method, headers };
    if (body) options.body = JSON.stringify(body);
    const response = await fetch(`${API_URL}${endpoint}`, options);
    if (response.status === 401) { localStorage.clear(); window.location.href = 'index.html'; }
    return response.json();
}
