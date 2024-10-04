Return-Path: <bpf+bounces-41038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F5499135A
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 01:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592DE2850E1
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 23:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF4D1553BC;
	Fri,  4 Oct 2024 23:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Afz5uC/k"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A723A1552EB;
	Fri,  4 Oct 2024 23:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728086393; cv=none; b=Rs+vGNkum9UaAwhdjWag5FT5pDGAWlgkwS6RYcEV6p0VtzRMQrgWI7gNDsfHUFlmIZFI3HqB/lFRvS2P8HnhDGmO0XGzSFKPnAY9RBpjgwk2ohHWBy6ySm3umzwCJ30GC9xN2o5A8a66wnXfUQT2PrC/ZR0+kxP/MULDm3nT+4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728086393; c=relaxed/simple;
	bh=nr4GUGUStXtqD14t7ZevxhYCeurvOELE6qLbAsqBJvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew8dr885twm1LZ7kCK9cERlGZ6z5fptTfUhJroQ+UaCC0oPF1BZEG5yPPDnzFFtgWGhLA7nREO04zHHyFRPlIQ/zt/q0N37DNyOqsbgUBIgn5Gprjo6AoCsV4RtM2JXuQ2E23atiWSohGLIY0RpqjycPjESMffDatTRtCElC758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Afz5uC/k; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728086392; x=1759622392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nr4GUGUStXtqD14t7ZevxhYCeurvOELE6qLbAsqBJvQ=;
  b=Afz5uC/k0yMcUR55/0vQ5sXFENv3AXtnLEu/riReXx2dfRglJzARMeOD
   B8xNjpvmMWHuQDtuXpE8RVr9gVd03ZJXaVNfG2Xyx3O1XeNUUVwu14gtP
   09qY8zdN2Z9Mt7pmF4ADQ9bQ+j0EdNkWiP+IulkdG2e7Oa5XvHIMUsURJ
   Z6V0U6Jm/88S5PV5hcpcEL+o1Wy7zZd/q6h4S2rGgs/GEO/EQmJGEEQwQ
   aHGbZ81Gn0HXhRP9Wdt8msfFIMA1UiPsYhaHBhAcoPgJzegZ1OXlPbexg
   Lt1Zlh66uO4AfRCPN3xmLeshkrFFiDd1UDYKtXcChqLk9JsSB40jaOABv
   w==;
X-CSE-ConnectionGUID: rcMEP+WmS6G8Lapqx6jBgQ==
X-CSE-MsgGUID: Ccn8La+cRsqGhsZ8UVJhkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27456451"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="27456451"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 16:59:52 -0700
X-CSE-ConnectionGUID: r4hSBamkQvqDiGw8qBDzCg==
X-CSE-MsgGUID: kSuRW7wQSN++WA4YrXARVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="75290556"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 04 Oct 2024 16:59:46 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swsD2-0002M1-0Q;
	Fri, 04 Oct 2024 23:59:44 +0000
Date: Sat, 5 Oct 2024 07:59:27 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, oleg@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org, willy@infradead.org, surenb@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com,
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org,
	vbabka@suse.cz, mingo@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 tip/perf/core 5/5] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
Message-ID: <202410050745.2Nuvusy4-lkp@intel.com>
References: <20241001225207.2215639-6-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001225207.2215639-6-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/perf/core]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/mm-introduce-mmap_lock_speculation_-start-end/20241002-065354
base:   tip/perf/core
patch link:    https://lore.kernel.org/r/20241001225207.2215639-6-andrii%40kernel.org
patch subject: [PATCH v2 tip/perf/core 5/5] uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20241005/202410050745.2Nuvusy4-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410050745.2Nuvusy4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410050745.2Nuvusy4-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/events/uprobes.c: In function 'find_active_uprobe_speculative':
>> kernel/events/uprobes.c:2098:46: error: passing argument 2 of 'mmap_lock_speculation_start' from incompatible pointer type [-Wincompatible-pointer-types]
    2098 |         if (!mmap_lock_speculation_start(mm, &seq))
         |                                              ^~~~
         |                                              |
         |                                              long int *
   In file included from include/linux/mm.h:16,
                    from arch/loongarch/include/asm/cacheflush.h:8,
                    from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from kernel/events/uprobes.c:13:
   include/linux/mmap_lock.h:126:75: note: expected 'int *' but argument is of type 'long int *'
     126 | static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int *seq) { return false; }
         |                                                                      ~~~~~^~~


vim +/mmap_lock_speculation_start +2098 kernel/events/uprobes.c

  2086	
  2087	static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
  2088	{
  2089		struct mm_struct *mm = current->mm;
  2090		struct uprobe *uprobe = NULL;
  2091		struct vm_area_struct *vma;
  2092		struct file *vm_file;
  2093		loff_t offset;
  2094		long seq;
  2095	
  2096		guard(rcu)();
  2097	
> 2098		if (!mmap_lock_speculation_start(mm, &seq))
  2099			return NULL;
  2100	
  2101		vma = vma_lookup(mm, bp_vaddr);
  2102		if (!vma)
  2103			return NULL;
  2104	
  2105		/* vm_file memory can be reused for another instance of struct file,
  2106		 * but can't be freed from under us, so it's safe to read fields from
  2107		 * it, even if the values are some garbage values; ultimately
  2108		 * find_uprobe_rcu() + mmap_lock_speculation_end() check will ensure
  2109		 * that whatever we speculatively found is correct
  2110		 */
  2111		vm_file = READ_ONCE(vma->vm_file);
  2112		if (!vm_file)
  2113			return NULL;
  2114	
  2115		offset = (loff_t)(vma->vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vma->vm_start);
  2116		uprobe = find_uprobe_rcu(vm_file->f_inode, offset);
  2117		if (!uprobe)
  2118			return NULL;
  2119	
  2120		/* now double check that nothing about MM changed */
  2121		if (!mmap_lock_speculation_end(mm, seq))
  2122			return NULL;
  2123	
  2124		return uprobe;
  2125	}
  2126	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

