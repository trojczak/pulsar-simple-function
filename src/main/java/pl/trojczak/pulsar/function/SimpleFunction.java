package pl.trojczak.pulsar.function;

import org.apache.pulsar.functions.api.Context;
import org.apache.pulsar.functions.api.Function;

public class SimpleFunction implements Function<String, String> {

    @Override
    public String process(String input, Context context) {
        System.out.println(input);
        return input;
    }
}