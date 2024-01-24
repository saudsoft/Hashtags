//
//  InfoViewController.swift
//  Hashtags
//
//  Created by Saud Almutlaq on 22/05/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import UIKit
import IAPurchaseManager
import StoreKit
import SafariServices
import PKHUD

class InfoViewController: UIViewController {
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func facebook(_ sender: Any) {
        open(scheme: "https://www.facebook.com/saudsoft")
    }
    
    @IBAction func website(_ sender: Any) {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = false

        let url = URL(string: "https://saudsoft.com")
        let vc = SFSafariViewController(url: url!, configuration: config)
        present(vc, animated: true)    }
    
    @IBAction func twitter(_ sender: Any) {
        open(scheme: "https://twitter.com/saudsoft")
    }
    
    @IBAction func purchaseRemoveAds(_ sender: Any) {
        HUD.show(.progress)
        if IAPManager.shared.canMakePayments() {
            print("CanMakePayments")
            IAPManager.shared.purchaseProductWithId(productId: productID) { (error) in
                
                if error == nil {
                    HUD.hide()
                    // successful purchase!
                    showAlert(withTitle: "نجاح", andMessage: "تم شراء إلغاء الاعلانات بنجاح.", inView: self)
                    print("successful purchase!")
                } else {
                    HUD.hide()
                    print("something wrong..")
//                    print(error?.localizedDescription)
                    // something wrong..
                }
            }
        } else {
            showAlert(withTitle: "خطأ", andMessage: "غير قادر على الاتصال بمتجر التطبيقات، يرجى المحاولة مرة أخرى والتحقق من اتصال الإنترنت", inView: self)
        }
    }
    
    @IBAction func restorePurchase(_ sender: Any) {
        HUD.show(.progress)
        if IAPManager.shared.canMakePayments() {
            print("CanMakePayments")
            IAPManager.shared.restoreCompletedTransactions { (error) in
                if error != nil {
                    HUD.hide()
//                    print(error)
                    showAlert(withTitle: "خطأ", andMessage: "حدث خطأ أثناء محاولة استعادة المشتريات، قد لا تكون قد اشتريت الخدمة بعد، يمكنك محاولة الشراء مرة أخرى، لا تخف إن كنت اشتريتها سابقاً لن يتم خصم المبلغ مرة أخرى", inView: self)
                } else {
                    HUD.hide()
                    showAlert(withTitle: "نجاح", andMessage: "تم استعادة مشترياتك وسيتم إخفاء الإعلانات، في حال الضرورة يرجى إغلاق التطبيق وإعادة فتحه.", inView: self)
                    print("Restore Successful")
                }
            }
        } else {
            showAlert(withTitle: "خطأ", andMessage: "غير قادر على الاتصال بمتجر التطبيقات، يرجى المحاولة مرة أخرى والتحقق من اتصال الإنترنت", inView: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Purchasing AdRemove: \(IAPManager.shared.isProductPurchased(productId: productID))")
    }
    
    /// This func will try to open social app or if fail will open safari to website
    /// - parameters:
    ///   - scheme: The website URL for the social app
    ///
    /** Example Call:
     
     @IBAction func instagramClicked(_ sender: Any) {
     open(scheme: "http://www.instagram.com/profileName")
     }
     */
    func open(scheme: String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                                            print("Open \(scheme): \(success)")
                })
            } else {
                let success = UIApplication.shared.openURL(url)
                print("Open \(scheme): \(success)")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillDisappear(_ animated: Bool) {
        if let firstVC = presentingViewController as? ViewController {
            DispatchQueue.main.async {
                firstVC.removeAdView()
            }
        }
    }
}
