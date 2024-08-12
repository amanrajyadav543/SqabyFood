importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyDPD5fXJkgICfQ9hUbyNyg4umCbFraEvoI",
    authDomain: "sqabyfood.firebaseapp.com",
    projectId: "sqabyfood",
    storageBucket: "sqabyfood.appspot.com",
    messagingSenderId: "455130785962",
    appId: "1:455130785962:web:c8b3fdca3cfdc5cdcc08d3",
    measurementId: "G-XKRTXVBC7Y"
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});