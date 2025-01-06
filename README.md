
# Prueba Final Desafío LATAM


### Pasos para ejecutar el proyecto

1. ####   *Requisitos previos*
*  *Cuenta de AWS*: Asegúrate de tener acceso a una cuenta de AWS con los permisos necesarios (para propósitos del proyecto, el usuario utilizado cuenta con permisos de administrador, es decir, *full access*).

* *GitHub Repository*: Clona el repositorio del proyecto desde GitHub.
  ```bash
    git clone https://github.com/demodogo/terraform-aws
    cd terraform-aws
  ```
* *Terraform*: Instala Terraform en tu máquina local (versión mínima: 1.5.0).

* *AWS CLI*: Instala y configura AWS CLI en tu máquina local con credenciales válidas.

* *GitHub Actions*: Configura los secretos requeridos en el repositorio para GitHub Actions:

  | Nombre  | Descripción                |
  | :--------  | :------------------------- |
  | `AWS_ACCESS_KEY_ID` | El key ID que obtienes de tu usuario *AWS*. |
  | `AWS_SECRET_ACCESS_KEY` | Secret Access Key que obtienes de tu usuario *AWS*. |
  | `SNYK_TOKEN` | Token de tu cuenta de *SNYK*, que puedes obtener desde tu perfil en su página web. |

  También debes configurar la siguiente variable:
  
  | Nombre  | Descripción                |
    | :--------  | :------------------------- |
    | `AWS_REGION` | La región de tu cuenta *AWS*. |
* *Terraform State Bucket*: Accede a la consola de *AWS* (desde tu perfil) y crea un *bucket S3* para almacenar el backend de *Terraform*.
    
* *Terraform State Blocking*: Accede a la consola de *AWS* (desde tu perfil) y crea una tabla con *Dynamo DB* para manejar el bloqueo remoto y prevenir cambios simultaneos que generen errores.

  *Para ambos recursos, es suficiente la configuración básica*

2. #### *Pasos para la ejecución*
* *Configura el backend en Terraform*: Edita el archivo *terraform/main.tf* para que el backend apunte a los servicios que creaste previamente en *AWS*:

  ```terraform
  terraform {
  backend "s3" {
    bucket         = <NOMBRE-DE-TU-BUCKET>
    key            = "terraform/terraform.tfstate"
    region         = <TU-REGIÓN-DE-AWS>
    dynamodb_table = <NOMBRE-DE-TU-TABLA>
    encrypt        = true
  }

#### Correr el proyecto de forma local

* *Inicializa Terraform*: Inicializa *Terraform* de manera local.
  Este paso es opcional. Para ejecutarlo debes generar *SSH Keys* en tu proyecto.


````
  cd terraform
````
Dentro de la carpeta, debes crear tus *claves SSH*
````
ssh-keygen -t rsa -b 4096 -f test_key
````
Asegúrate de usar exactamente el mismo nombre para la llave (*test_key*). Luego, en el archivo *terraform/main.tf* **descomenta** el último recurso *aws_key_pair*:
 ```terraform
  resource "aws_key_pair" "test_key" {
    key_name   = "test_key"
    public_key = file("${path.root}/test_key.pub")
  }
````
Inicializa *Terraform*:
````
  terraform init 
```` 
Corre *Terraform Plan* para visualizar los cambios:
````
  terraform plan -var "key_name=test_key"
```` 
Aplica los cambios con *Terraform Apply*:
````
  terraform apply -auto-approve -var "key_name=test_key" 
```` 

#### Correr el proyecto con las automatizaciones de *Github Actions*

* Luego de configurar el backend en *Terraform* (editar el archivo *terraform/main.tf* como se muestra en pasos anteriores), haz un push a la rama *main* de tu repositorio. Los *workflows* se ejecutarán automáticamente. En este caso los pasos para el run local no son necesarios.