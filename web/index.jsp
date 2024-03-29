<%@page import="entidades.Estudiantes"%>
<%@page import="controladores.EstudiantesJpaController"%>
<%@page import="entidades.Usuarios"%>
<%@page import="controladores.UsuariosJpaController"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inicio de Sesion</title>
        <link rel="stylesheet" href="css/estilo.css"/>
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">

    </head>
    <body>
        <div class="login-page">
            <div class="container">
                <div class="row ">
                    <div class="col-lg-10 offset-lg-1 ">
                        <div class="bg-white shadow rounded bg-light bg-opacity-75">
                            <div class="row">
                                <div class="col-md-6 pe-0">
                                    <h1 class="letra pt-5 text-center">Inicio de Sesion</h1>
                                    <div class="form-left h-100 py-4 px-5">
                                        <form action="" class="row g-4">
                                            <div class="col-12">
                                                <label class=""><strong>Numero de Cedula </strong><span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <div class="input-group-text"><i class="bi bi-person-fill"></i></div>
                                                    <input type="number" id="numero" name="numero" class="form-control"
                                                           placeholder="Numero de Cedula" required min="1" max="999999999999">
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label><strong>Contrase�a</strong><span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <div class="input-group-text"><i class="bi bi-lock-fill"></i></div>
                                                    <input type="password" id="clave" name="clave" class="form-control"
                                                           placeholder="Contrase�a" required min="1" maxlength="25">
                                                </div>
                                            </div>
                                            <div class="col-12 ">
                                                <a href="#" class="float-end text-primary " data-bs-toggle="modal" data-bs-target="#formularioModal2" > 
                                                    <strong>Olvido su Contrase�a? </strong> 
                                                </a>
                                            </div>
                                            <div class="col-12 d-flex justify-content-center align-items-center">
                                                <button type="submit" name="btninicio" class="btn mx-auto mt-2" style="background-color: #6acd56;"
                                                        >
                                                    <strong>Iniciar Sesion </strong></button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <img data-aos="flip-left"
                                         data-aos-easing="ease-out-cubic"
                                         data-aos-duration="2000" src="img/sesion.jpg" class="img-fluid" />
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>


        <!-- MODALES INICIO -->
        <div class="modal fade" id="formularioModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <form action="<%=request.getContextPath()%>/olvidoContrase_aServlet" method="post" class="row g-2 ">
                            <h2 class="pt-2 pb-1 text-center">Olvido su Contrase�a</h2>
                            <h6 class="">Ingrese su numero de cedula, y se le enviara un Link a su correo para poder cambiar su contrase�a. <br> </h6>
                            <div class="col-12">
                                <div class="input-group">
                                    <div class="input-group-text col-5"><b>Cedula:</b></div>

                                    <input type="number" class="form-control" id="cedula2" name="cedula2" required min="1" max="999999999999">
                                </div>
                            </div>

                            <div class="col-12 text-center py-3 pt-3"><!-- bottones -->
                                <button type="submit" class="btn botones  px-4"
                                        name="action" value="Enviar" style="background-color: #6acd56;"><b>Enviar</b></button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- MODALE FINAL -->

        <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
        <script>AOS.init();</script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>
</html>


<%
    String boton = request.getParameter("btninicio");

    if (boton != null) {
        Integer cedula = Integer.parseInt(request.getParameter("numero"));
        String clave = request.getParameter("clave");

        // Verificamos si existe un usuario con la misma c�dula en la base de datos
        UsuariosJpaController usuarioController = new UsuariosJpaController();
        Usuarios usuario = usuarioController.findUsuarios(cedula);

        if (usuario == null) {
            // Si el usuario no existe, redirigimos a la p�gina de inicio de sesi�n con un mensaje de error
            String mensaje = "documentoNoExiste";
            response.sendRedirect("index.jsp?respuesta=" + mensaje);
        } else {
            // Si el usuario existe, obtenemos el rol y la contrase�a
            int rol = usuario.getRol();
            int estadoClave = usuario.getEstadoClave();
            String contrase�aUsuario = usuario.getClaves(); // Obtener la contrase�a del usuario

            // Verificamos si la contrase�a coincide con la almacenada en la base de datos
            if (usuarioController.DencryptarClave(contrase�aUsuario, clave)) {

                // Verificamos el rol y el estado de la clave para redirigir correctamente
                if (rol == 1) {
                    // Si el usuario tiene rol 1, verificamos el estado de la clave
                    if (estadoClave == 1) {
                        HttpSession sessionActual = request.getSession();
                        sessionActual.setAttribute("estudiante", usuario);
                        // Si la clave est� en estado 1, redirigimos a la p�gina de cambio de contrase�a
                        String mensaje = "cambioClavesPrimeraVez";
                        response.sendRedirect("vistas/cambioContrasenaUsuario.jsp?respuesta=" + mensaje);
                    } else {
                        // Si la clave no est� en estado 1, redirigimos a la p�gina de usuario
                        HttpSession sessionActual = request.getSession();
                        sessionActual.setAttribute("estudiante", usuario);
                        response.sendRedirect("vistas/usuario.jsp");
                    }
                } else if (rol == 2) {
                    // Si el usuario tiene rol 2, lo redirigimos al men� principal
                    HttpSession sessionActual = request.getSession();
                    sessionActual.setAttribute("user", usuario);
                    response.sendRedirect("vistas/menuPrincipal.jsp");
                } else if (rol == 3) {
                    // Si el usuario tiene rol 3, lo redirigimos a otra p�gina
                    HttpSession sessionActual = request.getSession();
                    sessionActual.setAttribute("coordinador", usuario);
                    response.sendRedirect("vistas/coordinador.jsp");
                } else {
                    // Si el usuario tiene otro rol, redirigimos a la p�gina de inicio de sesi�n con un mensaje de error
                    String mensaje = "usuarioSinAcceso";
                    response.sendRedirect("index.jsp?respuesta=" + mensaje);
                }
            } else {
                // Si la contrase�a no coincide, redirigimos a la p�gina de inicio de sesi�n con un mensaje de error
                String mensaje = "conIncorrecta";
                response.sendRedirect("index.jsp?respuesta=" + mensaje);
            }
        }
    }
%>


<%
    String mensaje2 = request.getParameter("respuesta");

    if (mensaje2
            != null) {
        switch (mensaje2) {
            case "documentoNoExiste":
%>
<script>
            Swal.fire(
                    '�Oops!',
                    '�La cedula no existe!',
                    'warning'
                    );
</script>
<%
        break;
    case "usuarioSinAcceso":
%>
<script>
    Swal.fire(
            '�Oops!',
            '�Carnet Eliminado!',
            'warning'
            );
</script>
<%
        break;
    case "conIncorrecta":
%>
<script>
    Swal.fire(
            '�Oops!',
            '�Contrase�a Incorrecta!',
            'warning'
            );
</script>
<%
        break;
    case "noCedula":
%>
<script>
    Swal.fire(
            '�Oops!',
            '�No existe la cedula en la base de datos !',
            'warning'
            );
</script>

<%
        break;
    case "enviado":
%>
<script>
    Swal.fire(
            '�Exito!',
            '�Correo enviado!',
            'success'
            );
</script>
<%
        break;
    case "contrase�aNuevaGuardada":
%>
<script>
    Swal.fire(
            '�Exito!',
            '�Correo enviado!',
            'success'
            );
</script>
<%
        break;
    case "error":
%>
<script>
    Swal.fire(
            '�Oops!',
            '�Error!',
            'warning'
            );
</script>
<%
                break;
            default:

        }
    }
%>

