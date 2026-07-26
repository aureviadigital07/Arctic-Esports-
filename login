<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Login — Arctic Esports</title>
<meta name="description" content="Login to Arctic Esports to book BGMI scrims, Weekly War, Weekend War and tournaments." />
<link rel="canonical" href="https://arcticesports.example/login.html" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet" />
<script src="https://cdn.tailwindcss.com"></script>
<script>
  tailwind.config = { theme: { extend: {
    colors: { ink:'#0A0A0F', frost:'#F5F7FA', steel:'#94A3B8', bolt:'#2563EB', cyan:'#22D3EE' },
    fontFamily: { display:['Rajdhani','sans-serif'], body:['Inter','sans-serif'] },
  } } };
</script>
<style>
  body { font-family: 'Inter', sans-serif; }
  .font-display { font-family: 'Rajdhani', sans-serif; }
  .glow-blue:hover { box-shadow: 0 0 24px rgba(37,99,235,.5); }
  .tab-active { color: #fff; border-bottom: 2px solid #22D3EE; }
  .spinner { border: 2px solid rgba(255,255,255,.3); border-top-color:#fff; border-radius:50%; width:16px; height:16px; animation: spin .7s linear infinite; display:inline-block; }
  @keyframes spin { to { transform: rotate(360deg); } }
</style>
</head>
<body class="bg-ink min-h-screen flex items-center justify-center px-4 py-10">

<div class="w-full max-w-md bg-black/60 border border-white/10 rounded-2xl p-8 shadow-2xl">
  <div class="text-center mb-6">
    <span class="inline-flex w-10 h-10 rounded bg-gradient-to-br from-bolt to-cyan items-center justify-center text-black font-black text-sm mb-3">AE</span>
    <h1 class="font-display font-bold text-2xl text-white">Welcome back, warrior</h1>
    <p class="text-steel text-sm mt-1">Login to continue your booking</p>
  </div>

  <div id="formAlert" class="hidden mb-4 text-sm rounded-lg px-4 py-3"></div>

  <!-- Tabs -->
  <div class="flex gap-6 border-b border-white/10 mb-6 font-display font-semibold text-steel">
    <button id="tabLogin" class="pb-3 tab-active">Login</button>
    <button id="tabCreate" class="pb-3">Create Account</button>
  </div>

  <button id="googleBtn" class="glow-blue w-full flex items-center justify-center gap-3 bg-white text-ink font-display font-semibold py-3 rounded-lg mb-5 transition-shadow">
    <svg width="18" height="18" viewBox="0 0 48 48"><path fill="#FFC107" d="M43.6 20.5H42V20H24v8h11.3C33.7 32.6 29.3 36 24 36c-6.6 0-12-5.4-12-12s5.4-12 12-12c3 0 5.8 1.1 7.9 3l6-6C34.5 5.4 29.5 3 24 3 12.4 3 3 12.4 3 24s9.4 21 21 21 21-9.4 21-21c0-1.2-.1-2.4-.4-3.5z"/><path fill="#FF3D00" d="M6.3 14.7l6.6 4.8C14.6 15.6 18.9 13 24 13c3 0 5.8 1.1 7.9 3l6-6C34.5 5.4 29.5 3 24 3c-7.5 0-14 4.2-17.7 10.4z"/><path fill="#4CAF50" d="M24 45c5.4 0 10.3-2.1 14-5.5l-6.5-5.3C29.3 36 26.8 37 24 37c-5.3 0-9.7-3.4-11.3-8.1l-6.6 5.1C9.9 40.7 16.4 45 24 45z"/><path fill="#1976D2" d="M43.6 20.5H42V20H24v8h11.3c-.8 2.3-2.3 4.2-4.3 5.5l6.5 5.3C41.4 36 45 30.5 45 24c0-1.2-.1-2.4-.4-3.5z"/></svg>
    Continue with Google
  </button>

  <div class="flex items-center gap-3 text-steel text-xs mb-5">
    <div class="h-px bg-white/10 flex-1"></div>OR<div class="h-px bg-white/10 flex-1"></div>
  </div>

  <form id="authForm" class="space-y-4">
    <div>
      <label class="text-steel text-xs font-display tracking-wide">EMAIL</label>
      <input id="email" type="email" required placeholder="you@example.com"
        class="mt-1 w-full bg-white/5 border border-white/10 focus:border-cyan outline-none rounded-lg px-4 py-3 text-white" />
    </div>
    <div>
      <label class="text-steel text-xs font-display tracking-wide">PASSWORD</label>
      <input id="password" type="password" required minlength="6" placeholder="••••••••"
        class="mt-1 w-full bg-white/5 border border-white/10 focus:border-cyan outline-none rounded-lg px-4 py-3 text-white" />
    </div>

    <div id="loginExtras" class="flex items-center justify-between text-sm">
      <label class="flex items-center gap-2 text-steel">
        <input id="rememberMe" type="checkbox" checked class="accent-bolt" /> Remember me
      </label>
      <button type="button" id="forgotBtn" class="text-cyan hover:underline">Forgot password?</button>
    </div>

    <label id="termsRow" class="hidden items-start gap-2 text-xs text-steel">
      <input id="termsCheck" type="checkbox" required class="mt-0.5 accent-bolt" />
      I agree to the Terms of Service and Privacy Policy
    </label>

    <button type="submit" id="submitBtn" class="glow-blue w-full bg-bolt text-white font-display font-bold py-3 rounded-lg transition-shadow flex items-center justify-center gap-2">
      <span id="submitLabel">Login</span>
    </button>
  </form>

  <p class="text-center text-steel text-xs mt-6">
    <a href="index.html" class="hover:text-white">← Back to Home</a>
  </p>
</div>

<script type="module">
  import { loginWithGoogle, loginWithEmail, createAccount, resetPassword, getReturnTo, clearReturnTo }
    from "../src/firebase/auth-service.js";

  const tabLogin = document.getElementById('tabLogin');
  const tabCreate = document.getElementById('tabCreate');
  const submitLabel = document.getElementById('submitLabel');
  const termsRow = document.getElementById('termsRow');
  const loginExtras = document.getElementById('loginExtras');
  const alertBox = document.getElementById('formAlert');
  let mode = 'login';

  function setMode(next) {
    mode = next;
    const isCreate = mode === 'create';
    tabLogin.classList.toggle('tab-active', !isCreate);
    tabCreate.classList.toggle('tab-active', isCreate);
    submitLabel.textContent = isCreate ? 'Create Account' : 'Login';
    termsRow.classList.toggle('hidden', !isCreate);
    termsRow.classList.toggle('flex', isCreate);
    loginExtras.classList.toggle('hidden', isCreate);
    alertBox.classList.add('hidden');
  }
  tabLogin.addEventListener('click', () => setMode('login'));
  tabCreate.addEventListener('click', () => setMode('create'));

  function showAlert(msg, kind = 'error') {
    alertBox.textContent = msg;
    alertBox.className = 'mb-4 text-sm rounded-lg px-4 py-3 ' +
      (kind === 'error' ? 'bg-red-500/10 text-red-300 border border-red-500/30' : 'bg-emerald-500/10 text-emerald-300 border border-emerald-500/30');
    alertBox.classList.remove('hidden');
  }

  function goToReturnUrl() {
    const dest = getReturnTo();
    clearReturnTo();
    window.location.href = dest;
  }

  document.getElementById('googleBtn').addEventListener('click', async () => {
    try { await loginWithGoogle(); goToReturnUrl(); }
    catch (err) { showAlert(friendlyAuthError(err)); }
  });

  document.getElementById('forgotBtn').addEventListener('click', async () => {
    const email = document.getElementById('email').value.trim();
    if (!email) return showAlert('Enter your email above first, then tap "Forgot password?"');
    try { await resetPassword(email); showAlert('Password reset email sent.', 'success'); }
    catch (err) { showAlert(friendlyAuthError(err)); }
  });

  document.getElementById('authForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value;
    const submitBtn = document.getElementById('submitBtn');
    submitBtn.disabled = true;
    submitLabel.innerHTML = '<span class="spinner"></span>';

    try {
      if (mode === 'create') {
        if (!document.getElementById('termsCheck').checked) throw { code: 'terms' };
        await createAccount(email, password);
        showAlert('Account created — verification email sent. You can continue now.', 'success');
      } else {
        await loginWithEmail(email, password);
      }
      goToReturnUrl();
    } catch (err) {
      submitBtn.disabled = false;
      submitLabel.textContent = mode === 'create' ? 'Create Account' : 'Login';
      showAlert(err.code === 'terms' ? 'Please accept the Terms to continue.' : friendlyAuthError(err));
    }
  });

  function friendlyAuthError(err) {
    const map = {
      'auth/invalid-email': 'That email address looks invalid.',
      'auth/user-not-found': 'No account found with that email.',
      'auth/wrong-password': 'Incorrect password.',
      'auth/email-already-in-use': 'An account already exists with that email.',
      'auth/weak-password': 'Password should be at least 6 characters.',
      'auth/popup-closed-by-user': 'Google sign-in was closed before completing.',
    };
    return map[err.code] || 'Something went wrong. Please try again.';
  }
</script>
</body>
</html>
