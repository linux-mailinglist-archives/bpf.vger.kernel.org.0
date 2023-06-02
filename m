Return-Path: <bpf+bounces-1720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3C6720886
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 19:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE1C1C21204
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 17:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E3B156D2;
	Fri,  2 Jun 2023 17:41:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99F4332EE
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 17:41:58 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE45E4D;
	Fri,  2 Jun 2023 10:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685727715; x=1717263715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T2Z+PRpXdrWfJ6V1xooWewzuG3GPNhnATyZhAlZ8sMk=;
  b=Ai4bgAhI+OpOunQxAFsSQj87zuD9DA+qTb6IvE7cp+GhARpp7JigySB5
   iDLOz+ULws9Hy5ZEquPY8e01uXMH2dmoABphA0W3/DlCwaBK9Z8mk0ggg
   V3plO4MtsiWjroDGYhgG72foClq43g26pU2/rj6gUB0KlOQaXkhEXoCpf
   t7ngkpFNzHnvw3BOl5nUzEgSeuZWqirYdeKfZPsgFfMW+ns9aq27KBC6h
   CxyFAr82sCwnb4zI/du/xsNIO7Dgco9tc2frsJHJxHslMbkPl5mXVfPV0
   SAh5BLhocqkGTdBtKQoZw8Gw2hg7CU6OeRLXdthwsEpXbA2OeN1mdE1HG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="345504647"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="345504647"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 10:41:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="832051610"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="832051610"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Jun 2023 10:41:52 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q58md-0000mp-1B;
	Fri, 02 Jun 2023 17:41:51 +0000
Date: Sat, 3 Jun 2023 01:41:18 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-security-module@vger.kernel.org,
	keescook@chromium.org, brauner@kernel.org, lennart@poettering.net,
	cyphar@cyphar.com, luto@kernel.org
Subject: Re: [PATCH RESEND bpf-next 01/18] bpf: introduce BPF token object
Message-ID: <202306030138.u9AeNgUk-lkp@intel.com>
References: <20230602150011.1657856-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602150011.1657856-2-andrii@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-introduce-BPF-token-object/20230602-230448
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230602150011.1657856-2-andrii%40kernel.org
patch subject: [PATCH RESEND bpf-next 01/18] bpf: introduce BPF token object
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20230603/202306030138.u9AeNgUk-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/59e6ef2000a056ce3386db8481e477e5abfbbe15
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andrii-Nakryiko/bpf-introduce-BPF-token-object/20230602-230448
        git checkout 59e6ef2000a056ce3386db8481e477e5abfbbe15
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash kernel/ net/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306030138.u9AeNgUk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/fork.c:98:
   include/linux/bpf.h: In function 'bpf_token_new_fd':
>> include/linux/bpf.h:2465:16: warning: returning 'int' from a function with return type 'struct bpf_token *' makes pointer from integer without a cast [-Wint-conversion]
    2465 |         return -EOPNOTSUPP;
         |                ^
   kernel/fork.c: At top level:
   kernel/fork.c:164:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     164 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:991:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     991 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:1086:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
    1086 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:9,
                    from kernel/sysctl.c:35:
   include/linux/bpf.h: In function 'bpf_token_new_fd':
>> include/linux/bpf.h:2465:16: warning: returning 'int' from a function with return type 'struct bpf_token *' makes pointer from integer without a cast [-Wint-conversion]
    2465 |         return -EOPNOTSUPP;
         |                ^
--
   In file included from include/linux/filter.h:9,
                    from kernel/kallsyms.c:25:
   include/linux/bpf.h: In function 'bpf_token_new_fd':
>> include/linux/bpf.h:2465:16: warning: returning 'int' from a function with return type 'struct bpf_token *' makes pointer from integer without a cast [-Wint-conversion]
    2465 |         return -EOPNOTSUPP;
         |                ^
   kernel/kallsyms.c: At top level:
   kernel/kallsyms.c:662:12: warning: no previous prototype for 'arch_get_kallsym' [-Wmissing-prototypes]
     662 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
         |            ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:9,
                    from kernel/bpf/core.c:21:
   include/linux/bpf.h: In function 'bpf_token_new_fd':
>> include/linux/bpf.h:2465:16: warning: returning 'int' from a function with return type 'struct bpf_token *' makes pointer from integer without a cast [-Wint-conversion]
    2465 |         return -EOPNOTSUPP;
         |                ^
   kernel/bpf/core.c: At top level:
   kernel/bpf/core.c:1638:12: warning: no previous prototype for 'bpf_probe_read_kernel' [-Wmissing-prototypes]
    1638 | u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
         |            ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/core.c:2075:6: warning: no previous prototype for 'bpf_patch_call_args' [-Wmissing-prototypes]
    2075 | void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
         |      ^~~~~~~~~~~~~~~~~~~


vim +2465 include/linux/bpf.h

  2462	
  2463	static inline struct bpf_token *bpf_token_new_fd(struct bpf_token *token)
  2464	{
> 2465		return -EOPNOTSUPP;
  2466	}
  2467	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

