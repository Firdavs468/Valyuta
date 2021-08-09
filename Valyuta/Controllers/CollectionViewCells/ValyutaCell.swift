//
//  ValyutaCell.swift
//  Valyuta
//
//  Created by Firdavs Zokirov  on 09/08/21.
//

import UIKit

class ValyutaCell: UICollectionViewCell {
    
    //MARK:- nib
    static func nib() -> UINib{
        return UINib(nibName: "ValyutaCell", bundle: nil)
    }
    
    //MARK:- identifier
    static let identifier = "ValyutaCell"
    @IBOutlet weak var backView: UIView!{
        didSet{
            backView.layer.cornerRadius = backView.frame.height/10
        }
    }
    
    @IBOutlet weak var buyCourseLbl: UILabel!
    @IBOutlet weak var cbCourseLbl: UILabel!
    @IBOutlet weak var cellCourseLbl: UILabel!
    @IBOutlet weak var currensyLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    //MARK:- SetupCell
    func updateCell(buycourse:Float, cbCourse:Float, cellCourse:Float, currensy:String){
        buyCourseLbl.text! = "\(Int(buycourse))"
        cbCourseLbl.text! = "\(Int(cbCourse))"
        cellCourseLbl.text = "\(Int(cellCourse))"
        currensyLbl.text! = currensy
    }
    
    
    
}
