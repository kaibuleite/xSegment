//
//  ViewController.swift
//  xSegment
//
//  Created by 177955297@qq.com on 07/14/2021.
//  Copyright (c) 2021 177955297@qq.com. All rights reserved.
//

import UIKit
import xSegment
import xExtension

class ViewController: UIViewController {
    
    // MARK: - IBOutlet Property
    @IBOutlet weak var segment1: xSegmentView!
    @IBOutlet weak var segment2: xSegmentView!
    @IBOutlet weak var segment3: xSegmentView!
    
    // MARK: - Override Func
    override class func xDefaultViewController() -> Self {
        let vc = Self.xNew(storyboard: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 基本配置
        self.view.backgroundColor = .white
        DispatchQueue.main.async {
            self.resetConfigBtnClick()
        }
    }
    
    // MARK: - 初始化Segment
    func initSegment(_ segment : xSegmentView)
    {
        segment.backgroundColor = .xNewRandom(alpha: 0.2)
        segment.addChooseItem {
            (idx) in
            guard let item = segment.itemArray.xObject(at: idx) else { return }
            print(item)
        }
        
        let config = segment.config
        let random = (arc4random() % 2 == 0)
        config.fontSize = 15
        config.titleColor.normal = .xNewRandom()
        config.titleColor.choose = .xNewRandom()
        config.backgroundColor.normal = .xNewRandom(alpha: 0.5)
        config.backgroundColor.choose = .xNewRandom(alpha: 0.5)
        config.border.color.normal = .xNewRandom()
        config.border.color.choose = .xNewRandom()
        config.border.cornerRadius = 4
        config.border.width = (random ? 0 : 1)
        config.line.color = .xNewRandom()
        config.line.height = 1 + CGFloat.xNewRandom(max: 4)
        config.line.marginBottom = 1 + CGFloat.xNewRandom(max: 2)
        config.line.widthOfItemPercent = (5 +  CGFloat.xNewRandom(max: 5)) / 10
        config.spacing = 10
        config.itemHeight = 40
    }
    
    // MARK: - 重置样式
    @IBAction func resetConfigBtnClick()
    {
        print("\(#function) in \(type(of: self))")
        self.view.endEditing(true)
        self.initSegment(self.segment1)
        self.initSegment(self.segment2)
        self.initSegment(self.segment3)
        
        let list1 = ["泉州", "厦门", "哈尔滨", "呼和浩特",
//                     "武汉", "重庆", "乌鲁木齐", "天津",
//                     "晋江", "华盛顿", "伦敦", "巴黎", "长安"
                    ]
        self.segment1.config.fillMode = .equally
        self.segment1.reload(dataArray: list1)
        
        let arr2 = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑", "🍍", "🥝", "🥑", "🍅", "🍆", "🥒", "🥕", "🌶", "🥔", "🌽", "🍠", "🥜", "🍯", "🥐", "🍞", "🥖", "🧀", "🥚", "🥓", "🥞", "🍗", "🍖"]
        var list2 = [UILabel]()
        for str in arr2 {
            let lbl = UILabel()
            lbl.frame = .init(x: 0, y: 0, width: 40, height: 40)
            lbl.font = .systemFont(ofSize: 15)
            lbl.text = str
            lbl.textAlignment = .center
            list2.append(lbl)
        }
        self.segment2.config.fillMode = .auto
        self.segment2.reload(itemViewArray: list2)
        
        var list3 = [xSegmentItem]()
        for _ in 0 ..< 20 {
            let view = xSegmentItem()
            view.backgroundColor = .xNewRandom()
            view.frame = CGRect.init(x: 0, y: 0, width: 30 + CGFloat.xNewRandom(max: 50), height: 30)
            list3.append(view)
        }
        self.segment3.config.fillMode = .auto
        self.segment3.reload(itemViewArray: list3)
    }

}

