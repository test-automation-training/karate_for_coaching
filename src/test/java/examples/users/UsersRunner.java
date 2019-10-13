package examples.users;

import com.intuit.karate.junit5.Karate;

class UsersRunner {

    @Karate.Test
    Karate testUsers() {
        // according to the name of file like *.feature, it will find the file and run it when using annotation Karate.Test
        // and relativeTo is must have
        return new Karate().feature("users").relativeTo(getClass());
    }

}
