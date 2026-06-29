require 'faker'

# Clear existing data
puts "Cleaning database..."
MessageTemplate.delete_all
Reminder.delete_all
Customer.delete_all
User.delete_all

# Create demo user
puts "Creating demo user..."
demo_user = User.create!(
  email: "demo@clientepro.com",
  password: "password123",
  business_name: "Barbería El Peluquero"
)

# Create message templates
puts "Creating message templates..."
templates = [
  {
    title: "Saludo inicial",
    content: "¡Hola {{nombre}}! 👋 Gracias por contactarnos. ¿En qué podemos ayudarte hoy?"
  },
  {
    title: "Recordatorio de cita",
    content: "¡Hola {{nombre}}! Te recordamos que tienes una cita con nosotros. ¿Confirmas tu asistencia? 😊"
  },
  {
    title: "Seguimiento post-servicio",
    content: "¡Hola {{nombre}}! ¿Cómo estuvo todo después de tu visita? Esperamos que hayas quedado satisfecho. ¡Gracias por preferirnos! 🙌"
  },
  {
    title: "Promoción especial",
    content: "¡Hola {{nombre}}! Tenemos una promoción especial para ti. 💈 20% de descuento en tu próximo servicio. ¿Te interesa?"
  },
  {
    title: "Reactivación cliente perdido",
    content: "¡Hola {{nombre}}! Hace tiempo que no te vemos por aquí. Queremos ofrecerte un descuento especial por tu regreso. 🎉"
  },
  {
    title: "Feliz cumpleaños",
    content: "¡Feliz cumpleaños {{nombre}}! 🎂🎉 Como regalo, te ofrecemos 15% de descuento en tu próximo servicio. ¡Te esperamos!"
  }
]

templates.each do |t|
  demo_user.message_templates.create!(t)
end

# Create 50 fake customers
puts "Creating 50 fake customers..."
statuses = Customer.statuses.keys
first_names = %w[
  Carlos María José Ana Juan Pedro Lucía Miguel Sofía Diego
  Laura Martín Valentina Andrés Camila Fernando Gabriela Pablo
  Florencia Nicolás Victoria Javier Antonella Rodrigo Martina
  Sebastián Abril Mateo Emilia Benjamín Isabella Santiago Julieta
  Alejandro Renata Emmanuel Luciana Daniela Thiago Valentina
  Matías Catalina Joaquín Agustina Felipe Jimena
]

paraguayan_phones = [
  "+595 981 123 %04d",
  "+595 982 456 %04d",
  "+595 983 789 %04d",
  "+595 984 321 %04d",
  "+595 985 654 %04d",
  "+595 986 987 %04d",
  "+595 987 111 %04d",
  "+595 988 222 %04d",
  "+595 989 333 %04d",
  "+595 971 444 %04d"
]

sample_notes = [
  "Cliente frecuente, siempre viene los sábados.",
  "Prefiere agendar por WhatsApp.",
  "Llamar antes de recordar cita.",
  "Le interesan promociones de fin de mes.",
  "Paga siempre en efectivo.",
  "Se quejó del precio la última vez.",
  "Vino recomendado por otro cliente.",
  "Le gusta recibir novedades por WhatsApp.",
  "Pide presupuesto antes de cada servicio.",
  nil, nil, nil, nil, nil
]

50.times do |i|
  name = first_names[i % first_names.length]
  phone_template = paraguayan_phones.sample
  phone = phone_template % [rand(1000..9999)]

  # Vary last_contact_date: some recent, some old, some nil
  last_contact = case rand(0..10)
  when 0..2 then nil
  when 3..5 then rand(1..20).days.ago.to_date
  when 6..8 then rand(25..60).days.ago.to_date
  else rand(61..180).days.ago.to_date
  end

  demo_user.customers.create!(
    name: name,
    phone: phone,
    status: statuses.sample,
    notes: sample_notes.sample,
    last_contact_date: last_contact
  )
end

# Create some reminders
puts "Creating reminders..."
customers = demo_user.customers.to_a

20.times do |i|
  customer = customers.sample
  remind_at = case rand(0..3)
  when 0 then rand(1..3).days.ago  # some overdue
  when 1 then rand(1..5).days.from_now # upcoming
  else Time.current + rand(1..48).hours # today/tomorrow
  end

  demo_user.reminders.create!(
    customer: customer,
    message: [
      "Llamar para confirmar cita",
      "Enviar promoción de la semana",
      "Seguimiento post-servicio",
      "Recordar cumpleaños del cliente",
      "Preguntar si necesita agendar",
      "Enviar catálogo de productos",
      "Saludar y ofrecer descuento"
    ].sample,
    remind_at: remind_at,
    done: [true, false, false].sample
  )
end

puts "✅ Seeds created successfully!"
puts "   Demo user: demo@clientepro.com / password123"
puts "   Customers: #{demo_user.customers.count}"
puts "   Reminders: #{demo_user.reminders.count}"
puts "   Templates: #{demo_user.message_templates.count}"