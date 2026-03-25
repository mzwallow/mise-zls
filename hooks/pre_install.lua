-- Helper function for platform detection (uncomment and modify as needed)
local function get_platform()
    -- RUNTIME object is provided by mise/vfox
    -- RUNTIME.osType: "Windows", "Linux", "Darwin"
    -- RUNTIME.archetype: "amd64", "386", "arm64", etc.

    local os_name = RUNTIME.osType:lower()
    local arch = RUNTIME.archType

    -- Map to your tool's platform naming convention
    -- Adjust these mappings based on how your tool names its releases
    local platform_map = {
        ["linux"] = {
            ["386"] = "x86-linux",
            ["amd64"] = "x86_64-linux",
            ["arm"] = "arm-linux",
            ["arm64"] = "aarch64-linux",
            ["riscv64"] = "riscv64-linux",
        },
        ["darwin"] = {
            ["amd64"] = "x86_64-macos",
            ["arm64"] = "aarch64-macos",
        },
        ["windows"] = {
            ["386"] = "x86-windows",
            ["amd64"] = "x86_64-windows",
            ["arm64"] = "aarch64-windows",
        },
    }

    local os_map = platform_map[os_name]
    if os_map then
        return os_map[arch] or "x86_64-linux" -- fallback
    end

    -- Default fallback
    return "x86_64-linux"
end

--- Returns download information for a specific version
--- Documentation: https://mise.jdx.dev/tool-plugin-development.html#preinstall-hook
--- @param ctx {version: string, runtimeVersion: string} Context
--- @return table Version and download information
function PLUGIN:PreInstall(ctx)
    local version = ctx.version
    -- ctx.runtimeVersion contains the full version string if needed

    if version == "master" then
        return {
            version = version,
            url = "https://github.com/zigtools/zls/archive/refs/heads/master.tar.gz",
            note = "Downloading zls source from master branch",
        }
    end

    -- Example 1: Simple binary download
    -- local url = "https://github.com/<GITHUB_USER>/<GITHUB_REPO>/releases/download/v" .. version .. "/<TOOL>-linux-amd64"

    -- Example 2: Platform-specific binary
    local platform = get_platform() -- Uncomment the helper function below
    local url = "https://github.com/zigtools/zls/releases/download/" .. version .. "/zls-" .. platform .. ".tar.xz"

    -- Example 3: Archive (tar.gz, zip) - mise will extract automatically
    -- local url = "https://github.com/<GITHUB_USER>/<GITHUB_REPO>/releases/download/v" .. version .. "/<TOOL>-" .. version .. "-linux-amd64.tar.gz"

    -- Example 4: Raw file from repository
    -- local url = "https://raw.githubusercontent.com/<GITHUB_USER>/<GITHUB_REPO>/" .. version .. "/bin/<TOOL>"

    -- Replace with your actual download URL pattern
    -- local url = "https://example.com/<TOOL>/releases/download/" .. version .. "/<TOOL>"

    -- Optional: Fetch checksum for verification
    -- local sha256 = fetch_checksum(version) -- Implement if checksums are available

    return {
        version = version,
        url = url,
        -- sha256 = sha256, -- Optional but recommended for security
        note = "Downloading zls " .. version,
        -- addition = { -- Optional: download additional components
        --     {
        --         name = "component",
        --         url = "https://example.com/component.tar.gz"
        --     }
        -- }
    }
end
