//
//  NWHomeViewController.swift
//  testNews
//
//  Created by hjun on 2020/8/5.
//  Copyright © 2020 GD. All rights reserved.
//

import UIKit
import JXSegmentedView

class NWHomeViewController: UIViewController {
    var segmentDataSource: JXSegmentedTitleDataSource?
    let segmentView = JXSegmentedView()
    
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
        self.segmentDataSource?.titles = ["西瓜","苹果","香蕉","栗子","哈密瓜","菠萝","莲雾","柠檬"]

        
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
        return 8
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let listVc = NWHomeListViewController()
       return listVc
    }
}
