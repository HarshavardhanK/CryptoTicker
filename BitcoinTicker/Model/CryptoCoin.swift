//
//  CrptoCoin.swift
//  BitcoinTicker
//
//  Created by Harshavardhan K on 26/02/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class CryptoCoin {
    
    var coin: String
    var ticker: String
    var image: UIImage
    var basicURL: String
    var backgroundForCoin: [UIImage]
    var currentBackground: UIImage
    
    init(coin: String, ticker: String, image: UIImage, basicURL: String, backgroundForCoin: [String]) {
        
        self.coin = coin
        self.image = image
        self.ticker = ticker
        self.basicURL = basicURL
        self.backgroundForCoin = [UIImage(named:backgroundForCoin[0])!, UIImage(named: backgroundForCoin[1])!]
        
        self.currentBackground = self.backgroundForCoin[Int(arc4random() % 2)]
        
    }
    
    
}
