//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Harshavardhan K on 26/02/18.
//  Copyright © 2018 Harshavardhan K. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    //MARK: Variables
    
    let baseDetailURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    var baseCryptoCompareAPI: String!
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""
    var data: JSON = JSON()
    
    //MARK: DATA
    var cryptoCoin: CryptoCoin?
    var currency: String = "AUD"
    
    var detailViewbackgroundColor: UIColor = UIColor()

    

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var coinImageView: UIImageView!
    
    //MARK: IBActions
    @IBAction func refreshButton(_ sender: UIButton) {
        print("refresh button pushed")
        getBitcoinPrice(url: finalURL, pickedCurrency: currency)
    }
    
    //MARK: Unwind Segue
    @IBAction func unwindToCoinView(unwindSegue: UIStoryboardSegue) {
        print("Unwound to CoinViewController")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Delegates and Data Source
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinImageView.image = cryptoCoin?.image
        baseCryptoCompareAPI = cryptoCoin?.basicURL
        //createGradientLayer()
        navigationItem.title = cryptoCoin?.coin
        
        let randomNumber = Int(arc4random() % 2)
        
        if randomNumber == 1 {
            detailViewbackgroundColor =  UIColor(patternImage: (cryptoCoin?.backgroundForCoin[0])!)

        } else {
            detailViewbackgroundColor =  UIColor(patternImage: (cryptoCoin?.backgroundForCoin[1])!)

        }
        
        self.view.backgroundColor = UIColor(patternImage: (cryptoCoin?.backgroundForCoin[randomNumber])!)
        
       
    }

        //MARK: CurrencyPicker delegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let string = currencyArray[row]
        return NSAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       //r currency =  currencyArray[0]
    
        currency = currencyArray[row]
        print(currency)
        finalURL = urlForAPI(currency: currencyArray[row])
        print(finalURL)
        
        
         getBitcoinPrice(url: finalURL, pickedCurrency: currencyArray[row])
                    
        //getCurrentPrice(data: data)
    }
    
    //MARK: UIRefresh Control
    
    
    
//    
//    //MARK: - Networking
//    /***************************************************************/
//    
    func getBitcoinPrice(url: String, pickedCurrency: String)  {
        
        Alamofire.request(url, method: .get).responseJSON { response in
            
            if response.result.isSuccess {
                print("Got the price sucessfully!")
                self.data = JSON(response.result.value)
                print(1)
                print(self.data)
                
                
                self.getCurrentPrice(currency: pickedCurrency)
                
            } else {
                print("Failed to fetch price!")
            }
            
        }
    }
//    //MARK: - JSON Parsing
//    /***************************************************************/
    
    //MARK: Private Functions
    
    private func getCurrentPrice(currency: String) {
        
        if let tempPrice = data[currency].double {
            print(tempPrice)
            bitcoinPriceLabel.text = "\(tempPrice)"
            
        } else {
            print("Couldnt fetch prices!")
        }
        
    }
    
    private func urlForAPI(currency: String) -> String {
        let finalAPI = baseCryptoCompareAPI + currency
        return finalAPI
    }
    //    MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            
            if let destinationDetailViewController = segue.destination as? DetailViewController {
                print("Segue to detailViewController suceeded!")
                
                if let ticker = cryptoCoin?.ticker {
                    
                    destinationDetailViewController.cryptoCoin = ticker
                    destinationDetailViewController.backgroundColor = detailViewbackgroundColor
                    print(ticker)

                } else {
                    print("Optional Chaining failed")
                }
                
                destinationDetailViewController.currency = currency
                
            }
        }
    }
 

}

