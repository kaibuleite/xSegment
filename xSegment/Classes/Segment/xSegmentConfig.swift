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
        public var cornerRadius = CGFloat.zero
    }
    
    /// 指示线数据结构
    public struct xSegmentLine {
        /// 颜色
        public var color = UIColor.red
        /// 高度
        public var height = CGFloat(1.5)
        /// 宽度
        public var width = CGFloat.zero
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
    
    // MARK: - 更新配置
    /// 更新基本配置
    /// - Parameters:
    ///   - fillMode: 填充样式(默认相等)
    ///   - fontSize: 字体大小
    ///   - titleLines: 标题行数(默认1行)
    ///   - spacing: 内容间距(默认0)
    public func updateBasic(fillMode : xSegmentItemFillMode = .equally,
                            fontSize : CGFloat,
                            titleLines : Int = 1,
                            spacing : CGFloat = 0)
    {
        self.fillMode = fillMode
        self.fontSize = fontSize
        self.titleLines = titleLines
        self.spacing = spacing
    }
    /// 更新Item配置
    /// - Parameters:
    ///   - height: 高度
    ///   - width: 宽度(默认0，自适应计算)
    ///   - margin: 边距(默认8，自适应计算宽度后留空)
    public func updateItem(height : CGFloat,
                           width : CGFloat = 0,
                           margin : UIEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 8))
    {
        self.itemHeight = height
        self.itemWidth = width
        self.itemMarginEdgeInsets = margin
    }
    /// 更新颜色配置
    /// - Parameters:
    ///   - title: 标题颜色
    ///   - background: 背景颜色
    public func updateColor(title : xSegmentItemColor,
                            background : xSegmentItemColor)
    {
        self.titleColor = title
        self.backgroundColor = background
    }
    /// 更新边框配置
    /// - Parameters:
    ///   - color: 边框颜色
    ///   - width: 边框线条宽度
    ///   - radius: 圆角半径
    public func updateBorder(color : xSegmentItemColor,
                             width : CGFloat,
                             radius : CGFloat)
    {
        self.border.color = color
        self.border.width = width
        self.border.cornerRadius = radius
    }
    /// 更新指示线配置
    /// - Parameters:
    ///   - color: 颜色
    ///   - height: 线高
    ///   - width: 线宽(如果>0则优先使用固定宽度，否则使用比例计算)
    ///   - widthRatio: 线宽比例(默认1)
    ///   - bottomSpacing: 底部间距(默认0，贴底部)
    public func updateIndicatorLine(color : UIColor,
                                    height : CGFloat,
                                    width : CGFloat,
                                    widthRatio : CGFloat = 1,
                                    bottomSpacing : CGFloat = 0)
    {
        self.line.color = color
        self.line.height = height
        self.line.width = width
        self.line.widthOfItemPercent = widthRatio
        self.line.marginBottom = bottomSpacing
    }
    
}
