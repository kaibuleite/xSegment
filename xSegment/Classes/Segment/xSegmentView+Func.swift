//
//  xSegmentView+Func.swift
//  xSegment
//
//  Created by Mac on 2023/3/17.
//

import Foundation
import xExtension

extension xSegmentView {
    
    // MARK: - 添加回调
    public func addChooseItem(handler : @escaping xSegmentView.xHandlerChooseItem)
    {
        self.chooseHandler = handler
    }
    
    // MARK: - 选中
    /// 选中
    public func choose(idx : Int)
    {
        if idx != self.currentChooseIdx {
            self.updateItemStyleToNormal(at: self.currentChooseIdx)
        }
        self.updateItemStyleToChoose(at: idx)
        self.chooseHandler?(idx) 
    }  
    
    // MARK: - 设置Item样式
    /// 设置Item新内容提示
    public func setSegmentItem(idx : Int,
                               hasNew : Bool)
    {
        guard let item = self.getSegmentItem(at: idx) else { return }
        item.newFlag?.isHidden = !hasNew
        item.badgeLbl?.isHidden = true
    }
    /// 设置Item角标
    public func setSegmentItem(idx : Int, badge value : Int)
    {
        guard let item = self.getSegmentItem(at: idx) else { return }
        item.newFlag?.isHidden = true
        item.badgeLbl?.text = "\(value) "
        item.badgeLbl?.isHidden = (value <= 0)
    }
    /// 设置Item标题
    public func setSegmentItem(idx : Int,
                               title : String)
    {
        guard let item = self.getSegmentItem(at: idx) else { return }
        item.titleLbl?.text = title
    }
    /// 设置Item标题行数
    public func setSegmentItem(idx : Int, titleLines : Int)
    {
        guard let item = self.getSegmentItem(at: idx) else { return }
        item.titleLbl?.numberOfLines = titleLines
    }
    /// 设置所有Item标题行数
    public func setAllSegmentItem(titleLines : Int)
    {
        self.config.titleLines = titleLines
        for view in self.itemArray {
            guard let item = view as? xSegmentItem else { continue }
            item.titleLbl?.numberOfLines = titleLines
        }
    }
    func getSegmentItem(at idx : Int) -> xSegmentItem?
    {
        guard let view = self.itemArray.xObject(at: idx) else { return nil }
        guard let item = view as? xSegmentItem else {
            print("⚠️ 要编辑的 Item 不是继承 xSegmentItem 类")
            return nil
        }
        return item
    }
    
}
