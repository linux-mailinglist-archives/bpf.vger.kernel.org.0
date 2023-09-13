Return-Path: <bpf+bounces-9878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24A179E2E1
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 11:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BFD281A46
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 09:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A691DDC8;
	Wed, 13 Sep 2023 09:03:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC571DA3D
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 09:03:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5D81997;
	Wed, 13 Sep 2023 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694595790; x=1726131790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dxa1s4XwKeXVgdc9qv9AkmCDwZA82OCSSHsyB65KS+w=;
  b=RApvCs1+K2BlokCwi0aOEewPYwRUu2LPzKhERISVwBQx3ekDzsHeff1n
   oCAZa6Nd5cRzx6u9fOiUuZiwGWv/mXQl1m95KFql29kxbHO68Jh19fsjj
   cdG3D5lDBwOIjm3Fnha502+yjJByENBPWKM3uwNx1yPuMY80Sj3gNKHLx
   hv8FEwCWlXQ1QaLyUHI3ETqokoZASdVYzx9cm4ARjJjwWsBr9c9aYGex3
   g0Wv07yIEArU3proOf113Z9DyF3HEbCeMISqj4y65MU9VuAVbkA0w+l+B
   rKbLl5KhmkJe9vEOMqbJQS+4egplVyjXHdYnJUYcZCnl3/DraKyxOYOZZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="442637177"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="442637177"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 02:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="887253870"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="887253870"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 13 Sep 2023 02:02:36 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qgLm3-0000It-1b;
	Wed, 13 Sep 2023 09:03:03 +0000
Date: Wed, 13 Sep 2023 17:02:45 +0800
From: kernel test robot <lkp@intel.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	tj@kernel.org, linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [PATCH bpf-next v2 4/6] bpf: Introduce css_descendant open-coded
 iterator kfuncs
Message-ID: <202309131621.h5ogfV0Z-lkp@intel.com>
References: <20230912070149.969939-5-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912070149.969939-5-zhouchuyi@bytedance.com>

Hi Chuyi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuyi-Zhou/cgroup-Prepare-for-using-css_task_iter_-in-BPF/20230912-150454
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230912070149.969939-5-zhouchuyi%40bytedance.com
patch subject: [PATCH bpf-next v2 4/6] bpf: Introduce css_descendant open-coded iterator kfuncs
config: hexagon-randconfig-r032-20230913 (https://download.01.org/0day-ci/archive/20230913/202309131621.h5ogfV0Z-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131621.h5ogfV0Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131621.h5ogfV0Z-lkp@intel.com/

All warnings (new ones prefixed by >>):

     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from kernel/bpf/task_iter.c:9:
   In file included from include/linux/filter.h:9:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   kernel/bpf/task_iter.c:820:7: error: use of undeclared identifier 'CSS_TASK_ITER_PROCS'
     820 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
         |              ^
   kernel/bpf/task_iter.c:820:29: error: use of undeclared identifier 'CSS_TASK_ITER_THREADED'
     820 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
         |                                    ^
   kernel/bpf/task_iter.c:821:7: error: use of undeclared identifier 'CSS_TASK_ITER_PROCS'
     821 |         case CSS_TASK_ITER_PROCS:
         |              ^
   kernel/bpf/task_iter.c:828:24: error: invalid application of 'sizeof' to an incomplete type 'struct css_task_iter'
     828 |         kit->css_it = kzalloc(sizeof(struct css_task_iter), GFP_KERNEL);
         |                               ^     ~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/task_iter.c:807:9: note: forward declaration of 'struct css_task_iter'
     807 |         struct css_task_iter *css_it;
         |                ^
   kernel/bpf/task_iter.c:831:2: error: call to undeclared function 'css_task_iter_start'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     831 |         css_task_iter_start(css, flags, kit->css_it);
         |         ^
   kernel/bpf/task_iter.c:831:2: note: did you mean '__sg_page_iter_start'?
   include/linux/scatterlist.h:573:6: note: '__sg_page_iter_start' declared here
     573 | void __sg_page_iter_start(struct sg_page_iter *piter,
         |      ^
   kernel/bpf/task_iter.c:810:17: warning: no previous prototype for function 'bpf_iter_css_task_new' [-Wmissing-prototypes]
     810 | __bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
         |                 ^
   kernel/bpf/task_iter.c:810:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     810 | __bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
         |             ^
         |             static 
   kernel/bpf/task_iter.c:841:9: error: call to undeclared function 'css_task_iter_next'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     841 |         return css_task_iter_next(kit->css_it);
         |                ^
   kernel/bpf/task_iter.c:841:9: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'struct task_struct *' [-Wint-conversion]
     841 |         return css_task_iter_next(kit->css_it);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/task_iter.c:835:33: warning: no previous prototype for function 'bpf_iter_css_task_next' [-Wmissing-prototypes]
     835 | __bpf_kfunc struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it)
         |                                 ^
   kernel/bpf/task_iter.c:835:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     835 | __bpf_kfunc struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it)
         |             ^
         |             static 
   kernel/bpf/task_iter.c:850:2: error: call to undeclared function 'css_task_iter_end'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     850 |         css_task_iter_end(kit->css_it);
         |         ^
   kernel/bpf/task_iter.c:844:18: warning: no previous prototype for function 'bpf_iter_css_task_destroy' [-Wmissing-prototypes]
     844 | __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
         |                  ^
   kernel/bpf/task_iter.c:844:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     844 | __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
         |             ^
         |             static 
   kernel/bpf/task_iter.c:858:17: warning: no previous prototype for function 'bpf_iter_process_new' [-Wmissing-prototypes]
     858 | __bpf_kfunc int bpf_iter_process_new(struct bpf_iter_process *it)
         |                 ^
   kernel/bpf/task_iter.c:858:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     858 | __bpf_kfunc int bpf_iter_process_new(struct bpf_iter_process *it)
         |             ^
         |             static 
   kernel/bpf/task_iter.c:870:33: warning: no previous prototype for function 'bpf_iter_process_next' [-Wmissing-prototypes]
     870 | __bpf_kfunc struct task_struct *bpf_iter_process_next(struct bpf_iter_process *it)
         |                                 ^
   kernel/bpf/task_iter.c:870:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     870 | __bpf_kfunc struct task_struct *bpf_iter_process_next(struct bpf_iter_process *it)
         |             ^
         |             static 
   kernel/bpf/task_iter.c:879:18: warning: no previous prototype for function 'bpf_iter_process_destroy' [-Wmissing-prototypes]
     879 | __bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_process *it)
         |                  ^
   kernel/bpf/task_iter.c:879:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     879 | __bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_process *it)
         |             ^
         |             static 
>> kernel/bpf/task_iter.c:888:17: warning: no previous prototype for function 'bpf_iter_css_pre_new' [-Wmissing-prototypes]
     888 | __bpf_kfunc int bpf_iter_css_pre_new(struct bpf_iter_css_pre *it,
         |                 ^
   kernel/bpf/task_iter.c:888:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     888 | __bpf_kfunc int bpf_iter_css_pre_new(struct bpf_iter_css_pre *it,
         |             ^
         |             static 
   kernel/bpf/task_iter.c:904:13: error: call to undeclared function 'css_next_descendant_pre'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     904 |         kit->pos = css_next_descendant_pre(kit->pos, kit->root);
         |                    ^
   kernel/bpf/task_iter.c:904:11: error: incompatible integer to pointer conversion assigning to 'struct cgroup_subsys_state *' from 'int' [-Wint-conversion]
     904 |         kit->pos = css_next_descendant_pre(kit->pos, kit->root);
         |                  ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/task_iter.c:900:41: warning: no previous prototype for function 'bpf_iter_css_pre_next' [-Wmissing-prototypes]
     900 | __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_pre_next(struct bpf_iter_css_pre *it)
         |                                         ^
   kernel/bpf/task_iter.c:900:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     900 | __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_pre_next(struct bpf_iter_css_pre *it)
         |             ^
         |             static 
>> kernel/bpf/task_iter.c:908:18: warning: no previous prototype for function 'bpf_iter_css_pre_destroy' [-Wmissing-prototypes]
     908 | __bpf_kfunc void bpf_iter_css_pre_destroy(struct bpf_iter_css_pre *it)
         |                  ^
   kernel/bpf/task_iter.c:908:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     908 | __bpf_kfunc void bpf_iter_css_pre_destroy(struct bpf_iter_css_pre *it)
         |             ^
         |             static 
>> kernel/bpf/task_iter.c:912:17: warning: no previous prototype for function 'bpf_iter_css_post_new' [-Wmissing-prototypes]
     912 | __bpf_kfunc int bpf_iter_css_post_new(struct bpf_iter_css_post *it,
         |                 ^
   kernel/bpf/task_iter.c:912:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     912 | __bpf_kfunc int bpf_iter_css_post_new(struct bpf_iter_css_post *it,
         |             ^
         |             static 
   kernel/bpf/task_iter.c:928:13: error: call to undeclared function 'css_next_descendant_post'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     928 |         kit->pos = css_next_descendant_post(kit->pos, kit->root);
         |                    ^
   kernel/bpf/task_iter.c:928:11: error: incompatible integer to pointer conversion assigning to 'struct cgroup_subsys_state *' from 'int' [-Wint-conversion]
     928 |         kit->pos = css_next_descendant_post(kit->pos, kit->root);
         |                  ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/task_iter.c:924:41: warning: no previous prototype for function 'bpf_iter_css_post_next' [-Wmissing-prototypes]
     924 | __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_post_next(struct bpf_iter_css_post *it)
         |                                         ^
   kernel/bpf/task_iter.c:924:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     924 | __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_post_next(struct bpf_iter_css_post *it)
         |             ^
         |             static 
>> kernel/bpf/task_iter.c:932:18: warning: no previous prototype for function 'bpf_iter_css_post_destroy' [-Wmissing-prototypes]
     932 | __bpf_kfunc void bpf_iter_css_post_destroy(struct bpf_iter_css_post *it)
         |                  ^
   kernel/bpf/task_iter.c:932:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     932 | __bpf_kfunc void bpf_iter_css_post_destroy(struct bpf_iter_css_post *it)
         |             ^
         |             static 
   18 warnings and 12 errors generated.


vim +/bpf_iter_css_pre_new +888 kernel/bpf/task_iter.c

   878	
 > 879	__bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_process *it)
   880	{
   881	}
   882	
   883	struct bpf_iter_css_kern {
   884		struct cgroup_subsys_state *root;
   885		struct cgroup_subsys_state *pos;
   886	} __attribute__((aligned(8)));
   887	
 > 888	__bpf_kfunc int bpf_iter_css_pre_new(struct bpf_iter_css_pre *it,
   889			struct cgroup_subsys_state *root)
   890	{
   891		struct bpf_iter_css_kern *kit = (void *)it;
   892	
   893		BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css_pre));
   894		BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) != __alignof__(struct bpf_iter_css_pre));
   895		kit->root = root;
   896		kit->pos = NULL;
   897		return 0;
   898	}
   899	
 > 900	__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_pre_next(struct bpf_iter_css_pre *it)
   901	{
   902		struct bpf_iter_css_kern *kit = (void *)it;
   903	
 > 904		kit->pos = css_next_descendant_pre(kit->pos, kit->root);
   905		return kit->pos;
   906	}
   907	
 > 908	__bpf_kfunc void bpf_iter_css_pre_destroy(struct bpf_iter_css_pre *it)
   909	{
   910	}
   911	
 > 912	__bpf_kfunc int bpf_iter_css_post_new(struct bpf_iter_css_post *it,
   913			struct cgroup_subsys_state *root)
   914	{
   915		struct bpf_iter_css_kern *kit = (void *)it;
   916	
   917		BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css_post));
   918		BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) != __alignof__(struct bpf_iter_css_post));
   919		kit->root = root;
   920		kit->pos = NULL;
   921		return 0;
   922	}
   923	
 > 924	__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_post_next(struct bpf_iter_css_post *it)
   925	{
   926		struct bpf_iter_css_kern *kit = (void *)it;
   927	
 > 928		kit->pos = css_next_descendant_post(kit->pos, kit->root);
   929		return kit->pos;
   930	}
   931	
 > 932	__bpf_kfunc void bpf_iter_css_post_destroy(struct bpf_iter_css_post *it)
   933	{
   934	}
   935	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

