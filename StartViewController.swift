//
//  StartViewController.swift
//  MMApp1
//
//  Created by Kevin Stone on 31/01/2017.
//  Copyright © 2017 Kevin Stone. All rights reserved.
//

import UIKit
import Firebase

//Keeps track of the current promotion that the viewer selected.
enum Promotion {
    case UFC
    case Bellator
}

//To determine when all fighter info has been recovered from the databse use 2 counters.
//Both counters start off the same. Before an object is added to the fighter/event array the counters are set to the current array size.
//If a new element is added to the array then the newCount variables increase by one.
//A timer is used so that we check the difference between the counters every second.
//If the last count is 1 less than the size of the array (accounts for the array offset where [0] is the first element)
//then all data has been retrieved and app moves to home screen.
var lastFighterArrayCount = -1;
var newFighterArrayCount = -1;

var lastEventArrayCount = -1;
var newEventArrayCount = -1;
//Cache to store images for fighters
let fighterImageCache = NSCache<AnyObject, AnyObject>()

//Cache to store images for events.
let eventImageCache = NSCache<AnyObject, AnyObject>()

var promotionString = "UFC"
var childString = "Fighters"
var eventString = "Events"

//Variable used to indicate whether the program is checking whether or not all data has been downloaded.
var checkingFinish = true

var promotion = Promotion.UFC//Set default value

class StartViewController: UIViewController {

    var stopIndicator = false
    var getData = false

    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var bellatorButton: UIButton!
    
    @IBOutlet weak var ufcButton: UIButton!
    
    //Function that occurs when the Bellator button is pressed
    @IBAction func BellatorButtonPressed(_ sender: Any) {
        promotionString = "Bellator"
        childString = "Fighters"
        topLabel.text = "Bellator"
        //Disable both buttons so the user cant press them repeatedly
        bellatorButton.isEnabled = false
        ufcButton.isEnabled = false
        
        //Start animating the indicator to indicate that something is happeneing.
        activityIndicator.startAnimating()
        GetFighterData()
        GetEventData()
        
     
    }
    //Function that occurs when the UFC button is pressed
    @IBAction func UFCButtonPressed(_ sender: Any) {
        promotionString = "UFC"
        childString = "Fighters"
        topLabel.text = "UFC"
        bellatorButton.isEnabled = false
        ufcButton.isEnabled = false
        
        //Start animating the indicator to indicate that something is happeneing.
        activityIndicator.startAnimating()
        GetFighterData()
        GetEventData()
    }
    //Timer used to check whether all data has been gathered.
    var timer1 = Timer()
    

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!


    override func viewDidLoad() {
        super.viewDidLoad()
        //Make buttons circular
        ufcButton.layer.cornerRadius = ufcButton.frame.size.width/2
        bellatorButton.layer.cornerRadius = bellatorButton.frame.size.width/2

        // Do any additional setup after loading the view.
    }
    //Since the user will be able to return to this view, the variables need to be reset when the view appears.
    override func viewDidAppear(_ animated: Bool) {
        
        lastFighterArrayCount = -1;
        newFighterArrayCount = -1;
        lastEventArrayCount = -1;
        newEventArrayCount = -1;
        
        topLabel.text = "Pick a promotion"
        
        stopIndicator = false
        getData = false
        
        bellatorButton.isEnabled = true
        ufcButton.isEnabled = true
        
        timer1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkFinish), userInfo: nil, repeats: true)
        
        if (stopIndicator)
        {
            activityIndicator.stopAnimating()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func checkFinish()
    {
    print(lastEventArrayCount," ", newEventArrayCount)
        
    if(lastFighterArrayCount == (newFighterArrayCount - 1) && lastEventArrayCount == (newEventArrayCount - 1))
    {

        self.activityIndicator.stopAnimating()
        checkingFinish = false
        timer1.invalidate()
        self.performSegue(withIdentifier: "GoToMain", sender: Any?.self)
        }
    }
    
    //Getting data from the databse when the app first starts up means that when user goes to the fighter info page
    //there is no delay because no data needs to be downloaded.
    func GetFighterData()
    {
        //First child is the top data group and second child is the group of data we want, in this case fighters.
        FIRDatabase.database().reference().child(promotionString).child(childString).observe(.childAdded, with: { (snapshot) in
            
            //Need to know when to stop
            lastFighterArrayCount = fighterArray.count
            newFighterArrayCount = fighterArray.count
            print(lastFighterArrayCount," ",newFighterArrayCount)
            //This gets a snapshot of the whole database.
            //Each fighter entry is defined by their name.
            if let dictionary = snapshot.value as? [String: AnyObject]{

                let currentFighter = Fighter()
                currentFighter.setValuesForKeys(dictionary)
                fighterArray.append(currentFighter)//self.currentFighter
                //What this line does is start downloading and caching the fighter images on a background thread.
                //This means that the user will still be able to use the app whilst the picutres are downloading.
                //An alternative would be to force the program to wait until an image is downloaded and then move onto the next one but this could result in a long loading time at the start of the app.
                //This can cause some issues when the user goes to the table e.g. If they load the app up and quickly go to the table then some of the fighters images wont be loaded. However if the user looks at other tabs first then when they eventually click to the table tab then all of the images should be loaded.
                //Doing it this way means that we dont load ALL of the images when the user first enters the table tab.
                DispatchQueue.main.async {
                    self.cacheFighterImage(urlString: currentFighter.ListPic)
                    self.cacheFighterImage(urlString: currentFighter.PagePic)
                }
                newFighterArrayCount = fighterArray.count
                //Sort the array by surname.
                
                fighterArray.sort { (s1, s2) -> Bool in
                    
                    return s1.Surname < s2.Surname
                    
                }
            }
        }, withCancel: nil)
    }
    
    
    
    func GetEventData()
    {
        //First child is the top data group and second child is the group of data we want, in this case fighters.
        FIRDatabase.database().reference().child(promotionString).child(eventString).observe(.childAdded, with: { (snapshot1) in
            
            //Need to know when to stop
            lastEventArrayCount = eventArray.count
            newEventArrayCount = eventArray.count
            //This gets a snapshot of the whole database.
            //Each fighter entry is defined by their name.
            if let dictionary1 = snapshot1.value as? [String: AnyObject]{
                
                let currentEvent = Event()
                currentEvent.setValuesForKeys(dictionary1)
                //Use a date formatter so that a date variable can be extracted from the date string in the database.
                //Events will be sorted by their start date.
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                
                eventArray.append(currentEvent)
                eventArray.sort { (s1, s2) -> Bool in
                    
                    return dateFormatter.date(from: s1.Date)! < dateFormatter.date(from: s2.Date)!
                }
                
                newEventArrayCount = eventArray.count
                //Does the same as above. We start loading the event pictures on a background thread to allow the user to still use the app.
                DispatchQueue.main.async {
                    self.cacheEventImage(urlString: currentEvent.Picture)
                    self.cacheEventImage(urlString: currentEvent.FightCard)
                }
                
                
            }
        }, withCancel: nil)
    }
    
    func cacheFighterImage(urlString: String)
    {
        //Check cache for images first
        //Before we download an image we check the cache to see if it has already been downloaded.
        //We check this by using the URL of the image because the images are stored in the cache using a key
        //and the key is the url for the image.
        if let cachedImage = fighterImageCache.object(forKey: urlString as AnyObject)
        {
            print("cached already")
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
                if let downloadedImage = UIImage(data: data!)
                {
                    fighterImageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                }
        }).resume()
    }
    
    func cacheEventImage(urlString: String)
    {
        
        //Check cache for images first
        //Before we download an image we check the cache to see if it has already been downloaded.
        //We check this by using the URL of the image because the images are stored in the cache using a key
        //and the key is the url for the image.
        if let cachedImage = eventImageCache.object(forKey: urlString as AnyObject)
        {
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
                    eventImageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                }
            }
        }).resume()
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
