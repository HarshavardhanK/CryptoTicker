//
//  DetailTableViewController.swift
//  BitcoinTicker
//
//  Created by Harshavardhan K on 26/02/18.
//  Copyright © 2018 Harshavardhan K. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class DetailViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    
    //MARK: Properties
    let detailBaseAPI = "https://min-api.cryptocompare.com/data/histoday?fsym="
    var cryptoCoin: String = ""
    var currency: String = ""
    var data: JSON!
    var backgroundColor: UIColor!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColor
        print(finalAPICall())
        getDetailedPricingData(url: finalAPICall())
        
        

    }
    
    //MARK: Networking Alamofire
    
    func getDetailedPricingData(url: String)  {
        
        Alamofire.request(url, method: .get).responseJSON { response in
            
            if response.result.isSuccess {
                print("Got the price sucessfully!")
                self.data = JSON(response.result.value)
                print(1)
                print(self.data)
                
                
                self.getCurrentPrice(currency: self.currency)
                
            } else {
                print("Failed to fetch price!")
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Final API Call
    private func finalAPICall() -> String {
        
        return detailBaseAPI + cryptoCoin + "&tsym=" + currency + "&limit=1"
    }
    
    //    //MARK: - JSON Parsing
    //    /***************************************************************/
    
    //MARK: Private Functions
    
    private func getCurrentPrice(currency: String) {
        
        if let openPrice = data["Data"][0]["open"].int, let highPrice = data["Data"][0]["high"].int, let lowPrice = data["Data"][0]["low"].int {
            
            print(openPrice)
            
            openLabel.text = "\(openPrice)"
            highLabel.text = "\(highPrice)"
            lowLabel.text = "\(lowPrice)"
            
        } else {
            print("Couldnt parse prices!")
        }
        
    }

     
}
