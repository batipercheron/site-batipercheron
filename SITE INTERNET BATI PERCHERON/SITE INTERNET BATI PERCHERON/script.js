document.addEventListener('DOMContentLoaded', () => {
    // === Gestionnaire de formulaires générique ===
    const handleFormSubmission = (formId, submitBtnId, successMsgId) => {
        const form = document.getElementById(formId);
        if (!form) return;

        const submitBtn = document.getElementById(submitBtnId);
        const successMsg = document.getElementById(successMsgId);

        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            let isValid = true;
            const formData = new FormData(form);
            const inputs = form.querySelectorAll('input[required], textarea[required]');
            
            // Reset des erreurs
            inputs.forEach(input => {
                input.classList.remove('invalid');
                const errorEl = document.getElementById(`error-${input.id}`);
                if(errorEl) errorEl.style.display = 'none';
            });

            // Validation des champs requis
            inputs.forEach(input => {
                const value = input.value.trim();
                let fieldValid = true;

                if (!value) {
                    fieldValid = false;
                } else if (input.type === 'email') {
                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!emailRegex.test(value)) fieldValid = false;
                } else if (input.type === 'tel') {
                    const telRegex = /^[0-9\s\-\+\.]{10,20}$/;
                    if (!telRegex.test(value)) fieldValid = false;
                }

                if (!fieldValid) {
                    input.classList.add('invalid');
                    const errorEl = document.getElementById(`error-${input.id}`);
                    if(errorEl) errorEl.style.display = 'block';
                    isValid = false;
                }
            });

            if (isValid) {
                // Affichage du spinner
                submitBtn.classList.add('loading');
                submitBtn.disabled = true;

                fetch("/", {
                    method: "POST",
                    body: formData,
                })
                .then(response => {
                    if (response.ok) {
                        // Masquer le bouton et afficher le message de succès
                        submitBtn.style.display = 'none';
                        if (successMsg) {
                            successMsg.style.display = 'flex';
                            successMsg.scrollIntoView({ behavior: 'smooth', block: 'center' });
                        }
                    } else {
                        throw new Error('Erreur serveur');
                    }
                })
                .catch(error => {
                    console.error('Erreur:', error);
                    alert("Une erreur est survenue lors de l'envoi. Veuillez réessayer ou nous contacter par téléphone.");
                    submitBtn.classList.remove('loading');
                    submitBtn.disabled = false;
                });
            }
        });

        // Enlever l'erreur lors de la frappe
        form.querySelectorAll('input, textarea').forEach(input => {
            input.addEventListener('input', function() {
                if (this.classList.contains('invalid')) {
                    this.classList.remove('invalid');
                    const errorEl = document.getElementById(`error-${this.id}`);
                    if(errorEl) errorEl.style.display = 'none';
                }
            });
        });
    };

    // Initialisation pour les deux formulaires
    handleFormSubmission('recruitment-form', 'submit-btn', 'success-message');
    handleFormSubmission('contact-form', 'contact-submit-btn', 'contact-success-message');
});
