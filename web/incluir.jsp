<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Captura os parâmetros do formulário
    int id_figure = Integer.parseInt(request.getParameter("id_figure"));
    String nm_figure = request.getParameter("nm_figure");
    String nm_fabricante = request.getParameter("nm_fabricante");
    double preco = Double.parseDouble(request.getParameter("preco"));

    try {
        // Conexão com o banco de dados
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/actionfigure";
        String user = "root";
        String password = "";
        Connection conecta = DriverManager.getConnection(url, user, password);

        // Comando SQL para inserir dados na tabela correta (contato)
        String sql = "INSERT INTO figures (id_figure, nm_figure, nm_fabricante, preco) VALUES (?, ?, ?, ?)";
        PreparedStatement st = conecta.prepareStatement(sql);
        st.setInt(1, id_figure);
        st.setString(2, nm_figure);
        st.setString(3, nm_fabricante);
        st.setDouble(4, preco);

        // Executa a inserção
        int rowsAffected = st.executeUpdate();
        if (rowsAffected > 0) {
            out.println("<p>Figure cadastrada com sucesso!</p>");
        } else {
            out.println("<p>Erro ao cadastrar a figure.</p>");
        }

        // Fecha a conexão
        st.close();
        conecta.close();
    } catch (ClassNotFoundException | SQLException e) {
        out.println("<p>Erro ao conectar ao banco de dados: " + e.getMessage() + "</p>");
    }
%>
