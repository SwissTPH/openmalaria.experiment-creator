# Run a test

DIR=$(dirname $0)
cd "$DIR" # because the experiment creator writes debug.log to the current dir

# delete output from a previous run
rm -rf $DIR/scenarios.csv $DIR/scenarios $DIR/debug.log

echo "-----  Generating experiment  -----"
java -jar "$DIR/../../build/experiment_creator.jar" --stddirs "$DIR" \
    --no-validation --seeds 1 --unique-seeds true --name CHOICEVIVAX || exit 1

echo ""
echo "-----  Testing output  -----"
if [ -f $DIR/debug.log ]; then
    echo "Debug output found in debug.log; contents:"
    cat $DIR/debug.log
    echo
fi
diff -qr $DIR/expected_output/scenarios $DIR/scenarios || exit 1
diff -qr $DIR/expected_output/scenarios.csv $DIR/scenarios.csv || exit 1

echo "Tests passed"
