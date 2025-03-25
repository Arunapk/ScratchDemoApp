//
//  CustomButton.swift
//  ScratchApp
//
//  Created by HTS-676 on 07/02/25.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .blue
    }
}
