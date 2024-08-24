require 'firebase'

base_uri = 'https://concepthealth-7b3a9-default-rtdb.firebaseio.com/' # Replace with your Firebase Realtime Database URL
$firebase = Firebase::Client.new(base_uri)
