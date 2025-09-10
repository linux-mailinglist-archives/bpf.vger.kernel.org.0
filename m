Return-Path: <bpf+bounces-68044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ED5B51EE8
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 19:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B05A7BAB30
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 17:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD7E31DDB7;
	Wed, 10 Sep 2025 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcfZ8jUB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7ADEACD;
	Wed, 10 Sep 2025 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525350; cv=none; b=qutxNbrOhTL0Vl/UxAi8BhVfcv5Jyhef6fSr25yzV+lA+QAO5CAMlY+oU3OmlSwEjo68VjDp+p+Zvn1KeAZuYcTkVgm12aaBnmtfhkGPIVll/fuWFb3kc1JwDO6rM+13WbxaxO1F05t9ET7mUl4LpmAUM0oLQcRVnaxJxyY0Kcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525350; c=relaxed/simple;
	bh=lnqyI9f64I1yhXVL6nN7wKwIlUzM9Wz76sbGLU0tYUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhnXqx4V68NuaWSD66QxlPVEBFDDMs+yrCoyeoWgDyPfLzP3868s1pa/lWAd0SiKsnLnSOIYaS5eVzQ7myE6w131DYddBNJjVZ5RM+aymhEk0lpiDMJL9gSTeH7dbNPE/pB26aq1cyfhKQMoeIxh/HjZxTbAKKYnGEQOpYWkfSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcfZ8jUB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757525348; x=1789061348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lnqyI9f64I1yhXVL6nN7wKwIlUzM9Wz76sbGLU0tYUk=;
  b=bcfZ8jUBd5wZcpuPoCbjPL4h+gPwCYeAsz7W14BKqEEhlr7LfBobxYJ/
   BZrVLX5hJ1b1sfegQ//l0qs5g9R9zzzFIjG50byPOMkYko8XGPJkS4vKF
   3KqZzqKA9943J9ZdbTJEfq60v1Kl+ro3/E1lkoKsF1ck0GW/fjTN1aHWS
   SodHtP9Bp71dTzf5d1ljupmbMO5rbf+93snf2RQzZJJdt4T/JXzclg0uk
   fuCeO1sRZ2ebYggrnvccbyYX1E5i0XLl2Q1jRVjKXCKIH/woc9FXpL8f4
   vuwX9JNWfSWQFCD3+TWl8+UNgVbVk61cjNygAceT57LiOVEi8j1ODKZSb
   Q==;
X-CSE-ConnectionGUID: EFA+svv8T+upCVNxcZkaJg==
X-CSE-MsgGUID: w1QyYt1pQIir+sWn4K++Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="58886909"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="58886909"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 10:29:08 -0700
X-CSE-ConnectionGUID: 4mWWF5aTSDe+1XoKr5D04w==
X-CSE-MsgGUID: ltXG1s5yRRe/xWJO8Hq3Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="173826211"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Sep 2025 10:28:42 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwOca-0006Al-0G;
	Wed, 10 Sep 2025 17:28:40 +0000
Date: Thu, 11 Sep 2025 01:27:44 +0800
From: kernel test robot <lkp@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	hannes@cmpxchg.org, usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com, willy@infradead.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
	21cnbao@gmail.com, shakeel.butt@linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Lance Yang <ioworker0@gmail.com>
Subject: Re: [PATCH v7 mm-new 01/10] mm: thp: remove disabled task from
 khugepaged_mm_slot
Message-ID: <202509110109.PSgSHb31-lkp@intel.com>
References: <20250910024447.64788-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910024447.64788-2-laoar.shao@gmail.com>

Hi Yafang,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/mm-thp-remove-disabled-task-from-khugepaged_mm_slot/20250910-144850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250910024447.64788-2-laoar.shao%40gmail.com
patch subject: [PATCH v7 mm-new 01/10] mm: thp: remove disabled task from khugepaged_mm_slot
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20250911/202509110109.PSgSHb31-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250911/202509110109.PSgSHb31-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509110109.PSgSHb31-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/sys.c:2500:6: error: call to undeclared function 'hugepage_pmd_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2500 |             hugepage_pmd_enabled())
         |             ^
>> kernel/sys.c:2501:3: error: call to undeclared function '__khugepaged_enter'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2501 |                 __khugepaged_enter(mm);
         |                 ^
   2 errors generated.


vim +/hugepage_pmd_enabled +2500 kernel/sys.c

  2471	
  2472	static int prctl_set_thp_disable(bool thp_disable, unsigned long flags,
  2473					 unsigned long arg4, unsigned long arg5)
  2474	{
  2475		struct mm_struct *mm = current->mm;
  2476	
  2477		if (arg4 || arg5)
  2478			return -EINVAL;
  2479	
  2480		/* Flags are only allowed when disabling. */
  2481		if ((!thp_disable && flags) || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
  2482			return -EINVAL;
  2483		if (mmap_write_lock_killable(current->mm))
  2484			return -EINTR;
  2485		if (thp_disable) {
  2486			if (flags & PR_THP_DISABLE_EXCEPT_ADVISED) {
  2487				mm_flags_clear(MMF_DISABLE_THP_COMPLETELY, mm);
  2488				mm_flags_set(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
  2489			} else {
  2490				mm_flags_set(MMF_DISABLE_THP_COMPLETELY, mm);
  2491				mm_flags_clear(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
  2492			}
  2493		} else {
  2494			mm_flags_clear(MMF_DISABLE_THP_COMPLETELY, mm);
  2495			mm_flags_clear(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
  2496		}
  2497	
  2498		if (!mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm) &&
  2499		    !mm_flags_test(MMF_VM_HUGEPAGE, mm) &&
> 2500		    hugepage_pmd_enabled())
> 2501			__khugepaged_enter(mm);
  2502		mmap_write_unlock(current->mm);
  2503		return 0;
  2504	}
  2505	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

