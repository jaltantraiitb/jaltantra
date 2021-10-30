<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 	To enable JSP and JSTL Tags -->    
<%-- <%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 --%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- IITB LOGO-->
<link rel="shortcut icon" href="iitb_logo_black_small.png">
<!-- W2UI css file. W2UI is the javascript UI library to build the frontend. More information at http://w2ui.com/web/ -->
<link rel="stylesheet" type="text/css" href="css/w2ui-1.4.2.css" />
<!-- font awesome is used for some icons -->
<link rel="stylesheet" type="text/css" href="css/font-awesome/css/font-awesome.css" />
<!-- jquery is a javascript library -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.11.4/themes/pepper-grinder/jquery-ui.css">
<!-- importing jquery and jquery-ui javascript files -->
<script src="js/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<!-- importing w2ui javascript file -->
<script type="text/javascript" src="js/w2ui-1.4.2.js"></script>
<!-- importing json javascript file to handle operations on json objects-->
<script type="text/javascript" src="js/json.2.min.js"></script>
<!-- importing google charts javascript file to display charts in the map tab-->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>



<!-- importing google maps javascript file for the maps tab functionality-->

<!-- 		The Key for jaltantra: XXXXXXXXXXXXX          -->


<script type="text/javascript" src="https://maps.google.com/maps/api/js?key=KEY_MUST_BE_ADDED_HERE_&libraries=geometry,places"></script>



<!-- importing contextmenu javascript file for adding right click context menu to the map-->
<script type="text/javascript" src="js/ContextMenu.js"></script>
<!-- importing markerwithlabel javascript file for functionality of adding markers with labels to the map-->
<script type="text/javascript" src="js/markerwithlabel.js"></script>
<!-- importing map javascript file which contains logic for the map handling (such as adding of pipes/nodes) -->
<script type="text/javascript" src="js/map.js"></script>
<!-- importing javascript file for handling of excel import-->
<script type="text/javascript" src="js/xlsx.full.min.js"></script>
<!-- importing javascript file to handle network construction for EPANET file output -->
<script type="text/javascript" src="js/dagre.js"></script>
<!-- importing javascript file to convert map into image -->
<script type="text/javascript" src="js/html2canvas.js"></script>
<!--   <script src="js/geoxml3.js"></script> -->

<!-- some custom css, primarily for map tab  -->
<style>
.w2ui-icon.icon-folder2 {
  background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABFUlEQVR42mNkoBAwjhowmA0QERFhKS0t7/v58wfT7NmzSh8/fvydJAPY2dl5Dx868fHtu9eMYWHBkp8/f35BiQFSQAOek2fAW6AB4WQacAhowDugC8LDQqQ+ff6E3wBraxs5VlZWNhBbSUTfgV9IWM3V07nk+/dvjIf3H5347dOXm7dfntv9n+Efw9+/f/4cPnz4AdwAoG0sK1eufaupqc0H4t+6/IpBQFQOxab3Lx8xqOuLgdkPHz74HRLiz/vp06efYANYWFhYGxubnkpLy4ANeP2EkZWDX4YJ2YDvH57+E5P99xvEfvvmza/auhqxb9++/UAOAwmQWSCGML+4LTcnH4oTvv/48vz1h+f7oNy/QAwOEwCef4ARH3YTqwAAAABJRU5ErkJggg==) no-repeat center !important;
}

html, body {
  height: 100%;
  margin: 0;
  padding: 0;
}
#map {
  height: 80%;
  width: 100%;
}

#chart_div {
  height: 20%;
  width: 80%;
}

#searchlocationinput {
	background-color: #fff;
  	font-family: Roboto;
  	font-size: 15px;
  	font-weight: 300;
/*   	margin-left: 12px; */
  	padding: 0 11px 0 13px;
  	text-overflow: ellipsis;
  	width: 300px;
/*   	margin-top: 10px; */
  	border: 1px solid transparent;
  	border-radius: 2px 0 0 2px;
  	box-sizing: border-box;
  	-moz-box-sizing: border-box;
  	height: 32px;
  	outline: none;
  	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
}
     /*	start styles for the ContextMenu	*/
.context_menu{
	background-color:white;
	border:1px solid gray;
}
.context_menu_item{
	padding:3px 6px;
}
.context_menu_item:hover{
	background-color:#CCCCCC;
}
.context_menu_separator{
	background-color:gray;
	height:1px;
	margin:0;
	padding:0;
}
/*	end styles for the ContextMenu	*/
     
.labels {
    color: black;
    background-color: white;
    font-family: "Lucida Grande", "Arial", sans-serif;
    font-size: 10px;
    font-weight: bold;
    text-align: center;
/*     width: 100px;      */
    border: 1px solid black;
    /*white-space: nowrap; */
}
    
.infoClass {
	width: 100px;
}
    
.infoLabel {
	display: inline-block;
	width:65px;
	text-align: right;
	font-weight: bold;
	margin-right: 10px;
}
    
.errorText {
	margin-left: 5px;
	color: red;
}
    
#hiddenFrame {
	display: none;
}     
     
</style>

<script type="text/javascript">

// defines the String.startsWith function to support browsers that dont already have it defined
if (!String.prototype.startsWith) {
	  String.prototype.startsWith = function(searchString, position) {
	    position = position || 0;
	    return this.indexOf(searchString, position) === position;
	  };
	}

// defines current version of the system.
var version = "2.2.2.0";

// variable that will store coordinates of each node drawn on the map
var coordinatesstring = "";
//variable that will store start and end vertices for each edge drawn on the map
var verticesstring = "";

// array of nodes for the node table in node tab
var nodedata = [
               {recid: 1, nodeid: 1}
            ];
			
// array of pipes for the node table in pipes tab 
var pipedata = [
               {recid: 1, pipeid: 1}
            ];
			
// array of commercial pipes for the node table in commercial pipes tab			
var commercialpipedata = [
             {recid: 1}
          ]; 

//default cordinates of the center of the map		  
var mapCenter = {lat: 20.0094671, lng: 73.3826942};  

//variable storing the location where a new node is to be added
var place;
//variable for timeout when map is resized
var resizeId;

//variable for file reading
var reader;

//file type defintions when an existing network file is inputed
var XMLFILE = 0;
var BRANCHFILE = 1;
var EXCELFILE = 2;
var uploadFileType;

//defines the w2ui config used to generate the frontend
//refer to http://w2ui.com/web/ for details of different elements 
var config = {
		//overall layout of the page
	    layout: {
	        name: 'layout',
	        padding: 0,
	        panels: [
	            { type: 'top', size: '80px', style:'text-align:center;line-height:80px;height:80px;font-size:30px;background:beige;overflow:hidden',
	            	content: 'JalTantra: System For Optimization of Piped Water Networks, IIT Bombay<img src="iitb_logo_black_small.png" alt="IITB" style="vertical-align:middle;width:80px;height:80px;background:tranparent;">'},
	            { type: 'left', size: '20%'},
	            { type: 'main'},
	            { type: 'right', size: '80%', hidden: true, content:'right',
	            	toolbar: {
	            	    name  : 'toolbar',
	            	    items : [
	            	        { type: 'button',  id: 'itemExportToForm', caption: 'Transfer Data', hint: 'Transfer node and pipe information to respective tables', icon: 'fa fa-upload'
	            	        	, onClick: exportToFormConfirm },
	            	        { type: 'break',  id: 'break0' },
	            	        { type: 'button',  id: 'itemCloseChart', caption: 'Close Chart', hint: 'Close pipe elevation chart', icon: 'fa fa-close', onClick: closeChart },
	            	        { type: 'break',  id: 'break1' },
	            	        { type: 'button',  id: 'itemTakeSnapshot', caption: 'Take Snapshot', hint: 'Download an image snapshot of map', icon: 'fa fa-image', onClick: takeSnapshot },
	            	        { type: 'break',  id: 'break1' },
	            	        { type: 'html', id:'searchLocation', 
	            	        	html: '<input id="searchlocationinput" type="text" title="Search location by name or lat,lng" placeholder="Search location" onkeyup="searchtyped(event)">'}
	            	    ]
	            	}
	            }
	        ]
	    },
		//layout for the results tab
	    resultlayout : {
	        name: 'resultlayout',
	        panels: [
	            { type: 'main', 
	            	tabs: {
                    active: 'tabnodes',
                    tabs: [
                           { id: 'tabnodes', caption: 'Nodes' },
                           { id: 'tabpipes', caption: 'Pipes' },
                           { id: 'tabcosts', caption: 'Cost' },
                           { id: 'tabesrcosts', caption: 'ESR Cost' },
                           { id: 'tabpumpcosts', caption: 'Pump Cost' },
                          ],
                    onClick: function (event) {
                        switch (event.target) {
                        case 'tabnodes':
                            w2ui.resultlayout.content('main', w2ui.resultnodegrid);
                            break;
                        case 'tabpipes':
                            w2ui.resultlayout.content('main', w2ui.resultpipegrid);
                            break;
                        case 'tabcosts':
                            w2ui.resultlayout.content('main', w2ui.resultcostgrid);
                            break;
                        case 'tabesrcosts':
                            w2ui.resultlayout.content('main', w2ui.resultesrcostgrid);
                            break;
                        case 'tabpumpcosts':
                            w2ui.resultlayout.content('main', w2ui.resultpumpgrid);
                            break;
                    	}
                    },
                }},
	            ]
	    },
		//config for sidebar
	    sidebar: {
	        name: 'sidebar',
	        
	        //display link for detailed usage instructions
	        //topHTML: '<div style="background-color: #eee; height: 38px; padding: 10px 15px; border-top: 1px solid silver; border-bottom: 1px solid silver"><a target="_blank" href="script.html">JalTantra Usage Details</a>        
	       
	        topHTML: '<div style="background-color: #eee; height: 38px; padding: 10px 15px; border-top: 1px solid silver; border-bottom: 1px solid silver"> Welcome  <b>${username}!    <a href="/jaltantra/LogoutServlet"> [Logout]</a> </b></div>',
	        
	        bottomHTML: '<div style="background-color: #eee; padding: 10px 5px; border-top: 1px solid silver; border-bottom: 1px solid silver">JalTantra, version:'+version+'</div>',
	        nodes: [ 
	                { id: 'network', text: 'Network Description', expanded: true, group: true
	                	, nodes : [
		                { id: 'general', text: 'General', icon: 'fa fa-gears', selected: true},
		                { id: 'nodes', text: 'Nodes', icon: 'fa fa-home' },
		                { id: 'pipes', text: 'Pipes', icon: 'fa fa-code-fork' },
		                { id: 'commercialpipes', text: 'Commercial Pipes', icon: 'fa fa-rupee' },
		                { id: 'esr', text: 'ESRs', icon: 'fa fa-building' },
		                { id: 'pump', text: 'Pumps', icon: 'fa fa-upload' },
		                { id: 'valve', text: 'Valves', icon: 'fa fa-download' },
		                { id: 'map', text: 'Map', icon: 'fa fa-globe'},
		                { id: 'reset', text: 'RESET', icon: 'fa fa-rotate-left'
		                	, onClick: function(){
			                		w2confirm('Any unsaved data will be lost. Continue?')
	                      		 	.yes(resetInput);
		                		}}
		                ]},
	                { id: 'optimization', text: 'Optimize Network', expanded: false, group: true
	                	, nodes : [
	                	{ id: 'optimize', text: 'Optimize', icon: 'fa fa-wrench'},
	                	{ id: 'results', text: 'Results', icon: 'fa fa-bar-chart' }]},
                	{ id: 'loadsave', text: 'Load/Save Files', expanded: false, group: true
	                	, nodes : [
	                	{ id: 'loadfiles', icon: 'fa fa-folder-open', text: 'Load File', expanded : false
	                		, nodes: [ 
	                              { id: 'loadxmlfile', text: 'Load Xml File', icon: 'fa fa-file-text-o'
                                  	   , onClick: function() 
                                  	   {
                                  		 w2confirm('Any unsaved data will be lost. Continue?')
                                  		 	.yes(function(){
                                  		 			uploadFileType = XMLFILE;
                                  		 			$('#fileUpload').attr("accept",".xml");
                                  		 			$('#fileUpload').click();
                                  		 		});
                                  	   }},
								  { id: 'loadbranchfile', text: 'Load Branch File', icon: 'fa fa-file-text-o'
                                  	   , onClick: function() 
                                  	   {
                                  		 w2confirm('Any unsaved data will be lost. Continue?')
	                                  		.yes(function(){
	                          		 			uploadFileType = BRANCHFILE;
	                          		 			$('#fileUpload').attr("accept",".bra");
	                          		 			$('#fileUpload').click();
	                          		 		});
                                  	   }},
                                  { id: 'loadexcelfile', text: 'Load Excel File', icon: 'fa fa-file-excel-o'
                                       , onClick: function() 
                                   	   {
                                   		 w2confirm('Any unsaved data will be lost. Continue?')
	                                   		.yes(function(){
	                          		 			uploadFileType = EXCELFILE;
	                          		 			$('#fileUpload').attr("accept",".xls, .xlsx");	                          		 			
	                          		 			$('#fileUpload').click();
	                          		 		});
                                   	   }}
	                             ]
	                	},
	                	{ id: 'savefiles', icon: 'fa fa-save', text: 'Save Input File', expanded : false
	                		, nodes: [ 
	                              { id: 'savexmlfile', text: 'Save as Xml File', icon: 'fa fa-file-text-o'
                                  	   , onClick: saveInputXmlFile},
                                  { id: 'saveexcelfile', text: 'Save as Excel File', icon: 'fa fa-file-excel-o'
                                       , onClick: saveInputExcelFile}
	                             ]
	                	},
	                	{ id: 'saveoutputexcelfile', disabled: true, icon: 'fa fa-file-excel-o', text: 'Save Output Result File (Excel)', onClick: saveOutputExcelFile},
	                	{ id: 'saveoutputepanetfile', disabled: true, icon: 'fa fa-area-chart', text: 'Save Epanet Network File', onClick: saveOutputEpanetFile}]},
	                	{ id: 'help', text: 'Help', expanded: false, group: true,
	                		nodes: [
									{ id: 'units', text: 'Units', icon: 'fa fa-list-ol'},
									{ id: 'samplefiles', text: 'Sample Input/Output Files', icon: 'fa fa-file-text-o'},
									{ id: 'contactinfo', text: 'Contact Info', icon: 'fa fa-info'},
									//{ id: 'usageinfo',   text: '<a target="_blank" href="script.html">JalTantra Usage Details</a></div>'},
									{ id: 'youtube', text: 'YouTube Tutorial', icon: 'fa fa-youtube'}
	                		        ]}
	        ],
	        onClick: function (event) {
	        	w2ui.layout.set('right', {hidden: true});
	        	$(".ui-tooltip-content").parents('div').remove();
	            switch (event.target) {
	                case 'nodes':
	                    w2ui.layout.content('main', w2ui.nodegrid);
	                    break;
	                case 'pipes':
	                    w2ui.layout.content('main', w2ui.pipegrid);
	                    break;
	                case 'commercialpipes':
	                    w2ui.layout.content('main', w2ui.commercialpipegrid);
	                    break;
	                case 'esr':
	                    w2ui.layout.content('main', w2ui.esrlayout);
	                    w2ui.esrlayout_main_tabs.click('tabgeneral');
	                    break;
	                case 'pump':
	                    w2ui.layout.content('main', w2ui.pumplayout);
	                    w2ui.pumplayout_main_tabs.click('tabgeneral');
	                    break;
	                case 'valve':
	                    w2ui.layout.content('main', w2ui.valvegrid);
	                    break;
	                case 'general':
	                    w2ui.layout.content('main', w2ui.generalform);
	                    break;
	                case 'results':
	                    w2ui.layout.content('main', w2ui.resultlayout);
	                    w2ui.resultlayout_main_tabs.click('tabnodes');
	                    break;
	                case 'map':
	                	//w2ui.layout.load('main','/JalTantra/temp3.html','slide-left');
	                	w2ui.layout.set('right', {hidden: false});
	                	google.maps.event.trigger(map, 'resize');
	                	map.setCenter(mapCenter);
	                	displayMap();
	                	
	                	if($('#chart_status').val() == "show")
	                	{
	                    	chart.draw(data, chartOptions2);
	                	}
	                	else
                		{
                			$('#chart_status').change();
                		}
	                	break;
	                case 'optimize':
						// the previous results tables are cleared
	                	w2ui.resultnodegrid.clear();
	                    w2ui.resultpipegrid.clear();
	                    w2ui.resultcostgrid.clear();
	                    w2ui.resultesrcostgrid.clear();
	                    w2ui.resultpumpgrid.clear();
						// data is validated. if any errors, there are popups reporting the same
	                    if(!validateData())
	                    	return;
						// convert all the input provided in the various tabs into json objects
	                    var generalString = JSON.stringify(w2ui.generalform.record,replacer);
	                	var nodesString = JSON.stringify(w2ui.nodegrid.records,replacer);
	                    var pipesString = JSON.stringify(w2ui.pipegrid.records,replacer);
	                    var commercialPipesString = JSON.stringify(w2ui.commercialpipegrid.records,replacer);
	                    
	                    var esrProperties = w2ui.esrmainform.record;
	                    esrProperties.esr_enabled = (w2ui.esrtopform.record['enable_esr'] == true);
	                    var esrGeneralString = JSON.stringify(esrProperties,esrnodereplacer);
	                    var esrCostString = JSON.stringify(w2ui.esrmaingrid.records,replacer);
	                    
	                    var pumpProperties = w2ui.pumpmainform.record;
	                    pumpProperties.pump_enabled = (w2ui.pumptopform.record['enable_pump'] == true);
	                    pumpProperties.energycost_factor = 1;
	                    var pumpGeneralString = JSON.stringify(pumpProperties,pumpnodereplacer);
	                    var pumpManualString = JSON.stringify(w2ui.pumpmaingrid.records,replacer);
                    	
	                    var valveString = JSON.stringify(w2ui.valvegrid.records,replacer);
	                    
	                    //all of the json objects are sent to the server as a post request
	                    w2ui.generalform.save({'general': generalString,
	                    						'nodes': nodesString, 
	                    						'pipes': pipesString, 
	                    						'commercialPipes': commercialPipesString,
	                    						'esrGeneral': esrGeneralString,
	                    						'esrCost': esrCostString,
	                    						'pumpGeneral': pumpGeneralString,
	                    						'pumpManual': pumpManualString,
	                    						'valves': valveString,
	                    						'version': version,
	                    						'place': place}, 
                    		//process the response of the post request. fill all the results tables with appropriate data
							function(data)
                    		{
                    			w2alert(data['data']);
                    			var resultnodes = data['resultnodes'];
                    			$.each(resultnodes, function(index,value)
                    					{
                    						value['recid']=index+1;
                    					});
                    			w2ui.resultnodegrid.add(resultnodes);
                    			
                    			var resultpipes = data['resultpipes'];
                    			$.each(resultpipes, function(index,value){
                  						value['recid']=index+1;
                  						if(value['pressureexceeded']){
                  							value['style'] = 'background-color: red';
                  						}
                  						if(value['pumphead']==0){
                  							value['pumphead'] = null;
                  						}
                  						if(value['pumppower']==0){
                  							value['pumppower'] = null;
                  						}
                  						if(value['valvesetting']==0){
                  							value['valvesetting'] = null;
                  						}
                  					});
                    			w2ui.resultpipegrid.add(resultpipes);
                    			
                    			var resultcost = data['resultcost'];
                    			$.each(resultcost, function(index,value)
                    					{
                    						value['recid']=index+1;
                    					});
                    			w2ui.resultcostgrid.add(resultcost);
                    			
                    			var resultesrcost = data['resultesrcost'];
                    			$.each(resultesrcost, function(index,value)
                    					{
                    						value['recid']=index+1;
                    					});
                    			w2ui.resultesrcostgrid.add(resultesrcost);
                    			
                    			var resultpumpcost = data['resultpumpcost'];
                    			var totalpower = 0;
                    			var totalenergy = 0;
                    			var totalcapital = 0;
                    			var totalcost = 0;
                    			$.each(resultpumpcost, function(index,value)
                    					{
                    						value['recid']=index+1;
                    						totalpower += value.pumppower;
                    						totalenergy += value.energycost;
                    						totalcapital += value.capitalcost;
                    						totalcost += value.totalcost;
                    					});
                    			w2ui.resultpumpgrid.add(resultpumpcost);
                    			w2ui.resultpumpgrid.add({
                    						w2ui: { summary: true },
                    						style: 'background-color : palegreen',
                    	             		recid: 'S-1',
                    	             		pipeid: 'Total',
                    	             		pumppower: totalpower,
                    	             		energycost: totalenergy,
                    	             		capitalcost: totalcapital,
                    	             		totalcost: totalcost
                    	             	});
                    			
                    			generateCoordinates();
                    			
                    			w2ui.sidebar.click('results');
                    			w2ui.sidebar.enable('saveoutputexcelfile');
                    			w2ui.sidebar.enable('saveoutputepanetfile');
                    		});
	                	break;
	                case 'units':
	                	w2ui.layout.content('main',
	                	"<div style='font-family: \"w2ui-font\"'>"
	                	+ "Elevation: Metre<br>"
	    				+ "Head: Metre<br>"
	    				+ "Demand: Litres per second<br>"
	    				+ "Min. Pressure: Metre<br>"
	    				+ "Length: Metre<br>"
	    				+ "Diameter: Milimeter")
	    				+ "</div>";
	                	break;
	                case 'samplefiles':
	                	w2ui.layout.content('main',
	                	"<div style='font-family: \"w2ui-font\"'>"
	                	+ 'Sample Input: <a href="https://www.cse.iitb.ac.in/~nikhilh/Sample_Files/Sample.BRA" target="_blank">Sample.BRA</a> or <a href="https://www.cse.iitb.ac.in/~nikhilh/Sample_Files/Sample.xml" target="_blank">Sample.xml</a> or <a href="https://www.cse.iitb.ac.in/~nikhilh/Sample_Files/Sample_input.xls" target="_blank">Sample_input.xls</a> <br>'
	                	+ 'Sample Output: <a href="https://www.cse.iitb.ac.in/~nikhilh/Sample_Files/Sample_output.xls" target="_blank">Sample_output.xls</a>'
	                	+ '<br><br><br>'
	                	+ 'Sample Input(With ESR option): <a href="https://www.cse.iitb.ac.in/~nikhilh/Sample_Files/Sample_ESR.xml" target="_blank">Sample_ESR.xml</a> or <a href="https://www.cse.iitb.ac.in/~nikhilh/Sample_Files/Sample_input_ESR.xls" target="_blank">Sample_input_ESR.xls</a> <br>'
	                	+ 'Sample Output(With ESR option): <a href="https://www.cse.iitb.ac.in/~nikhilh/Sample_Files/Sample_output.xls" target="_blank">Sample_output_ESR.xls</a>'
	                	+ '</div>');           	
	                	break;
	                case 'contactinfo':
	                	w2ui.layout.content('main',
               			"<div style='font-family: \"w2ui-font\"'>"
               			+ 'For more information on JalTantra visit <a href="https://www.cse.iitb.ac.in/~nikhilh/jaltantra" target="_blank">https://www.cse.iitb.ac.in/~nikhilh/jaltantra<a/>'
               			+ '<br>Join the <a target="_blank" href="https://groups.google.com/forum/#!forum/jaltantra-users/join">JalTantra Google Group</a> for any discussion regarding JalTantra'
               			+ '<br>For any queries, suggestions or comments please contact hooda.nikhil@gmail.com'
               			+ '</div>');
	                	break;
	                case 'youtube':
	                	w2ui.layout.content('main',
	                   	"<div style='font-family: \"w2ui-font\"'>"
               			+ '<br><iframe width="784" height="427" src="https://www.youtube.com/embed/605FCrPr8P4" frameborder="0" allowfullscreen></iframe>'
               			+ '</div>');
	                	break;
	            }
	        }
	    },
	//config of the general form
	generalform : { 
        name   : 'generalform',
        focus : -1,
        //url : '/jaltantra/OptimizerServlet', //initially 2.2.2.0 was not here
        url : '/jaltantra/OptimizerServlet', //initially 2.2.2.0 was not here
        msgSaving  : 'Optimizing, Please Wait...',
        fields : [
            { field: 'name_project', type: 'text', required: true, html: { caption: 'Name of Project:', attr: 'style="width: 200px" title="Name of the project"', span: 9 } },
            { field: 'name_organization', type: 'text', required: false, html: { caption: 'Name of Organization:', attr: 'style="width: 200px" title="Name of the organization"', span: 9 } },
            { field: 'min_node_pressure',  type: 'float', options: {min: '0'}, required: true, html: { caption: 'Minimum Node Pressure (m):', attr: 'style="width: 200px" title="Minimum pressure in metres that must be maintained at each node"', span: 9 } },
            { field: 'def_pipe_roughness',   type: 'float', options: {min: '0'}, required: true, html: { caption: 'Default Pipe Roughness:', attr: 'style="width: 200px" title="Default Hazen-Williams roughness coefficient used to calculate headloss in pipes"', span: 9 } },
            { field: 'min_hl_perkm',  type: 'float', options: {min: '0'}, required: true, html: { caption: 'Minimum Headloss/KM (m):', attr: 'style="width: 200px" title="Minimum headloss in metres that is allowed per kilometre in a pipe"', span: 9 } },
            { field: 'max_hl_perkm',  type: 'float', options: {min: '0'}, required: true, html: { caption: 'Maximum Headloss/KM (m):', attr: 'style="width: 200px" title="Maximum headloss in metres that is allowed per kilometre in a pipe"', span: 9 } },
            { field: 'max_water_speed',  type: 'float', options: {min: '0'}, required: false, html: { caption: 'Maximum Water Speed (m/s):', attr: 'style="width: 200px" title="Maximum speed of water in metres per second that is allowed in a pipe (can be left blank if no upper limit on speed is to be enforced)"', span: 9 } },
            { field: 'max_pipe_pressure',  type: 'float', options: {min: '0'}, required: false, html: { caption: 'Maximum Pipe Pressure (m):', attr: 'style="width: 200px" title="Maximum pressure of water in metres that should exist in a pipe (can be left blank if no upper limit on pressure). Note that this constraint is not strictly enforced, but a warning is provided in the results if pressure is exceeded"', span: 9 } },
            { field: 'supply_hours',  type: 'float', options: {min: '0'}, required: true, html: { caption: 'Number of Supply Hours:', attr: 'style="width: 200px"  title="Number of hours in day that the source provides water. For example a supply hours of 12 is equivalent to a peak factor of 2"', span: 9 } },
            { field: 'source_nodeid',  type: 'int', options: {min: '1'}, required: true, html: { caption: 'Source Node ID:', attr: 'style="width: 200px" title="Unique integer identifier for the source. Must be >= 1"', span: 9 } },
            { field: 'source_nodename',  type: 'text', required: true, html: { caption: 'Source Node Name:', attr: 'style="width: 200px" title="Name of the source node"', span: 9 } },
            { field: 'source_head',  type: 'float', options: {min: '0'}, required: true, html: { caption: 'Source Head (m):', attr: 'style="width: 200px" title="Constant head in metres provided by the source to the network"', span: 9 } },
            { field: 'source_elevation',  type: 'float', options: {min: '0'}, required: true, html: { caption: 'Source Elevation (m):', attr: 'style="width: 200px" title="Elevation of the source node"', span: 9 } }
        ],
        toolbar: {
            items: [
                { id: 'bt1', type: 'button', caption: 'Default', img: 'icon-page' },
                { id: 'bt2', type: 'button', caption: 'Reset', img: 'icon-page' }
            ],
            onClick: function (event) {
                if (event.target == 'bt2') w2ui.generalform.clear();
                if (event.target == 'bt1') {
                	w2ui.generalform.record['min_node_pressure'] = 7;
                	w2ui.generalform.record['def_pipe_roughness'] = 140;
                	w2ui.generalform.record['min_hl_perkm'] = 0;
                	w2ui.generalform.record['max_hl_perkm'] = 25;
                	w2ui.generalform.record['max_water_speed'] = 3;
                	w2ui.generalform.record['supply_hours'] = 24;
                	w2ui.generalform.refresh();
                }
            }
        }
    },
	//config of the node tab
    nodegrid : { 
        name: 'nodegrid',
        show: { 
            selectColumn: true,
            toolbar: true,
            toolbarReload: false,
            toolbarAdd: true,
            toolbarDelete: true,
            toolbarColumns: false
        },
        columns: [                
            { field: 'nodeid', caption: 'Node ID', sortable:true, size: '15%', editable: {type: 'int', min:'1'}, render: 'int'},
            { field: 'nodename', caption: 'Node Name', sortable:true, size: '25%', editable: {type: 'text'}},
            { field: 'elevation', caption: 'Elevation (m)', sortable:true, size: '20%', editable: {type: 'float', min:'0'}, render: 'int'},
            { field: 'demand', caption: 'Demand (lps)', sortable:true, size: '20%', editable: {type: 'float', min:'0'}, render: 'number:2' },
            { field: 'minpressure', caption: 'Min. Pressure (m)', sortable:true, size: '20%', editable: {type: 'float', min:'0'}, render: 'int' }
        ],
        onAdd : function(event){
        	addRecord(this, 'nodeid', parseInt(w2ui.generalform.record['source_nodeid']));
        }
   	},
	//config of the pipe tab
   	pipegrid : { 
           name: 'pipegrid',
           show: { 
               selectColumn: true,
               toolbar: true,
               toolbarReload: false,
               toolbarAdd: true,
               toolbarDelete: true,
               toolbarColumns: false
           },
           columns: [                
               { field: 'pipeid', caption: 'Pipe ID', sortable:true, size: '20%', editable: {type: 'int', min:'1'}, render: 'int'},
               { field: 'startnode', caption: 'Start Node', sortable:true, size: '20%', editable: {type: 'int', min:'1'}, render: 'int'},
               { field: 'endnode', caption: 'End Node', sortable:true, size: '20%', editable: {type: 'int', min:'1'}, render: 'int' },
               { field: 'length', caption: 'Length (m)', sortable:true, size: '20%', editable: {type: 'float', min:'0'}, render: 'int' },
               { field: 'diameter', caption: 'Diameter (mm)', sortable:true, size: '20%', editable: {type: 'float', min:'0'}, render: 'int' },
               { field: 'roughness', caption: 'Roughness', sortable:true, size: '20%', editable: {type: 'float', min:'0'}, render: 'int' },
               { field: 'parallelallowed', caption: 'Parallel Allowed', sortable:true, size: '20%', editable: {type: 'checkbox'} }
           ],
           onAdd : function(event){
           	addRecord(this, 'pipeid');
           }
       },
	//config of the commerical pipe tab   
	commercialpipegrid : { 
           name: 'commercialpipegrid',
           show: { 
               selectColumn: true,
               toolbar: true,
               toolbarReload: false,
               toolbarAdd: true,
               toolbarDelete: true,
               toolbarColumns: false
           },
           columns: [                
               { field: 'diameter', caption: 'Diameter (mm)', sortable:true, size: '33%', editable: {type: 'float', min:'0'}, render: 'int'},
               { field: 'roughness', caption: 'Roughness', sortable:true, size: '33%', editable: {type: 'float', min:'0'}, render: 'int'},
               { field: 'cost', caption: 'Cost (Rs)', sortable:true, size: '33%', editable: {type: 'float', min:'0'}, render: 'int'}
           ],
           onAdd : function(event){
           	addRecord(this);
           }
       },
	//config of the esr tab
    esrlayout : {
    	name: 'esrlayout',
        panels: [
            { type: 'top', size:60},
            { type: 'main',
            	tabs: {
                    active: 'tabgeneral',
                    tabs: [
                           { id: 'tabgeneral', caption: 'General' },
                           { id: 'tabcosts', caption: 'Cost' }
                          ],
                    onClick: function (event) {
                        switch (event.target) {
                        case 'tabgeneral':
                            w2ui.esrlayout.content('main', w2ui.esrmainform);
                            break;
                        case 'tabcosts':
                            w2ui.esrlayout.content('main', w2ui.esrmaingrid);
                            break;
                    	}}
            	}
            }
            ]
    	
       },
	//config of the form at the top of the esr tab
    esrtopform : {
    	name: 'esrtopform',
    	style: 'border: 0px; background-color: transparent;',
    	formHTML:
    		'<div class="w2ui-page page-0">'+
            '    <div class="w2ui-field">'+
            '        <label>Enable ESR Costing</label>'+
            '        <div>'+
            '            <input name="enable_esr" type="checkbox"/>'+
            '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
            '		<button type="button" onclick="esrPopup()">'+
            '			<i class="fa fa-question-circle"/>'+
            'About ESR'+
            '       </button>'+
            '        </div>'+
            '	 </div>'+	
            '</div>',
    	fields: [
    		{ field:'enable_esr', type: 'checkbox'}
    	         ],       
    	onRender : function(event){
    		event.onComplete = function(){
    			if(w2ui.esrtopform.record['enable_esr'] == true){
	        		w2ui.esrlayout.unlock('main');
	        	}
	        	else{
	        		w2ui.esrlayout.lock('main');
	        	}
    		}
    	},
        onChange : function(event){
        	if(event.target == 'enable_esr'){  
		    	event.onComplete = function (){
		    		if(w2ui.esrtopform.record['enable_esr'] == true){
		        		w2ui.esrlayout.unlock('main');
		        	}
		        	else{
		        		w2ui.esrlayout.lock('main');
		        	}
		        }
		    }
        }
       },
	   //config of the esr main form in the esr tab	   
       esrmainform : { 
           name   : 'esrmainform',
           focus : -1,
           fields : [
               { field: 'secondary_supply_hours',  type: 'float', options: {min: '0'}, required: true, html: { caption: 'Secondary Network Supply Hours:', attr: 'style="width: 200px"  title="Number of hours in day that an ESR provides water to its secondary network."', span: 10 } },
               { field: 'esr_capacity_factor',  type: 'float', options: {min: '0'}, required: true, html: { caption: 'ESR Capacity Factor:', attr: 'style="width: 200px"  title="Size of ESR in relation to the daily demand it serves. For eg a value of 0.5 means that the ESR capacity is half the daily demand."', span: 10 } },
               { field: 'max_esr_height',  type: 'float', options: {min: '0'}, html: { caption: 'Maximum ESR Height:', attr: 'style="width: 200px" title="Maximum height of ESR in metres."', span: 10 } },
               { field: 'allow_dummy',  type: 'checkbox', html: { caption: 'Allow ESRs at zero demand nodes:', attr: 'title="Allow ESRs to placed at nodes with zero demand. Note that if zero demand nodes are not allowed optimization will be significantly faster"', span: 10 } },
               { field: 'must_esr',  type: 'enum', html: { caption: 'Nodes with ESRs:', attr: 'style="width: 200px"', span: 10 } },
               { field: 'must_not_esr',  type: 'enum', options: {items: [{text:'a'},{id:2}], openOnFocus: true, placeholder: 'List of nodes that cannot have ESRs'}, html: { caption: 'Nodes without ESRs:', attr: 'style="width: 200px"', span: 10 } }
           ],
           onRender : function(event){
        	   nodeids = getNodeIds();
        	   w2ui.esrmainform.set('must_esr',{options: {items: nodeids, openOnFocus: true, placeholder: 'List of nodes that must have ESRs'}});
        	   w2ui.esrmainform.set('must_not_esr',{options: {items: nodeids, openOnFocus: true, placeholder: 'List of nodes that cannot have ESRs'}});
           }
       },
	//config of the esr table in the esr tab
	esrmaingrid : { 
           name: 'esrmaingrid',
           show: { 
               selectColumn: true,
               toolbar: true,
               toolbarReload: false,
               toolbarAdd: true,
               toolbarDelete: true,
               toolbarColumns: false
           },
           columns: [                
               { field: 'mincapacity', caption: 'Minimum Capacity (l)', sortable:true, size: '25%', editable: {type: 'float', min:'0'}, render: 'int'},
               { field: 'maxcapacity', caption: 'Maximum Capacity (l)', sortable:true, size: '25%', editable: {type: 'float', min:'0'}, render: 'int'},
               { field: 'basecost', caption: 'Base Cost (Rs)', sortable:true, size: '25%', editable: {type: 'float', min:'0'}, render: 'int'},
               { field: 'unitcost', caption: 'Unit Cost (Rs)', sortable:true, size: '25%', editable: {type: 'float', min:'0'}, render: 'number:2'}
           ],
           onAdd : function(event){
           	var newrecid = getNewRecid(this);
        	var record = {recid: newrecid};
        	//if(this.)	
        	if(this.records.length==0){
        		record['mincapacity'] = 0;
        	}
        	else{
        		var lastrecord = this.records[this.records.length-1];
        		record['mincapacity'] = lastrecord['maxcapacity'];
        		record['basecost'] = lastrecord['basecost'] + (lastrecord['maxcapacity']-lastrecord['mincapacity'])*lastrecord['unitcost'];	
        	}
        		this.add( record );
           }
       },
	//config of the pump tab
	pumplayout : {
       	name: 'pumplayout',
           panels: [
               { type: 'top', size:60},
               { type: 'main',
               	tabs: {
                       active: 'tabgeneral',
                       tabs: [
                              { id: 'tabgeneral', caption: 'General' },
                              { id: 'tabmanual', caption: 'Manual' }
                             ],
                       onClick: function (event) {
                           switch (event.target) {
                           case 'tabgeneral':
                               w2ui.pumplayout.content('main', w2ui.pumpmainform);
                               break;
                           case 'tabmanual':
                               w2ui.pumplayout.content('main', w2ui.pumpmaingrid);
                               break;
                       	}}
               	}
               }
               ]
       	
          },
		  //config of the top form in the pump tab
       pumptopform : {
       	name: 'pumptopform',
       	style: 'border: 0px; background-color: transparent;',
       	formHTML:
       		'<div class="w2ui-page page-0">'+
               '    <div class="w2ui-field">'+
               '        <label>Enable Pump Costing</label>'+
               '        <div>'+
               '            <input name="enable_pump" type="checkbox"/>'+
               '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
               '		<button type="button" onclick="pumpPopup()">'+
               '			<i class="fa fa-question-circle"/>'+
               'About Pump'+
               '       </button>'+
               '        </div>'+
               '	 </div>'+	
               '</div>',
       	fields: [
       		{ field:'enable_pump', type: 'checkbox'}
       	         ],       
       	onRender : function(event){
       		event.onComplete = function(){
       			if(w2ui.pumptopform.record['enable_pump'] == true){
   	        		w2ui.pumplayout.unlock('main');
   	        	}
   	        	else{
   	        		w2ui.pumplayout.lock('main');
   	        	}
       		}
       	},
           onChange : function(event){
           	if(event.target == 'enable_pump'){  
   		    	event.onComplete = function (){
   		    		if(w2ui.pumptopform.record['enable_pump'] == true){
   		        		w2ui.pumplayout.unlock('main');
   		        	}
   		        	else{
   		        		w2ui.pumplayout.lock('main');
   		        	}
   		        }
   		    }
           }
          }, 
	//config of the main form in the pump tab	
    pumpmainform : { 
        name   : 'pumpmainform',
        focus : -1,
        fields : [
			{ field: 'minpumpsize',  type: 'float', options: {min: '0'}, required: true, html: { caption: 'Minimum Pump Size (kW):', attr: 'style="width: 150px"  title="Size of Minimum Pump in kW that can be installed"', span: 8 } },
            { field: 'efficiency',  type: 'float', options: {min: '0'}, required: true, html: { caption: 'Pump Efficiency:', attr: 'style="width: 150px"  title="Efficiency of pump expressed as a %"', span: 8 } },
            { field: 'capitalcost_per_kw',  type: 'float', options: {min: '0'}, required: true, html: { caption: 'Capital Cost per kW:', attr: 'style="width: 150px"  title="Capital cost of the pump per kW installed capacity"', span: 8 } },
            { field: 'energycost_per_kwh',  type: 'float', options: {min: '0'}, required: true, html: { caption: 'Energy Cost per kWh:', attr: 'style="width: 150px" title="Energy cost per kWh energy consumed"', span: 8 } },
            { field: 'design_lifetime',  type: 'int', required: true, html: { caption: 'Design Lifetime:', attr: 'style="width: 150px" title="Number of years for which pumps will be operational."', span: 8 } },
            { field: 'discount_rate',  type: 'float', options: {min: '0'}, html: { caption: 'Discount Rate:', attr: 'style="width: 150px" title="Discount rate is the interest rate expressed as a %. More the discount rate lesser is the enrgy cost of the pump"', span: 8 } },
            { field: 'inflation_rate',  type: 'float', options: {min: '0'}, html: { caption: 'Inflation Rate:', attr: 'style="width: 150px" title="Inflation rate is the rate by which prices rise expressed as a %. More the inflation rate greater is the energy cost of the pump"', span: 8 } },
            { field: 'must_not_pump',  type: 'enum', options: {items: [{text:'a'},{id:2}], openOnFocus: true, placeholder: 'List of pipes that cannot have Pumps'}, html: { caption: 'Pipes without Pumps:', attr: 'style="width: 150px"', span: 8 } }
        ],
        onRender : function(event){
     	   var pipeids = getPipeIds();
     	   w2ui.pumpmainform.set('must_not_pump',{options: {items: pipeids, openOnFocus: true, placeholder: 'List of pipes that cannot have Pumps'}});
        }
    },
	//config of the table in the pump tab	
   	pumpmaingrid : { 
              name: 'pumpmaingrid',
              show: { 
                  selectColumn: true,
                  toolbar: true,
                  toolbarReload: false,
                  toolbarAdd: true,
                  toolbarDelete: true,
                  toolbarColumns: false
              },
              columns: [                
                  { field: 'pipeid', caption: 'Pipe ID', sortable:true, size: '25%', editable: {type: 'int', min:'1'}, render: 'int'},
                  { field: 'pumppower', caption: 'Pump Power (kWh)', sortable:true, size: '25%', editable: {type: 'float', min:'0'}, render: 'number:2'}
              ],
              onAdd : function(event){
              	addRecord(this);
              }
          },
	//config of the table in the valve tab
	valvegrid : { 
	    name: 'valvegrid',
	    show: { 
	        selectColumn: true,
	        toolbar: true,
	        toolbarReload: false,
	        toolbarAdd: true,
	        toolbarDelete: true,
	        toolbarColumns: false
	    },
	    columns: [                
	        { field: 'pipeid', caption: 'Pipe ID', sortable:true, size: '25%', editable: {type: 'int', min:'1'}, render: 'int'},
	        { field: 'valvesetting', caption: 'Valve Pressure Reducing Setting (m)', sortable:true, size: '25%', editable: {type: 'float', min:'0'}, render: 'number:2'}
	    ],
	    onAdd : function(event){
	    	addRecord(this);
	    }
	},
	//config of the table in the results nodes tab
    resultnodegrid : { 
           name: 'resultnodegrid',
           show: { 
               toolbar: true,
               toolbarReload: false,
               toolbarAdd: false,
               toolbarDelete: false,
               toolbarColumns: false
           },
           columns: [                
               { field: 'nodeid', caption: 'Node ID', sortable:true, size: '25%'},
               { field: 'nodename', caption: 'Node Name', sortable:true, size: '25%'},
               { field: 'demand', caption: 'Demand (lps)', sortable:true, render: 'number:2', size: '25%'},
               { field: 'elevation', caption: 'Elevation (m)', sortable:true, render: 'number:2', size: '25%'},
               { field: 'head', caption: 'Head (m)', sortable:true, render: 'number:2', size: '25%'},
               { field: 'pressure', caption: 'Pressure (m)', sortable:true, render: 'number:2', size: '25%'},
               { field: 'minpressure', caption: 'Min. Pressure (m)', sortable:true, render: 'number:2', size: '25%'}
           ]
      	},
	//config of the table in the results pipes tab
    resultpipegrid : { 
            name: 'resultpipegrid',
            show: { 
                toolbar: true,
                toolbarReload: false,
                toolbarAdd: false,
                toolbarDelete: false,
                toolbarColumns: false
            },
            columns: [                
                { field: 'pipeid', caption: 'Pipe ID', sortable:true, size: '10%', min: '56'},
                { field: 'startnode', caption: 'Start Node', sortable:true, size: '10%', min: '75'},
                { field: 'endnode', caption: 'End Node', sortable:true, size: '10%', min: '71'},
                { field: 'length', caption: 'Length (m)', sortable:true, render: 'number:2', size: '10%', min: '78'},
                { field: 'flow', caption: 'Flow (lps)', sortable:true, render: 'number:2', size: '10%', min: '70'},
                { field: 'speed', caption: 'Speed (m/s)', sortable:true, render: 'number:2', size: '10%', min: '86'},
                { field: 'diameter', caption: 'Diameter (mm)', sortable:true, render: 'number:2', size: '10%', min: '102'},
                { field: 'roughness', caption: 'Roughness', sortable:true, render: 'number:2', size: '10%', min: '76'},
                { field: 'headloss', caption: 'Headloss (m)', sortable:true, render: 'number:2', size: '10%', min: '91'},
                { field: 'headlossperkm', caption: 'Headloss per KM (m)', sortable:true, render: 'number:2', size: '15%', min: '135'},
                { field: 'cost', caption: 'Cost (Rs)', sortable:true, render: 'number:2', size: '15%', min: '85'},  
                { field: 'pumphead', caption: 'Pump Head (m)', sortable:true, render: 'number:2', size: '15%', min: '110'},
                { field: 'pumppower', caption: 'Pump Power (kW)', sortable:true, render: 'number:2', size: '15%', min: '120'},
                { field: 'valvesetting', caption: 'Valve Setting (m)', sortable:true, render: 'number:2', size: '15%', min: '115'},
                { field: 'status', caption: 'Status', sortable:true, render: function (record, index, column_index) {
                    var text = '';
                    if(record.parallelallowed)
                    {
                    	text = 'Parallel';
                    }
                	var html = '<div>'+ text + '</div>';
                    return html;
                }, size: '10%', min: '82'} 
            ]
       	},
	//config of the table in the results cost tab
    resultcostgrid : { 
            name: 'resultcostgrid',
            show: { 
                toolbar: true,
                toolbarReload: false,
                toolbarAdd: false,
                toolbarDelete: false,
                toolbarColumns: false
            },
            columns: [                
                { field: 'diameter', caption: 'Diameter (mm)', size: '25%'},
                { field: 'length', caption: 'Length (m)', render: 'number:2', size: '25%'},
                { field: 'cost', caption: 'Cost (Rs)', render: 'number:2', size: '25%'},
                { field: 'cumulativecost', caption: 'Cumulative Cost (Rs)', render: 'number:2', size: '25%'},
                ]
       	},
	//config of the table in the results esr cost tab
	resultesrcostgrid : { 
		name: 'resultesrcostgrid',
		show: { 
			toolbar: true,
			toolbarReload: false,
			toolbarAdd: false,
			toolbarDelete: false,
			toolbarColumns: false
		},
		columns: [                
			{ field: 'nodeid', caption: 'ESR Node ID', sortable:true, size: '25%'},
			{ field: 'nodename', caption: 'Node Name', sortable:true, size: '25%'},
			{ field: 'elevation', caption: 'Elevation (m)', sortable:true, render: 'number:2', size: '25%'},
			{ field: 'capacity', caption: 'Capacity (l)', sortable:true, render: 'number:0', size: '25%'},
			{ field: 'esrheight', caption: 'Esr Height (m)', sortable:true, render: 'number:2', size: '25%'},
			{ field: 'cost', caption: 'Cost (Rs)', sortable:true, render: 'number:2', size: '25%'},
			{ field: 'cumulativecost', caption: 'Cumulative Cost (Rs)', sortable:true, render: 'number:2', size: '25%'},
			],
		onDblClick: function(event){
			this.expand(event.recid);
		},    
		onExpand: function (event) {
			if (w2ui.hasOwnProperty('subgrid-' + event.recid)) w2ui['subgrid-' + event.recid].destroy();
				var nodes = w2ui.resultnodegrid.records;
				var currnode = w2ui.resultesrcostgrid.get(event.recid);
				var rec = [];
				var recid = 1;
				$.each(nodes, function(key,value){
					if(value.esr===currnode.nodeid && value.demand > 0){
						var n = new Object();
						n.recid=1;
						n.nodeid = value.nodeid;
						n.nodename = value.nodename;
						n.elevation = value.elevation;
						n.demand = value.dailydemand;
						rec.push(n);
						recid++;
					}
				});
				var h = (25*recid+5)+'px';
				$('#'+ event.box_id).css({ margin: '0px', padding: '0px', width: '100%' }).animate({ height: h }, 100);
				setTimeout(function () {
					$('#'+ event.box_id).w2grid({
						name: 'subgrid-' + event.recid, 
						show: { columnHeaders: true },
						fixedBody: true,
						columns: [                
							{ field: 'nodeid', caption: 'Node ID', sortable:true, size: '25%'},
							{ field: 'nodename', caption: 'Node Name', sortable:true, size: '25%'},
							{ field: 'elevation', caption: 'Elevation (m)', sortable:true, render: 'number:2', size: '25%'},
							{ field: 'demand', caption: 'Capacity (l)', sortable:true, render: 'number:0', size: '25%'},
							{ field: 'dummy1', caption: '', sortable:true, render: 'number:2', size: '25%'},
							{ field: 'dummy2', caption: '', sortable:true, render: 'number:2', size: '25%'},
							{ field: 'dummy3', caption: '', sortable:true, render: 'number:2', size: '25%'},
						],
						records: rec
					});
					w2ui['subgrid-' + event.recid].resize();
				}, 300);
			}
	},
	//config of the table in the results pump tab
	resultpumpgrid : { 
		name: 'resultpumpgrid',
		show: { 
			toolbar: true,
			toolbarReload: false,
			toolbarAdd: false,
			toolbarDelete: false,
			toolbarColumns: false
		},
		columns: [                
			{ field: 'pipeid', caption: 'Pipe ID', sortable:true, size: '25%'},
			{ field: 'pumphead', caption: 'Pump Head (m)', sortable:true, render: 'number:2', size: '25%'},
			{ field: 'pumppower', caption: 'Pump Power (kW)', sortable:true, render: 'number:2', size: '25%'},
			{ field: 'energycost', caption: 'Energy Cost (Rs)', sortable:true, render: 'int', size: '25%'},
			{ field: 'capitalcost', caption: 'Capital Cost (Rs)', sortable:true, render: 'int', size: '25%'},
			{ field: 'totalcost', caption: 'Total Cost (Rs)', sortable:true, render: 'int', size: '25%'},
			]
	},
};

$(function () {	
	//intialize the frontend based on the config definitions above
	$('#main').w2layout(config.layout);
    w2ui.layout.content('left', $().w2sidebar(config.sidebar));
    w2ui.layout.content('main', $().w2form(config.generalform)); 
    // in memory initialization
    $().w2grid(config.nodegrid);
    $().w2grid(config.pipegrid);
    $().w2grid(config.commercialpipegrid);
    $().w2grid(config.resultnodegrid);
    $().w2grid(config.resultpipegrid);
    $().w2grid(config.resultcostgrid);
    $().w2grid(config.resultesrcostgrid);
    $().w2grid(config.resultpumpgrid);
    $().w2layout(config.resultlayout);
    $().w2layout(config.esrlayout);
    $().w2form(config.esrtopform);
    $().w2form(config.esrmainform);
    $().w2grid(config.esrmaingrid);
    w2ui.esrlayout.content('top',w2ui.esrtopform);
    w2ui.esrlayout.content('main',w2ui.esrmainform);
    $().w2layout(config.pumplayout);
    $().w2form(config.pumptopform);
    $().w2form(config.pumpmainform);
    $().w2grid(config.pumpmaingrid);
    $().w2grid(config.valvegrid);
    w2ui.pumplayout.content('top',w2ui.pumptopform);
    w2ui.pumplayout.content('main',w2ui.pumpmainform);
    w2ui.resultlayout.content('main', w2ui.resultnodegrid);
    
    w2ui.nodegrid.on('change', function(event) {
    	event.onComplete = function (){
    		w2ui.nodegrid.mergeChanges();
    	};
    });
    w2ui.pipegrid.on('change', function(event) {
    	event.onComplete = function (){
    		w2ui.pipegrid.mergeChanges();
    	};
    });
    w2ui.commercialpipegrid.on('change', function(event) {
    	event.onComplete = function (){
    		w2ui.commercialpipegrid.mergeChanges();
    	};
    });
    w2ui.esrmaingrid.on('change', function(event) {
    	event.onComplete = function (){
    		w2ui.esrmaingrid.mergeChanges();
    	};
    });
    w2ui.pumpmaingrid.on('change', function(event) {
    	event.onComplete = function (){
    		w2ui.pumpmaingrid.mergeChanges();
    	};
    });
    w2ui.valvegrid.on('change', function(event) {
    	event.onComplete = function (){
    		w2ui.valvegrid.mergeChanges();
    	};
    });
    
    w2ui.layout.content('right','<div id="map">Could not connect to Google. Please check connection and refresh page.</div>'+
								//'<div id="chart_div" style="width=\'100%\' ">there</div>'+
								'<div id="chart_div"></div>'+
								'<input type="hidden" id="chart_status" value="hide"/>');
  	
    $('#chart_status').change(elevationChartChanged);
    
	//add a hidden form. it is used to download input/output files
    $('body').append('<iframe style="display:none" id="hiddenFrame" name="hiddenFrame"></iframe>');
	
	//Initially it was only jaltantra, without 2.2.2.0. ====   OptimizerServlet
    $('body').append('<form action="/jaltantra/OptimizerServlet" method="post" target="hiddenFrame" id="postToIframeForm"></form>');
    $('body').append('<input type="file" id="fileUpload" style="opacity:0; height:0px;width:0px;" />');
    
	//read the uploaded input files
    reader = new FileReader();
	reader.onload = function(){
			switch (uploadFileType) {
			case XMLFILE:
				uploadXmlFile(reader.result);
				break;
			case BRANCHFILE:
				uploadBranchFile(reader.result);
				break;
			case EXCELFILE:
				uploadExcelFile(reader.result);
				break;	
			default:
				break;
			}
			$(".ui-tooltip-content").parents('div').remove();
		};
    
	$('#fileUpload').change(function()
    		{
    			var files = $('#fileUpload')[0].files;
    			
    			try{
	    			if(files!==null && files.length > 0)
	    			{
	    				if(uploadFileType === EXCELFILE)
	   					{
	   						reader.readAsArrayBuffer(files[0]);
	   					}
	    				else
	    				{	
	    					reader.readAsText(files[0]);
	    				}
	    			}
    			}
    			catch(e) {
    				w2alert(e);
    			}
    			finally {
    				$('#fileUpload').val('');
    			}
    		});
    
	//redraw chart if window is resized
    $(window).resize(function() {
    	if($('#chart_status').val() == "show")
    	{
        	clearTimeout(resizeId);
        	resizeId = setTimeout(function(){chart.draw(data, chartOptions2);}, 500);
    	}
    });
    
//     $( window ).resize(function() {
//     	chart.draw(data, chartOptions2);
//     	});
    
    $(document).tooltip({
 
      // place tooltip on the right edge
      position: { my: "left+15 center", at: "right center" },
 
      // use the built-in fadeIn/fadeOut effect
      effect: "fade",
 
      // custom opacity setting
      opacity: 0.7
 
      });
    //$(document).tooltip().off("mouseover mouseout");
    $(".ui-tooltip-content").parents('div').remove();
    
	//confirm before user leaves page
    $(window).on('beforeunload', function(){
    	  return 'Are you sure you want to leave?';
    	});
    
	//load google chart libraries
	google.charts.load('current', {packages: ['corechart']});
	google.charts.setOnLoadCallback(map_initialize);
});

//display esr popup that describes the ESR option
function esrPopup(){
	w2popup.open({
	    title   : 'About ESR Option',
	    body    : 'Enabling this option will include ESR costing as part of the optimzation.'+
	    		  '<br><br>'+'The network from the source to the ESRs is considered the primary network and the network from the ESRs to the individual nodes is considered the secondary network.'+
	    		  '<br><br>'+'The flow in the primary network depends on the number of supply hours provided in the general screen and the flow in the secondary network depends on the number of secondary network supply hours provided in this screen.'+
	    		  '<br><br>'+'The ESR capacity is determined by the ESR capacity factor which is the ratio of the ESR size to the daily demand. For example for a factor of 0.5 ESR will be sized as half the daily demand.'+
	    		  '<br><br>'+'Note that enabling this option will cause the optimization to take a long time especially for large networks. To improve speed, fix some ESR locations or do not allow ESRs at dummy nodes.',
	    showMax: true,
	    width: 600,
	    height: 300
	});
}

//display pump popup that describes the pump option
function pumpPopup(){
	w2popup.open({
	    title   : 'About Pump Option',
	    body    : 'Enabling this option will include Pump costing as part of the optimzation.'+
	    		  '<br><br>'+'Pumps can be placed along the pipes to boost the pressure head in the pipe.'+
	    		  '<br><br>'+'By default the optimization can select any pipes to install a pump. User can manually disable some pipes from having a pump.'+
	    		  '<br><br>'+'User can also manually set the pump power for any pipe in the network.'+
	    		  '<br><br>'+'The total cost attributed to the pump is the present value of the total energy cost over the design lifetime of the pumps.',
	    showMax: true,
	    width: 600,
	    height: 300
	});
}

function replacer(key, value) {
	return value ? value : undefined;
}

//return an array of node ids given a list of nodes
function esrnodereplacer(key, value) {
	if(key==='must_esr' || key==='must_not_esr'){
		if(value===undefined)
			return value;
		
		var new_value = [];
		$.each(value, function(key2,value2){
			new_value.push(value2.id);
		});
		return new_value;
	}
	return value ? value : undefined;
}

//return an array of node ids given a list of nodes
function pumpnodereplacer(key, value) {
	if(key==='must_not_pump'){
		if(value===undefined)
			return value;
		
		var new_value = [];
		$.each(value, function(key2,value2){
			new_value.push(value2.id);
		});
		return new_value;
	}
	return value ? value : undefined;
}

//save output as an excel file
//all the result tables are converted into json objects
//these json objects are then sent to the server
//the server then returns a file with the data uploaded
function saveOutputExcelFile()
{
	var generalString = JSON.stringify(w2ui.generalform.record,replacer);
	
	var resultNodesString = JSON.stringify(w2ui.resultnodegrid.records,replacer);// .replace(/\"/g, "'");
    var resultPipesString = JSON.stringify(w2ui.resultpipegrid.records,replacer);
    var resultCostString = JSON.stringify(w2ui.resultcostgrid.records,replacer);
    
    var esrProperties = w2ui.esrmainform.record;
    esrProperties.esr_enabled = (w2ui.esrtopform.record['enable_esr'] == true);
    var esrGeneralString = JSON.stringify(esrProperties,esrnodereplacer);
    var resultEsrCostString = JSON.stringify(w2ui.resultesrcostgrid.records,replacer);
    
    var pumpProperties = w2ui.pumpmainform.record;
    pumpProperties.pump_enabled = (w2ui.pumptopform.record['enable_pump'] == true);
    pumpProperties.energycost_factor = 1;
    var pumpGeneralString = JSON.stringify(pumpProperties,pumpnodereplacer);
    var pumpManualString = JSON.stringify(w2ui.pumpmaingrid.records,replacer);
	var resultPumpCostString = JSON.stringify(w2ui.resultpumpgrid.records.slice(0,-1),replacer);
	
    var valveString = JSON.stringify(w2ui.valvegrid.records,replacer);
    
	$('#postToIframeForm').append('<input type="hidden" name="action" />');
	
	$('#postToIframeForm').append('<input type="hidden" name="general" />');
	$('#postToIframeForm').append('<input type="hidden" name="resultnodes" />');
	$('#postToIframeForm').append('<input type="hidden" name="resultpipes" />');
	$('#postToIframeForm').append('<input type="hidden" name="resultcosts" />');
	$('#postToIframeForm').append('<input type="hidden" name="esrGeneral" />');
	$('#postToIframeForm').append('<input type="hidden" name="resultesrs" />');
	$('#postToIframeForm').append('<input type="hidden" name="pumpGeneral" />');
	$('#postToIframeForm').append('<input type="hidden" name="resultpumps" />');
	$('#postToIframeForm').append('<input type="hidden" name="valves" />');
	
	$('input[name="action"]').val("saveOutputExcel");
	$('input[name="general"]').val(generalString);
	$('input[name="resultnodes"]').val(resultNodesString);
	$('input[name="resultpipes"]').val(resultPipesString);
	$('input[name="resultcosts"]').val(resultCostString);
	$('input[name="esrGeneral"]').val(esrGeneralString);
	$('input[name="resultesrs"]').val(resultEsrCostString);
	$('input[name="pumpGeneral"]').val(pumpGeneralString);
	$('input[name="resultpumps"]').val(resultPumpCostString);
	$('input[name="valves"]').val(valveString);
	
	$('#postToIframeForm').submit().empty();
}

//save output as an epanet file
//all the result tables are converted into json objects
//these json objects are then sent to the server
//the server then returns a file with the data uploaded
function saveOutputEpanetFile()
{
	var generalString = JSON.stringify(w2ui.generalform.record,replacer);
	
	var resultNodesString = JSON.stringify(w2ui.resultnodegrid.records,replacer);// .replace(/\"/g, "'");
    var resultPipesString = JSON.stringify(w2ui.resultpipegrid.records,replacer);
    var resultCostString = JSON.stringify(w2ui.resultcostgrid.records,replacer);
    
    var esrProperties = w2ui.esrmainform.record;
    esrProperties.esr_enabled = (w2ui.esrtopform.record['enable_esr'] == true);
    var esrGeneralString = JSON.stringify(esrProperties,esrnodereplacer);
    var resultEsrCostString = JSON.stringify(w2ui.resultesrcostgrid.records,replacer);
    
    var pumpProperties = w2ui.pumpmainform.record;
    pumpProperties.pump_enabled = (w2ui.pumptopform.record['enable_pump'] == true);
    pumpProperties.energycost_factor = 1;
    var pumpGeneralString = JSON.stringify(pumpProperties,pumpnodereplacer);
    var pumpManualString = JSON.stringify(w2ui.pumpmaingrid.records,replacer);
	var resultPumpCostString = JSON.stringify(w2ui.resultpumpgrid.records.slice(0,-1),replacer);
	
    var valveString = JSON.stringify(w2ui.valvegrid.records,replacer);
    
	$('#postToIframeForm').append('<input type="hidden" name="action" />');
	
	$('#postToIframeForm').append('<input type="hidden" name="general" />');
	$('#postToIframeForm').append('<input type="hidden" name="resultnodes" />');
	$('#postToIframeForm').append('<input type="hidden" name="resultpipes" />');
	$('#postToIframeForm').append('<input type="hidden" name="resultcosts" />');
	$('#postToIframeForm').append('<input type="hidden" name="esrGeneral" />');
	$('#postToIframeForm').append('<input type="hidden" name="resultesrs" />');
	$('#postToIframeForm').append('<input type="hidden" name="pumpGeneral" />');
	$('#postToIframeForm').append('<input type="hidden" name="resultpumps" />');
	$('#postToIframeForm').append('<input type="hidden" name="valves" />');
	$('#postToIframeForm').append('<input type="hidden" name="coordinatesstring" />');
	$('#postToIframeForm').append('<input type="hidden" name="verticesstring" />');
	
	$('input[name="action"]').val("saveOutputEpanet");
	$('input[name="general"]').val(generalString);
	$('input[name="resultnodes"]').val(resultNodesString);
	$('input[name="resultpipes"]').val(resultPipesString);
	$('input[name="resultcosts"]').val(resultCostString);
	$('input[name="esrGeneral"]').val(esrGeneralString);
	$('input[name="resultesrs"]').val(resultEsrCostString);
	$('input[name="pumpGeneral"]').val(pumpGeneralString);
	$('input[name="resultpumps"]').val(resultPumpCostString);
	$('input[name="valves"]').val(valveString);
	$('input[name="coordinatesstring"]').val(coordinatesstring);
	$('input[name="verticesstring"]').val(verticesstring);
	
	$('#postToIframeForm').submit().empty();
}

//generate coordinates from a network of nodes and pipes
function generateCoordinates(){
	coordinatesstring="";
    verticesstring="";
    
	var g = new dagre.graphlib.Graph({multigraph: true});

	// Set an object for the graph label
	g.setGraph({});
	g.graph().nodesep=150;
	g.graph().rankdir="BT";

	// Default to assigning a new object as a label for each new edge.
	g.setDefaultEdgeLabel(function() { return {}; });
	
	var sourceid = w2ui.generalform.record['source_nodeid'];
		
	var pipesseen = new Set();
	var seriespipes = new Set();
	var esrnodes = new Set();
	var pumppipes = new Set();
	var valvepipes = new Set();
	var esrwithprimarychild = new Set();
	
	$.each(w2ui.resultesrcostgrid.records, function(key,e){
		esrnodes.add(e.nodeid);
		if(e.hasprimarychild)
			esrwithprimarychild.add(e.nodeid);
	});
	
	$.each(w2ui.resultpumpgrid.records, function(key,e){
		pumppipes.add(e.pipeid);
	});
	
	
	$.each(w2ui.valvegrid.records, function(key,e){
		valvepipes.add(e.pipeid);
	});
	
	$.each(w2ui.resultnodegrid.records, function(key,n){
		var nodeid = n.nodeid+"";
		if(esrnodes.has(n.nodeid)){
			nodeid = n.nodeid+"t";
			if(n.demand > 0){
				g.setNode(n.nodeid+"d",  { label: n.nodeid+"d", width: 100, height: 100 });
				g.setEdge(n.nodeid+"t",n.nodeid+"d", {label:n.nodeid+"d", minlen:0}, n.nodeid+"d");
			}
			if(esrwithprimarychild.has(n.nodeid)){
				g.setNode(n.nodeid+"j",  { label: n.nodeid+"j", width: 100, height: 100 });
				g.setEdge(n.nodeid+"j",n.nodeid+"t", {label:n.nodeid+"j", minlen:0}, n.nodeid+"j");
			}
		}
		g.setNode(nodeid,  { label: nodeid, width: 100, height: 100 });
	});
	
	
	$.each(w2ui.resultpipegrid.records, function(key,p){
		if(pipesseen.has(p.pipeid)){
			if(!p.parallelallowed){
				seriespipes.add(p.pipeid);
			}
		}
		else{
			pipesseen.add(p.pipeid);
		}
	});
	
	pipesseen = new Set();
	$.each(w2ui.resultpipegrid.records, function(key,p){
		var startnode = p.startnode+"";
		var endnode = p.endnode+"";
		var pipeid = p.pipeid+"";
		var l = Math.max(1,Math.round(p.length/1000));
				
		if(esrnodes.has(p.startnode)){
			if(p.isprimary)
				startnode += "j";
			else
				startnode += "t";
		}
		
		if(esrnodes.has(p.endnode)){
			if(esrwithprimarychild.has(p.endnode))
				endnode += "j";
			else
				endnode += "t";
		}
		
		if(pipesseen.has(p.pipeid)){
			// parrallel pipe
			if(p.parallelallowed){
				pipeid += "p";
				if(pumppipes.has(p.pipeid)){
					startnode = startnode + "pump";
				}
				if(valvepipes.has(p.pipeid)){
					startnode = startnode + "valve";
				}
			}
			// series 2nd pipe
			else{
				startnode = startnode+"s"+endnode;
				pipeid += "s";
			}
		}
		else{
			// series 1st pipe
			if(seriespipes.has(p.pipeid)){
				endnode = startnode+"s"+endnode;
				g.setNode(endnode,  { label: endnode, width: 100, height: 100 });
			}
			pipesseen.add(p.pipeid);
			
			if(pumppipes.has(p.pipeid)){
				var tempnode = startnode + "pump";
				g.setNode(tempnode,  { label: tempnode, width: 100, height: 100 });
				g.setEdge(startnode,tempnode, {label:pipeid+"pump", minlen:1}, pipeid);
				startnode = tempnode;
			}
			if(valvepipes.has(p.pipeid)){
				var tempnode = startnode + "valve";
				g.setNode(tempnode,  { label: tempnode, width: 100, height: 100 });
				g.setEdge(startnode,tempnode, {label:pipeid+"valve", minlen:1}, pipeid);
				startnode = tempnode;
			}
		}
		
		g.setEdge(startnode,endnode, {label:pipeid, minlen:l}, pipeid);		
	});
	
	dagre.layout(g);
	
	g.nodes().forEach(function(v) {
		coordinatesstring += v + " " + g.node(v).x + " "+ g.node(v).y + ",";
	});
	g.edges().forEach(function(e) {
		ed = g.edge(e);
		ed.points.forEach(function(p) {
			verticesstring += ed.label + " " + p.x + " " + p.y + ",";
		});
	});
	
	
}

//save input as a xml file
//all the result tables are converted into json objects
//these json objects are then sent to the server
//the server then returns a file with the data uploaded
function saveInputXmlFile()
{
	var generalString = JSON.stringify(w2ui.generalform.record,replacer);
	
	var nodesString = JSON.stringify(w2ui.nodegrid.records,replacer);// .replace(/\"/g, "'");
    var pipesString = JSON.stringify(w2ui.pipegrid.records,replacer);
    var commercialPipesString = JSON.stringify(w2ui.commercialpipegrid.records,replacer);
    
    var esrProperties = w2ui.esrmainform.record;
    esrProperties.esr_enabled = (w2ui.esrtopform.record['enable_esr'] == true);
    var esrGeneralString = JSON.stringify(esrProperties,esrnodereplacer);
    var esrCostString = JSON.stringify(w2ui.esrmaingrid.records,replacer);
    
    var pumpProperties = w2ui.pumpmainform.record;
    pumpProperties.pump_enabled = (w2ui.pumptopform.record['enable_pump'] == true);
    pumpProperties.energycost_factor = 1;
    var pumpGeneralString = JSON.stringify(pumpProperties,pumpnodereplacer);
    var pumpManualString = JSON.stringify(w2ui.pumpmaingrid.records,replacer);
	
    var valveString = JSON.stringify(w2ui.valvegrid.records,replacer);
    
    
    var mapNodesString = getNodesJSON();
    var mapPipesString = getPipesJSON();
    
	$('#postToIframeForm').append('<input type="hidden" name="action" />');
	
	$('#postToIframeForm').append('<input type="hidden" name="general" />');
	$('#postToIframeForm').append('<input type="hidden" name="nodes" />');
	$('#postToIframeForm').append('<input type="hidden" name="pipes" />');
	$('#postToIframeForm').append('<input type="hidden" name="commercialpipes" />');
	
	$('#postToIframeForm').append('<input type="hidden" name="esrGeneral" />');
	$('#postToIframeForm').append('<input type="hidden" name="esrCost" />');
	
	$('#postToIframeForm').append('<input type="hidden" name="pumpGeneral" />');
	$('#postToIframeForm').append('<input type="hidden" name="pumpManual" />');
	
	$('#postToIframeForm').append('<input type="hidden" name="valves" />');
	
	$('#postToIframeForm').append('<input type="hidden" name="mapnodes" />');
	$('#postToIframeForm').append('<input type="hidden" name="mappipes" />');
	$('#postToIframeForm').append('<input type="hidden" name="mapsource" />')
	
	$('input[name="action"]').val("saveInputXml");
	$('input[name="general"]').val(generalString);
	$('input[name="nodes"]').val(nodesString);
	$('input[name="pipes"]').val(pipesString);
	$('input[name="commercialpipes"]').val(commercialPipesString);
	$('input[name="esrGeneral"]').val(esrGeneralString);
	$('input[name="esrCost"]').val(esrCostString);
	$('input[name="pumpGeneral"]').val(pumpGeneralString);
	$('input[name="pumpManual"]').val(pumpManualString);
	$('input[name="valves"]').val(valveString);
	$('input[name="mapnodes"]').val(mapNodesString);
	$('input[name="mappipes"]').val(mapPipesString);
	$('input[name="mapsource"]').val(sourceMarker ? sourceMarker.nodeID : "");
	
	$('#postToIframeForm').submit().empty();
}

//save input as an excel file
//all the result tables are converted into json objects
//these json objects are then sent to the server
//the server then returns a file with the data uploaded
function saveInputExcelFile()
{
	var generalString = JSON.stringify(w2ui.generalform.record,replacer);
	
	var nodesString = JSON.stringify(w2ui.nodegrid.records,replacer);// .replace(/\"/g, "'");
    var pipesString = JSON.stringify(w2ui.pipegrid.records,replacer);
    var commercialPipesString = JSON.stringify(w2ui.commercialpipegrid.records,replacer);
    
    var esrProperties = w2ui.esrmainform.record;
    esrProperties.esr_enabled = (w2ui.esrtopform.record['enable_esr'] == true);
    var esrGeneralString = JSON.stringify(esrProperties,esrnodereplacer);
    var esrCostString = JSON.stringify(w2ui.esrmaingrid.records,replacer);
    
    var pumpProperties = w2ui.pumpmainform.record;
    pumpProperties.pump_enabled = (w2ui.pumptopform.record['enable_pump'] == true);
    pumpProperties.energycost_factor = 1;
    var pumpGeneralString = JSON.stringify(pumpProperties,pumpnodereplacer);
    var pumpManualString = JSON.stringify(w2ui.pumpmaingrid.records,replacer);
	
    var valveString = JSON.stringify(w2ui.valvegrid.records,replacer);
    
    var mapNodesString = getNodesJSON();
    var mapPipesString = getPipesJSON();
    
	$('#postToIframeForm').append('<input type="hidden" name="action" />');
	
	$('#postToIframeForm').append('<input type="hidden" name="general" />');
	$('#postToIframeForm').append('<input type="hidden" name="nodes" />');
	$('#postToIframeForm').append('<input type="hidden" name="pipes" />');
	$('#postToIframeForm').append('<input type="hidden" name="commercialpipes" />');
	
	$('#postToIframeForm').append('<input type="hidden" name="esrGeneral" />');
	$('#postToIframeForm').append('<input type="hidden" name="esrCost" />');
	
	$('#postToIframeForm').append('<input type="hidden" name="pumpGeneral" />');
	$('#postToIframeForm').append('<input type="hidden" name="pumpManual" />');
	
	$('#postToIframeForm').append('<input type="hidden" name="valves" />');
	
	$('#postToIframeForm').append('<input type="hidden" name="mapnodes" />');
	$('#postToIframeForm').append('<input type="hidden" name="mappipes" />');
	$('#postToIframeForm').append('<input type="hidden" name="mapsource" />')
	
	$('input[name="action"]').val("saveInputExcel");
	$('input[name="general"]').val(generalString);
	$('input[name="nodes"]').val(nodesString);
	$('input[name="pipes"]').val(pipesString);
	$('input[name="commercialpipes"]').val(commercialPipesString);
	$('input[name="esrGeneral"]').val(esrGeneralString);
	$('input[name="esrCost"]').val(esrCostString);
	$('input[name="pumpGeneral"]').val(pumpGeneralString);
	$('input[name="pumpManual"]').val(pumpManualString);
	$('input[name="valves"]').val(valveString);
	$('input[name="mapnodes"]').val(mapNodesString);
	$('input[name="mappipes"]').val(mapPipesString);
	$('input[name="mapsource"]').val(sourceMarker ? sourceMarker.nodeID : "");
	
	$('#postToIframeForm').submit().empty();
}

// event handler when elevation chart changes
function elevationChartChanged(event)
{
	console.log('chart changed');
	var chartStatus = $('#chart_status').val();
	if(chartStatus=="hide" && $('#chart_div').is(':visible'))
	{
		$('#map').height('100%');
		$('#chart_div').hide();
		console.log('chart hidden');
	}
	else if(chartStatus=="show" && !$('#chart_div').is(':visible'))
	{
		$('#map').height('80%');
		$('#chart_div').show();
		console.log('chart shown');
	}	
}

//add a new row to a table
function addRecord(grid, field, notAllowedIDs)
{
	var newrecid = getNewRecid(grid);
	var record = {recid: newrecid};
	if(field)
	{
			record[field] = getNewRecid(grid, field, notAllowedIDs);
	}
	grid.add( record );
}

//upload XML input file
//fill the input tabs with the data
//report any errors/mssing data
function uploadXmlFile(xmlFileString)
{
	//resetResults();

	resetInput();

	var errormessages = "";
	try
	{
// 		var xmlfile = $('#file').data('selected');
// 		if(!xmlfile || xmlfile.length==0)
// 		{
// 			errormessages += "No File Selected.<br>";
// 			throw ""
// 		}
		
// 		var xmlstring = atob(xmlfile[0]['content']);	
		var xmlobject = $.parseXML(xmlFileString);
		if(!xmlobject)
		{
			errormessages += "File in incorrect XML format.<br>";
			throw ""
		}
				        
        var namenode = $(xmlobject).find("name");
        if (namenode && namenode.length > 0) 
        {
        	var nameproject = namenode.text();
        	w2ui.generalform.record['name_project'] = nameproject;
        }
        else
        {
        	errormessages += "No name present in the input file.<br>";
        }
        
        var organizationnode = $(xmlobject).find("organization");
        if (organizationnode && organizationnode.length > 0) 
        {
        	var nameorganization = organizationnode.text();
        	w2ui.generalform.record['name_organization'] = nameorganization;
        }
        
        var minpressurenode = $(xmlobject).find("defaultMinPressure");
        if (minpressurenode && minpressurenode.length > 0) 
        {
        	var minpressure = minpressurenode.text();
        	w2ui.generalform.record['min_node_pressure'] = minpressure;
        }
        else
        {
        	errormessages += "No defaultMinPressure present in the input file.<br>";
        }
        
        var supplyhoursnode = $(xmlobject).find("supplyHours");
        if (supplyhoursnode && supplyhoursnode.length > 0) 
        {
        	var supplyhours = supplyhoursnode.text();
        	w2ui.generalform.record['supply_hours'] = supplyhours;
        }
        else
        {
        	var peakfactornode = $(xmlobject).find("peakFactor");
            if (peakfactornode && peakfactornode.length > 0) 
            {
            	var peakfactor = peakfactornode.text();
            	w2ui.generalform.record['supply_hours'] = 24/parseFloat(peakfactor);
            }
            else
            {
            	w2ui.generalform.record['supply_hours'] = 24;
            }        	
        }
        
        var defaultroughnessnode = $(xmlobject).find("defaultRoughness");
        if (defaultroughnessnode && defaultroughnessnode.length > 0) 
        {
        	var defaultroughness = defaultroughnessnode.text();
        	w2ui.generalform.record['def_pipe_roughness'] = defaultroughness;
        }
        else
        {
        	errormessages += "No defaultRoughness present in the input file.<br>";
        }
        
        var minheadlossperkmnode = $(xmlobject).find("minHeadLossPerKM");
        if (minheadlossperkmnode && minheadlossperkmnode.length > 0) 
        {
        	var minheadlossperkm = minheadlossperkmnode.text();
        	w2ui.generalform.record['min_hl_perkm'] = minheadlossperkm;
        }
        else
        {
        	errormessages += "No minHeadLossPerKM present in the input file.<br>";
	    }
        
        var maxheadlossperkmnode = $(xmlobject).find("maxHeadLossPerKM");
        if (maxheadlossperkmnode && maxheadlossperkmnode.length > 0) 
        {
        	var maxheadlossperkm = maxheadlossperkmnode.text();
        	w2ui.generalform.record['max_hl_perkm'] = maxheadlossperkm;
        }
        else
        {
        	errormessages += "No maxHeadLossPerKM present in the input file.<br>";
	    }

        var maxwaterspeednode = $(xmlobject).find("maxWaterSpeed");
        if (maxwaterspeednode && maxwaterspeednode.length > 0) 
        {
        	var maxwaterspeed = maxwaterspeednode.text();
        	w2ui.generalform.record['max_water_speed'] = maxwaterspeed;
        }
        
        var maxpipepressurenode = $(xmlobject).find("maxPipePressure");
        if (maxpipepressurenode && maxpipepressurenode.length > 0) 
        {
        	var maxpipepressure = maxpipepressurenode.text();
        	w2ui.generalform.record['max_pipe_pressure'] = maxpipepressure;
        }
        
        var sourcenode = $(xmlobject).find("source");
        if (sourcenode && sourcenode.length > 0) 
        {        	
        	var nodeid = sourcenode.attr("nodeID");
        	w2ui.generalform.record['source_nodeid'] = nodeid;
            
        	var nodename = sourcenode.attr("nodeName");
        	w2ui.generalform.record['source_nodename'] = nodename;
        	
        	var elevation = sourcenode.attr("elevation");
        	w2ui.generalform.record['source_elevation'] = elevation;
        	
        	var head = sourcenode.attr("head");
        	w2ui.generalform.record['source_head'] = head;
        }
        else
        {
        	errormessages += "No source present in the input file.<br>";
	    }
        
        var nodelist = $(xmlobject).find("node");                
        if (nodelist && nodelist.length > 0) 
        {        	
        	$.each (nodelist, function(key, val){
        	    var demand = $(val).attr("demand");
                var nodeid = $(val).attr("nodeID");
                var nodename = $(val).attr("nodeName");
                var minpressure = $(val).attr("minPressure");
                var elevation = $(val).attr("elevation");
               
                var newrecid = getNewRecid(w2ui.nodegrid);
                if(!nodeid)
               	{
               		nodeid = getNewRecid(w2ui.nodegrid, nodeid, w2ui.generalform.record['source_nodeid']);
               	}
                var record = {
                		recid: newrecid,
                		nodeid: nodeid,
                		nodename: nodename,
                		elevation: elevation,
                		demand: demand,
                		minpressure: minpressure
                		};
            	
                w2ui.nodegrid.add(record);
        	});
        } 
        else 
        {
        	errormessages += "No nodes present in the input file.<br>";
	    }
        
        var pipelist = $(xmlobject).find("pipe");               
        if (pipelist && pipelist.length > 0) 
        {	        	
        	$.each (pipelist, function(key, val){ 
        		var pipeid = $(val).attr("pipeID");
                var diameter = $(val).attr("diameter");
                var roughness = $(val).attr("roughness");               
                var length = $(val).attr("length");
                var startnode = $(val).attr("startNode");
                var endnode = $(val).attr("endNode");
                var parallelallowedString = $(val).attr("parallelAllowed");
                var parallelallowed = parallelallowedString === "true" ? true : false;
                
                
                var newrecid = getNewRecid(w2ui.pipegrid);
                if(!pipeid)
               	{
                	pipeid = getNewRecid(w2ui.pipegrid, pipeid);
               	}
                var record = {
                		recid: newrecid,
                		pipeid: pipeid,
                		diameter: diameter,
                		roughness: roughness,
                		length: length,
                		startnode: startnode,
                		endnode: endnode,
                		parallelallowed: parallelallowed
                		};
            	
                w2ui.pipegrid.add(record);   
            });
        } 
        else 
        {
        	errormessages += "No pipes present in the input file.<br>";
	    }
        
        var pipecost = $(xmlobject).find("pipeCost");                
        if (pipecost && pipecost.length > 0) 
        {	        	
        	$.each (pipecost, function(key, val){ 
            	
        		var diameter = $(val).attr("diameter");
        		var roughness = $(val).attr("roughness");
                var cost = $(val).attr("cost");               
                                       
                var newrecid = getNewRecid(w2ui.commercialpipegrid);
                var record = {
                		recid: newrecid,
                		diameter: diameter,
                		roughness: roughness,
                		cost: cost
                		};
            	
                w2ui.commercialpipegrid.add(record);
            });
        } 
        else 
        {
        	errormessages += "No pipecosts present in the input file.<br>";
	    } 
        
        var esr_enabled_boolean = false;
        var esrenablednode = $(xmlobject).find("esr_enabled");
        if (esrenablednode && esrenablednode.length > 0) 
        {
        	var esrenabled = esrenablednode.text();
        	if(esrenabled.toLowerCase()=="true"){
        		w2ui.esrtopform.record['enable_esr'] = true;
        		esr_enabled_boolean = true;
        	}
        }
        
        var secondarysupplyhoursnode = $(xmlobject).find("secondary_supply_hours");
        if (secondarysupplyhoursnode && secondarysupplyhoursnode.length > 0) 
        {
        	var secondarysupplyhours = parseFloat(secondarysupplyhoursnode.text());
        	if(secondarysupplyhours>0)
        		w2ui.esrmainform.record['secondary_supply_hours'] = secondarysupplyhours;
        }
        else if(esr_enabled_boolean){
        	errormessages += "No secondary supply hours present in the input file even when esr option is enabled.<br>";
        }
        
        var esrcapacityfactornode = $(xmlobject).find("esr_capacity_factor");
        if (esrcapacityfactornode && esrcapacityfactornode.length > 0) 
        {
        	var esrcapacityfactor = parseFloat(esrcapacityfactornode.text());
        	if(esrcapacityfactor>0)
        		w2ui.esrmainform.record['esr_capacity_factor'] = esrcapacityfactor;
        }
        else if(esr_enabled_boolean){
        	errormessages += "No ESR capacity factor present in the input file even when esr option is enabled.<br>";
        }
        
        var maxesrheightnode = $(xmlobject).find("max_esr_height");
        if (maxesrheightnode && maxesrheightnode.length > 0) 
        {
        	var maxesrheight = parseFloat(maxesrheightnode.text());
        	if(maxesrheight>0)
        		w2ui.esrmainform.record['max_esr_height'] = maxesrheight;
        }
        
        var allowdummynode = $(xmlobject).find("allow_dummy");
        if (allowdummynode && allowdummynode.length > 0) 
        {
        	var allowdummy = allowdummynode.text();
        	if(allowdummy.toLowerCase()=="true")
        		w2ui.esrmainform.record['allow_dummy'] = true;
        }
        
        var mustesr = $(xmlobject).find("must_esr");                
        if (mustesr && mustesr.length > 0) 
        {	 
        	w2ui.esrmainform.record["must_esr"] = [];
        	$.each (mustesr, function(key, val){ 
            	
        		var nodeid = parseInt($(val).text());
                
        		$.each(w2ui.nodegrid.records, function(index,value){
        			var id = value['nodeid'];
        			if(id==nodeid){
	        			var nodename = value['nodename'];
	        			var newnode;
	        			if(nodename===undefined || nodename==="")
	        				newnode = {id:id};
	        			else
	        				newnode = {id:id, text:nodename+'('+id+')'};
	        			w2ui.esrmainform.record["must_esr"].push(newnode);
	        			return false;
        			}
        		});
            });
        } 
        
        var mustnotesr = $(xmlobject).find("must_not_esr");                
        if (mustnotesr && mustnotesr.length > 0) 
        {	  
        	w2ui.esrmainform.record["must_not_esr"] = [];
        	$.each (mustnotesr, function(key, val){ 
            	
        		var nodeid = parseInt($(val).text());
                
        		$.each(w2ui.nodegrid.records, function(index,value){
        			var id = value['nodeid'];
        			if(id==nodeid){
	        			var nodename = value['nodename'];
	        			var newnode;
	        			if(nodename===undefined || nodename==="")
	        				newnode = {id:id};
	        			else
	        				newnode = {id:id, text:nodename+'('+id+')'};
	        			w2ui.esrmainform.record["must_not_esr"].push(newnode);
	        			return false;
        			}
        		});
            });
        } 
        
        var esrcost = $(xmlobject).find("esr_cost");                
        if (esrcost && esrcost.length > 0) 
        {	        	
        	$.each (esrcost, function(key, val){ 
            	
        		var mincapacity = $(val).attr("mincapacity");
        		var maxcapacity = $(val).attr("maxcapacity");
                var basecost = $(val).attr("basecost");               
                var unitcost = $(val).attr("unitcost");
                
                var newrecid = getNewRecid(w2ui.esrmaingrid);
                var record = {
                		recid: newrecid,
                		mincapacity: mincapacity,
                		maxcapacity: maxcapacity,
                		basecost: basecost,
                		unitcost: unitcost
                		};
            	
                w2ui.esrmaingrid.add(record);
            });
        } 
        else if(esr_enabled_boolean){
        	errormessages += "No esr costs present in the input file even when esr option is enabled.<br>";
        } 
        
        var pump_enabled_boolean = false;
        var pumpenablednode = $(xmlobject).find("pump_enabled");
        if (pumpenablednode && pumpenablednode.length > 0){
        	var pumpenabled = pumpenablednode.text();
        	if(pumpenabled.toLowerCase()=="true"){
        		w2ui.pumptopform.record['enable_pump'] = true;
        		pump_enabled_boolean = true;
        	}
        }
        
        var minpumpsizenode = $(xmlobject).find("minimum_pump_size");
        if (minpumpsizenode && minpumpsizenode.length > 0){
        	var minpumpsize = parseFloat(minpumpsizenode.text());
        	w2ui.pumpmainform.record['minpumpsize'] = minpumpsize;
        }
        else if(pump_enabled_boolean){
        	errormessages += "No minimum pump size present in the input file even when pump option is enabled.<br>";
        }
        
        var pumpefficiencynode = $(xmlobject).find("pump_efficiency");
        if (pumpefficiencynode && pumpefficiencynode.length > 0){
        	var pumpefficiency = parseFloat(pumpefficiencynode.text());
        	w2ui.pumpmainform.record['efficiency'] = pumpefficiency;
        }
        else if(pump_enabled_boolean){
        	errormessages += "No pump efficiency present in the input file even when pump option is enabled.<br>";
        }
        
        var capitalcostnode = $(xmlobject).find("capital_cost_per_kw");
        if (capitalcostnode && capitalcostnode.length > 0){
        	var capitalcost = parseFloat(capitalcostnode.text());
        	w2ui.pumpmainform.record['capitalcost_per_kw'] = capitalcost;
        }
        else if(pump_enabled_boolean){
        	errormessages += "No pump capital cost per kW present in the input file even when pump option is enabled.<br>";
        }
        
        var energycostnode = $(xmlobject).find("energy_cost_per_kwh");
        if (energycostnode && energycostnode.length > 0){
        	var energycost = parseFloat(energycostnode.text());
        	w2ui.pumpmainform.record['energycost_per_kwh'] = energycost;
        }
        else if(pump_enabled_boolean){
        	errormessages += "No pump energy cost per kWh present in the input file even when pump option is enabled.<br>";
        }
        
        var designlifetimenode = $(xmlobject).find("design_lifetime");
        if (designlifetimenode && designlifetimenode.length > 0){
        	var designlifetime = parseFloat(designlifetimenode.text());
        	w2ui.pumpmainform.record['design_lifetime'] = designlifetime;
        }
        else if(pump_enabled_boolean){
        	errormessages += "No pump design lifetime present in the input file even when pump option is enabled.<br>";
        }
        
        var discountratenode = $(xmlobject).find("discount_rate");
        if (discountratenode && discountratenode.length > 0){
        	var discountrate = parseFloat(discountratenode.text());
        	w2ui.pumpmainform.record['discount_rate'] = discountrate;
        }
        
        var inflationratenode = $(xmlobject).find("inflation_rate");
        if (inflationratenode && inflationratenode.length > 0){
        	var inflationrate = parseFloat(inflationratenode.text());
        	w2ui.pumpmainform.record['inflation_rate'] = inflationrate;
        }
        
        var mustnotpump = $(xmlobject).find("pipe_without_pump");                
        if (mustnotpump && mustnotpump.length > 0){	  
        	w2ui.pumpmainform.record["must_not_pump"] = [];
        	$.each (mustnotpump, function(key, val){ 
            	
        		var pipeid = parseInt($(val).text());
                
        		$.each(w2ui.pipegrid.records, function(index,value){
        			var id = value['pipeid'];
        			if(id==pipeid){
	        			var newnode = {id:id};
	        			w2ui.pumpmainform.record["must_not_pump"].push(newnode);
	        			return false;
        			}
        		});
            });
        }
        
        var manualpump = $(xmlobject).find("manual_pump");                
        if (manualpump && manualpump.length > 0){	        	
        	$.each (manualpump, function(key, val){ 
            	
        		var pipeid = $(val).attr("pipeid");
        		var pumppower = $(val).attr("pumppower");
                
                var newrecid = getNewRecid(w2ui.pumpmaingrid);
                var record = {
                		recid: newrecid,
                		pipeid: pipeid,
                		pumppower: pumppower
                		};
            	
                w2ui.pumpmaingrid.add(record);
            });
        }
        
        var manualvalve = $(xmlobject).find("valve");                
        if (manualvalve && manualvalve.length > 0){	        	
        	$.each (manualvalve, function(key, val){ 
            	
        		var pipeid = $(val).attr("pipeid");
        		var valvesetting = $(val).attr("valvesetting");
                
                var newrecid = getNewRecid(w2ui.valvegrid);
                var record = {
                		recid: newrecid,
                		pipeid: pipeid,
                		valvesetting: valvesetting
                		};
            	
                w2ui.valvegrid.add(record);
            });
        }
                
        var mapsourcenodes = $(xmlobject).find("map_source_node");                
        var mapsourcenodeid;
        if (mapsourcenodes && mapsourcenodes.length > 0) {
        	mapsourcenodeid = $(mapsourcenodes[0]).attr("nodeid"); 
        }
        
        var mapnodes = $(xmlobject).find("map_node");                
        if (mapnodes && mapnodes.length > 0) 
        {	        	
        	$.each (mapnodes, function(key, val){          	
        		var nodeid = $(val).attr("nodeid");
        		var latitude = $(val).attr("latitude");
        		var longitude = $(val).attr("longitude");
        		var nodename = $(val).attr("nodename");
        		var isesr = $(val).attr("isesr");
                            
        		var position = new google.maps.LatLng(latitude,longitude);
        		var marker = addMarker(position, false, nodeid, nodename);
        		
        		if(mapsourcenodeid===nodeid) {
        			setSource(marker);
        		}
        		else if(isesr && isesr.toLowerCase()=="true"){
        			marker.isesr = true;
        			marker.setIcon(esrIcon);
        		}
            });
        } 
        else 
        {
        	errormessages += "No map nodes present in the input file.<br>";
	    }
        
        var mappipes = $(xmlobject).find("map_pipe");                
        if (mappipes && mappipes.length > 0) 
        {	        	
        	$.each (mappipes, function(key, val){ 
        		var encodedPath = $(val).attr("encodedpath")
        		var path = google.maps.geometry.encoding.decodePath(encodedPath);
        		var origin = findNode($(val).attr("originid"));
       			var destination = findNode($(val).attr("destinationid"));
       			var length = $(val).attr("length");
       			addPath(path, origin, destination, false);
            });
        } 
        else 
        {
        	errormessages += "No map pipes present in the input file.<br>";
	    }
        elevationChartChanged();
       
    }	
	catch(err)
	{
		console.log(err);
		errormessages += err+"<br>";
	}
	finally {
		if(errormessages!="")
			w2alert(errormessages);
		w2ui.generalform.refresh();
		w2ui.sidebar.click('general');
	}
}

function fixdata(data) {
	var o = "", l = 0, w = 10240;
	for(; l<data.byteLength/w; ++l) o+=String.fromCharCode.apply(null,new Uint8Array(data.slice(l*w,l*w+w)));
	o+=String.fromCharCode.apply(null, new Uint8Array(data.slice(l*w)));
	return o;
}

//clear all the input forms/tables
function resetInput(){
	
	//reset general form
	w2ui.generalform.clear();
	
	//delete all grids
	w2ui.nodegrid.clear();
    w2ui.pipegrid.clear();
    w2ui.commercialpipegrid.clear();
    w2ui.esrmaingrid.clear();
    w2ui.pumpmaingrid.clear();
    w2ui.valvegrid.clear();
    
    w2ui.resultnodegrid.clear();
    w2ui.resultpipegrid.clear();
    w2ui.resultcostgrid.clear();
    w2ui.resultesrcostgrid.clear();
    w2ui.resultpumpgrid.clear();
    
    //reset esr form
    w2ui.esrtopform.clear();
    w2ui.esrmainform.clear();
    
    w2ui.pumptopform.clear();
    w2ui.pumpmainform.clear();
    
    //delete map info
    deleteAllNodes();
    $('#searchlocationinput')[0].value = "";
	
    if(autocomplete != undefined)
    	autocomplete.set('place',void(0));
	
	w2ui.sidebar.click('general');
}

//upload excel input file
//fill the input tabs with the data
//report any errors/mssing data
function uploadExcelFile(excelFileData){
	

// 	//resetResults();

 	resetInput();

 	var errormessages = "";
	try
	{	
		var excelFileArray = fixdata(excelFileData);
		var workbook = XLS.read(btoa(excelFileArray), {type: 'base64'});
		if(!workbook)
		{
			errormessages += "File in incorrect Excel format.<br>";
			throw ""
		}
				 
		var generalSheet = workbook.Sheets['General'];
		
		var range = XLSX.utils.decode_range(generalSheet["!ref"]);
		var lastRow = range.e.r;
		
		
		var row = range.s.r; //starting row is the title row
		row++; // CSE/CTARA row
		row++; // date row
		var cell;
		
		while(row < lastRow) {
			row++;
			
			cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			if(cell !== undefined && cell.v.trim().length!==0)
			{
				break;
			}
		}
		
		if(cell === undefined)
		{
			errormessages += "No Network Name present in the input file.<br>";
			throw "";
		}
		
		var titleCell = cell;
		var valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
		if(titleCell !== undefined && titleCell.v ==="Network Name" 
			 && valueCell !== undefined)
		{
			w2ui.generalform.record['name_project'] = valueCell.v;
		}			
		else
		{
			errormessages += "No Network Name present in the input file.<br>";
		}
		
		row++;
		titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
		if(titleCell !== undefined && titleCell.v ==="Organization Name")
		{
			if(valueCell !== undefined)
				w2ui.generalform.record['name_organization'] = valueCell.v;
		}			
		else
		{
			row--; // this entry was not added so revert to previous row
		}
		
		row++;
		titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
		if(titleCell !== undefined && titleCell.v ==="Minimum Node Pressure" 
			 && valueCell !== undefined)
		{
			w2ui.generalform.record['min_node_pressure'] = valueCell.v;
		}			
		else
		{
			errormessages += "No default Min Node Pressure present in the input file.<br>";
		}
        
		row++;
		titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
		if(titleCell !== undefined && titleCell.v ==="Default Pipe Roughness 'C'" 
			 && valueCell !== undefined)
		{
			w2ui.generalform.record['def_pipe_roughness'] = valueCell.v;
		}			
		else
		{
			errormessages += "No defaultRoughness present in the input file.<br>";
		}
		
		row++;
		titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
		if(titleCell !== undefined && titleCell.v ==="Minimum Headloss per KM" 
			 && valueCell !== undefined)
		{
			w2ui.generalform.record['min_hl_perkm'] = valueCell.v;
		}			
		else
		{
			errormessages += "No minHeadLossPerKM present in the input file.<br>";
		}
		
		row++;
		titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
		if(titleCell !== undefined && titleCell.v ==="Maximum Headloss per KM" 
			 && valueCell !== undefined)
		{
			w2ui.generalform.record['max_hl_perkm'] = valueCell.v;
		}			
		else
		{
			errormessages += "No maxHeadLossPerKM present in the input file.<br>";
		}
		
		row++;
		titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
		if(titleCell !== undefined && titleCell.v ==="Maximum Water Speed")
		{
			if(valueCell !== undefined)
				w2ui.generalform.record['max_water_speed'] = valueCell.v;
		}			
		else
		{
			row--; // this entry was not added so revert to previous row
		}
		
		row++;
		titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
		if(titleCell !== undefined && titleCell.v ==="Maximum Pipe Pressure")
		{
			if(valueCell !== undefined)
				w2ui.generalform.record['max_pipe_pressure'] = valueCell.v;
		}			
		else
		{
			row--; // this entry was not added so revert to previous row
		}
		
		row++;
		titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
		if(titleCell !== undefined && titleCell.v ==="Number of Supply Hours" 
			 && valueCell !== undefined)
		{
			w2ui.generalform.record['supply_hours'] = valueCell.v;
		}			
		else
		{
			w2ui.generalform.record['supply_hours'] = 24;
		}
                
		row++;
		titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
		if(titleCell !== undefined && titleCell.v ==="Source Node ID" 
			 && valueCell !== undefined)
		{
			w2ui.generalform.record['source_nodeid'] = valueCell.v;
		}			
		else
		{
			errormessages += "No source node id present in the input file.<br>";
		}
		
		row++;
		titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
		if(titleCell !== undefined && titleCell.v ==="Source Node Name" 
			 && valueCell !== undefined)
		{
			w2ui.generalform.record['source_nodename'] = valueCell.v;
		}			
		else
		{
			errormessages += "No source name present in the input file.<br>";
		}
		
		row++;
		titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
		if(titleCell !== undefined && titleCell.v ==="Source Elevation" 
			 && valueCell !== undefined)
		{
			w2ui.generalform.record['source_elevation'] = valueCell.v;
		}			
		else
		{
			errormessages += "No source elevation present in the input file.<br>";
		}
		
		row++;
		titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
		if(titleCell !== undefined && titleCell.v ==="Source Head" 
			 && valueCell !== undefined)
		{
			w2ui.generalform.record['source_head'] = valueCell.v;
		}			
		else
		{
			errormessages += "No source head present in the input file.<br>";
		}
        
		// now read rows
		while(row<lastRow)
		{
			row++;
			
			cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			if(cell !== undefined && cell.v.trim()==="NODE DATA")
			{
				break;
			}
		}		
		
		if(cell !== undefined && cell.v.trim()==="NODE DATA")
		{	
			row++; // node title row
			
			var nodeIDCell;
			var nodeNameCell;
			var elevationCell;
			var demandCell;
			var resPressureCell;
			
			var nodeID;
			var nodeName;
			var elevation;
			var demand;
			var resPressure;
			
			while(row<lastRow)
			{
				row++;
							
				nodeIDCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
				nodeNameCell = generalSheet[XLSX.utils.encode_cell({c:1, r: row})];	
				elevationCell = generalSheet[XLSX.utils.encode_cell({c:2, r: row})];
				demandCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
				resPressureCell = generalSheet[XLSX.utils.encode_cell({c:4, r: row})];
				
				if(nodeIDCell===undefined){
					break;
				}
				
				nodeID = nodeIDCell.v;
				nodeName = nodeNameCell? nodeNameCell.v : null;
				demand = demandCell ? demandCell.v : null;
				elevation = elevationCell ? elevationCell.v : null;
				resPressure = resPressureCell ? resPressureCell.v : null;
				
				var newrecid = getNewRecid(w2ui.nodegrid);
				var record = {
                		recid: newrecid,
                		nodeid: nodeID,
                		nodename : nodeName,
                		elevation: elevation,
                		demand: demand,
                		minpressure: resPressure
                		};
            	
                w2ui.nodegrid.add(record);
			}
		}
		else
		{
			errormessages += "No Nodes present in the input file.<br>";
			throw "";
		}
		
		while(row < lastRow) {
			cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			if(cell !== undefined && cell.v.trim().length!==0){
				break;
			}
			row++;
		}
		
		cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		if(cell !== undefined && cell.v.trim()==="PIPE DATA")
		{	
			row++; // pipe title row
			
			var pipeIDCell;
			var startNodeCell;
			var endNodeCell;
			var lengthCell;
			var diameterCell;
			var roughnessCell;
			var parallelAllowedCell;
			
			var pipeID;
			var startNodeID;
			var endNodeID;
			var length;
			var diameter;
			var roughness;
			var parallelAllowed;
			
			while(row<lastRow)
			{
				row++;
							
				pipeIDCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
				startNodeCell = generalSheet[XLSX.utils.encode_cell({c:1, r: row})];
				endNodeCell = generalSheet[XLSX.utils.encode_cell({c:2, r: row})];
				lengthCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
				diameterCell = generalSheet[XLSX.utils.encode_cell({c:4, r: row})];
				roughnessCell = generalSheet[XLSX.utils.encode_cell({c:5, r: row})];
				parallelAllowedCell = generalSheet[XLSX.utils.encode_cell({c:6, r: row})];
				
				if(pipeIDCell===undefined)
				{
					break;
				}
				
				pipeID = pipeIDCell.v;
				startNodeID = startNodeCell ? startNodeCell.v : null;
				endNodeID = endNodeCell ? endNodeCell.v : null;
				length = lengthCell ? lengthCell.v : null;
				diameter = diameterCell ? diameterCell.v : null;
				roughness = roughnessCell ? roughnessCell.v : null;
				parallelAllowed = parallelAllowedCell ? parallelAllowedCell.v : null;
				
				var newrecid = getNewRecid(w2ui.pipegrid);
                var record = {
                		recid: newrecid,
                		pipeid: pipeID,
                		diameter: diameter,
                		roughness: roughness,
                		length: length,
                		startnode: startNodeID,
                		endnode: endNodeID,
                		parallelallowed: parallelAllowed
                		};
            	
                w2ui.pipegrid.add(record); 
			}
		}
		else
		{
			errormessages += "No Pipes present in the input file.<br>";
			throw "";
		}
		
		while(row < lastRow) {
			cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			if(cell !== undefined && cell.v.trim().length!==0){
				break;
			}
			row++;
		}
		
		cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		if(cell !== undefined && cell.v.trim()==="COMMERCIAL PIPE DATA")
		{	
			row++; // commercial pipe title row
			
			var diameterCell;
			var roughnessCell;
			var costCell;
						
			var diameter;
			var roughness;
			var cost;
						
			while(row<lastRow)
			{
				row++;
							
				diameterCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
				roughnessCell = generalSheet[XLSX.utils.encode_cell({c:1, r: row})];
				costCell = generalSheet[XLSX.utils.encode_cell({c:2, r: row})];
					
				if(diameterCell===undefined)
				{
					break;
				}
							
				diameter = diameterCell ? diameterCell.v : null;
				roughness = roughnessCell ? roughnessCell.v : null;
				cost = costCell ? costCell.v : null;
				
				var newrecid = getNewRecid(w2ui.commercialpipegrid);
				var record = {
						recid: newrecid,
                		diameter: diameter,
                		roughness: roughness,
                		cost: cost
                		};
            	
                w2ui.commercialpipegrid.add(record);
			}
		}
		else
		{
			errormessages += "No pipecosts present in the input file.<br>";
			throw "";
		}
        
		while(row < lastRow) {
			cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			if(cell !== undefined && cell.v.trim().length!==0){
				break;
			}
			row++;
		}
		
		cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		if(cell !== undefined && cell.v.trim()==="ESR GENERAL DATA"){
			
			row++;
			titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
			if(titleCell !== undefined && titleCell.v ==="ESR Enabled" 
				 && valueCell !== undefined)
			{
				var esrenabled = (valueCell.v).toString();
	        	if(esrenabled.toLowerCase()=="true"){
	        		w2ui.esrtopform.record['enable_esr'] = true;
	        	}
			}			
			else
			{
				errormessages += "No ESR Enabled setting present in the input file.<br>";
			}
				
			row++;
			titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
			if(titleCell !== undefined && titleCell.v ==="Secondary Supply Hours" 
				 && valueCell !== undefined)
			{
				var secondarysupplyhours = parseFloat(valueCell.v);
	        	if(secondarysupplyhours>0)
	        		w2ui.esrmainform.record['secondary_supply_hours'] = secondarysupplyhours;
			}			
			else
			{
				errormessages += "No Secondary Supply Hours present in the input file.<br>";
			}
			
			row++;
			titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
			if(titleCell !== undefined && titleCell.v ==="ESR Capacity Factor" 
				 && valueCell !== undefined)
			{
				var esrcapacityfactor = parseFloat(valueCell.v);
	        	if(esrcapacityfactor>0)
	        		w2ui.esrmainform.record['esr_capacity_factor'] = esrcapacityfactor;
			}			
			else
			{
				errormessages += "No ESR capacity factor present in the input file.<br>";
			}
			
			row++;
			titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
			if(titleCell !== undefined && titleCell.v ==="Maximum ESR Height" 
				 && valueCell !== undefined)
			{
				var maxesrheight = parseFloat(valueCell.v);
	        	if(maxesrheight>0)
	        		w2ui.esrmainform.record['max_esr_height'] = maxesrheight;
			}			
			else
			{
				errormessages += "No Maximum ESR height present in the input file.<br>";
			}
			
			row++;
			titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
			if(titleCell !== undefined && titleCell.v ==="Allow ESRs at zero demand nodes" 
				 && valueCell !== undefined)
			{
				var allowdummy = (valueCell.v).toString();
	        	if(allowdummy.toLowerCase()=="true")
	        		w2ui.esrmainform.record['allow_dummy'] = true;			
	        }			
			else
			{
				errormessages += "No Allow ESRs at zero demand nodes setting present in the input file.<br>";
			}
			
			row++;
			titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
			if(titleCell !== undefined && titleCell.v ==="Nodes that must have ESRs" 
				 && valueCell !== undefined)
			{
				var mustesr = valueCell.v.split(";");
				
				w2ui.esrmainform.record["must_esr"] = [];
	        	$.each (mustesr, function(key, val){ 
	            	
	        		var nodeid = parseInt(val);
	                
	        		$.each(w2ui.nodegrid.records, function(index,value){
	        			var id = value['nodeid'];
	        			if(id==nodeid){
		        			var nodename = value['nodename'];
		        			var newnode;
		        			if(nodename===undefined || nodename==="")
		        				newnode = {id:id};
		        			else
		        				newnode = {id:id, text:nodename+'('+id+')'};
		        			w2ui.esrmainform.record["must_esr"].push(newnode);
		        			return false;
	        			}
	        		});
	            });
			}			
			else
			{
				errormessages += "No Nodes that must have ESRs list present in the input file.<br>";
			}
			
			row++;
			titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
			if(titleCell !== undefined && titleCell.v ==="Nodes that must not have ESRs" 
				 && valueCell !== undefined)
			{
				var mustnotesr = valueCell.v.split(";");
				
				w2ui.esrmainform.record["must_not_esr"] = [];
	        	$.each (mustnotesr, function(key, val){ 
	            	
	        		var nodeid = parseInt(val);
	                
	        		$.each(w2ui.nodegrid.records, function(index,value){
	        			var id = value['nodeid'];
	        			if(id==nodeid){
		        			var nodename = value['nodename'];
		        			var newnode;
		        			if(nodename===undefined || nodename==="")
		        				newnode = {id:id};
		        			else
		        				newnode = {id:id, text:nodename+'('+id+')'};
		        			w2ui.esrmainform.record["must_not_esr"].push(newnode);
		        			return false;
	        			}
	        		});
	            });
			}			
			else
			{
				errormessages += "No Nodes that must not have ESRs list present in the input file.<br>";
			}
			
			row++;
			while(row < lastRow) {
				cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
				if(cell !== undefined && cell.v.trim().length!==0){
					break;
				}
				row++;
			}
			
			cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			if(cell !== undefined && cell.v.trim()==="ESR COST DATA")
			{	
				row++; // esr cost title row
				
				var mincapacityCell;
				var maxcapacityCell;
				var basecostCell;
				var unitcostCell;
							
				var mincapacity;
				var maxcapacity;
				var basecost;
				var unitcost;
							
				while(row<lastRow)
				{
					row++;
								
					mincapacityCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
					maxcapacityCell = generalSheet[XLSX.utils.encode_cell({c:1, r: row})];
					basecostCell = generalSheet[XLSX.utils.encode_cell({c:2, r: row})];
					unitcostCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
						
					if(mincapacityCell===undefined)
					{
						break;
					}
														
					mincapacity = mincapacityCell ? mincapacityCell.v : null;
					maxcapacity = maxcapacityCell ? maxcapacityCell.v : null;
					basecost = basecostCell ? basecostCell.v : null;
					unitcost = unitcostCell ? unitcostCell.v : null;
					
					var newrecid = getNewRecid(w2ui.esrmaingrid);
	                var record = {
	                		recid: newrecid,
	                		mincapacity: mincapacity,
	                		maxcapacity: maxcapacity,
	                		basecost: basecost,
	                		unitcost: unitcost
	                		};
	            	
	                w2ui.esrmaingrid.add(record);
				}
			}
			else
			{
				errormessages += "No esrcosts present in the input file.<br>";
				throw "";
			}
		}
		
		while(row < lastRow) {
			cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			if(cell !== undefined && cell.v.trim().length!==0){
				break;
			}
			row++;
		}
		
		cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		if(cell !== undefined && cell.v.trim()==="PUMP GENERAL DATA"){
			
			row++;
			titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
			if(titleCell !== undefined && titleCell.v ==="Pump Enabled" 
				 && valueCell !== undefined)
			{
				var pumpenabled = (valueCell.v).toString();
	        	if(pumpenabled.toLowerCase()=="true"){
	        		w2ui.pumptopform.record['enable_pump'] = true;
	        	}
			}			
			else
			{
				errormessages += "No Pump Enabled setting present in the input file.<br>";
			}
				
			row++;
			titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
			if(titleCell !== undefined && titleCell.v ==="Minimum Pump Size" 
				 && valueCell !== undefined)
			{
				var minpumpsize = parseFloat(valueCell.v);
	        	w2ui.pumpmainform.record['minpumpsize'] = minpumpsize;
			}			
			else
			{
				errormessages += "No Minimum Pump Size present in the input file.<br>";
			}
			
			row++;
			titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
			if(titleCell !== undefined && titleCell.v ==="Pump Efficiency" 
				 && valueCell !== undefined)
			{
				var pumpefficiency = parseFloat(valueCell.v);
	        	if(pumpefficiency>0)
	        		w2ui.pumpmainform.record['efficiency'] = pumpefficiency;
			}			
			else
			{
				errormessages += "No Pump Efficiency present in the input file.<br>";
			}
			
			row++;
			titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
			if(titleCell !== undefined && titleCell.v ==="Capital Cost per kW" 
				 && valueCell !== undefined)
			{
				var capitalcost = parseFloat(valueCell.v);
	        	w2ui.pumpmainform.record['capitalcost_per_kw'] = capitalcost;
			}			
			else
			{
				errormessages += "No Pump Capital Cost per kW present in the input file.<br>";
			}
			
			row++;
			titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
			if(titleCell !== undefined && titleCell.v ==="Energy Cost per kWh" 
				 && valueCell !== undefined)
			{
				var energycost = parseFloat(valueCell.v);
	        	w2ui.pumpmainform.record['energycost_per_kwh'] = energycost;
			}			
			else
			{
				errormessages += "No Pump Energy Cost per kWh present in the input file.<br>";
			}
			
			row++;
			titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
			if(titleCell !== undefined && titleCell.v ==="Design Lifetime" 
				 && valueCell !== undefined)
			{
				var designlifetime = parseFloat(valueCell.v);
				if(designlifetime>0)
					w2ui.pumpmainform.record['design_lifetime'] = designlifetime;
			}			
			else
			{
				errormessages += "No Pump Design Lifetime present in the input file.<br>";
			}
			
			row++;
			titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
			if(titleCell !== undefined && titleCell.v ==="Discount Rate" 
				 && valueCell !== undefined)
			{
				var discountrate = parseFloat(valueCell.v);
				w2ui.pumpmainform.record['discount_rate'] = discountrate;
			}			
			else
			{
				errormessages += "No Discount Rate present in the input file.<br>";
			}
			
			row++;
			titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
			if(titleCell !== undefined && titleCell.v ==="Inflation Rate" 
				 && valueCell !== undefined)
			{
				var inflationrate = parseFloat(valueCell.v);
				w2ui.pumpmainform.record['inflation_rate'] = inflationrate;
			}			
			else
			{
				errormessages += "No Inflation Rate present in the input file.<br>";
			}
					
			row++;
			titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			valueCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
			if(titleCell !== undefined && titleCell.v ==="Pipes that must not have Pumps" 
				 && valueCell !== undefined)
			{
				var mustnotpump = valueCell.v.split(";");
				
				w2ui.pumpmainform.record["must_not_pump"] = [];
	        	$.each (mustnotpump, function(key, val){ 
	            	
	        		var pipeid = parseInt(val);
	                
	        		$.each(w2ui.pipegrid.records, function(index,value){
	        			var id = value['pipeid'];
	        			if(id==pipeid){
		        			var newpipe = {id:id};
		        			w2ui.pumpmainform.record["must_not_pump"].push(newpipe);
		        			return false;
	        			}
	        		});
	            });
			}			
			else
			{
				errormessages += "No Pipes that must not have Pumps list present in the input file.<br>";
			}
			
			row++;
			while(row < lastRow) {
				cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
				if(cell !== undefined && cell.v.trim().length!==0){
					break;
				}
				row++;
			}
			
			cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			if(cell !== undefined && cell.v.trim()==="MANUAL PUMPS DATA")
			{	
				row++; // manual pump data title row
				
				var pipeidCell;
				var pumppowerCell;
							
				var pipeid;
				var pumppower;
							
				while(row<lastRow)
				{
					row++;
								
					pipeidCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
					pumppowerCell = generalSheet[XLSX.utils.encode_cell({c:1, r: row})];
						
					if(pipeidCell===undefined)
					{
						break;
					}
										
					pipeid = pipeidCell ? pipeidCell.v : null;
					pumppower = pumppowerCell ? pumppowerCell.v : null;
										
					var newrecid = getNewRecid(w2ui.pumpmaingrid);
	                var record = {
	                		recid: newrecid,
	                		pipeid: pipeid,
	                		pumppower: pumppower
	                		};
	            	
	                w2ui.pumpmaingrid.add(record);
				}
			}
			else
			{
				errormessages += "No manual pumps present in the input file.<br>";
			}			
		}
		
		while(row < lastRow) {
			cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			if(cell !== undefined && cell.v.trim().length!==0){
				break;
			}
			row++;
		}
		
		cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		if(cell !== undefined && cell.v.trim()==="VALVES DATA")
		{	
			row++; // manual pump data title row
			
			var pipeidCell;
			var valvesettingCell;
						
			var pipeid;
			var valvesetting;
						
			while(row<lastRow)
			{
				row++;
							
				pipeidCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
				valvesettingCell = generalSheet[XLSX.utils.encode_cell({c:1, r: row})];
					
				if(pipeidCell===undefined)
				{
					break;
				}
									
				pipeid = pipeidCell ? pipeidCell.v : null;
				valvesetting = valvesettingCell ? valvesettingCell.v : null;
									
				var newrecid = getNewRecid(w2ui.valvegrid);
                var record = {
                		recid: newrecid,
                		pipeid: pipeid,
                		valvesetting: valvesetting
                		};
            	
                w2ui.valvegrid.add(record);
			}
		}
		
		while(row < lastRow) {
			cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			if(cell !== undefined && cell.v.trim().length!==0){
				break;
			}
			row++;
		}
		
		var sourcenode;
		titleCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
		valueCell = generalSheet[XLSX.utils.encode_cell({c:1, r: row})];
		if(titleCell !== undefined && titleCell.v ==="Map Source Node" 
			 && valueCell !== undefined)
		{
			sourcenode = valueCell.v;
		
			row++;
		
	        cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			if(cell !== undefined && cell.v.trim()==="MAP NODE DATA")
			{							
				row++; // map node title row
							
				var nodenameCell;
				var nodeidCell;
				var latitudeCell;
				var longitudeCell;
				var isesrCell;
							
				var nodename;
				var nodeid;
				var latitude;
				var longitude;
				var isesr;
							
				while(row<lastRow)
				{
					row++;
								
					nodenameCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
					nodeidCell = generalSheet[XLSX.utils.encode_cell({c:1, r: row})];
					latitudeCell = generalSheet[XLSX.utils.encode_cell({c:2, r: row})];
					longitudeCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
					isesrCell = generalSheet[XLSX.utils.encode_cell({c:4, r: row})];
						
					if(nodenameCell===undefined)
					{
						break;
					}
								
					nodename = nodenameCell ? nodenameCell.v : null;
					nodeid = nodeidCell ? nodeidCell.v : null;
					latitude = latitudeCell ? latitudeCell.v : null;
					longitude = longitudeCell ? longitudeCell.v : null;
					isesr = isesrCell ? (isesrCell.v).toString() : "false";
					
					var position = new google.maps.LatLng(latitude,longitude);
	        		var marker = addMarker(position, false, nodeid, nodename);
	        		
	        		if(sourcenode===nodeid) {
	        			setSource(marker);
	        		}
	        		else if(isesr.toLowerCase()=="true"){
	        			marker.isesr = true;
	        			marker.setIcon(esrIcon);
	        		}
				}
			}
			else
			{
				errormessages += "No map nodes present in the input file.<br>";
			}
			
			while(row < lastRow) {
				cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
				if(cell !== undefined && cell.v.trim().length!==0){
					break;
				}
				row++;
			}
	        
			cell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
			if(cell !== undefined && cell.v.trim()==="MAP PIPE DATA")
			{	
				row++; // map pipe title row
				
				var originidCell;
				var destinationidCell;
				var lengthCell;
				var encodedpathCell;
							
				var originid;
				var destinationid;
				var length;
				var encodedpath;
							
				while(row<lastRow)
				{
					row++;
								
					originidCell = generalSheet[XLSX.utils.encode_cell({c:0, r: row})];
					destinationidCell = generalSheet[XLSX.utils.encode_cell({c:1, r: row})];
					lengthCell = generalSheet[XLSX.utils.encode_cell({c:2, r: row})];
					encodedpathCell = generalSheet[XLSX.utils.encode_cell({c:3, r: row})];
									
					originid = originidCell ? originidCell.v : null;
					destinationid = destinationidCell ? destinationidCell.v : null;
					length = lengthCell ? lengthCell.v : null;
					encodedpath = encodedpathCell ? encodedpathCell.v : null;
					
					var path = google.maps.geometry.encoding.decodePath(encodedpath);
	        		var origin = findNode(originid);
	       			var destination = findNode(destinationid);
	       			if(origin===null) {
	       				errormessages += "Could not find origin node "+ originid +" for pipe.<br>";
	       			}
	       			else if(destination===null) {
	       				errormessages += "Could not find destination node "+ destinationid +" for pipe.<br>";
	       			}
	       			else {
	       				addPath(path, origin, destination, false);
	       			}
				}
			}
			else
			{
				errormessages += "No map pipes present in the input file.<br>";
			}
		}
               
        elevationChartChanged();
       
    }	
	catch(err)
	{
		console.log(err);
		errormessages += err+"<br>";
	}
	finally {
		if(errormessages!="")
			w2alert(errormessages);
		w2ui.generalform.refresh();
		w2ui.sidebar.click('general');
	}
}

//upload branch input file
//fill the input tabs with the data
//report any errors/mssing data
function uploadBranchFile(branchFileString)
{
	resetInput();

	var errormessages = "";
	
/////Branch File Format
	//Project Title
	//User Name
	//number of pipes : number of commercial pipes : peak factor : min headloss : max headloss : min resdiual pressure : type of formula(1 for hazen 2 for darcy)
	//unit (mostly 1 for SI : 2 for fps )
	//"Pipe Data"
	//rows of pipe data: pipeid : startnode : endnode : length : diameter : roughness
	//"Node Data"
	//rows of node data: nodeid : peak factor : flow : elevation : residual pressure
	//"Reference Node"
	//source nodeid : source head
	//"Pipes 'C' Value & Cost Data"
	//rows of commercial pipe data : diameter : roughness : cost
	// "0 0 0"
	
	try
	{
		var lines = branchFileString.match(/[^\r\n]+/g);
		var linenumber = 0;
		
		var nameOfProject = lines[linenumber].trim();  //title line 
		linenumber++;
       	w2ui.generalform.record['name_project'] = nameOfProject;
	    
		linenumber++;   //username line
	    
		var constantsLine = lines[linenumber].trim();
		linenumber++;
	    var constants = constantsLine.split(/\s+/); //constants
	    var minResidualPressure = constants[5];
	    var numberOfPipes = parseInt(constants[0]);
	    var numberOfCommercialPipes = parseInt(constants[1]);
	    var peakFactor = constants[2];
	    var minHeadLossPerKM = constants[3];
	    var maxHeadLossPerKM = constants[4];
	    linenumber++; // other constants
	    
	    w2ui.generalform.record['min_node_pressure'] = minResidualPressure;
	    w2ui.generalform.record['supply_hours'] = 24/parseFloat(peakFactor);
	    //w2ui.generalform.record['def_pipe_roughness'] = defaultroughness;
    	w2ui.generalform.record['min_hl_perkm'] = minHeadLossPerKM;
    	w2ui.generalform.record['max_hl_perkm'] = maxHeadLossPerKM;
    	
	    var pipeDataString = lines[linenumber].trim(); //"Pipe Data" String
	    linenumber++;
	    if(pipeDataString !== "Pipe Data")
	    {	
	    	errormessages += "Pipe Data not found in Branch Input File";
	    	throw "";
	    }
	    
	    var pipeStrings = [];
	    var nodeStrings = [];
	    var commercialPipeStrings = [];
	           
	    while(linenumber < lines.length)
	    {
	    	var line = lines[linenumber].trim(); // pipe information
	    	linenumber++;
	    	if(line === "Node Data")
	    	{
	    		break;
	    	}
	    	pipeStrings.push(line);
	    }
	    if(pipeStrings.length!=numberOfPipes)
	    {
	    	errormessages += "Incorrect number of pipes provided";
	    	throw "";
	    }
	    
	    while(linenumber < lines.length)
	    {
	    	var line = lines[linenumber].trim(); // node information
	    	linenumber++;
	    	if(line === "Reference Node")
	    	{
	    		break;
	    	}
	    	nodeStrings.push(line);
	    }
	    if(nodeStrings.length!=numberOfPipes+1)
	    {
	    	errormessages += "Incorrect number of nodes provided";
	    	throw "";
	    }
	    	    
	    var sourceStrings =  lines[linenumber].trim().split(/\s+/); // source information
	    linenumber++;
	    var sourceNodeID = sourceStrings[0];
	    w2ui.generalform.record['source_nodeid'] = sourceNodeID;
	    w2ui.generalform.record['source_nodename'] = "Node"+sourceNodeID;    	
	    w2ui.generalform.record['source_head'] = sourceStrings[1];
	           
	    var commericalPipeDataString = lines[linenumber].trim(); //"Pipes 'C' Value & Cost Data" String
	    linenumber++;
	    if(commericalPipeDataString !== "Pipes 'C' Value & Cost Data")
    	{
	    	errormessages += "Commerical Pipe Data not found in Branch Input File";
	    	throw "";
    	}
	    
	    while(linenumber < lines.length)
	    {
	    	var line = lines[linenumber].trim();  // commercial pipe information
	    	linenumber++;
	    	if(commercialPipeStrings.length==numberOfCommercialPipes) // BRANCH EOF indicator
	    		break;
	    	commercialPipeStrings.push(line);
	    }
	    
	    $.each (nodeStrings, function(key, nodeString){ 
        	var nodeProperties = nodeString.split(/\s+/); // nodeid : peak factor : demand : elevation : residual pressure
            var demand = nodeProperties[2];
            if(demand.startsWith("-"))
            {	
            	demand = demand.substring(1);
            }
            var nodeID = nodeProperties[0];
            var residualPressure = nodeProperties[4];
            var elevation = nodeProperties[3];
                        		
            if(nodeID===sourceNodeID)
            {
            	w2ui.generalform.record['source_elevation'] = elevation;
        	}
            else
            {
            	if(parseFloat(residualPressure)===0)
                {
                	residualPressure=null;
                }
            	
            	var newrecid = getNewRecid(w2ui.nodegrid);
            	var record = {
                		recid: newrecid,
                		nodeid: nodeID,
                		nodename: 'Node'+nodeID,
                		elevation: elevation,
                		demand: demand,
                		minpressure: residualPressure
                		};
            	
                w2ui.nodegrid.add(record);
            }
        });    
            	
        $.each (pipeStrings, function(key, pipeString){  
        	var pipeProperties = pipeString.split(/\s+/); //pipeid : startnode : endnode : length : diameter : roughness
        	
            var pipeID = pipeProperties[0];
            var startNode = pipeProperties[1];
            var endNode = pipeProperties[2];
            var length = pipeProperties[3];
            var diameter = pipeProperties[4];
            var roughness = pipeProperties[5];
            var parallelAllowed = pipeProperties[6];
                          
            if(parallelAllowed !== "")
            {	
            	parallelAllowed = (parallelAllowed === "P");
            }
            
            if(parseFloat(roughness)===0)
            {
            	roughness=null;
            }
            if(parseFloat(diameter)===0)
            {
            	diameter=null;
            }
            
            var newrecid = getNewRecid(w2ui.pipegrid);
            var record = {
            		recid: newrecid,
            		pipeid: pipeID,
            		diameter: diameter,
            		roughness: roughness,
            		length: length,
            		startnode: startNode,
            		endnode: endNode,
            		parallelallowed: parallelAllowed
            		};      	
            w2ui.pipegrid.add(record);
        });
        
        $.each (commercialPipeStrings, function(key, commericalPipeString){
			var commericalPipeProperties = commericalPipeString.split(/\s+/); //diameter roughness cost
        	
            var diameter = commericalPipeProperties[0];
            var cost = commericalPipeProperties[2];
                       
            w2ui.generalform.record['def_pipe_roughness'] = commericalPipeProperties[1];
            var newrecid = getNewRecid(w2ui.commercialpipegrid);
            var record = {
            		recid: newrecid,
            		diameter: diameter,
            		cost: cost
            		};
            w2ui.commercialpipegrid.add(record);
        }); 
    }	
	catch(err)
	{
		console.log(err);
		errormessages += err+"<br>";
	}
	finally
	{
		if(errormessages!="")
			w2alert(errormessages);
		w2ui.generalform.refresh();
		w2ui.sidebar.click('general');
	}
}

//get list of nodeids from the node table
function getNodeIds(){
	var nodes_list = []
	$.each(w2ui.nodegrid.records, function(index,value){
		var id = value['nodeid'];
		var nodename = value['nodename'];
		var newnode;
		if(nodename===undefined || nodename==="")
			newnode = {id:id};
		else
			newnode = {id:id, text:nodename+'('+id+')'};
		nodes_list.push(newnode);
	});
	return nodes_list;
}

//get list of pipeids from the pipe table
function getPipeIds(){
	var pipes_list = []
	$.each(w2ui.pipegrid.records, function(index,value){
		var id = value['pipeid'];
		pipes_list.push({id:id});
	});
	return pipes_list;
}

//get the next unique id for a table
function getNewRecid(grid, field, notAllowedIDs){
	if(!field)
		field = 'recid';
	if (!$.isArray(notAllowedIDs)) notAllowedIDs = [notAllowedIDs];
	$.each(grid.records, function(index,value)
				{
		notAllowedIDs.push(parseInt(value[field]));
				});
	var i = 1;
	var newrecid;
	while(true)
	{
			var index = $.inArray(i, notAllowedIDs);
			if(index==-1)
			{
				newrecid = i;
				break;
			}
			else
				i++;
	}
	return i;
}

//validate data that is been entered in the input forms and tables
//report any errors or missing data
function validateData(){
	var errMsg = "";
	
	var generalErrors = w2ui.generalform.validate();
    if(generalErrors.length!=0)
    {
    	if(errMsg==="")
    	{
    		w2ui.sidebar.click('general');
    	}
    	$.each(generalErrors, function(index,value)
    			{
    				var fieldString = value.field.html.caption.slice(0,-1);
    				errMsg += "Please enter "+ fieldString + ".<br>";
    			});
    }
    
	if(w2ui.nodegrid.records==null || w2ui.nodegrid.records.length==0)
	{
		if(errMsg==="")
		{
			w2ui.sidebar.click('nodes');
		}
		errMsg += "Please enter node data.<br>";
	}
	else
	{
		$.each(w2ui.nodegrid.records, function(index,value)
				{
					if(value['elevation']==null || value['elevation'].length==0)
					{
						if(errMsg==="")
						{
							w2ui.sidebar.click('nodes');
						}
						errMsg += "Please enter elevation details.<br>";
						return false;
					}
				});
	}
    
    if(w2ui.pipegrid.records==null || w2ui.pipegrid.records.length==0)
    {
    	if(errMsg==="")
    	{
    		w2ui.sidebar.click('pipes');
    	}
    	errMsg += "Please enter pipe data.<br>";    
    }
    if(w2ui.commercialpipegrid.records==null || w2ui.commercialpipegrid.records.length==0)
    {
    	if(errMsg==="")
    	{
    		w2ui.sidebar.click('commercialpipes');
    	}
    	errMsg += "Please enter commercial pipe data.<br>";
    }
    
    if(w2ui.esrtopform.record['enable_esr'] == true){
    	if(w2ui.esrmainform.record['secondary_supply_hours']===undefined ||
    			w2ui.esrmainform.record['secondary_supply_hours']===""){
    		if(errMsg===""){
	    		w2ui.sidebar.click('esr');
	    	}
	    	errMsg += "Please enter the Secondary Network Supply Hours.<br>";
    	}
    	if(w2ui.esrmainform.record['esr_capacity_factor']===undefined ||
    			w2ui.esrmainform.record['esr_capacity_factor']===""){
    		if(errMsg===""){
	    		w2ui.sidebar.click('esr');
	    	}
	    	errMsg += "Please enter the ESR Capacity Factor.<br>";
    	}
    	    	
    	var esrmustnodes = w2ui.esrmainform.record['must_esr'];
    	var esrmustnotnodes = w2ui.esrmainform.record['must_not_esr'];
    	var nodes_list = getNodeIds();
    	if(esrmustnodes!==undefined){
	    	$.each (esrmustnodes, function(key, val){
	    		var index = -1;
	    		$.each (nodes_list, function(key2, val2){
					if(val2.id===val.id)
						index=key2;
	    		});
	    		if(index===-1){
	    			if(errMsg===""){
	    	    		w2ui.sidebar.click('esr');
	    	    	}
	    	    	errMsg += "Node "+val.id+" in 'must have esr' list does not occur in the list of nodes in the nodes tab.<br>";
	    		}
	    	});
    	}
    	
    	if(esrmustnotnodes!==undefined){
	    	$.each (esrmustnotnodes, function(key, val){
	    		var index = -1;
	    		$.each (nodes_list, function(key2, val2){
					if(val2.id===val.id)
						index=key2;
	    		});
	    		if(index===-1){
	    			if(errMsg==="")
	    	    	{
	    	    		w2ui.sidebar.click('esr');
	    	    	}
	    	    	errMsg += "Node "+val.id+" in 'must not have esr' list does not occur in the list of nodes in the nodes tab.<br>";
	    		}
	    	});
    	}
    	if(esrmustnodes!==undefined && esrmustnotnodes!==undefined){
	    	$.each (esrmustnodes, function(key, val){
	    		var index = -1;
	    		$.each (esrmustnotnodes, function(key2, val2){
					if(val2.id===val.id)
						index=key2;
	    		});
	    		if(index>-1){
	    			if(errMsg==="")
	    	    	{
	    	    		w2ui.sidebar.click('esr');
	    	    	}
	    	    	errMsg += "Node "+val.id+" cannot occur in both 'must have esr' and 'must not have esr' lists.<br>";
	    		}
	    	});
    	}
    	
    	if(w2ui.esrmaingrid.records==null || w2ui.esrmaingrid.records.length==0){
        	if(errMsg===""){
        		w2ui.sidebar.click('esr');
        		w2ui.esrlayout_main_tabs.click('tabcosts');
        	}
        	errMsg += "Please enter esr cost data.<br>";
        }
    }
    
    if(w2ui.pumptopform.record['enable_pump'] == true){
    	if(w2ui.pumpmainform.record['minpumpsize']===undefined ||
    			w2ui.pumpmainform.record['minpumpsize']===""){
    		if(errMsg===""){
	    		w2ui.sidebar.click('pump');
	    	}
	    	errMsg += "Please enter the minimum Pump Size.<br>";
    	}
    	if(w2ui.pumpmainform.record['efficiency']===undefined ||
    			w2ui.pumpmainform.record['efficiency']===""){
    		if(errMsg===""){
	    		w2ui.sidebar.click('pump');
	    	}
	    	errMsg += "Please enter the Pump Efficiency.<br>";
    	}
    	if(w2ui.pumpmainform.record['capitalcost_per_kw']===undefined ||
    			w2ui.pumpmainform.record['capitalcost_per_kw']===""){
    		if(errMsg===""){
	    		w2ui.sidebar.click('pump');
	    	}
	    	errMsg += "Please enter the Pump Capital Cost per kW.<br>";
    	}
    	if(w2ui.pumpmainform.record['energycost_per_kwh']===undefined ||
    			w2ui.pumpmainform.record['energycost_per_kwh']===""){
    		if(errMsg===""){
	    		w2ui.sidebar.click('pump');
	    	}
	    	errMsg += "Please enter the Pump Energy Cost per kWh.<br>";
    	}
    	if(w2ui.pumpmainform.record['design_lifetime']===undefined ||
    			w2ui.pumpmainform.record['design_lifetime']===""){
    		if(errMsg===""){
	    		w2ui.sidebar.click('pump');
	    	}
	    	errMsg += "Please enter the Pump Design Lifetime.<br>";
    	}
    	    	    	
    	var pumpmustnotnodes = w2ui.pumpmainform.record['must_not_pump'];
    	var pipes_list = getPipeIds();
    	    	
    	if(pumpmustnotnodes!==undefined){
	    	$.each (pumpmustnotnodes, function(key, val){
	    		var index = -1;
	    		$.each (pipes_list, function(key2, val2){
					if(val2.id===val.id)
						index=key2;
	    		});
	    		if(index===-1){
	    			if(errMsg==="")
	    	    	{
	    	    		w2ui.sidebar.click('pump');
	    	    	}
	    	    	errMsg += "Pipe "+val.id+" in 'must not have pump' list does not occur in the list of pipes in the pipes tab.<br>";
	    		}
	    	});
    	}
    }
    
	if(errMsg.length==0)
    	return true;
	else
	{
		w2alert(errMsg);
		return false;
	}
}

//confim that existing node/pipe data will be overwritten when importing from map tab
function exportToFormConfirm(){
	w2confirm('Existing Node and Pipe data will be overwritten. Continue?')
	.yes(exportToForm);
}

//export data from the map to input forms/tables
function exportToForm(){
	var errormessages = "";
	
	w2ui.nodegrid.clear();
    w2ui.pipegrid.clear();
    w2ui.esrmainform.record["must_esr"] = [];
    
	if (nodes && nodes.length > 0) 
    {        	
    	$.each (nodes, function(key, val){
    	    var nodeid = val.nodeID;
            var elevation = Math.round(val.elevation);
            var nodename = val.getTitle();
           
            if(val === sourceMarker) {           		
            	w2ui.generalform.record['source_nodeid'] = nodeid;
            	w2ui.generalform.record['source_elevation'] = elevation;
            	w2ui.generalform.record['source_nodename'] = nodename;
            }
            else {
	            var newrecid = getNewRecid(w2ui.nodegrid);
	            if(!nodeid) {
	           		nodeid = getNewRecid(w2ui.nodegrid, nodeid, w2ui.generalform.record['source_nodeid']);
	           	}
	            var record = {
	            		recid: newrecid,
	            		nodeid: nodeid,
	            		nodename: nodename,
	            		elevation: elevation,
	            		};
	        	
	            w2ui.nodegrid.add(record);
	            
	            if(val.isesr){
	    			var newnode;
	    			if(nodename===undefined || nodename==="")
	    				newnode = {id:nodeid};
	    			else
	    				newnode = {id:nodeid, text:nodename+'('+nodeid+')'};
	    			w2ui.esrmainform.record["must_esr"].push(newnode);
	    			
	    			w2ui.esrtopform.record['enable_esr'] = true;
	            }
            }
    	});
    } 
    else 
    {
    	errormessages += "No nodes present in map.<br>";
    }
    
    if (pipes && pipes.length > 0) 
    {	        	
    	$.each (pipes, function(key, val){ 
    		var pipeid;
    		var length = Math.round(val.getLength());
            var startnode = val.origin.nodeID;
            var endnode = val.destination.nodeID;
            
            var newrecid = getNewRecid(w2ui.pipegrid);
            if(!pipeid)
           	{
            	pipeid = getNewRecid(w2ui.pipegrid, pipeid);
           	}
            var record = {
            		recid: newrecid,
            		pipeid: pipeid,
            		length: length,
            		startnode: startnode,
            		endnode: endnode
            		};
        	
            w2ui.pipegrid.add(record);   
        });
    } 
    else 
    {
    	errormessages += "No pipes present in the map.<br>";
    }
    
    w2ui.sidebar.click('nodes');
    if(errormessages.length!=0)
	{
		w2alert(errormessages);
	}
}

//initialize the maps tab
function map_initialize() {
	//initalize the google map, expects a div with id 'map'
	map = new google.maps.Map(document.getElementById('map'), {
    		center: mapCenter,
    		zoom: 12,
    		streetViewControl: false,
    		});
  
	//initalizing and adding a 'add node' button
	var optionsControl1Div = document.createElement('div');
	var optionsControl1 = new OptionsControl1(optionsControl1Div, map);
	optionsControl1Div.index = 1;
  	map.controls[google.maps.ControlPosition.TOP_CENTER].push(optionsControl1Div);
  
  	//initalizing and adding a 'add pipe' button
	var optionsControl2Div = document.createElement('div');
  	var optionsControl2 = new OptionsControl2(optionsControl2Div, map);
	optionsControl2Div.index = 1;
  	map.controls[google.maps.ControlPosition.TOP_CENTER].push(optionsControl2Div);
    	
  	//add a right click context menu
  	addContextMenu();
  
  	//initialize a generic infowindow to be used later for user input
  	infoWindow = new google.maps.InfoWindow();
  	
  	//initalize a chart to display elevation profiles of paths
  	chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
  
  	//initalize google map services to get elevations and directions
  	elevationService = new google.maps.ElevationService();
  	directionsService = new google.maps.DirectionsService();
  	
  	autocomplete = new google.maps.places.Autocomplete($('#searchlocationinput')[0]);
    autocomplete.bindTo('bounds', map);
    
    placemarker = new google.maps.Marker({
      map: map,
      anchorPoint: new google.maps.Point(0, -29)
    });
    
    autocomplete.addListener('place_changed', searchPlaceChanged);
    
// directions display not being used at the moment
// user only provided a static route
// 	  	//initalise google maps direction display
// 	  	directionsDisplay = new google.maps.DirectionsRenderer({
// 			draggable: false,
// 			map: map
// 		});
  
// geolocation disabled at the moment
// location would zoom to the imported file location

  // Try HTML5 geolocation.
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      mapCenter = pos;
      map.setCenter(pos);
      getplace(pos);
    });
  }
  
  
	//add a left click event listener to the map
	google.maps.event.addListener(map, 'click', function(event) {
		//if the add node button has been clicked, add a marker at the next clicked position
		if(addNode)
		{
	    	addMarker(event.latLng);
		}
	    addNode = false;
	});
  
	//add a mouseover event listener to the elevation chart
	//hovering over the chart highlights the corresponding point on the map 
  	google.visualization.events.addListener(chart, 'onmouseover', function(e) {
		if (mousemarker === null) {
        	mousemarker = new google.maps.Marker({
          		position: elevations[Math.floor(e.row/chartPointMultiplier)].location,
          		map: map,
          		icon: "http://maps.google.com/mapfiles/ms/icons/green-dot.png"
        	});
      	} 
		else {
        	mousemarker.setPosition(elevations[Math.floor(e.row/chartPointMultiplier)].location);
      	}
	});
	
  	$("#chart_div").mouseleave(clearMouseMarker);
  
  	//parse kml file
  	//var myParser = new geoXML3.parser({map: map});
  	//myParser.parse('doc.kml');
  	
	//some default nodes and pipes
	//var pos1 = new google.maps.LatLng(20.018193871478147,73.32412719726562);
	//var pos2 = new google.maps.LatLng(20.005491749276022,73.37047576904297);
	//var pos3 = new google.maps.LatLng(20.01690354396404,73.40961456298828);
  	  
	//var mar1 = addMarker(pos1,false);
	//var mar2 = addMarker(pos2,false);
	//var mar3 = addMarker(pos3,false);
  
	//addRoute(mar1, mar2);
	//addRoute(mar2, mar3);	
}

function useTheData(doc){
	map.fitbounds(doc[0].bounds);
}

function searchPlaceChanged(){
	infoWindow.close();
	placemarker.setVisible(false);
    var place = autocomplete.getPlace();
    var position;
    if (!place) {
      return;
    }
    else if(!place.geometry) {
    	//regex to match latlong string (lat long seperated by whitespace and/or one comma)
    	var regex = /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?)\s*(,|\s)\s*[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$/g;
    	var result = place.name.match(regex);
    	
    	if(result===null || result.length == 0) {
   			return;
   		}
    	var latlngString = result[0];
    	var commaIndex = latlngString.indexOf(',');
    	var splitStrings;
    	
    	if(commaIndex==-1) {
    		splitStrings = latlngString.split(/\s+/g);
    	}
    	else {
    		splitStrings = latlngString.split(',');
    	}
    		
    	if(!splitStrings || splitStrings.length !=2) {
    		return;
    	}
    		
    	var lat = splitStrings[0].trim();
    	var lng = splitStrings[1].trim();
    	position = new google.maps.LatLng(lat,lng);
    }
    else{
    	position = place.geometry.location;
    }
    autocomplete.position = position;

    map.setCenter(position);
    map.setZoom(12); 

    var icon = place.icon ? place.icon : "http://maps.google.com/mapfiles/marker.png";
//    placemarker.setIcon(/** @type {google.maps.Icon} */({
//       url: place.icon,
//       size: new google.maps.Size(71, 71),
//       origin: new google.maps.Point(0, 0),
//       anchor: new google.maps.Point(17, 34),
//       scaledSize: new google.maps.Size(35, 35)
//     }));
    placemarker.setPosition(position);
    placemarker.setVisible(true);

    var address = '';
    if (place.address_components) {
      address = [
        (place.address_components[0] && place.address_components[0].short_name || ''),
        (place.address_components[1] && place.address_components[1].short_name || ''),
        (place.address_components[2] && place.address_components[2].short_name || '')
      ].join(' ');
    }

    var text = place.name ? place.name : "";
    infoWindow.setContent('<div><strong>' + text + '</strong><br>' + address 
    		+ '<br><input type="button" onclick="addSearchNode()" value="Add node here"/>');
    infoWindow.open(map, placemarker);
}

//add a node at the location that has been searched
function addSearchNode(){
	var place = autocomplete.getPlace();
	var position = autocomplete.position;
	var name = place.name;
	if(!place.geometry) {
		name = undefined;	
	}
	addMarker(position,true,undefined,name);
	$('#searchlocationinput')[0].value = "";
	autocomplete.set('place',void(0));
}

function searchtyped(e){
	var code = (e.keyCode ? e.keyCode : e.which);
	if(code == 27) // esc key was pressed
	{
		e.currentTarget.value = "";
		autocomplete.set('place',void(0));
	}
}

//take a snapshot of the map and save it as an image
function takeSnapshot(){
	
	map.setOptions({
		  zoomControl: false,
		  mapTypeControl: false
		});
	
	setTimeout(function(){
		map.controls[2].b[0].style.visibility = 'hidden';
		map.controls[2].b[1].style.visibility = 'hidden';
	},100);
	
	setTimeout(function(){
		var element = $("#map");
	    html2canvas(element, {
	        useCORS: true,
	        onrendered: function(canvas) {
	        	       	
	            var dataUrl= canvas.toDataURL("image/png");

	            $('#postToIframeForm').append('<input type="hidden" name="action" />');
	        	$('#postToIframeForm').append('<input type="hidden" name="imagestring" />');
	        	
	        	$('input[name="action"]').val("saveMapSnapshot");
	        	$('input[name="imagestring"]').val(dataUrl);
	        	
	        	$('#postToIframeForm').submit().empty();
	           
	            //var w = window.open("");
	        	//w.document.write('<img src="' + dataUrl + '"/>');
	        	
	        	map.setOptions({
	      		  zoomControl: true,
	      		  mapTypeControl: true
	      		});
	        }
	    }); 
	},100);
	
	
}

//get place from google API based on position
function getplace(position){
	var geocoder = new google.maps.Geocoder;
	var city,state,country;
    geocoder.geocode({'location':position}, function(results,status){
  	  if (status === 'OK'){
  	      if (results.length>0){
  	    	  for(var i=0;i<results.length;i++){
	  	    	  for(var j=0;j<results[i].address_components.length;j++){
	  	    		  var comp = results[i].address_components[j];
	  	    		  if(comp.types[0]=="locality"){
	  	    			  city = comp.long_name;
	  	    			  break;
	  	    		  }
	  	    		  if(comp.types[0]=="administrative_area_level_1"){
	  	    			  state = comp.long_name;
	  	    			  break;
	  	    		  }
	  	    		  if(comp.types[0]=="country"){
	  	    			  country = comp.long_name;
	  	    			  break;
	  	    		  }
	  	    	  }
  	    	  }
  	    	  place = city?city:(state?state:(country?country:place));
  	      }
  	      else{
  	    	  console.log('No results found for geocoder');
  	      }
  	  } 
  	  else{
  		  console.log('Geocoder failed due to: ' + status);
  	  }
    });
}

</script>

<title>JalTantra</title>
</head>
<body>
	<div id="main" style="width: 100%; height: 100%;"></div>
</body>
</html>