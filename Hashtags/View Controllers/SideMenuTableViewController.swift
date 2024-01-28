//
//  SideMenuTableViewController.swift
//  Hashtags
//
//  Created by Saud Almutlaq on 29/05/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.appearance().semanticContentAttribute = .forceLeftToRight

        // refresh cell blur effect in case it changed
        tableView.reloadData()
        
        guard let menu = navigationController as? SideMenuNavigationController, menu.blurEffectStyle == nil else {
            return
        }
        
        // Set up a cool background image for demo purposes
//        let imageView = UIImageView(image: #imageLiteral(resourceName: "saturn"))
//        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
//        tableView.backgroundView = imageView
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! UITableViewVibrantCell
//
//        if let menu = navigationController as? SideMenuNavigationController {
//            cell.blurEffectStyle = menu.blurEffectStyle
//        }
//        
//        return cell
//    }
}
