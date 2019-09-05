const readline = require('readline')

const { calculate } = require('abacus-calculator')

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
})

rl.setPrompt('abacus> ')
rl.prompt()

rl.on('line', function(line) {
  switch (line.trim()) {
    case ':q':
      rl.close()
      break
    default:
      console.log(calculate(line))
      break
  }
  rl.prompt()
}).on('close', function() {
  process.exit(0)
})
