<%@page import="java.io.File"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.io.File"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.HashMap" %>
<%@page import="java.io.File"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.io.File"%>
<%
   Connection coneccion;
    Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
    coneccion = DriverManager.getConnection("jdbc:mysql://localhost/senacarnet", "root", "27478426*cP");

    String idFormacion = request.getParameter("idFormacion");
     
    int id = Integer.parseInt(idFormacion);

    // Crear un HashMap para almacenar los parámetros del informe
    HashMap<String, Object> parameters = new HashMap<>();
   
    // Agregar el parámetro agendaId al HashMap
    parameters.put("id", id);

    // Obtener la ruta del archivo Jasper
    File reportFile = new File(application.getRealPath("reportes/carnetFormciones.jasper"));

    try {
        // Generar el informe PDF con los parámetros
        byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, coneccion);

        // Mostrar el PDF normalmente
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream outputStream = response.getOutputStream();
        outputStream.write(bytes, 0, bytes.length);
        outputStream.flush();
        outputStream.close();
    } catch (Exception e) {
        // Capturar cualquier excepción que pueda ocurrir durante la generación del informe
        out.println("Error falta de imagenes en los carnet de la formacion: " + e.getMessage());
    }
%>
