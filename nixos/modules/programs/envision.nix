{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.envision;
in
{

  options = {
    programs.envision = {
      enable = lib.mkEnableOption "envision";

      package = lib.mkPackageOption pkgs "envision" { };
    };
  };

  config = lib.mkIf cfg.enable {
    services.udev = {
      enable = true;
      packages = with pkgs; [
        xr-hardware
      ];
    };

    environment.systemPackages = [ cfg.package ];
  };

  meta.maintainers = pkgs.envision.meta.maintainers;
}
