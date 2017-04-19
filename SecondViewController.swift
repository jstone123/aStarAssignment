//
//  SecondViewController.swift
//  MMApplication
//
//  Created by Kevin Stone on 03/01/2017.
//  Copyright © 2017 Kevin Stone. All rights reserved.
//

import UIKit
import EventKit

//Class for events.
class Event: NSObject{
    
    var Name: String = ""
    var Date: String = ""
    var StartTime: String = ""
    var Picture: String = ""
    var FightCard: String = ""
    var Location: String = ""
    var HowToWatch: String = ""
    var ReasonsToWatch: String = ""
}
//timeCalc is an object of a class that is used to calculate and display a countdown until an event.
var timeCalc = countdownCalculator()

//Same as selectedFighter, this variable is used app wide to track what event the user has selected.
var selectedEvent = Event()


class SecondViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    

    @IBOutlet weak var tableview: UITableView!
    //When the top event icon is pressed then the app moves to the event info screen.
    @IBAction func topButtonPressed(_ sender: Any) {
        selectedEvent = eventArray[0]
        self.performSegue(withIdentifier: "GoToEventInfo2", sender: Any?.self)
    }
    //Date formatters are used to specify the format of the date we want e.g. dd/mm or mm/dd etc.
    let formatter = DateFormatter()
    //When the user tries to set a reminder for an event this code is executed.
    @IBAction func eventButton(_ sender: Any) {
        //2 different events. One for a successful save and one for an error.
        let sucessEvent = UIAlertController(title: "Saved Event", message: "Reminder added for \n \(eventArray[0].Name)", preferredStyle: .alert)
        let errorEvent = UIAlertController(title: "Save Error", message: "Unable to add reminder for \n \(eventArray[0].Name). Please try again.", preferredStyle: .alert)

        //This code is used to create an event that will be added to the users calendar.
        let eventStore : EKEventStore = EKEventStore()
        //The app will request access and ask the user if it can access their calendar.
        eventStore.requestAccess(to: .event) { (granted, error) in
            
            if (granted) && (error == nil) {
                print("granted \(granted)")
                
                let event:EKEvent = EKEvent(eventStore: eventStore)
                
                event.title = selectedEvent.Name
                
              //testing  event.startDate = timeCalc.DateFormatDays.date(from: "\(eventArray[3].Date) \(eventArray[3].StartTime) a")!
                event.startDate = timeCalc.DateFormatDays.date(from: "\(selectedEvent.Date) \(selectedEvent.StartTime) a")!
                
                //There is no set time for an end date. Events are usually 5 hours depending on the length of fights and whether fighters drop out or not.
                event.endDate = event.startDate.addingTimeInterval((60*60) * 5)
                //Add 2 alarms. One is 1 hour before event and 1 is 5 minutes before
                event.addAlarm(EKAlarm(relativeOffset: -1*60*5))
                event.addAlarm(EKAlarm(relativeOffset: -1*60*60))
                
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                    
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                    
                    //Display error event
                    errorEvent.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                        errorEvent.dismiss(animated: true, completion: nil)
                    }))
                    
                    self.present(errorEvent, animated: true, completion: nil)
                    
                }
                print("Saved Event")
                //Display success event.
                sucessEvent.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    sucessEvent.dismiss(animated: true, completion: nil)
                }))
                self.present(sucessEvent, animated: true, completion: nil)
                
            }
            else
            {
                print("failed to save event with error : \(error) or access not granted")
                //Display error event
                errorEvent.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    errorEvent.dismiss(animated: true, completion: nil)
                }))
                
                self.present(errorEvent, animated: true, completion: nil)
                
            }
        }
    }


    //This gets the current calendar of the user. Used to get current day and time.
    let userCalendar = Calendar.current
    
    var timeDifference = ""
    
    
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
    
    @IBAction func watchButtonPressed(_ sender: Any) {
        
        UIApplication.shared.open(NSURL(string:eventArray[0].HowToWatch) as! URL, options: [:], completionHandler: nil)
    }
    

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label1: UILabel!

    
    @IBOutlet weak var watchButton: UIButton!
    func printTime() -> Void
    {
        timeCalc.timePrinter(label: label1)
        
    }
    var timer = Timer()
    
    func printArray()
    {
        for i in eventArray
        {
            print(i.Name)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in events controller")
       
        // printArray()
        //The countdown is only displayed for the closest event so element 0, on this page.
        timeCalc.m_EndDate = eventArray[0].Date
        timeCalc.m_StartTime = eventArray[0].StartTime
     

        button.imageView?.loadEventImageUsingCache(urlString: eventArray[0].Picture)
        
        let dateFormat = DateFormatter()
        //Set the format of the dat we want to use.
        dateFormat.dateFormat = "dd-MM-yyyy HH:mm:ss"
        label1.sizeToFit()
        // Do any additional setup after loading the view.
        DispatchQueue.main.async
            {
                self.tableview.reloadData()
        }

    }
    override func viewDidAppear(_ animated: Bool) {
            //Create a timer that fires every second. This will be used so that the label will update with the countdown timer.
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(printTime), userInfo: nil, repeats: true)
            timer.fire()
    }
    //Function used when the user clicks on a table element.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = eventArray[indexPath.row]
         tableView.deselectRow(at: indexPath, animated: true)
        
            self.timer.invalidate()
    }
    //Function used to define the number of rows in the section (only 1 section in this table)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    //Function used to set properties of each cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "eventCell")
        
        //check if the image hasnt been set yet i.e. the first time loading the page and set a default image with the same
        //size as downloaded images.
        if(myCell?.imageView?.image?.description == nil)
        {
            myCell?.imageView?.image = #imageLiteral(resourceName: "defaultListPic")
        }
   
        
        myCell?.detailTextLabel?.text = eventArray[indexPath.row].Location
        
        myCell?.textLabel?.text = eventArray[indexPath.row].Name
        myCell?.imageView?.loadEventImageUsingCache(urlString: eventArray[indexPath.row].Picture)
        return myCell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
