<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Birra extends Model
{
    use HasFactory;

    /**
     * Get the images for the Birra.
     */
    public function images()
    {
        return $this->hasMany(Immagine::class);
    }
}
