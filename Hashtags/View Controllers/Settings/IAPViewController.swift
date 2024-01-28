//
//  IAPTableViewController.swift
//  Hashtags
//
//  Created by Saud Almutlaq on 13/06/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import UIKit
import IAPurchaseManager
import StoreKit
import PKHUD

class IAPViewController: UIViewController {
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IAPManager.shared.loadProducts(productIds: [productID]) { (products: [SKProduct]?, error) in
            
            for product in products! {
                if product.productIdentifier == productID {
                    self.priceLabel.text = self.priceOf(product: products![0])
                    print("Product: \(product.productIdentifier) is at \(product.price) \(product.priceLocale.currencyCode!)")
                }
            }
        }
    }
    
    func priceOf(product: SKProduct) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.formatterBehavior = .behavior10_4
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product.priceLocale
        return numberFormatter.string(from: product.price)!
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
}
