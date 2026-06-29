# ClientePro 🚀

CRM simple para pequeños negocios que venden por WhatsApp (barberías, talleres, tiendas de Instagram, etc.).

## Stack

- **Backend:** Ruby on Rails 8.1
- **Base de datos:** PostgreSQL
- **Frontend:** Hotwire (Turbo + Stimulus)
- **Auth:** Devise
- **UI:** TailwindCSS 4

## Requisitos

- Ruby 3.4+
- PostgreSQL 17+
- Node.js (para importmaps)

## Instalación

```bash
# 1. Clonar el repositorio
git clone <repo-url> cliente_pro
cd cliente_pro

# 2. Instalar dependencias
bundle install

# 3. Configurar base de datos
rails db:create
rails db:migrate

# 4. Cargar datos de prueba (50 clientes, 6 plantillas, 20 recordatorios)
rails db:seed

# 5. Compilar TailwindCSS (primera vez)
rails tailwindcss:build

# 6. Iniciar servidor
bin/dev
# o
rails server
```

## Acceso Demo

```
Email:    demo@clientepro.com
Password: password123
```

## Funcionalidades

### ✅ Dashboard
- Total de clientes
- Clientes por estado (Nuevo, Interesado, Frecuente, Perdido)
- Clientes que necesitan seguimiento (>30 días sin contacto)
- Próximos recordatorios
- Clientes recientes

### ✅ Clientes (CRUD)
- Crear, editar, eliminar clientes
- Filtrar por estado
- Buscar por nombre o teléfono
- Vista detalle con:
  - Botón "Abrir WhatsApp"
  - Botón "Copiar mensaje" desde plantillas (con variables {{nombre}}, {{telefono}})
  - Estado de seguimiento
  - Notas del cliente

### ✅ Recordatorios
- Crear recordatorios asociados a un cliente
- Vista de pendientes, vencidos y completados
- Marcar como completado con un clic

### ✅ Plantillas de Mensajes
- Crear plantillas con variables dinámicas
- Botón "Copiar al portapapeles"
- Uso directo desde la vista del cliente

### ✅ Configuración
- Editar perfil del negocio
- Información de suscripción (preparado para dLocal / PagoPar)
- Eliminar cuenta

### ✅ Multi-tenant
Cada usuario ve solo sus propios datos (clientes, recordatorios, plantillas).

## Estructura del Proyecto

```
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb    # Auth + multi-tenant
│   │   ├── dashboard_controller.rb      # Dashboard
│   │   ├── customers_controller.rb      # CRUD clientes
│   │   ├── reminders_controller.rb      # CRUD recordatorios
│   │   ├── message_templates_controller.rb
│   │   └── settings_controller.rb       # Perfil + suscripción
│   ├── models/
│   │   ├── user.rb                      # Devise + suscripción
│   │   ├── customer.rb                  # Cliente con scopes
│   │   ├── reminder.rb                  # Recordatorio
│   │   └── message_template.rb          # Plantilla
│   ├── views/
│   │   ├── dashboard/                   # Dashboard con métricas
│   │   ├── customers/                   # CRUD + detalle + WhatsApp
│   │   ├── reminders/                   # Lista + formulario
│   │   ├── message_templates/           # Grid de plantillas
│   │   └── settings/                    # Configuración
│   └── javascript/controllers/
│       ├── sidebar_controller.js        # Menú responsive
│       ├── clipboard_controller.js      # Copiar al portapapeles
│       └── notification_controller.js   # Notificaciones auto
├── db/
│   └── seeds.rb                         # 50 clientes + datos demo
└── config/
    └── routes.rb
```

## Próximos Pasos (Arquitectura Lista)

- [ ] Integración pagos dLocal / PagoPar
- [ ] Planes de suscripción (Gratuito, Premium)
- [ ] Exportar clientes a CSV
- [ ] Importar contactos desde WhatsApp
- [ ] API REST para integraciones