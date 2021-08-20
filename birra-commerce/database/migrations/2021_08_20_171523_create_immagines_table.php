<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateImmaginesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('immagines', function (Blueprint $table) {
            $table->id();
            $table->string("url",1024);
            $table->boolean("immagine_vetrina");
            $table->foreign('birra_id') // attributo birra_id
                    ->references('id')  // si riferisce alla chiave primaria (id)
                    ->on('birras')      // sulla tabella "birras"
                    ->onCascade('delete');  // elimina tutte le immagini relative a una birra
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('immagines');
    }
}
