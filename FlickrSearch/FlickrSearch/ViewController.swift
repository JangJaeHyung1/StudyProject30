//
//  ViewController.swift
//  FlickrSearch
//
//  Created by jh on 2021/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    private let sectionInsets = UIEdgeInsets(
        top: 50.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0)
    
    //    let apiKey = "be83bddb963d2ad00bcb99f8c9c43e1f"
    
    private var searches: [FlickrSearchResults] = []
    private let flickr = Flickr()
    
    
    
    @IBAction func selectBtn(_ sender: UIBarButtonItem) {
        print("btn pressed")
        var selectedLabel = UIBarButtonItem(title: "0 photos selected", style: .plain, target: .none, action: nil)
        //        selectedLabel.isEnabled = false
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
extension ViewController: UICollectionViewDelegateFlowLayout, UISearchResultsUpdating, UIScrollViewDelegate , UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches[section].searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        let flickrPhoto = photo(for: indexPath)
        cell.backgroundColor = .white
        cell.cellImage.image = flickrPhoto.thumbnail
        return cell
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let keyword = searchController.searchBar.text {
            print(keyword)
        }
    }
    
    func setupSearchController() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem?.tintColor = .systemGreen
    }
    
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
        self.imageCollectionView.reloadData()
    }
    
    private func createSpinenerFooter() -> UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
}

// MARK: - Private
private extension ViewController {
    func photo(for indexPath: IndexPath) -> FlickrPhoto {
        return searches[indexPath.section].searchResults[indexPath.row]
    }
}


// MARK: - Text Field Delegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard
            let text = textField.text,
            !text.isEmpty
        else { return true }
        
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
                    // 2
                    print("Error Searching: \(error)")
                case .success(let results):
                    // 3
                    print("""
            Found \(results.searchResults.count) \
            matching \(results.searchTerm)
            """)
                    self.searches.insert(results, at: 0)
                    // 4
                    self.imageCollectionView.reloadData()
                }
            }
        }
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
}

