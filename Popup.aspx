<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Popup.aspx.vb" Inherits="Popup" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="_assets/themes/yui/style.css" rel="stylesheet" type="text/css" />
    <script src="_assets/js/jquery-1.2.6.min.js" type="text/javascript"></script>
    <script src="_assets/js/jquery.tablesorter-2.0.3.js" type="text/javascript"></script>
    <script src="_assets/js/jquery.tablesorter.filer.js" type="text/javascript"></script>
    <script src="_assets/js/jquery.tablesorter.pager.js" type="text/javascript"></script>
    
    <script type="text/jscript">
        function getURLParam(strParamName) {
            var strReturn = "";
            var strHref = window.location.href;
            var exp = new RegExp("[+]", "g");
            if (strHref.indexOf("?") > -1) {
                var strQueryString = strHref.substr(strHref.indexOf("?"));
                var aQueryString = strQueryString.split("&");
                for (var iParam = 0; iParam < aQueryString.length; iParam++) {
                    if (aQueryString[iParam].toLowerCase().indexOf(strParamName.toLowerCase() + "=") > -1) {
                        var aParam = aQueryString[iParam].split("=");
                        strReturn = aParam[1].replace(exp, " ");
                        break;
                    }
                }
            }
            return unescape(strReturn);
        }

        function RowMouseOver(row) {
            var selectedrow;
            var colName;
            selectedrow = document.getElementById("row" + row.toString());
            selectedrow.style.cursor = 'hand';
        }

        function RowSelected(row) {
            var rowdata, headerdata;
            var colName;
            rowdata = document.getElementById("row" + row.toString()).getElementsByTagName("td");

            var placement = getURLParam("Placement");
            var selColumn = getURLParam("SelColumn");
            var ColType = getURLParam("ColType");
            if (ColType == "html")
                opener.document.getElementById(placement).innerHTML = rowdata[selColumn * 1].innerHTML;
            else if (ColType == "value") {
                opener.document.getElementById(placement).value = rowdata[selColumn * 1].innerHTML;
            }
            else if (ColType == "valueload") {
                opener.document.getElementById(placement).value = rowdata[selColumn * 1].innerHTML;
                opener.document.getElementById(placement).onchange();
            }
            window.close();

        }

        function CreateTable(columnNo) {
            
            $(document).ready(function() {
                $("#ReportTable").tablesorter({ debug: false, sortList: [[0, 0]], widgets: ['zebra'] })
            .tablesorterPager({ container: $("#pagerOne"), positionFixed: false })
            .tablesorterFilter({ filterContainer: $("#filterBox0"),
                filterClearContainer: $("#filterClear0"),
                filterColumns: columnNo,
                filterCaseSensitive: false
            });

                $("#ReportTable").tablesorterFilter({ filterContainer: $("#filterBox1"),
                    filterClearContainer: $("#filterClear1"),
                    filterColumns: columnNo,
                    filterCaseSensitive: false
                });

                $("#ReportTable").tablesorterFilter({ filterContainer: $("#filterBox2"),
                    filterClearContainer: $("#filterClear2"),
                    filterColumns: columnNo,
                    filterCaseSensitive: false
                });
                $("#ReportTable").tablesorterFilter({ filterContainer: $("#filterBox3"),
                    filterClearContainer: $("#filterClear3"),
                    filterColumns: columnNo,
                    filterCaseSensitive: false
                });
                $("#ReportTable").tablesorterFilter({ filterContainer: $("#filterBox4"),
                    filterClearContainer: $("#filterClear4"),
                    filterColumns: columnNo,
                    filterCaseSensitive: false
                });
                $("#ReportTable").tablesorterFilter({ filterContainer: $("#filterBox5"),
                    filterClearContainer: $("#filterClear5"),
                    filterColumns: columnNo,
                    filterCaseSensitive: false
                });
                $("#ReportTable").tablesorterFilter({ filterContainer: $("#filterBox6"),
                    filterClearContainer: $("#filterClear6"),
                    filterColumns: columnNo,
                    filterCaseSensitive: false
                });
                $("#ReportTable").tablesorterFilter({ filterContainer: $("#filterBox7"),
                    filterClearContainer: $("#filterClear7"),
                    filterColumns: columnNo,
                    filterCaseSensitive: false
                });
                $("#ReportTable").tablesorterFilter({ filterContainer: $("#filterBox8"),
                    filterClearContainer: $("#filterClear8"),
                    filterColumns: columnNo,
                    filterCaseSensitive: false
                });
                $("#ReportTable").tablesorterFilter({ filterContainer: $("#filterBox9"),
                    filterClearContainer: $("#filterClear9"),
                    filterColumns: columnNo,
                    filterCaseSensitive: false
                });

            });

        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="tDiv" runat="server">
    
    </div>
    </form>
</body>
</html>
