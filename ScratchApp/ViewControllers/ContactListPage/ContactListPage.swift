//
//  ContactListPage.swift
//  ScratchApp
//
//  Created by HTS-676 on 04/01/25.
//

import UIKit
import Contacts
import SwiftyJSON

class ContactListPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var contactList: [ContactModel] = []
    var responseContactList: [ContactResponseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ContactListTVCell", bundle: nil), forCellReuseIdentifier: "ContactListTVCell")
        if let responseJson = self.getResponseValue(){
            self.fetchContacts(responseJson)
        }
        
    }
    
    
    @IBAction func logoutAct(_ sender: Any) {
        let emailID = UserDefaults.standard.value(forKey: "email_id") as? String ?? ""
        EntityManagement.shared.deleteUser(email_id: emailID, success: {(status) in
            if status{
                UserDefaults.standard.set("", forKey: "email_id")
                appDelegate.setInitialViewControllers()
            }
        }, failure: {(failure) in
            debugPrint("error")
        })
    }
    
    
    /*func fetchContacts() { // fetch Local Contack
        let contactStore = CNContactStore()
        // Request access to contacts
        contactStore.requestAccess(for: .contacts) { granted, error in
            if granted {
                let keys = [
                    CNContactGivenNameKey,
                    CNContactFamilyNameKey,
                    CNContactPhoneNumbersKey,
                    CNContactThumbnailImageDataKey // Fetch thumbnail image
                ] as [CNKeyDescriptor]
                
                let request = CNContactFetchRequest(keysToFetch: keys)
                do {
                    try contactStore.enumerateContacts(with: request) { contact, stop in
                        let name = "\(contact.givenName) \(contact.familyName)"
                        let phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? "No Number"
                        let image = contact.thumbnailImageData != nil ? UIImage(data: contact.thumbnailImageData!) : nil
                        
                        let contactModel = ContactModel(name: name, phoneNumber: phoneNumber, image: image)
                        self.contactList.append(contactModel)
                    }
                    DispatchQueue.main.async {
                        print(self.contactList)
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Failed to fetch contacts: \(error.localizedDescription)")
                }
            } else {
                print("Access to contacts denied.")
            }
        }
    } */
    
    func getResponseValue() -> JSON? {
        if let path = Bundle.main.path(forResource: "DuplicateContactResponse", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
                let json = try JSON(data: jsonData)
                return json
            } catch {
                print("Error loading JSON: \(error)")
            }
        }
        return nil
    }
    
    func fetchContacts(_ value: JSON!){
        let contactJsonArray = value["contacts"].arrayValue
        for contact in contactJsonArray{
            let InitContact = ContactResponseModel(fromjson: contact)
            self.responseContactList.append(InitContact)
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return contactList.count
        return responseContactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListTVCell", for: indexPath) as! ContactListTVCell
        /*let contactObj = self.contactList[indexPath.row]
        cell.loadContactList(contactObj)*/
        let contactObj = self.responseContactList[indexPath.row]
        cell.loadResponseList(contactObj)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


