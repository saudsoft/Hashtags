//
//  SettingsViewController.swift
//  Hashtags
//
//  Created by Saud Almutlaq on 13/06/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import UIKit
import TagListView

class SettingsTableViewController: UITableViewController, TagListViewDelegate {
    @IBOutlet weak var numberType: UISegmentedControl!
    @IBOutlet weak var fontSizeText: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        setTagFontSize()
        print("*************viewWillAppear***********")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
        let selectedNumberType = UserDefaults.standard.bool(forKey: "numberType")
        
        if selectedNumberType {
            numberType.selectedSegmentIndex = 1
            print("AR")
        } else {
            numberType.selectedSegmentIndex = 0
            print("EN")
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func numberTypeChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
    
    func setTagFontSize() {
        let tagViewFontSize = UserDefaults.standard.integer(forKey: "tagViewFontSize")
        
        if tagViewFontSize == 20 {
            fontSizeText.text = "كبير"
        } else if tagViewFontSize == 16 {
            fontSizeText.text = "وسط"
        } else if tagViewFontSize == 12 {
            fontSizeText.text = "صغير"
        } else {
            fontSizeText.text = "وسط"
            UserDefaults.standard.set(16, forKey: "tagViewFontSize")
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

}
