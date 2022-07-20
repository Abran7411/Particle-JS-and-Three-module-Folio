<%-- 
    Document   : impContBillPrint
    Created on : July 20, 2022, 2:55:33 PM
    Author     : Abran
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="in.indev.common.bdo.OriginalNumToLetter"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<script src="screens/plugin_js/print-headers-and-footers.js" type="text/javascript"></script>
<script src="screens/plugin_js/qrious.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="screens/plugin_css/print-headers-and-footers.css" />
<!DOCTYPE html>
<%
    ArrayList invoicePreviewList = new ArrayList();
    ArrayList getHeaderDtl = new ArrayList();
    ArrayList storageList = new ArrayList();
    ArrayList amountDetails = new ArrayList();
    ArrayList billHistory = new ArrayList();
    String billingHistory = "", remarks = "";
    ArrayList invoiceTaxHeader = new ArrayList();
    ArrayList<Double> taxTotal = new ArrayList();
    String ou = "";
    String headerSection[] = {};
    String taxTotalPercentage = "";
    Double totalTax = 0.00, sbCess = 0.00, kkCess = 0.00;
    int taxCodeCount = 0;
    NumberFormat form = NumberFormat.getNumberInstance(new Locale("en", "IN"));
    form.setMinimumFractionDigits(2);
    form.setMaximumFractionDigits(2);
    Double totalAmtDouble = 0.00;
    String ouCompanyName = "";
    String cinNumber = "";
    String ouAddress = "", monthlySatus = "";
    String ouRegisteredAddress = "";
    String businessType = "";
    String importFclPrintType = "";
    boolean taxFlag = false;

    if (request.getAttribute("monthlyFlag") != null) {
        monthlySatus = request.getAttribute("monthlyFlag").toString();
    }
    if (request.getAttribute("importFclPrintType") != null) {
        importFclPrintType = request.getAttribute("importFclPrintType").toString();
    }
    if (request.getAttribute("invoicePreviewList") != null) {
        invoicePreviewList = (ArrayList) request.getAttribute("invoicePreviewList");
    }
    if (request.getAttribute("getHeaderDtl") != null) {
        getHeaderDtl = (ArrayList) request.getAttribute("getHeaderDtl");
    }
    if (request.getAttribute("storageList") != null) {
        storageList = (ArrayList) request.getAttribute("storageList");
    }
    if (request.getAttribute("invoiceTaxHeader") != null) {
        invoiceTaxHeader = (ArrayList) request.getAttribute("invoiceTaxHeader");
    }
    if (request.getAttribute("ou") != null) {
        ou = request.getAttribute("ou").toString();
    }
    if (request.getAttribute("billingHistory") != null) {
        billHistory = (ArrayList) request.getAttribute("billingHistory");
        ArrayList recordData = (ArrayList) billHistory.get(0);
        billingHistory = recordData.get(0).toString();
        billingHistory = billingHistory.replaceAll("#", ",");
        billingHistory = billingHistory.replaceAll("@", "-");
        remarks = recordData.get(1).toString();
    }
    if (request.getAttribute("amountDetails") != null) {
        amountDetails = (ArrayList) request.getAttribute("amountDetails");
        if (!amountDetails.isEmpty()) {
            taxTotalPercentage = amountDetails.get(0).toString();
        }
    }
    Double chargeAmount = 0.00;
    String chargeAmountInWords = "";
    String cha = "", chaDivision = "", importer = "", importerDivision = "", sliner = "", slinerDivision = "", billToCustomer = "", totalAmount = "", billToAddress = "", type = "", chaGst = "", slinerGst = "", impGst = "", otherGst = "", billToState = "", irNo = "", qrCodeDB = "", eInvApplcble = "";
    String bankName = "", accountNumber = "", ifsCode = "", bankBranch = "";
    if (request.getAttribute("headerList") != null) {
        ArrayList headerList = (ArrayList) request.getAttribute("headerList");
        ArrayList recordData = (ArrayList) headerList.get(0);
        billToCustomer = recordData.get(0).toString();
        importer = recordData.get(1).toString();
        sliner = recordData.get(2).toString();
        cha = recordData.get(3).toString();
        totalAmount = recordData.get(4).toString();
        billToAddress = recordData.get(5).toString();
        type = recordData.get(6).toString();
        chaGst = recordData.get(7).toString();
        impGst = recordData.get(8).toString();
        slinerGst = recordData.get(9).toString();
        otherGst = recordData.get(10).toString();
        billToState = recordData.get(11).toString();
        irNo = recordData.get(12).toString();
        qrCodeDB = recordData.get(13).toString();
        importerDivision = recordData.get(14).toString();
        slinerDivision = recordData.get(15).toString();
        chaDivision = recordData.get(16).toString();
        eInvApplcble = recordData.get(17).toString();
    }
    OriginalNumToLetter orNumToLetter = new OriginalNumToLetter();
//    if (totalAmount != null && !totalAmount.equals("")) {
//        chargeAmount = Double.parseDouble("" + totalAmount);
//        totalAmtDouble = chargeAmount;
//        chargeAmountInWords = orNumToLetter.numberToWord(String.format("%.2f", chargeAmount));        
//    }
%>
<html>
    <table cellpadding="0" cellspacing="0" style="height:100%;width: 99%;"> 
        <%if (monthlySatus.equals("MONTHLY")) {%>
        <tr>
            <td>
                <span style="float: right;padding-right: 5px;padding-top: 5px;cursor: pointer;"><img src="screens/images/deleteRow.png" onclick="closeWindowForFclPrintPopup()"/></span>
            </td>
        </tr>
        <% }%>
        <tr>
            <td style="padding: 5px">
                <%if (monthlySatus.equals("MONTHLY")) {%>
                <div id="popUpFclInvoicePrintOthersEcct" style="margin: 2px;width: 750px;height: 500px;overflow: auto;">
                    <%} else {%>
                    <div id="popUpFclInvoicePrintOthersEcct" style="margin: 2px;width:100%;height:100%;">
                        <% }%>
                        <div id="printContent">
                            <div id="headerGrp">
                                <table id="headerTable" style="width: 100%" cellspacing='0' cellpadding='0' style="font-size: 11px;border-collapse: collapse">
                                    <%if (monthlySatus.equals("MONTHLY")) {%>
                                    <tr><td  width='100%' ><p id="checkedGroupType" style="text-align: left;float: left"><label><input class="forType" checked='true' type="checkbox"/><span class="typeForLabel">Original for Recipient</span> </label><label><input  type="checkbox" class="forType" id="suppilerChb"/> <span class="typeForLabel" >Office Copy</span></label></p></td></tr>
                                                    <%}%>
                                                    <%String vessel = "", sbCessPercentage = "", userName = "", kkCessPercentage = "", cargo = "", igm = "", boe = "", bl = "", headerDetails = "", containerCount = "", grossWt = "", groundRenttillDate = "", serviceTaxPercentage = "", billState = "";
                                                        String panNo = "", createdBy = "", gstNo = "";
                                                        for (int i = 0; i < getHeaderDtl.size(); i++) {
                                                            ArrayList recordData = (ArrayList) getHeaderDtl.get(i);
                                                            vessel = recordData.get(3).toString();
                                                            boe = recordData.get(1).toString();
                                                            igm = recordData.get(2).toString();
                                                            bl = recordData.get(4).toString();
                                                            cargo = recordData.get(5).toString();
                                                            if (recordData.size() >= 13) {
                                                                billState = recordData.get(9).toString();
                                                                panNo = recordData.get(10).toString();
                                                                userName = recordData.get(11).toString();
                                                                gstNo = recordData.get(12).toString();
                                                                containerCount = recordData.get(6).toString();
                                                                groundRenttillDate = recordData.get(7).toString();
                                                                grossWt = recordData.get(8).toString();
                                                                bankName = recordData.size() >= 13 && recordData.get(13) != null ? recordData.get(13).toString() : "";
                                                                accountNumber = recordData.size() >= 14 && recordData.get(14) != null ? recordData.get(14).toString() : "";
                                                                ifsCode = recordData.size() >= 15 && recordData.get(15) != null ? recordData.get(15).toString() : "";
                                                                bankBranch = recordData.size() >= 16 && recordData.get(16) != null ? recordData.get(16).toString() : "";
                                                            }
                                                            headerDetails = recordData.get(0).toString();
                                                            headerSection = headerDetails.split("@@");
                                                            if (headerSection.length >= 4) {
                                                                ouCompanyName = headerSection[0].replaceAll("--", ",");;
                                                                cinNumber = headerSection[1].replaceAll("--", ",");;
                                                                ouAddress = headerSection[2].replaceAll("--", ",");;
                                                                ouRegisteredAddress = headerSection[3].replaceAll("--", ",");;
                                                                businessType = headerSection[4].replaceAll("--", ",");;
                                                            }%>
                                    <!--<tr><td align="right" width="100%" style='font-family: Segoe UI;text-align:right;font-size:4;white-space: nowrap' ><span class='checkedTypeFor'></span></td></tr>-->
                                    <tr>
                                        <td width="100%"   style='font-family: Segoe UI;text-align:left;font-size:17px;font-weight: bold;white-space: nowrap;vertical-align: bottom'><%=ouCompanyName%></td>
                                    </tr>
                                    <tr>
                                        <td width="100%"  style='font-family: Segoe UI;text-align:left;font-size:11px;white-space: nowrap'><%=orNumToLetter.toCamelCase(businessType)%></td>
                                    </tr>                        
                                    <tr>
                                        <td width="25%"   style='font-family: Segoe UI;text-align:left;font-size:11px;white-space: nowrap'><%=ouAddress%></td>
                                    </tr>
                                    <%}%>
                                    <tr><td width="100%" style="text-align: left;padding-top: 3px;font-size:11px;"><b>State : </b><%=billState%> / <b>Pan No : </b><%=panNo%> / <b>GSTIN No : </b><%=gstNo%></td>
                                        <!--<td width="70%" style="text-align: right"><span class='checkedTypeFor'></span></td>-->
                                    </tr>
                                    <%if (eInvApplcble.equals("1")) {%>
                                    <tr><td width="100%" style="text-align: left;padding-top: 3px;font-size:11px;"><b>IR No : </b><%=irNo%></td></tr>
                                    <%}%>
                                </table>
                                <div id='hdrWithoutImg'>
                                    <table cellspacing='0' cellpadding='0' style="width:100%">
                                        <tr>
                                            <%if (monthlySatus.equals("MONTHLY")) {%>
                                            <td width='54%' align='center' style="text-align: right;vertical-align: bottom;font-size: 16px"><span style="text-align: right;float: left;font-size: 11px" class='checkedTypeFor'></span><b>Tax Invoice-Import FCL</b></td>
                                                    <%} else {%>
                                            <td width='54%' align='center' style="text-align: right;vertical-align: bottom;font-size: 16px"><b id="checkedGroupType" style="text-align: left;float: left"><font size='4'>☑</font><span class="typeForLabel" id="officeTab" style="font-size:12px;">&nbsp;Office Copy</span><span class="typeForLabel" id="originalTab" style="font-size:12px;">&nbsp;Original for Recipient</span></b><b>Tax Invoice-Import FCL</b></td>
                                                    <%}%>
                                            <td width='14%'  style="text-align: center;vertical-align: middle;font-size: 11px"></td>
                                            <td width='32%' style="text-align: right;font-size: 13px" ><p><B>Invoice No :</B> ${seqNo}<br><b>Invoice Date : </b> ${invoiceDate}</p></td>
                                        </tr>
                                    </table>
                                    &nbsp;
                                    <c:choose>
                                        <c:when test="${not empty monthlyFlag and fn:contains(monthlyFlag, 'MONTHLY')}">
                                            <table cellspacing='0' cellpadding='0' style="width:100%;border: 1px solid #aaa;border-collapse: collapse">
                                                <tr>
                                                    <td width="28%" style="vertical-align: top;border-right: 1px solid #aaa;padding:3px">
                                                        <B>&nbsp;Bill To</B>
                                                        <br/>
                                                        <div style="margin-left:5px;font-family: Segoe UI;font-size:11px;">
                                                            <%=billToCustomer%><br/>
                                                            <%=billToAddress%><br>
                                                            <b>Place Of Supply : </b><%=billToState%><br>
                                                            <%if (type.equals("CHA")) {
                                                            %><b>GSTIN No :</b> <%=chaGst%><%
                                                            } else if (type.equals("IMPORTER")) {
                                                            %><b>GSTIN No :</b> <%=impGst%><%
                                                            } else if (type.equals("SLINER")) {
                                                            %><b>GSTIN No :</b> <%=slinerGst%><%
                                                            } else {
                                                            %><b>GSTIN No :</b> <%=otherGst%><%
                                                                }%>
                                                            <b>Tax is Payable On Reverse Charge :</b> No
                                                        </div>
                                                    </td>
                                                    <%if (eInvApplcble.equals("1")) {%>
                                                    <td width="20%" style="text-align: center;padding-top: 5px">
                                                        <%if (!qrCodeDB.isEmpty()) {%>
                                                        <img id="qr-code"/>
                                                        <%}%>
                                                    </td>
                                                    <%}%>
                                                </tr>
                                            </table>
                                        </c:when>
                                        <c:otherwise>
                                            <table cellspacing='0' cellpadding='0' style="width:100%;border: 1px solid #aaa;border-collapse: collapse">
                                                <tr>
                                                    <td width="28%" style="vertical-align: top;border-right: 1px solid #aaa;padding:3px">
                                                        <b>&nbsp;Bill To</b>
                                                        <br/>
                                                        <div style="margin-left:5px;font-family: Segoe UI;font-size:11px;">
                                                            <%=billToCustomer%><br/>
                                                            <%=billToAddress%><br>
                                                            <b>Place Of Supply : </b><%=billToState%><br>
                                                            <%if (type.equals("CHA")) {
                                                            %><b>GSTIN No :</b> <%=chaGst%><%
                                                            } else if (type.equals("IMPORTER")) {
                                                            %><b>GSTIN No :</b> <%=impGst%><%
                                                            } else if (type.equals("SLINER")) {
                                                            %><b>GSTIN No :</b> <%=slinerGst%><%
                                                            } else {
                                                            %><b>GSTIN No :</b> <%=otherGst%><%
                                                                }%>
                                                        </div>
                                                    </td>
                                                    <td  width="40%" style="vertical-align: top;border-right: 1px solid #aaa;padding:3px">
                                                        <p style="font-family: Segoe UI;font-size:11px;padding:3px">
                                                            <b>BOE No/Date :</b> <%=boe%><br>
                                                            <b>IGM No/Line No/Year :</b> <%=igm%><br>
                                                            <b>BL No :</b> <%=bl%><br>
                                                            <b>Vessel/Voyage : </b><%=orNumToLetter.toCamelCase(vessel)%><br>
                                                            <b>Steamer :</b> <%=orNumToLetter.toCamelCase(sliner)%><%if (eInvApplcble.equals("1")) {%><br>
                                                            <b>Steamer Division :</b> <%=orNumToLetter.toCamelCase(slinerDivision)%><%} else {%><span>-</span> <%=orNumToLetter.toCamelCase(slinerDivision)%><%}%><br>
                                                            <%if (type != null && type.equals("IMPORTER")) {%>
                                                            <b>CHA :</b> <%=orNumToLetter.toCamelCase(cha)%><%if (eInvApplcble.equals("1")) {%><br>
                                                            <b>CHA Division :</b> <%=orNumToLetter.toCamelCase(chaDivision)%><%} else {%><span>-</span> <%=orNumToLetter.toCamelCase(chaDivision)%><%}%><br>
                                                            <%} else {%>
                                                            <b>Importer :</b> <%=orNumToLetter.toCamelCase(importer)%><%if (eInvApplcble.equals("1")) {%><br>
                                                            <b>Importer Division :</b> <%=orNumToLetter.toCamelCase(importerDivision)%><%} else {%><span>-</span> <%=orNumToLetter.toCamelCase(importerDivision)%><%}%><br>
                                                            <%}%>
                                                            <%if (type != null && !type.equals("IMPORTER") && !type.equals("CHA")) {%>
                                                            <b>CHA :</b> <%=orNumToLetter.toCamelCase(cha)%><%if (eInvApplcble.equals("1")) {%><br>
                                                            <b>CHA Division :</b> <%=orNumToLetter.toCamelCase(chaDivision)%><%} else {%><span>-</span> <%=orNumToLetter.toCamelCase(chaDivision)%><%}%><br>
                                                            <%}%>
                                                            <b>Tax is Payable On Reverse Charge :</b> No
                                                        </p>
                                                    </td>
                                                    <%if (eInvApplcble.equals("1")) {%>
                                                    <td width="20%" style="text-align: center;padding-top: 5px">
                                                        <%if (!qrCodeDB.isEmpty()) {%>
                                                        <img id="qr-code"/>
                                                        <%}%>
                                                    </td>
                                                    <%}%>
                                                </tr>
                                            </table>
                                            <div align="left">
                                                <table cellspacing='0' cellpadding='0' style='width:100%;border-collapse: collapse;border:1px solid #aaa;border-top: 0px;'>
                                                    <tr>
                                                        <td style="border-bottom: 1px solid #aaa;font-family: Segoe UI;font-size:11px;padding: 2px;border-right: 1px solid #aaa;"><b>Cargo : </b> <%=orNumToLetter.toCamelCase(cargo)%></td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>   
                            </div>
                            <div id="printAll" >
                                <style>
                                    @media screen {
                                        <%if (monthlySatus.equals("MONTHLY")) {%>
                                        #termsBlock{
                                            display: none !important;
                                        }
                                        #termsBlockData{
                                            display: none;
                                        }
                                        #checkedTypeFor{
                                            display: none;
                                        }
                                        #supplierDeclaration{
                                            display: none !important;
                                        }
                                        #footerReg{
                                            display: none;
                                        }
                                        #footerRegData{
                                            display: none;
                                        }
                                        #annexure{
                                            display: none;
                                        }
                                        #headerTableDiv{
                                            display: none;
                                        }
                                        #fclOffCopyData{
                                            display: none; 
                                        }
                                        #headerTable{
                                            <%if (ou.equals("24")) {%>
                                            background: url(screens/images/ecctaeoLogo.png) !important;
                                            background-size: 120px 90px !important;
                                            <%} else {%>
                                            background: url(screens/images/KerryIndevNewLogo.png) !important;
                                            <%}%>
                                            background-repeat: no-repeat !important;
                                            background-position-x: 100% !important;
                                            background-position-y: -3px !important;
                                            -webkit-print-color-adjust: exact !important;
                                        }
                                        <%}%>  
                                    }
                                    @media print {
                                        @page:left{
                                            margin-top: 1.5cm;
                                            margin-bottom: 1.5cm;
                                        }
                                        @page:right{
                                            margin-top: 1.5cm;
                                            margin-bottom: 1.5cm;
                                        }
                                        <%if (monthlySatus.equals("MONTHLY")) {%>
                                        #checkedGroupType{
                                            display: none;
                                        }
                                        <%}%>
                                        <%if (!monthlySatus.equals("MONTHLY") && importFclPrintType.equals("OfficeCopy")) {%>
                                        #supplierDeclaration{	
                                            display: block;	
                                        }
                                        #originalTab{	
                                            display: none;	
                                        }
                                        #termsBlock{	
                                            display: none;	
                                        }
                                        <%} else {%>
                                        #supplierDeclaration{	
                                            display: none;	
                                        }
                                        #officeTab{	
                                            display: none;	
                                        }
                                        #termsBlock{	
                                            display: block;	
                                        }
                                        <% } %>
                                        #fclOffCopyData{
                                            display: block; 
                                        }
                                        #annexure{
                                            position:relative;
                                            display: block;
                                        }
                                        #footerGroupData{
                                            position: relative;
                                            bottom: 2%;
                                        }
                                        #headerTableDiv{
                                            display: block;
                                            position: relative;
                                            top: 0;
                                        }
                                        #footerGroup{
                                            display: block;
                                            margin-top: 12%;
                                            position: relative;
                                            bottom: 2%;
                                        }

                                        ol {
                                            padding-left: 1.8em;
                                        }

                                        #storageTable td,th{
                                            border:1px solid #aaa;  
                                        }
                                        #checkedTypeFor{
                                            display: inline;
                                        }  
                                        #storageTable{
                                            border: 1px solid #aaa; 
                                        }
                                        #tableContent td{
                                            padding-top: 0px;
                                        }
                                        #footerReg{
                                            display: block;
                                            position: relative;
                                        }
                                        #footerRegData{
                                            display: block;
                                            position: relative;
                                        }
                                        #headerTable{
                                            <%if (ou.equals("24")) {%>
                                            background: url(screens/images/ecctaeoLogo.png);
                                            background-size: 120px 90px;
                                            <%} else {%>
                                            background: url(screens/images/KerryIndevNewLogo.png);
                                            <%}%>
                                            background-repeat: no-repeat;
                                            background-position-x: 100%;
                                            background-position-y: -3px;
                                            -webkit-print-color-adjust: exact !important;
                                        }
                                    }
                                    <%if (!monthlySatus.equals("MONTHLY")) {%>
                                    #headerTable{
                                        <%if (ou.equals("24")) {%>
                                        background: url(screens/images/ecctaeoLogo.png);
                                        background-size: 120px 90px;
                                        <%} else {%>
                                        background: url(screens/images/KerryIndevNewLogo.png);
                                        <%}%>
                                        background-repeat: no-repeat;
                                        background-position-x: 100%;
                                        background-position-y: -3px;
                                        -webkit-print-color-adjust: exact !important;
                                    }
                                    <%}%>
                                </style>
                                <div id='tableContent' align="left" style="padding-top: 5px;">
                                    <table style='width:100%;border: 1px solid #aaa;font-size: 11px;border-collapse: collapse'>
                                        <thead>
                                            <tr style="border-bottom: 1px solid #aaa">
                                                <th style="border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;padding: 2px;">S.No</th>
                                                <th style="border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;padding: 2px;">Service Description</th>
                                                <th style="border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;padding: 2px;">SAC</th>
                                                <th style="border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;padding: 2px;">Qty</th>
                                                <th style="border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;padding: 2px;">Rate &#x20B9;</th>
                                                <th style="border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;padding: 2px;">Amount &#x20B9;</th>
                                                    <%if (!invoiceTaxHeader.isEmpty()) {
                                                            int tdWidth = 70 / invoiceTaxHeader.size();
                                                            for (int j = 0; j < invoiceTaxHeader.size(); j++) {
                                                                taxTotal.add(0.00);
                                                    %>
                                                <th colspan="2" style="border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;padding: 2px;text-align: center">
                                                    <%=invoiceTaxHeader.get(j).toString()%> &#x20B9;
                                                </th>
                                                <%}
                                                    }%>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                chargeAmount = 0.00;
                                                Double taxAmt = 0.00, netAmt = 0.00;
                                                for (int i = 0; i < invoicePreviewList.size(); i++) {
                                                    ArrayList recordData = (ArrayList) invoicePreviewList.get(i);
                                            %>
                                            <tr style="border-bottom: 1px solid #aaa;">
                                                <td  style='font-family: Segoe UI;text-align:center;border-right:1px solid #aaa;font-size:11px '>
                                                    <%=(i + 1)%>
                                                </td>
                                                <%
                                                    for (int k = 0; k < recordData.size(); k++) {
                                                        if (k == 0) {
                                                            taxCodeCount = 0;
                                                %>
                                                <td style='border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;white-space: nowrap;padding-left: 5px'>
                                                    <%=orNumToLetter.toCamelCase(recordData.get(k).toString() + "-") + recordData.get(k + 2).toString().toUpperCase()%>
                                                </td>
                                                <%} else if (k == 1) {%>
                                                <td style='border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;white-space: nowrap;padding-left: 5px;text-align: center;padding: 2px;padding-right: 5px;'>
                                                    <%if (recordData.get(k) != null) {
                                                            out.print(recordData.get(k));
                                                        } else {
                                                            out.print("");
                                                        }%>
                                                </td>
                                                <%} else if (k == 3) {%>
                                                <td style='border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;white-space: nowrap;padding-left: 5px;text-align: center;padding: 2px;padding-right: 5px;'>
                                                    <%=recordData.get(k)%>
                                                </td>
                                                <%} else if (k == 4) {
                                                    Double rateAmount = 0.00;
                                                    if (!recordData.get(k).toString().equals("")) {
                                                        rateAmount = Double.parseDouble(recordData.get(k).toString());
                                                    }%>
                                                <td style='border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;white-space: nowrap;padding-left: 5px;text-align: right;padding: 2px;padding-right: 5px;'>
                                                    <%if (!recordData.get(k).toString().equals("")) {
                                                            out.print(form.format(rateAmount));
                                                        } else {
                                                            out.print("");
                                                        }%>
                                                </td>
                                                <%} else if (k == 5) {
                                                    chargeAmount += Double.parseDouble(recordData.get(k).toString());
                                                    Double chrgeAmount = 0.00;
                                                    if (!recordData.get(k).toString().equals("")) {
                                                        chrgeAmount = Double.parseDouble(recordData.get(k).toString());
                                                    }
                                                %>
                                                <td style='border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;white-space: nowrap;padding-left: 5px;text-align: right;padding: 2px;padding-right: 5px;'>
                                                    <%if (!recordData.get(k).toString().equals("")) {
                                                            out.print(form.format(chrgeAmount));
                                                        } else {
                                                            out.print("");
                                                        }%>
                                                </td>
                                                <%} else if (k != 2) {
                                                    if (!taxFlag) {
                                                        taxFlag = true;
                                                %>
                                                <td style='border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;white-space: nowrap;padding-left: 5px;text-align: right;padding: 2px;padding-right: 5px;'>
                                                    <%if (recordData.get(k) != null) {
                                                            out.print(recordData.get(k));
                                                        } else {
                                                            out.print("0.00");
                                                        }%>
                                                </td>
                                                <%} else {
                                                    taxFlag = false;
                                                    String resultAmount = "0.00";
                                                    if (recordData.get(k) != null && !recordData.get(k).toString().equals("")) {
                                                        resultAmount = recordData.get(k).toString();
                                                    }
                                                    taxAmt += Double.parseDouble(resultAmount);
                                                    Double taxChrgeAmt = 0.00;
                                                    if (!resultAmount.equals("")) {
                                                        taxChrgeAmt = Double.parseDouble(resultAmount);
                                                    }
                                                    Double amt = taxTotal.get(taxCodeCount);
                                                    amt += Double.parseDouble(resultAmount);
                                                    taxTotal.set(taxCodeCount, amt);
                                                    taxCodeCount++;
                                                %>
                                                <td style='border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;white-space: nowrap;padding-left: 5px;text-align: right;padding: 2px;padding-right: 5px;'>
                                                    <%if (recordData.get(k) != null && !recordData.get(k).toString().equals("")) {
                                                            out.print(form.format(taxChrgeAmt));
                                                        } else {
                                                            out.print("0.00");
                                                        }%>
                                                </td>
                                                <%}
                                                        }
                                                    }%>
                                            </tr>
                                            <%}
                                                netAmt = chargeAmount + taxAmt;
                                                DecimalFormat df = new DecimalFormat("####0.00");
                                            %>
                                        </tbody>
                                        <tbody style="page-break-inside: avoid">
                                            <tr style="border-bottom: 1px solid #aaa;">
                                                <td rowspan="2" colspan="2" style="padding: 2px;padding-left: 5px;border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;vertical-align: top;border-top: 1px solid #aaa;white-space: normal"><b>Rupees: </b><span id='amountInWords'></span></td>
                                                <td colspan="3" align="right" style="padding: 2px;padding-right: 5px;border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;border-top: 1px solid #aaa;">Total</td>
                                                <td  style="padding: 2px;padding-right: 5px;border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;text-align: right;border-top: 1px solid #aaa;">
                                                    <%=form.format(chargeAmount)%>
                                                </td>
                                                <%for (int k = 0; k < taxTotal.size(); k++) {%>
                                                <td colspan="2"  style="padding: 2px;padding-right: 5px;border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;text-align: right;border-top: 1px solid #aaa;">
                                                    <%=form.format(taxTotal.get(k))%>
                                                </td>
                                                <%}%>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right;padding: 2px;padding-right: 5px;border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;white-space: nowrap" colspan="3"><%=taxTotalPercentage%></td>
                                                <td style="text-align:right;padding: 2px;padding-right: 5px;border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;"><%=form.format(taxAmt)%></td>
                                                <td colspan="<%=taxTotal.size() * 2%>" style="border-right:1px solid #aaa; "></td>
                                            </tr>     
                                            <tr style="border-bottom: 1px solid #aaa;">
                                                <td colspan="5" align="right" style="padding: 2px;padding-right: 5px;border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;border-top:1px solid #aaa; ">Grand Total</td>
                                                <td align="right" style="padding: 2px;padding-right: 5px;border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;border-top:1px solid #aaa;"><%if (!totalAmount.equals("")) {%><%=form.format(Double.parseDouble(totalAmount))%><%}%></td>
                                                <td colspan="<%=taxTotal.size() * 2%>" style="border-right:1px solid #aaa; "></td>
                                            </tr>
                                        </tbody>
                                    </table>&nbsp;
                                    <div style="page-break-inside: avoid">
                                        <div>
                                            <div style="text-align: right;padding-top: 5px;font-family: Segoe UI;font-size:11px;float: right">For <span style="font-weight: normal"> <%=ouCompanyName%></span></div>
                                            <div style="font-family: Segoe UI;font-size:11px;float: left;">
                                                <% if (ou.equals("06")) {%>
                                                <b>A/c Name&nbsp;&nbsp;&nbsp; :</b> Kerry Indev Logistics Pvt Ltd
                                                <br/>
                                                <%}%>
                                                <b>A/c No&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b><span style="font-weight: normal"> <%=accountNumber%></span>
                                                <br/>
                                                <b>Bank Name&nbsp;:</b><span style="font-weight: normal"> <%=bankName%></span>
                                                <br/>
                                                <b>IFS Code&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  :</b><span style="font-weight: normal"> <%=ifsCode%></span>
                                                <br/>
                                                <b>Branch &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b><span style="font-weight: normal"> <%=bankBranch%></span>
                                                <br/>
                                                <%if (remarks != null && !remarks.equals("")) {%>
                                                <b>Remarks : </b><span style="font-weight: normal"> <%=remarks%></span>
                                                <br/>
                                                <%}%>
                                                <%if (billingHistory != null && !billingHistory.equals("")) {%>
                                                <b>Billing history : </b><span style="font-weight: normal"> <%=billingHistory%></span>
                                                <%}%>
                                            </div>
                                        </div>
                                        <br>
                                        <br>
                                        <br>
                                        <div align="left">
                                            <table style="width:100%">
                                                <tr>
                                                    <td style="font-family: Segoe UI;font-size:11px;padding: 0px;"><b>Prepared by</b> <b>:</b><span style="font-weight: normal"> <%=userName%></span></td>
                                                    <td style="font-family: Segoe UI;font-size:11px;" align="right"><b>Authorised Signatory</b>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <br>
                                    <div id="supplierDeclaration" style="font-size: 11px">
                                        <p>
                                            Hereby declare that the details mentioned in this invoice, is true to the best of my knowledge and, I accept the same.
                                            <br>
                                            for <%=billToCustomer%>
                                            <br>
                                            <br>
                                            <br>
                                            <br>
                                            <b>Authorised Representative</b>
                                        </p>
                                    </div>   
                                    <br>
                                    <br>
                                    <c:if test="${empty monthlyFlag}">
                                        <table style="margin-top: 2px;" cellspacing='0' cellpadding='0' width="100%">
                                            <td>
                                                <table id="storageTable"  cellspacing='0' cellpadding='0' style='width:100%;border-collapse: collapse' class="billingTable" >
                                                    <tr><b>Container Details:</b></tr><br>
                                                    <c:if test="${not empty storageList}">
                                                        <c:forEach items="${storageList}" var="storageListRow" varStatus="mainLoop">
                                                            <c:choose>
                                                                <c:when test="${mainLoop.first}">
                                                                    <thead>
                                                                        <tr style="white-space: nowrap;font-size: 11px">
                                                                            <c:if test="${not empty storageListRow}">
                                                                                <c:forEach items="${storageListRow}" var="storageHeader">
                                                                                    <th style="border-right: 1px solid #aaa;font-family: Segoe UI;font-size:11px;padding: 2px">
                                                                                        ${storageHeader}
                                                                                    </th>
                                                                                </c:forEach>
                                                                            </c:if>
                                                                        </tr>
                                                                    </thead>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <tbody>
                                                                        <c:if test="${not empty storageListRow}">
                                                                            <tr style="border-bottom: 1px solid #aaa">
                                                                                <c:forEach items="${storageListRow}" var="storageTd">
                                                                                    <td style='text-align:center;font-size:11px;padding: 2px;font-weight: normal<c:if test="${storageTd.matches('([0-9]*)\\\\.([0-9]*)')}">text-align:right;font-weight: normal</c:if>'>
                                                                                        ${storageTd}
                                                                                    </td>
                                                                                </c:forEach>
                                                                            </tr>
                                                                        </c:if>
                                                                    </tbody>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </c:if>
                                                </table>
                                            </td>
                                        </table>
                                    </c:if>
                                    <br/>
                                    <div id="footerGroupData">
                                        <footer style="font-size: 10px;width: 100%;text-align: left">
                                            <div id="termsBlock">
                                                <b><u>Terms & Conditions :</u></b>
                                                <ol>
                                                    <li>Payment should be made by DD/Pay Order/Cheque or Telegraphic Transfer in favour of <%=ouCompanyName%></li>
                                                    <li>If this invoice is not paid within the payment terms, an interest at 15% p.a. at the sole discretion  of the company will
                                                        be charged.</li>
                                                    <li>If cheque is dishonored for
                                                        any reason whatsoever, the Customer shall, within 3 (three) days of being notified of such dishonor, remit the payment
                                                        by Demand Draft.</li>
                                                    <li>Any discrepancy found in this document should be notified to <%=ouCompanyName%> within three days of the receipt of 
                                                        this document.</li>
                                                    <li>All other terms and conditions are subject to scale of rates, terms of business, standard operating procedures as
                                                        applicable from time to time referred in our tariff as well as applicable contracts.</li>
                                                </ol>
                                            </div>
                                            <div id="footerRegData" style="font-size: 11px;border-top: 1px solid #aaa;width:100%;text-align: center">
                                                <%=ouRegisteredAddress + " " + cinNumber%> <span class="pageNumberSpan" style="float: right"></span>
                                            </div>
                                        </footer>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            </td>
        </tr>
        <%if (monthlySatus.equals("MONTHLY")) {%>
        <tr>
            <td style="text-align: center">
                <input type="button" class="buttonStyle invoicePreviewPrint" value="Print Invoice" id="btnPrintFc" onclick="fclInvoicePrint()"/>
                &nbsp;&nbsp; <input type="button" class="buttonStyle" value="Annexure" id="annexureBtnFc" onclick="getFclAnnexure()"/>
            </td>
        </tr>
        <tr><td>&emsp;</td></tr>
        <%}%>
    </table>
    <script>
        var qrCodeValue = "<%=qrCodeDB%>";
        var qr;
        (function () {
            qr = new QRious({
                element: document.getElementById('qr-code'),
                size: 110,
                value: qrCodeValue,
                padding: 0
            });
        })();

        <%if (monthlySatus.equals("MONTHLY")) {%>
        $(".forType").on("change", function () {
            $(".forType").not($(this)).prop("checked", false);
            $(this).prop("checked", true);
        });
        <%}%>

        function closeWindowForFclPrintPopup() {
            $('.processLoader1').hide();
            $('#impFclBillingPrintPopup').hide();
        }

        function fclInvoicePrint() {
            $(".forType:checked").attr("checked", "true");
            $(".checkedTypeFor").html("<b id='fclOffCopyData'><font size='3'>☑</font>  " + $(".forType:checked").siblings("span").html() + "</b>");
            $(".checkedTypeFor").show();
            if ($("#suppilerChb").is(":checked")) {
                $("#supplierDeclaration").show();
                $("#termsBlock").hide();
            } else {
                $("#supplierDeclaration").hide();
                $("#termsBlock").show();
            }
            var impfclInvoicePrint = document.getElementById("ifmcontentstoprint").contentWindow;
            impfclInvoicePrint.document.open();
            impfclInvoicePrint.document.write("<html><body><div style='height:500px;'>");
            impfclInvoicePrint.document.write($('#popUpFclInvoicePrintOthersEcct').html());
            impfclInvoicePrint.document.write("</div>");
            impfclInvoicePrint.document.write("</body></html>");
            impfclInvoicePrint.document.close();
            impfclInvoicePrint.focus();
            impfclInvoicePrint.print();
        }

        function convertNumberToWords(amount) {
            var words = new Array();
            words[0] = '';
            words[1] = 'One';
            words[2] = 'Two';
            words[3] = 'Three';
            words[4] = 'Four';
            words[5] = 'Five';
            words[6] = 'Six';
            words[7] = 'Seven';
            words[8] = 'Eight';
            words[9] = 'Nine';
            words[10] = 'Ten';
            words[11] = 'Eleven';
            words[12] = 'Twelve';
            words[13] = 'Thirteen';
            words[14] = 'Fourteen';
            words[15] = 'Fifteen';
            words[16] = 'Sixteen';
            words[17] = 'Seventeen';
            words[18] = 'Eighteen';
            words[19] = 'Nineteen';
            words[20] = 'Twenty';
            words[30] = 'Thirty';
            words[40] = 'Forty';
            words[50] = 'Fifty';
            words[60] = 'Sixty';
            words[70] = 'Seventy';
            words[80] = 'Eighty';
            words[90] = 'Ninety';
            amount = amount.toString();
            var atemp = amount.split(".");
            var number = atemp[0].split(",").join("");
            var n_length = number.length;
            var words_string = "";
            if (n_length <= 9) {
                var n_array = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0);
                var received_n_array = new Array();
                for (var i = 0; i < n_length; i++) {
                    received_n_array[i] = number.substr(i, 1);
                }
                for (var i = 9 - n_length, j = 0; i < 9; i++, j++) {
                    n_array[i] = received_n_array[j];
                }
                for (var i = 0, j = 1; i < 9; i++, j++) {
                    if (i == 0 || i == 2 || i == 4 || i == 7) {
                        if (n_array[i] == 1) {
                            n_array[j] = 10 + parseInt(n_array[j]);
                            n_array[i] = 0;
                        }
                    }
                }
                value = "";
                for (var i = 0; i < 9; i++) {
                    if (i == 0 || i == 2 || i == 4 || i == 7) {
                        value = n_array[i] * 10;
                    } else {
                        value = n_array[i];
                    }
                    if (value != 0) {
                        words_string += words[value] + " ";
                    }
                    if ((i == 1 && value != 0) || (i == 0 && value != 0 && n_array[i + 1] == 0)) {
                        words_string += "Crores ";
                    }
                    if ((i == 3 && value != 0) || (i == 2 && value != 0 && n_array[i + 1] == 0)) {
                        words_string += "Lakhs ";
                    }
                    if ((i == 5 && value != 0) || (i == 4 && value != 0 && n_array[i + 1] == 0)) {
                        words_string += "Thousand ";
                    }
                    if (i == 6 && value != 0 && (n_array[i + 1] != 0 && n_array[i + 2] != 0)) {
                        words_string += "Hundred and ";
                    } else if (i == 6 && value != 0) {
                        words_string += "Hundred ";
                    }
                }
                words_string = words_string.split("  ").join(" ") + "Rupees Only";
            }
            return words_string;
        }

        var chargeamount = "<%=totalAmount%>";
        document.getElementById("amountInWords").innerHTML = convertNumberToWords(chargeamount);
//        $("#amountInWords").text(convertNumberToWords(chargeamount));
//        var hdrWithImage = false;
//        var officeCopyFlag = false;
//         <%if (importFclPrintType.equals("OfficeCopy")) {%>
//        document.getElementById("supplierDeclaration").style.display = "block";
//        document.getElementById("originalTab").style.display = "none";
//        document.getElementById("termsBlock").style.display = "none";
//        <%} else {%>
//        document.getElementById("supplierDeclaration").style.display = "none";
//        document.getElementById("officeTab").style.display = "none";
//        document.getElementById("termsBlock").style.display = "block";
//        <% }%>
    </script>
</html>
