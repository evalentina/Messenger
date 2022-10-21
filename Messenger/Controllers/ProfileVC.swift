//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Валентина Евдокимова on 16.10.2022.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class ProfileViewController: UIViewController {
    
    let data = ["Log out"]
    
    private let scrollView : UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    
    private let tableView : UITableView = {
        var tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(scrollView)
        scrollView.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        tableView.frame = view.bounds
    }
}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Log out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        let logOut = UIAlertAction(title: "Log out", style: .destructive) { [weak self] _ in
            guard let self = self else {
                return
            }
            FBSDKLoginKit.LoginManager().logOut()
            do {
                try FirebaseAuth.Auth.auth().signOut()
            } catch {
                print("Error to sign out")
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(logOut)
        alert.addAction(cancel)
        present(alert, animated: true)
        
    }
    
    
    
}
