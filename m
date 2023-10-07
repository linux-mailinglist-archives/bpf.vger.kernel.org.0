Return-Path: <bpf+bounces-11639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC73E7BC8FD
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 18:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37FE1C20A3F
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 16:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB571328A9;
	Sat,  7 Oct 2023 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKLN4L94"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B130FBD
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 16:06:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C257FB9;
	Sat,  7 Oct 2023 09:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696694773; x=1728230773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n5AFnPXEzN+QKzdl9114Nc4MT/H4AlQFbFyb9f0tsJE=;
  b=IKLN4L94kWQMYIE+DJRjPfVcVm/l2fUX3Wh71EeD5dcKJipJ1mzOSB/K
   cuLY/Qslb4Bjw5Teu99r1GMz08DnOKo1LEPE6lesxx/01C/q598hN/mZl
   3r+7XSC2Pq+5YW4ysy8Ol2IySB1hH3JdgWpAgErK+CkP8Ty80flMXT+6p
   4kj8zOJB3Z7WcTsdl1YrfzXnJEC4O81yLgQijvx/9uJgQAfD/T2Ty0jXx
   6bHHbcsYSR8VMRVrVYdLnjherN/qE5Z1WPlXmUXqIjVc3W1kcinfjKN8b
   tqH6YldVdaRqpGeMZt1Yd3KvM3vZy5wQdfDrk/XdM4bSyVOK8kUYEwcHV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="387806740"
X-IronPort-AV: E=Sophos;i="6.03,206,1694761200"; 
   d="scan'208";a="387806740"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 09:06:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="702413998"
X-IronPort-AV: E=Sophos;i="6.03,206,1694761200"; 
   d="scan'208";a="702413998"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Oct 2023 09:06:10 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qp9oe-0004XN-0m;
	Sat, 07 Oct 2023 16:06:08 +0000
Date: Sun, 8 Oct 2023 00:05:40 +0800
From: kernel test robot <lkp@intel.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
	linux-kernel@vger.kernel.org, Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [PATCH bpf-next v4 4/8] bpf: Introduce css open-coded iterator
 kfuncs
Message-ID: <202310072337.CzRlbffm-lkp@intel.com>
References: <20231007124522.34834-5-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007124522.34834-5-zhouchuyi@bytedance.com>
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
patch link:    https://lore.kernel.org/r/20231007124522.34834-5-zhouchuyi%40bytedance.com
patch subject: [PATCH bpf-next v4 4/8] bpf: Introduce css open-coded iterator kfuncs
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231007/202310072337.CzRlbffm-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310072337.CzRlbffm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310072337.CzRlbffm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/cgroup_iter.c:308:17: warning: no previous prototype for 'bpf_iter_css_new' [-Wmissing-prototypes]
     308 | __bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
         |                 ^~~~~~~~~~~~~~~~
>> kernel/bpf/cgroup_iter.c:332:41: warning: no previous prototype for 'bpf_iter_css_next' [-Wmissing-prototypes]
     332 | __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it)
         |                                         ^~~~~~~~~~~~~~~~~
>> kernel/bpf/cgroup_iter.c:353:18: warning: no previous prototype for 'bpf_iter_css_destroy' [-Wmissing-prototypes]
     353 | __bpf_kfunc void bpf_iter_css_destroy(struct bpf_iter_css *it)
         |                  ^~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
   kernel/bpf/cgroup_iter.c: In function 'bpf_iter_css_new':
   include/linux/compiler_types.h:425:45: error: call to '__compiletime_assert_320' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css)
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
   kernel/bpf/cgroup_iter.c:313:9: note: in expansion of macro 'BUILD_BUG_ON'
     313 |         BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css));
         |         ^~~~~~~~~~~~


vim +/bpf_iter_css_new +308 kernel/bpf/cgroup_iter.c

   307	
 > 308	__bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
   309			struct cgroup_subsys_state *start, unsigned int flags)
   310	{
   311		struct bpf_iter_css_kern *kit = (void *)it;
   312	
   313		BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css));
   314		BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) != __alignof__(struct bpf_iter_css));
   315	
   316		kit->start = NULL;
   317		switch (flags) {
   318		case BPF_CGROUP_ITER_DESCENDANTS_PRE:
   319		case BPF_CGROUP_ITER_DESCENDANTS_POST:
   320		case BPF_CGROUP_ITER_ANCESTORS_UP:
   321			break;
   322		default:
   323			return -EINVAL;
   324		}
   325	
   326		kit->start = start;
   327		kit->pos = NULL;
   328		kit->flags = flags;
   329		return 0;
   330	}
   331	
 > 332	__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it)
   333	{
   334		struct bpf_iter_css_kern *kit = (void *)it;
   335	
   336		if (!kit->start)
   337			return NULL;
   338	
   339		switch (kit->flags) {
   340		case BPF_CGROUP_ITER_DESCENDANTS_PRE:
   341			kit->pos = css_next_descendant_pre(kit->pos, kit->start);
   342			break;
   343		case BPF_CGROUP_ITER_DESCENDANTS_POST:
   344			kit->pos = css_next_descendant_post(kit->pos, kit->start);
   345			break;
   346		case BPF_CGROUP_ITER_ANCESTORS_UP:
   347			kit->pos = kit->pos ? kit->pos->parent : kit->start;
   348		}
   349	
   350		return kit->pos;
   351	}
   352	
 > 353	__bpf_kfunc void bpf_iter_css_destroy(struct bpf_iter_css *it)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

