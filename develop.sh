if [ ! -d "riscv-tests" ]; then
    git clone https://github.com/nervosnetwork/riscv-tests
    cd riscv-tests
    git submodule update --init --recursive
    cd ..
fi

if [ "x$RISCV" = "x" ]
then
  echo "Please set the RISCV environment variable to your installed path."
  exit 1
fi

$RISCV/bin/riscv64-unknown-elf-gcc \
    -march=rv64g \
    -mabi=lp64 \
    -static \
    -mcmodel=medany \
    -fvisibility=hidden \
    -nostdlib \
    -nostartfiles \
    -Iriscv-tests/env/p \
    -Iriscv-tests/isa/macros/scalar \
    -Triscv-tests/env/p/link.ld \
    -o main \
    main.S
