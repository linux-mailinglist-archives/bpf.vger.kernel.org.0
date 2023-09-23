Return-Path: <bpf+bounces-10686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 344057AC2DC
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 16:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 016F01C2097C
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707B1D556;
	Sat, 23 Sep 2023 14:54:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5CB1D54D
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 14:54:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2E5180;
	Sat, 23 Sep 2023 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695480852; x=1727016852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2GU4L5XwbONvpT/KbcdubrCADKBC+cDuByHqBIFHzqM=;
  b=nBpOo08g/iaRggCMFNCgI42VL1FUNyzYjMgI9Zt4VuMTgt2SW1QNnKlN
   dAccIgYbdM8FeD6ykmxbEE7L9V3VqWihW20AdeAME7kaVZ9F3j2eAkkWi
   k29OnzAHbOrfghZv3vOyvf5M0igfhMKOgTFhUXTFaWsEW8nwGwkGU2lT8
   3g8ZgAJXxW2fyuHy1UPgRLAM9blIoh4YwZmnIpMquf5NuRzk3gMLXU5mc
   SzkuDkyglBb3m8iZYT9v8jZaia9w4fg2xqnJnI8DJq4bgnt4W2le/KJCk
   +eGkFDp0F7urfdjXWXLhMN8OtQOY79viumOK8zmvDH+abPuyRLA4JFktv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="411959294"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="411959294"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 07:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="724507506"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="724507506"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 23 Sep 2023 07:54:08 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qk40z-0002Uv-0g;
	Sat, 23 Sep 2023 14:53:55 +0000
Date: Sat, 23 Sep 2023 22:52:33 +0800
From: kernel test robot <lkp@intel.com>
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, paul@paul-moore.com,
	keescook@chromium.org, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, kpsingh@kernel.org,
	renauld@google.com
Subject: Re: [PATCH v4 3/5] security: Replace indirect LSM hook calls with
 static calls
Message-ID: <202309232244.uCfB7AMn-lkp@intel.com>
References: <20230922145505.4044003-4-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922145505.4044003-4-kpsingh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi KP,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf/master pcmoore-selinux/next linus/master v6.6-rc2 next-20230921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/kernel-Add-helper-macros-for-loop-unrolling/20230922-225925
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230922145505.4044003-4-kpsingh%40kernel.org
patch subject: [PATCH v4 3/5] security: Replace indirect LSM hook calls with static calls
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230923/202309232244.uCfB7AMn-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230923/202309232244.uCfB7AMn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309232244.uCfB7AMn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   security/security.c: In function 'security_binder_set_context_mgr':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:872:16: note: in expansion of macro 'call_int_hook'
     872 |         return call_int_hook(binder_set_context_mgr, 0, mgr);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_binder_transaction':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:887:16: note: in expansion of macro 'call_int_hook'
     887 |         return call_int_hook(binder_transaction, 0, from, to);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_binder_transfer_binder':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:902:16: note: in expansion of macro 'call_int_hook'
     902 |         return call_int_hook(binder_transfer_binder, 0, from, to);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_binder_transfer_file':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:918:16: note: in expansion of macro 'call_int_hook'
     918 |         return call_int_hook(binder_transfer_file, 0, from, to, file);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_ptrace_access_check':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:937:16: note: in expansion of macro 'call_int_hook'
     937 |         return call_int_hook(ptrace_access_check, 0, child, mode);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_ptrace_traceme':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:952:16: note: in expansion of macro 'call_int_hook'
     952 |         return call_int_hook(ptrace_traceme, 0, parent);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_capget':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:974:16: note: in expansion of macro 'call_int_hook'
     974 |         return call_int_hook(capget, 0, target,
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_capset':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:996:16: note: in expansion of macro 'call_int_hook'
     996 |         return call_int_hook(capset, 0, new, old,
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_capable':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1018:16: note: in expansion of macro 'call_int_hook'
    1018 |         return call_int_hook(capable, 0, cred, ns, cap, opts);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_quotactl':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1034:16: note: in expansion of macro 'call_int_hook'
    1034 |         return call_int_hook(quotactl, 0, cmds, type, id, sb);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_quota_on':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1047:16: note: in expansion of macro 'call_int_hook'
    1047 |         return call_int_hook(quota_on, 0, dentry);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_syslog':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1062:16: note: in expansion of macro 'call_int_hook'
    1062 |         return call_int_hook(syslog, 0, type);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_settime64':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1077:16: note: in expansion of macro 'call_int_hook'
    1077 |         return call_int_hook(settime, 0, ts, tz);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_bprm_creds_for_exec':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1132:16: note: in expansion of macro 'call_int_hook'
    1132 |         return call_int_hook(bprm_creds_for_exec, 0, bprm);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_bprm_creds_from_file':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1156:16: note: in expansion of macro 'call_int_hook'
    1156 |         return call_int_hook(bprm_creds_from_file, 0, bprm, file);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_bprm_check':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1175:15: note: in expansion of macro 'call_int_hook'
    1175 |         ret = call_int_hook(bprm_check_security, 0, bprm);
         |               ^~~~~~~~~~~~~
   security/security.c: In function 'security_fs_context_submount':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1225:16: note: in expansion of macro 'call_int_hook'
    1225 |         return call_int_hook(fs_context_submount, 0, fc, reference);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_fs_context_dup':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1241:16: note: in expansion of macro 'call_int_hook'
    1241 |         return call_int_hook(fs_context_dup, 0, fc, src_fc);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_sb_alloc':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1289:14: note: in expansion of macro 'call_int_hook'
    1289 |         rc = call_int_hook(sb_alloc_security, 0, sb);
         |              ^~~~~~~~~~~~~
   security/security.c: In function 'security_sb_eat_lsm_opts':
>> security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1347:16: note: in expansion of macro 'call_int_hook'
    1347 |         return call_int_hook(sb_eat_lsm_opts, 0, options, mnt_opts);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_sb_mnt_opts_compat':
   security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1364:16: note: in expansion of macro 'call_int_hook'
    1364 |         return call_int_hook(sb_mnt_opts_compat, 0, sb, mnt_opts);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_sb_remount':
   security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1381:16: note: in expansion of macro 'call_int_hook'
    1381 |         return call_int_hook(sb_remount, 0, sb, mnt_opts);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_sb_kern_mount':
   security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1395:16: note: in expansion of macro 'call_int_hook'
    1395 |         return call_int_hook(sb_kern_mount, 0, sb);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_sb_show_options':
   security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1409:16: note: in expansion of macro 'call_int_hook'
    1409 |         return call_int_hook(sb_show_options, 0, m, sb);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_sb_statfs':
   security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1423:16: note: in expansion of macro 'call_int_hook'
    1423 |         return call_int_hook(sb_statfs, 0, dentry);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_sb_mount':
   security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1446:16: note: in expansion of macro 'call_int_hook'
    1446 |         return call_int_hook(sb_mount, 0, dev_name, path, type, flags, data);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_sb_umount':
   security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1460:16: note: in expansion of macro 'call_int_hook'
    1460 |         return call_int_hook(sb_umount, 0, mnt, flags);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_sb_pivotroot':
   security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1475:16: note: in expansion of macro 'call_int_hook'
    1475 |         return call_int_hook(sb_pivotroot, 0, old_path, new_path);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_sb_set_mnt_opts':
   security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1494:16: note: in expansion of macro 'call_int_hook'
    1494 |         return call_int_hook(sb_set_mnt_opts,
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_sb_clone_mnt_opts':
   security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1516:16: note: in expansion of macro 'call_int_hook'
    1516 |         return call_int_hook(sb_clone_mnt_opts, 0, oldsb, newsb,
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_move_mount':
   security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1533:16: note: in expansion of macro 'call_int_hook'
    1533 |         return call_int_hook(move_mount, 0, from_path, to_path);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_path_notify':
   security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1550:16: note: in expansion of macro 'call_int_hook'
    1550 |         return call_int_hook(path_notify, 0, path, mask, obj_type);
         |                ^~~~~~~~~~~~~
   security/security.c: In function 'security_inode_alloc':
   security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~
   security/security.c:1569:14: note: in expansion of macro 'call_int_hook'
    1569 |         rc = call_int_hook(inode_alloc_security, 0, inode);
         |              ^~~~~~~~~~~~~
   security/security.c: In function 'security_dentry_create_files_as':
   security/security.c:851:1: warning: label 'out' defined but not used [-Wunused-label]
     851 | out:                                                                    \
         | ^~~


vim +/out +851 security/security.c

   845	
   846	#define call_int_hook(FUNC, IRC, ...)					\
   847	({									\
   848		__label__ out;							\
   849		int RC = IRC;							\
   850		LSM_LOOP_UNROLL(__CALL_STATIC_INT, RC, FUNC, out, __VA_ARGS__);	\
 > 851	out:									\
   852		RC;								\
   853	})
   854	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

