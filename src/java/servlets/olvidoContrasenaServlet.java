package servlets;
import controladores.AdministradorJpaController;
import controladores.CoordinadorJpaController;
import controladores.EstudiantesJpaController;
import entidades.Administrador;
import entidades.Coordinador;
import entidades.Estudiantes;
import entidades.Usuarios;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Properties;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Peralta
 */
@WebServlet(name = "olvidoContraseñaServlet", urlPatterns = {"/olvidoContrase_aServlet"})
public class olvidoContrasenaServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {

        String boton = request.getParameter("action");

        switch (boton) {
            case "Enviar":
                buscarCorreo(request, response);
                break;
            default:
                throw new AssertionError();
        }

    }

    public void buscarCorreo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {

        // Aquí creas un nuevo objeto Usuarios para enviarlo por correo
        Usuarios usuario = new Usuarios();

        // Supongamos que obtienes la información necesaria para el usuario de alguna manera, por ejemplo, de los parámetros de la solicitud HTTP
        usuario.setCedula(Integer.parseInt(request.getParameter("cedula2")));

        // Aquí configuras los demás atributos del usuario según lo que necesites
        int cedula = usuario.getCedula();

        // Crear instancias de los controladores JPA
        EstudiantesJpaController estudiantesController = new EstudiantesJpaController();
        AdministradorJpaController admincontrolador = new AdministradorJpaController();
        CoordinadorJpaController cordinaControlador = new CoordinadorJpaController();

        boolean correoEnviado = false; // Variable para verificar si se envió el correo

        try {
            // Buscar el estudiante por cédula en la base de datos
            Estudiantes estudiante = estudiantesController.findEstudiantes(cedula);
            // Buscar el administrador por cédula en la base de datos
            Administrador admin = admincontrolador.findAdministrador(cedula);
            // Buscar el coordinador por cédula en la base de datos
            Coordinador cordina = cordinaControlador.findCoordinador(cedula);

            // Verificar si se encontró el estudiante y obtener su correo electrónico
            if (estudiante != null) {
                String correo = estudiante.getCorreo();
                // Ahora puedes enviar el correo electrónico al correo asociado
                enviarCorreo(correo, usuario, response, request); // Pasar el usuario como parámetro
                correoEnviado = true; // Actualizar la bandera
            }

            // Verificar si se encontró el administrador y obtener su correo electrónico
            if (admin != null) {
                String correo2 = admin.getCorreo();
                // Ahora puedes enviar el correo electrónico al correo asociado
                enviarCorreo(correo2, usuario, response, request); // Pasar el usuario como parámetro
                correoEnviado = true; // Actualizar la bandera
            }

            // Verificar si se encontró el coordinador y obtener su correo electrónico
            if (cordina != null) {
                String correo3 = cordina.getCorreo(); // Aquí debería ser cordina.getCorreo() en lugar de admin.getCorreo()
                // Ahora puedes enviar el correo electrónico al correo asociado
                enviarCorreo(correo3, usuario, response, request); // Pasar el usuario como parámetro
                correoEnviado = true; // Actualizar la bandera
            }

            // Después de encontrar al usuario
            HttpSession sesion = request.getSession();
            sesion.setAttribute("usuario", usuario);

            if (!correoEnviado) {
                // Si no se envió el correo, significa que no se encontró ninguna cédula
                String mensaje = "noCedula";
                response.sendRedirect("index.jsp?respuesta=" + mensaje);
            } else {

            }
        } catch (Exception ex) {
            // Manejar cualquier excepción que pueda ocurrir durante la búsqueda
            ex.printStackTrace();
            String mensaje = "error";
            response.sendRedirect("index.jsp?respuesta=" + mensaje);
        }
    }

    private void enviarCorreo(String correoDestino, Usuarios usuario, HttpServletResponse response, HttpServletRequest request) throws IOException {
        String correoOrigen = "peralta9513@gmail.com";
        String password = "ndok qjog axmf ynhd";

        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(correoOrigen, password);
            }
        });

        try {
            Message message = new MimeMessage(session);

            message.setFrom(new InternetAddress(correoOrigen));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(correoDestino));
            message.setSubject("Recuperación de contraseña");

            // Generar un token único para la URL de recuperación de contraseña
            String token = UUID.randomUUID().toString(); // Generar un UUID aleatorio como token único

            // Obtener la fecha y hora actual
            LocalDateTime now = LocalDateTime.now();

            // Convertir la fecha y hora actual a milisegundos
            long nowMillis = now.atZone(ZoneId.systemDefault()).toInstant().toEpochMilli();

            // Definir la validez del token en minutos (5 minuto en este caso)
            int validityMinutes = 5;

            // Calcular la fecha y hora de expiración del token
            long expirationMillis = nowMillis + (validityMinutes * 60 * 1000);

            // Crear la URL con el token y la fecha de expiración
            String url = "http://cits.com.co/SenaCarnet/vistas/olvidoContrasena.jsp?token=" + token
                    + "&cedula=" + usuario.getCedula() + "&expiration=" + expirationMillis;

            System.out.println("servlets.olvidoContrasenaServlet.enviarCorreo()" + url);

            // Construir el contenido del mensaje con la URL única
            String mensaje = "Hola,\n\nHemos recibido una solicitud para restablecer tu contraseña. "
                    + "Si no solicitaste esto, puedes ignorar este correo.\n\n"
                    + "Para cambiar tu contraseña, haz clic en el siguiente enlace:\n"
                    + "<a href=\"" + url + "\" rel=\"noopener\">Cambiar contraseña</a>"
                    + " Si tienes alguna pregunta, contáctanos.";

            message.setContent(mensaje, "text/html");

            // Enviar el correo electrónico
            Transport.send(message);

            // Redireccionar a la página de inicio con un mensaje de confirmación
            String mensajeRedireccion = "enviado";
            response.sendRedirect("index.jsp?respuesta=" + mensajeRedireccion);

        } catch (MessagingException e) {
            String mensaje = "errorEnvio";
            response.sendRedirect("index.jsp?respuesta=" + mensaje);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(olvidoContrasenaServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(olvidoContrasenaServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
