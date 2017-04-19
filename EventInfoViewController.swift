//
//  EventInfoViewController.swift
//  MMApp1
//
//  Created by Kevin Stone on 02/04/2017.
//  Copyright © 2017 Kevin Stone. All rights reserved.
//

import UIKit
import EventKit

class EventInfoViewController: UIViewController {

    //Function called by the timer, this will call a function of timeCalc object which calculates time and updates the label display.
    func printTime() -> Void
    {
        timeCalc2.timePrinter(label: label)
        
    }
    
    var timeCalc2 = countdownCalculator()
    var timer = Timer()
    
    @IBOutlet weak var reasonsToWatch: UILabel!
    @IBOutlet weak var watchButton: UIButton!
    @IBAction func watchButton(_ sender: Any) {
        //This opens up a safari webpage and displays information on how the user can watch the event.
        UIApplication.shared.open(NSURL(string:selectedEvent.HowToWatch) as! URL, options: [:], completionHandler: nil)
    }
    
    //Function used when the user adds a reminder.
    @IBAction func reminderButton(_ sender: Any) {
        let sucessEvent = UIAlertController(title: "Saved Event", message: "Reminder added for \n \(selectedEvent.Name)", preferredStyle: .alert)
        let errorEvent = UIAlertController(title: "Save Error", message: "Unable to add reminder for \n \(selectedEvent.Name). Please try again. Enable Calendar access in settings.", preferredStyle: .alert)
        
        
        let eventStore : EKEventStore = EKEventStore()

        eventStore.requestAccess(to: .event) { (granted, error) in
            
            if (granted) && (error == nil) {
                let event:EKEvent = EKEvent(eventStore: eventStore)
                
                event.title = selectedEvent.Name
                //This sets the day to 1 day before value in database. To deal with this just set the start dat in database as one day after date.
                event.startDate = self.timeCalc2.DateFormatDays.date(from: "\(selectedEvent.Date) \(selectedEvent.StartTime) a")!
                print("start date = \(event.startDate)")
                event.endDate = event.startDate.addingTimeInterval((60*60) * 5)
                //Add 2 alarms. One is 1 hour before event and 1 is 5 minutes before
                event.addAlarm(EKAlarm(relativeOffset: -1*60*5))
                event.addAlarm(EKAlarm(relativeOffset: -1*60*60))
            
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                    
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                    
                    
                    errorEvent.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                        errorEvent.dismiss(animated: true, completion: nil)
                    }))
                    
                    self.present(errorEvent, animated: true, completion: nil)
                    
                }
                print("Saved Event")
                
                sucessEvent.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    sucessEvent.dismiss(animated: true, completion: nil)
                }))
                self.present(sucessEvent, animated: true, completion: nil)
                
            }
            else
            {
                print("failed to save event with error : \(error) or access not granted")
                
                errorEvent.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    errorEvent.dismiss(animated: true, completion: nil)
                }))
                
                self.present(errorEvent, animated: true, completion: nil)
                
            }
        }
    }
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var fightCardImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        reasonsToWatch.text = selectedEvent.ReasonsToWatch
        watchButton.sizeToFit()
        label.sizeToFit()

        
      

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timeCalc2.m_StartTime = selectedEvent.StartTime
        timeCalc2.m_EndDate = selectedEvent.Date
    
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(printTime), userInfo: nil, repeats: true)
        timer.fire()
        fightCardImage.loadEventImageUsingCache(urlString: selectedEvent.FightCard)
        
    }
    //When we leave this view, invalidate the timer
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
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
