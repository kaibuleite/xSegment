//
//  xSegmentConfig.swift
//  xSDK
//
//  Created by Mac on 2020/9/16.
//

import UIKit

public class xSegmentConfig: NSObject {
    
    // MARK: - Enum
    /// 填充样式
    public enum xSegmentItemFillMode {
        /// 自适应
        case auto
        /// 均等铺满（等宽）
        case equally
    }
    
    // MARK: - Struct
    /// 颜色数据结构
    public struct xSegmentItemColor {
        /// 普通
        public var normal = UIColor.black
        /// 选中
        public var choose = UIColor.red
        
        public init(normal: UIColor = UIColor.black, choose: UIColor = UIColor.red) {
            self.normal = normal
            self.choose = choose
        }
    }
    
    /// 边框数据结构
    public struct xSegmentItemBorder {
        /// 边框颜色
        public var color = xSegmentItemColor.init(normal: .clear, choose: .clear)
        /// 线宽
        public var width = CGFloat.zero
        /// 圆角
        public var cornerRadius = CGFloat(0)
    }
    
    /// 指示线数据结构
    public struct xSegmentLine {
        /// 颜色
        public var color = UIColor.red
        /// 高度
        public var height = CGFloat(1.5)
        /// 底部留空
        public var marginBottom = CGFloat(0)
        /// 相对于Item的宽度（默认相等）
        public var widthOfItemPercent = CGFloat(1)
    }
    
    // MARK: - Public Property
    /// 填充样式
    public var fillMode = xSegmentItemFillMode.auto
    /// 字号(默认15.0)
    public var fontSize = CGFloat(15)
    /// 间距
    public var spacing = CGFloat.zero
    
    /// item指定高度(默认44)
    public var itemHeight = CGFloat(44)
    /// item指定宽度(默认0)
    public var itemWidth = CGFloat(0)
    /// item边距(默认8，自适应计算宽度后留空)
    public var itemMarginEdgeInsets = UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 8)
    
    /// 行数
    public var titleLines = 1
    /// 标题颜色
    public var titleColor = xSegmentItemColor(normal: .lightGray, choose: .darkText)
    /// 背景颜色
    public var backgroundColor = xSegmentItemColor(normal: .clear, choose: .clear)
    
    /// 边框样式
    public var border = xSegmentItemBorder()
    
    /// 指示线样式
    public var line = xSegmentLine()
    
}
