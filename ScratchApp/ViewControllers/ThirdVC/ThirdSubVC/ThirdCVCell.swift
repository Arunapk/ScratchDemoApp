//
//  ThirdCVCell.swift
//  ScratchApp
//
//  Created by HTS-676 on 10/03/25.
//

import UIKit
import SDWebImage

class ThirdCVCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImgView: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func loadData(_ receipe: receipeModel?){
        itemNameLbl.text = receipe?.name
        let imgURL = URL(string: receipe?.image ?? "")
        itemImgView.sd_setImage(with: imgURL)
    }
}
