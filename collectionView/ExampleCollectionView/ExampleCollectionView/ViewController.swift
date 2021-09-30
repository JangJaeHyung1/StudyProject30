//
//  ViewController.swift
//  ExampleCollectionView
//
//  Created by jh on 2021/09/24.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var arr: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionCellUI()
        setSearchBar()
    }
}

// MARK: - collection VC delegate & dataSource

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.imageView.image = arr[indexPath.row]
        //        cell.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: CGFloat(Float(indexPath.row)/8))
        return cell
    }
}

// MARK: - collection VC flowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interval:CGFloat = 3
        let width: CGFloat = ( UIScreen.main.bounds.width - interval * 4 ) / 3
        return CGSize(width: width , height: width )
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    //collection VC section 마진값
    func collectionCellUI(){
        let interval:CGFloat = 3
        let flowLayout: UICollectionViewFlowLayout
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.init(top: interval , left: interval, bottom: 0, right: interval)
        self.collectionView.collectionViewLayout = flowLayout
    }
}


// MARK: - searchBar delegate

extension ViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //        print(searchBar.text)
        arr = []
        if let keyword = searchBar.text {
            requestFlickr(searchKey: keyword) { [weak self] photos in
                for i in 0 ... photos.count-1{
                    if let images = fetchImage(serverId: photos[i].server,
                                               photoId: photos[i].id,
                                               secretKey: photos[i].secret){
                        self?.arr.append(images)
                    }
                }
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                
            }
        }
    }
    
    func setSearchBar(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색할 키워드를 입력해 주세요."
        searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Flickr 이미지 검색"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

