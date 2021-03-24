//
//  TabCollectionViewController.swift
//  toyWebBrowser
//
//  Created by Yuyu Qian on 3/23/21.
//

import UIKit

private let reuseIdentifier = "TabCell"

class TabCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, DataEnteredDelegate, TabCellDelegate{
    func closeTab(ind: Int) {
        print("CLOSE!")
        tabURLs.remove(at: ind)
        self.collectionView.reloadData()
    }
    
    
    var tabURLs: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabURLs.append("https://www.google.com")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        if let nav = self.navigationController {
            nav.isToolbarHidden = false
        }
    }
    
    func userDidEnterInformation(info: Info) {
        //back from viewcontroller
        self.tabURLs[info.index] = info.url
        self.collectionView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return tabURLs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TabCollectionViewCell
    
        cell.URLText.text = tabURLs[indexPath.row]
//        cell.contentView.frame = cell.bounds
//        cell.contentView.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleWidth, .flexibleTopMargin, .flexibleHeight, .flexibleBottomMargin]
//        print(self.contentView.frame.size.width)
        cell.URLText.numberOfLines = 0
//        cell.URLText.lineBreakMode = .byTruncatingTail
        cell.sizeToFit()
        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
////        let width = 200//(view.frame.width - 20) / 3
////        let height = width * 1.5
//        return CGSize(width: 200.0, height: 250.0)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        ////        let width = 200//(view.frame.width - 20) / 3
        ////        let height = width * 1.5
        return CGSize(width: view.frame.width / 2, height: 250.0)
    }

    @IBAction func newTab(_ sender: Any) {
        tabURLs.append("https://www.google.com")
        self.collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
     Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }
    
    

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?){

    }
        */
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navc = segue.destination as? UINavigationController
        let vc = navc?.viewControllers.first as! ViewController
        vc.delegate = self
        if let cv = self.collectionView,
           let indexPath = collectionView.indexPathsForSelectedItems?.first,
           let cell = collectionView.cellForItem(at: indexPath) as? TabCollectionViewCell{
            vc.index = indexPath.row
            vc.currentURL = self.tabURLs[indexPath.row]
        }
       
    }

}
