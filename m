Return-Path: <bpf+bounces-15433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC92C7F2055
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D004B1C21872
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF5E3A27F;
	Mon, 20 Nov 2023 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUgVX7cT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39332116;
	Mon, 20 Nov 2023 14:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700519333; x=1732055333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MdsssRTEob1Hm13/gBHFDxmBhg91YTkHQMpmH14tqPU=;
  b=lUgVX7cTnDguQ2mL2UBtXQoeBZ4inrdqL4qLV7rapCl0w++K1Cr55f9k
   0B9vdr/k2n5QWgbWUmJ0BeHMx9Uaz2sN3cFtsM0wzo97qtfa1QyUDQSoM
   NU21yHoK9RgSzAx0qDzjZkaqQc1VoEAGcE6UKdKDWKWu934U9SNkcYomh
   mk+g64XGz25ip+O7R/py13W+PYn+hlvP58UpH5KQSpIchBgzZX5Goj2pO
   Lfs8h7+7usoDQU+r0WgGQ2krQF0E8iKcSNDPn9EwCZ7rG5SYNjQY5add5
   jBnbEVBNDAOMK8kt+fLVEqfjLTr/3PcQwf71Z4XIfsJE8ryodrijPZVhW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="10390852"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="10390852"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 14:28:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="759908909"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="759908909"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 20 Nov 2023 14:28:47 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5Cl3-00070S-1R;
	Mon, 20 Nov 2023 22:28:45 +0000
Date: Tue, 21 Nov 2023 06:28:09 +0800
From: kernel test robot <lkp@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Paul Moore <paul@paul-moore.com>,
	Kees Cook <keescook@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>, renauld@google.com,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 4/4] LSM: Add a LSM module which handles dynamically
 appendable LSM hooks.
Message-ID: <202311210652.jzysT4DZ-lkp@intel.com>
References: <34be5cd8-1fdd-4323-82a3-40f2e7d35db3@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34be5cd8-1fdd-4323-82a3-40f2e7d35db3@I-love.SAKURA.ne.jp>

Hi Tetsuo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf/master]
[also build test WARNING on pcmoore-audit/next pcmoore-selinux/next linus/master v6.7-rc2]
[cannot apply to bpf-next/master next-20231120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tetsuo-Handa/LSM-Auto-undef-LSM_HOOK-macro/20231120-214522
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/34be5cd8-1fdd-4323-82a3-40f2e7d35db3%40I-love.SAKURA.ne.jp
patch subject: [PATCH 4/4] LSM: Add a LSM module which handles dynamically appendable LSM hooks.
config: arm64-randconfig-002-20231121 (https://download.01.org/0day-ci/archive/20231121/202311210652.jzysT4DZ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210652.jzysT4DZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311210652.jzysT4DZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> security/security.c:822: warning: Incorrect use of kernel-doc format:  * security_binder_transaction() - Check if a binder transaction is allowed
>> security/security.c:832: warning: Incorrect use of kernel-doc format:  * security_binder_transfer_binder() - Check if a binder transfer is allowed
>> security/security.c:842: warning: Incorrect use of kernel-doc format:  * security_binder_transfer_file() - Check if a binder file xfer is allowed
>> security/security.c:853: warning: Incorrect use of kernel-doc format:  * security_ptrace_access_check() - Check if tracing is allowed
>> security/security.c:868: warning: Incorrect use of kernel-doc format:  * security_ptrace_traceme() - Check if tracing is allowed
>> security/security.c:879: warning: Incorrect use of kernel-doc format:  * security_capget() - Get the capability sets for a process
>> security/security.c:894: warning: Incorrect use of kernel-doc format:  * security_capset() - Set the capability sets for a process
>> security/security.c:908: warning: Incorrect use of kernel-doc format:  * security_capable() - Check if a process has the necessary capability
>> security/security.c:922: warning: Incorrect use of kernel-doc format:  * security_quotactl() - Check if a quotactl() syscall is allowed for this fs
>> security/security.c:934: warning: Incorrect use of kernel-doc format:  * security_quota_on() - Check if QUOTAON is allowed for a dentry
>> security/security.c:943: warning: Incorrect use of kernel-doc format:  * security_syslog() - Check if accessing the kernel message ring is allowed
>> security/security.c:954: warning: Incorrect use of kernel-doc format:  * security_settime64() - Check if changing the system time is allowed
>> security/security.c:964: warning: Function parameter or member 'ts' not described in 'security_settime64'
>> security/security.c:964: warning: Function parameter or member 'tz' not described in 'security_settime64'
>> security/security.c:964: warning: expecting prototype for security_binder_set_context_mgr(). Prototype was for security_settime64() instead
>> security/security.c:1020: warning: Incorrect use of kernel-doc format:  * security_bprm_creds_from_file() - Update linux_binprm creds based on file
>> security/security.c:1040: warning: Incorrect use of kernel-doc format:  * security_bprm_check() - Mediate binary handler search
>> security/security.c:1052: warning: expecting prototype for security_bprm_creds_for_exec(). Prototype was for security_bprm_check() instead
>> security/security.c:1075: warning: Incorrect use of kernel-doc format:  * security_bprm_committed_creds() - Tidy up after cred install during exec()
>> security/security.c:1087: warning: Incorrect use of kernel-doc format:  * security_fs_context_submount() - Initialise fc->security
   security/security.c:1097: warning: Incorrect use of kernel-doc format:  * security_fs_context_dup() - Duplicate a fs_context LSM blob
   security/security.c:1109: warning: Incorrect use of kernel-doc format:  * security_fs_context_parse_param() - Configure a filesystem context
   security/security.c:1122: warning: Function parameter or member 'fc' not described in 'security_fs_context_parse_param'
   security/security.c:1122: warning: Function parameter or member 'param' not described in 'security_fs_context_parse_param'
   security/security.c:1122: warning: expecting prototype for security_bprm_committing_creds(). Prototype was for security_fs_context_parse_param() instead
   security/security.c:1169: warning: Incorrect use of kernel-doc format:  * security_sb_free() - Free a super_block LSM blob
   security/security.c:1176: warning: expecting prototype for security_sb_delete(). Prototype was for security_sb_free() instead
   security/security.c:1206: warning: Function parameter or member 'security_sb_eat_lsm_opts' not described in 'EXPORT_SYMBOL'
   security/security.c:1206: warning: expecting prototype for security_sb_eat_lsm_opts(). Prototype was for EXPORT_SYMBOL() instead
   security/security.c:1218: warning: Function parameter or member 'security_sb_mnt_opts_compat' not described in 'EXPORT_SYMBOL'
   security/security.c:1218: warning: expecting prototype for security_sb_mnt_opts_compat(). Prototype was for EXPORT_SYMBOL() instead
   security/security.c:1230: warning: Function parameter or member 'security_sb_remount' not described in 'EXPORT_SYMBOL'
   security/security.c:1230: warning: expecting prototype for security_sb_remount(). Prototype was for EXPORT_SYMBOL() instead
   security/security.c:1242: warning: Incorrect use of kernel-doc format:  * security_sb_show_options() - Output the mount options for a superblock
   security/security.c:1252: warning: Incorrect use of kernel-doc format:  * security_sb_statfs() - Check if accessing fs stats is allowed
   security/security.c:1262: warning: Incorrect use of kernel-doc format:  * security_sb_mount() - Check permission for mounting a filesystem
   security/security.c:1280: warning: Incorrect use of kernel-doc format:  * security_sb_umount() - Check permission for unmounting a filesystem
   security/security.c:1290: warning: Incorrect use of kernel-doc format:  * security_sb_pivotroot() - Check permissions for pivoting the rootfs
   security/security.c:1300: warning: Incorrect use of kernel-doc format:  * security_sb_set_mnt_opts() - Set the mount options for a filesystem
   security/security.c:1314: warning: Function parameter or member 'mnt_opts' not described in 'security_sb_set_mnt_opts'
   security/security.c:1314: warning: Function parameter or member 'kern_flags' not described in 'security_sb_set_mnt_opts'
   security/security.c:1314: warning: Function parameter or member 'set_kern_flags' not described in 'security_sb_set_mnt_opts'
   security/security.c:1314: warning: expecting prototype for security_sb_kern_mount(). Prototype was for security_sb_set_mnt_opts() instead
   security/security.c:1332: warning: Function parameter or member 'security_sb_clone_mnt_opts' not described in 'EXPORT_SYMBOL'
   security/security.c:1332: warning: expecting prototype for security_sb_clone_mnt_opts(). Prototype was for EXPORT_SYMBOL() instead
   security/security.c:1345: warning: Incorrect use of kernel-doc format:  * security_path_notify() - Check if setting a watch is allowed
   security/security.c:1357: warning: Incorrect use of kernel-doc format:  * security_inode_alloc() - Allocate an inode LSM blob
   security/security.c:1367: warning: Function parameter or member 'inode' not described in 'security_inode_alloc'
   security/security.c:1367: warning: expecting prototype for security_move_mount(). Prototype was for security_inode_alloc() instead
   security/security.c:1425: warning: Function parameter or member 'security_dentry_init_security' not described in 'EXPORT_SYMBOL'
   security/security.c:1425: warning: expecting prototype for security_dentry_init_security(). Prototype was for EXPORT_SYMBOL() instead
   security/security.c:1442: warning: Function parameter or member 'security_dentry_create_files_as' not described in 'EXPORT_SYMBOL'
   security/security.c:1442: warning: expecting prototype for security_dentry_create_files_as(). Prototype was for EXPORT_SYMBOL() instead
   security/security.c:1539: warning: Incorrect use of kernel-doc format:  * security_path_mknod() - Check if creating a special file is allowed
   security/security.c:1552: warning: Function parameter or member 'dir' not described in 'security_path_mknod'
   security/security.c:1552: warning: Function parameter or member 'dentry' not described in 'security_path_mknod'
   security/security.c:1552: warning: Function parameter or member 'mode' not described in 'security_path_mknod'
   security/security.c:1552: warning: Function parameter or member 'dev' not described in 'security_path_mknod'
   security/security.c:1552: warning: expecting prototype for security_inode_init_security_anon(). Prototype was for security_path_mknod() instead
   security/security.c:1736: warning: Incorrect use of kernel-doc format:  * security_inode_create() - Check if creating a file is allowed
   security/security.c:1747: warning: Function parameter or member 'dir' not described in 'security_inode_create'
   security/security.c:1747: warning: Function parameter or member 'dentry' not described in 'security_inode_create'
   security/security.c:1747: warning: Function parameter or member 'mode' not described in 'security_inode_create'
   security/security.c:1747: warning: expecting prototype for security_path_chroot(). Prototype was for security_inode_create() instead
   security/security.c:2204: warning: Incorrect use of kernel-doc format:  * security_inode_killpriv() - The setuid bit is removed, update LSM state
   security/security.c:2216: warning: Incorrect use of kernel-doc format:  * security_inode_getsecurity() - Get the xattr security label of an inode
   security/security.c:2234: warning: Function parameter or member 'idmap' not described in 'security_inode_getsecurity'
   security/security.c:2234: warning: Function parameter or member 'inode' not described in 'security_inode_getsecurity'
   security/security.c:2234: warning: Function parameter or member 'name' not described in 'security_inode_getsecurity'
   security/security.c:2234: warning: Function parameter or member 'buffer' not described in 'security_inode_getsecurity'
   security/security.c:2234: warning: Function parameter or member 'alloc' not described in 'security_inode_getsecurity'
   security/security.c:2234: warning: expecting prototype for security_inode_need_killpriv(). Prototype was for security_inode_getsecurity() instead
   security/security.c:2319: warning: Incorrect use of kernel-doc format:  * security_inode_copy_up() - Create new creds for an overlayfs copy-up op
   security/security.c:2330: warning: Function parameter or member 'security_inode_copy_up' not described in 'EXPORT_SYMBOL'
   security/security.c:2330: warning: expecting prototype for security_inode_getsecid(). Prototype was for EXPORT_SYMBOL() instead
   security/security.c:2377: warning: Incorrect use of kernel-doc format:  * security_file_permission() - Check file permissions
   security/security.c:2396: warning: Function parameter or member 'file' not described in 'security_file_permission'
   security/security.c:2396: warning: Function parameter or member 'mask' not described in 'security_file_permission'
   security/security.c:2396: warning: expecting prototype for security_kernfs_init_security(). Prototype was for security_file_permission() instead
   security/security.c:2459: warning: Function parameter or member 'security_file_ioctl' not described in 'EXPORT_SYMBOL_GPL'
   security/security.c:2459: warning: expecting prototype for security_file_ioctl(). Prototype was for EXPORT_SYMBOL_GPL() instead
   security/security.c:2527: warning: Incorrect use of kernel-doc format:  * security_file_mprotect() - Check if changing memory protections is allowed
   security/security.c:2538: warning: Function parameter or member 'vma' not described in 'security_file_mprotect'
   security/security.c:2538: warning: Function parameter or member 'reqprot' not described in 'security_file_mprotect'
   security/security.c:2538: warning: Function parameter or member 'prot' not described in 'security_file_mprotect'
   security/security.c:2538: warning: expecting prototype for security_mmap_addr(). Prototype was for security_file_mprotect() instead
   security/security.c:2559: warning: Incorrect use of kernel-doc format:  * security_file_fcntl() - Check if fcntl() op is allowed
   security/security.c:2574: warning: Incorrect use of kernel-doc format:  * security_file_set_fowner() - Set the file owner info in the LSM blob
   security/security.c:2584: warning: Incorrect use of kernel-doc format:  * security_file_send_sigiotask() - Check if sending SIGIO/SIGURG is allowed
   security/security.c:2599: warning: Incorrect use of kernel-doc format:  * security_file_receive() - Check is receiving a file via IPC is allowed
   security/security.c:2609: warning: Incorrect use of kernel-doc format:  * security_file_open() - Save open() time state for late use by the LSM
   security/security.c:2618: warning: expecting prototype for security_file_lock(). Prototype was for security_file_open() instead
   security/security.c:2640: warning: Incorrect use of kernel-doc format:  * security_task_alloc() - Allocate a task's LSM blob
   security/security.c:2649: warning: Function parameter or member 'task' not described in 'security_task_alloc'
   security/security.c:2649: warning: Function parameter or member 'clone_flags' not described in 'security_task_alloc'
   security/security.c:2649: warning: expecting prototype for security_file_truncate(). Prototype was for security_task_alloc() instead
   security/security.c:2781: warning: Incorrect use of kernel-doc format:  * security_kernel_create_files_as() - Set file creation context using an inode
   security/security.c:2793: warning: Incorrect use of kernel-doc format:  * security_kernel_module_request() - Check is loading a module is allowed
   security/security.c:2802: warning: Function parameter or member 'kmod_name' not described in 'security_kernel_module_request'
   security/security.c:2802: warning: expecting prototype for security_kernel_act_as(). Prototype was for security_kernel_module_request() instead
   security/security.c:2922: warning: Incorrect use of kernel-doc format:  * security_task_fix_setgid() - Update LSM with new group id attributes
   security/security.c:2937: warning: Incorrect use of kernel-doc format:  * security_task_fix_setgroups() - Update LSM with new supplementary groups
   security/security.c:2950: warning: Incorrect use of kernel-doc format:  * security_task_setpgid() - Check if setting the pgid is allowed
   security/security.c:2961: warning: Incorrect use of kernel-doc format:  * security_task_getpgid() - Check if getting the pgid is allowed
   security/security.c:2971: warning: Incorrect use of kernel-doc format:  * security_task_getsid() - Check if getting the session id is allowed
   security/security.c:2980: warning: Incorrect use of kernel-doc format:  * security_current_getsecid_subj() - Get the current task's subjective secid
   security/security.c:2987: warning: Function parameter or member 'secid' not described in 'security_current_getsecid_subj'
   security/security.c:2987: warning: expecting prototype for security_task_fix_setuid(). Prototype was for security_current_getsecid_subj() instead
   security/security.c:3019: warning: Incorrect use of kernel-doc format:  * security_task_setioprio() - Check if setting a task's ioprio is allowed
   security/security.c:3029: warning: Incorrect use of kernel-doc format:  * security_task_getioprio() - Check if getting a task's ioprio is allowed
   security/security.c:3038: warning: Incorrect use of kernel-doc format:  * security_task_prlimit() - Check if get/setting resources limits is allowed
   security/security.c:3050: warning: Incorrect use of kernel-doc format:  * security_task_setrlimit() - Check if setting a new rlimit value is allowed
   security/security.c:3063: warning: Incorrect use of kernel-doc format:  * security_task_setscheduler() - Check if setting sched policy/param is allowed
   security/security.c:3073: warning: Incorrect use of kernel-doc format:  * security_task_getscheduler() - Check if getting scheduling info is allowed
   security/security.c:3082: warning: Incorrect use of kernel-doc format:  * security_task_movememory() - Check if moving memory is allowed
   security/security.c:3091: warning: Incorrect use of kernel-doc format:  * security_task_kill() - Check if sending a signal is allowed
   security/security.c:3107: warning: Incorrect use of kernel-doc format:  * security_task_prctl() - Check if a prctl op is allowed
   security/security.c:3122: warning: Function parameter or member 'option' not described in 'security_task_prctl'
   security/security.c:3122: warning: Function parameter or member 'arg2' not described in 'security_task_prctl'
   security/security.c:3122: warning: Function parameter or member 'arg3' not described in 'security_task_prctl'


vim +822 security/security.c

20510f2f4e2dab James Morris      2007-10-16   811  
1427ddbe5cc1a3 Paul Moore        2023-02-16   812  /**
1427ddbe5cc1a3 Paul Moore        2023-02-16   813   * security_binder_set_context_mgr() - Check if becoming binder ctx mgr is ok
1427ddbe5cc1a3 Paul Moore        2023-02-16   814   * @mgr: task credentials of current binder process
1427ddbe5cc1a3 Paul Moore        2023-02-16   815   *
1427ddbe5cc1a3 Paul Moore        2023-02-16   816   * Check whether @mgr is allowed to be the binder context manager.
1427ddbe5cc1a3 Paul Moore        2023-02-16   817   *
1427ddbe5cc1a3 Paul Moore        2023-02-16   818   * Return: Return 0 if permission is granted.
1427ddbe5cc1a3 Paul Moore        2023-02-16   819   */
79af73079d753b Stephen Smalley   2015-01-21   820  
1427ddbe5cc1a3 Paul Moore        2023-02-16   821  /**
1427ddbe5cc1a3 Paul Moore        2023-02-16  @822   * security_binder_transaction() - Check if a binder transaction is allowed
1427ddbe5cc1a3 Paul Moore        2023-02-16   823   * @from: sending process
1427ddbe5cc1a3 Paul Moore        2023-02-16   824   * @to: receiving process
1427ddbe5cc1a3 Paul Moore        2023-02-16   825   *
1427ddbe5cc1a3 Paul Moore        2023-02-16   826   * Check whether @from is allowed to invoke a binder transaction call to @to.
1427ddbe5cc1a3 Paul Moore        2023-02-16   827   *
1427ddbe5cc1a3 Paul Moore        2023-02-16   828   * Return: Returns 0 if permission is granted.
1427ddbe5cc1a3 Paul Moore        2023-02-16   829   */
79af73079d753b Stephen Smalley   2015-01-21   830  
1427ddbe5cc1a3 Paul Moore        2023-02-16   831  /**
1427ddbe5cc1a3 Paul Moore        2023-02-16  @832   * security_binder_transfer_binder() - Check if a binder transfer is allowed
1427ddbe5cc1a3 Paul Moore        2023-02-16   833   * @from: sending process
1427ddbe5cc1a3 Paul Moore        2023-02-16   834   * @to: receiving process
1427ddbe5cc1a3 Paul Moore        2023-02-16   835   *
1427ddbe5cc1a3 Paul Moore        2023-02-16   836   * Check whether @from is allowed to transfer a binder reference to @to.
1427ddbe5cc1a3 Paul Moore        2023-02-16   837   *
1427ddbe5cc1a3 Paul Moore        2023-02-16   838   * Return: Returns 0 if permission is granted.
1427ddbe5cc1a3 Paul Moore        2023-02-16   839   */
79af73079d753b Stephen Smalley   2015-01-21   840  
1427ddbe5cc1a3 Paul Moore        2023-02-16   841  /**
1427ddbe5cc1a3 Paul Moore        2023-02-16  @842   * security_binder_transfer_file() - Check if a binder file xfer is allowed
1427ddbe5cc1a3 Paul Moore        2023-02-16   843   * @from: sending process
1427ddbe5cc1a3 Paul Moore        2023-02-16   844   * @to: receiving process
1427ddbe5cc1a3 Paul Moore        2023-02-16   845   * @file: file being transferred
1427ddbe5cc1a3 Paul Moore        2023-02-16   846   *
1427ddbe5cc1a3 Paul Moore        2023-02-16   847   * Check whether @from is allowed to transfer @file to @to.
1427ddbe5cc1a3 Paul Moore        2023-02-16   848   *
1427ddbe5cc1a3 Paul Moore        2023-02-16   849   * Return: Returns 0 if permission is granted.
1427ddbe5cc1a3 Paul Moore        2023-02-16   850   */
79af73079d753b Stephen Smalley   2015-01-21   851  
e261301c851aee Paul Moore        2023-02-16   852  /**
e261301c851aee Paul Moore        2023-02-16  @853   * security_ptrace_access_check() - Check if tracing is allowed
e261301c851aee Paul Moore        2023-02-16   854   * @child: target process
e261301c851aee Paul Moore        2023-02-16   855   * @mode: PTRACE_MODE flags
e261301c851aee Paul Moore        2023-02-16   856   *
e261301c851aee Paul Moore        2023-02-16   857   * Check permission before allowing the current process to trace the @child
e261301c851aee Paul Moore        2023-02-16   858   * process.  Security modules may also want to perform a process tracing check
e261301c851aee Paul Moore        2023-02-16   859   * during an execve in the set_security or apply_creds hooks of tracing check
e261301c851aee Paul Moore        2023-02-16   860   * during an execve in the bprm_set_creds hook of binprm_security_ops if the
e261301c851aee Paul Moore        2023-02-16   861   * process is being traced and its security attributes would be changed by the
e261301c851aee Paul Moore        2023-02-16   862   * execve.
e261301c851aee Paul Moore        2023-02-16   863   *
e261301c851aee Paul Moore        2023-02-16   864   * Return: Returns 0 if permission is granted.
e261301c851aee Paul Moore        2023-02-16   865   */
5cd9c58fbe9ec9 David Howells     2008-08-14   866  
e261301c851aee Paul Moore        2023-02-16   867  /**
e261301c851aee Paul Moore        2023-02-16  @868   * security_ptrace_traceme() - Check if tracing is allowed
e261301c851aee Paul Moore        2023-02-16   869   * @parent: tracing process
e261301c851aee Paul Moore        2023-02-16   870   *
e261301c851aee Paul Moore        2023-02-16   871   * Check that the @parent process has sufficient permission to trace the
e261301c851aee Paul Moore        2023-02-16   872   * current process before allowing the current process to present itself to the
e261301c851aee Paul Moore        2023-02-16   873   * @parent process for tracing.
e261301c851aee Paul Moore        2023-02-16   874   *
e261301c851aee Paul Moore        2023-02-16   875   * Return: Returns 0 if permission is granted.
e261301c851aee Paul Moore        2023-02-16   876   */
20510f2f4e2dab James Morris      2007-10-16   877  
e261301c851aee Paul Moore        2023-02-16   878  /**
e261301c851aee Paul Moore        2023-02-16  @879   * security_capget() - Get the capability sets for a process
e261301c851aee Paul Moore        2023-02-16   880   * @target: target process
e261301c851aee Paul Moore        2023-02-16   881   * @effective: effective capability set
e261301c851aee Paul Moore        2023-02-16   882   * @inheritable: inheritable capability set
e261301c851aee Paul Moore        2023-02-16   883   * @permitted: permitted capability set
e261301c851aee Paul Moore        2023-02-16   884   *
e261301c851aee Paul Moore        2023-02-16   885   * Get the @effective, @inheritable, and @permitted capability sets for the
e261301c851aee Paul Moore        2023-02-16   886   * @target process.  The hook may also perform permission checking to determine
e261301c851aee Paul Moore        2023-02-16   887   * if the current process is allowed to see the capability sets of the @target
e261301c851aee Paul Moore        2023-02-16   888   * process.
e261301c851aee Paul Moore        2023-02-16   889   *
e261301c851aee Paul Moore        2023-02-16   890   * Return: Returns 0 if the capability sets were successfully obtained.
e261301c851aee Paul Moore        2023-02-16   891   */
20510f2f4e2dab James Morris      2007-10-16   892  
e261301c851aee Paul Moore        2023-02-16   893  /**
e261301c851aee Paul Moore        2023-02-16  @894   * security_capset() - Set the capability sets for a process
e261301c851aee Paul Moore        2023-02-16   895   * @new: new credentials for the target process
e261301c851aee Paul Moore        2023-02-16   896   * @old: current credentials of the target process
e261301c851aee Paul Moore        2023-02-16   897   * @effective: effective capability set
e261301c851aee Paul Moore        2023-02-16   898   * @inheritable: inheritable capability set
e261301c851aee Paul Moore        2023-02-16   899   * @permitted: permitted capability set
e261301c851aee Paul Moore        2023-02-16   900   *
e261301c851aee Paul Moore        2023-02-16   901   * Set the @effective, @inheritable, and @permitted capability sets for the
e261301c851aee Paul Moore        2023-02-16   902   * current process.
e261301c851aee Paul Moore        2023-02-16   903   *
e261301c851aee Paul Moore        2023-02-16   904   * Return: Returns 0 and update @new if permission is granted.
e261301c851aee Paul Moore        2023-02-16   905   */
20510f2f4e2dab James Morris      2007-10-16   906  
e261301c851aee Paul Moore        2023-02-16   907  /**
e261301c851aee Paul Moore        2023-02-16  @908   * security_capable() - Check if a process has the necessary capability
e261301c851aee Paul Moore        2023-02-16   909   * @cred: credentials to examine
e261301c851aee Paul Moore        2023-02-16   910   * @ns: user namespace
e261301c851aee Paul Moore        2023-02-16   911   * @cap: capability requested
e261301c851aee Paul Moore        2023-02-16   912   * @opts: capability check options
e261301c851aee Paul Moore        2023-02-16   913   *
e261301c851aee Paul Moore        2023-02-16   914   * Check whether the @tsk process has the @cap capability in the indicated
e261301c851aee Paul Moore        2023-02-16   915   * credentials.  @cap contains the capability <include/linux/capability.h>.
e261301c851aee Paul Moore        2023-02-16   916   * @opts contains options for the capable check <include/linux/security.h>.
e261301c851aee Paul Moore        2023-02-16   917   *
e261301c851aee Paul Moore        2023-02-16   918   * Return: Returns 0 if the capability is granted.
e261301c851aee Paul Moore        2023-02-16   919   */
20510f2f4e2dab James Morris      2007-10-16   920  
e261301c851aee Paul Moore        2023-02-16   921  /**
e261301c851aee Paul Moore        2023-02-16  @922   * security_quotactl() - Check if a quotactl() syscall is allowed for this fs
e261301c851aee Paul Moore        2023-02-16   923   * @cmds: commands
e261301c851aee Paul Moore        2023-02-16   924   * @type: type
e261301c851aee Paul Moore        2023-02-16   925   * @id: id
e261301c851aee Paul Moore        2023-02-16   926   * @sb: filesystem
e261301c851aee Paul Moore        2023-02-16   927   *
e261301c851aee Paul Moore        2023-02-16   928   * Check whether the quotactl syscall is allowed for this @sb.
e261301c851aee Paul Moore        2023-02-16   929   *
e261301c851aee Paul Moore        2023-02-16   930   * Return: Returns 0 if permission is granted.
e261301c851aee Paul Moore        2023-02-16   931   */
20510f2f4e2dab James Morris      2007-10-16   932  
e261301c851aee Paul Moore        2023-02-16   933  /**
e261301c851aee Paul Moore        2023-02-16  @934   * security_quota_on() - Check if QUOTAON is allowed for a dentry
e261301c851aee Paul Moore        2023-02-16   935   * @dentry: dentry
e261301c851aee Paul Moore        2023-02-16   936   *
e261301c851aee Paul Moore        2023-02-16   937   * Check whether QUOTAON is allowed for @dentry.
e261301c851aee Paul Moore        2023-02-16   938   *
e261301c851aee Paul Moore        2023-02-16   939   * Return: Returns 0 if permission is granted.
e261301c851aee Paul Moore        2023-02-16   940   */
20510f2f4e2dab James Morris      2007-10-16   941  
e261301c851aee Paul Moore        2023-02-16   942  /**
e261301c851aee Paul Moore        2023-02-16  @943   * security_syslog() - Check if accessing the kernel message ring is allowed
e261301c851aee Paul Moore        2023-02-16   944   * @type: SYSLOG_ACTION_* type
e261301c851aee Paul Moore        2023-02-16   945   *
e261301c851aee Paul Moore        2023-02-16   946   * Check permission before accessing the kernel message ring or changing
e261301c851aee Paul Moore        2023-02-16   947   * logging to the console.  See the syslog(2) manual page for an explanation of
e261301c851aee Paul Moore        2023-02-16   948   * the @type values.
e261301c851aee Paul Moore        2023-02-16   949   *
e261301c851aee Paul Moore        2023-02-16   950   * Return: Return 0 if permission is granted.
e261301c851aee Paul Moore        2023-02-16   951   */
20510f2f4e2dab James Morris      2007-10-16   952  
e261301c851aee Paul Moore        2023-02-16   953  /**
e261301c851aee Paul Moore        2023-02-16  @954   * security_settime64() - Check if changing the system time is allowed
e261301c851aee Paul Moore        2023-02-16   955   * @ts: new time
e261301c851aee Paul Moore        2023-02-16   956   * @tz: timezone
e261301c851aee Paul Moore        2023-02-16   957   *
e261301c851aee Paul Moore        2023-02-16   958   * Check permission to change the system time, struct timespec64 is defined in
e261301c851aee Paul Moore        2023-02-16   959   * <include/linux/time64.h> and timezone is defined in <include/linux/time.h>.
e261301c851aee Paul Moore        2023-02-16   960   *
e261301c851aee Paul Moore        2023-02-16   961   * Return: Returns 0 if permission is granted.
e261301c851aee Paul Moore        2023-02-16   962   */
457db29bfcfd1d Baolin Wang       2016-04-08   963  int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
20510f2f4e2dab James Morris      2007-10-16  @964  {
f25fce3e8f1f15 Casey Schaufler   2015-05-02   965  	return call_int_hook(settime, 0, ts, tz);
20510f2f4e2dab James Morris      2007-10-16   966  }
20510f2f4e2dab James Morris      2007-10-16   967  
e261301c851aee Paul Moore        2023-02-16   968  /**
e261301c851aee Paul Moore        2023-02-16   969   * security_vm_enough_memory_mm() - Check if allocating a new mem map is allowed
e261301c851aee Paul Moore        2023-02-16   970   * @mm: mm struct
e261301c851aee Paul Moore        2023-02-16   971   * @pages: number of pages
e261301c851aee Paul Moore        2023-02-16   972   *
e261301c851aee Paul Moore        2023-02-16   973   * Check permissions for allocating a new virtual mapping.  If all LSMs return
e261301c851aee Paul Moore        2023-02-16   974   * a positive value, __vm_enough_memory() will be called with cap_sys_admin
e261301c851aee Paul Moore        2023-02-16   975   * set. If at least one LSM returns 0 or negative, __vm_enough_memory() will be
e261301c851aee Paul Moore        2023-02-16   976   * called with cap_sys_admin cleared.
e261301c851aee Paul Moore        2023-02-16   977   *
e261301c851aee Paul Moore        2023-02-16   978   * Return: Returns 0 if permission is granted by the LSM infrastructure to the
e261301c851aee Paul Moore        2023-02-16   979   *         caller.
e261301c851aee Paul Moore        2023-02-16   980   */
20510f2f4e2dab James Morris      2007-10-16   981  int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
20510f2f4e2dab James Morris      2007-10-16   982  {
b1d9e6b0646d0e Casey Schaufler   2015-05-02   983  	struct security_hook_list *hp;
b1d9e6b0646d0e Casey Schaufler   2015-05-02   984  	int cap_sys_admin = 1;
b1d9e6b0646d0e Casey Schaufler   2015-05-02   985  	int rc;
b1d9e6b0646d0e Casey Schaufler   2015-05-02   986  
b1d9e6b0646d0e Casey Schaufler   2015-05-02   987  	/*
b1d9e6b0646d0e Casey Schaufler   2015-05-02   988  	 * The module will respond with a positive value if
b1d9e6b0646d0e Casey Schaufler   2015-05-02   989  	 * it thinks the __vm_enough_memory() call should be
b1d9e6b0646d0e Casey Schaufler   2015-05-02   990  	 * made with the cap_sys_admin set. If all of the modules
b1d9e6b0646d0e Casey Schaufler   2015-05-02   991  	 * agree that it should be set it will. If any module
b1d9e6b0646d0e Casey Schaufler   2015-05-02   992  	 * thinks it should not be set it won't.
b1d9e6b0646d0e Casey Schaufler   2015-05-02   993  	 */
df0ce17331e250 Sargun Dhillon    2018-03-29   994  	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
b1d9e6b0646d0e Casey Schaufler   2015-05-02   995  		rc = hp->hook.vm_enough_memory(mm, pages);
b1d9e6b0646d0e Casey Schaufler   2015-05-02   996  		if (rc <= 0) {
b1d9e6b0646d0e Casey Schaufler   2015-05-02   997  			cap_sys_admin = 0;
b1d9e6b0646d0e Casey Schaufler   2015-05-02   998  			break;
b1d9e6b0646d0e Casey Schaufler   2015-05-02   999  		}
b1d9e6b0646d0e Casey Schaufler   2015-05-02  1000  	}
b1d9e6b0646d0e Casey Schaufler   2015-05-02  1001  	return __vm_enough_memory(mm, pages, cap_sys_admin);
20510f2f4e2dab James Morris      2007-10-16  1002  }
20510f2f4e2dab James Morris      2007-10-16  1003  
1661372c912d19 Paul Moore        2023-02-07  1004  /**
1661372c912d19 Paul Moore        2023-02-07  1005   * security_bprm_creds_for_exec() - Prepare the credentials for exec()
1661372c912d19 Paul Moore        2023-02-07  1006   * @bprm: binary program information
1661372c912d19 Paul Moore        2023-02-07  1007   *
1661372c912d19 Paul Moore        2023-02-07  1008   * If the setup in prepare_exec_creds did not setup @bprm->cred->security
1661372c912d19 Paul Moore        2023-02-07  1009   * properly for executing @bprm->file, update the LSM's portion of
1661372c912d19 Paul Moore        2023-02-07  1010   * @bprm->cred->security to be what commit_creds needs to install for the new
1661372c912d19 Paul Moore        2023-02-07  1011   * program.  This hook may also optionally check permissions (e.g. for
1661372c912d19 Paul Moore        2023-02-07  1012   * transitions between security domains).  The hook must set @bprm->secureexec
1661372c912d19 Paul Moore        2023-02-07  1013   * to 1 if AT_SECURE should be set to request libc enable secure mode.  @bprm
1661372c912d19 Paul Moore        2023-02-07  1014   * contains the linux_binprm structure.
1661372c912d19 Paul Moore        2023-02-07  1015   *
1661372c912d19 Paul Moore        2023-02-07  1016   * Return: Returns 0 if the hook is successful and permission is granted.
1661372c912d19 Paul Moore        2023-02-07  1017   */
b8bff599261c93 Eric W. Biederman 2020-03-22  1018  
1661372c912d19 Paul Moore        2023-02-07  1019  /**
1661372c912d19 Paul Moore        2023-02-07 @1020   * security_bprm_creds_from_file() - Update linux_binprm creds based on file
1661372c912d19 Paul Moore        2023-02-07  1021   * @bprm: binary program information
1661372c912d19 Paul Moore        2023-02-07  1022   * @file: associated file
1661372c912d19 Paul Moore        2023-02-07  1023   *
1661372c912d19 Paul Moore        2023-02-07  1024   * If @file is setpcap, suid, sgid or otherwise marked to change privilege upon
1661372c912d19 Paul Moore        2023-02-07  1025   * exec, update @bprm->cred to reflect that change. This is called after
1661372c912d19 Paul Moore        2023-02-07  1026   * finding the binary that will be executed without an interpreter.  This
1661372c912d19 Paul Moore        2023-02-07  1027   * ensures that the credentials will not be derived from a script that the
1661372c912d19 Paul Moore        2023-02-07  1028   * binary will need to reopen, which when reopend may end up being a completely
1661372c912d19 Paul Moore        2023-02-07  1029   * different file.  This hook may also optionally check permissions (e.g. for
1661372c912d19 Paul Moore        2023-02-07  1030   * transitions between security domains).  The hook must set @bprm->secureexec
1661372c912d19 Paul Moore        2023-02-07  1031   * to 1 if AT_SECURE should be set to request libc enable secure mode.  The
1661372c912d19 Paul Moore        2023-02-07  1032   * hook must add to @bprm->per_clear any personality flags that should be
1661372c912d19 Paul Moore        2023-02-07  1033   * cleared from current->personality.  @bprm contains the linux_binprm
1661372c912d19 Paul Moore        2023-02-07  1034   * structure.
1661372c912d19 Paul Moore        2023-02-07  1035   *
1661372c912d19 Paul Moore        2023-02-07  1036   * Return: Returns 0 if the hook is successful and permission is granted.
1661372c912d19 Paul Moore        2023-02-07  1037   */
20510f2f4e2dab James Morris      2007-10-16  1038  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

