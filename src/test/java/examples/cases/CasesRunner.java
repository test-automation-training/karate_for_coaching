package examples.cases;

import com.intuit.karate.junit5.Karate;

public class CasesRunner {
    @Karate.Test
    Karate testCases() {
        return new Karate().feature("cases").relativeTo(getClass());
    }
}
