//
//  NewConversationViewController.swift
//  Messenger
//
//  Created by Валентина Евдокимова on 16.10.2022.
//

import UIKit
import JGProgressHUD

class NewConversationViewController: UIViewController {
    
    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for user..."
        return searchBar
    }()
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    private let noResultLabel : UILabel = {
        let noResultLabel = UILabel()
        noResultLabel.text = "No result"
        noResultLabel.isHidden = true
        noResultLabel.textColor = .systemGray
        noResultLabel.textAlignment = .center
        return noResultLabel
        
    }()
    
    private let spinner = JGProgressHUD()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchBar.delegate = self
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissNewConversation))
        view.addSubview(noResultLabel)
        
    }
    
    @objc private func dismissNewConversation() {
        dismiss(animated: true)
    }
    


}
extension NewConversationViewController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
}
