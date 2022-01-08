//
//  FirstViewController.swift
//  YandexMapsDemo
//
//  Created by NODIR KARIMOV on 07/01/22.
//

import UIKit

class FirstViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9763746858, green: 0.9765380025, blue: 0.9806585908, alpha: 1)
        
        tableView.rowHeight = 80
        
        tableView.separatorInset.left = 20
        tableView.separatorInset.right = 20
        
        configureNavController()
    }
    
    func configureNavController() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width / 2, height: view.frame.height))
        titleLabel.text = "Мои адреса"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 19)
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.barTintColor = UIColor.white
    }
 
}

