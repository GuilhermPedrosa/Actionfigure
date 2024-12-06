<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterar Produto</title>
        <link rel="stylesheet" href="carregar.css">
    </head>
    <body>
        <%
            try {
                // Recebe o ID do produto como parâmetro da requisição
                int id_figure = Integer.parseInt(request.getParameter("id_figure"));
                
                // Conexão com o banco de dados
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/actionfigure"; // Ajuste para o nome correto do seu banco de dados
                String user = "root";
                String password = "";
                conecta = DriverManager.getConnection(url, user, password);

                // Consulta SQL para buscar o produto pelo ID
                String sql = "SELECT * FROM figures WHERE id_figure = ?";
                st = conecta.prepareStatement(sql);
                st.setInt(1, id_figure); // Passando o ID como parâmetro

                ResultSet resultado = st.executeQuery();
               
                if (!resultado.next()) {
                    // Caso o ID informado não seja encontrado
                    out.print("Esta figure não foi encontrada.");
                } else {
                    // Se encontrou o produto, carrega os dados no formulário
        %>
            <form method="post" action="alterar_telefone.jsp">
                <p>
                    <label for="id_figure">ID:</label>
                    <input id="id_figure" type="number" name="id_figure" value="<%= resultado.getInt("id_figure") %>" readonly>
                </p>
                
                <p>
                    <label for="nm_figure">Nome da Figure:</label>
                    <input id="nm_figure" type="text" name="nm_figure" value="<%= resultado.getString("nm_figure") %>" required>
                </p>

                <p>
                    <label for="nm_fabricante">Fabricante:</label>
                    <input id="nm_fabricante" type="text" name="nm_fabricante" value="<%= resultado.getString("nm_fabricante") %>" required>
                </p>
                
                <p>
                    <label for="preco">Preço da Figure:</label>
                    <input id="preco" type="number" step="0.01" name="preco" value="<%= resultado.getDouble("preco") %>" required>
                </p>

                <p>
                    <input type="submit" value="Salvar Alterações">
                </p>
            </form>
        <%
                }
                // Fecha os recursos
                resultado.close();
                st.close();
                conecta.close();
            } catch (NumberFormatException e) {
                out.print("<p style='color: red;'>ID inválido!</p>");
            } catch (Exception e) {
                out.print("<p style='color: red;'>Erro: " + e.getMessage() + "</p>");
            }
        %>
    </body>
</html>
