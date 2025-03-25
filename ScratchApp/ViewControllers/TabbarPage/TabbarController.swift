//
//  TabbarController.swift
//  SwiftCoding
//
//  Created by HTS-676 on 11/12/24.
//

import UIKit

class TabbarController: UITabBarController, UITabBarControllerDelegate {
        
    let firstTab = ContactListPage()
    let secondTab = ThirdVC()
    
//    let tabbarView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadTabPage()
//        setView()
    }
    
//    private func setView(){
//          view.addSubview(tabbarView)
//          tabbarView.backgroundColor = .quaternarySystemFill
//          tabbarView.translatesAutoresizingMaskIntoConstraints = false
//          tabbarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
//          tabbarView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60).isActive = true
//          tabbarView.heightAnchor.constraint(equalToConstant: 60).isActive = true
//          tabbarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//          tabbarView.layer.cornerRadius = 30
//      }
        
    func loadTabPage(){
        firstTab.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        secondTab.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        viewControllers = [firstTab, secondTab]
    }

}
