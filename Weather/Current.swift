//
//  Current.swift
//  Weather
//
//  Created by orhaniye on 03/11/14.
//  Copyright (c) 2014 orhaniye. All rights reserved.
//

import Foundation

public class Current: NSObject {
    var currentTime: String?            // time is returned in integer but converted to string with the function
    var temperature: Int
    var humidity: Double
    var precipProbability: Double   // chance of rain
    var summary: String
    var icon: String
    
    init(weatherDictionary: NSDictionary) {
        
        let currentWeather = weatherDictionary["currently"] as NSDictionary

        // swift does not know the return type (will return as AnyObject) therefore downcast to Int
        temperature = currentWeather["temperature"] as Int
        humidity = currentWeather["humidity"] as Double
        precipProbability = currentWeather["precipProbability"] as Double
        summary = currentWeather["summary"] as String
        icon = currentWeather["icon"] as String

        let currentTimeIntValue = currentWeather["time"] as Int

        super.init()
        
        currentTime = self.dateStringFromUnixTime(currentTimeIntValue)
    }
    
    // create method to clean up the date
    // input parameter is unix time, return type String
    
    func dateStringFromUnixTime(unixTime: Int) -> String {
        
        // convert unix time
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        // convert time to short style
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        // return the date as string
        return dateFormatter.stringFromDate(weatherDate)
        
    }
    
    
    
    
    
    
    
}

