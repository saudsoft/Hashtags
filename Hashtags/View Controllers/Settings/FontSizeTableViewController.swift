//
//  FontSizeTableViewController.swift
//  Hashtags
//
//  Created by Saud Almutlaq on 13/06/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import UIKit
import TagListView

class FontSizeTableViewController: UITableViewController, TagListViewDelegate {
    @IBOutlet weak var hashtagBigFont: TagListView!
    @IBOutlet weak var hashtagMidFont: TagListView!
    @IBOutlet weak var hashtagSmlFont: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fontSizeOption()
    }

    func fontSizeOption() {
        hashtagBigFont.delegate = self
        hashtagMidFont.delegate = self
        hashtagSmlFont.delegate = self
        
        hashtagBigFont.fontSize(ofSize: 20)
        hashtagMidFont.fontSize(ofSize: 16)
        hashtagSmlFont.fontSize(ofSize: 12)
        
        hashtagBigFont.addTag("كبير")
        hashtagMidFont.addTag("وسط")
        hashtagSmlFont.addTag("صغير")
        
        hashtagBigFont.tagViews[0].tag = 0
        hashtagMidFont.tagViews[0].tag = 1
        hashtagSmlFont.tagViews[0].tag = 2
        
        let bitTagSize = hashtagBigFont.tagViews[0]
        hashtagBigFont.frame.size.width = bitTagSize.frame.size.width + 4
        let midTagSize = hashtagMidFont.tagViews[0]
        hashtagMidFont.frame.size.width = midTagSize.frame.size.width + 4
        let smlTagSize = hashtagSmlFont.tagViews[0]
        hashtagSmlFont.frame.size.width = smlTagSize.frame.size.width + 4
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectTagView(row: indexPath.row)
    }
    
    func selectTagView(row:Int) {
        if row == 0 {
            tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
            UserDefaults.standard.set(20, forKey: "tagViewFontSize")
            dismissView()
        } else if row == 1 {
            tableView.selectRow(at: IndexPath(row: 1, section: 0), animated: false, scrollPosition: .none)
            UserDefaults.standard.set(16, forKey: "tagViewFontSize")
            dismissView()
            
        } else if row == 2 {
            tableView.selectRow(at: IndexPath(row: 2, section: 0), animated: false, scrollPosition: .none)
            UserDefaults.standard.set(12, forKey: "tagViewFontSize")
            dismissView()
        }
    }
    
    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
        selectTagView(row: tagView.tag)
        //        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
    }
    
    func dismissView() {
        if let navController = presentingViewController as? UINavigationController {
            let presenter = navController.topViewController as! SettingsTableViewController
            presenter.setTagFontSize()
        }
        
        dismiss(animated: true, completion: nil)
    }
}
