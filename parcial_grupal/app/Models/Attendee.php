<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Attendee extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'first_name', 'last_name', 'email', 'phone', 'qr_code', 'event_id'
    ];

    // Relación con el evento
    public function event()
    {
        return $this->belongsTo(Event::class);
    }

    // Relación con los check-ins
    public function checkIns()
    {
        return $this->hasMany(CheckIn::class);
    }

    // Método para generar QR code (se llamaría al crear el asistente)
    public static function generateQrCode()
    {
        return Str::random(40) . time();
    }

    // Método para verificar si ha asistido
    public function hasCheckedIn()
    {
        return $this->checkIns()->exists();
    }
}
