<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * Show the profile for a given user.
     */
	
   /*public function show(string $id): View
    {
        return view('user.profile', [
            'user' => User::findOrFail($id)
        ]);
   }*/

    public function index($id)
    {
        #$user = User::find($id);
	echo '111111';
        #return $user;
    }

}
