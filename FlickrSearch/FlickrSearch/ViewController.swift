//
//  ViewController.swift
//  FlickrSearch
//
//  Created by jh on 2021/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    //    let apiKey = "be83bddb963d2ad00bcb99f8c9c43e1f"
    
    private var searches: [FlickrSearchResults] = []
    private let flickr = Flickr()
    
    
    
    @IBAction func selectBtn(_ sender: UIBarButtonItem) {
        print("btn pressed")
        var selectedLabel = UIBarButtonItem(title: "0 photos selected", style: .plain, target: .none, action: nil)
        
        selectedLabel.tintColor = .systemGreen
        if self.navigationItem.rightBarButtonItems?.count == 1{
            self.navigationItem.rightBarButtonItems?.append(selectedLabel)
        }
    }
    
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.setupSearchController()
        collectionCellUI()
    }
    
    
}



// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDelegateFlowLayout, UIScrollViewDelegate , UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches[section].searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        
        let flickrPhoto = searches[indexPath.section].searchResults[indexPath.row]
        cell.backgroundColor = .white
        cell.cellImage.image = flickrPhoto.thumbnail
        return cell
    }
    
//    func setupSearchController() {
//        let searchBar = UISearchBar()
//        searchBar.placeholder = "Search"
//        self.navigationItem.titleView = searchBar
//        self.navigationItem.rightBarButtonItem?.tintColor = .systemGreen
//    }
    
    // MARK: - collectionView UI
    
    func collectionCellUI(){
        let interval:CGFloat = 5
        let flowLayout: UICollectionViewFlowLayout
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.init(top: interval , left: interval, bottom: 0, right: interval)
        flowLayout.minimumInteritemSpacing = interval
        flowLayout.minimumLineSpacing = interval
        let width: CGFloat = ( UIScreen.main.bounds.width - interval) / 3
        flowLayout.itemSize = CGSize(width: width - interval, height: width - interval)
        
        self.imageCollectionView.collectionViewLayout = flowLayout
    }
    
}


// MARK: - Text Field Delegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text, !text.isEmpty else { return true }
        
        // 1
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
        flickr.searchFlickr(for: text) { searchResults in
            DispatchQueue.main.async {
                activityIndicator.removeFromSuperview()
                
                switch searchResults {
                case .failure(let error) :
                    print("Error Searching: \(error)")
                    
                case .success(let results):
                    print(results)
                    self.searches.insert(results, at: 0)
                    self.imageCollectionView.reloadData()
                }
            }
        }
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
}

