//
//  InfoPanelViewController.swift
//  MMApplication
//
//  Created by Kevin Stone on 01/01/2017.
//  Copyright © 2017 Kevin Stone. All rights reserved.
//

import UIKit

class InfoPanelViewController: UIViewController {

    
    var websiteString = String()
    

    @IBOutlet weak var DesciptionBox: UILabel!

   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var Image1: UIImageView!
    @IBOutlet weak var Image2: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    titleLabel.center.x = self.view.center.x//centre the title label
       
        // Do any additional setup after loading the view.
        //Check what button is pressed.
        //Change title and text box to correct text.
        //This reduces the amount of different views needed. We dont need a different page for each technique. 
        if(buttonPressed == .Boxing)
        {
            
            titleLabel.text = boxing.m_title
            DesciptionBox.text = boxing.m_description
            Image1.image = #imageLiteral(resourceName: "Boxing-1")
            Image2.image = #imageLiteral(resourceName: "Boxing-2")
            websiteString = boxing.m_website
        }
        
        if(buttonPressed == .Karate)
        {
            
            titleLabel.text = karate.m_title
            DesciptionBox.text = karate.m_description
            Image1.image = #imageLiteral(resourceName: "Karate-1")
            Image2.image = #imageLiteral(resourceName: "Karate-2")
             websiteString = boxing.m_website
        }
        
        if(buttonPressed == .Kung_Fu)
        {
            
            titleLabel.text = kung_fu.m_title
            DesciptionBox.text = kung_fu.m_description
            Image1.image = #imageLiteral(resourceName: "KungFu-1")
            Image2.image = #imageLiteral(resourceName: "KungFu-2")
             websiteString = boxing.m_website
        }
        
        if(buttonPressed == .Kickboxing)
        {
            
            titleLabel.text = kickboxing.m_title
            DesciptionBox.text = kickboxing.m_description
            Image1.image = #imageLiteral(resourceName: "Kickboxing-1")
            Image2.image = #imageLiteral(resourceName: "Kickboxing-2")
             websiteString = boxing.m_website
        }
        
        if(buttonPressed == .BJJ)
        {
            
            titleLabel.text = bjj.m_title
            DesciptionBox.text = bjj.m_description
            Image1.image = #imageLiteral(resourceName: "BJJ-1")
            Image2.image = #imageLiteral(resourceName: "BJJ-2")
             websiteString = boxing.m_website
        }
        
        if(buttonPressed == .Wrestling)
        {
            
            titleLabel.text = wrestling.m_title
            DesciptionBox.text = wrestling.m_description
            Image1.image = #imageLiteral(resourceName: "Wrestling-3")
            Image2.image = #imageLiteral(resourceName: "Wrestling-2")
             websiteString = boxing.m_website
        }
        
        if(buttonPressed == .Taekwondo)
        {
            
            titleLabel.text = taekwondo.m_title
            DesciptionBox.text = taekwondo.m_description
            Image1.image = #imageLiteral(resourceName: "Taekwondo-1")
            Image2.image = #imageLiteral(resourceName: "Taekwondo-2")
            websiteString = boxing.m_website
        }
        
        if(buttonPressed == .Jiu_Jitsu)
        {
            
            titleLabel.text = jiu_jitsu.m_title
            DesciptionBox.text = jiu_jitsu.m_description
            Image1.image = #imageLiteral(resourceName: "Jiu-jitsu-1")
            Image2.image = #imageLiteral(resourceName: "Jiu-jitsu-2")
            websiteString = boxing.m_website
        }
        
        if(buttonPressed == .Judo)
        {
            
            titleLabel.text = judo.m_title
            DesciptionBox.text = judo.m_description
            Image1.image = #imageLiteral(resourceName: "Judo-1")
            Image2.image = #imageLiteral(resourceName: "Judo-2")
             websiteString = boxing.m_website
        }
        
         titleLabel.sizeToFit()
        
      //  Image1.image = #imageLiteral(resourceName: "default")
       // Image2.image = #imageLiteral(resourceName: "default")
        
    }
    
    
    
    @IBAction func webButton(_ sender: Any) {
        
        UIApplication.shared.open(NSURL(string:websiteString) as! URL, options: [:], completionHandler: nil)

        
        
        
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
