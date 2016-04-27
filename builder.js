var ProtoBuf = require("protobufjs"),
    fs = require("fs"),
    util = require("util"),
    path = require("path");


var output_folder = './json_output'

var builder = ProtoBuf.newBuilder({convertFieldsToCamelCase: true});
ProtoBuf.loadProtoFile(path.resolve(process.argv[3]), builder);
var message = builder.build("edu.psu.cse.siis.ic3.Application");

var buffer = fs.readFileSync(process.argv[2]);

var mymsg = message.decode(buffer);


if (!fs.existsSync(output_folder)){
    fs.mkdirSync(output_folder);
}
var output = output_folder + '/' + path.basename(process.argv[2], '.dat') + '.json'

fs.writeFileSync(output, util.inspect(mymsg, true, null, true, false) , 'utf-8');

//console.log(util.inspect(mymsg, showHidden=false, depth=2, colorize=true));