package pl.trojczak.pulsar.function;

import java.util.Collections;

import org.apache.pulsar.common.functions.FunctionConfig;
import org.apache.pulsar.functions.LocalRunner;

class SimpleFunctionTest {

    private static final String FUNCTION_NAME = "simple-function";
    private static final String INPUT_TOPIC = "persistent://rtk/test/simple-input";
    private static final String OUTPUT_TOPIC = "persistent://rtk/test/simple-output";

    public static void main(String[] args) throws Exception {
        FunctionConfig functionConfig = new FunctionConfig();
        functionConfig.setName(SimpleFunction.class.getSimpleName());
        functionConfig.setInputs(Collections.singletonList(INPUT_TOPIC));
        functionConfig.setSubName(FUNCTION_NAME);
        functionConfig.setOutput(OUTPUT_TOPIC);
        functionConfig.setClassName(SimpleFunction.class.getName());
        functionConfig.setRuntime(FunctionConfig.Runtime.JAVA);

        LocalRunner localRunner = LocalRunner.builder().functionConfig(functionConfig).build();
        localRunner.start(false);
    }
}