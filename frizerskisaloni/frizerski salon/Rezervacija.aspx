<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Rezervacija.aspx.cs" Inherits="frizerski_salon.Rezervacija" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rezervacija</title>
    <link href="Rezervacija.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="naziv">
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        </div>
            <br />
        <div class="salon">
            <asp:DropDownList ID="ddl_frizerskisalon" runat="server" OnSelectedIndexChanged="ddl_frizerskisalon_SelectedIndexChanged" AutoPostBack="True" >
            </asp:DropDownList>
        </div>
        <div class="kalendar">
            <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="380px" NextPrevFormat="FullMonth" OnDayRender="Calendar1_DayRender" OnSelectionChanged="Calendar1_SelectionChanged" Width="700px">
                <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                <OtherMonthDayStyle ForeColor="#999999" />
                <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                <TodayDayStyle BackColor="#CCCCCC" />
            </asp:Calendar>
        </div>
        <div class="podaci">
            <asp:DropDownList ID="ddl_vreme" runat="server">
            </asp:DropDownList>
            <asp:DropDownList ID="ddl_frizer" runat="server">
            </asp:DropDownList>
            <asp:Button ID="Button1" runat="server" Text="Potvrdi" OnClick="Button1_Click" />
        </div>
    </form>
</body>
</html>
