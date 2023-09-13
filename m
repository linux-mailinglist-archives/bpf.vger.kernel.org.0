Return-Path: <bpf+bounces-9872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0E979E0D1
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 09:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC4D281D74
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 07:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2D81DA2B;
	Wed, 13 Sep 2023 07:27:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CF414F92
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 07:27:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4837C1727;
	Wed, 13 Sep 2023 00:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694590053; x=1726126053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xdNcP7YzTuO/KtXmc0b2clcxVqK94aaCrneS0dMIvoo=;
  b=Y+orIYEOKl68ADSyNOoH/H4417m9InkXST+aD0QCJTiJJJc+rCFMxUDP
   Mz6RW+klKH2UCWPpQBYDIbtwppJ+YiXi90apOxzqONq7s9W1NhuGnA/K6
   GdTZTYav4aOmmEjug8fWX2PzbDMcd97zKxrWAZStO2MEQXRscKRKPdbG5
   WRmiCXKsaaDSZEw7DHdiUglNAO10JMYNNAop4+BLMPYXd1pBYC/3zA73c
   ef/dQH4JHkIKZHgWM0MRsF1NpvEjvx9ejU21Da/d6deuqp3Bj4dK7rIEg
   EmRdO6XbSxAzBEh/HjkRuTqD5vc9OQD6WXaBv9LggEohpc8hoteAXenYf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358862273"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="358862273"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 00:27:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="773349016"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="773349016"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Sep 2023 00:27:15 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qgKGS-0000CX-1Q;
	Wed, 13 Sep 2023 07:26:30 +0000
Date: Wed, 13 Sep 2023 15:25:02 +0800
From: kernel test robot <lkp@intel.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
	linux-kernel@vger.kernel.org, Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [PATCH bpf-next v2 4/6] bpf: Introduce css_descendant open-coded
 iterator kfuncs
Message-ID: <202309131500.J19z0Dil-lkp@intel.com>
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
config: s390-defconfig (https://download.01.org/0day-ci/archive/20230913/202309131500.J19z0Dil-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131500.J19z0Dil-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131500.J19z0Dil-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/task_iter.c:810:17: warning: no previous prototype for 'bpf_iter_css_task_new' [-Wmissing-prototypes]
     810 | __bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
         |                 ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/task_iter.c:835:33: warning: no previous prototype for 'bpf_iter_css_task_next' [-Wmissing-prototypes]
     835 | __bpf_kfunc struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/task_iter.c:844:18: warning: no previous prototype for 'bpf_iter_css_task_destroy' [-Wmissing-prototypes]
     844 | __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/task_iter.c:858:17: warning: no previous prototype for 'bpf_iter_process_new' [-Wmissing-prototypes]
     858 | __bpf_kfunc int bpf_iter_process_new(struct bpf_iter_process *it)
         |                 ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/task_iter.c:870:33: warning: no previous prototype for 'bpf_iter_process_next' [-Wmissing-prototypes]
     870 | __bpf_kfunc struct task_struct *bpf_iter_process_next(struct bpf_iter_process *it)
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/task_iter.c:879:18: warning: no previous prototype for 'bpf_iter_process_destroy' [-Wmissing-prototypes]
     879 | __bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_process *it)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/task_iter.c:888:17: warning: no previous prototype for 'bpf_iter_css_pre_new' [-Wmissing-prototypes]
     888 | __bpf_kfunc int bpf_iter_css_pre_new(struct bpf_iter_css_pre *it,
         |                 ^~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/task_iter.c:900:41: warning: no previous prototype for 'bpf_iter_css_pre_next' [-Wmissing-prototypes]
     900 | __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_pre_next(struct bpf_iter_css_pre *it)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/task_iter.c:908:18: warning: no previous prototype for 'bpf_iter_css_pre_destroy' [-Wmissing-prototypes]
     908 | __bpf_kfunc void bpf_iter_css_pre_destroy(struct bpf_iter_css_pre *it)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/task_iter.c:912:17: warning: no previous prototype for 'bpf_iter_css_post_new' [-Wmissing-prototypes]
     912 | __bpf_kfunc int bpf_iter_css_post_new(struct bpf_iter_css_post *it,
         |                 ^~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/task_iter.c:924:41: warning: no previous prototype for 'bpf_iter_css_post_next' [-Wmissing-prototypes]
     924 | __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_post_next(struct bpf_iter_css_post *it)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/task_iter.c:932:18: warning: no previous prototype for 'bpf_iter_css_post_destroy' [-Wmissing-prototypes]
     932 | __bpf_kfunc void bpf_iter_css_post_destroy(struct bpf_iter_css_post *it)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/bpf_iter_css_pre_new +888 kernel/bpf/task_iter.c

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
   904		kit->pos = css_next_descendant_pre(kit->pos, kit->root);
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
   928		kit->pos = css_next_descendant_post(kit->pos, kit->root);
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

