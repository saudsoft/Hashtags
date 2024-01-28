//
//  ViewController.swift
//  Hashtags
//
//  Created by Saud Almutlaq on 21/05/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import GoogleMobileAds
import UIKit
import Photos
import TagListView
import IAPurchaseManager
import StoreKit

enum AppStoreReviewManager {
  static func requestReviewIfAppropriate() {
    
  }
}

class ViewController: UIViewController, TagListViewDelegate {
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var rewardedAd: GADRewardedAd?
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var hashtagListView: TagListView!
    @IBOutlet weak var superAdView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var selectedCount: UILabel!
    @IBOutlet weak var totalCount: UILabel!
    
    @IBAction func editHashtag(_ sender: Any) {
        if !IAPManager.shared.isProductPurchased(productId: productID) {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                self.initInterstitialAdView()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "hashtagsEditViewController") as! HashtagsEditViewController
                self.present(vc, animated: true, completion: nil)
//                print("Ad wasn't ready")
            }
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "hashtagsEditViewController") as! HashtagsEditViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func selectAllHashtags(_ sender: Any) {
        for tag in hashtagListView.tagViews {
            tag.isSelected = true
        }
        
        countSelected()
        
        // Show app review modal
//        SKStoreReviewController.requestReview()
    }
    
    @IBAction func copyHashtags(_ sender: Any) {
        var hashtagString = ""

        if hashtagListView.selectedTags().count > 0 {
            for tag in hashtagListView.selectedTags() {
                hashtagString.append(" \(tag.titleLabel?.text! ?? "")")
            }
        } else {
            showAlert(withTitle: "", andMessage: "لم تقم بتحديد أي هاشتاق لنسخه، حدد أولاً ثم انسخ.", inView: self)
        }
        
        UIPasteboard.general.string = hashtagString
        
        showAlert(withTitle: "", andMessage: "تم نسخ الهاشتاقات المحددة بنجاح، بإمكانك الآن لصقها في أي تطبيق تريده.", inView: self)
        
    }
    
    @IBAction func clearHashtag(_ sender: Any) {
        for tag in hashtagListView.selectedTags() {
            tag.isSelected = false
        }
        countSelected()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.integer(forKey: "tagViewFontSize") == 0 {
            print("ZERO")
            UserDefaults.standard.set(16, forKey: "tagViewFontSize")
        }
        
        tagViewFontSize = CGFloat(UserDefaults.standard.integer(forKey: "tagViewFontSize"))
        
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        updateView()
        if IAPManager.shared.isProductPurchased(productId: productID) {
            self.removeAdView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if !IAPManager.shared.isProductPurchased(productId: productID) {
            self.populateAds()
        } else {
            self.removeAdView()
        }
        
        //Looks for single or multiple taps.
        hashtagListView.delegate = self
        countSelected()
        
        setViewShadow(forView: hashtagListView)
//        updateView()
    }
    
    func populateAds() {
        initBannerAdView()
        addBannerViewToView(bannerView)
        
        // Interstitial Ad Init
        initInterstitialAdView()
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        self.adView.addSubview(bannerView)
    }
    
    func updateView() {
        getHashData()
        self.hashtagListView.removeAllTags()
        self.hashtagListView.addTags(hashtagsArray)
        self.hashtagListView.fontSize(ofSize: tagViewFontSize)
        countSelected()
        DispatchQueue.main.async {
            if !IAPManager.shared.isProductPurchased(productId: productID) {
                print("In prepare for interstitial ad")
                self.initInterstitialAdView()
            } else {
                self.removeAdView()
            }
        }
    }
    
    func countSelected() {
        var counter = 0
        var total = 0
        for tag in hashtagListView.tagViews {
            if tag.isSelected {
                counter += 1
            }
            total += 1
        }
        
        selectedCount.text = "\(counter)"
        totalCount.text = "\(total)"
    }
    
    func setViewShadow(forView yourView: UIView) {
//        yourView.layer.shadowColor = UIColor.black.cgColor
//        yourView.layer.shadowOpacity = 1
//        yourView.layer.shadowOffset = .zero
//        yourView.layer.shadowRadius = 10
//        yourView.layer.shadowPath = UIBezierPath(rect: yourView.bounds).cgPath
//        yourView.layer.shouldRasterize = true
    }
    
    func removeAdView() {
        print("running removeAdView")
        if IAPManager.shared.isProductPurchased(productId: productID) {
            print("adView not present!")
            if self.superAdView != nil {
                print("ad removed")
                self.superAdView.removeFromSuperview()
            }
        }
    }
    
    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
//        print("Tag pressed: \(title)")
        tagView.isSelected = !tagView.isSelected
        countSelected()
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
//        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
        countSelected()
    }
}
