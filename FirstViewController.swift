//
//  FirstViewController.swift
//  MMApplication
//
//  Created by Kevin Stone on 20/12/2016.
//  Copyright © 2016 Kevin Stone. All rights reserved.
//

import UIKit



enum Button {
    case Boxing
    case Karate
    case Kung_Fu
    case Kickboxing
    case BJJ
    case Wrestling
    case Taekwondo
    case Jiu_Jitsu
    case Judo
}

var buttonPressed = Button.Boxing;
//Struct for each technique.
struct techniqueType {
    var m_title: String
    var m_description: String
    var m_website: String
}
//Store data for each technique.
var boxing = techniqueType(m_title:"Boxing",m_description:"The skill of fighting with the fists, usually with padded leather gloves. Referred to as the 'sweet science', boxers use elaborate foot manoeuvres and quick jabs for offence.", m_website:"https://en.wikipedia.org/wiki/Boxing")

var karate = techniqueType(m_title:"Karate",m_description:"Name used to identify many Japanese martial arts. Known for powerful, linear techniques, many karate stlyes also incorporate softer, circular techniques.", m_website:"https://en.wikipedia.org/wiki/Karate")

var kung_fu = techniqueType(m_title:"Kung Fu",m_description:"Referred to as Gung Fu or Chinese boxing. There are hundreds of Kung Fu styles. Many are patterned after movements of animals. Well known styles include Wing Chun, Praying Mantis, Pau Kua and Shuai Chiao.", m_website:"https://en.wikipedia.org/wiki/Chinese_martial_arts")

var kickboxing = techniqueType(m_title:"Kickboxing",m_description:"Sportive martial art combining boxing punches and martial arts kicks. Different styles include Muay Thai, full-contact karate and Asian Rules fighting.", m_website:"https://en.wikipedia.org/wiki/Kickboxing")

var bjj = techniqueType(m_title:"BJJ",m_description:"Brazilian Jiu-Jitsu focuses on grappling and ground fighting. Carlos and Helio Gracie helped refine the craft which involves joint locks and chokeholds such as armbars and rear naked chokes.", m_website:"https://en.wikipedia.org/wiki/Brazilian_jiu-jitsu")

var wrestling = techniqueType(m_title:"Wrestling",m_description:"The world's oldest sport in which two contestants struggle hand-to-hand, attempting to throw or take down their opponents without strikes. Styles include freestyle and greco-roman.", m_website:"https://en.wikipedia.org/wiki/Wrestling")

var taekwondo = techniqueType(m_title:"Taekwondo",m_description:"One of the most practiced martial arts in the world, taekwondo is a Korean style known for flashy kicking techniques.", m_website:"https://en.wikipedia.org/wiki/Taekwondo")

var jiu_jitsu = techniqueType(m_title:"Jiu-Jitsu",m_description:"Ancient Japanese martial art that encompasses throwing, joint locks, striking and weapons training.", m_website:"https://en.wikipedia.org/wiki/Jujutsu")

var judo = techniqueType(m_title:"Judo",m_description:"Sportive Japanese martial art wasa founded in 1882 by Jigoro Kano and derived from jiu-jitsu. Judo is now an Olympic sport emphasising throwing.", m_website:"https://en.wikipedia.org/wiki/Judo")


//tab bar image <a href="https://icons8.com/web-app/19680/Kicking">Kicking icon credits</a>

class FirstViewController: UIViewController {

    
    
    
    
    
    @IBOutlet weak var scrollview: UIScrollView!
    //When a button is pressed change value of the variable that tracks which button was pressed.
    @IBAction func judoButton(_ sender: Any) {
        buttonPressed = .Judo
    }

    @IBAction func bjjButton(_ sender: Any) {
        buttonPressed = .BJJ
    }

    @IBAction func jiuJitsuButton(_ sender: Any) {
        buttonPressed = .Jiu_Jitsu
    }

    @IBAction func taekwondoButton(_ sender: Any) {
        buttonPressed = .Taekwondo
    }
    @IBAction func wrestlingButton(_ sender: Any) {
        buttonPressed = .Wrestling
    }
    
    @IBAction func kickboxingButton(_ sender: Any) {
        buttonPressed = .Kickboxing
    }
    @IBAction func kungFuButton(_ sender: Any) {
        buttonPressed = .Kung_Fu
    }

    @IBAction func karateButton(_ sender: Any) {
        buttonPressed = .Karate
    }
    @IBAction func boxingButton(_ sender: Any) {
        
        buttonPressed = .Boxing
    }
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var KarateButton: UIButton!
    @IBOutlet weak var BoxingButton: UIButton!
    @IBOutlet weak var KungFuButton: UIButton!
    @IBOutlet weak var KickBoxingButton: UIButton!

    @IBOutlet weak var JiuJitsuButton: UIButton!
  
    @IBOutlet weak var BjjButton: UIButton!

    @IBOutlet weak var WrestlingButton: UIButton!
    @IBOutlet weak var TaekwondoButton: UIButton!

    @IBOutlet weak var JudoButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        

        
        
        
        
        
                    //Make the buttons circular.
        BoxingButton.layer.cornerRadius = BoxingButton.frame.size.width/2
        BoxingButton.setTitle(boxing.m_title, for: .normal)
    
       
        TitleLabel.text = "Fight Styles"
        TitleLabel.sizeToFit()
        TitleLabel.center.x = self.view.center.x//centre the title label
   
        BjjButton.layer.cornerRadius = BjjButton.frame.size.width/2
        BjjButton.setTitle(bjj.m_title, for: .normal)
        
  
        scrollview.contentSize.height = 950
        
        KarateButton.layer.cornerRadius = KarateButton.frame.size.width/2
        KarateButton.setTitle(karate.m_title, for: .normal)

        KungFuButton.layer.cornerRadius = KungFuButton.frame.size.width/2
        KungFuButton.setTitle(kung_fu.m_title, for: .normal)
        
        
        KickBoxingButton.layer.cornerRadius = KickBoxingButton.frame.size.width/2
        KickBoxingButton.setTitle(kickboxing.m_title, for: .normal)
        
        
        WrestlingButton.layer.cornerRadius = WrestlingButton.frame.size.width/2
        WrestlingButton.setTitle(wrestling.m_title, for: .normal)
        
        TaekwondoButton.layer.cornerRadius = TaekwondoButton.frame.size.width/2
        TaekwondoButton.setTitle(taekwondo.m_title, for: .normal)

        JiuJitsuButton.layer.cornerRadius = JiuJitsuButton.frame.size.width/2
        JiuJitsuButton.setTitle(jiu_jitsu.m_title, for: .normal)
        
        JudoButton.layer.cornerRadius = JudoButton.frame.size.width/2
        JudoButton.setTitle(judo.m_title, for: .normal)
        
        
        
        
           }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

