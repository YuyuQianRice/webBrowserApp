//
//  TabCollectionViewCell.swift
//  toyWebBrowser
//
//  Created by Yuyu Qian on 3/23/21.
//

import UIKit
    
protocol TabCellDelegate: class{
    func closeTab(ind: Int)
}

class TabCollectionViewCell: UICollectionViewCell {
    var index = 0
    @IBOutlet weak var URLText: UILabel!
    weak var delegate: TabCellDelegate?
    
    @IBAction func closeTab(_ sender: Any) {
        delegate?.closeTab(ind: self.index)
    }
    
}
