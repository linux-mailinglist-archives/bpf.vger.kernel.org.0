Return-Path: <bpf+bounces-41042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180339913B0
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 03:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C8C1C228B2
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 01:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D4EE56A;
	Sat,  5 Oct 2024 01:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEjnu/Dg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E44E7482;
	Sat,  5 Oct 2024 01:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728090836; cv=none; b=TuyrO/OHawNyf5xdyGB6FUmHcjPc6ywEVsfjBVyxWbRVJbNs3sc23Ax9uS3dzxU4eeIILX1vhkpHsv3hlXG6BbxZckrcUq06JFZGQPfCcUF6e3SfoNbKGYqIVfRUsemA0SgowW7b7qckc4tFol5SMTn9Q6XyydBFxN1aLuX4qn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728090836; c=relaxed/simple;
	bh=ROpFcwVfpBZVEEAbzD/niLbgvfn+U8TQfekfFIK1SB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bnf7trURSjIzdYlYhsFXWHF8FNKoIZmv5OSOBNMRjEsTl3UHKJXKtyWPLy0VwzI6LuDAe7RGkQkkPUsuZxK8G5dQ9szHDQfKHrrxmE2obQ6SJTxiFmE4kJcxmSpEZ8EdQRQ131Qq//0FfEeQ91KZoWkHiZrU44ur1gNPoDickdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEjnu/Dg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728090833; x=1759626833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ROpFcwVfpBZVEEAbzD/niLbgvfn+U8TQfekfFIK1SB4=;
  b=VEjnu/DgY0VPytyJ/m2IpkBk8bKs5uvUfo5Rhih4L6JXSOQSojueiQj/
   D+rqJ9103hITVU1m7Q8VZW4MTLUBRToGeoxycXRwVwWzao1AEw4wRhdSh
   ihz5oDy0/9WrxUagLeGFxQAzQKbs1uY0tJyRSJVm8Ry18vKB04SWbUPoe
   Yr80jtCe+cvT2NKvfyw8A4ViUdtloyRUGtmxbaebuMG+pIfGoPPchgnph
   /ysE6RIgmIdaONgTY+Plcv0At2Q6SKTc/1a1h8S2+wWPcatazRmodBNeX
   dNqXpIGEmxHGive7OavKPK2SKlXKUnJtti/yQoElS2nMXpCUp2pSszjwT
   A==;
X-CSE-ConnectionGUID: zPFAYclsSTii9EFpgjD6FQ==
X-CSE-MsgGUID: hJOuLSi1Sv2Jcwcw8DHO5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="37891404"
X-IronPort-AV: E=Sophos;i="6.11,179,1725346800"; 
   d="scan'208";a="37891404"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 18:13:53 -0700
X-CSE-ConnectionGUID: Jq3hpcnDQ9SJ7qXh6xlIgQ==
X-CSE-MsgGUID: YHkhactZQc2V34zPY3+UIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,179,1725346800"; 
   d="scan'208";a="78857400"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 04 Oct 2024 18:13:48 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swtMf-0002P8-2G;
	Sat, 05 Oct 2024 01:13:45 +0000
Date: Sat, 5 Oct 2024 09:12:58 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, oleg@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org,
	jannh@google.com, mhocko@kernel.org, vbabka@suse.cz,
	mingo@kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 tip/perf/core 5/5] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
Message-ID: <202410050846.Zbsm9OI1-lkp@intel.com>
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
config: i386-defconfig (https://download.01.org/0day-ci/archive/20241005/202410050846.Zbsm9OI1-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410050846.Zbsm9OI1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410050846.Zbsm9OI1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/events/uprobes.c:2098:39: error: incompatible pointer types passing 'long *' to parameter of type 'int *' [-Werror,-Wincompatible-pointer-types]
    2098 |         if (!mmap_lock_speculation_start(mm, &seq))
         |                                              ^~~~
   include/linux/mmap_lock.h:126:75: note: passing argument to parameter 'seq' here
     126 | static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int *seq) { return false; }
         |                                                                           ^
   1 error generated.


vim +2098 kernel/events/uprobes.c

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

