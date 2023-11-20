Return-Path: <bpf+bounces-15451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EDC7F2178
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8419A1C2180C
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DE13B2AC;
	Mon, 20 Nov 2023 23:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b16obzmp"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499FF92;
	Mon, 20 Nov 2023 15:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700523422; x=1732059422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cxz6UjMDz/60vN8qZ38jsSzHRChcXc2xRatWwl7/9MY=;
  b=b16obzmp8KSHrq+go9FTRnYYTm5l1ZJg5RGO6RvkhmwOtfgaEKbmGgyQ
   Vv1FyUE9QSdBq9oteEvULQxLk9tvY4NvuwyEQEdfOjrxfd3peAfnskipV
   GZn8OVjfKVL0IwIwqVRSjGYl6X8ezMvUpfXInQKvuT38LoBstQ6A7WTIU
   BTX4Ytd1wTBm1VAKbRee7swrjVXdxw6aG5nJJ1nOUtZTSixI7qJ9WmrF/
   eZg0QYWnoXLKr64HJJ4ZzCB7JqwVFuOyzvg1QhTvRF+0Tpb6vCgW/ba2C
   VpZUeypXrSsUk2TeARLvanned/qbBr2cvsMZY6yVgclj1t4zRl7W80YkJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371067516"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="371067516"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 15:37:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="832440922"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="832440922"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 Nov 2023 15:36:58 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5Dp1-00074A-1T;
	Mon, 20 Nov 2023 23:36:55 +0000
Date: Tue, 21 Nov 2023 07:36:30 +0800
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
Message-ID: <202311210740.Mxc4WM7v-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf/master]
[also build test ERROR on pcmoore-audit/next pcmoore-selinux/next linus/master v6.7-rc2]
[cannot apply to bpf-next/master next-20231120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tetsuo-Handa/LSM-Auto-undef-LSM_HOOK-macro/20231120-214522
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/34be5cd8-1fdd-4323-82a3-40f2e7d35db3%40I-love.SAKURA.ne.jp
patch subject: [PATCH 4/4] LSM: Add a LSM module which handles dynamically appendable LSM hooks.
config: arc-randconfig-002-20231121 (https://download.01.org/0day-ci/archive/20231121/202311210740.Mxc4WM7v-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210740.Mxc4WM7v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311210740.Mxc4WM7v-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> security/security.c:784:13: warning: no previous prototype for 'security_bprm_check_security' [-Wmissing-prototypes]
     784 |         int security_##NAME(__VA_ARGS__)                                \
         |             ^~~~~~~~~
   include/linux/lsm_hook_defs.h:114:1: note: in expansion of macro 'LSM_PLAIN_INT_HOOK'
     114 | LSM_PLAIN_INT_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
         | ^~~~~~~~~~~~~~~~~~
>> security/security.c:784:13: warning: no previous prototype for 'security_sb_alloc_security' [-Wmissing-prototypes]
     784 |         int security_##NAME(__VA_ARGS__)                                \
         |             ^~~~~~~~~
   include/linux/lsm_hook_defs.h:123:1: note: in expansion of macro 'LSM_PLAIN_INT_HOOK'
     123 | LSM_PLAIN_INT_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
         | ^~~~~~~~~~~~~~~~~~
>> security/security.c:799:14: warning: no previous prototype for 'security_sb_free_security' [-Wmissing-prototypes]
     799 |         void security_##NAME(__VA_ARGS__)                               \
         |              ^~~~~~~~~
   include/linux/lsm_hook_defs.h:125:1: note: in expansion of macro 'LSM_PLAIN_VOID_HOOK'
     125 | LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
         | ^~~~~~~~~~~~~~~~~~~
>> security/security.c:799:14: warning: no previous prototype for 'security_sb_free_mnt_opts' [-Wmissing-prototypes]
     799 |         void security_##NAME(__VA_ARGS__)                               \
         |              ^~~~~~~~~
   include/linux/lsm_hook_defs.h:126:1: note: in expansion of macro 'LSM_PLAIN_VOID_HOOK'
     126 | LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
         | ^~~~~~~~~~~~~~~~~~~
>> security/security.c:784:13: warning: no previous prototype for 'security_inode_alloc_security' [-Wmissing-prototypes]
     784 |         int security_##NAME(__VA_ARGS__)                                \
         |             ^~~~~~~~~
   include/linux/lsm_hook_defs.h:174:1: note: in expansion of macro 'LSM_PLAIN_INT_HOOK'
     174 | LSM_PLAIN_INT_HOOK(int, 0, inode_alloc_security, struct inode *inode)
         | ^~~~~~~~~~~~~~~~~~
>> security/security.c:799:14: warning: no previous prototype for 'security_inode_free_security' [-Wmissing-prototypes]
     799 |         void security_##NAME(__VA_ARGS__)                               \
         |              ^~~~~~~~~
   include/linux/lsm_hook_defs.h:175:1: note: in expansion of macro 'LSM_PLAIN_VOID_HOOK'
     175 | LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
         | ^~~~~~~~~~~~~~~~~~~
>> security/security.c:784:13: warning: no previous prototype for 'security_file_alloc_security' [-Wmissing-prototypes]
     784 |         int security_##NAME(__VA_ARGS__)                                \
         |             ^~~~~~~~~
   include/linux/lsm_hook_defs.h:231:1: note: in expansion of macro 'LSM_PLAIN_INT_HOOK'
     231 | LSM_PLAIN_INT_HOOK(int, 0, file_alloc_security, struct file *file)
         | ^~~~~~~~~~~~~~~~~~
>> security/security.c:799:14: warning: no previous prototype for 'security_file_free_security' [-Wmissing-prototypes]
     799 |         void security_##NAME(__VA_ARGS__)                               \
         |              ^~~~~~~~~
   include/linux/lsm_hook_defs.h:232:1: note: in expansion of macro 'LSM_PLAIN_VOID_HOOK'
     232 | LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
         | ^~~~~~~~~~~~~~~~~~~
>> security/security.c:784:13: warning: no previous prototype for 'security_cred_prepare' [-Wmissing-prototypes]
     784 |         int security_##NAME(__VA_ARGS__)                                \
         |             ^~~~~~~~~
   include/linux/lsm_hook_defs.h:254:1: note: in expansion of macro 'LSM_PLAIN_INT_HOOK'
     254 | LSM_PLAIN_INT_HOOK(int, 0, cred_prepare, struct cred *new, const struct cred *old,
         | ^~~~~~~~~~~~~~~~~~
>> security/security.c:784:13: warning: no previous prototype for 'security_msg_msg_alloc_security' [-Wmissing-prototypes]
     784 |         int security_##NAME(__VA_ARGS__)                                \
         |             ^~~~~~~~~
   include/linux/lsm_hook_defs.h:300:1: note: in expansion of macro 'LSM_PLAIN_INT_HOOK'
     300 | LSM_PLAIN_INT_HOOK(int, 0, msg_msg_alloc_security, struct msg_msg *msg)
         | ^~~~~~~~~~~~~~~~~~
>> security/security.c:799:14: warning: no previous prototype for 'security_msg_msg_free_security' [-Wmissing-prototypes]
     799 |         void security_##NAME(__VA_ARGS__)                               \
         |              ^~~~~~~~~
   include/linux/lsm_hook_defs.h:301:1: note: in expansion of macro 'LSM_PLAIN_VOID_HOOK'
     301 | LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, msg_msg_free_security, struct msg_msg *msg)
         | ^~~~~~~~~~~~~~~~~~~
>> security/security.c:784:13: warning: no previous prototype for 'security_msg_queue_alloc_security' [-Wmissing-prototypes]
     784 |         int security_##NAME(__VA_ARGS__)                                \
         |             ^~~~~~~~~
   include/linux/lsm_hook_defs.h:302:1: note: in expansion of macro 'LSM_PLAIN_INT_HOOK'
     302 | LSM_PLAIN_INT_HOOK(int, 0, msg_queue_alloc_security, struct kern_ipc_perm *perm)
         | ^~~~~~~~~~~~~~~~~~
>> security/security.c:799:14: warning: no previous prototype for 'security_msg_queue_free_security' [-Wmissing-prototypes]
     799 |         void security_##NAME(__VA_ARGS__)                               \
         |              ^~~~~~~~~
   include/linux/lsm_hook_defs.h:303:1: note: in expansion of macro 'LSM_PLAIN_VOID_HOOK'
     303 | LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, msg_queue_free_security,
         | ^~~~~~~~~~~~~~~~~~~
>> security/security.c:784:13: warning: no previous prototype for 'security_shm_alloc_security' [-Wmissing-prototypes]
     784 |         int security_##NAME(__VA_ARGS__)                                \
         |             ^~~~~~~~~
   include/linux/lsm_hook_defs.h:311:1: note: in expansion of macro 'LSM_PLAIN_INT_HOOK'
     311 | LSM_PLAIN_INT_HOOK(int, 0, shm_alloc_security, struct kern_ipc_perm *perm)
         | ^~~~~~~~~~~~~~~~~~
>> security/security.c:799:14: warning: no previous prototype for 'security_shm_free_security' [-Wmissing-prototypes]
     799 |         void security_##NAME(__VA_ARGS__)                               \
         |              ^~~~~~~~~
   include/linux/lsm_hook_defs.h:312:1: note: in expansion of macro 'LSM_PLAIN_VOID_HOOK'
     312 | LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, shm_free_security, struct kern_ipc_perm *perm)
         | ^~~~~~~~~~~~~~~~~~~
>> security/security.c:784:13: warning: no previous prototype for 'security_sem_alloc_security' [-Wmissing-prototypes]
     784 |         int security_##NAME(__VA_ARGS__)                                \
         |             ^~~~~~~~~
   include/linux/lsm_hook_defs.h:317:1: note: in expansion of macro 'LSM_PLAIN_INT_HOOK'
     317 | LSM_PLAIN_INT_HOOK(int, 0, sem_alloc_security, struct kern_ipc_perm *perm)
         | ^~~~~~~~~~~~~~~~~~
>> security/security.c:799:14: warning: no previous prototype for 'security_sem_free_security' [-Wmissing-prototypes]
     799 |         void security_##NAME(__VA_ARGS__)                               \
         |              ^~~~~~~~~
   include/linux/lsm_hook_defs.h:318:1: note: in expansion of macro 'LSM_PLAIN_VOID_HOOK'
     318 | LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, sem_free_security, struct kern_ipc_perm *perm)
         | ^~~~~~~~~~~~~~~~~~~
>> security/security.c:799:14: warning: no previous prototype for 'security_sk_getsecid' [-Wmissing-prototypes]
     799 |         void security_##NAME(__VA_ARGS__)                               \
         |              ^~~~~~~~~
   include/linux/lsm_hook_defs.h:381:1: note: in expansion of macro 'LSM_PLAIN_VOID_HOOK'
     381 | LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, sk_getsecid, const struct sock *sk, u32 *secid)
         | ^~~~~~~~~~~~~~~~~~~
>> security/security.c:784:13: warning: no previous prototype for 'security_xfrm_policy_alloc_security' [-Wmissing-prototypes]
     784 |         int security_##NAME(__VA_ARGS__)                                \
         |             ^~~~~~~~~
   include/linux/lsm_hook_defs.h:420:1: note: in expansion of macro 'LSM_PLAIN_INT_HOOK'
     420 | LSM_PLAIN_INT_HOOK(int, 0, xfrm_policy_alloc_security, struct xfrm_sec_ctx **ctxp,
         | ^~~~~~~~~~~~~~~~~~
>> security/security.c:784:13: warning: no previous prototype for 'security_xfrm_policy_clone_security' [-Wmissing-prototypes]
     784 |         int security_##NAME(__VA_ARGS__)                                \
         |             ^~~~~~~~~
   include/linux/lsm_hook_defs.h:422:1: note: in expansion of macro 'LSM_PLAIN_INT_HOOK'
     422 | LSM_PLAIN_INT_HOOK(int, 0, xfrm_policy_clone_security, struct xfrm_sec_ctx *old_ctx,
         | ^~~~~~~~~~~~~~~~~~
   security/security.c:799:14: warning: no previous prototype for 'security_xfrm_policy_free_security' [-Wmissing-prototypes]
     799 |         void security_##NAME(__VA_ARGS__)                               \
         |              ^~~~~~~~~
   include/linux/lsm_hook_defs.h:424:1: note: in expansion of macro 'LSM_PLAIN_VOID_HOOK'
     424 | LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, xfrm_policy_free_security,
         | ^~~~~~~~~~~~~~~~~~~
   security/security.c:784:13: warning: no previous prototype for 'security_xfrm_policy_delete_security' [-Wmissing-prototypes]
     784 |         int security_##NAME(__VA_ARGS__)                                \
         |             ^~~~~~~~~
   include/linux/lsm_hook_defs.h:426:1: note: in expansion of macro 'LSM_PLAIN_INT_HOOK'
     426 | LSM_PLAIN_INT_HOOK(int, 0, xfrm_policy_delete_security, struct xfrm_sec_ctx *ctx)
         | ^~~~~~~~~~~~~~~~~~
   security/security.c:799:14: warning: no previous prototype for 'security_xfrm_state_free_security' [-Wmissing-prototypes]
     799 |         void security_##NAME(__VA_ARGS__)                               \
         |              ^~~~~~~~~
   include/linux/lsm_hook_defs.h:431:1: note: in expansion of macro 'LSM_PLAIN_VOID_HOOK'
     431 | LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, xfrm_state_free_security, struct xfrm_state *x)
         | ^~~~~~~~~~~~~~~~~~~
   security/security.c:784:13: warning: no previous prototype for 'security_xfrm_state_delete_security' [-Wmissing-prototypes]
     784 |         int security_##NAME(__VA_ARGS__)                                \
         |             ^~~~~~~~~
   include/linux/lsm_hook_defs.h:432:1: note: in expansion of macro 'LSM_PLAIN_INT_HOOK'
     432 | LSM_PLAIN_INT_HOOK(int, 0, xfrm_state_delete_security, struct xfrm_state *x)
         | ^~~~~~~~~~~~~~~~~~
   security/security.c:784:13: error: conflicting types for 'security_xfrm_decode_session'; have 'int(struct sk_buff *, u32 *, int)' {aka 'int(struct sk_buff *, unsigned int *, int)'}
     784 |         int security_##NAME(__VA_ARGS__)                                \
         |             ^~~~~~~~~
   include/linux/lsm_hook_defs.h:436:1: note: in expansion of macro 'LSM_PLAIN_INT_HOOK'
     436 | LSM_PLAIN_INT_HOOK(int, 0, xfrm_decode_session, struct sk_buff *skb, u32 *secid,
         | ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/lsm_hooks.h:28,
                    from security/security.c:21:
   include/linux/security.h:1753:5: note: previous declaration of 'security_xfrm_decode_session' with type 'int(struct sk_buff *, u32 *)' {aka 'int(struct sk_buff *, unsigned int *)'}
    1753 | int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   security/security.c:784:13: warning: no previous prototype for 'security_bpf_map_alloc_security' [-Wmissing-prototypes]
     784 |         int security_##NAME(__VA_ARGS__)                                \
         |             ^~~~~~~~~
   include/linux/lsm_hook_defs.h:462:1: note: in expansion of macro 'LSM_PLAIN_INT_HOOK'
     462 | LSM_PLAIN_INT_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
         | ^~~~~~~~~~~~~~~~~~
   security/security.c:799:14: warning: no previous prototype for 'security_bpf_map_free_security' [-Wmissing-prototypes]
     799 |         void security_##NAME(__VA_ARGS__)                               \
         |              ^~~~~~~~~
   include/linux/lsm_hook_defs.h:463:1: note: in expansion of macro 'LSM_PLAIN_VOID_HOOK'
     463 | LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, bpf_map_free_security, struct bpf_map *map)
         | ^~~~~~~~~~~~~~~~~~~
   security/security.c:784:13: warning: no previous prototype for 'security_bpf_prog_alloc_security' [-Wmissing-prototypes]
     784 |         int security_##NAME(__VA_ARGS__)                                \
         |             ^~~~~~~~~
   include/linux/lsm_hook_defs.h:464:1: note: in expansion of macro 'LSM_PLAIN_INT_HOOK'
     464 | LSM_PLAIN_INT_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
         | ^~~~~~~~~~~~~~~~~~
   security/security.c:799:14: warning: no previous prototype for 'security_bpf_prog_free_security' [-Wmissing-prototypes]
     799 |         void security_##NAME(__VA_ARGS__)                               \
         |              ^~~~~~~~~
   include/linux/lsm_hook_defs.h:465:1: note: in expansion of macro 'LSM_PLAIN_VOID_HOOK'
     465 | LSM_PLAIN_VOID_HOOK(void, LSM_RET_VOID, bpf_prog_free_security, struct bpf_prog_aux *aux)
         | ^~~~~~~~~~~~~~~~~~~


vim +784 security/security.c

   781	
   782	#include <linux/lsm_hook_args.h>
   783	#define LSM_PLAIN_INT_HOOK(RET, DEFAULT, NAME, ...)			\
 > 784		int security_##NAME(__VA_ARGS__)				\
   785		{								\
   786			struct security_hook_list *P;				\
   787										\
   788			hlist_for_each_entry(P, &security_hook_heads.NAME, list) { \
   789				int RC = P->hook.NAME(LSM_CALL_ARGS_##NAME);	\
   790										\
   791				if (RC != DEFAULT)				\
   792					return RC;				\
   793			}							\
   794			return DEFAULT;						\
   795		}
   796	#define LSM_CUSTOM_INT_HOOK(RET, DEFAULT, NAME, ...) DECLARE_LSM_RET_DEFAULT_int(DEFAULT, NAME)
   797	#define LSM_SPECIAL_INT_HOOK(RET, DEFAULT, NAME, ...) DECLARE_LSM_RET_DEFAULT_int(DEFAULT, NAME)
   798	#define LSM_PLAIN_VOID_HOOK(RET, DEFAULT, NAME, ...)			\
 > 799		void security_##NAME(__VA_ARGS__)				\
   800		{								\
   801			struct security_hook_list *P;				\
   802										\
   803			hlist_for_each_entry(P, &security_hook_heads.NAME, list) \
   804				P->hook.NAME(LSM_CALL_ARGS_##NAME);		\
   805		}
   806	#define LSM_CUSTOM_VOID_HOOK(RET, DEFAULT, NAME, ...)
   807	#define LSM_SPECIAL_VOID_HOOK(RET, DEFAULT, NAME, ...)
   808	#include <linux/lsm_hook_defs.h>
   809	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

