<%@ Page Language="F#" AutoEventWireup="true" CodeFile="Default.aspx.fs" Inherits="Fits.Sample.DefaultPage"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>F# Sample</title>
</head>
<body>
  <form runat="server">
    <div>
      <asp:TextBox runat="server" id="InfoText" />
      <asp:Button runat="server" id="InfoButton" text="Button" onClick="InfoButton_Click" />
    </div>
    <div>
      <asp:Label runat="server" id="InfoLabel" />
    </div>
  </form>
</body>
</html>
