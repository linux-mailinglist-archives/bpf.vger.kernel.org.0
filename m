Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E56F674D52
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 07:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjATGYS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 01:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjATGYS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 01:24:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3C285371;
        Thu, 19 Jan 2023 22:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674195822; x=1705731822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KCemd+gR6Sk0uJqxe5gyusCcMC7HCWG8y/CVYzAwrTw=;
  b=b8KIr2f5QToaB+H53BYySkwCEc6JnBOFprKyroceWth9QotAQUbWJDhC
   /CttzeDuSNDZO9/s9yjE8ZwxXCOg8UV+fCa0jkNft5t23tkM8dpF4Ocxi
   nUowvefu54eUs2ec2md2kPmA0i+OHTEs8z2Clyw+CcmY4O+9sIExnRwDu
   lEuQoDZ05wic2Zqobw/BjfWw5XNS7E10M0Nal7S6IQnocm2X57SUTn3HP
   o+Rh97yrf6CxaLZvUQkudbx0Csm6nyvIBQ8qB85fjWWmFOStkJatHvj+s
   xSRKnm4V+QwkvfRumszI6FLaiUygqLbdkOblPucd9IHRZHOW5igGGeokS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="411745950"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="411745950"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 22:22:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="690943125"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="690943125"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Jan 2023 22:22:43 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIknS-0002Gr-2m;
        Fri, 20 Jan 2023 06:22:42 +0000
Date:   Fri, 20 Jan 2023 14:22:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 4/8] bpf: Enable cpumasks to be queried and used
 as kptrs
Message-ID: <202301201454.hTFU2jPK-lkp@intel.com>
References: <20230119235833.2948341-5-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119235833.2948341-5-void@manifault.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Vernet/bpf-Enable-annotating-trusted-nested-pointers/20230120-080139
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230119235833.2948341-5-void%40manifault.com
patch subject: [PATCH bpf-next 4/8] bpf: Enable cpumasks to be queried and used as kptrs
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20230120/202301201454.hTFU2jPK-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/11541205c58f2226e5ffbc5967317469d65efac6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Vernet/bpf-Enable-annotating-trusted-nested-pointers/20230120-080139
        git checkout 11541205c58f2226e5ffbc5967317469d65efac6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/cpumask.c:38:21: warning: no previous prototype for function 'bpf_cpumask_create' [-Wmissing-prototypes]
   struct bpf_cpumask *bpf_cpumask_create(void)
                       ^
   kernel/bpf/cpumask.c:38:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct bpf_cpumask *bpf_cpumask_create(void)
   ^
   static 
>> kernel/bpf/cpumask.c:52:21: warning: no previous prototype for function 'bpf_cpumask_acquire' [-Wmissing-prototypes]
   struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
                       ^
   kernel/bpf/cpumask.c:52:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
   ^
   static 
>> kernel/bpf/cpumask.c:58:21: warning: no previous prototype for function 'bpf_cpumask_kptr_get' [-Wmissing-prototypes]
   struct bpf_cpumask *bpf_cpumask_kptr_get(struct bpf_cpumask **cpumaskp)
                       ^
   kernel/bpf/cpumask.c:58:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct bpf_cpumask *bpf_cpumask_kptr_get(struct bpf_cpumask **cpumaskp)
   ^
   static 
>> kernel/bpf/cpumask.c:76:6: warning: no previous prototype for function 'bpf_cpumask_release' [-Wmissing-prototypes]
   void bpf_cpumask_release(struct bpf_cpumask *cpumask)
        ^
   kernel/bpf/cpumask.c:76:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void bpf_cpumask_release(struct bpf_cpumask *cpumask)
   ^
   static 
>> kernel/bpf/cpumask.c:88:5: warning: no previous prototype for function 'bpf_cpumask_first' [-Wmissing-prototypes]
   u32 bpf_cpumask_first(const struct cpumask *cpumask)
       ^
   kernel/bpf/cpumask.c:88:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u32 bpf_cpumask_first(const struct cpumask *cpumask)
   ^
   static 
>> kernel/bpf/cpumask.c:93:5: warning: no previous prototype for function 'bpf_cpumask_first_zero' [-Wmissing-prototypes]
   u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
       ^
   kernel/bpf/cpumask.c:93:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
   ^
   static 
>> kernel/bpf/cpumask.c:98:6: warning: no previous prototype for function 'bpf_cpumask_set_cpu' [-Wmissing-prototypes]
   void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
        ^
   kernel/bpf/cpumask.c:98:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
   ^
   static 
>> kernel/bpf/cpumask.c:106:6: warning: no previous prototype for function 'bpf_cpumask_clear_cpu' [-Wmissing-prototypes]
   void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
        ^
   kernel/bpf/cpumask.c:106:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
   ^
   static 
>> kernel/bpf/cpumask.c:114:6: warning: no previous prototype for function 'bpf_cpumask_test_cpu' [-Wmissing-prototypes]
   bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask)
        ^
   kernel/bpf/cpumask.c:114:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask)
   ^
   static 
>> kernel/bpf/cpumask.c:122:6: warning: no previous prototype for function 'bpf_cpumask_test_and_set_cpu' [-Wmissing-prototypes]
   bool bpf_cpumask_test_and_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
        ^
   kernel/bpf/cpumask.c:122:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool bpf_cpumask_test_and_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
   ^
   static 
>> kernel/bpf/cpumask.c:130:6: warning: no previous prototype for function 'bpf_cpumask_test_and_clear_cpu' [-Wmissing-prototypes]
   bool bpf_cpumask_test_and_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
        ^
   kernel/bpf/cpumask.c:130:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool bpf_cpumask_test_and_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
   ^
   static 
>> kernel/bpf/cpumask.c:138:6: warning: no previous prototype for function 'bpf_cpumask_setall' [-Wmissing-prototypes]
   void bpf_cpumask_setall(struct bpf_cpumask *cpumask)
        ^
   kernel/bpf/cpumask.c:138:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void bpf_cpumask_setall(struct bpf_cpumask *cpumask)
   ^
   static 
>> kernel/bpf/cpumask.c:143:6: warning: no previous prototype for function 'bpf_cpumask_clear' [-Wmissing-prototypes]
   void bpf_cpumask_clear(struct bpf_cpumask *cpumask)
        ^
   kernel/bpf/cpumask.c:143:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void bpf_cpumask_clear(struct bpf_cpumask *cpumask)
   ^
   static 
>> kernel/bpf/cpumask.c:148:6: warning: no previous prototype for function 'bpf_cpumask_and' [-Wmissing-prototypes]
   bool bpf_cpumask_and(struct bpf_cpumask *dst,
        ^
   kernel/bpf/cpumask.c:148:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool bpf_cpumask_and(struct bpf_cpumask *dst,
   ^
   static 
>> kernel/bpf/cpumask.c:155:6: warning: no previous prototype for function 'bpf_cpumask_or' [-Wmissing-prototypes]
   void bpf_cpumask_or(struct bpf_cpumask *dst,
        ^
   kernel/bpf/cpumask.c:155:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void bpf_cpumask_or(struct bpf_cpumask *dst,
   ^
   static 
>> kernel/bpf/cpumask.c:162:6: warning: no previous prototype for function 'bpf_cpumask_xor' [-Wmissing-prototypes]
   void bpf_cpumask_xor(struct bpf_cpumask *dst,
        ^
   kernel/bpf/cpumask.c:162:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void bpf_cpumask_xor(struct bpf_cpumask *dst,
   ^
   static 
>> kernel/bpf/cpumask.c:169:6: warning: no previous prototype for function 'bpf_cpumask_equal' [-Wmissing-prototypes]
   bool bpf_cpumask_equal(const struct cpumask *src1, const struct cpumask *src2)
        ^
   kernel/bpf/cpumask.c:169:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool bpf_cpumask_equal(const struct cpumask *src1, const struct cpumask *src2)
   ^
   static 
>> kernel/bpf/cpumask.c:174:6: warning: no previous prototype for function 'bpf_cpumask_intersects' [-Wmissing-prototypes]
   bool bpf_cpumask_intersects(const struct cpumask *src1, const struct cpumask *src2)
        ^
   kernel/bpf/cpumask.c:174:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool bpf_cpumask_intersects(const struct cpumask *src1, const struct cpumask *src2)
   ^
   static 
>> kernel/bpf/cpumask.c:179:6: warning: no previous prototype for function 'bpf_cpumask_subset' [-Wmissing-prototypes]
   bool bpf_cpumask_subset(const struct cpumask *src1, const struct cpumask *src2)
        ^
   kernel/bpf/cpumask.c:179:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool bpf_cpumask_subset(const struct cpumask *src1, const struct cpumask *src2)
   ^
   static 
>> kernel/bpf/cpumask.c:184:6: warning: no previous prototype for function 'bpf_cpumask_empty' [-Wmissing-prototypes]
   bool bpf_cpumask_empty(const struct cpumask *cpumask)
        ^
   kernel/bpf/cpumask.c:184:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool bpf_cpumask_empty(const struct cpumask *cpumask)
   ^
   static 
   kernel/bpf/cpumask.c:189:6: warning: no previous prototype for function 'bpf_cpumask_full' [-Wmissing-prototypes]
   bool bpf_cpumask_full(const struct cpumask *cpumask)
        ^
   kernel/bpf/cpumask.c:189:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool bpf_cpumask_full(const struct cpumask *cpumask)
   ^
   static 
   kernel/bpf/cpumask.c:194:6: warning: no previous prototype for function 'bpf_cpumask_copy' [-Wmissing-prototypes]
   void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src)
        ^
   kernel/bpf/cpumask.c:194:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src)
   ^
   static 
   kernel/bpf/cpumask.c:199:5: warning: no previous prototype for function 'bpf_cpumask_any' [-Wmissing-prototypes]
   u32 bpf_cpumask_any(const struct cpumask *cpumask)
       ^
   kernel/bpf/cpumask.c:199:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u32 bpf_cpumask_any(const struct cpumask *cpumask)
   ^
   static 
   kernel/bpf/cpumask.c:204:5: warning: no previous prototype for function 'bpf_cpumask_any_and' [-Wmissing-prototypes]
   u32 bpf_cpumask_any_and(const struct cpumask *src1, const struct cpumask *src2)
       ^
   kernel/bpf/cpumask.c:204:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u32 bpf_cpumask_any_and(const struct cpumask *src1, const struct cpumask *src2)
   ^
   static 
   24 warnings generated.


vim +/bpf_cpumask_create +38 kernel/bpf/cpumask.c

    37	
  > 38	struct bpf_cpumask *bpf_cpumask_create(void)
    39	{
    40		struct bpf_cpumask *cpumask;
    41	
    42		cpumask = bpf_mem_alloc(&bpf_cpumask_ma, sizeof(*cpumask));
    43		if (!cpumask)
    44			return NULL;
    45	
    46		memset(cpumask, 0, sizeof(*cpumask));
    47		refcount_set(&cpumask->usage, 1);
    48	
    49		return cpumask;
    50	}
    51	
  > 52	struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
    53	{
    54		refcount_inc(&cpumask->usage);
    55		return cpumask;
    56	}
    57	
  > 58	struct bpf_cpumask *bpf_cpumask_kptr_get(struct bpf_cpumask **cpumaskp)
    59	{
    60		struct bpf_cpumask *cpumask;
    61	
    62		/* The BPF memory allocator frees memory backing its caches in an RCU
    63		 * callback. Thus, we can safely use RCU to ensure that the cpumask is
    64		 * safe to read.
    65		 */
    66		rcu_read_lock();
    67	
    68		cpumask = READ_ONCE(*cpumaskp);
    69		if (cpumask && !refcount_inc_not_zero(&cpumask->usage))
    70			cpumask = NULL;
    71	
    72		rcu_read_unlock();
    73		return cpumask;
    74	}
    75	
  > 76	void bpf_cpumask_release(struct bpf_cpumask *cpumask)
    77	{
    78		if (!cpumask)
    79			return;
    80	
    81		if (refcount_dec_and_test(&cpumask->usage)) {
    82			migrate_disable();
    83			bpf_mem_free(&bpf_cpumask_ma, cpumask);
    84			migrate_enable();
    85		}
    86	}
    87	
  > 88	u32 bpf_cpumask_first(const struct cpumask *cpumask)
    89	{
    90		return cpumask_first(cpumask);
    91	}
    92	
  > 93	u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
    94	{
    95		return cpumask_first_zero(cpumask);
    96	}
    97	
  > 98	void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
    99	{
   100		if (!cpu_valid(cpu))
   101			return;
   102	
   103		cpumask_set_cpu(cpu, (struct cpumask *)cpumask);
   104	}
   105	
 > 106	void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
   107	{
   108		if (!cpu_valid(cpu))
   109			return;
   110	
   111		cpumask_clear_cpu(cpu, (struct cpumask *)cpumask);
   112	}
   113	
 > 114	bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask)
   115	{
   116		if (!cpu_valid(cpu))
   117			return false;
   118	
   119		return cpumask_test_cpu(cpu, (struct cpumask *)cpumask);
   120	}
   121	
 > 122	bool bpf_cpumask_test_and_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
   123	{
   124		if (!cpu_valid(cpu))
   125			return false;
   126	
   127		return cpumask_test_and_set_cpu(cpu, (struct cpumask *)cpumask);
   128	}
   129	
 > 130	bool bpf_cpumask_test_and_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
   131	{
   132		if (!cpu_valid(cpu))
   133			return false;
   134	
   135		return cpumask_test_and_clear_cpu(cpu, (struct cpumask *)cpumask);
   136	}
   137	
 > 138	void bpf_cpumask_setall(struct bpf_cpumask *cpumask)
   139	{
   140		cpumask_setall((struct cpumask *)cpumask);
   141	}
   142	
 > 143	void bpf_cpumask_clear(struct bpf_cpumask *cpumask)
   144	{
   145		cpumask_clear((struct cpumask *)cpumask);
   146	}
   147	
 > 148	bool bpf_cpumask_and(struct bpf_cpumask *dst,
   149			     const struct cpumask *src1,
   150			     const struct cpumask *src2)
   151	{
   152		return cpumask_and((struct cpumask *)dst, src1, src2);
   153	}
   154	
 > 155	void bpf_cpumask_or(struct bpf_cpumask *dst,
   156			    const struct cpumask *src1,
   157			    const struct cpumask *src2)
   158	{
   159		cpumask_or((struct cpumask *)dst, src1, src2);
   160	}
   161	
 > 162	void bpf_cpumask_xor(struct bpf_cpumask *dst,
   163			     const struct cpumask *src1,
   164			     const struct cpumask *src2)
   165	{
   166		cpumask_xor((struct cpumask *)dst, src1, src2);
   167	}
   168	
 > 169	bool bpf_cpumask_equal(const struct cpumask *src1, const struct cpumask *src2)
   170	{
   171		return cpumask_equal(src1, src2);
   172	}
   173	
 > 174	bool bpf_cpumask_intersects(const struct cpumask *src1, const struct cpumask *src2)
   175	{
   176		return cpumask_intersects(src1, src2);
   177	}
   178	
 > 179	bool bpf_cpumask_subset(const struct cpumask *src1, const struct cpumask *src2)
   180	{
   181		return cpumask_subset(src1, src2);
   182	}
   183	
 > 184	bool bpf_cpumask_empty(const struct cpumask *cpumask)
   185	{
   186		return cpumask_empty(cpumask);
   187	}
   188	
 > 189	bool bpf_cpumask_full(const struct cpumask *cpumask)
   190	{
   191		return cpumask_full(cpumask);
   192	}
   193	
 > 194	void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src)
   195	{
   196		cpumask_copy((struct cpumask *)dst, src);
   197	}
   198	
 > 199	u32 bpf_cpumask_any(const struct cpumask *cpumask)
   200	{
   201		return cpumask_any(cpumask);
   202	}
   203	
 > 204	u32 bpf_cpumask_any_and(const struct cpumask *src1, const struct cpumask *src2)
   205	{
   206		return cpumask_any_and(src1, src2);
   207	}
   208	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
