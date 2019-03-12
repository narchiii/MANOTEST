package=util-linux
$(package)_version=2.33
$(package)_download_path=https://mirrors.edge.kernel.org/pub/linux/utils/$(package)/v$($(package)_version)/
$(package)_file_name=$(package)-$($(package)_version).tar.xz
$(package)_sha256_hash=f261b9d73c35bfeeea04d26941ac47ee1df937bd3b0583e748217c1ea423658a

define $(package)_set_vars
  $(package)_config_opts=--disable-all-programs --enable-libuuid
endef

define $(package)_config_cmds
  $($(package)_autoconf)
endef

define $(package)_build_cmds
  $(MAKE)
endef

define $(package)_stage_cmds
  $(MAKE) DESTDIR=$($(package)_staging_dir) install
endef