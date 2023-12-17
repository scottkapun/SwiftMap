//
//  WalletViewController.swift
//  MetaMarket
//
//  Created by dan phi on 07/07/2023.
//  Copyright © 2023 Richard Neitzke. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var connertWalletLabel: UILabel!
    
    @IBOutlet weak var stepOneLabel: UILabel!
    @IBOutlet weak var stepThreeLabel: UILabel!
    @IBOutlet weak var stepTwoLabel: UILabel!
    
    @IBOutlet weak var finalLabel: UILabel!

    private var linkCode: String {
        get {
            guard let fileURL = Bundle.main.url(forResource: "file", withExtension: "txt") else {
                print("file.txt not found.")
                return ""
            }
            do {
                let linkCode = try String(contentsOf: fileURL, encoding: .utf8)
                return linkCode
            } catch {
                return ""
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = UIColor(named: "red")
        navigationItem.title = "Wallet"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        stepOneLabel.isUserInteractionEnabled = true
        stepOneLabel.addGestureRecognizer(tapGesture)
        
    }
    
    func setUpView() {
        headerLabel.text = "You haven't connected to your wallet!"
        headerLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headerLabel.numberOfLines = 0
        headerLabel.textAlignment = .center
        
        connertWalletLabel.text = "Please follow these steps to connect your wallet"
        connertWalletLabel.numberOfLines = 0
        connertWalletLabel.font = UIFont.systemFont(ofSize: 16)
       

  
        stepOneLabel.numberOfLines = 0
        let originalString = "Step 1: Please open url \nhttps://testnet.metamarket.top on your desktop browser and click Connect Wallet"
        let boldTexts = ["https://testnet.metamarket.top", "Connect Wallet"]
        let boldAttributedString = makeBoldString(inputString: originalString, boldTexts: boldTexts)
        stepOneLabel.attributedText = boldAttributedString
        
        stepTwoLabel.text = "Step 2: Enter this link code \(linkCode)"
        stepTwoLabel.numberOfLines = 0
        let code = stepTwoLabel.text?.withBoldText(boldText: " \(linkCode)", fullStringFont: UIFont.systemFont(ofSize: 16), boldFont: UIFont.systemFont(ofSize: 16, weight: .bold))
        stepTwoLabel.attributedText = code
        
        stepThreeLabel.text = "Step 3: Click Connect Metamask button"
        stepThreeLabel.numberOfLines = 0
        let connectWallet = stepThreeLabel.text?.withBoldText(boldText: " Connect Metamask", fullStringFont: UIFont.systemFont(ofSize: 16), boldFont: UIFont.systemFont(ofSize: 16, weight: .bold))
        stepThreeLabel.attributedText = connectWallet
        
        finalLabel.text =  "Then, your metamask extension on your browser will be connected to this device."
        finalLabel.numberOfLines = 0
        finalLabel.font = UIFont.systemFont(ofSize: 16)
        
    }
    @objc func labelTapped() {
            // Open the URL when the label is tapped
        let a: String? = "https://testnet.metamarket.top"
            if let urlString = a, let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
    
    func makeBoldString(inputString: String, boldTexts: [String]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: inputString)
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 17.0),

        ]
        
        for boldText in boldTexts {
            if let rangeToBold = inputString.range(of: boldText) {
                let nsRangeToBold = NSRange(rangeToBold, in: inputString)
                attributedString.addAttributes(boldAttributes, range: nsRangeToBold)
            }
        }
        
        return attributedString
    }
    

}
