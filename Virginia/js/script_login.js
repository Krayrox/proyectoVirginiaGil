document.getElementById("forgotPasswordLink").addEventListener("click", function (e) {
    e.preventDefault();
    document.getElementById("loginForm").classList.add("hidden");
    document.getElementById("forgotPasswordForm").classList.remove("hidden");
});

document.getElementById("backToLogin").addEventListener("click", function (e) {
    e.preventDefault();
    document.getElementById("forgotPasswordForm").classList.add("hidden");
    document.getElementById("loginForm").classList.remove("hidden");
});
