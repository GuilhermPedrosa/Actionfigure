<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Produtos</title>
    </head>
    <body>
        <%
            try {
                // Conexão com o banco de dados
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/agenda_telefoneb";
                String user = "root";
                String password = "";
                conecta = DriverManager.getConnection(url, user, password);

                // Consulta SQL para listar produtos
                String sql = "SELECT * FROM produto";
                st = conecta.prepareStatement(sql);

                // Executa a consulta e obtém os dados
                ResultSet rs = st.executeQuery();
        %>
        <table border="1">
            <tr>
                <th>Id</th>
                <th>Nome</th>
                <th>Marca</th>
                <th>Preço</th>
                <th>Imagem</th>
             
            </tr>
            <%
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("nome") %></td>
                <td><%= rs.getString("marca") %></td>
                <td><%= rs.getDouble("preco") %></td>
                <td><img src="<%= rs.getString("imagem") %>" alt="Imagem do Produto" width="100" height="100"></td>
                <td><a href="excluir_produto.jsp?id=<%= rs.getInt("id") %>">Excluir</a></td>
            </tr>
            <%
                }
                // Fecha os recursos de banco de dados
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
