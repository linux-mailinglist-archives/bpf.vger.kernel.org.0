Return-Path: <bpf+bounces-18094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B088159F7
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 16:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E922285AC6
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0726D2E83D;
	Sat, 16 Dec 2023 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrjqgRum"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5AA2D786
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702740502; x=1734276502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tfoByuBnvOpssFBV59veNAdamP3HzMHPBlLK/amW5RI=;
  b=RrjqgRumiHqwn+xL4LxSXk7C2K743UlGvXb18qRcG8t2vMn2LKunVep8
   cHtm8Kx6ms65mnOm9XbGmEOPMp91iDiPrER1Igq8I0K4lbYnZXyCTxbM/
   siNtWq1vHipo389lIPItDa1UWKndESm176jBL+6nyZXctGWkXXmfBmmKR
   US8BrIuCDngt2QRH5weEdLwE7WV327A4kgqX/39w0zR6oAHsTz85UHLwo
   +35Lh6TescXAXktIcu5lxyx5eAc54Zw0QQdkiOlzup4gMdtUXnLipiQCN
   srcTGZTdW8seLcIS5aKgMiAT0zCJmeamL937v0MkSY8+gAcaRxW65yypo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="2464285"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="2464285"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 07:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="768329246"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="768329246"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2023 07:28:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEWaP-0001mg-0A;
	Sat, 16 Dec 2023 15:28:17 +0000
Date: Sat, 16 Dec 2023 23:27:19 +0800
From: kernel test robot <lkp@intel.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Allow per unit prefill for
 non-fix-size percpu memory allocator
Message-ID: <202312162351.UuoFmjJk-lkp@intel.com>
References: <20231216023015.3741144-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216023015.3741144-1-yonghong.song@linux.dev>

Hi Yonghong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yonghong-Song/bpf-Avoid-unnecessary-extra-percpu-memory-allocation/20231216-103310
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231216023015.3741144-1-yonghong.song%40linux.dev
patch subject: [PATCH bpf-next v3 2/6] bpf: Allow per unit prefill for non-fix-size percpu memory allocator
config: x86_64-randconfig-003-20231216 (https://download.01.org/0day-ci/archive/20231216/202312162351.UuoFmjJk-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312162351.UuoFmjJk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312162351.UuoFmjJk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/memalloc.c:665:14: warning: variable 'objcg' is uninitialized when used here [-Wuninitialized]
                   c->objcg = objcg;
                              ^~~~~
   kernel/bpf/memalloc.c:642:26: note: initialize the variable 'objcg' to silence this warning
           struct obj_cgroup *objcg;
                                   ^
                                    = NULL
   1 warning generated.


vim +/objcg +665 kernel/bpf/memalloc.c

   637	
   638	int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
   639	{
   640		int cpu, i, err = 0, unit_size, percpu_size;
   641		struct bpf_mem_caches *cc, __percpu *pcc;
   642		struct obj_cgroup *objcg;
   643		struct bpf_mem_cache *c;
   644	
   645		i = bpf_mem_cache_idx(size);
   646		if (i < 0)
   647			return -EINVAL;
   648	
   649		/* room for llist_node and per-cpu pointer */
   650		percpu_size = LLIST_NODE_SZ + sizeof(void *);
   651	
   652		pcc = ma->caches;
   653		unit_size = sizes[i];
   654	
   655	#ifdef CONFIG_MEMCG_KMEM
   656		objcg = get_obj_cgroup_from_current();
   657	#endif
   658		for_each_possible_cpu(cpu) {
   659			cc = per_cpu_ptr(pcc, cpu);
   660			c = &cc->cache[i];
   661			if (cpu == 0 && c->unit_size)
   662				goto out;
   663	
   664			c->unit_size = unit_size;
 > 665			c->objcg = objcg;
   666			c->percpu_size = percpu_size;
   667			c->tgt = c;
   668	
   669			init_refill_work(c);
   670			prefill_mem_cache(c, cpu);
   671	
   672			if (cpu == 0) {
   673				err = check_obj_size(c, i);
   674				if (err) {
   675					drain_mem_cache(c);
   676					memset(c, 0, sizeof(*c));
   677					goto out;
   678				}
   679			}
   680		}
   681	
   682	out:
   683		return err;
   684	}
   685	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

