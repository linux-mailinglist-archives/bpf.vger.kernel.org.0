Return-Path: <bpf+bounces-11633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4307BC85F
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 16:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37921C209F3
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 14:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0208D286BE;
	Sat,  7 Oct 2023 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLq3EuXO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE63171C2
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 14:41:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E75BF;
	Sat,  7 Oct 2023 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696689667; x=1728225667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JQHNSle2ueyfdO9Mt/f52EyzsjPdPwIj0SvbjbMA0QU=;
  b=HLq3EuXOHCkv4gWJA2KamJkO8zygRJIRo1IqgZFToNuSRrzqHWicxGoD
   LXAgGa2b1u36ILgdFz0m1QnJHFFAlRkBcs0EvsAUzr7/Jx8uQaa84sAHp
   hT6k8JLC7xkBnBnUqTKO/uWNwoJJ7SyKNyKScGIBcqkYQCaWgYN/alPSP
   MZSqMMAdY5otUoIMFl2/YU++Ij+UDyA6fOnf5zcz4tvcns6nAXb+ChgkJ
   v62wdAp2nkD6lJ/IcsO6ilI/Ll/yuo2yZg2K4pOkY0gnP7IQIkkSXlNck
   MMGd9sLdroVVVZAfWW2jODP7v0Qalt752XIbTy1hEcD8CJNeOXwqREbS5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="448123687"
X-IronPort-AV: E=Sophos;i="6.03,206,1694761200"; 
   d="scan'208";a="448123687"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 07:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="782003461"
X-IronPort-AV: E=Sophos;i="6.03,206,1694761200"; 
   d="scan'208";a="782003461"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Oct 2023 07:41:03 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qp8UH-0004SK-1o;
	Sat, 07 Oct 2023 14:41:01 +0000
Date: Sat, 7 Oct 2023 22:40:38 +0800
From: kernel test robot <lkp@intel.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
	linux-kernel@vger.kernel.org, Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Introduce css_task open-coded
 iterator kfuncs
Message-ID: <202310072246.OfAldQpf-lkp@intel.com>
References: <20231007124522.34834-3-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007124522.34834-3-zhouchuyi@bytedance.com>
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
patch link:    https://lore.kernel.org/r/20231007124522.34834-3-zhouchuyi%40bytedance.com
patch subject: [PATCH bpf-next v4 2/8] bpf: Introduce css_task open-coded iterator kfuncs
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231007/202310072246.OfAldQpf-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310072246.OfAldQpf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310072246.OfAldQpf-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/task_iter.c:815:17: warning: no previous prototype for 'bpf_iter_css_task_new' [-Wmissing-prototypes]
     815 | __bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
         |                 ^~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/task_iter.c:840:33: warning: no previous prototype for 'bpf_iter_css_task_next' [-Wmissing-prototypes]
     840 | __bpf_kfunc struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/task_iter.c:849:18: warning: no previous prototype for 'bpf_iter_css_task_destroy' [-Wmissing-prototypes]
     849 | __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/bpf_iter_css_task_new +815 kernel/bpf/task_iter.c

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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

