import Vue from "vue";
import axios from "axios";

new Vue({
  el: '#takso-app',
  data: {
    pickup_address: "Liivi 2, Tartu, Estonia",
    dropoff_address: "J Sutiste tee 44, Tallin"
    
  },
  methods: {
      submitBookingRequest: function() {
          console.log(
              this.pickup_address, 
              this.dropoff_address, 
              this.user_id
              );  
      axios
        .post("/api/bookings", {
            pickup_address: this.pickup_address, 
            dropoff_address: this.dropoff_address

        })
      .then(response => console.log(response))
      .catch(error => console.log(error));
    }
  },
  mounted: function () {
      navigator.geolocation.getCurrentPosition(position => {
        let loc = {lat: position.coords.latitude, lng: position.coords.longitude};
        var geocoder = new google.maps.Geocoder;
        geocoder.geocode({location: loc}, (results, status) => {
            if (status === "OK" && results[0]) this.pickup_address = results[0].formatted_address;
        });
        this.map = new google.maps.Map(document.getElementById('map'), {zoom: 14, center: loc});
        new google.maps.Marker({position: loc, map: this.map, title: "Pickup address"});
      })
  }
});