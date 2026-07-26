<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>My Profile — Arctic Esports</title>
<meta name="robots" content="noindex" />
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
  body { font-family:'Inter', sans-serif; }
  .font-display { font-family:'Rajdhani', sans-serif; }
</style>
</head>
<body class="bg-frost text-ink min-h-screen">

<header class="bg-black h-[70px] flex items-center sticky top-0 z-30">
  <div class="max-w-3xl mx-auto w-full px-4 flex items-center justify-between">
    <a href="index.html" class="text-white font-display font-bold text-lg">← ARCTIC <span class="text-cyan">ESPORTS</span></a>
  </div>
</header>

<section class="max-w-3xl mx-auto px-4 py-10">
  <div class="bg-white rounded-2xl shadow-sm p-6 flex items-center gap-5">
    <img id="photo" src="" alt="" class="w-16 h-16 rounded-full object-cover bg-slate-200 hidden" />
    <div id="initialsAvatar" class="w-16 h-16 rounded-full bg-bolt text-white font-display font-bold text-xl flex items-center justify-center"></div>
    <div>
      <p id="name" class="font-display font-bold text-xl"></p>
      <p id="email" class="text-steel text-sm"></p>
      <p id="joined" class="text-steel text-xs mt-1"></p>
    </div>
  </div>

  <div class="grid grid-cols-2 gap-4 mt-6">
    <div class="bg-white rounded-2xl shadow-sm p-5 text-center">
      <p id="totalRegs" class="font-display font-bold text-3xl">0</p>
      <p class="text-steel text-xs mt-1">Total Registrations</p>
    </div>
    <div class="bg-white rounded-2xl shadow-sm p-5 text-center">
      <p id="totalPaid" class="font-display font-bold text-3xl">₹0</p>
      <p class="text-steel text-xs mt-1">Total Paid</p>
    </div>
  </div>

  <div class="mt-6 flex gap-3">
    <a href="orders.html" class="flex-1 text-center border border-slate-200 bg-white font-display font-semibold py-3 rounded-lg hover:bg-slate-50">Recent Orders</a>
    <button id="editProfileBtn" class="flex-1 border border-slate-200 bg-white font-display font-semibold py-3 rounded-lg hover:bg-slate-50">Edit Profile</button>
  </div>

  <button id="logoutBtn" class="w-full mt-3 bg-black text-white font-display font-bold py-3 rounded-lg">Logout</button>
</section>

<script type="module">
  import { collection, query, where, getDocs } from "https://www.gstatic.com/firebasejs/10.12.2/firebase-firestore.js";
  import { db } from "../src/firebase/firebase-config.js";
  import { watchAuthState, logout } from "../src/firebase/auth-service.js";

  watchAuthState(async (user) => {
    if (!user) { window.location.href = 'login.html'; return; }

    document.getElementById('name').textContent = user.displayName || 'Player';
    document.getElementById('email').textContent = user.email || '';
    document.getElementById('joined').textContent = user.metadata?.creationTime
      ? `Member since ${new Date(user.metadata.creationTime).toLocaleDateString()}` : '';

    if (user.photoURL) {
      document.getElementById('photo').src = user.photoURL;
      document.getElementById('photo').classList.remove('hidden');
      document.getElementById('initialsAvatar').classList.add('hidden');
    } else {
      document.getElementById('initialsAvatar').textContent = (user.displayName || user.email || '?').charAt(0).toUpperCase();
    }

    try {
      const snap = await getDocs(query(collection(db, 'orders'), where('uid', '==', user.uid)));
      const orders = snap.docs.map(d => d.data());
      document.getElementById('totalRegs').textContent = orders.length;
      const total = orders.reduce((sum, o) => sum + (Number(o.amount) || 0), 0);
      document.getElementById('totalPaid').textContent = `₹${total}`;
    } catch { /* leave stats at 0 if Firestore isn't reachable yet */ }
  });

  document.getElementById('logoutBtn').addEventListener('click', async () => {
    await logout();
    window.location.href = 'index.html';
  });

  // Future-ready placeholder — editing profile fields (name/phone) isn't
  // wired up yet; this just tells the user that plainly.
  document.getElementById('editProfileBtn').addEventListener('click', () => {
    alert('Profile editing is coming soon.');
  });
</script>
</body>
</html>
