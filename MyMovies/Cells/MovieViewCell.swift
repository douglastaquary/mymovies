//
//  MovieViewCell.swift
//  MyMovies
//
//  Created by Douglas Taquary on 10/02/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import UIKit
import Reusable

final class MovieViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var backgroundCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func height() -> CGFloat {
        return 73
    }
    
    func setup(with nameOfMovie: String) {
        name.text = nameOfMovie
    }
}
