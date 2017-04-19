//
//  LoadingViewController.swift
//  MMApp1
//
//  Created by Kevin Stone on 05/04/2017.
//  Copyright © 2017 Kevin Stone. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Don't do a lot in this view. Can't animate the launchScreen.storyboard view controller so need to make a view in the main.Storyboard that is exactly the same as the launchScreen then the transition to start screen can be animated.
        self.performSegue(withIdentifier: "GoToStart", sender: Any?.self)
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
