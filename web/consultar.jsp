<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consultar Contato</title>
        <link rel="stylesheet" href="configura.css"/>
    </head>
    <body>
        <!-- Formulário para pesquisar o contato -->
        <form method="get" action="consultar.jsp">
            <label for="id_figure">ID da Figure:</label>
            <input type="number" name="id_figure" id="id_figure" placeholder="ID da figure" required>
            <button type="submit">Pesquisar</button>
        </form>

        <%
            // Recebe o ID do contato digitado no formulário
            String idParam = request.getParameter("id_figure");
            
            if (idParam != null && !idParam.trim().isEmpty()) {
                try {
                    // Conexão com o banco de dados
                    Connection conecta;
                    PreparedStatement st;
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/actionfigure"; // Ajuste conforme o banco de dados
                    String user = "root";
                    String password = "";
                    conecta = DriverManager.getConnection(url, user, password);

                    // Consulta SQL para buscar o contato pelo ID
                    String sql = "SELECT * FROM figures WHERE id_figure = ?";
                    st = conecta.prepareStatement(sql);
                    st.setInt(1, Integer.parseInt(idParam)); // Converte o ID para inteiro

                    // Executa a consulta e exibe os resultados
                    ResultSet rs = st.executeQuery();
                    
                    // Verifica se a consulta retornou resultados
                    boolean hasResults = false;
        %>
                    <h1>Resultado da Busca</h1>
                    <table border="1">
                        <tr>
                            <th>ID</th>
                            <th>Nome da Figure</th>
                            <th>Fabricante</th>
                            <th>Preço</th>
                        </tr>
                        <%
                            // Exibe o registro encontrado
                            while (rs.next()) {
                                hasResults = true;
                        %>
                        <tr>
                            <td><%= rs.getInt("id_figure") %></td>
                            <td><%= rs.getString("nm_figure") %></td>
                            <td><%= rs.getString("nm_fabricante") %></td>
                            <td>R$ <%= rs.getDouble("preco") %></td>
                        </tr>
                        <%
                            }
                            // Mensagem caso nenhum resultado seja encontrado
                            if (!hasResults) {
                        %>
                        <tr>
                            <td colspan="4" style="text-align: center;">Nenhum contato encontrado.</td>
                        </tr>
                        <%
                            }
                            // Fecha recursos
                            rs.close();
                            st.close();
                            conecta.close();
                        %>
                    </table>
        <%
                } catch (Exception e) {
                    out.print("<p style='color: red;'>Erro: " + e.getMessage() + "</p>");
                }
            } else {
                out.print("<p style='color: red;'>Por favor, insira um ID válido para buscar.</p>");
            }
        %>
    </body>
</html>
