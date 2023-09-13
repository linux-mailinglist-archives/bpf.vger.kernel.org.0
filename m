Return-Path: <bpf+bounces-9879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AB879E342
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 11:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C85C281F19
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 09:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D926E1DDD0;
	Wed, 13 Sep 2023 09:13:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0CC1DDCB
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 09:13:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1062C1BC2;
	Wed, 13 Sep 2023 02:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694596390; x=1726132390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UI7Qbv2ISxSWzVTtCLjJhlZfMYW9yi+U3VgE2/7eP5M=;
  b=h+iqKoyfahZv56xDh7FKJYwrqjdPzGCjclznRNWlnsSK9oBlxG5nkGC3
   RGWvntAC7/9P4xdrT0VkE7f9BFtmJLV/NYWQKOnm9SAuhj+z8W8EAAa2u
   kkIhjgvT4GcBkhDmbt5vdeubrF/MN8m5Cy6unWshh42Qi6ofNPf51rN1g
   LMitPhDCv1KQZbhEAK89j87YxRgFY+upYxWnmfgiVgbcOd7vJ1GP9R4Vi
   sB8fMAxUueiliaKRn1XCFOYU+YhpZUnTemFIxVzWfyHwag7afGkQYve/r
   rqBlkPm/WAPUWuXX7E/sRiODGxvK78ue/JtEihkK06ZK0KQTFdHPBcakW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="445046171"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="445046171"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 02:13:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="693786102"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="693786102"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Sep 2023 02:13:06 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qgLvk-0000K1-13;
	Wed, 13 Sep 2023 09:13:04 +0000
Date: Wed, 13 Sep 2023 17:13:00 +0800
From: kernel test robot <lkp@intel.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	tj@kernel.org, linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [PATCH bpf-next v2 4/6] bpf: Introduce css_descendant open-coded
 iterator kfuncs
Message-ID: <202309131634.hJlxw7NA-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuyi-Zhou/cgroup-Prepare-for-using-css_task_iter_-in-BPF/20230912-150454
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230912070149.969939-5-zhouchuyi%40bytedance.com
patch subject: [PATCH bpf-next v2 4/6] bpf: Introduce css_descendant open-coded iterator kfuncs
config: arm-randconfig-r032-20230913 (https://download.01.org/0day-ci/archive/20230913/202309131634.hJlxw7NA-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131634.hJlxw7NA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131634.hJlxw7NA-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/task_iter.c:810:17: warning: no previous prototype for function 'bpf_iter_css_task_new' [-Wmissing-prototypes]
     810 | __bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
         |                 ^
   kernel/bpf/task_iter.c:810:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     810 | __bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
         |             ^
         |             static 
   kernel/bpf/task_iter.c:835:33: warning: no previous prototype for function 'bpf_iter_css_task_next' [-Wmissing-prototypes]
     835 | __bpf_kfunc struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it)
         |                                 ^
   kernel/bpf/task_iter.c:835:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     835 | __bpf_kfunc struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it)
         |             ^
         |             static 
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
   kernel/bpf/task_iter.c:888:17: warning: no previous prototype for function 'bpf_iter_css_pre_new' [-Wmissing-prototypes]
     888 | __bpf_kfunc int bpf_iter_css_pre_new(struct bpf_iter_css_pre *it,
         |                 ^
   kernel/bpf/task_iter.c:888:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     888 | __bpf_kfunc int bpf_iter_css_pre_new(struct bpf_iter_css_pre *it,
         |             ^
         |             static 
   kernel/bpf/task_iter.c:900:41: warning: no previous prototype for function 'bpf_iter_css_pre_next' [-Wmissing-prototypes]
     900 | __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_pre_next(struct bpf_iter_css_pre *it)
         |                                         ^
   kernel/bpf/task_iter.c:900:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     900 | __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_pre_next(struct bpf_iter_css_pre *it)
         |             ^
         |             static 
   kernel/bpf/task_iter.c:908:18: warning: no previous prototype for function 'bpf_iter_css_pre_destroy' [-Wmissing-prototypes]
     908 | __bpf_kfunc void bpf_iter_css_pre_destroy(struct bpf_iter_css_pre *it)
         |                  ^
   kernel/bpf/task_iter.c:908:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     908 | __bpf_kfunc void bpf_iter_css_pre_destroy(struct bpf_iter_css_pre *it)
         |             ^
         |             static 
   kernel/bpf/task_iter.c:912:17: warning: no previous prototype for function 'bpf_iter_css_post_new' [-Wmissing-prototypes]
     912 | __bpf_kfunc int bpf_iter_css_post_new(struct bpf_iter_css_post *it,
         |                 ^
   kernel/bpf/task_iter.c:912:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     912 | __bpf_kfunc int bpf_iter_css_post_new(struct bpf_iter_css_post *it,
         |             ^
         |             static 
   kernel/bpf/task_iter.c:924:41: warning: no previous prototype for function 'bpf_iter_css_post_next' [-Wmissing-prototypes]
     924 | __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_post_next(struct bpf_iter_css_post *it)
         |                                         ^
   kernel/bpf/task_iter.c:924:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     924 | __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_post_next(struct bpf_iter_css_post *it)
         |             ^
         |             static 
   kernel/bpf/task_iter.c:932:18: warning: no previous prototype for function 'bpf_iter_css_post_destroy' [-Wmissing-prototypes]
     932 | __bpf_kfunc void bpf_iter_css_post_destroy(struct bpf_iter_css_post *it)
         |                  ^
   kernel/bpf/task_iter.c:932:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
     932 | __bpf_kfunc void bpf_iter_css_post_destroy(struct bpf_iter_css_post *it)
         |             ^
         |             static 
>> kernel/bpf/task_iter.c:893:2: error: call to '__compiletime_assert_389' declared with 'error' attribute: BUILD_BUG_ON failed: sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css_pre)
     893 |         BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css_pre));
         |         ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:425:2: note: expanded from macro 'compiletime_assert'
     425 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:413:2: note: expanded from macro '_compiletime_assert'
     413 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:406:4: note: expanded from macro '__compiletime_assert'
     406 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:6:1: note: expanded from here
       6 | __compiletime_assert_389
         | ^
>> kernel/bpf/task_iter.c:917:2: error: call to '__compiletime_assert_391' declared with 'error' attribute: BUILD_BUG_ON failed: sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css_post)
     917 |         BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css_post));
         |         ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:425:2: note: expanded from macro 'compiletime_assert'
     425 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:413:2: note: expanded from macro '_compiletime_assert'
     413 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:406:4: note: expanded from macro '__compiletime_assert'
     406 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:14:1: note: expanded from here
      14 | __compiletime_assert_391
         | ^
   12 warnings and 2 errors generated.


vim +893 kernel/bpf/task_iter.c

   887	
   888	__bpf_kfunc int bpf_iter_css_pre_new(struct bpf_iter_css_pre *it,
   889			struct cgroup_subsys_state *root)
   890	{
   891		struct bpf_iter_css_kern *kit = (void *)it;
   892	
 > 893		BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css_pre));
   894		BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) != __alignof__(struct bpf_iter_css_pre));
   895		kit->root = root;
   896		kit->pos = NULL;
   897		return 0;
   898	}
   899	
   900	__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_pre_next(struct bpf_iter_css_pre *it)
   901	{
   902		struct bpf_iter_css_kern *kit = (void *)it;
   903	
   904		kit->pos = css_next_descendant_pre(kit->pos, kit->root);
   905		return kit->pos;
   906	}
   907	
   908	__bpf_kfunc void bpf_iter_css_pre_destroy(struct bpf_iter_css_pre *it)
   909	{
   910	}
   911	
   912	__bpf_kfunc int bpf_iter_css_post_new(struct bpf_iter_css_post *it,
   913			struct cgroup_subsys_state *root)
   914	{
   915		struct bpf_iter_css_kern *kit = (void *)it;
   916	
 > 917		BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css_post));
   918		BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) != __alignof__(struct bpf_iter_css_post));
   919		kit->root = root;
   920		kit->pos = NULL;
   921		return 0;
   922	}
   923	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

