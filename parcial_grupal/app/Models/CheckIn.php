<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CheckIn extends Model

{
    use HasFactory;

    protected $fillable = ['attendee_id', 'check_in_time', 'checked_by'];

    protected $casts = [
        'check_in_time' => 'datetime',
    ];

    // Relación con el asistente
    public function attendee()
    {
        return $this->belongsTo(Attendee::class);
    }
}
