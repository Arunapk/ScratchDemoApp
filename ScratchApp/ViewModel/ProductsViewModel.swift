//
//  ProductsViewModel.swift
//  ScratchApp
//
//  Created by HTS-676 on 24/02/25.
//

import Combine
import Foundation

class ProductsViewModel{
    
    public var cancelable = Set<AnyCancellable>()
    private let service = NetworkManager.shared
    @Published private(set) public var receipeData: receipeListModel?

    func getListOfData(){
        service.APIRequest(endPoints: .recipes, Method: .get, completion: { [weak self] (result: Result<receipeListModel, NetworkError>) in
            switch result {
            case .success(let receipeModel):
                self?.receipeData = receipeModel
                return
            case .failure(_):
                return
            }
        })
    }
    
}
