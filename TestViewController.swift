//
//  TestViewController.swift
//  MMApplication
//
//  Created by Kevin Stone on 03/01/2017.
//  Copyright © 2017 Kevin Stone. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UIWebViewDelegate {
    
    //Reference to the webview that will display the webpage inside the app.
      @IBOutlet weak var webView: UIWebView!

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //Function when the back button is pressed. Will go to previous webpage.
    @IBAction func backPressed(_ sender: Any) {
           self.webView.goBack()
        checkButtons()
    }
    //Function when the next button is pressed. Will go to next webpage.
    @IBAction func nextPressed(_ sender: Any) {
                self.webView.goForward()
        checkButtons()
    }
    //https://www.youtube.com/watch?v=UIKKMRwD0_Q
  
    
    @IBOutlet weak var backButton: UIBarButtonItem!

    @IBOutlet weak var nextButton: UIBarButtonItem!
      override func viewDidLoad() {
        super.viewDidLoad()
   
        self.webView.delegate = self
        indicator.isHidden = true
        //Problems were had trying to load ufc.com. This website uses http not https = its not secure. Apple doesnt
        //Allow connections to be made to insecure website. Need to disable this safety measure in .plist file.
        //URL of the website.
        var url = NSURL()
        if(promotion == .UFC)
        {
            url = NSURL (string: "http://m.ufc.com")!;
        }
        else
        {
            url = NSURL (string: "http://bellator.spike.com/")!;
        }
        
        let request = URLRequest(url: url as URL);
        
        
            webView.loadRequest(request)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //These functions are used to animate the progress indicator. This lets the user know that the app is trying to load the webpage.
    //Providing this feedback allows the user to know that the app hasnt crashed.
    func webViewDidStartLoad(_ webView: UIWebView) {
          indicator.isHidden = false
        indicator.startAnimating()
        
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
          indicator.isHidden = true
        indicator.stopAnimating()
        checkButtons()
    }
    
    func checkButtons()
    {
        //Only enable the next and back buttons if there is a previous or next webpage to go to.
        if (self.webView.canGoBack)
        {
            self.backButton.isEnabled = true
        }
        else{
            self.backButton.isEnabled = false
        }
        
        if (self.webView.canGoForward)
        {
            self.nextButton.isEnabled = true
        }
        else{
            self.nextButton.isEnabled = false
        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    //tab bar icon used for free with permission from
    //<a href="https://icons8.com/web-app/12452/Google-News">Google news icon credits</a>
}
