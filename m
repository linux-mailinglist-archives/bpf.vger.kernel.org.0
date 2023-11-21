Return-Path: <bpf+bounces-15504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBE57F253B
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 06:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93A81C218CB
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 05:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A962E199DA;
	Tue, 21 Nov 2023 05:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amRS5kA/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7CFC8
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 21:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700544219; x=1732080219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fl3Tmal+8MUaITF85OyuVoJV7t7A/ocR2PgT72cuTLo=;
  b=amRS5kA/wi70Pvz/VwSdIHK7bdbpxqVKpiDm4NgYHXVGcICdsdn8PObG
   kItV7ATLgdRwHQvXZiMJCTGjBtNsI8RCQH8ldKWMHEql+5lC50JJjX8Fd
   quoKa0HuddjdJMuN5E+WArkSPja2ZGwfgYkCePX4nDzNohgwyXk+70X6J
   2BuT33bkzhAsHpj6grP8Ymlk4SD2yOiY4zOkrqSF/sr3EPl+J2RrC/2HO
   k2u2/fpV6nM+0MGiuRW71viDKj86wJ/5obMkmAA3z6UfnCEHw++yBEegy
   1q6TCBaHOQ/NUePpAK5IrDG0OTiTSKAPikNVHIctcOfBhw6oA3JE+FWAr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="382160685"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="382160685"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 21:23:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14793493"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2023 21:23:36 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5JEN-0007LT-0L;
	Tue, 21 Nov 2023 05:23:29 +0000
Date: Tue, 21 Nov 2023 13:20:54 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_MMAPABLE task_local
 storage
Message-ID: <202311211358.O24bsL46-lkp@intel.com>
References: <20231120175925.733167-2-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120175925.733167-2-davemarchevsky@fb.com>

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Marchevsky/bpf-Support-BPF_F_MMAPABLE-task_local-storage/20231121-020345
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231120175925.733167-2-davemarchevsky%40fb.com
patch subject: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_MMAPABLE task_local storage
config: x86_64-randconfig-121-20231121 (https://download.01.org/0day-ci/archive/20231121/202311211358.O24bsL46-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211358.O24bsL46-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211358.O24bsL46-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/bpf_local_storage.c:30:6: sparse: sparse: symbol 'alloc_mmapable_selem_value' was not declared. Should it be static?
>> kernel/bpf/bpf_local_storage.c:291:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bpf_local_storage_map *smap @@     got struct bpf_local_storage_map [noderef] __rcu *smap @@
   kernel/bpf/bpf_local_storage.c:291:14: sparse:     expected struct bpf_local_storage_map *smap
   kernel/bpf/bpf_local_storage.c:291:14: sparse:     got struct bpf_local_storage_map [noderef] __rcu *smap
   kernel/bpf/bpf_local_storage.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +/alloc_mmapable_selem_value +30 kernel/bpf/bpf_local_storage.c

    29	
  > 30	void *alloc_mmapable_selem_value(struct bpf_local_storage_map *smap)
    31	{
    32		struct mem_cgroup *memcg, *old_memcg;
    33		void *ptr;
    34	
    35		memcg = bpf_map_get_memcg(&smap->map);
    36		old_memcg = set_active_memcg(memcg);
    37		ptr = bpf_map_area_mmapable_alloc(PAGE_ALIGN(smap->map.value_size),
    38						  NUMA_NO_NODE);
    39		set_active_memcg(old_memcg);
    40		mem_cgroup_put(memcg);
    41	
    42		return ptr;
    43	}
    44	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

