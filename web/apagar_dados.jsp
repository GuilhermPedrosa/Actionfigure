<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exclusão de Figure</title>
    </head>
    <body>
        <%
            // Recebe o ID digitado no formulário
            int id_figure;
            try {
                id_figure = Integer.parseInt(request.getParameter("id_figure"));
                
                // Conexão com o banco de dados
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/actionfigure"; // Nome do banco de dados
                String user = "root";
                String password = "";
                conecta = DriverManager.getConnection(url, user, password);

                // Excluindo o contato do ID informado
                String sql = "DELETE FROM figures WHERE id_figure = ?"; // Mudança de 'produto' para 'contato'
                st = conecta.prepareStatement(sql);
                st.setInt(1, id_figure);
                int resultado = st.executeUpdate(); // Executa o DELETE
                
                // Verifica se o contato foi ou não excluído
                if (resultado == 0) {
                    out.print("<p style='color: red;'>O contato com ID " + id_figure + " não está cadastrado.</p>");
                } else {
                    out.print("<p style='color: green;'>O contato com ID " + id_figure + " foi excluído com sucesso.</p>");
                }

                // Fecha a conexão
                st.close();
                conecta.close();
            } catch (NumberFormatException e) {
                out.print("<p style='color: red;'>ID inválido! Por favor, insira um número válido.</p>");
            } catch (Exception erro) {
                out.print("<p style='color: blue; font-size: 18px;'>Erro ao excluir a figure: " + erro.getMessage() + "</p>");
            }
        %>
    </body>
</html>
