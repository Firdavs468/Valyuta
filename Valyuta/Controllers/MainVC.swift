//
//  MainVC.swift
//  Valyuta
//
//  Created by Firdavs Zokirov  on 09/08/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainVC: UIViewController {
    
    @IBOutlet weak var collection_view: UICollectionView!{
        didSet{
            self.collection_view.delegate = self
            self.collection_view.dataSource = self
            self.collection_view.register(ValyutaCell.nib(), forCellWithReuseIdentifier: ValyutaCell.identifier)
        }
    }
    
    @IBOutlet weak var pageControll: SnakePageControl!
    
    var currencyArr: [CurrencyDM] = []
    let url: String = "https://dbo.infinbank.com:9443/api/v1/nci/NCIRate"
    var counter = 0
    var isSet:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrency()
        setUpScroll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if currencyArr.count != 0{
            pageControll.pageCount = currencyArr.count
            print(currencyArr.count)
        }
    }
    
    //MARK: - FetchRequest
    
    func fetchCurrency(){
        AF.request(URL(string: url)!, method: .get).responseJSON { [self] (response) in
            if let data = response.data {
                let jsonData = JSON(data)
                let dat = jsonData["data"]
                for d in 0..<dat.count{
                    
                    let currency = CurrencyDM(buyCourse: dat[d]["buyCourse"].floatValue, cellCourse: dat[d]["sellCourse"].floatValue, cbCourse: dat[d]["cbCourse"].floatValue, currencyCode: dat[d]["currency"].stringValue)
                    
                    currencyArr.append(currency)
                    collection_view.reloadData()
                }
            }
        }
        
    }
    
    
    //MARK:- SnakePageControll_Animation
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let countpage = scrollView.contentOffset.x/scrollView.bounds.width
        pageControll.progress = CGFloat(countpage)
    }
    
    func setUpScroll(){
        DispatchQueue.main.async {
            Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(self.scroll_Animation), userInfo: nil, repeats: true)
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

//MARK:- CollectionView delegate methods

extension MainVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currencyArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collection_view.dequeueReusableCell(withReuseIdentifier: ValyutaCell.identifier, for: indexPath) as! ValyutaCell
        cell.updateCell(buycourse: currencyArr[indexPath.row].buyCourse, cbCourse: currencyArr[indexPath.row].cbCourse, cellCourse: currencyArr[indexPath.row].cellCourse, currensy: currencyArr[indexPath.row].currencyCode)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collection_view.bounds.width, height: 230)
    }
    
}
