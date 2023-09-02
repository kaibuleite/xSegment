//
//  xSegmentView+Reload.swift
//  xSegment
//
//  Created by Mac on 2023/3/17.
//

import Foundation
import xExtension

extension xSegmentView {
    
    // MARK: - 数据加载
    // TODO: 数据加载
    /// 加载默认组件数据
    /// - Parameters:
    ///   - dataArray: 标题
    public func reload(dataArray : [String])
    {
        guard dataArray.count > 0 else {
            print("⚠️ Segment没有数据")
            return
        }
        // 创建新控件
        let cfg = self.config
        let font = UIFont.systemFont(ofSize: cfg.fontSize)
        var list = [xSegmentItem]()
        for (i, title) in dataArray.enumerated() {
            let item = xSegmentItem.loadXib()
            item.tag = i
            item.titleLbl?.text = title
            // 计算宽高
            let lbl = item.titleLbl!
            lbl.font = font
            lbl.numberOfLines = cfg.titleLines
            let size = lbl.xContentSize(margin: cfg.itemMarginEdgeInsets)
            var frame = CGRect.zero
            frame.size = size
            if cfg.itemWidth > 0 {
                frame.size.height = cfg.itemWidth
            }
            if cfg.itemHeight > 0 {
                frame.size.height = cfg.itemHeight
            }
            item.frame = frame
            list.append(item)
        }
        self.reload(itemViewArray: list)
    }
    /// 加载自定义组件数据(view的frame自己设)
    /// - Parameters:
    ///   - itemViewArray: 视图列表
    public func reload(itemViewArray : [UIView])
    {
        guard itemViewArray.count > 0 else {
            print("⚠️ Segment没有数据")
            return
        }
        // 清空旧规格控件
        for item in self.itemArray {
            item.removeFromSuperview()
        }
        self.itemArray.removeAll()
        // 保存数据
        self.itemArray = itemViewArray
        // 排列控件
        let cfg = self.config
        for (i, item) in itemViewArray.enumerated() {
            item.tag = i
            // 设置初始样式
            item.layer.masksToBounds = true
            item.layer.cornerRadius = cfg.border.cornerRadius
            item.layer.borderWidth = cfg.border.width
            item.layer.borderColor = cfg.border.color.normal.cgColor
            item.backgroundColor = cfg.backgroundColor.normal
            // TODO: 按钮
            if let obj = item as? UIButton {
                obj.setTitleColor(cfg.titleColor.normal, for: .normal) 
            } else
            // TODO: 标签
            if let obj = item as? UILabel {
                obj.textColor = cfg.titleColor.normal
            } else
            // TODO: 自定义视图
            if let obj = item as? xSegmentItem {
                obj.updateNormalStyle(cfg)
            } else {
                print("❗️ 建议继承 xSegmentItem 类")
            }
            // 添加响应事件
            item.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapItem(_:)))
            item.addGestureRecognizer(tap)
            self.contentScroll.addSubview(item)
        }
        self.chooseItemLine.frame = .zero
        self.chooseItemLine.backgroundColor = cfg.line.color
        self.contentScroll.bringSubviewToFront(self.chooseItemLine)
        // 更新布局
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    // MARK: - 点击手势
    /// 点击手势
    @objc func tapItem(_ gesture : UITapGestureRecognizer)
    {
        guard let idx = gesture.view?.tag else { return }
        self.choose(idx: idx)
    }
    
}
