Return-Path: <bpf+bounces-52780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2481A486FB
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 18:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A19D1885953
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 17:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1F1EFF91;
	Thu, 27 Feb 2025 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRC9CMEb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172341E51E7;
	Thu, 27 Feb 2025 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678558; cv=none; b=QGaj5ucAGRtch3CA68hs/y+yhA6mqCxv4uxtaWn9ZpQUZJtiy+Kfh9w9/x2+tPp808McHzVN6pv93d1IA9g3XZACkGHTUWsbTadUjYQzQ+Y+KviyVYeykdieIq7fA0Q5v2R5C6F7XU+ywyeV2lp24O+S2LHBexTfe8qcf5BWlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678558; c=relaxed/simple;
	bh=hbOcWRR965qL+r3t+KOoQIZ6pqo51J3oCtyYdu/MbP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm/S2S+gpk9FDG8Q/qvhmLc6wRELUjZQNT6uySP69qUtLClVVEDwbkiAO1rKzBnxw2rP+4xT2UJiTozszqFlRdciM+UqQfrxYM1pDHXlbo/tVBC8ZPaLWP47lOBshktWrt9io//cu+Gb7PQn/ov+6k67Hy8NLVffS5ATDnc018U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRC9CMEb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740678556; x=1772214556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hbOcWRR965qL+r3t+KOoQIZ6pqo51J3oCtyYdu/MbP8=;
  b=eRC9CMEbSw91m9MKdtFIALTXHdePzXEhMRanjuPXzLktTxSKsx0FQ/IG
   0it4Neh5y9184DEnohQxRgyMOgrlM0pQVIQ2zXoFlv4CddpjaI7d592Qs
   nAEiDKfu7yUWRHS9Xbw5pd5eYq2sCX5RDLn835kJYy7i0SnQDzefRbt4h
   c3eyZdDACbMftHZKBFfGyYJkD3Gbdz96aH6OjUdOYSNH+QcNe5XWYqoiC
   W4Exqf9xCbygpsY3PzpDCpNxsQjK5EVtX4ep3ZXrWMx3VSPMdyGJtDPa8
   g7dzEit1XaGm3REFAc5jUhTTrEBvyHL5vqzlWIP6n+mwyhi5PBp9d/7k+
   g==;
X-CSE-ConnectionGUID: XLGVswL3Rfa16ts4q2dg7g==
X-CSE-MsgGUID: ahRYtFKqR0qSZtSFKP117g==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41503217"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41503217"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 09:49:16 -0800
X-CSE-ConnectionGUID: od8b3YkhQHOqc5lLH407AA==
X-CSE-MsgGUID: qM2gFwLiQoGeQ9Pbh3oF7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117753696"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2025 09:49:09 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tni0R-000DnH-0q;
	Thu, 27 Feb 2025 17:49:07 +0000
Date: Fri, 28 Feb 2025 01:48:52 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, rostedt@goodmis.org,
	mark.rutland@arm.com, alexei.starovoitov@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, catalin.marinas@arm.com, will@kernel.org,
	mhiramat@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, mathieu.desnoyers@efficios.com, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	dongml2@chinatelecom.cn, akpm@linux-foundation.org, rppt@kernel.org,
	graf@amazon.com, dan.j.williams@intel.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v2] add function metadata support
Message-ID: <202502280123.BNaCYT2A-lkp@intel.com>
References: <20250226121537.752241-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226121537.752241-1-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/add-function-metadata-support/20250226-202312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250226121537.752241-1-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next v2] add function metadata support
config: i386-randconfig-062-20250227 (https://download.01.org/0day-ci/archive/20250228/202502280123.BNaCYT2A-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280123.BNaCYT2A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280123.BNaCYT2A-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/kfunc_md.c:12:23: sparse: sparse: symbol 'kfunc_mds' redeclared with different type (different address spaces):
   kernel/trace/kfunc_md.c:12:23: sparse:    struct kfunc_md [noderef] __rcu *[addressable] [toplevel] kfunc_mds
   kernel/trace/kfunc_md.c: note: in included file:
   include/linux/kfunc_md.h:16:24: sparse: note: previously declared as:
   include/linux/kfunc_md.h:16:24: sparse:    struct kfunc_md *extern [addressable] [toplevel] kfunc_mds
   kernel/trace/kfunc_md.c:186:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct kfunc_md *md @@     got struct kfunc_md [noderef] __rcu * @@
   kernel/trace/kfunc_md.c:186:20: sparse:     expected struct kfunc_md *md
   kernel/trace/kfunc_md.c:186:20: sparse:     got struct kfunc_md [noderef] __rcu *
>> kernel/trace/kfunc_md.c:98:25: sparse: sparse: non size-preserving pointer to integer cast

vim +98 kernel/trace/kfunc_md.c

    10	
    11	static u32 kfunc_md_count = ENTRIES_PER_PAGE, kfunc_md_used;
  > 12	struct kfunc_md __rcu *kfunc_mds;
    13	EXPORT_SYMBOL_GPL(kfunc_mds);
    14	
    15	static DEFINE_MUTEX(kfunc_md_mutex);
    16	
    17	
    18	void kfunc_md_unlock(void)
    19	{
    20		mutex_unlock(&kfunc_md_mutex);
    21	}
    22	EXPORT_SYMBOL_GPL(kfunc_md_unlock);
    23	
    24	void kfunc_md_lock(void)
    25	{
    26		mutex_lock(&kfunc_md_mutex);
    27	}
    28	EXPORT_SYMBOL_GPL(kfunc_md_lock);
    29	
    30	static u32 kfunc_md_get_index(void *ip)
    31	{
    32		return *(u32 *)(ip - KFUNC_MD_DATA_OFFSET);
    33	}
    34	
    35	static void kfunc_md_init(struct kfunc_md *mds, u32 start, u32 end)
    36	{
    37		u32 i;
    38	
    39		for (i = start; i < end; i++)
    40			mds[i].users = 0;
    41	}
    42	
    43	static int kfunc_md_page_order(void)
    44	{
    45		return fls(DIV_ROUND_UP(kfunc_md_count, ENTRIES_PER_PAGE)) - 1;
    46	}
    47	
    48	/* Get next usable function metadata. On success, return the usable
    49	 * kfunc_md and store the index of it to *index. If no usable kfunc_md is
    50	 * found in kfunc_mds, a larger array will be allocated.
    51	 */
    52	static struct kfunc_md *kfunc_md_get_next(u32 *index)
    53	{
    54		struct kfunc_md *new_mds, *mds;
    55		u32 i, order;
    56	
    57		mds = rcu_dereference(kfunc_mds);
    58		if (mds == NULL) {
    59			order = kfunc_md_page_order();
    60			new_mds = (void *)__get_free_pages(GFP_KERNEL, order);
    61			if (!new_mds)
    62				return NULL;
    63			kfunc_md_init(new_mds, 0, kfunc_md_count);
    64			/* The first time to initialize kfunc_mds, so it is not
    65			 * used anywhere yet, and we can update it directly.
    66			 */
    67			rcu_assign_pointer(kfunc_mds, new_mds);
    68			mds = new_mds;
    69		}
    70	
    71		if (likely(kfunc_md_used < kfunc_md_count)) {
    72			/* maybe we can manage the used function metadata entry
    73			 * with a bit map ?
    74			 */
    75			for (i = 0; i < kfunc_md_count; i++) {
    76				if (!mds[i].users) {
    77					kfunc_md_used++;
    78					*index = i;
    79					mds[i].users++;
    80					return mds + i;
    81				}
    82			}
    83		}
    84	
    85		order = kfunc_md_page_order();
    86		/* no available function metadata, so allocate a bigger function
    87		 * metadata array.
    88		 */
    89		new_mds = (void *)__get_free_pages(GFP_KERNEL, order + 1);
    90		if (!new_mds)
    91			return NULL;
    92	
    93		memcpy(new_mds, mds, kfunc_md_count * sizeof(*new_mds));
    94		kfunc_md_init(new_mds, kfunc_md_count, kfunc_md_count * 2);
    95	
    96		rcu_assign_pointer(kfunc_mds, new_mds);
    97		synchronize_rcu();
  > 98		free_pages((u64)mds, order);
    99	
   100		mds = new_mds + kfunc_md_count;
   101		*index = kfunc_md_count;
   102		kfunc_md_count <<= 1;
   103		kfunc_md_used++;
   104		mds->users++;
   105	
   106		return mds;
   107	}
   108	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

