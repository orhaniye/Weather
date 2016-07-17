//
//  Forecast.swift
//  Weather
//
//  Created by orhaniye on 03/11/14.
//  Copyright (c) 2014 orhaniye. All rights reserved.
//

import Foundation

public class Forecast : NSObject{

    public func forecastForLocation (locationCoordinates: String, callback: ((Current!, NSError!) -> ()) ) {
        // defining the apiKey for forecast.io API
        let apiKey = "f056f6dde276e02bd6031cd4dcd2b251"
        
        // let locationCoordinates: String = "52.369476,4.897587"
        let queuryOptions: String = "?units=si"
        
        // save url for forecast.io
        // use baseURL to make generic url without hardcoding apiKey
        
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
        
        // append the location to the baseURL
        
        let forecastURL = NSURL(string: locationCoordinates+queuryOptions, relativeToURL: baseURL)
        
        // create a weather data object
        // let weatherData = NSData(contentsOfURL: forecastURL!, options: nil, error: nil)
        // println(weatherData)
        
        
        // implement concurrency
        // creates a global object that can be accessed from every location in this project
        
        let sharedSession = NSURLSession.sharedSession()
        
        // define download task
        
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL!, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            
            
            // the completion handler
            // create string object with the location info
            // use NSString contentsOfURL and pass location
            
            // var urlContents = NSString(contentsOfURL: location, encoding: NSUTF8StringEncoding, error: nil)
            // println(urlContents)
            
            // create data object from saved file (location on disk), do not use forecastURL!
            // to do this use NSData class
            // use let to create a mutable dataobject - content will not change
            // check whether there is response
            
            var currentWeather: Current! = nil;
            
            if (error == nil) {
                
                let dataObject = NSData(contentsOfURL: location)
                
                // create data object to a JSON object using NSJSON serialization
                
                let weatherDictionary : NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as NSDictionary
                
                // gives the dictionary containing the current weather data
                
                // let currentWeatherDictionary : NSDictionary = weatherDictionary["currently"] as NSDictionary
                
                // grab the data using key value pair
                
                // println(currentWeatherDictionary)
                
                // create a new instance by passing on to the struct initializer (Current)
                
                currentWeather = Current(weatherDictionary: weatherDictionary)
                
                
            }
            
            callback(currentWeather, error);
            
        })
        
        // execute the task
        
        downloadTask.resume()
    }
}




