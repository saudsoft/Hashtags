//
//  FunnyHashtagsViewController.swift
//  Hashtags
//
//  Created by Saud Almutlaq on 29/05/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import UIKit
import TagListView

class FunnyHashtagsViewController: UIViewController {
    @IBOutlet weak var hashtagListView: TagListView!

    override func viewWillAppear(_ animated: Bool) {
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        // Do any additional setup after loading the view.
    }
    
    func updateView() {
        getHashData()
        hashtagListView.removeAllTags()
        hashtagListView.addTags(hashtagsArray)
        hashtagListView.fontSize(ofSize: tagViewFontSize)
//        DispatchQueue.main.async {
//            if !IAPManager.shared.isProductPurchased(productId: productID) {
//                print("In prepare for interstitial ad")
//                self.initInterstitialAdView()
//            } else {
//                self.removeAdView()
//            }
//        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
