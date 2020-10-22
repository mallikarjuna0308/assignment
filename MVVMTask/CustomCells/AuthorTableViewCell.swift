//
//  AuthorTableViewCell.swift
//  MVVMTask
//
//  Created by iRam Technologies Pvt. Ltd. on 21/10/20.
//

import UIKit
import SkeletonView

class AuthorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkboxBtn: UIButton!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var tagLbl: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.cornerRadius = 15.0
        cellView.layer.shadowColor = UIColor.gray.cgColor
        cellView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cellView.layer.shadowRadius = 12.0
        cellView.layer.shadowOpacity = 0.7
        
        cellView.isSkeletonable = true
        cellView.showAnimatedGradientSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.cellView.hideSkeleton()
            self.cellView.isSkeletonable = false
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
