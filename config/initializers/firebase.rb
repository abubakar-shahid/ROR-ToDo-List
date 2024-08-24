require 'firebase'

base_uri = 'https://todo-list-e1c5f-default-rtdb.firebaseio.com/' # Replace with your Firebase Realtime Database URL
$firebase = Firebase::Client.new(base_uri)
