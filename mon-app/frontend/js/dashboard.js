document.addEventListener('DOMContentLoaded', () => {
    const user = JSON.parse(localStorage.getItem('user'));
    if (!user) { window.location.href = 'index.html'; return; }

    document.getElementById('user-name').textContent = user.nom;
    document.getElementById('user-category').textContent = user.category || 'Sans catégorie';

    const permissionMap = {
        'create_user': 'section-create-user',
        'manage_categories': 'section-categories',
        'view_reports': 'section-reports',
    };

    (user.permissions || []).forEach(code => {
        const sectionId = permissionMap[code];
        if (sectionId) document.getElementById(sectionId)?.classList.remove('hidden');
    });
});
