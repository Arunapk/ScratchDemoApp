//
//  ContactListTVCell.swift
//  ScratchApp
//
//  Created by HTS-676 on 04/01/25.
//

import UIKit
import SDWebImage

class ContactListTVCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        userImage.layer.cornerRadius = self.userImage.frame.height / 2.0
        userImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadContactList(_ contact: ContactModel?){
        self.userName.text = contact?.name
        self.phoneNumber.text = contact?.phoneNumber
        self.userImage.image = contact?.image ?? UIImage(systemName: "person.crop.circle")
    }
    
    func loadResponseList(_ list: ContactResponseModel?){
        self.userName.text = list?.name
        self.phoneNumber.text = list?.phone_no
        self.userImage.sd_setImage(with: URL(string: (list?.photo)!), placeholderImage: UIImage(systemName: "person.crop.circle"))
    }
    
}
