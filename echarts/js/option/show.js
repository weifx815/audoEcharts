/********************************单个柱状图更新************************************/
function barChart(url,mapChart){
	$.get(url, function (rData) {
		var barChartOption = myChart.getOption();
		//myChart.clear();//清空原来画布，重新生成图片
		var datas = rData.split("||");
	    var myDatas = datas[0];
	    var myData = myDatas.split(",");
		var xAxisDates = datas[1];
		var xAxisDate = xAxisDates.split(",");
		barChartOption.xAxis[0].data=xAxisDate;
		barChartOption.series[0].data = myData;
    	myChart.setOption(barChartOption);
	});
}
/**绑定地图联动**/
function BingBarChart(myChart,xData,yData){
	var barChartOption = myChart.getOption();
	barChartOption.xAxis[0].data = xData;
	barChartOption.series[0].data = yData;
	myChart.setOption(barChartOption);
}
/********************************地图更新************************************/
function mapChartOption(url,mapChart,myChart){
	$.get(url, function (rData) {
		var rData = $.parseJSON(rData);
		var mapOption = mapChart.getOption();
		//mapChart.clear();//清空原来画布，重新生成图片
		var mapData = new Array();
		var xData = new Array();
		var yData = new Array();
	     for(var i =0 ;i < rData.length;i++){
	         mapData.push({"name":rData[i].name,"value":rData[i].value});//存入mapData
	         xData.push(rData[i].name);
	         yData.push(rData[i].value);
	     }
		mapOption.series[0].data=mapData;
		mapChart.setOption(mapOption);
		BingBarChart(myChart,xData,yData);
	});
}
/********************************重叠柱状图更新************************************/
function twoBarEchartOption(url,barChart){
	$.get(url, function (rData) {
		var barOption = barChart.getOption();
		var rData = $.parseJSON(rData);
		//barChart.clear();//清空原来画布，重新生成图片
	    barOption.series[0].data=rData.ggj;
	    barOption.series[1].data=rData.szs;
		barChart.setOption(barOption);
	});
}

/********************************列表更新************************************/
function listShow(url,tabId){
	$.get(url, function (rData) {
		var rData = $.parseJSON(rData);
		if (rData && rData.length > 0) {
			$("#"+tabId).children("tbody").empty();
			for (var i = 0, l = rData.length; i < l; i++) {
				loadTable(tabId,rData[i]);
			}
		}
	});
}
function loadTable(tabId,data) {
	var html = "";
	if (data) {
		html = '<tr><td style="text-align:center">' + data.NAME + '</td><td style="text-align:center">' + data.VALUE + '</td></tr>'
		$("#"+tabId).children("tbody").append(html);
	}
}
/********************************线状图更新************************************/
function lineEchartOption(url,lineChart,lineOption){
	$.get(url, function (rData) {
		var lineOption = lineChart.getOption();
		var rData = $.parseJSON(rData);
		//lineChart.clear();//清空原来画布，重新生成图片
		lineOption.series[0].data=rData.data0;
		lineOption.series[1].data=rData.data1;
		lineOption.series[2].data=rData.data2;
		lineOption.series[3].data=rData.data3;
		lineOption.series[4].data=rData.data4;
	    lineChart.setOption(lineOption);
	});
}
/********************************饼状图更新************************************/
function pieEchartOption(url,pieChart,pieOption){
	$.get(url, function (rData) {
		var pieOption = pieChart.getOption();
		var rData = $.parseJSON(rData);
		//pieChart.clear();//清空原来画布，重新生成图片
		var pieData = new Array();
	     for(var i =0 ;i < rData.length;i++){
	    	 pieData.push({"name":rData[i].name,"value":rData[i].value});//存入mapData
	     }
	     pieOption.series[0].data=pieData;
		 pieChart.setOption(pieOption);
	});
}
