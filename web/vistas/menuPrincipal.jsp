<%@page import="entidades.Formacion"%>
<%@page import="java.util.List"%>
<%@page import="controladores.FormacionJpaController"%>
<%@page import="entidades.Usuarios"%>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Menu Principal</title>
        <link rel="stylesheet" href="../css/Menu.css"/>
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
        <link href= "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous" >
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

        <% HttpSession sesion = request.getSession();

            Usuarios usuario = (Usuarios) sesion.getAttribute("user");

            if (usuario == null) {
                response.sendRedirect("../index.jsp");
            } else {

            }

            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
            response.setHeader("Pragma", "no-cache"); // HTTP 1.0
            response.setHeader("Expires", "0"); // Proxies
        %>

        <script>
            function verReporte3() {
                // Obtener el valor seleccionado en el select
                var codigoFormacion = document.getElementById("idFormacion").value;

                // Redirigir al enlace con el ID seleccionado como par�metro
                window.open("<%= request.getContextPath()%>/reportes/reporteFormacion.jsp?idFormacion=" + codigoFormacion, "_blank");
            }
        </script>
    </head>
    <body  style="background-color: #fefafb;">

        <%--MENU INICIO --%>
        <nav class="navbar text-l navbar-expand-lg " style="background-color: #6acd56;">
            <div class="container d-flex justify-content-center align-items-center">

                <div class="col-md-2 col-12 text-center ">

                    <img class="" src="../img/inicioSesion_sena.jpg" alt="" height="80px" width="80px">

                </div>
                <div class="col-md-2 col-12 text-center">
                    <h2 class="mt-3 letras"> SENA </h2>
                </div>
                <div class="col-md-8 col-12 text-center">
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false"
                            aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse mt-2" id="navbarNavDropdown">
                        <ul class="navbar-nav ms-auto navbar-brand">

                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Aprendiz
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="estudiantes.jsp">Ingresar</a></li>
                                    <li><a class="dropdown-item" href="carnetEliminado.jsp">Carnet Eliminado</a></li>
                                </ul>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link" href="administrador.jsp">Administrador</a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link" href="coordinadorDatos.jsp">Coordinador</a>
                            </li>
                            <li class="nav-item ">
                                <a class="nav-link" href="sedesFormaciones.jsp">Sede-Formacion</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Menu Principal</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="cerrarSesionAdministrador.jsp">Salir</a>
                            </li>
                        </ul>
                    </div>
                </div>

            </div>
        </nav>
        <%--MENU FINAL --%>

        <%--CONTENIDO INICIO --%>
        <div class="container text-center ">
            <h1 class="letra text-center pt-3 pb-3">Bienvenido:  <%if (usuario != null) {
                    out.print(usuario.getNombres());

                }%> </h1>
            <div class="row ">
                <div class="col-lg-3 col-sd-12 d-flex align-items-center justify-content-center ">
                    <div class="card mb-5" data-aos="flip-left"
                         data-aos-easing="ease-out-cubic"
                         data-aos-duration="2000">
                        <div class="card-details">
                            <div><img src="../img/menu_estudiantes" width="210px" height="200px" alt="alt"/></div>
                            <h3>Aprendiz</h3>
                        </div>
                        <a href="estudiantes.jsp"><button class="card-button" >ENTRAR</button></a>
                    </div>
                </div>
                <div class="col-lg-3 col-sd-12 d-flex align-items-center justify-content-center ">
                    <div class="card mb-5" data-aos="flip-left"
                         data-aos-easing="ease-out-cubic"
                         data-aos-duration="2000">
                        <div class="card-details">
                            <div><img src="../img/menu_administrador.jpg" width="210px" height="200px" alt="alt"/></div>
                            <h3>Administrador</h3>
                        </div>
                        <a href="administrador.jsp"> <button class="card-button">ENTRAR</button></a>
                    </div>
                </div>
                <div class="col-lg-3  col-sd-12 d-flex align-items-center justify-content-center">
                    <div class="card mb-5" data-aos="flip-left"
                         data-aos-easing="ease-out-cubic"
                         data-aos-duration="2000">
                        <div class="card-details">
                            <div><img src="../img/menu-coordinador.jpg" width="210px" height="200px" alt="alt"/></div>
                            <h3>Coordinador</h3>
                        </div>
                        <a href="coordinadorDatos.jsp"><button class="card-button">ENTRAR</button></a>
                    </div>
                </div>
                <div class="col-lg-3  col-sd-12 d-flex align-items-center justify-content-center">
                    <div class="card mb-5" data-aos="flip-left"
                         data-aos-easing="ease-out-cubic"
                         data-aos-duration="2000">
                        <div class="card-details">
                            <div><img src="../img/menu_sedes.jpeg" width="210px" height="200px" alt="alt"/></div>
                            <h3>Sede-Formacion</h3>
                        </div>
                        <a href="sedesFormaciones.jsp"><button class="card-button">ENTRAR</button></a>
                    </div>
                </div>
            </div>  
        </div>
        <%--CONTENIDO FINAL --%>
        <h2 class="letra   text-center">Reporte de Carnet y Cambio de Logo</h2>
        <div class="container mb-5">  
            <div class="row">
                <div class="col-lg-6 col-sd-12 ">
                    <p><h4 class="text-center">Bienvenido..!!</h4> Aqu� puedes buscar y visualizar los reportes de los carnets generados para las diferentes formaciones. Utiliza el men� desplegable para seleccionar la formaci�n de tu inter�s y ver los carnets asociados a esa formaci�n.
                    Una vez seleccionada la formaci�n, podr�s descargar los carnets necesarios para su uso. 
                    </p>

                    <div class="card" data-aos="flip-left"
                         data-aos-easing="ease-out-cubic"
                         data-aos-duration="2000">
                        <div class="card-details">
                            <div><img src="../img/menu_carnet.webp" width="300px" height="150px" alt="alt"/></div>
                            <h3 class="text-center">Carnet por Formacion</h3>
                        </div>
                        <div class="col-12">
                            <div class="input-group mb-3 ">
                                <div class="input-group-text col-5"><b>Nombre:</b></div>
                                <select name="idFormacion" id="idFormacion"
                                        class="from-selec col-7"  >

                                    < <%
                                        FormacionJpaController controF = new FormacionJpaController();
                                        List listaC = controF.findFormacionEntities();

                                        for (int i = 0; i < listaC.size(); i++) {
                                            Formacion form = (Formacion) listaC.get(i);
                                            out.print("<option value='" + form.getIdFormacion() + "'>");
                                            out.print(form.getNombre());
                                            out.print("</option>");
                                        }
                                    %>
                                </select>
                            </div>
                            <a href="" onclick="verReporte3()"><button class="card-button">ENTRAR</button></a>

                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-sd-12 ">
                    <p>
                    <h4 class="text-center">Actualizar Datos del Logo</h4>
                    Para acceder al formulario de actualizaci�n, por favor haz clic en el bot�n <b>"Formulario"</b>.
                    <br><br>
                    En este formulario, puedes actualizar la imagen del logo, la imagen de la firma y el nombre del director. Por favor, selecciona los archivos de imagen deseados y proporciona el nuevo nombre del director.
                    <br><br>
                    <strong>Instrucciones:</strong>
                    <ul>
                        <li>Imagen del Logo: Selecciona la nueva imagen del logo.</li>
                        <li>Imagen de la Firma: Selecciona la nueva imagen de la firma.</li>
                        <li>Nombre del Director: Ingresa el nuevo nombre del director en el campo correspondiente.</li>
                    </ul>
                    Una vez completado, haz clic en el bot�n "Actualizar" para guardar los cambios.
                    </p>

                    <form action="<%=request.getContextPath()%>" method="post" class="pt-2">
                        <div class="input-group mb-2">
                            <div class="input-group-text col-md-5 col-sd-12"><b>Actualizar Datos del Logo</b></div>
                            <button id="editarBtnFormaciones" type="button" class="btn " style="background-color: #6acd56;" data-bs-toggle="modal" data-bs-target="#formulario3Modallogo"><b>Formulario</b></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <footer class="py-3 mt-2 text-center" style="background-color: #6acd56;">
            <div class="row">
                <div class="col-lg-4 col-md-6 col-sd-6 pt-3">
                    <img src="../img/icon_facebook.png" alt="alt"/>
                    <a  href="http://www.facebook.com">Facebook</a><br>
                    <img src="../img/icon_instagram.png" alt="alt"/>
                    <a href="http://www.instagram.com">Instagram</a><br>
                    <img src="../img/icon_github.png" alt="alt"/>
                    <a href="https://github.com/Crystian9513">Github</a>
                </div>
                <div class="col-lg-8 col-md-6 col-sd-6">

                    <h5 class="pt-2">Copyright <%= java.time.LocalDate.now().getYear()%>
                        Crystian Jesus Peralta Arias y Sebastian Navaja.<br>
                        Desarrollador Web.
                    </h5>
                    <h6>Telefono: +57 300 7836674 </h6>
                    <h6>Correo: crystian_9513@hotmail.com</h6>

                </div>
            </div>
        </footer>

        <!-- MODALE GUARDAR INICIO -->
        <div class="modal fade" id="formulario3Modallogo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <form action="<%=request.getContextPath()%>/LogoServlet" method="post" class="row g-2 "  enctype="multipart/form-data">
                            <h2 class="pt-5 pb-4 text-center">Actualizar</h2>

                            <input type="hidden" class="form-control" id="id" name="id" required min="1" maxlength="45" value="14" readonly>


                            <div class="col-12">
                                <div class="input-group input-group-sm">
                                    <div class="input-group-text col-6"><b>Logo:</b></div>
                                    <input type="file" class="form-control" id="logo" name="logo" accept="image/*" >
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="input-group input-group-sm">
                                    <div class="input-group-text col-6"><b>Nombre Completo:</b></div>
                                    <input type="text" class="form-control" id="nombre" name="nombre"  maxlength="45">
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="input-group input-group-sm">
                                    <div class="input-group-text col-6"><b>Firma:</b></div>
                                    <input type="file" class="form-control" id="firma" name="firma" accept="image/*" >
                                </div>
                            </div>
                            <div class="col-12 text-center py-5 pt-5"><!-- bottones -->
                                <button type="submit" class="btn botones  px-4"
                                        value="Guardar" name="action" style="background-color: #6acd56;"><b>Actualizar</b></button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" >Cerrar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- MODALE GUARDAR FINAL -->

        <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
        <script>AOS.init();</script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    </body>
</html>

<%
    String mensaje = request.getParameter("respuesta");

    if (mensaje != null) {

        switch (mensaje) {
            case "guardado":
%>
<script>
                                Swal.fire(
                                        '�Exito!',
                                        '�Guardado!',
                                        'success'
                                        );
</script>
<%
        break;
    case "Erroraleditar":
%>
<script>
    Swal.fire(
            '�Oops!',
            '�Error al Actualizar!',
            'warning'
            );
</script>
<%break;
            default:
                throw new AssertionError();
        }
    }

%>