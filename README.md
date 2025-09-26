# Terraform AWS EC2 Instance Module

Este módulo ("brick") se encarga de provisionar una instancia de AWS EC2 siguiendo las mejores prácticas de seguridad, como el cifrado de volúmenes EBS y la exigencia de IMDSv2 por defecto.

## Usage

A continuación se muestra un ejemplo básico de cómo utilizar el módulo para lanzar una instancia en la VPC por defecto de tu cuenta de AWS.

```hcl
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = "us-east-1a"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

module "app_server" {
  source = "[github.com/your-org/terraform-aws-ec2-instance](https://github.com/your-org/terraform-aws-ec2-instance)"
  # O la ruta local: source = "../"

  instance_name = "MyWebAppServer"
  ami_id        = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  subnet_id     = data.aws_subnet.default.id

  tags = {
    Environment = "Development"
    Project     = "WebApp"
  }
}
```

## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | >= 1.3.0 |
| aws       | ~> 5.0  |

## Inputs

| Name                           | Description                                                                                    | Type         | Default | Required |
| ------------------------------ | ---------------------------------------------------------------------------------------------- | ------------ | ------- | :------: |
| `ami_id`                       | El ID de la AMI a utilizar para la instancia.                                                  | `string`     | n/a     |   yes    |
| `instance_name`                | El nombre de la instancia EC2, se usará en la etiqueta "Name".                                 | `string`     | n/a     |   yes    |
| `instance_type`                | El tipo de instancia a utilizar.                                                               | `string`     | n/a     |   yes    |
| `subnet_id`                    | El ID de la subred donde se lanzará la instancia.                                              | `string`     | n/a     |   yes    |
| `associate_public_ip_address`  | Si es `true`, la instancia tendrá una dirección IP pública.                                    | `bool`       | `false` |    no    |
| `ebs_optimized`                | Si es `true`, la instancia se lanza como optimizada para EBS.                                  | `bool`       | `false` |    no    |
| `iam_instance_profile_name`    | El nombre del perfil de instancia IAM a asociar con la instancia.                              | `string`     | `null`  |    no    |
| `instance_metadata_tags_enabled` | Si las etiquetas de metadatos de la instancia EC2 están habilitadas.                           | `bool`       | `false` |    no    |
| `key_name`                     | El nombre del par de claves a utilizar para la instancia.                                      | `string`     | `null`  |    no    |
| `kms_key_id_for_ebs`           | El ARN de la clave KMS a usar para el cifrado de EBS. Si no se especifica, se usa la clave por defecto de AWS. | `string`     | `null`  |    no    |
| `monitoring`                   | Si es `true`, la instancia tendrá habilitado el monitoreo detallado.                             | `bool`       | `false` |    no    |
| `root_volume_size`             | El tamaño del volumen raíz en gigabytes.                                                       | `number`     | `8`     |    no    |
| `root_volume_type`             | El tipo de volumen raíz.                                                                       | `string`     | `"gp3"` |    no    |
| `tags`                         | Un mapa de etiquetas para asignar al recurso.                                                  | `map(string)`| `{}`    |    no    |
| `user_data_base64`             | Los datos de usuario para la instancia, codificados en base64.                                 | `string`     | `null`  |    no    |
| `vpc_security_group_ids`       | Una lista de IDs de grupos de seguridad para asociar con la instancia.                         | `list(string)`| `[]`    |    no    |

## Outputs

| Name                         | Description                                                     |
| ---------------------------- | --------------------------------------------------------------- |
| `arn`                        | El ARN de la instancia EC2.                                     |
| `instance_id`                | El ID de la instancia EC2.                                      |
| `primary_network_interface_id`| El ID de la interfaz de red primaria.                           |
| `private_ip`                 | La dirección IP privada asignada a la instancia.                |
| `public_ip`                  | La dirección IP pública asignada a la instancia, si aplica.     |

