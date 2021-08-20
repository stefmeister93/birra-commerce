<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBirrasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('birras', function (Blueprint $table) {
            $table->id();
            $table->string("nome",255);
            $table->string("colore",64);
            $table->string("marchio",128);
            $table->string("tipo",96)->nullable();
            $table->string("stato_provenienza",128);
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
        Schema::dropIfExists('birras');
    }
}
