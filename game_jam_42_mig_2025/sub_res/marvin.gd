extends Control
@onready var rich_text_label = $RichTextLabel
@onready var sound_player = $AudioStreamPlayer2D
@onready var marvin_sprite = $Marvin_sprite  # AnimatedSprite2D
var tamano_fuente = 5
var historia_texto_marvin = [
	"[font_size=" + str(tamano_fuente + 13) + "][color=Red](Transmitiendo...)[/color][/font_size]",
	"[font_size=" + str(tamano_fuente + 13) + "][color=Red](...)[/color][/font_size]",
	"[font_size=" + str(tamano_fuente + 13) + "][color=Blue]Comandante![/color][/font_size]",
	"[font_size=" + str(tamano_fuente + 13) + "][color=Red](...)[/color][/font_size]",
	"[font_size=" + str(tamano_fuente + 13) + "][color=Blue]Soy Marvin y seré su asistente de operaciones[/color][/font_size]",
	"[font_size=" + str(tamano_fuente + 13) + "][color=Blue]Por favor, siga mis instrucciones[/color][/font_size]",
	"[font_size=" + str(tamano_fuente + 13) + "][color=Red](...)[/color][/font_size]",
	"[font_size=" + str(tamano_fuente + 13) + "][color=red]Iniciando Protocolo de Combate...[/color][/font_size]",
	"[font_size=" + str(tamano_fuente + 13) + "][color=Red](...)[/color][/font_size]",
	"[font_size=" + str(tamano_fuente + 13) + "][color=Red]Haciendo click izquierdo sobre nuestro planeta seleccionará la mitad de su flota de combate[/color][/font_size]",
	"[font_size=" + str(tamano_fuente + 13) + "][color=Red]Luego seleccione su objetivo haciendo click sobre el planeta que desea atacar[/color][/font_size]",
	"[font_size=" + str(tamano_fuente + 13) + "][color=Red]Nuestras flotas atacarán después de esta acción[/color][/font_size]",
	"[font_size=" + str(tamano_fuente + 13) + "][color=Red](...)[/color][/font_size]",
	"[font_size=" + str(tamano_fuente + 13) + "][color=Blue]Bien hecho comandante! lo ha entendido...[/color][/font_size]",
	"[font_size=" + str(tamano_fuente + 13) + "][color=Blue]Ya estamos listos para liberar al universo de los Críptidos y expandir nuestro carnaval a cada rincón del espacio exterior[/color][/font_size]"
]
var indice_marvin = 0
var escribiendo = false
var tiempo_entre_letras = 0.05
var tiempo_acelerado = 0.01
func _ready():
	rich_text_label.bbcode_enabled = true
	sound_player = get_node("AudioStreamPlayer2D")
	if not sound_player.playing:
		sound_player.play()
	if marvin_sprite is AnimatedSprite2D:
		marvin_sprite.play()
	mostrar_texto_marvin()
# Mostrar el texto de Marvin en la interfaz
func mostrar_texto_marvin():
	if indice_marvin < historia_texto_marvin.size():
		escribiendo = true
		await escribir_texto(historia_texto_marvin[indice_marvin])
		escribiendo = false
		indice_marvin += 1
	else:
		get_tree().quit()  # Cerrar el juego tras el último mensaje
# Escribir el texto con retardo
func escribir_texto(texto):
	rich_text_label.text = texto
	await get_tree().create_timer(tiempo_entre_letras).timeout  # Esperamos el tiempo entre letras
# Capturar eventos del teclado y mouse
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		procesar_clic()
# Función para manejar clics y animaciones
func procesar_clic():
	if escribiendo:
		tiempo_entre_letras = tiempo_acelerado  # Acelerar escritura
	else:
		if indice_marvin < historia_texto_marvin.size():
			cambiar_frame_marvin()
			mostrar_texto_marvin()
		else:
			queue_free()  # Cerrar el juego al final
# Cambiar frame de Marvin en cada clic
func cambiar_frame_marvin():
	if marvin_sprite is AnimatedSprite2D:
		marvin_sprite.frame = (marvin_sprite.frame + 1) % marvin_sprite.sprite_frames.get_frame_count(marvin_sprite.animation)
