//
//  LineFilledChartVC.swift
//  ChartsUnderstandAndUsage
//
//  Created by 张海峰 on 2018/9/18.
//  Copyright © 2018年 张海峰. All rights reserved.
//
//Charts框架地址
//https://github.com/danielgindi/Charts.git
//该demo地址
//https://github.com/FighterLightning/ChartsUnderstandAndUsage.git
/*折线填充图*/
import UIKit
import Charts
class LineFilledChartVC: UIViewController {
        var lineChartView: LineChartView  = LineChartView()
        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = ZHFColor.white
            //添加折线和刷新按钮
            addLineChartAndRefreshBtn()
            //设置基本样式
            setLineChartViewBaseStyle()
            //添加（刷新数据）
            updataData()
        }
        //添加折线和刷新按钮
        func addLineChartAndRefreshBtn(){
            lineChartView.backgroundColor = ZHFColor.white
            lineChartView.frame.size = CGSize.init(width: 300, height: 300)
            lineChartView.center = self.view.center
            lineChartView.delegate = self
            self.view.addSubview(lineChartView)
            //添加刷新按钮
            let btn: UIButton = UIButton.init(type: UIButtonType.custom)
            btn.frame = CGRect.init(x: 30, y: 84, width: 40, height: 25)
            btn.setTitle("刷新", for: UIControlState.normal)
            btn.backgroundColor = ZHFColor.red
            btn.setTitleColor(ZHFColor.zhf33_titleTextColor, for: UIControlState.normal)
            btn.layer.cornerRadius = 5
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn.addTarget(self, action: #selector(updataData), for: UIControlEvents.touchUpInside)
            self.view.addSubview(btn)
        }
        //基本样式
        func setLineChartViewBaseStyle(){
            lineChartView.noDataText = "暂无数据" //如果没有数据会显示这个
            lineChartView.drawGridBackgroundEnabled = true  //绘制图形区域背景
            lineChartView.gridBackgroundColor = ZHFColor.blue //背景颜色
            lineChartView.alpha = 0.5//背景透明度
            //折线图描述文字和样式
            lineChartView.chartDescription?.text = "折线图描述"
            lineChartView.legend.textColor = ZHFColor.purple //描述文字颜色
            lineChartView.legend.formSize = 10 //（图例大小）默认是8
            lineChartView.legend.form = Legend.Form.circle//图例头部样式
            //矩形：.square（默认值） 圆形：.circle   横线：.line  无：.none 空：.empty（与 .none 一样都不显示头部，但不同的是 empty 头部仍然会占一个位置)
            lineChartView.chartDescription?.position = CGPoint.init(x: lineChartView.frame.width - 30, y:lineChartView.frame.height - 20)//位置（及在lineChartView的中心点）
            lineChartView.chartDescription?.font = UIFont.systemFont(ofSize: 12)//大小
            lineChartView.chartDescription?.textColor = UIColor.red
            //设置交互样式
            lineChartView.scaleYEnabled = false //取消Y轴缩放
            lineChartView.doubleTapToZoomEnabled = true //双击缩放
            lineChartView.dragEnabled = true //启用拖动手势
            lineChartView.dragDecelerationEnabled = true //拖拽后是否有惯性效果
            lineChartView.dragDecelerationFrictionCoef = 0.9 //拖拽后惯性效果摩擦系数(0~1)越小惯性越不明显
            //修改背景色和边框样式
            lineChartView.drawBordersEnabled = true  //绘制图形区域边框
            lineChartView.borderColor = ZHFColor.red  //边框为红色
            lineChartView.borderLineWidth = 2  //边框线条大小为2
        }
        @objc func updataData(){
            //1.第一条折线
            //生成30条随机数据
            var dataEntries1 = [ChartDataEntry]()
            for i in 0..<30 {
                let y = arc4random()%10 + 20
                //或者 arc4random_uniform(UInt32(100))
                let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
                dataEntries1.append(entry)
            }
            let chartDataSet1 = LineChartDataSet(values: dataEntries1, label: "上折线")
            //chartDataSet1.setColors(ZHFColor.gray,ZHFColor.green,ZHFColor.yellow,ZHFColor.zhf_randomColor(),ZHFColor.zhf_randomColor())//设置折线颜色(是一个循环，例如：你设置5个颜色，你设置8条折线，后三个对应的颜色是该设置中的前三个，依次类推)
            //  chartDataSet1.setColors(ChartColorTemplates.material(), alpha: 1)
            chartDataSet1.setColor(ZHFColor.gray)//颜色一致
            chartDataSet1.lineWidth = 2
            chartDataSet1.drawCirclesEnabled = false //不绘制拐点
            chartDataSet1.fillAlpha = 1
            chartDataSet1.drawFilledEnabled = true  //绘制上填充色
            chartDataSet1.fillColor = .white
            chartDataSet1.drawValuesEnabled = false //不绘制拐点上的文字
            chartDataSet1.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
                return CGFloat(self.lineChartView.leftAxis.axisMaximum) //向上绘制填充区域
            }
            //修改点击时十字线的样式
            chartDataSet1.highlightColor = .red //十字线颜色
            chartDataSet1.highlightLineWidth = 2 //十字线线宽
            chartDataSet1.highlightLineDashLengths = [4, 2] //使用虚线样式的十字线
          //  chartDataSet1.highlightEnabled = false  //不启用十字线
            chartDataSet1.drawVerticalHighlightIndicatorEnabled = false //不显示纵向十字线
         // chartDataSet1.drawHorizontalHighlightIndicatorEnabled = false //不显示横向十字线
            //2.第二条折线
            var dataEntries2 = [ChartDataEntry]()
            for i in 0..<30 {
                let y = arc4random()%10
                //或者 arc4random_uniform(UInt32(100))
                let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
                dataEntries2.append(entry)
            }
            let chartDataSet2 = LineChartDataSet(values: dataEntries2, label: "下折线")
            //chartDataSet2.setColors(ZHFColor.gray,ZHFColor.green,ZHFColor.yellow,ZHFColor.zhf_randomColor(),ZHFColor.zhf_randomColor())//设置折线颜色(是一个循环，例如：你设置5个颜色，你设置8条折线，后三个对应的颜色是该设置中的前三个，依次类推)
            //  chartDataSet2.setColors(ChartColorTemplates.material(), alpha: 1)
            chartDataSet2.setColor(ZHFColor.green)//颜色一致
            chartDataSet2.lineWidth = 2
            chartDataSet2.drawCirclesEnabled = false //不绘制拐点
            chartDataSet2.fillAlpha = 1
            chartDataSet2.drawFilledEnabled = true //绘制下填充色
            chartDataSet2.fillColor = .white
            chartDataSet2.drawValuesEnabled = false //不绘制拐点上的文字
            chartDataSet2.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
                return CGFloat(self.lineChartView.leftAxis.axisMinimum) //向下绘制填充区域
            }
            //修改点击时十字线的样式
            chartDataSet2.highlightColor = .red //十字线颜色
            chartDataSet2.highlightLineWidth = 2 //十字线线宽
            chartDataSet2.highlightLineDashLengths = [4, 2] //使用虚线样式的十字线
            let chartData = LineChartData(dataSets: [chartDataSet1,chartDataSet2])
            //设置折现图数据
            lineChartView.data = chartData
     }
}
extension LineFilledChartVC: ChartViewDelegate{
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
