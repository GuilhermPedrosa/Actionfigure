<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterar Contato</title>
    </head>
    <body>
        <%
            int id_figure;
            String nm_figure, nm_fabricante;
            double preco;

            try {
                // Obtendo os parâmetros do formulário
                id_figure = Integer.parseInt(request.getParameter("id_figure"));
                nm_figure = request.getParameter("nm_figure");
                nm_fabricante = request.getParameter("nm_fabricante");
                preco = Double.parseDouble(request.getParameter("preco"));

                // Estabelecendo a conexão com o banco de dados
                String url = "jdbc:mysql://localhost:3306/actionfigure"; // Verifique se o nome do banco está correto
                String user = "root";
                String password = "";

                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conecta = DriverManager.getConnection(url, user, password);

                // SQL de atualização para a tabela 'contato'
                String sql = "UPDATE figures SET nm_figure=?, nm_fabricante=?, preco=? WHERE id_figure=?";
                PreparedStatement st = conecta.prepareStatement(sql);
                st.setString(1, nm_figure);
                st.setString(2, nm_fabricante);
                st.setDouble(3, preco);
                st.setInt(4, id_figure);

                // Executa a atualização no banco de dados
                int rowsAffected = st.executeUpdate();
                if (rowsAffected > 0) {
                    out.print("Os dados da figure " + nm_figure + " foram alterados com sucesso.");
                } else {
                    out.print("Nenhum dado foi alterado. Verifique o ID fornecido.");
                }

                // Fecha os recursos
                st.close();
                conecta.close();
            } catch (ClassNotFoundException e) {
                out.print("Erro: O driver JDBC não foi encontrado. " + e.getMessage());
            } catch (SQLException e) {
                out.print("Erro ao alterar o contato: " + e.getMessage());
            } catch (NumberFormatException e) {
                out.print("Erro: Dados inválidos fornecidos. Verifique os valores de ID e preço. " + e.getMessage());
            }
        %>
    </body>
</html>
