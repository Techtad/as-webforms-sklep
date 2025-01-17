﻿<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="MainPage.aspx.cs" Inherits="f3b_store.MainPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <title>F3B.com - Strona główna</title>
    <link href="css/all.css" rel="stylesheet" />
    <link href="/css/MainPage/productStyle.css" rel="stylesheet" />
    <link href="/css/MainPage/headerStyle.css" rel="stylesheet" />
    <link href="css/MainPage/mainStyle.css" rel="stylesheet" />
    <link href="/css/MainPage/footerStyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <div id="title">
                <img src="res/img/logo.png" />
            </div>
            <div id="menu">
                <div id="menu-list-box">
                    <ul id="menu-list">
                        <li>
                            <asp:LinkButton ID="lbToLogin" runat="server" PostBackUrl="~/LoginPage.aspx">Logowanie</asp:LinkButton>
                        </li>
                        <li>
                            <asp:LinkButton ID="lbToRegister" runat="server" PostBackUrl="~/RegisterPage.aspx" Visible="True">Rejestracja</asp:LinkButton>

                        </li>
                        <li>
                            <asp:LinkButton ID="lbToAdmin" runat="server" PostBackUrl="~/AdminPanel.aspx" Visible="False">Panel admina</asp:LinkButton>

                        </li>
                    </ul>
                </div>
                <div id="user-status">
                    <asp:LinkButton ID="lbToBasket" CssClass="cart-bt" runat="server" PostBackUrl="~/BasketPage.aspx">Koszyk</asp:LinkButton>
                    <asp:Label ID="lLoggedIn" CssClass="logged-as" runat="server" Text="Nie jesteś zalogowany."></asp:Label>
                    <asp:Button ID="bLogout" CssClass="logout-bt" runat="server" OnClick="bLogout_Click" Text="Wyloguj" Width="75px" />
                </div>
            </div>
        </header>

        <main>
            <div id="categories">
                <h1>Gatunki gier:</h1>
                <ul>
                    <asp:ListView ID="lvCategories" runat="server">
                        <ItemTemplate>
                            <li><a href="<%# "?category=" + Eval("name") %>"> <%# Eval("name") %></a></li>
                        </ItemTemplate>
                    </asp:ListView>
                </ul>
                <div id="search-box">
                    <asp:TextBox ID="tbSearch" runat="server" OnTextChanged="tbSearch_TextChanged" AutoPostBack="True" AutoCompleteType="Search"></asp:TextBox>
                    <asp:Button ID="bSearch" runat="server" Text="Szukaj" OnClick="bSearch_Click" />
                </div>
            </div>
            <div id="products">
                <asp:Repeater ID="rProducts" runat="server" OnItemCommand="basketHandler" OnItemDataBound="rProducts_ItemDataBound">
                    <ItemTemplate>
                        <div class="product">
                            <div class="prod-img-box">
                                <img
                                    class="prod-img"
                                    src="<%# Eval("img_path") %>"
                                    alt="product-image" />
                            </div>
                            <div class="prod-info">
                                <span class="prod-title"><%# Eval("name") %></span>
                                <div class="prod-spec-box">
                                    <div class="prod-spec">
                                        <p class="spec-text">Gatunek: <%# f3b_store.DBOperations.selectQuery("SELECT name FROM product_categories WHERE id LIKE '" + Eval("category").ToString() + "'").Rows[0]["name"] %></p>
                                        <p class="spec-text">
                                            Opis: <%# Eval("description") %>
                                        </p>
                                        <p class="spec-text">Deweloper: <%# Eval("supplier") %> </p>
                                    </div>
                                    <div class="prod-buy-box">
                                        <div class="prod-stock">Stan magazynowy: <%# Eval("stock") %></div>
                                        <div class="prod-price">Cena:<%# Eval("price") %><span class="currency">zł</span></div>
                                        <div class="prod-buy">
                                            <asp:TextBox ID="tbStock" runat="server" type="hidden" Text='<%# Eval("stock") %>'></asp:TextBox>
                                            <asp:TextBox ID="tbPrice" runat="server" type="hidden" Text='<%# Eval("price") %>'></asp:TextBox>
                                            <asp:TextBox ID="tbAmount" CssClass="prod-but-amount" runat="server" type="number" value="1" min="1" max='<%# Eval("stock") %>' step="1" Width="50"></asp:TextBox>
                                            <asp:Button ID="bAddProduct" CssClass="prod-buy-button" CommandName="addToBasket" CommandArgument='<%# Eval("id") %>' runat="server" Text="Dodaj do koszyka" PostBackUrl="/" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </main>

        <footer>
            <div id="flexfooter">
                <div id="sitemap">
                    <div id="konto">
                        <p>Konto</p>
                        <asp:LinkButton ID="lbToRegister2" runat="server" PostBackUrl="~/RegisterPage.aspx" Visible="False">Rejestracja</asp:LinkButton>
                        <asp:LinkButton ID="lbToAdmin2" runat="server" PostBackUrl="~/AdminPanel.aspx" Visible="False">Panel admina</asp:LinkButton>
                        <asp:LinkButton ID="lbToLogin2" runat="server" PostBackUrl="~/LoginPage.aspx">Zaloguj się</asp:LinkButton>
                        <asp:LinkButton ID="lbToBasket2" runat="server" PostBackUrl="~/BasketPage.aspx">Koszyk</asp:LinkButton>
                    </div>
                    <div id="sklep">
                        <p>Sklep</p>
                        <asp:LinkButton ID="lbToMainPage" runat="server" PostBackUrl="~/MainPage.aspx">Strona główna</asp:LinkButton>
                        <asp:LinkButton ID="lbToContact" runat="server" PostBackUrl="~/MainPage.aspx">Kontakt</asp:LinkButton>
                    </div>
                </div>
                <div id="info">
                    <p>Kontakt</p>
                    <span>Telefon: +48 213 769 666</span>
                    <span>Mail: kontakt@f3b.com</span>
                    <span>Adres: Wawel 5, 31-001 Kraków</span>
                </div>
            </div>
            <div id="copyright">© Techtad 2019</div>
        </footer>
    </form>
</body>
</html>
