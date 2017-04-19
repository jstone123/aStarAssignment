//
//  Extensions.swift
//  MMApp1
//
//  Created by Kevin Stone on 23/01/2017.
//  Copyright © 2017 Kevin Stone. All rights reserved.
//

import UIKit
//This cache is used to store all the images that have been downloaded.


extension UIImageView{
    
    func loadFighterImageUsingCache(urlString: String)
    {
        
        //check cache for images first
        //Before we download an image we check the cache to see if it has already been downloaded.
        //We check this by using the URL of the image because the images are stored in the cache using a key
        //and the key is the url for the image.
    
            if let cachedImage = fighterImageCache.object(forKey: urlString as AnyObject)
            {
                
                self.image = cachedImage as! UIImage
                print("image found")
                print(urlString)
                print(" ")
                return
            }
    
        
        
        
        //if the image wasnt in the cache then we need to download it.
        let testing = URL(string: urlString)
        URLSession.shared.dataTask(with: testing!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print("error")
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!)
                {
                    fighterImageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
            }
        }).resume()
        
    }
    func loadEventImageUsingCache(urlString: String)
    {
        //check cache for images first
        //Before we download an image we check the cache to see if it has already been downloaded.
        //We check this by using the URL of the image because the images are stored in the cache using a key
        //and the key is the url for the image.
        if let cachedImage = eventImageCache.object(forKey: urlString as AnyObject)
        {
            self.image = cachedImage as! UIImage
            print("image found")
            print(urlString)
            print(" ")
            return
        }
        
        
        
        
        //if the image wasnt in the cache then we need to download it.
        let testing = URL(string: urlString)
        URLSession.shared.dataTask(with: testing!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print("error")
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                
                if let downloadedImage = UIImage(data: data!)
                {
                    print("cached event")
                    eventImageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
            }
        }).resume()
        
    }
}

class countdownCalculator: NSObject
{
    //Date formatters are used to specify the format of the date we want e.g. dd/mm or mm/dd etc.
    let DateFormatDays = DateFormatter()
    let DateFormatTime = DateFormatter()
    
    
    
    //This gets the current calendar of the user. Used to get current day and time.
    let userCalendar = Calendar.current
    
    var timeDifference = ""
    
    //end date is the date we want to countdown until
    var m_EndDate = ""
    //Start time is the time of the event on the end date.
    var m_StartTime = ""
    
    
    var calcDifference = true
    //These components are needed to specify what values to get when we access the calendar.
    //First one gives us everything and is used to calcualte the number of days left
    let requestedComponentDay : Set<Calendar.Component> = [
        Calendar.Component.month,
        Calendar.Component.day,
        Calendar.Component.hour,
        Calendar.Component.minute,
        Calendar.Component.second
    ]
    //Second one gives only hours,mins,seconds and is used to calculate the amount of time until event when its event day.
    let requestedComponentTime : Set<Calendar.Component> = [
        Calendar.Component.hour,
        Calendar.Component.minute,
        Calendar.Component.second
    ]
    
    
    //This functions is used to set the start date and end date for the date comparison.
    //Start time is the current time.
    func timeCalculator(dateFormat: String, endTime: String, startTime: Date = Date()) -> DateComponents
    {
        DateFormatDays.dateFormat = dateFormat
        let _startTime = startTime
        let _endTime = DateFormatDays.date(from: endTime)
        let timeDifference =  userCalendar.dateComponents(requestedComponentDay, from: _startTime, to: _endTime!)
        
        
        //userCalendar.dateComponents(requestedComponent, from: _startTime, to: _endTime!, options:0)
        return timeDifference
    }
    
   public func timePrinter(label: UILabel) -> Void {
        //               let test1 = "GMT"
        
        //Fight times vary based on region.
        //Fights are made to cater to the north american audience specifically the pacific time zone.
        //The value that we calculate is the time until
        
        let time = timeCalculator(dateFormat: "dd/MM/yyyy HH:mm:ss a", endTime: "\(m_EndDate) \(m_StartTime) a")
        
        if (calcDifference)
        {
            timeDifference = "\(time.month!) Months \(time.day!) Days \(time.hour!) Hours \(time.minute!) Minutes \(time.second!) Seconds"
            if (time.month! == 1)
            {
                timeDifference = "\(time.month!) Month \(time.day!) Days \(time.hour!) Hours \(time.minute!) Minutes \(time.second!) Seconds"
            }
            if (time.month! <= 0)
            {
                timeDifference = "\(time.day!) Days \(time.hour!) Hours \(time.minute!) Minutes \(time.second!) Seconds"
            }
            if (time.day! == 1)
            {
                timeDifference = "\(time.day!) Day \(time.hour!) Hours \(time.minute!) Minutes \(time.second!) Seconds"
            }
            if (time.day! <= 0)
            {
                timeDifference = "\(time.hour!) Hours \(time.minute!) Minutes \(time.second!) Seconds"
            }
            if (time.hour! == 1)
            {
                timeDifference = "\(time.hour!) Hour \(time.minute!) Minutes \(time.second!) Seconds"
            }
            if (time.hour! <= 0)
            {
                timeDifference = "\(time.minute!) Minutes \(time.second!) Seconds"
            }
            if (time.minute! == 1)
            {
                timeDifference = "\(time.minute!) Minute \(time.second!) Seconds"
            }
            if (time.minute! <= 0)
            {
                timeDifference = "\(time.second!) Seconds"
            }
            if (time.second! <= 0)
            {
                timeDifference = "Live"
                calcDifference = false
            }
        }
        
        if (calcDifference == false)
        {
            let date = Date()//Get the current date and time.
            
            //Get time from the current data.
            var hour = userCalendar.component(.hour, from: date)
            var minute = userCalendar.component(.minute, from: date)
            var second = userCalendar.component(.second, from: date)
            
            DateFormatTime.dateFormat = "HH:mm:ss"
            let currentTime = DateFormatTime.date(from: "\(hour):\(minute):\(second)")//Extract the current hour min and second values = the current time.
            
            let eventStartTime = DateFormatTime.date(from: "23:00:00")
            //This calculate the difference between the two times. We get the hours minutes and seconds as a result because
            //they are the only components used.
            let diff = userCalendar.dateComponents(requestedComponentTime, from: currentTime!, to: eventStartTime!)
            
            
            //need to use .hour! to prevent the word "optional" being inserted into text
            // label.text = "\(diff.hour!) h \(diff.minute!) m \(diff.second!) s"
            timeDifference = "\(diff.hour!) Hours \(diff.minute!) Minutes \(diff.second!) seconds"
        }
        
     //   print(timeDifference)
        label.text = timeDifference
        label.sizeToFit()
    }
    
    
}

