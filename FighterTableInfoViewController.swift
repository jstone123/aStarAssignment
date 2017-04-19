//
//  FighterTableInfoViewController.swift
//  MMApp1
//
//  Created by Kevin Stone on 22/02/2017.
//  Copyright © 2017 Kevin Stone. All rights reserved.
//

import UIKit

//<a href="https://icons8.com/web-app/7873/Pin-Filled">Pin filled icon credits</a>

//This variable is used by the whole app and it keeps a track of what fighter the user has selected from the primary table, search table or the pinned fighters from the homescreen. This will hold the fighter information and allows it to be used in multiple views.
var selectedFighter = Fighter()


//Function used when the user wants to pin a fighter.
func pinFighterFunction(pinnedFighter: inout PinnedFighter, pinFighterKey: String, pinFighterArray: inout [String]) -> Void
{
    pinnedFighter.fighter = selectedFighter
    pinnedFighter.pinned = true
    //Save the fighter that will be pinned to an array.
    pinnedFighter.fighter.saveUserDefaults(myArray: &pinFighterArray)
    //This array is then used to save the data rather than saving as 11 different strings.
    UserDefaults.standard.set(pinFighterArray, forKey: pinFighterKey)
}

class FighterTableInfoViewController: UIViewController {
    //Function used to create the alert popups. These provide info to the user when they are trying to pin fighters.
    //This alert is used when the user tries to pin a fighter when they already have 3 fighters pinned.
    func createAlert(title: String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        var title1 = ""
        var title2 = ""
        var title3 = ""
        
        if(!pinnedFighter1.pinned)
        {
            title1 = "Empty Slot"
        }
        else
        {
            title1 = "\(pinnedFighter1.fighter.Forename) \(pinnedFighter1.fighter.Surname)"
        }
        if(!pinnedFighter2.pinned)
        {
            title2 = "Empty Slot"
        }
        else
        {
            title2 = "\(pinnedFighter2.fighter.Forename) \(pinnedFighter2.fighter.Surname)"
        }
        if(!pinnedFighter3.pinned)
        {
            title3 = "Empty Slot"
        }
        else
        {
            title3 = "\(pinnedFighter3.fighter.Forename) \(pinnedFighter3.fighter.Surname)"
        }
        //4 options are presented to the user. They can choose to replace an already pinned fighter or just cancel the operation
        alert.addAction(UIAlertAction(title: "1. \(title1)", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            pinFighterFunction(pinnedFighter: &pinnedFighter1, pinFighterKey: pinFighter1Key, pinFighterArray: &pinFighter1Array)
        }))
        
        alert.addAction(UIAlertAction(title: "2. \(title2)", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            pinFighterFunction(pinnedFighter: &pinnedFighter2, pinFighterKey: pinFighter2Key, pinFighterArray: &pinFighter2Array)
        }))
        alert.addAction(UIAlertAction(title: "3. \(title3)", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            pinFighterFunction(pinnedFighter: &pinnedFighter3, pinFighterKey: pinFighter3Key, pinFighterArray: &pinFighter3Array)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            return
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func pinFighterButton(_ sender: Any) {

        UserDefaults.standard.set(true, forKey: fighterIsPinned)
        //Need to make it so that when the user has 3 pinned fighters the alert will ask them if they want to overwrite a fighter.
        //The user can pick any fighter to overwrite.
        
        //When the user tries to pin a fighter, check if the fighter is already pinned. If it is then create an alert to notify them.
        if( (pinnedFighter1.pinned == true && selectedFighter.Forename == pinnedFighter1.fighter.Forename && selectedFighter.Surname == pinnedFighter1.fighter.Surname) || (pinnedFighter2.pinned == true && selectedFighter.Forename == pinnedFighter2.fighter.Forename && selectedFighter.Surname == pinnedFighter2.fighter.Surname) || (pinnedFighter3.pinned == true && selectedFighter.Forename == pinnedFighter3.fighter.Forename && selectedFighter.Surname == pinnedFighter3.fighter.Surname))
        {
                //Create alert.
              let alertSame = UIAlertController(title: "Pin Fighter", message: "\(selectedFighter.Forename) \(selectedFighter.Surname) is already pinned.", preferredStyle: .alert)
            
            alertSame.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                alertSame.dismiss(animated: true, completion: nil)
            }))
            self.present(alertSame, animated: true, completion: nil)

        }
        //If 3 fighter are pinned then create alert letting them know and give option to replace a fighter.
        else if(pinnedFighter1.pinned == true && pinnedFighter2.pinned == true && pinnedFighter3.pinned == true)
        {
        createAlert(title: "Pin Fighter", message: "You can only pin 3 fighters. Select a fighter you want to unpin to pin this one.")
        }
        else if(pinnedFighter1.pinned == false)
        {
            //print("pin1")
            pinFighterFunction(pinnedFighter: &pinnedFighter1, pinFighterKey: pinFighter1Key, pinFighterArray: &pinFighter1Array)
        }
        else if(pinnedFighter2.pinned == false)
        {
           // print("pin2")
            pinFighterFunction(pinnedFighter: &pinnedFighter2, pinFighterKey: pinFighter2Key, pinFighterArray: &pinFighter2Array)
        }
        else if(pinnedFighter3.pinned == false)
        {
           // print("pin3")
            pinFighterFunction(pinnedFighter: &pinnedFighter3, pinFighterKey: pinFighter3Key, pinFighterArray: &pinFighter3Array)
        }
    }

    @IBOutlet weak var fighterImage: UIImageView!

    @IBOutlet weak var forenameLabel: UILabel!

    @IBOutlet weak var surnameLabel: UILabel!
    
    @IBOutlet weak var nicknameLabel: UILabel!

    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var recordLabel: UILabel!
    
    @IBOutlet weak var reachLabel: UILabel!

    @IBOutlet weak var nextFightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var previousFiveFightsLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        //Get the larger body image of the fighter.
        self.fighterImage.loadFighterImageUsingCache(urlString: selectedFighter.PagePic);

        
        forenameLabel.text = "\(selectedFighter.Forename)"
        surnameLabel.text = "\(selectedFighter.Surname)"
        if(selectedFighter.Nickname != "N/A")
        {
            nicknameLabel.text = "\(selectedFighter.Nickname)"
        }
        
        forenameLabel.textColor = UIColor.red
        forenameLabel.sizeToFit()
        
        surnameLabel.textColor = UIColor.red
        surnameLabel.sizeToFit()
        
        nicknameLabel.textColor = UIColor.red
        nicknameLabel.sizeToFit()
        
        //The first part of the label is bold and the second part is normal text. Rather than using 2 sepearte labels just use on and use attributed text.
        var boldText  = "Country: "
        var attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
        var attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        var normalText = "\(selectedFighter.Country)"
        var normalString = NSMutableAttributedString(string:normalText)
        
        attributedString.append(normalString)
        countryLabel.attributedText = attributedString
        countryLabel.textColor = UIColor.black
        countryLabel.sizeToFit()
        
        boldText  = "Record: "
        attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
        attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        normalText = "\(selectedFighter.Record)"
        normalString = NSMutableAttributedString(string:normalText)
        
        attributedString.append(normalString)
        recordLabel.attributedText = attributedString
        recordLabel.textColor = UIColor.black
        recordLabel.sizeToFit()
        
      
        boldText  = "Height: "
        attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
        attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        normalText = "\(selectedFighter.Height)"
        normalString = NSMutableAttributedString(string:normalText)
        
        attributedString.append(normalString)
        heightLabel.attributedText = attributedString
        heightLabel.textColor = UIColor.black
        heightLabel.sizeToFit()
        
        boldText  = "Reach: "
        attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
        attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        normalText = "\(selectedFighter.Reach)"
        normalString = NSMutableAttributedString(string:normalText)
        
        attributedString.append(normalString)
        reachLabel.attributedText = attributedString
        reachLabel.textColor = UIColor.black
        reachLabel.sizeToFit()
        
        
        boldText  = "Next Fight: "
        attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
        attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        normalText = "Max Holloway - UFC 212"
        //normalText = "\(selectedFighter.NextFight)"
        normalString = NSMutableAttributedString(string:normalText)
        
        attributedString.append(normalString)
        nextFightLabel.attributedText = attributedString
        nextFightLabel.textColor = UIColor.black
        nextFightLabel.sizeToFit()
        
        
        boldText  = "Last Fight: "
        attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
        attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        normalText = "Frankie Edgar - UFC 200"
      //  normalText = "\(selectedFighter.LastFight)"
        normalString = NSMutableAttributedString(string:normalText)
        
        attributedString.append(normalString)
        previousFiveFightsLabel.attributedText = attributedString
        previousFiveFightsLabel.textColor = UIColor.black
        previousFiveFightsLabel.sizeToFit()
        
        
        boldText  = "Summary: "
        attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
        attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        normalText = "Having been undefeated for 10 years, no one expected Jose Aldo to be dispatched so easily by Conor Mcgregor. It took just 13 seconds for him to lose the belt at UFC 194. After a solid performance at UFC 200 over Frankie Edgar to become the Interim Featherweight Champion, he was crowned Official Champion after McGregor was stripped. He will defend the belt at UFC 212 against the Interim Champion Max Holloway."
        //normalText = selectedFighter.Summary
        normalString = NSMutableAttributedString(string:normalText)
        
        attributedString.append(normalString)
        summaryLabel.attributedText = attributedString
        summaryLabel.textColor = UIColor.black
        summaryLabel.sizeToFit()
                
        // Do any additional setup after loading the view.
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
