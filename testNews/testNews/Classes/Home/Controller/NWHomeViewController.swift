//
//  NWHomeViewController.swift
//  testNews
//
//  Created by hjun on 2020/8/5.
//  Copyright © 2020 GD. All rights reserved.
//

import UIKit
import JXSegmentedView
import Moya
import Alamofire
import SwiftyJSON
class NWHomeViewController: UIViewController {
    var segmentDataSource: JXSegmentedTitleDataSource?
    let segmentView = JXSegmentedView()
    var channelIds : Array<String>?
    
    lazy var listContainerView : JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource:self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        segmentView.delegate = self
        view.addSubview(segmentView)
        //设置导航栏为不透明，这样就可以让frame自动从导航栏下面开始布局
        navigationController?.navigationBar.isTranslucent = false
        segmentView.listContainer = listContainerView
        view.addSubview(listContainerView)
        
        segmentDataSource = JXSegmentedTitleDataSource()
        segmentView.dataSource = segmentDataSource
        segmentDataSource?.titleSelectedColor = UIColor.red
        segmentDataSource?.titleNormalFont = UIFont.systemFont(ofSize: 15)
        segmentDataSource?.titleSelectedFont = UIFont.systemFont(ofSize: 17)
        segmentDataSource?.isTitleColorGradientEnabled = true
        
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorColor = UIColor.red
        segmentView.indicators = [indicator]
        
        requsetData()
    }
    
    func requsetData() {
        let provider = MoyaProvider<HttpRequest>()
        
        provider.request(.getHomePageChannelAPI(siteId: wnj_siteId, useID: "", type: 1, size: 2, regionCode: 50015)) { (result) in
            switch result {
            case let .success(response):
                let dict:[String:Any] = try! JSONSerialization.jsonObject(with: response.data, options: .mutableContainers) as! [String:Any]
                let list = dict["Data"] as! Array<AnyObject>
                let channelModel = [NWHomePageModel].deserialize(from: list)
                var titles : [String] = []
                self.channelIds = [String]()
                channelModel?.forEach({ (model) in
                    titles.append((model?.channelName)!)
                    self.channelIds?.append(model!.channelId!)
                })
                self.segmentDataSource?.titles = titles
                self.segmentView.reloadData()
                
            case let .failure(error):
                print(error)
                
                
            }
        }
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        segmentView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 50)
        listContainerView.frame = CGRect(x: 0, y: 50, width: view.bounds.size.width, height: view.bounds.size.height - 50)
    }
    
}

extension NWHomeViewController: JXSegmentedViewDelegate {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
    }
    
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        
    }
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        
    }
    
}

extension NWHomeViewController : JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return segmentDataSource?.titles.count ?? 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let listVc = NWHomeListViewController()
        listVc.channelId = channelIds![index]
        return listVc
    }
}
