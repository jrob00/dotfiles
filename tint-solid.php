<?php


/*
# create
- /c/?8046df,8046df,etc
# flash
- /f/?ff9900
# get?
- /g/


specify a color name and we tint it according to the W3C color names chart
*/

if (empty($_SERVER["argv"]["1"])) {
  
  // random gradient
  $url = "http://tint.cloversites.com/api/create_random_gradient";
  
} else {
  
  // solid color
  $color = $_SERVER["argv"]["1"];
  
  $color_array = array();
  $number_of_colors = 160;
  
  // build an all black color array
  for ($i=0; $i<$number_of_colors; $i++) {
    $color_array[$i] = $color;
  }
  
  // request tint
  $url = "http://cloversites.dyndns.org:10000/c/?" . implode(",", $color_array);
  
  $ch = curl_init($url); 
  $response = curl_exec($ch); //execute post and get results
  
  print "url: $url\n";
  //print "response: $response";
  //print "\n";
  
  curl_close($ch);
  
}

?>