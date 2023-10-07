Return-Path: <bpf+bounces-11634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C337BC897
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 17:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5428C1C20A26
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 15:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC032AB47;
	Sat,  7 Oct 2023 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUjXKWyT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62082AB23
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 15:23:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77D6B9;
	Sat,  7 Oct 2023 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696692188; x=1728228188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IpRc5z4WmRriEfJzf4b+NZsALKWf/jfHlw4bf5iX+2k=;
  b=FUjXKWyTuoqOQjgLEYP6n7yHVRO35Jmi7ERolAedAY0QSmH2nX+lkp8n
   afnuqmPnVWyQDa0hD/nEd7rdfLh21AZoENIA6blY8EBChIQzgn8LKSxjs
   CsgEu18p2hcoEXrWUqFQoytlaXFJMaeU4zGJcRwQ6/BJu0IS9YE+K5iuX
   FeiN0TtntbaB6pqkf9hxd/kqgHW3nE+1NYdhWeRmmbNiFO7AB+S5x1yMe
   tlC84wP42p894j/beZ9qVCn8EX6Yb13Mk0Wsx6z0fiS0f3LkmTyLoNde0
   1NF8CnFXyh48xkFj463V20ClUWKP3eUR22p4QOR/gmsIZ+QSYW7PIZgtC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="382795274"
X-IronPort-AV: E=Sophos;i="6.03,206,1694761200"; 
   d="scan'208";a="382795274"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 08:23:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="868720578"
X-IronPort-AV: E=Sophos;i="6.03,206,1694761200"; 
   d="scan'208";a="868720578"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Oct 2023 08:23:05 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qp98x-0004UH-2p;
	Sat, 07 Oct 2023 15:23:03 +0000
Date: Sat, 7 Oct 2023 23:22:46 +0800
From: kernel test robot <lkp@intel.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
	linux-kernel@vger.kernel.org, Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [PATCH bpf-next v4 3/8] bpf: Introduce task open coded iterator
 kfuncs
Message-ID: <202310072354.0oARP80g-lkp@intel.com>
References: <20231007124522.34834-4-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007124522.34834-4-zhouchuyi@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Chuyi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuyi-Zhou/cgroup-Prepare-for-using-css_task_iter_-in-BPF/20231007-204750
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231007124522.34834-4-zhouchuyi%40bytedance.com
patch subject: [PATCH bpf-next v4 3/8] bpf: Introduce task open coded iterator kfuncs
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231007/202310072354.0oARP80g-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310072354.0oARP80g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310072354.0oARP80g-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/task_iter.c:815:17: warning: no previous prototype for 'bpf_iter_css_task_new' [-Wmissing-prototypes]
     815 | __bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
         |                 ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/task_iter.c:840:33: warning: no previous prototype for 'bpf_iter_css_task_next' [-Wmissing-prototypes]
     840 | __bpf_kfunc struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/task_iter.c:849:18: warning: no previous prototype for 'bpf_iter_css_task_destroy' [-Wmissing-prototypes]
     849 | __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/task_iter.c:875:17: warning: no previous prototype for 'bpf_iter_task_new' [-Wmissing-prototypes]
     875 | __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
         |                 ^~~~~~~~~~~~~~~~~
>> kernel/bpf/task_iter.c:903:33: warning: no previous prototype for 'bpf_iter_task_next' [-Wmissing-prototypes]
     903 | __bpf_kfunc struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it)
         |                                 ^~~~~~~~~~~~~~~~~~
>> kernel/bpf/task_iter.c:937:18: warning: no previous prototype for 'bpf_iter_task_destroy' [-Wmissing-prototypes]
     937 | __bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
         |                  ^~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
   kernel/bpf/task_iter.c: In function 'bpf_iter_task_new':
   include/linux/compiler_types.h:425:45: error: call to '__compiletime_assert_438' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct bpf_iter_task_kern) != sizeof(struct bpf_iter_task)
     425 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:406:25: note: in definition of macro '__compiletime_assert'
     406 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:425:9: note: in expansion of macro '_compiletime_assert'
     425 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   kernel/bpf/task_iter.c:880:9: note: in expansion of macro 'BUILD_BUG_ON'
     880 |         BUILD_BUG_ON(sizeof(struct bpf_iter_task_kern) != sizeof(struct bpf_iter_task));
         |         ^~~~~~~~~~~~


vim +/bpf_iter_task_new +875 kernel/bpf/task_iter.c

   814	
 > 815	__bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
   816			struct cgroup_subsys_state *css, unsigned int flags)
   817	{
   818		struct bpf_iter_css_task_kern *kit = (void *)it;
   819	
   820		BUILD_BUG_ON(sizeof(struct bpf_iter_css_task_kern) != sizeof(struct bpf_iter_css_task));
   821		BUILD_BUG_ON(__alignof__(struct bpf_iter_css_task_kern) !=
   822						__alignof__(struct bpf_iter_css_task));
   823		kit->css_it = NULL;
   824		switch (flags) {
   825		case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
   826		case CSS_TASK_ITER_PROCS:
   827		case 0:
   828			break;
   829		default:
   830			return -EINVAL;
   831		}
   832	
   833		kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct css_task_iter));
   834		if (!kit->css_it)
   835			return -ENOMEM;
   836		css_task_iter_start(css, flags, kit->css_it);
   837		return 0;
   838	}
   839	
 > 840	__bpf_kfunc struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it)
   841	{
   842		struct bpf_iter_css_task_kern *kit = (void *)it;
   843	
   844		if (!kit->css_it)
   845			return NULL;
   846		return css_task_iter_next(kit->css_it);
   847	}
   848	
 > 849	__bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
   850	{
   851		struct bpf_iter_css_task_kern *kit = (void *)it;
   852	
   853		if (!kit->css_it)
   854			return;
   855		css_task_iter_end(kit->css_it);
   856		bpf_mem_free(&bpf_global_ma, kit->css_it);
   857	}
   858	
   859	struct bpf_iter_task {
   860		__u64 __opaque[3];
   861	} __attribute__((aligned(8)));
   862	
   863	struct bpf_iter_task_kern {
   864		struct task_struct *task;
   865		struct task_struct *pos;
   866		unsigned int flags;
   867	} __attribute__((aligned(8)));
   868	
   869	enum {
   870		BPF_TASK_ITER_ALL_PROCS,
   871		BPF_TASK_ITER_ALL_THREADS,
   872		BPF_TASK_ITER_PROC_THREADS
   873	};
   874	
 > 875	__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
   876			struct task_struct *task, unsigned int flags)
   877	{
   878		struct bpf_iter_task_kern *kit = (void *)it;
   879	
   880		BUILD_BUG_ON(sizeof(struct bpf_iter_task_kern) != sizeof(struct bpf_iter_task));
   881		BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=
   882						__alignof__(struct bpf_iter_task));
   883	
   884		kit->task = kit->pos = NULL;
   885		switch (flags) {
   886		case BPF_TASK_ITER_ALL_THREADS:
   887		case BPF_TASK_ITER_ALL_PROCS:
   888		case BPF_TASK_ITER_PROC_THREADS:
   889			break;
   890		default:
   891			return -EINVAL;
   892		}
   893	
   894		if (flags == BPF_TASK_ITER_PROC_THREADS)
   895			kit->task = task;
   896		else
   897			kit->task = &init_task;
   898		kit->pos = kit->task;
   899		kit->flags = flags;
   900		return 0;
   901	}
   902	
 > 903	__bpf_kfunc struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it)
   904	{
   905		struct bpf_iter_task_kern *kit = (void *)it;
   906		struct task_struct *pos;
   907		unsigned int flags;
   908	
   909		flags = kit->flags;
   910		pos = kit->pos;
   911	
   912		if (!pos)
   913			goto out;
   914	
   915		if (flags == BPF_TASK_ITER_ALL_PROCS)
   916			goto get_next_task;
   917	
   918		kit->pos = next_thread(kit->pos);
   919		if (kit->pos == kit->task) {
   920			if (flags == BPF_TASK_ITER_PROC_THREADS) {
   921				kit->pos = NULL;
   922				goto out;
   923			}
   924		} else
   925			goto out;
   926	
   927	get_next_task:
   928		kit->pos = next_task(kit->pos);
   929		kit->task = kit->pos;
   930		if (kit->pos == &init_task)
   931			kit->pos = NULL;
   932	
   933	out:
   934		return pos;
   935	}
   936	
 > 937	__bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
   938	{
   939	}
   940	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

