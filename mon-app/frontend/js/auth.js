async function login() {
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const errorDiv = document.getElementById('error-msg');
    try {
        const data = await apiCall('/auth/login', 'POST', { email, password });
        if (data.token) {
            localStorage.setItem('token', data.token);
            localStorage.setItem('user', JSON.stringify(data.user));
            window.location.href = 'dashboard.html';
        } else {
            errorDiv.textContent = data.error || 'Erreur de connexion';
            errorDiv.classList.remove('hidden');
        }
    } catch (e) {
        errorDiv.textContent = 'Impossible de joindre le serveur';
        errorDiv.classList.remove('hidden');
    }
}

function logout() { localStorage.clear(); window.location.href = 'index.html'; }
