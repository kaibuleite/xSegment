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
        var list = [xSegmentItem]()
        
        for title in dataArray {
            let item = xSegmentItem.loadXib()
            let lbl = item.titleLbl!
            lbl.numberOfLines = cfg.titleLines
            lbl.font = cfg.font.normal
            lbl.text = title
            // 计算内容宽度
            var frame = CGRect.zero
            var contentWidth = title.xContentWidth(for: cfg.font.normal,
                                                   height: cfg.itemHeight)
            contentWidth += cfg.itemMargin.left
            contentWidth += cfg.itemMargin.right
            frame.size.width = contentWidth
            // 是否固定宽高
            if cfg.itemWidth > 0 { frame.size.width = cfg.itemWidth }
            if cfg.itemHeight > 0 { frame.size.height = cfg.itemHeight }
            
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
        // 移除旧控件
        self.contentScroll.xRemoveAllSubViews()
        self.itemArray.removeAll()
        // 保存数据
        self.itemArray = itemViewArray
        self.itemFrameArray.removeAll()
        // 排列控件
        let cfg = self.config
        for (i, item) in itemViewArray.enumerated() {
            item.tag = i
            // 设置初始样式
            item.layer.masksToBounds = true
            item.layer.cornerRadius = cfg.border.cornerRadius
            item.layer.borderWidth = cfg.border.width
            self.updateItemStyleToNormal(at: i)
            // 保存Frame
            self.itemFrameArray.append(item.frame)
            self.contentScroll.addSubview(item)
            // 添加响应事件
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapItem(_:)))
            item.addGestureRecognizer(tap)
            item.isUserInteractionEnabled = true
        }
        // 设置指示线
        self.chooseItemLine.frame = .zero
        self.chooseItemLine.backgroundColor = cfg.line.color
        self.chooseItemLine.layer.cornerRadius = cfg.line.height / 2
        self.contentScroll.addSubview(self.chooseItemLine)
        // 更新布局
        self.setNeedsLayout()
        self.layoutIfNeeded()
        // 默认选中第一个数据
        self.updateItemStyleToChoose(at: 0)
    }
    
    // MARK: - 点击手势
    /// 点击手势
    @objc func tapItem(_ gesture : UITapGestureRecognizer)
    {
        guard let idx = gesture.view?.tag else { return }
        self.choose(idx: idx)
    }
    
}
