//
//  extensionFiles.swift
//  ScratchApp
//
//  Created by HTS-676 on 03/02/25.
//

import Foundation

//MARK: STRING
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
