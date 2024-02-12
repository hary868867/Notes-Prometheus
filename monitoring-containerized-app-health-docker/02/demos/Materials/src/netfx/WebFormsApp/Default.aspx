<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebFormsApp._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Monitoring Containerized Apps - </title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>
            .NET WebForms App</h1>
        <h2>
            Server: <asp:Label runat="server" ID="lblServer" />
        </h2>
    </div>
    
    <hr />
    
    <h2>eShop</h2>
    <div>
        <asp:Button runat="server" ID="btnAddToCart" Text="Add to Cart" OnClick="BtnAddToCart_Click"></asp:Button>
        <asp:Button runat="server" ID="btnCheckout" Text="Checkout" OnClick="BtnCheckout_Click"></asp:Button>
    </div>
    
    <hr />
    
    <h2>Log</h2>
    
    <div>
        <asp:BulletedList runat="server" ID="listLog"></asp:BulletedList>
    </div>
    
    </form>
</body>
</html>
