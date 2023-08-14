local packages = {
    'ruff',
    'mypy',
    'black',
}

local registry = require("mason-registry")

for i, pack in pairs(packages) do

    if not registry.is_installed(pack) then
        local package = registry.get_package(pack)
        package:install()
    end

end
