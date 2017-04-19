//
//  HomeViewController.swift
//  MMApp1
//
//  Created by Kevin Stone on 09/03/2017.
//  Copyright © 2017 Kevin Stone. All rights reserved.
//

import UIKit
//Pinned fighter variables.
var pinnedFighter1 = PinnedFighter()
var pinnedFighter2 = PinnedFighter()
var pinnedFighter3 = PinnedFighter()

//Arrays used to store the pinned data and also retrieve it.
var pinFighter1Array = [String]()
var pinFighter2Array = [String]()
var pinFighter3Array = [String]()

//Keys used to store the user default data.
let fighterIsPinned = "fighterIsPinned"
let pinFighter1Key = "pinFighter1"
let pinFighter2Key = "pinFighter2"
let pinFighter3Key = "pinFighter3"

//Use this dictionary to store data needed to retrieve the saved user data.
//User data is saved as an array. This dicionary makes it easy to access elements of the save data array.
//Dont need to remember the index of each value
//Can just give the key that we want e.g. Forename and the dictionary will return the int value so we can access the saved data array.
var fighterDictionary: [String:Int] = [

    "Forename":0,
    "Surname":1,
    "Champion":2,
    "Country":3,
    "Nickname":4,
    "Ranking":5,
    "Reach":6,
    "Record":7,
    "Height":8,
    "Weight":9,
    "ListPic":10,
    "PagePic":11
//    "NextFight":12
//    "LastFight":13
//    "Summary":14
]
//Bool used to keep track of whether the pinned arrays size has been set so that they arent appended to more than once.
var pinArraysSet = false

var timer1 = Timer()
var timer2 = Timer()
var timer3 = Timer()
var timer4 = Timer()
var timer5 = Timer()

//TimeCalc used to calculate countdown until event.
var timeCalc3 = countdownCalculator()






let emptyPinSlotText = "Empty Pin Slot"


class HomeViewController: UIViewController {
    
    @IBOutlet weak var closestEventLabel: UILabel!
    
    func printTime() -> Void
    {
        print("Home")
        timeCalc3.timePrinter(label: closestEventLabel)
        
    }
    
    
    //Functions used to check whether an image has finished loading and when to stop the activity indicator.
    func checkImage1Loaded() -> Void
    {
        if(pinFighter1.image != nil)
        {
            image1Activity.stopAnimating()
            timer1.invalidate()
        }
    }
    
    func checkImage2Loaded() -> Void
    {
        if(pinFighter2.image != nil)
        {
            image2Activity.stopAnimating()
            timer2.invalidate()
        }
    }
    
    func checkImage3Loaded() -> Void
    {
        if(pinFighter3.image != nil)
        {
            image3Activity.stopAnimating()
            timer3.invalidate()
        }
    }
    func checkEventImageLoaded() -> Void
    {
        if(closestEventImage.image != nil)
        {
            eventImageActivityIndicator.stopAnimating()
            timer4.invalidate()
            closestEventLabel.alpha = 1
            closestEventImage.isUserInteractionEnabled = true
        }
    }
    
    //Function used for clearing all arrays. This will be needed for when the user wants to swap which promotion they are viewing.
    func clearArrays()
    {
        fighterArray.removeAll()
        
        objectsArray.removeAll()
        objectsArray2.removeAll()
        objectsArray3.removeAll()
        
        eventArray.removeAll()
        fighterArrayA.removeAll()
        fighterArrayB.removeAll()
        fighterArrayC.removeAll()
        fighterArrayD.removeAll()
        fighterArrayE.removeAll()
        fighterArrayF.removeAll()
        fighterArrayG.removeAll()
        fighterArrayH.removeAll()
        fighterArrayI.removeAll()
        fighterArrayJ.removeAll()
        fighterArrayK.removeAll()
        fighterArrayL.removeAll()
        fighterArrayM.removeAll()
        fighterArrayN.removeAll()
        fighterArrayO.removeAll()
        fighterArrayP.removeAll()
        fighterArrayQ.removeAll()
        fighterArrayR.removeAll()
        fighterArrayS.removeAll()
        fighterArrayT.removeAll()
        fighterArrayU.removeAll()
        fighterArrayV.removeAll()
        fighterArrayW.removeAll()
        fighterArrayX.removeAll()
        fighterArrayY.removeAll()
        fighterArrayZ.removeAll()
        
        fighterArray125Men.removeAll()
        fighterArray135Men.removeAll()
        fighterArray145Men.removeAll()
        fighterArray155Men.removeAll()
        fighterArray170Men.removeAll()
        fighterArray185Men.removeAll()
        fighterArray205Men.removeAll()
        fighterArray265Men.removeAll()
        fighterArray115Women.removeAll()
        fighterArray135Women.removeAll()
        
        fighterArrayChampions.removeAll()
    }

    @IBAction func swapPromotionButton(_ sender: Any) {
        clearArrays()
        self.performSegue(withIdentifier: "GoToStartScreen", sender: Any?.self)
    }
    @IBOutlet weak var image1Activity: UIActivityIndicatorView!

    @IBOutlet weak var image2Activity: UIActivityIndicatorView!
    
    @IBOutlet weak var image3Activity: UIActivityIndicatorView!

    @IBOutlet weak var pinFighter3: UIImageView!
    
    @IBOutlet weak var pinFighter3Label: UILabel!
    
    @IBOutlet weak var eventImageActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var closestEventImage: UIImageView!
    
    @IBOutlet weak var pinFighter1: UIImageView!

    @IBOutlet weak var pinFighter1Label: UILabel!
    
    @IBOutlet weak var pinFighter2: UIImageView!
    
    @IBOutlet weak var pinFighter2Label: UILabel!
    
    @IBOutlet weak var deletePin1Button: UIButton!

    @IBOutlet weak var deletePin2Button: UIButton!
    
    @IBOutlet weak var deletePin3Button: UIButton!
    
    func resetLabels()
    {
        pinFighter1Label.text = emptyPinSlotText
        pinFighter2Label.text = emptyPinSlotText
        pinFighter3Label.text = emptyPinSlotText
    }
    
    //Function used when the user unpins a pinned fighter.
    func updatePinnedDisplay(image: UIImageView, label: UILabel, loadingIndicator: UIActivityIndicatorView, pinnedFight: PinnedFighter, loadingTimer: inout Timer)
    {
        image.image = nil
        image.isUserInteractionEnabled = false
        label.text = emptyPinSlotText
        loadingIndicator.stopAnimating()
        pinnedFight.pinned = false
        loadingTimer.invalidate()
    }
    
    @IBAction func deletePin1(_ sender: Any) {
//        deletePin1Button.alpha = 0
//        deletePin1Button.isEnabled = false
//        UserDefaults.standard.removeObject(forKey: pinFighter1Key)
//        
//        if let y = UserDefaults.standard.stringArray(forKey: pinFighter1Key)
//        {
//            print("y =  \(y) ")
//        }
//        else
//        {
//            print("no data for this key1")
//        }
//        
//        updatePinnedDisplay(image: pinFighter1, label: pinFighter1Label, loadingIndicator: image1Activity, pinnedFight: pinnedFighter1, loadingTimer: &timer1)
//        print(selectedFighter.Forename)
//        pinnedFighter1.fighter.Forename = "123"
//         print(selectedFighter.Forename)
//        checkPinnedData()
        
    }
    
    
    @IBAction func deletePin2(_ sender: Any) {
//        deletePin2Button.alpha = 0
//        deletePin2Button.isEnabled = false
//        
//        UserDefaults.standard.removeObject(forKey: pinFighter2Key)
//        
//        if let y = UserDefaults.standard.stringArray(forKey: pinFighter2Key)
//        {
//            print("y =  \(y) ")
//        }
//        else
//        {
//            print("no data for this key2")
//        }
//        
//        updatePinnedDisplay(image: pinFighter2, label: pinFighter2Label, loadingIndicator: image2Activity, pinnedFight: pinnedFighter2, loadingTimer: &timer2)
//        checkPinnedData()
        
    }
    
    @IBAction func deletePin3(_ sender: Any) {
//        deletePin3Button.alpha = 0
//        deletePin3Button.isEnabled = false
//        
//        UserDefaults.standard.removeObject(forKey: pinFighter3Key)
//        
//        if let y = UserDefaults.standard.stringArray(forKey: pinFighter3Key)
//        {
//            print("y =  \(y) ")
//        }
//        else
//        {
//            print("no data for this key3")
//        }
//        
//        updatePinnedDisplay(image: pinFighter3, label: pinFighter3Label, loadingIndicator: image3Activity, pinnedFight: pinnedFighter3, loadingTimer: &timer3)
//        checkPinnedData()
//        
        
    }
    //Functions used when the user clicks one of the pinned fighters. This will take them to the fighter info page and display the info of that fighter.
    func pinFighterClicked1()
    {
        print("pin 1 clicked info")
        selectedFighter.copyPinData(pinnedFighterFunction: pinnedFighter1.fighter)
        self.performSegue(withIdentifier: "GoToFighterInfo", sender: Any?.self)
    }
    func pinFighterClicked2()
    {
        print("pin 2 clicked info")
        selectedFighter.copyPinData(pinnedFighterFunction: pinnedFighter2.fighter)
        self.performSegue(withIdentifier: "GoToFighterInfo", sender: Any?.self)
    }
    func pinFighterClicked3()
    {
        print("pin 3 clicked info")
        selectedFighter.copyPinData(pinnedFighterFunction: pinnedFighter3.fighter)
        self.performSegue(withIdentifier: "GoToFighterInfo", sender: Any?.self)
    }
    func eventImageClicked()
    {
        selectedEvent = eventArray[0]
        self.performSegue(withIdentifier: "GoToEventInfo", sender: Any?.self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        timeCalc3.m_EndDate = eventArray[0].Date
        timeCalc3.m_StartTime = eventArray[0].StartTime
        

        closestEventImage.loadEventImageUsingCache(urlString: eventArray[0].Picture)

        //Add gesture reconisers to the images to allow them to be clicked.
        let gestureRecogniser1 = UITapGestureRecognizer(target: self, action: #selector(pinFighterClicked1))
        gestureRecogniser1.numberOfTapsRequired = 1
        
        let gestureRecogniser2 = UITapGestureRecognizer(target: self, action: #selector(pinFighterClicked2))
        gestureRecogniser2.numberOfTapsRequired = 1
        
        let gestureRecogniser3 = UITapGestureRecognizer(target: self, action: #selector(pinFighterClicked3))
        gestureRecogniser3.numberOfTapsRequired = 1
        
        let gestureRecogniser4 = UITapGestureRecognizer(target: self, action: #selector(eventImageClicked))
        gestureRecogniser4.numberOfTapsRequired = 1
        
        
        pinFighter1.layer.borderWidth = 2
        pinFighter1.layer.borderColor = UIColor.darkGray.cgColor
        
        pinFighter2.layer.borderWidth = 2
        pinFighter2.layer.borderColor = UIColor.darkGray.cgColor
        
        pinFighter3.layer.borderWidth = 2
        pinFighter3.layer.borderColor = UIColor.darkGray.cgColor
        

        //Can only have one gesture recogniser for each element so each element needs its own.
        pinFighter1.addGestureRecognizer(gestureRecogniser1)
        pinFighter2.addGestureRecognizer(gestureRecogniser2)
        pinFighter3.addGestureRecognizer(gestureRecogniser3)
        closestEventImage.addGestureRecognizer(gestureRecogniser4)
        
        if(pinArraysSet == false)
        {
            for i in 0...11
            {
                pinFighter1Array.append("")
                pinFighter2Array.append("")
                pinFighter3Array.append("")
            }
            pinArraysSet = true
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Function gets called every time the view appears, view did load only gets called the first time the view is loaded.
    //This can be used to refresh the images and display the new pinned fighter.
    override func viewDidAppear(_ animated: Bool) {
        
        
        timer5 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(printTime), userInfo: nil, repeats: true)
        timer5.fire()
        self.pinFighter1.image = nil
        self.pinFighter2.image = nil
        self.pinFighter3.image = nil
        
        //User can pin their favourite fighters. This displays their image on the home page and gives them quick access to that fighters page.
        //To determine if a fighter has been pinned a bool is saved to the device. 
        //When no fighters are pinned there will be no value stored under this key.
        //When a fighter is pinned this value is set to true.
        //This prevents the app crashing as it prevents it trying to access variables that might have nothing in them/not exist.
        
            //Check if there is some saved data using this key.
            //If there is then we can display the data.
            if let pinFight1 = UserDefaults.standard.stringArray(forKey: pinFighter1Key)
            {
                deletePin1Button.alpha = 1
                deletePin1Button.isEnabled = true
                image1Activity.startAnimating()
                pinFighter1.isUserInteractionEnabled = true
                print("true1")
                //Update labels on main thread
                //If there is a pinned fighter then we need to get the saved data and store it in pinnedFighter so it can be used elsewhere.
                pinnedFighter1.fighter.getSavedData(savedArray: pinFight1)
                pinnedFighter1.pinned = true
                self.pinFighter1.loadFighterImageUsingCache(urlString: pinnedFighter1.fighter.ListPic)
               // self.pinFighter1Label.text = pinFight1[fighterDictionary["Forename"]!] + "\n" + pinFight1[fighterDictionary["Surname"]!]
                self.pinFighter1Label.text = pinnedFighter1.fighter.Forename + "\n" + pinnedFighter1.fighter.Surname
                self.pinFighter1Label.sizeToFit()
            }
            else
            {
                pinFighter1Label.text = emptyPinSlotText
                pinFighter1.isUserInteractionEnabled = false
            }
            //Will need to add code here for when there is pinned data but there is not data for a specific number.
            if let pinFight2 = UserDefaults.standard.stringArray(forKey: pinFighter2Key)
            {
                deletePin2Button.alpha = 1
                deletePin2Button.isEnabled = true
                
                image2Activity.startAnimating()
                pinFighter2.isUserInteractionEnabled = true
                print("true2")
                //Update labels on main thread
                    pinnedFighter2.fighter.getSavedData(savedArray: pinFight2)
                pinnedFighter2.pinned = true
                    self.pinFighter2.loadFighterImageUsingCache(urlString: pinFight2[fighterDictionary["ListPic"]!])
                    self.pinFighter2Label.text = pinFight2[fighterDictionary["Forename"]!] + "\n" + pinFight2[fighterDictionary["Surname"]!]
                    self.pinFighter2Label.sizeToFit()
            }
            else
            {
                pinFighter2Label.text = emptyPinSlotText
                pinFighter2.isUserInteractionEnabled = false
            }
            if let pinFight3 = UserDefaults.standard.stringArray(forKey: pinFighter3Key)
            {
                deletePin3Button.alpha = 1
                deletePin3Button.isEnabled = true
                
                image3Activity.startAnimating()
                pinFighter3.isUserInteractionEnabled = true
                print("true3")
                    pinnedFighter3.fighter.getSavedData(savedArray: pinFight3)
                pinnedFighter3.pinned = true
                    self.pinFighter3.loadFighterImageUsingCache(urlString: pinFight3[fighterDictionary["ListPic"]!])
                    self.pinFighter3Label.text = pinFight3[fighterDictionary["Forename"]!] + "\n" + pinFight3[fighterDictionary["Surname"]!]
                    self.pinFighter3Label.sizeToFit()
            }
            else
            {
                pinFighter3Label.text = emptyPinSlotText
                pinFighter3.isUserInteractionEnabled = false
            }
 
        
        
        timer1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkImage1Loaded), userInfo: nil, repeats: true)
        timer1.fire()
        
        
        timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkImage2Loaded), userInfo: nil, repeats: true)
        timer2.fire()
        
        timer3 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkImage3Loaded), userInfo: nil, repeats: true)
        timer3.fire()
        
        timer4 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkEventImageLoaded), userInfo: nil, repeats: true)
        timer4.fire()
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer1.invalidate()
        timer2.invalidate()
        timer3.invalidate()
        timer5.invalidate()
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
