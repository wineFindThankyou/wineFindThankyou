//
//  MainViewController.swift
//  wineFindThankyou
//
//  Created by betty on 2022/01/23.
//

import UIKit
import NMapsMap
class MainViewController: UIViewController {
    
    private let arrCategoryName: [String] = [
            "전체 ",
            "개인샵",
            "체인샵",
            "치즈볼",
            "편의점",
            "대형마트",
            "창고형매장",
            "백화점"
    ]
    
   
    var arrCategoryImage: [String] = ["Tag","Tag","Tag","Tag","Tag","Tag","Tag","Tag"]
  //  @IBOutlet weak var mapView: NMFMapView!
   
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
            super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

}



extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCategoryName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else {return UICollectionViewCell()}
        cell.imageCell.image = UIImage(named: arrCategoryImage[indexPath.row]) ?? UIImage()
        cell.labelCell.text = arrCategoryName[indexPath.row]
          return cell
    }
    
    // CollectionView Cell의 Size
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let width: CGFloat = collectionView.frame.width / 3 - 1.0
            
            return CGSize(width: width, height: width)
        }
 
        // CollectionView Cell의 옆 간격
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 4.0
        }
    
    
    
}
