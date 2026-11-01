$Url = "https://github.com/Kitware/CMake/releases/download/v4.3.4/cmake-4.3.4-windows-x86_64.msi"
$Path = "$env:TEMP\cmake-4.3.4.msi"

Write-Host "Downloading CMake 4.3.4..." -ForegroundColor Cyan
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri $Url -OutFile $Path

Write-Host "Installing CMake silently..." -ForegroundColor Cyan
$Args = "/i `"$Path`" /qn /norestart ADD_CMAKE_TO_PATH=System"
Start-Process msiexec.exe -ArgumentList $Args -Wait -NoNewWindow

Remove-Item -Path $Path -Force
Write-Host "CMake installation completed successfully." -ForegroundColor Green

winget install --id Nvidia.CUDA


git subtree add --prefix=llama.cpp https://github.com/ggml-org/llama.cpp.git master --squash
cd llama.cpp
cmake -B build -DGGML_CUDA=ON
cmake --build build --config Release -j 8 # metade dos cores que você tem, para não travar a máquina
