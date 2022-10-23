//
//  ViewController.swift
//  Messenger
//
//  Created by Валентина Евдокимова on 16.10.2022.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class ConversationsViewController: UIViewController {
    
    private let tableView : UITableView = {
        var tableView = UITableView()
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    private let noConversationsLabel : UILabel = {
        var noConversationsLabel = UILabel()
        noConversationsLabel.text = "No conversations"
        noConversationsLabel.textColor = .systemGray
        noConversationsLabel.font = .systemFont(ofSize: 21)
        noConversationsLabel.isHidden = true
        return noConversationsLabel
    }()
    
    private let spinner = JGProgressHUD(style: .dark)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(navigationButton))
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(noConversationsLabel)
        view.addSubview(tableView)
        fetchConversations() 
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav,animated:  false)
        }
    }
    
    private func fetchConversations() {
        tableView.isHidden = false
    }
    
    @objc private func navigationButton() {
        let vc = NewConversationViewController()
        let nv = UINavigationController(rootViewController: vc)
        present(nv, animated: true)
    }


}

extension ConversationsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Yandex HR"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
        let vc = ChatViewController()
        vc.title = "Yandex HR"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

