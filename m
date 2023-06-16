Return-Path: <bpf+bounces-2771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DFA733B5B
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 23:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBC12817FC
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 21:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEAA6AC2;
	Fri, 16 Jun 2023 21:10:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5546AB5
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 21:10:00 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67B0D8;
	Fri, 16 Jun 2023 14:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686949797; x=1718485797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MGvblgTiM/nU8S83WbvkzafTeQ3MttQEJKhdcqTmHXA=;
  b=cC/P13p8D+JtG7AGB1tD9maM7qkDok4qvcVI/xt2JbVnElNDeKXbl1Y1
   0ugPrHah7SMB2LlZC/zCfD+i9RI/oCe2jL+TnrVRcmW8PuGxeD+Gatr6i
   hlG+REsA26uG0/supS8hedr3QiCAuwqk2o6lgpbHFuGLhgQReAwiCmTye
   ROC6eUwlwmvK62Nyi99Ez7+FP1iax60wB/QVUHDGKQxzHxeZaPZj85XHq
   dQKOAlYCfDZMGW/jUH0LDu3Q7166mrYD7Dx+pIbnYAlGNEthRZMysbAZ6
   +MHiBPSrCaddG48b8wsG9/u+YyqpmjNd8/Szyg1OYJCFchffw7MGz758Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="344052164"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="344052164"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="802970275"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="802970275"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2023 14:09:54 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qAGhd-0001ok-2j;
	Fri, 16 Jun 2023 21:09:53 +0000
Date: Sat, 17 Jun 2023 05:09:45 +0800
From: kernel test robot <lkp@intel.com>
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, paul@paul-moore.com,
	keescook@chromium.org, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, jannh@google.com,
	KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH v2 3/5] security: Replace indirect LSM hook calls with
 static calls
Message-ID: <202306170414.br6e1YPW-lkp@intel.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
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
config: s390-defconfig (https://download.01.org/0day-ci/archive/20230617/202306170414.br6e1YPW-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230617/202306170414.br6e1YPW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306170414.br6e1YPW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x28): undefined reference to `__SCT__lsm_static_call_binder_set_context_mgr_0'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x48): undefined reference to `__SCT__lsm_static_call_binder_set_context_mgr_1'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x68): undefined reference to `__SCT__lsm_static_call_binder_set_context_mgr_2'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x88): undefined reference to `__SCT__lsm_static_call_binder_set_context_mgr_3'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0xa8): undefined reference to `__SCT__lsm_static_call_binder_set_context_mgr_4'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0xc8): undefined reference to `__SCT__lsm_static_call_binder_transaction_0'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0xe8): undefined reference to `__SCT__lsm_static_call_binder_transaction_1'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x108): undefined reference to `__SCT__lsm_static_call_binder_transaction_2'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x128): undefined reference to `__SCT__lsm_static_call_binder_transaction_3'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x148): undefined reference to `__SCT__lsm_static_call_binder_transaction_4'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x168): undefined reference to `__SCT__lsm_static_call_binder_transfer_binder_0'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x188): undefined reference to `__SCT__lsm_static_call_binder_transfer_binder_1'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x1a8): undefined reference to `__SCT__lsm_static_call_binder_transfer_binder_2'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x1c8): undefined reference to `__SCT__lsm_static_call_binder_transfer_binder_3'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x1e8): undefined reference to `__SCT__lsm_static_call_binder_transfer_binder_4'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x208): undefined reference to `__SCT__lsm_static_call_binder_transfer_file_0'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x228): undefined reference to `__SCT__lsm_static_call_binder_transfer_file_1'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x248): undefined reference to `__SCT__lsm_static_call_binder_transfer_file_2'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x268): undefined reference to `__SCT__lsm_static_call_binder_transfer_file_3'
>> s390-linux-ld: security/security.o:(.data..ro_after_init+0x288): undefined reference to `__SCT__lsm_static_call_binder_transfer_file_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x2a8): undefined reference to `__SCT__lsm_static_call_ptrace_access_check_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x2c8): undefined reference to `__SCT__lsm_static_call_ptrace_access_check_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x2e8): undefined reference to `__SCT__lsm_static_call_ptrace_access_check_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x308): undefined reference to `__SCT__lsm_static_call_ptrace_access_check_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x328): undefined reference to `__SCT__lsm_static_call_ptrace_access_check_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x348): undefined reference to `__SCT__lsm_static_call_ptrace_traceme_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x368): undefined reference to `__SCT__lsm_static_call_ptrace_traceme_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x388): undefined reference to `__SCT__lsm_static_call_ptrace_traceme_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x3a8): undefined reference to `__SCT__lsm_static_call_ptrace_traceme_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x3c8): undefined reference to `__SCT__lsm_static_call_ptrace_traceme_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x3e8): undefined reference to `__SCT__lsm_static_call_capget_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x408): undefined reference to `__SCT__lsm_static_call_capget_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x428): undefined reference to `__SCT__lsm_static_call_capget_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x448): undefined reference to `__SCT__lsm_static_call_capget_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x468): undefined reference to `__SCT__lsm_static_call_capget_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x488): undefined reference to `__SCT__lsm_static_call_capset_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x4a8): undefined reference to `__SCT__lsm_static_call_capset_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x4c8): undefined reference to `__SCT__lsm_static_call_capset_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x4e8): undefined reference to `__SCT__lsm_static_call_capset_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x508): undefined reference to `__SCT__lsm_static_call_capset_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x528): undefined reference to `__SCT__lsm_static_call_capable_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x548): undefined reference to `__SCT__lsm_static_call_capable_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x568): undefined reference to `__SCT__lsm_static_call_capable_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x588): undefined reference to `__SCT__lsm_static_call_capable_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x5a8): undefined reference to `__SCT__lsm_static_call_capable_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x5c8): undefined reference to `__SCT__lsm_static_call_quotactl_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x5e8): undefined reference to `__SCT__lsm_static_call_quotactl_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x608): undefined reference to `__SCT__lsm_static_call_quotactl_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x628): undefined reference to `__SCT__lsm_static_call_quotactl_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x648): undefined reference to `__SCT__lsm_static_call_quotactl_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x668): undefined reference to `__SCT__lsm_static_call_quota_on_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x688): undefined reference to `__SCT__lsm_static_call_quota_on_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x6a8): undefined reference to `__SCT__lsm_static_call_quota_on_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x6c8): undefined reference to `__SCT__lsm_static_call_quota_on_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x6e8): undefined reference to `__SCT__lsm_static_call_quota_on_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x708): undefined reference to `__SCT__lsm_static_call_syslog_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x728): undefined reference to `__SCT__lsm_static_call_syslog_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x748): undefined reference to `__SCT__lsm_static_call_syslog_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x768): undefined reference to `__SCT__lsm_static_call_syslog_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x788): undefined reference to `__SCT__lsm_static_call_syslog_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x7a8): undefined reference to `__SCT__lsm_static_call_settime_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x7c8): undefined reference to `__SCT__lsm_static_call_settime_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x7e8): undefined reference to `__SCT__lsm_static_call_settime_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x808): undefined reference to `__SCT__lsm_static_call_settime_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x828): undefined reference to `__SCT__lsm_static_call_settime_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x848): undefined reference to `__SCT__lsm_static_call_vm_enough_memory_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x868): undefined reference to `__SCT__lsm_static_call_vm_enough_memory_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x888): undefined reference to `__SCT__lsm_static_call_vm_enough_memory_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x8a8): undefined reference to `__SCT__lsm_static_call_vm_enough_memory_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x8c8): undefined reference to `__SCT__lsm_static_call_vm_enough_memory_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x8e8): undefined reference to `__SCT__lsm_static_call_bprm_creds_for_exec_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x908): undefined reference to `__SCT__lsm_static_call_bprm_creds_for_exec_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x928): undefined reference to `__SCT__lsm_static_call_bprm_creds_for_exec_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x948): undefined reference to `__SCT__lsm_static_call_bprm_creds_for_exec_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x968): undefined reference to `__SCT__lsm_static_call_bprm_creds_for_exec_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x988): undefined reference to `__SCT__lsm_static_call_bprm_creds_from_file_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x9a8): undefined reference to `__SCT__lsm_static_call_bprm_creds_from_file_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x9c8): undefined reference to `__SCT__lsm_static_call_bprm_creds_from_file_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0x9e8): undefined reference to `__SCT__lsm_static_call_bprm_creds_from_file_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xa08): undefined reference to `__SCT__lsm_static_call_bprm_creds_from_file_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xa28): undefined reference to `__SCT__lsm_static_call_bprm_check_security_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xa48): undefined reference to `__SCT__lsm_static_call_bprm_check_security_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xa68): undefined reference to `__SCT__lsm_static_call_bprm_check_security_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xa88): undefined reference to `__SCT__lsm_static_call_bprm_check_security_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xaa8): undefined reference to `__SCT__lsm_static_call_bprm_check_security_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xac8): undefined reference to `__SCT__lsm_static_call_bprm_committing_creds_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xae8): undefined reference to `__SCT__lsm_static_call_bprm_committing_creds_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xb08): undefined reference to `__SCT__lsm_static_call_bprm_committing_creds_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xb28): undefined reference to `__SCT__lsm_static_call_bprm_committing_creds_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xb48): undefined reference to `__SCT__lsm_static_call_bprm_committing_creds_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xb68): undefined reference to `__SCT__lsm_static_call_bprm_committed_creds_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xb88): undefined reference to `__SCT__lsm_static_call_bprm_committed_creds_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xba8): undefined reference to `__SCT__lsm_static_call_bprm_committed_creds_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xbc8): undefined reference to `__SCT__lsm_static_call_bprm_committed_creds_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xbe8): undefined reference to `__SCT__lsm_static_call_bprm_committed_creds_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xc08): undefined reference to `__SCT__lsm_static_call_fs_context_dup_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xc28): undefined reference to `__SCT__lsm_static_call_fs_context_dup_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xc48): undefined reference to `__SCT__lsm_static_call_fs_context_dup_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xc68): undefined reference to `__SCT__lsm_static_call_fs_context_dup_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xc88): undefined reference to `__SCT__lsm_static_call_fs_context_dup_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xca8): undefined reference to `__SCT__lsm_static_call_fs_context_parse_param_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xcc8): undefined reference to `__SCT__lsm_static_call_fs_context_parse_param_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xce8): undefined reference to `__SCT__lsm_static_call_fs_context_parse_param_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xd08): undefined reference to `__SCT__lsm_static_call_fs_context_parse_param_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xd28): undefined reference to `__SCT__lsm_static_call_fs_context_parse_param_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xd48): undefined reference to `__SCT__lsm_static_call_sb_alloc_security_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xd68): undefined reference to `__SCT__lsm_static_call_sb_alloc_security_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xd88): undefined reference to `__SCT__lsm_static_call_sb_alloc_security_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xda8): undefined reference to `__SCT__lsm_static_call_sb_alloc_security_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xdc8): undefined reference to `__SCT__lsm_static_call_sb_alloc_security_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xde8): undefined reference to `__SCT__lsm_static_call_sb_delete_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xe08): undefined reference to `__SCT__lsm_static_call_sb_delete_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xe28): undefined reference to `__SCT__lsm_static_call_sb_delete_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xe48): undefined reference to `__SCT__lsm_static_call_sb_delete_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xe68): undefined reference to `__SCT__lsm_static_call_sb_delete_4'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xe88): undefined reference to `__SCT__lsm_static_call_sb_free_security_0'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xea8): undefined reference to `__SCT__lsm_static_call_sb_free_security_1'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xec8): undefined reference to `__SCT__lsm_static_call_sb_free_security_2'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xee8): undefined reference to `__SCT__lsm_static_call_sb_free_security_3'
   s390-linux-ld: security/security.o:(.data..ro_after_init+0xf08): undefined reference to `__SCT__lsm_static_call_sb_free_security_4'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

