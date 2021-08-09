//
//  MainVC.swift
//  Valyuta
//
//  Created by Firdavs Zokirov  on 09/08/21.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var collection_view: UICollectionView!{
        didSet{
        self.collection_view.delegate = self
        self.collection_view.dataSource = self
            self.collection_view.register(ValyutaCell.nib(), forCellWithReuseIdentifier: ValyutaCell.identifier)
        }
    }
    
    @IBOutlet weak var pageControll: SnakePageControl!
    
    var counter = 0
    var isSet:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpScroll()
        pageControll.pageCount = 5
    }


    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let countpage = scrollView.contentOffset.x/scrollView.bounds.width
        
        pageControll.progress = CGFloat(countpage)
        
    }
    
    func setUpScroll(){
        DispatchQueue.main.async {
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.scroll_Animation), userInfo: nil, repeats: true)
        }
        
    }
    @objc func scroll_Animation(){
        if counter < 5 && isSet{
            
            let index = IndexPath.init(item: counter, section: 0)
            self.collection_view.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControll.progress = CGFloat(counter)
            counter += 1
            
            
        }else {
            isSet = false
            counter -= 1
            let index = IndexPath.init(item: counter, section: 0)
            self.collection_view.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControll.progress = CGFloat(counter)
            
            if counter == 0 {
                isSet = true
            }
        }
        
    }

}


extension MainVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collection_view.dequeueReusableCell(withReuseIdentifier: ValyutaCell.identifier, for: indexPath) as! ValyutaCell
//        cell.updateCell(buycourse: <#T##String#>, cbCourse: <#T##String#>, cellCourse: <#T##String#>, currensy: <#T##String#>)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collection_view.bounds.width, height: 230)
    }
    
}
