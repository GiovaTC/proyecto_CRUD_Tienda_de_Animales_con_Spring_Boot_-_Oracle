# Proyecto CRUD Tienda de Animales con Spring Boot + Oracle

<img width="203" height="193" alt="image" src="https://github.com/user-attachments/assets/acd0ce8a-579d-497b-a76e-797430d0bb13" />  

Proyecto completo listo para abrir en **IntelliJ (Java 21 + Maven)** que implementa un CRUD con **Spring Boot**,  
interfaz web con **Thymeleaf** y conexión a **Oracle** como base de datos.

<img width="2559" height="1040" alt="image" src="https://github.com/user-attachments/assets/1abd92f8-7e5f-4554-aa49-ef350227a99b" /> 

<img width="2558" height="1079" alt="image" src="https://github.com/user-attachments/assets/dafc23ec-b36c-4a36-b6d6-87d79708beec" />

<img width="2556" height="1079" alt="image" src="https://github.com/user-attachments/assets/1e00a552-14a8-42c1-9a60-60de8061ffea" />

Incluye:

- `pom.xml` con dependencia del driver Oracle (**ojdbc11**).
- Código Java (`entity`, `repository`, `service`, `controller`, aplicación).
- Templates **Thymeleaf** (`list`, `form`, `view`).
- `application.properties` listo para apuntar a tu Oracle.
- **DDL** (tabla + secuencia) para Oracle.

---

## 1) `pom.xml` (proyecto Maven)

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
           http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.example</groupId>
  <artifactId>petshop-oracle</artifactId>
  <version>0.0.1-SNAPSHOT</version>
  <packaging>jar</packaging>

  <name>petshop-oracle</name>

  <parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>3.2.1</version> <!-- compatible con Java 21 -->
    <relativePath/>
  </parent>

  <properties>
    <java.version>21</java.version>
    <maven.compiler.release>21</maven.compiler.release>
  </properties>

  <dependencies>
    <!-- Web + Thymeleaf -->
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-thymeleaf</artifactId>
    </dependency>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-web</artifactId>
    </dependency>

    <!-- Data JPA -->
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>

    <!-- Oracle JDBC (ojdbc11) -->
    <dependency>
      <groupId>com.oracle.database.jdbc</groupId>
      <artifactId>ojdbc11</artifactId>
      <version>21.9.0.0</version>
    </dependency>

    <!-- Validación -->
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-validation</artifactId>
    </dependency>

    <!-- DevTools (opcional) -->
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-devtools</artifactId>
      <scope>runtime</scope>
      <optional>true</optional>
    </dependency>

    <!-- Lombok opcional -->
    <dependency>
      <groupId>org.projectlombok</groupId>
      <artifactId>lombok</artifactId>
      <optional>true</optional>
    </dependency>
  </dependencies>

  <build>
    <plugins>
      <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
      </plugin>
    </plugins>
  </build>
</project>
2) Estructura del proyecto
css
Copiar código
petshop-oracle/
├─ src/
│  ├─ main/
│  │  ├─ java/
│  │  │  └─ com.example.petshop/
│  │  │     ├─ PetshopApplication.java
│  │  │     ├─ controller/PetController.java
│  │  │     ├─ model/Pet.java
│  │  │     ├─ repository/PetRepository.java
│  │  │     └─ service/PetService.java
│  │  ├─ resources/
│  │  │  ├─ templates/pets/{list.html,form.html,view.html}
│  │  │  └─ application.properties
├─ pom.xml
3) Código Java
PetshopApplication.java
java
Copiar código
package com.example.petshop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class PetshopApplication {
    public static void main(String[] args) {
        SpringApplication.run(PetshopApplication.class, args);
    }
}
model/Pet.java
java
Copiar código
package com.example.petshop.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import java.time.LocalDate;

@Entity
@Table(name = "PETS")
@SequenceGenerator(name = "pet_seq", sequenceName = "PETS_SEQ", allocationSize = 1)
public class Pet {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "pet_seq")
    private Long id;

    @NotBlank(message = "El nombre es obligatorio")
    @Column(nullable = false)
    private String name;

    private String species;
    private String breed;

    @Min(0)
    private Integer age;

    private Double price;

    @Column(length = 2000)
    private String description;

    private LocalDate birthDate;

    private String imageUrl;

    public Pet() {}
    // Getters y setters...
}
repository/PetRepository.java
java
Copiar código
package com.example.petshop.repository;

import com.example.petshop.model.Pet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PetRepository extends JpaRepository<Pet, Long> {
}
service/PetService.java
java
Copiar código
package com.example.petshop.service;

import com.example.petshop.model.Pet;
import com.example.petshop.repository.PetRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PetService {
    private final PetRepository repo;

    public PetService(PetRepository repo) {
        this.repo = repo;
    }

    public List<Pet> listAll() {
        return repo.findAll();
    }

    public Pet save(Pet pet) {
        return repo.save(pet);
    }

    public Optional<Pet> getById(Long id) {
        return repo.findById(id);
    }

    public void delete(Long id) {
        repo.deleteById(id);
    }
}
controller/PetController.java
java
Copiar código
package com.example.petshop.controller;

import com.example.petshop.model.Pet;
import com.example.petshop.service.PetService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/pets")
public class PetController {

    private final PetService service;

    public PetController(PetService service) {
        this.service = service;
    }

    @GetMapping
    public String list(Model model) {
        model.addAttribute("pets", service.listAll());
        return "pets/list";
    }

    @GetMapping("/new")
    public String createForm(Model model) {
        model.addAttribute("pet", new Pet());
        return "pets/form";
    }

    @PostMapping("/save")
    public String save(@Valid @ModelAttribute("pet") Pet pet, BindingResult result) {
        if (result.hasErrors()) {
            return "pets/form";
        }
        service.save(pet);
        return "redirect:/pets";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        return service.getById(id)
                .map(pet -> {
                    model.addAttribute("pet", pet);
                    return "pets/form";
                })
                .orElse("redirect:/pets");
    }

    @GetMapping("/view/{id}")
    public String view(@PathVariable Long id, Model model) {
        return service.getById(id)
                .map(pet -> {
                    model.addAttribute("pet", pet);
                    return "pets/view";
                })
                .orElse("redirect:/pets");
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        service.delete(id);
        return "redirect:/pets";
    }
}
4) Configuración application.properties
properties
Copiar código
server.port=8080
spring.mvc.view.prefix=/templates/
spring.mvc.view.suffix=.html

# Oracle datasource
spring.datasource.url=jdbc:oracle:thin:@//<ORACLE_HOST>:<PORT>/<SERVICE_NAME>
spring.datasource.username=TU_USUARIO
spring.datasource.password=TU_CONTRASENA
spring.datasource.driver-class-name=oracle.jdbc.driver.OracleDriver

# Hibernate / JPA
spring.jpa.database-platform=org.hibernate.dialect.Oracle12cDialect
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true
Ejemplo de URL Oracle:

arduino
Copiar código
jdbc:oracle:thin:@//db.mycompany.com:1521/ORCLCDB.localdomain
5) DDL Oracle (tabla + secuencia)
sql
Copiar código
-- Secuencia
CREATE SEQUENCE PETS_SEQ START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- Tabla
CREATE TABLE PETS (
  ID          NUMBER(19) PRIMARY KEY,
  NAME        VARCHAR2(200) NOT NULL,
  SPECIES     VARCHAR2(100),
  BREED       VARCHAR2(100),
  AGE         NUMBER(5),
  PRICE       NUMBER(18,2),
  DESCRIPTION VARCHAR2(2000),
  BIRTH_DATE  DATE,
  IMAGE_URL   VARCHAR2(1000)
);

-- (Opcional) permisos:
-- GRANT SELECT, INSERT, UPDATE, DELETE ON PETS TO TU_USUARIO;
6) Instrucciones para ejecutar en IntelliJ
Abre el proyecto en IntelliJ IDEA (File -> Open).

Configura JDK 21 en Project Structure y en la configuración de ejecución.

Ajusta application.properties con los datos correctos de conexión.

Ejecuta:

bash
Copiar código
mvn clean package
o directamente Run PetshopApplication desde IntelliJ.

Abre en el navegador:
http://localhost:8080/pets

7) Notas y buenas prácticas
El driver ojdbc11 está en Maven Central, compatible con Java 21.
En producción, evita spring.jpa.hibernate.ddl-auto=create/update.
Usa scripts SQL o migraciones (Flyway/Liquibase).
Cuidado con DATE vs TIMESTAMP en Oracle al usar LocalDate.
Si tu Oracle requiere SSL/TLS o wallets, agrega propiedades extra en el datasource.

8) Próximas ampliaciones posibles
Templates completos (list.html, form.html, view.html).
Usar IDENTITY en vez de secuencia si Oracle 12c+.
Integrar Flyway para migraciones automáticas.
Subida de imágenes (guardar en BLOB, filesystem o S3).
Configuración con profiles (application-dev.properties, application-prod.properties) .
