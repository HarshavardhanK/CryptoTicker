//
//  CrpytoTableViewController.swift
//  BitcoinTicker
//
//  Created by Harshavardhan K on 26/02/18.
//  Copyright © 2018 Harshavardhan K. All rights reserved.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var coinName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class CryptoTableViewController: UITableViewController {
    
    var cryptoCurrencies = [CryptoCoin]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.delegate = self
        tableView.dataSource = self
        
        //fill the array and table view
        cryptoCurrencies.append(CryptoCoin(coin: "Bitcoin", ticker: "BTC", image: UIImage(named:"bitcoin")!, basicURL: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=", backgroundForCoin: ["BitcoinView", "BitcoinView-1"]))
        cryptoCurrencies.append(CryptoCoin(coin: "Ethereum", ticker: "ETH", image: UIImage(named:"ethereum")!, basicURL: "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=" , backgroundForCoin: ["EthereumView", "EthereumView-1"]))
        cryptoCurrencies.append(CryptoCoin(coin: "Ripple", ticker: "XRP", image: UIImage(named:"ripple")!, basicURL: "https://min-api.cryptocompare.com/data/price?fsym=XRP&tsyms=" , backgroundForCoin: ["RippleView", "RippleView-1"]))
        
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.backgroundView = UIImageView(image: UIImage(named:"TableViewBackground"))
       // self.tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cryptoCurrencies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyIndentifier", for: indexPath) as? CryptoTableViewCell
        
        if indexPath.row % 2 == 0 {
            cell?.backgroundColor = UIColor.clear
            cell?.coinName.textColor = UIColor.gray
            
        } else {
            cell?.backgroundColor = UIColor.clear
            cell?.coinName.textColor = UIColor.black
        }
        
//        var backView = UIView()
//        backView.backgroundColor = UIColor.clear
//        cell.backgroundView = backView
//
        cell?.logoView.image = cryptoCurrencies[indexPath.row].image
        cell?.coinName.text = cryptoCurrencies[indexPath.row].coin
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "coins" {
            if let destination = segue.destination as? ViewController {
                destination.cryptoCoin = cryptoCurrencies[(tableView.indexPathForSelectedRow?.row)!]
                print("Segue suceeds!")
            }
        }
    }
    

}
