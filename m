Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A3169F315
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 12:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjBVLBR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 06:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjBVLBQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 06:01:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EEC38674
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 03:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677063675; x=1708599675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rdcpkSkVjM+SqRRdobfsImTfB/ySxzYGHClmkYUhqsM=;
  b=eLgb3pBJwxGsuPbjkOrISfhJ12IGuCmOyUVScbY72mLruPlnAo2WOb2c
   GCnX7IrggqrT997V2OLP57jHfqWlZzRn5Qgf1f3gYEXkv5lhAkMELRFaE
   v7345WcgL4tvLpr6zX4Q8FluWFShImcuF/F1/8YeDTRljHz+/HugRxr8f
   Haq5kgWBlme2NzkAYTqgu8ygElxyGk9sFKfbDwoeS5OJZvjsn6ptRvyhX
   Ijwz6NEQYUr3nOM3oQNNrzPvhYDBn4BPE76C7st0tlH/iCPkhV0tHqBby
   3hvsxwi6mDbhFuqkn1xHuWAib/jzXfelA0SZ2RfuUO4X8VKXR5q3JutnV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="330620769"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="330620769"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 03:01:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="795864675"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="795864675"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Feb 2023 03:01:10 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUms1-0000HV-2a;
        Wed, 22 Feb 2023 11:01:09 +0000
Date:   Wed, 22 Feb 2023 19:01:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, horenc@vt.edu, xiyou.wangcong@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next v2 17/18] bpf: offload map memory usage
Message-ID: <202302221852.mOd5T9T6-lkp@intel.com>
References: <20230222014553.47744-18-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222014553.47744-18-laoar.shao@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yafang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/bpf-add-new-map-ops-map_mem_usage/20230222-094856
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230222014553.47744-18-laoar.shao%40gmail.com
patch subject: [PATCH bpf-next v2 17/18] bpf: offload map memory usage
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20230222/202302221852.mOd5T9T6-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/e5742e839659b59ea26bc7a5804d04e577604aab
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yafang-Shao/bpf-add-new-map-ops-map_mem_usage/20230222-094856
        git checkout e5742e839659b59ea26bc7a5804d04e577604aab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302221852.mOd5T9T6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/fork.c:98:
>> include/linux/bpf.h:2644:1: error: expected identifier or '(' before '{' token
    2644 | {
         | ^
   kernel/fork.c:162:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     162 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:862:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     862 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:957:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     957 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
   In file included from kernel/fork.c:98:
   include/linux/bpf.h:2643:19: warning: 'bpf_map_offload_map_mem_usage' declared 'static' but never defined [-Wunused-function]
    2643 | static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:9,
                    from kernel/sysctl.c:35:
>> include/linux/bpf.h:2644:1: error: expected identifier or '(' before '{' token
    2644 | {
         | ^
   In file included from include/linux/filter.h:9,
                    from kernel/sysctl.c:35:
   include/linux/bpf.h:2643:19: warning: 'bpf_map_offload_map_mem_usage' declared 'static' but never defined [-Wunused-function]
    2643 | static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:9,
                    from kernel/kallsyms.c:25:
>> include/linux/bpf.h:2644:1: error: expected identifier or '(' before '{' token
    2644 | {
         | ^
   kernel/kallsyms.c:663:12: warning: no previous prototype for 'arch_get_kallsym' [-Wmissing-prototypes]
     663 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
         |            ^~~~~~~~~~~~~~~~
   In file included from include/linux/filter.h:9,
                    from kernel/kallsyms.c:25:
   include/linux/bpf.h:2643:19: warning: 'bpf_map_offload_map_mem_usage' declared 'static' but never defined [-Wunused-function]
    2643 | static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/bpf-cgroup.h:5,
                    from net/socket.c:55:
>> include/linux/bpf.h:2644:1: error: expected identifier or '(' before '{' token
    2644 | {
         | ^
   net/socket.c: In function '__sys_getsockopt':
   net/socket.c:2300:13: warning: variable 'max_optlen' set but not used [-Wunused-but-set-variable]
    2300 |         int max_optlen;
         |             ^~~~~~~~~~
   In file included from include/linux/bpf-cgroup.h:5,
                    from net/socket.c:55:
   net/socket.c: At top level:
   include/linux/bpf.h:2643:19: warning: 'bpf_map_offload_map_mem_usage' declared 'static' but never defined [-Wunused-function]
    2643 | static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:9,
                    from kernel/bpf/core.c:21:
>> include/linux/bpf.h:2644:1: error: expected identifier or '(' before '{' token
    2644 | {
         | ^
   kernel/bpf/core.c:1631:12: warning: no previous prototype for 'bpf_probe_read_kernel' [-Wmissing-prototypes]
    1631 | u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
         |            ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/core.c:2070:6: warning: no previous prototype for 'bpf_patch_call_args' [-Wmissing-prototypes]
    2070 | void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
         |      ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/filter.h:9,
                    from kernel/bpf/core.c:21:
   include/linux/bpf.h:2643:19: warning: 'bpf_map_offload_map_mem_usage' declared 'static' but never defined [-Wunused-function]
    2643 | static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/filter.h:9,
                    from include/net/sock_reuseport.h:5,
                    from include/net/tcp.h:35,
                    from net/ipv4/route.c:95:
>> include/linux/bpf.h:2644:1: error: expected identifier or '(' before '{' token
    2644 | {
         | ^
   net/ipv4/route.c: In function 'ip_rt_send_redirect':
   net/ipv4/route.c:880:13: warning: variable 'log_martians' set but not used [-Wunused-but-set-variable]
     880 |         int log_martians;
         |             ^~~~~~~~~~~~
   In file included from include/linux/filter.h:9,
                    from include/net/sock_reuseport.h:5,
                    from include/net/tcp.h:35,
                    from net/ipv4/route.c:95:
   net/ipv4/route.c: At top level:
   include/linux/bpf.h:2643:19: warning: 'bpf_map_offload_map_mem_usage' declared 'static' but never defined [-Wunused-function]
    2643 | static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +2644 include/linux/bpf.h

  2642	
  2643	static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);
> 2644	{
  2645		return 0;
  2646	}
  2647	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
