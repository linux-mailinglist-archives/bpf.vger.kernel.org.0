Return-Path: <bpf+bounces-66619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4EDB37866
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 04:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8592F1B22CE7
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 02:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245F7305062;
	Wed, 27 Aug 2025 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzOtl8eQ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1784276046;
	Wed, 27 Aug 2025 02:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756263524; cv=none; b=OfVEDVmvwYkOwZNI/Wx3PpBSi2hFtOUdfSX6i3cbVZQdc2E9Z7gN/jE5XFasQEvWzvnoMnJ3I81oHQIW+hCRXNWKGGpk0ENBI1px5O6AaZt4IH1tOq97WblFgzoHZXnkTbGCt/odRh3Bk/eXz+3VAmC+PT23FdePe7m4fWVvStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756263524; c=relaxed/simple;
	bh=FaAYjYeaqo6BXH3QV/GlJJdaIRRLN9q/K9TzS6NDhLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rs1rvJJBfKx7m8DgUbeAmJOeLFQpNzXjvMKsCRXSaj+ZBdGD02ZwJjWGenbPDzH2IGl3WI40TGM9XMxcgm3tFs9BYr7SVDrSB++4LkWz7aO2B10qJiQi2KEj4858MF4XC4Yitw9WZZNI59xgBStXKzlnE0tZoOJ84QydG3O2+Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JzOtl8eQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756263523; x=1787799523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FaAYjYeaqo6BXH3QV/GlJJdaIRRLN9q/K9TzS6NDhLo=;
  b=JzOtl8eQZYJvSpW41W3KmNbwHuP0GNIpf53VWpKjCmTlxJe8orK0w7kK
   1ttZib4jegj69g6GHX1SLDwr2XZBm4dByiBJTdy9pzK2RFTkpAqkHMoVU
   4gMDHFznMBSVN7ryd8RxHyPZeYiBLXymBTPXlO3AQgKAWl9H9SWVE+TK4
   Hoe4RZWZFEqRR9kPCoWa8Yw0WtpKnTRyC83JIUemCzG2wvjLfYJyUStBV
   b/7n7hpvj0uqmmKk/cFVKM2maccLndIrD9k+mOtS+AqMBDtVXPNoqPcE7
   jB4waF8LT8u5TTkqRRkRmTa6gnHZgxiccLKRUeahpy+PWeJuSluOj/PKd
   Q==;
X-CSE-ConnectionGUID: uN5icr2gTI2woPvnOBzNZA==
X-CSE-MsgGUID: SRube0x/SBGSZ0onC8wAxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58569363"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58569363"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 19:58:42 -0700
X-CSE-ConnectionGUID: WQLEuyUDQBiSRfhdVtzXyA==
X-CSE-MsgGUID: uWywIkghRhiOifWM3Oe+9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="193380595"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 26 Aug 2025 19:58:36 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ur6Mr-000Sbz-3B;
	Wed, 27 Aug 2025 02:58:33 +0000
Date: Wed, 27 Aug 2025 10:57:10 +0800
From: kernel test robot <lkp@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	hannes@cmpxchg.org, usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com, willy@infradead.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v6 mm-new 01/10] mm: thp: add support for BPF based THP
 order selection
Message-ID: <202508271009.5neOZ0OG-lkp@intel.com>
References: <20250826071948.2618-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826071948.2618-2-laoar.shao@gmail.com>

Hi Yafang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/mm-thp-add-support-for-BPF-based-THP-order-selection/20250826-152415
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250826071948.2618-2-laoar.shao%40gmail.com
patch subject: [PATCH v6 mm-new 01/10] mm: thp: add support for BPF based THP order selection
config: loongarch-randconfig-r113-20250827 (https://download.01.org/0day-ci/archive/20250827/202508271009.5neOZ0OG-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce: (https://download.01.org/0day-ci/archive/20250827/202508271009.5neOZ0OG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508271009.5neOZ0OG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/bpf_thp.c:47:31: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/bpf_thp.c:47:31: sparse:    int ( [noderef] __rcu * )( ... )
   mm/bpf_thp.c:47:31: sparse:    int ( * )( ... )
   mm/bpf_thp.c:101:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/bpf_thp.c:101:9: sparse:    int ( [noderef] __rcu * )( ... )
   mm/bpf_thp.c:101:9: sparse:    int ( * )( ... )
   mm/bpf_thp.c:102:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/bpf_thp.c:102:9: sparse:    int ( [noderef] __rcu * )( ... )
   mm/bpf_thp.c:102:9: sparse:    int ( * )( ... )
   mm/bpf_thp.c:111:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/bpf_thp.c:111:9: sparse:    int ( [noderef] __rcu * )( ... )
   mm/bpf_thp.c:111:9: sparse:    int ( * )( ... )
   mm/bpf_thp.c:112:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/bpf_thp.c:112:9: sparse:    int ( [noderef] __rcu * )( ... )
   mm/bpf_thp.c:112:9: sparse:    int ( * )( ... )
   mm/bpf_thp.c:112:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/bpf_thp.c:112:9: sparse:    int ( [noderef] __rcu * )( ... )
   mm/bpf_thp.c:112:9: sparse:    int ( * )( ... )
   mm/bpf_thp.c:133:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/bpf_thp.c:133:9: sparse:    int ( [noderef] __rcu * )( ... )
   mm/bpf_thp.c:133:9: sparse:    int ( * )( ... )
   mm/bpf_thp.c:134:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/bpf_thp.c:134:9: sparse:    int ( [noderef] __rcu * )( ... )
   mm/bpf_thp.c:134:9: sparse:    int ( * )( ... )
   mm/bpf_thp.c:134:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/bpf_thp.c:134:9: sparse:    int ( [noderef] __rcu * )( ... )
   mm/bpf_thp.c:134:9: sparse:    int ( * )( ... )
>> mm/bpf_thp.c:102:9: sparse: sparse: dereference of noderef expression
>> mm/bpf_thp.c:102:9: sparse: sparse: dereference of noderef expression
   mm/bpf_thp.c:112:9: sparse: sparse: dereference of noderef expression
   mm/bpf_thp.c:134:9: sparse: sparse: dereference of noderef expression
   mm/bpf_thp.c:134:9: sparse: sparse: dereference of noderef expression
   mm/bpf_thp.c:134:9: sparse: sparse: dereference of noderef expression
   mm/bpf_thp.c:148:14: sparse: sparse: dereference of noderef expression

vim +47 mm/bpf_thp.c

    33	
    34	int get_suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
    35				u64 vma_flags, enum tva_type tva_flags, int orders)
    36	{
    37		int (*bpf_suggested_order)(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
    38					   u64 vma_flags, enum tva_type tva_flags, int orders);
    39		int suggested_orders = orders;
    40	
    41		/* No BPF program is attached */
    42		if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
    43			      &transparent_hugepage_flags))
    44			return suggested_orders;
    45	
    46		rcu_read_lock();
  > 47		bpf_suggested_order = rcu_dereference(bpf_thp.get_suggested_order);
    48		if (!bpf_suggested_order)
    49			goto out;
    50	
    51		suggested_orders = bpf_suggested_order(mm, vma__nullable, vma_flags, tva_flags, orders);
    52		if (highest_order(suggested_orders) > highest_order(orders))
    53			suggested_orders = orders;
    54	
    55	out:
    56		rcu_read_unlock();
    57		return suggested_orders;
    58	}
    59	
    60	static bool bpf_thp_ops_is_valid_access(int off, int size,
    61						enum bpf_access_type type,
    62						const struct bpf_prog *prog,
    63						struct bpf_insn_access_aux *info)
    64	{
    65		return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
    66	}
    67	
    68	static const struct bpf_func_proto *
    69	bpf_thp_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
    70	{
    71		return bpf_base_func_proto(func_id, prog);
    72	}
    73	
    74	static const struct bpf_verifier_ops thp_bpf_verifier_ops = {
    75		.get_func_proto = bpf_thp_get_func_proto,
    76		.is_valid_access = bpf_thp_ops_is_valid_access,
    77	};
    78	
    79	static int bpf_thp_init(struct btf *btf)
    80	{
    81		return 0;
    82	}
    83	
    84	static int bpf_thp_init_member(const struct btf_type *t,
    85				       const struct btf_member *member,
    86				       void *kdata, const void *udata)
    87	{
    88		return 0;
    89	}
    90	
    91	static int bpf_thp_reg(void *kdata, struct bpf_link *link)
    92	{
    93		struct bpf_thp_ops *ops = kdata;
    94	
    95		spin_lock(&thp_ops_lock);
    96		if (test_and_set_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
    97				     &transparent_hugepage_flags)) {
    98			spin_unlock(&thp_ops_lock);
    99			return -EBUSY;
   100		}
   101		WARN_ON_ONCE(rcu_access_pointer(bpf_thp.get_suggested_order));
 > 102		rcu_assign_pointer(bpf_thp.get_suggested_order, ops->get_suggested_order);
   103		spin_unlock(&thp_ops_lock);
   104		return 0;
   105	}
   106	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

