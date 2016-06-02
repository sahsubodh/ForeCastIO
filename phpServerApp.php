<?php

$endpoint = 'https://maps.googleapis.com/maps/api/geocode/xml';
$responseEncoding = 'XML';   // Format of the response
$stradd = $_REQUEST['streetaddr']; 
$cty = $_REQUEST['city']; 
$state = $_REQUEST['state']; 
$punit =$_REQUEST["degree"];


//google url with mandatory parameters
$apicall = "$endpoint"
            . "?address=$stradd,"
            . "$cty,"
            . "$state"
            . "&key=AIzaSyCMEQqKND9ggOSVd14F0xcaSatMt1ptRgg";
            

//getting xml response from eBay
$results = simplexml_load_file($apicall) or die("Error: Cannot create object");

//extracting information from xml response
$lati    = (int) $results->result[0]->geometry->location->lat;
$longi     = (int) $results->result[0]->geometry->location->lng;


//get the units
if ($punit == "Fahrenheit")
      {
       $unit = "us";
      }
     else
     {
      $unit = "si";
     } 


$forecast_key = "b35654b2b84bf4465136513f5b0b6216";

$forecast_url = 'https://api.forecast.io/forecast/'.$forecast_key.'/'.$lati.','.$longi.'?units='.$unit.'&exclude=flags';

$forecast_contents  = file_get_contents($forecast_url);

$json = json_decode($forecast_contents,true);

$weather_condition  = $json['currently']['summary'];

$icon  = $json['currently']['icon'];





//set the time zone from the forecast API
$timezone  = $json['timezone'];

date_default_timezone_set($timezone);

$precipProbability = $json['currently']['precipProbability'];




//need to work on this
       $temperature  = $json['currently']['temperature'];

       $precipIntensity = $json['currently']['precipIntensity'];

       $windSpeed = $json['currently']['windSpeed'];

       $dewPoint  = $json['currently']['dewPoint']; 

       $humidity = $json['currently']['humidity']; 

       $visibility = $json['currently']['visibility']; 


$sunriseTime = $json['daily']['data'][0]['sunriseTime']; 

$sunsetTime = $json['daily']['data'][0]['sunsetTime']; 


$temperatureMax = $json['daily']['data'][0]['temperatureMax']; 

$temperatureMin = $json['daily']['data'][0]['temperatureMin']; 


//correct the preception intensity
if ($punit == "Celsius")
{ 	
  $abspi = $precipIntensity * 25.4;
}
else
{
  $abspi = $precipIntensity;
}


if ($abspi >= 0 && $abspi < 0.002) 
{
  $precipIntensitystr = 'None';
}
else if ($abspi >= 0.002 && $abspi < 0.017) {
  $precipIntensitystr = 'Very Light';
}
else if ($abspi >= 0.017 && $abspi < 0.1) {
  $precipIntensitystr = 'Light';
}
else if ($abspi >= 0.1 && $abspi < 0.4) {
  $precipIntensitystr =  'Moderate';
}
else if ($abspi >= 0.4) {
  $precipIntensitystr = 'Heavy';
}


//convert to percentage
$precipProbabilityper = $precipProbability*100;

//convert to percentage
$humidityper = $humidity*100;

//echo (string)($humidityper)."%";

$sunriseTimestr = date("h:i:A", $sunriseTime);

$sunsetTimestr =  date("h:i:A", $sunsetTime);


//check all the variable values
if (!isset($weather_condition))
{
  $weather_condition = 'N/A';
}
if (!isset($temperature))
{
  $temperature = 'N/A';
}
if (!isset($image))
{
  $image = 'N/A';
}
if (!isset($precipIntensitystr))
{
  $precipIntensitystr = 'N/A';
}
if (!isset($precipProbabilityper))
{
  $precipProbabilityper = 'N/A';
}

if (!isset($precipProbabilityper))
{
  $precipProbabilityper = 'N/A';
}

if (!isset($windSpeed))
{
  $windSpeed = 'N/A';
}
if (!isset($dewPoint))
{
  $dewPoint = 'N/A';
}

if (!isset($humidityper))
{
  $humidityper = 'N/A';
}

if (!isset($visibility))
{
  $visibility = 'N/A';
}

if (!isset($sunriseTimestr))
{
  $sunriseTimestr = 'N/A';
}

if (!isset($sunsetTimestr))
{
  $sunsetTimestr = 'N/A';
}


	$jasonData = array();

	$jasonData["weather_condition"]   = $weather_condition;
	$jasonData["icon"]   = $icon;
	$jasonData["forecast_url"]   = $forecast_url;
    $jasonData["temperature"]   = $temperature;
    $jasonData["precipIntensity"]   = $precipIntensity;
    $jasonData["windSpeed"]   = $windSpeed;
    $jasonData["dewPoint"]   = $dewPoint;
    $jasonData["humidity"]   = $humidity;       
    $jasonData["visibility"]   = $visibility;



for ($x = 0; $x <= 47; $x++) {

	$time = $json['hourly']['data'][$x]['time']; 

	$timestr = date("h:i:A", $time);

	$summary = $json['hourly']['data'][$x]['icon']; 

	$temp = isset($json['hourly']['data'][$x]['temperature']) ? $json['hourly']['data'][$x]['temperature'] : 'N/A';

  $jasonData["timestr"][$x]  = $timestr;
	$jasonData["summary"][$x]   = $summary;
	$jasonData["temp"][$x]   = $temp;


}

for ($x = 0; $x <=6; $x++) {

  $weektime = $json['daily']['data'][$x]['time']; 
  $weektimestr = date("l", $weektime);
  $monthday = date("M d", $weektime);
  $weekmintemp = isset($json['daily']['data'][$x]['temperatureMin']) ? $json['daily']['data'][$x]['temperatureMin'] : 'N/A';
  $weekmaxtemp = isset($json['daily']['data'][$x]['temperatureMax']) ? $json['daily']['data'][$x]['temperatureMax'] : 'N/A';
  $weekicon = $json['daily']['data'][$x]['icon']; 

  $jasonData["weektimestr"][$x]  = $weektimestr;
  $jasonData["monthday"][$x]  = $monthday;
  $jasonData["weekmintemp"][$x]  = $weekmintemp;
  $jasonData["weekmaxtemp"][$x]  = $weekmaxtemp;  
  $jasonData["weekicon"][$x]  = $weekicon;  

}

       $jasonData["humidityper"]   = $humidityper;  
       $jasonData["sunriseTimestr"]   = $sunriseTimestr;       
       $jasonData["sunsetTimestr"]   = $sunsetTimestr;
       $jasonData["precipProbabilityper"]   = $precipProbabilityper;   
       $jasonData["precipIntensitystr"]   = $precipIntensitystr;         
       $jasonData["temperatureMax"]   = $temperatureMax;       
       $jasonData["temperatureMin"]   = $temperatureMin;





            //print_r($jasonData);
print_r(json_encode($jasonData,JSON_UNESCAPED_SLASHES));
?>