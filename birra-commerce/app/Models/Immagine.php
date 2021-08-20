<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Immagine extends Model
{
    use HasFactory;

    /**
     * Get the birra that owns the image
     */
    public function birra()
    {
        return $this->belongsTo(Birra::class, 'birra');
    }
}
