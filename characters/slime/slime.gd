extends Node2D

func play_walk():
	%AnimationPlayer.play("walk")

func play_hurt():
	%AnimationPlayer.play("hurt")

func play_idle():
	%AnimationPlayer.play("idle")
