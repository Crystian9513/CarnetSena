<%@page import="entidades.Usuarios"%>
<%@page import="entidades.Usuarios"%>
<%@page import="java.util.List"%>
<%@page import="entidades.Administrador"%>
<%@page import="controladores.AdministradorJpaController"%>
<!DOCTYPE html>
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
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Administrador</title>
        <link rel="stylesheet" href="../css/tabla.css"/>
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
        <link href= "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous" >
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

        <script>
            // Espera a que el DOM est� completamente cargado
            document.addEventListener("DOMContentLoaded", function () {
                // Encuentra todos los elementos con el atributo data-bs-toggle="popover"
                var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));

                // Itera sobre cada elemento y crea un nuevo objeto Popover para �l
                var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
                    return new bootstrap.Popover(popoverTriggerEl);
                });
            });
        </script>

        <script>
            function obtenerDatosAdministradores(Cedula, Nombre, Apellido, Correo, Fotografia) {
                $('#cedula2').val(Cedula);
                $('#nombre2').val(Nombre);
                $('#apellido2').val(Apellido);
                $('#correo2').val(Correo);
                // Construir la URL completa de la foto
                var fotoUrl = window.location.origin + '../fotos/' + Fotografia;
                $('#foto2_url').text(fotoUrl);
            }

        </script>


    </head>
    <body  style="background-color: #fefafb;">

        <%--MENU INICIO --%>
        <nav class="navbar text-l navbar-expand-lg " style="background-color: #6acd56;">
            <div class="container">

                <div class="row">

                    <div class="col-md-2">
                        
                            <img class="" src="../img/inicioSesion_sena.jpg" alt="" height="80px" width="80px">
                        
                    </div>

                    <div class="col-md-2 text-center">
                        <h2 class="mt-3 letras"> SENA </h2>
                    </div>
                    <div class="col-md-8">
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
                                    <a class="nav-link" href="#">Administrador</a>
                                </li>
                                <li class="nav-item ">
                                    <a class="nav-link" href="coordinadorDatos.jsp">Coordinador</a>
                                </li>
                                <li class="nav-item ">
                                    <a class="nav-link" href="sedesFormaciones.jsp">Sede-Formacion</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="menuPrincipal.jsp">Menu Principal</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="cerrarSesionAdministrador.jsp">Salir</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
        <%--MENU FINAL --%>

        <%--CONTENIDO INICIO --%>
        <div class="container">
            <div class="row">
                <div class="col-12">

                    <h1 class="letra text-center pt-3 pb-3">Informacion de Administrador</h1>

                    <div class="container">
                        <div class="row">
                            <div class="col-md-6 col-sd-12">
                                <form action="<%=request.getContextPath()%>" method="post" class="pt-2">
                                    <div class="input-group mb-2">
                                        <div class="input-group-text col-md-8 col-sd-12"><b>Nuevo administrador:</b></div>
                                        <button id="" type="button" class="btn" style="background-color: #6acd56;" data-bs-toggle="modal" data-bs-target="#formularioModal"><b>Formulario</b></button>
                                    </div>
                                </form>
                            </div>
                            <div class="col-md-6 col-sd-12">
                                <form action="<%=request.getContextPath()%>" method="post" class="pt-2">
                                    <div class="input-group mb-2">
                                        <div class="input-group-text col-4"><b>Buscar:</b></div>
                                        <input type="text" class="form-control" id="filtro1">
                                    </div>
                                </form>
                            </div>

                        </div>
                    </div>

                    <section class="intro mb-2">
                        <div class="bg-image" >
                            <div class="mask d-flex align-items-center h-100">
                                <div class="container">
                                    <div class="row justify-content-center" data-aos="zoom-in"  data-aos-duration="500">
                                        <div class="col-12"> 
                                            <div class="card-body p-0 ">
                                                <%--TABLA INICIO --%>
                                                <div class="table-responsive table-scroll table-sm" data-mdb-perfect-scrollbar="true" style="position: relative; height: 210px">
                                                    <table id="tablaAdministradores" class="table table-striped table-sm  mb-0 text-center ">
                                                        <thead class="" style="background-color: #263642;">
                                                            <tr class="text-light">
                                                                <th scope="col">Cedula</th>
                                                                <th scope="col">Nombres</th>
                                                                <th scope="col">Apellidos</th>
                                                                <th scope="col">Correo</th>
                                                                <th scope="col">Fotografia</th>
                                                                <th scope="col">Opcines</th>

                                                            </tr>
                                                        </thead>
                                                        <tbody>

                                                            <%
                                                                AdministradorJpaController controlador = new AdministradorJpaController();
                                                                List<Administrador> admin = controlador.findAdministradorEntities();

                                                                if (admin.isEmpty()) {


                                                            %>

                                                            <tr>
                                                                <td colspan="9" class="text-center">No se encontraron Administradores en la base de datos.</td>
                                                            </tr>
                                                            <%                                                                } else {

                                                                for (Administrador adm : admin) {


                                                            %>
                                                            <tr>
                                                                <td> <%= adm.getCedula()%> </td>
                                                                <td> <%= adm.getNombre()%></td>
                                                                <td> <%= adm.getApellido()%> </td>
                                                                <td> <%= adm.getCorreo()%> </td>
                                                                <td> 
                                                                    <!-- Utiliza el atributo data-bs-html="true" para que el contenido del popover se interprete como HTML -->
                                                                    <span class="d-inline-block" tabindex="0" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-html="true"
                                                                          data-bs-content='<img src="<%= adm.getFotografia()%>" width="120px" height="120px">'
                                                                          <button class="btn btn-primary btn-md fw-bold" type="button" disabled>Foto</button>
                                                                    </span>
                                                                </td>

                                                                <td> 
                                                                    <button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" 
                                                                            data-bs-target="#formularioModal2" onclick="obtenerDatosAdministradores('<%= adm.getCedula()%>',
                                                                                            '<%= adm.getNombre()%>',
                                                                                            '<%= adm.getApellido()%>',
                                                                                            '<%= adm.getCorreo()%>',
                                                                                            '<%= adm.getFotografia()%>')" >
                                                                        Opciones
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                            <%
                                                                    }

                                                                }
                                                            %>
                                                        </tbody>
                                                    </table>
                                                    <%--CONTENIDO FINAL --%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                </div>
            </div>  
        </div>
        <%--CONTENIDO FINAL --%>

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
                        Crystian Jesus Peralta Arias y Sebastian Navaja. <br>
                        Desarrollador Web.
                    </h5>
                    <h6>Telefono: +57 300 7836674 </h6>
                    <h6>Correo: crystian_9513@hotmail.com</h6>
                </div>
            </div>
        </footer>

        <!-- MODALES DE SEDES GUARDAR INICIO -->
        <div class="modal fade" id="formularioModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <form action="<%=request.getContextPath()%>/administradoresServlet" method="post" class="row g-2 "
                              enctype="multipart/form-data">
                            <h2 class="pt-5 pb-4 text-center">Registrar Administrador</h2>

                            <div class="col-12">
                                <div class="input-group">
                                    <div class="input-group-text col-5"><b>Cedula:</b></div>

                                    <input type="number" class="form-control" id="cedula" name="cedula" required min="1" max="999999999999">
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="input-group">
                                    <div class="input-group-text col-5"><b>Nombres:</b></div>

                                    <input type="text" class="form-control" id="nombre" name="nombre" required min="1" maxlength="40">
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="input-group">
                                    <div class="input-group-text col-5"><b>Apellidos:</b></div>

                                    <input type="text" class="form-control" id="apellido" name="apellido" required min="1" maxlength="40">
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="input-group">
                                    <div class="input-group-text col-5"><b>Clave:</b></div>

                                    <input type="text" class="form-control" id="clave" name="clave" required min="1" maxlength="20">
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="input-group input-group">
                                    <div class="input-group-text col-5"><b>Correo: </b></div>
                                    <input type="email" class="form-control" id="correo" name="correo" required min="1" maxlength="45">
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="input-group input-group">
                                    <div class="input-group-text col-5"><b>Fotografia:</b></div>
                                    <input type="file" class="form-control" id="foto" name="foto" accept="image/*" required>
                                </div>
                            </div>
                            <div class="col-12 text-center py-5 pt-5"><!-- bottones -->
                                <button type="submit" class="btn botones  px-4"
                                        value="Guardar" name="action" style="background-color: #6acd56;"><b>Guardar</b></button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" >Cerrar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- MODALES DE SEDES GUARDAR FINAL -->
        <!-- MODALES DE SEDES GUARDAR INICIO -->
        <div class="modal fade" id="formularioModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <form action="<%=request.getContextPath()%>/administradoresServlet" method="post" class="row g-2 " enctype="multipart/form-data">
                            <h2 class="pt-5 pb-4 text-center">Administrador</h2>

                            <div class="col-12">
                                <div class="input-group">
                                    <div class="input-group-text col-5"><b>Cedula:</b></div>

                                    <input type="number" class="form-control" id="cedula2" name="cedula2" required min="1" max="999999999999" readonly>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="input-group">
                                    <div class="input-group-text col-5"><b>Nombres:</b></div>

                                    <input type="text" class="form-control" id="nombre2" name="nombre2" required min="1" maxlength="45">
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="input-group">
                                    <div class="input-group-text col-5"><b>Apellidos:</b></div>

                                    <input type="text" class="form-control" id="apellido2" name="apellido2" required min="1" maxlength="45">
                                </div>
                            </div>  
                            <div class="col-12">
                                <div class="input-group input-group">
                                    <div class="input-group-text col-5"><b>Correo: </b></div>
                                    <input type="email" class="form-control" id="correo2" name="correo2" required min="1" maxlength="45">
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="input-group input-group">
                                    <div class="input-group-text col-6"><b>Fotografia:</b></div>

                                    <input type="file" class="form-control" id="foto2" name="foto2" accept="image/*" >

                                </div>
                            </div>
                            <div class="col-12 text-center py-5 pt-5"><!-- bottones -->
                                <button type="submit" class="btn botones  px-4"
                                        name="action" value="Editar" style="background-color: #6acd56;"><b>Actualizar</b></button>
                                <button type="submit" class="btn " name="action" value="Eliminar" style="background-color: #6acd56;"><b>Eliminar</b></button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- MODALES DE SEDES GUARDAR FINAL -->

        <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
        <script>AOS.init();</script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="link">
                                                                                const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')
                                                                                const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl))
        </script> 
    </body>
</html>

<%
    String mensaje = request.getParameter("respuesta");

    if (mensaje != null) {

        switch (mensaje) {
            case "existe":
%>
<script>
    Swal.fire(
            '�Oops!',
            '�La cedula ya existe en la base de datos!',
            'warning'
            );
</script>
<%
        break;
    case "guardado":
%>
<script>
    Swal.fire(
            '��xito!',
            '�El administrador ha sido guardado!',
            'success'
            );
</script>
<%
        break;
    case "errorAlguardar":
%>
<script>
    Swal.fire(
            '�Oops!',
            '�Error al guardar!',
            'warning'
            );
</script>
<%
        break;
    case "eliminado":
%>
<script>
    Swal.fire(
            '��xito!',
            '�El administrador ha sido eliminado!',
            'success'
            );
</script>
<%
        break;
    case "editado":
%>
<script>
    Swal.fire(
            '��xito!',
            '�El estudiante ha sido actualizado!',
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

<script>
    const filtroInput = document.getElementById("filtro1");
    const filas = document.querySelectorAll("#tablaAdministradores tbody tr");
    filtroInput.addEventListener("input", function () {
        const filtro = filtroInput.value.trim().toLowerCase();
        filas.forEach(function (fila) {
            const textoFila = fila.textContent.toLowerCase();
            if (textoFila.includes(filtro)) {
                fila.style.display = "";
            } else {
                fila.style.display = "none";
            }
        });
    });</script>
