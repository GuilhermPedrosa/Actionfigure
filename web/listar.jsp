<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Lista de Figures</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="listar.css">
    </head>
    <body>
        <% 
            try {
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/actionfigure";
                String user = "root";
                String password = "";
                conecta = DriverManager.getConnection(url, user, password);

                String sql = "SELECT * FROM figures";
                st = conecta.prepareStatement(sql);

                ResultSet rs = st.executeQuery();
        %>
        <table>
            <tr>
                <th>Id</th>
                <th>Nome</th>
                <th>Fabricante</th>
                <th>Preço</th>
            </tr>
            <% 
                while (rs.next()) { 
            %>
            <tr>
                <td><%= rs.getInt("id_figure") %></td>
                <td><%= rs.getString("nm_figure") %></td>
                <td><%= rs.getString("nm_fabricante") %></td>
                <td>R$ <%= String.format("%.2f", rs.getDouble("preco")) %></td>
            </tr>
            <% 
                } 
                rs.close();
                st.close();
                conecta.close();
            } catch (Exception x) {
                out.print("Mensagem de erro: " + x.getMessage());
            } 
            %>
        </table>
    </body>
</html>
