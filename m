Return-Path: <bpf+bounces-2694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0697325EB
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 05:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7051C20A52
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 03:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A28B817;
	Fri, 16 Jun 2023 03:42:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8007EE
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 03:42:13 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AEE171F;
	Thu, 15 Jun 2023 20:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686886931; x=1718422931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NTvG5ctWBX4OunZFs++KWo1lWVv7MlP+75F3gJ11Noo=;
  b=EM2QXTrQ3Y/KNlDiBdNwY6z37UZ+QmifOYwLdRxT6ixZ3t0dYbyW6hVf
   VrpMq3D1Zcz1SomxOkRPFrF9lAZPEbMrTnQoQWDV3v3jocJrj3nRd5tsH
   dhuTKGhdfpruzbO6gdGXEsow9YVnXq05OHIojY6sYKJC+PXiVZudmIfmv
   Cjg6LGFXnrYH5KTbQh9a0JQpTBnxvYyoGJKR5u8Cfcl/pVq5BUFtY+MbQ
   5LZqdo6gAyodPvBJrcyJx0O040uzex4JOjhAAs/0RUKze5SFJ7y/R2oxH
   e5gLrl1JKVbAzdtG+vuaDk6v14VfkIvX6zlX+Gly0cEfSYfbFdk+lgyDP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425039553"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425039553"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 20:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="777988481"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="777988481"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2023 20:42:06 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qA0Le-0000lz-0R;
	Fri, 16 Jun 2023 03:42:06 +0000
Date: Fri, 16 Jun 2023 11:41:34 +0800
From: kernel test robot <lkp@intel.com>
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, paul@paul-moore.com,
	keescook@chromium.org, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, jannh@google.com,
	KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH v2 3/5] security: Replace indirect LSM hook calls with
 static calls
Message-ID: <202306161110.9jeDpzVN-lkp@intel.com>
References: <20230616000441.3677441-4-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616000441.3677441-4-kpsingh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi KP,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230615]
[also build test ERROR on v6.4-rc6]
[cannot apply to bpf-next/master bpf/master pcmoore-selinux/next linus/master v6.4-rc6 v6.4-rc5 v6.4-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/kernel-Add-helper-macros-for-loop-unrolling/20230616-080708
base:   next-20230615
patch link:    https://lore.kernel.org/r/20230616000441.3677441-4-kpsingh%40kernel.org
patch subject: [PATCH v2 3/5] security: Replace indirect LSM hook calls with static calls
config: m68k-randconfig-r001-20230615 (https://download.01.org/0day-ci/archive/20230616/202306161110.9jeDpzVN-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout next-20230615
        b4 shazam https://lore.kernel.org/r/20230616000441.3677441-4-kpsingh@kernel.org
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306161110.9jeDpzVN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0x20): undefined reference to `__SCT__lsm_static_call_binder_set_context_mgr_0'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0x30): undefined reference to `__SCT__lsm_static_call_binder_set_context_mgr_1'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0x40): undefined reference to `__SCT__lsm_static_call_binder_transaction_0'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0x50): undefined reference to `__SCT__lsm_static_call_binder_transaction_1'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0x60): undefined reference to `__SCT__lsm_static_call_binder_transfer_binder_0'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0x70): undefined reference to `__SCT__lsm_static_call_binder_transfer_binder_1'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0x80): undefined reference to `__SCT__lsm_static_call_binder_transfer_file_0'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0x90): undefined reference to `__SCT__lsm_static_call_binder_transfer_file_1'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0xa0): undefined reference to `__SCT__lsm_static_call_ptrace_access_check_0'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0xb0): undefined reference to `__SCT__lsm_static_call_ptrace_access_check_1'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0xc0): undefined reference to `__SCT__lsm_static_call_ptrace_traceme_0'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0xd0): undefined reference to `__SCT__lsm_static_call_ptrace_traceme_1'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0xe0): undefined reference to `__SCT__lsm_static_call_capget_0'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0xf0): undefined reference to `__SCT__lsm_static_call_capget_1'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0x100): undefined reference to `__SCT__lsm_static_call_capset_0'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0x110): undefined reference to `__SCT__lsm_static_call_capset_1'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0x120): undefined reference to `__SCT__lsm_static_call_capable_0'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0x130): undefined reference to `__SCT__lsm_static_call_capable_1'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0x140): undefined reference to `__SCT__lsm_static_call_quotactl_0'
>> m68k-linux-ld: security/security.o:(.data..ro_after_init+0x150): undefined reference to `__SCT__lsm_static_call_quotactl_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x160): undefined reference to `__SCT__lsm_static_call_quota_on_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x170): undefined reference to `__SCT__lsm_static_call_quota_on_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x180): undefined reference to `__SCT__lsm_static_call_syslog_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x190): undefined reference to `__SCT__lsm_static_call_syslog_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x1a0): undefined reference to `__SCT__lsm_static_call_settime_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x1b0): undefined reference to `__SCT__lsm_static_call_settime_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x1c0): undefined reference to `__SCT__lsm_static_call_vm_enough_memory_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x1d0): undefined reference to `__SCT__lsm_static_call_vm_enough_memory_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x1e0): undefined reference to `__SCT__lsm_static_call_bprm_creds_for_exec_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x1f0): undefined reference to `__SCT__lsm_static_call_bprm_creds_for_exec_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x200): undefined reference to `__SCT__lsm_static_call_bprm_creds_from_file_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x210): undefined reference to `__SCT__lsm_static_call_bprm_creds_from_file_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x220): undefined reference to `__SCT__lsm_static_call_bprm_check_security_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x230): undefined reference to `__SCT__lsm_static_call_bprm_check_security_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x240): undefined reference to `__SCT__lsm_static_call_bprm_committing_creds_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x250): undefined reference to `__SCT__lsm_static_call_bprm_committing_creds_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x260): undefined reference to `__SCT__lsm_static_call_bprm_committed_creds_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x270): undefined reference to `__SCT__lsm_static_call_bprm_committed_creds_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x280): undefined reference to `__SCT__lsm_static_call_fs_context_dup_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x290): undefined reference to `__SCT__lsm_static_call_fs_context_dup_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x2a0): undefined reference to `__SCT__lsm_static_call_fs_context_parse_param_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x2b0): undefined reference to `__SCT__lsm_static_call_fs_context_parse_param_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x2c0): undefined reference to `__SCT__lsm_static_call_sb_alloc_security_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x2d0): undefined reference to `__SCT__lsm_static_call_sb_alloc_security_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x2e0): undefined reference to `__SCT__lsm_static_call_sb_delete_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x2f0): undefined reference to `__SCT__lsm_static_call_sb_delete_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x300): undefined reference to `__SCT__lsm_static_call_sb_free_security_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x310): undefined reference to `__SCT__lsm_static_call_sb_free_security_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x320): undefined reference to `__SCT__lsm_static_call_sb_free_mnt_opts_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x330): undefined reference to `__SCT__lsm_static_call_sb_free_mnt_opts_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x340): undefined reference to `__SCT__lsm_static_call_sb_eat_lsm_opts_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x350): undefined reference to `__SCT__lsm_static_call_sb_eat_lsm_opts_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x360): undefined reference to `__SCT__lsm_static_call_sb_mnt_opts_compat_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x370): undefined reference to `__SCT__lsm_static_call_sb_mnt_opts_compat_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x380): undefined reference to `__SCT__lsm_static_call_sb_remount_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x390): undefined reference to `__SCT__lsm_static_call_sb_remount_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x3a0): undefined reference to `__SCT__lsm_static_call_sb_kern_mount_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x3b0): undefined reference to `__SCT__lsm_static_call_sb_kern_mount_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x3c0): undefined reference to `__SCT__lsm_static_call_sb_show_options_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x3d0): undefined reference to `__SCT__lsm_static_call_sb_show_options_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x3e0): undefined reference to `__SCT__lsm_static_call_sb_statfs_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x3f0): undefined reference to `__SCT__lsm_static_call_sb_statfs_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x400): undefined reference to `__SCT__lsm_static_call_sb_mount_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x410): undefined reference to `__SCT__lsm_static_call_sb_mount_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x420): undefined reference to `__SCT__lsm_static_call_sb_umount_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x430): undefined reference to `__SCT__lsm_static_call_sb_umount_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x440): undefined reference to `__SCT__lsm_static_call_sb_pivotroot_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x450): undefined reference to `__SCT__lsm_static_call_sb_pivotroot_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x460): undefined reference to `__SCT__lsm_static_call_sb_set_mnt_opts_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x470): undefined reference to `__SCT__lsm_static_call_sb_set_mnt_opts_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x480): undefined reference to `__SCT__lsm_static_call_sb_clone_mnt_opts_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x490): undefined reference to `__SCT__lsm_static_call_sb_clone_mnt_opts_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x4a0): undefined reference to `__SCT__lsm_static_call_move_mount_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x4b0): undefined reference to `__SCT__lsm_static_call_move_mount_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x4c0): undefined reference to `__SCT__lsm_static_call_dentry_init_security_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x4d0): undefined reference to `__SCT__lsm_static_call_dentry_init_security_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x4e0): undefined reference to `__SCT__lsm_static_call_dentry_create_files_as_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x4f0): undefined reference to `__SCT__lsm_static_call_dentry_create_files_as_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x500): undefined reference to `__SCT__lsm_static_call_path_unlink_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x510): undefined reference to `__SCT__lsm_static_call_path_unlink_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x520): undefined reference to `__SCT__lsm_static_call_path_mkdir_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x530): undefined reference to `__SCT__lsm_static_call_path_mkdir_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x540): undefined reference to `__SCT__lsm_static_call_path_rmdir_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x550): undefined reference to `__SCT__lsm_static_call_path_rmdir_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x560): undefined reference to `__SCT__lsm_static_call_path_mknod_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x570): undefined reference to `__SCT__lsm_static_call_path_mknod_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x580): undefined reference to `__SCT__lsm_static_call_path_truncate_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x590): undefined reference to `__SCT__lsm_static_call_path_truncate_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x5a0): undefined reference to `__SCT__lsm_static_call_path_symlink_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x5b0): undefined reference to `__SCT__lsm_static_call_path_symlink_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x5c0): undefined reference to `__SCT__lsm_static_call_path_link_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x5d0): undefined reference to `__SCT__lsm_static_call_path_link_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x5e0): undefined reference to `__SCT__lsm_static_call_path_rename_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x5f0): undefined reference to `__SCT__lsm_static_call_path_rename_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x600): undefined reference to `__SCT__lsm_static_call_path_chmod_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x610): undefined reference to `__SCT__lsm_static_call_path_chmod_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x620): undefined reference to `__SCT__lsm_static_call_path_chown_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x630): undefined reference to `__SCT__lsm_static_call_path_chown_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x640): undefined reference to `__SCT__lsm_static_call_path_chroot_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x650): undefined reference to `__SCT__lsm_static_call_path_chroot_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x660): undefined reference to `__SCT__lsm_static_call_path_notify_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x670): undefined reference to `__SCT__lsm_static_call_path_notify_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x680): undefined reference to `__SCT__lsm_static_call_inode_alloc_security_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x690): undefined reference to `__SCT__lsm_static_call_inode_alloc_security_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x6a0): undefined reference to `__SCT__lsm_static_call_inode_free_security_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x6b0): undefined reference to `__SCT__lsm_static_call_inode_free_security_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x6c0): undefined reference to `__SCT__lsm_static_call_inode_init_security_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x6d0): undefined reference to `__SCT__lsm_static_call_inode_init_security_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x6e0): undefined reference to `__SCT__lsm_static_call_inode_init_security_anon_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x6f0): undefined reference to `__SCT__lsm_static_call_inode_init_security_anon_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x700): undefined reference to `__SCT__lsm_static_call_inode_create_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x710): undefined reference to `__SCT__lsm_static_call_inode_create_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x720): undefined reference to `__SCT__lsm_static_call_inode_link_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x730): undefined reference to `__SCT__lsm_static_call_inode_link_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x740): undefined reference to `__SCT__lsm_static_call_inode_unlink_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x750): undefined reference to `__SCT__lsm_static_call_inode_unlink_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x760): undefined reference to `__SCT__lsm_static_call_inode_symlink_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x770): undefined reference to `__SCT__lsm_static_call_inode_symlink_1'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x780): undefined reference to `__SCT__lsm_static_call_inode_mkdir_0'
   m68k-linux-ld: security/security.o:(.data..ro_after_init+0x790): undefined reference to `__SCT__lsm_static_call_inode_mkdir_1'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

