//
//  TicketsViewController.swift
//  MMApp1
//
//  Created by Kevin Stone on 10/04/2017.
//  Copyright © 2017 Kevin Stone. All rights reserved.
//

import UIKit

class TicketsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,PayPalPaymentDelegate {
    
    //Paypal setting.
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    var resultText = "" // empty
    var payPalConfig = PayPalConfiguration() // default
    
    
    //Create ticket info.
    var tierArray = ["Floor - $1500","Tier 1 - $1000","Tier 2 - $500","Tier 3 - $250"]
    var ticketPrices = [1500,1000,500,250]
    var ticketArray = ["1","2","3","4"]
    
    var price: Int = 1500
    var numberOfTickets: Int = 0
    

    @IBOutlet weak var tierPicker: UIPickerView!
    
    @IBOutlet weak var ticketPicker: UIPickerView!
    
    @IBOutlet weak var priceLabel: UILabel!

    
    
    
    
    //When the paypal button is pressed we create the order and generate items, taxes, shipping etc. 
    //The user is then taken to the paypal view controller and asked to login.
    @IBAction func payPalButton(_ sender: Any) {
        
        // Optional: include multiple items
        let item1 = PayPalItem(name: "\(selectedEvent.Name) tickets", withQuantity: UInt(numberOfTickets), withPrice: NSDecimalNumber(string: "\(price)"), withCurrency: "USD", withSku: "Ticket")
        
        let items = [item1]
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "0.00")
        let tax = NSDecimalNumber(string: "2.50")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.adding(shipping).adding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "\(selectedEvent.Name) tickets", intent: .sale)
        
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
            print("Payment not processalbe: \(payment)")
        }
        
    }
    
    // PayPalPaymentDelegate
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        resultText = ""
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
        })
    }

    
    

    
    //Function used to update the price label.
    func setPriceLabel(price: Int,number: Int)
    {
        var cost = price * number
        priceLabel.text = "Total Price: $\(cost)"
        priceLabel.sizeToFit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("name = \(selectedEvent.Name)")
        
        price = ticketPrices[0]
        numberOfTickets = Int(ticketArray[0])!


        
        tierPicker.delegate = self
        tierPicker.dataSource = self
        
        ticketPicker.delegate = self
        ticketPicker.dataSource = self
        
        // Set up payPalConfig
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "MMApp, Inc."
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        
        
        
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        
        
        
        payPalConfig.payPalShippingAddressOption = .payPal;
        
        print("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")

    
        
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: environment)
        
        setPriceLabel(price: price, number: numberOfTickets)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Picker view functions
    
    //Function used to determine which row has been selected and update the variable correctly.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == tierPicker)
        {
            price = ticketPrices[row]
        }
        else
        {
            numberOfTickets = Int(ticketArray[row])!
        }
            setPriceLabel(price: price, number: numberOfTickets)
    }
    
    //Function used to set the title of a row.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == tierPicker)
        {
            return tierArray[row]
        }
        else
        {
            return ticketArray[row]
        }
    }
    //Function used to set the number of rows in the picker.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           if(pickerView == tierPicker)
           {
                return tierArray.count
           }
        else
           {
            return ticketArray.count
        }
    }
    
     public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
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
