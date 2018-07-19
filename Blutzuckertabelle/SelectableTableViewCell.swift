//
//  SelectableTableViewCell.swift
//  Blutzuckertabelle
//
//  Created by Rupert Quaderer on 19.07.18.
//  Copyright © 2018 Webdevs. All rights reserved.
//

import UIKit

class SelectableTableViewCell: UITableViewCell {
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBInspectable var selectionColor: UIColor = .gray {
        didSet {
            configureSelectedBackgroundView()
        }
    }
    func configureSelectedBackgroundView() {
        let view = UIView()
        view.backgroundColor = selectionColor
        selectedBackgroundView = view
    }
    

}
