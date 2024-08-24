require 'firebase'

base_uri = 'https://your-project-id.firebaseio.com/' # Replace with your Firebase Realtime Database URL
$firebase = Firebase::Client.new(base_uri)
