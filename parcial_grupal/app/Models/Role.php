<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'description'];

    // Relación muchos a muchos con usuarios
    public function users()
    {
        return $this->belongsToMany(User::class, 'user_roles');
    }

    // Relación muchos a muchos con permisos
    public function permissions()
    {
        return $this->belongsToMany(Permission::class, 'role_permissions');
    }
}