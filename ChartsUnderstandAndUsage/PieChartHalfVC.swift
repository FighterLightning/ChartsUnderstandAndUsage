//
//  PieChartHalfVC.swift
//  ChartsUnderstandAndUsage
//
//  Created by 张海峰 on 2018/9/19.
//  Copyright © 2018年 张海峰. All rights reserved.
//
//Charts框架地址
//https://github.com/danielgindi/Charts.git
//该demo地址
//https://github.com/FighterLightning/ChartsUnderstandAndUsage.git
/*半个饼状图*/
import UIKit
import Charts
class PieChartHalfVC: BaseVC {
    var pieChartView: PieChartView  = PieChartView()
    var data: PieChartData = PieChartData()
    override func viewDidLoad() {
        super.viewDidLoad()
        //1.添加饼状图
        addPieChart()
        //2.设置基本样式
        setPieChartViewBaseStyle()
        //3.添加（刷新数据）
        updataData()
    }
    //添加饼状图
    func addPieChart(){
        pieChartView.backgroundColor = ZHFColor.white
        pieChartView.frame.size = CGSize.init(width: ScreenWidth, height: 300)
        pieChartView.center = self.view.center
        pieChartView.delegate = self
        self.view.addSubview(pieChartView)
        //刷新按钮响应
        refreshrBtn.addTarget(self, action: #selector(updataData), for: .touchUpInside)
    }
    func setPieChartViewBaseStyle(){
        //基本样式
        pieChartView.setExtraOffsets(left: 30, top: 30, right: 30, bottom: 0)//饼状图距离边缘的间隙
        pieChartView.usePercentValuesEnabled = true//是否根据所提供的数据, 将显示数据转换为百分比格式
        pieChartView.dragDecelerationEnabled = true//拖拽饼状图后是否有惯性效果
        pieChartView.drawSlicesUnderHoleEnabled = true//是否显示区块文本
        
        //空（实）心饼状图样式
        pieChartView.drawHoleEnabled = true//饼状图是否是空心 true为空心 false为实心
        pieChartView.holeRadiusPercent = 0.5//空心半径占比
        pieChartView.holeColor = ZHFColor.white//空心颜色 这个不能设置成clear
        pieChartView.transparentCircleRadiusPercent = 0.54//半透明空心半径占比
        pieChartView.transparentCircleColor = ZHFColor.zhf_colorAlpha(withHex: 0xffffff, alpha: 0.4)//半透明空心的颜色
        //设置成半圆
        pieChartView.maxAngle = 180 // Half chart
        pieChartView.rotationAngle = 180 // Rotate to make the half on the upper side
        pieChartView.centerTextOffset = CGPoint(x: 0, y: -20)//上移20
        //饼状图中间描述
        if pieChartView.isDrawHoleEnabled == true {
            pieChartView.drawCenterTextEnabled = true
            //pieChartView.centerText = "饼状图"
            //富文本
                        let centerText : NSMutableAttributedString = NSMutableAttributedString.init(string: "半圆饼状图")
                        centerText.setAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: ZHFColor.green], range: NSRange.init(location: 0, length: 2))
                        pieChartView.centerAttributedText = centerText
        }
        else{}
        //饼状图描述
        pieChartView.chartDescription?.text = "饼状图示例"
        pieChartView.chartDescription?.font = UIFont.systemFont(ofSize: 10)
        pieChartView.chartDescription?.textColor = ZHFColor.zhf33_titleTextColor
        //饼状图图例
         let l = pieChartView.legend
        l.maxSizePercent = 1 //图例在饼状图中的大小占比, 这会影响图例的宽高
        l.formToTextSpace = 5 //文本间隔
        l.font = UIFont.systemFont(ofSize: 10)//字体大小
        l.textColor = ZHFColor.gray//字体颜色
        l.form = Legend.Form.circle//图示样式: 方形、线条、圆形
        //图例在饼状图中的位置(右上角)
        l.horizontalAlignment = Legend.HorizontalAlignment.right
        l.verticalAlignment = Legend.VerticalAlignment.top
        l.orientation = Legend.Orientation.vertical
        l.formSize = 12;//图示大小
    }
    @objc func updataData(){
        //对应x轴上面需要显示的数据
        let count = 5
        //对应Y轴上面需要显示的数据
        let yVals: NSMutableArray  = NSMutableArray.init()
        for i in 0 ..< count {
            let val: Double = Double(arc4random_uniform(UInt32(200)))
            let entry:PieChartDataEntry  = PieChartDataEntry.init(value: val, label: "paty\(i)")
            // let entry:BarChartDataEntry  = BarChartDataEntry.init(x:  Double(i), y: Double(val))
            yVals.add(entry)
        }
        //创建PieChartDataSet对象
        let set1: PieChartDataSet = PieChartDataSet.init(values: yVals as? [ChartDataEntry], label: "饼状图")
        set1.drawIconsEnabled = false //是否在饼状图上面显示图片
        set1.sliceSpace = 2 //相邻区块之间的间距
        set1.selectionShift = 8//选中区块时, 放大的半径
        set1.drawValuesEnabled = true //是否在饼状图上面显示数值
        set1.highlightEnabled = true //点击选饼状图是否有高亮效果，（单击空白处取消选中）
        set1.setColors(ZHFColor.gray,ZHFColor.blue,ZHFColor.red,ZHFColor.zhf_randomColor(),ZHFColor.zhf_randomColor())//设置柱形图颜色(是一个循环，例如：你设置5个颜色，你设置8个柱形，后三个对应的颜色是该设置中的前三个，依次类推)
        //  set1.setColors(ChartColorTemplates.material(), alpha: 1)
        //  set1.setColor(ZHFColor.gray)//颜色一致
        set1.xValuePosition = PieChartDataSet.ValuePosition.insideSlice//名称位置（名称显示在饼图内部）
        //外部条件下有折线
        set1.yValuePosition = PieChartDataSet.ValuePosition.insideSlice//数据位置
        //数据与区块之间的用于指示的折线样式
        set1.valueLinePart1OffsetPercentage = 0.85//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
        set1.valueLinePart1Length = 0.5//折线中第一段长度占比
        set1.valueLinePart2Length = 0.4//折线中第二段长度最大占比
        set1.valueLineWidth = 1//折线的粗细
        set1.valueLineColor = ZHFColor.brown//折线颜色
        let dataSets: NSMutableArray  = NSMutableArray.init()
        dataSets.add(set1)
        //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
        let data:  PieChartData = PieChartData.init(dataSets: dataSets as? [IChartDataSet])
        
        let formatter: NumberFormatter = NumberFormatter.init()
        formatter.numberStyle = NumberFormatter.Style.percent //自定义数据显示格式  小数点形式(可以尝试不同看效果)
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1
        formatter.percentSymbol = " %"
        let forma :DefaultValueFormatter = DefaultValueFormatter.init(formatter: formatter)
        data.setValueFormatter(forma)
        
        data.setValueFont(UIFont.systemFont(ofSize: 10))
        data.setValueTextColor(ZHFColor.orange)
        pieChartView.data = data
        pieChartView.animate(xAxisDuration: 1, easingOption: ChartEasingOption.easeOutExpo)
    }
}
//MARK:-   <ChartViewDelegate代理方法实现>
extension PieChartHalfVC :ChartViewDelegate {
    //1.点击选中
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        ZHFLog(message: "点击选中")
    }
    //2.没有选中
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        ZHFLog(message: "没有选中")
    }
    //3.捏合放大或缩小
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        ZHFLog(message: "捏合放大或缩小")
    }
    //4.拖拽图表
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        ZHFLog(message: "拖拽图表")
    }
}
