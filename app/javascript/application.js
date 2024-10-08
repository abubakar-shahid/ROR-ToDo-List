// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
// import "controllers"



// document.addEventListener('turbo:load', () => {
// document.addEventListener('DOMContentLoaded', function () {
const firebaseConfig = {
    apiKey: "AIzaSyAqCDQ3IsupyhP0uKr90bou3MAbfY3ooiM",
    authDomain: "concepthealth-7b3a9.firebaseapp.com",
    databaseURL: "https://concepthealth-7b3a9-default-rtdb.firebaseio.com",
    projectId: "concepthealth-7b3a9",
    storageBucket: "concepthealth-7b3a9.appspot.com",
    messagingSenderId: "132826073965",
    appId: "1:132826073965:web:d69e4e8ee1737cd2a3a864",
    measurementId: "G-YDJZV624VH"
};

firebase.initializeApp(firebaseConfig);
const db = firebase.database();
const todosRef = db.ref('todos');

let x = 0;

todosRef.on('value', (snapshot) => {
    x++;
    console.log("updated recieved: ", x);
    const todos = snapshot.val();
    updateTodos(todos);
    // saveTodosToDatabase(todos);
});

function updateTodos(todos) {
    for (const [id, todo] of Object.entries(todos)) {
        fetch(`/todos/render_todo_partial?id=${id}&todo[title]=${encodeURIComponent(todo.title)}&todo[completed]=${todo.completed}`, {
            method: 'GET',
            headers: {
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
            }
        })
            .then(response => response.text())
            .then(html => {
                const li = document.getElementById(`todo-${id}`);
                if (li) {
                    li.outerHTML = html; // Replace existing item
                } else {
                    const todoList = document.querySelector('ul');
                    todoList.insertAdjacentHTML('beforeend', html); // Add new item
                }
            })
            .catch(error => console.error('Error fetching the todo partial:', error));
    }
}

// function saveTodosToDatabase(todos) {
//     for (const [id, todo] of Object.entries(todos)) {
//         fetch('/database/save_from_firebase', {
//             method: 'POST',
//             headers: {
//                 'Content-Type': 'application/json',
//                 'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
//             },
//             body: JSON.stringify({ firebase_id: id, title: todo.title, completed: todo.completed })
//         })
//             .then(response => response.json())
//             .then(data => console.log('Saved to DB:', data))
//             .catch(error => console.error('Error saving to DB:', error));
//     }
// }
// });









// const firebaseConfig = {
//     apiKey: "AIzaSyAqCDQ3IsupyhP0uKr90bou3MAbfY3ooiM",
//     authDomain: "concepthealth-7b3a9.firebaseapp.com",
//     databaseURL: "https://concepthealth-7b3a9-default-rtdb.firebaseio.com",
//     projectId: "concepthealth-7b3a9",
//     storageBucket: "concepthealth-7b3a9.appspot.com",
//     messagingSenderId: "132826073965",
//     appId: "1:132826073965:web:d69e4e8ee1737cd2a3a864",
//     measurementId: "G-YDJZV624VH"
// };

// firebase.initializeApp(firebaseConfig);

// const db = firebase.database();
// const todosRef = db.ref('todos');

// let x = 0;

// todosRef.on('value', (snapshot) => {
//     x++;
//     console.log("updates received: ", x);
//     alert("updates received: ", x);
//     const todos = snapshot.val();
//     updateTodos(todos);
// });

// function updateTodos(todos) {
//     for (const [id, todo] of Object.entries(todos)) {
//         fetch(`/todos/render_todo_partial?id=${id}&todo[title]=${encodeURIComponent(todo.title)}&todo[completed]=${todo.completed}`, {
//             method: 'GET',
//             headers: {
//                 'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
//             }
//         })
//             .then(response => response.text())
//             .then(html => {
//                 const li = document.getElementById(`todo-${id}`);
//                 if (li) {
//                     li.outerHTML = html; // Replace existing item
//                 } else {
//                     const todoList = document.querySelector('ul');
//                     todoList.insertAdjacentHTML('beforeend', html); // Add new item
//                 }
//             })
//             .catch(error => console.error('Error fetching the todo partial:', error));
//     }
// }


// function updateTodos(todos) {
//     const todoList = document.querySelector('ul');
//     todoList.innerHTML = '';

//     for (const [id, todo] of Object.entries(todos)) {
//         const li = document.createElement('li');
//         li.innerHTML = `
//       <form action="/todos/${id}" method="post" data-turbo="false">
//           <input type="checkbox" name="completed" ${todo.completed ? 'checked' : ''}>
//               <input type="text" name="title" value="${todo.title}">
//                   <input type="submit" value="Update">
//                   </form>
//                   <button data-id="${id}" class="delete-btn">Delete</button>
//                   `;
//         todoList.appendChild(li);
//     }

//     // Uncomment and implement the delete functionality as needed
//     document.querySelectorAll('.delete-btn').forEach(button => {
//         button.addEventListener('click', (event) => {
//             const todoId = event.target.getAttribute('data-id');
//             fetch(`/todos/${todoId}`, {
//                 method: 'DELETE',
//                 headers: {
//                     'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
//                 }
//             }).then(() => {
//                 // Handle successful delete
//             });
//         });
//     });
// }