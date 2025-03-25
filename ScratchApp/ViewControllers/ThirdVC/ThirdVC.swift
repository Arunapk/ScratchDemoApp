//
//  ThirdVC.swift
//  ScratchApp
//
//  Created by HTS-676 on 06/02/25.
//

import UIKit

class ThirdVC: UIViewController{
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = ProductsViewModel()
    var _listData = [receipeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCV()
        setupListener()
        viewModel.getListOfData()
    }
    
    private func setupListener(){
        viewModel.$receipeData
            .sink(receiveValue: { [weak self] (receiveValue) in
                guard let self = self else{ return }
                DispatchQueue.main.async(execute: updateUI)
            })
            .store(in: &viewModel.cancelable)
    }
    
    private func updateUI(){
        _listData = viewModel.receipeData?.receipeList ?? []
        self.collectionView.reloadData()
    }
    
    
    
}

extension ThirdVC: UICollectionViewDelegate, UICollectionViewDataSource {
    private func initCV(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ThirdCVCell", bundle: nil), forCellWithReuseIdentifier: "ThirdCVCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        _listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCVCell", for: indexPath) as! ThirdCVCell
        let listItem = _listData[indexPath.item]
        cell.loadData(listItem)
        return cell
    }
}

/*
 "id": 1,
 "name": "Classic Margherita Pizza",
 "ingredients": [
 "Pizza dough",
 "Tomato sauce",
 "Fresh mozzarella cheese",
 "Fresh basil leaves",
 "Olive oil",
 "Salt and pepper to taste"
 ],
 "instructions": [
 "Preheat the oven to 475°F (245°C).",
 "Roll out the pizza dough and spread tomato sauce evenly.",
 "Top with slices of fresh mozzarella and fresh basil leaves.",
 "Drizzle with olive oil and season with salt and pepper.",
 "Bake in the preheated oven for 12-15 minutes or until the crust is golden brown.",
 "Slice and serve hot."
 ],
 "prepTimeMinutes": 20,
 "cookTimeMinutes": 15,
 "servings": 4,
 "difficulty": "Easy",
 "cuisine": "Italian",
 "caloriesPerServing": 300,
 "tags": [
 "Pizza",
 "Italian"
 ],
 "userId": 166,
 "image": "https://cdn.dummyjson.com/recipe-images/1.webp",
 "rating": 4.6,
 "reviewCount": 98,
 "mealType": [
 "Dinner"
 ]
 }
 */


