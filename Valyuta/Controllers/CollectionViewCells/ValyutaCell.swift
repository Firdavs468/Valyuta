//
//  ValyutaCell.swift
//  Valyuta
//
//  Created by Firdavs Zokirov  on 09/08/21.
//

import UIKit

class ValyutaCell: UICollectionViewCell {
    
    
    static func nib() -> UINib{
        return UINib(nibName: "ValyutaCell", bundle: nil)
    }
    
    static let identifier = "ValyutaCell"
    @IBOutlet weak var backView: UIView!{
        didSet{
            backView.layer.cornerRadius = backView.frame.height/5
        }
    }
    
    @IBOutlet weak var buyCourseLbl: UILabel!
    @IBOutlet weak var cbCourseLbl: UILabel!
    @IBOutlet weak var cellCourseLbl: UILabel!
    @IBOutlet weak var currensyLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func updateCell(buycourse:String, cbCourse:String, cellCourse:String, currensy:String){
        buyCourseLbl.text! = buycourse
        cbCourseLbl.text! = cbCourse
        cellCourseLbl.text = cellCourse
        currensyLbl.text! = currensy
    }
    
    
    
}
