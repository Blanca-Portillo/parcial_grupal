<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'name', 'description', 'start_date', 'end_date', 
        'location', 'type', 'status', 'organizer_id'
    ];

    protected $casts = [
        'start_date' => 'datetime',
        'end_date' => 'datetime',
    ];

    // Relación con el organizador (usuario)
    public function organizer()
    {
        return $this->belongsTo(User::class, 'organizer_id');
    }

    // Relación con los asistentes
    public function attendees()
    {
        return $this->hasMany(Attendee::class);
    }

    // Método para contar asistentes registrados
    public function registeredAttendeesCount()
    {
        return $this->attendees()->count();
    }

    // Método para contar asistentes que han hecho check-in
    public function checkedInAttendeesCount()
    {
        return $this->attendees()->has('checkIns')->count();
    }
}