Return-Path: <bpf+bounces-74349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D36AC55B7B
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 05:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D95B34E690
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 04:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3595B305053;
	Thu, 13 Nov 2025 04:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAXSISrz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2527330276D
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 04:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009606; cv=none; b=OE2CcECdoQRIQMQ6GsaAK5ZNMVK00uD0gz7HUTpXQvVutZjCHk+H9Loii6NyJx96HVBo5ZNAFtmJR/DDC0AcabvaOQhHdwFg0A7q04KxdjW7IQYvgQMVk/Q9UlaCKgYwEAo5WPEMsrJxHUHyQXWfJdugy6LrI099203ZEcWK6TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009606; c=relaxed/simple;
	bh=+RnNgJxnLCpjiL4aWVpfdB/7glQSfIJsvV6SyEJUxwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccxBw17/kdvoD3+c7+bk7z3r+PZGGQAM3HTufgQamKjV3aP0hC+hJAjbOwQIvkLvltfXdpg+fxG4q0QC5N02wuaihD0AkeS8IOz0Z3ReE9GUSJZE/qh/WgSFQToktfnsWlRSF4WcMJnXuMYZ1F0RL73i5aBFMZTufOqZW5G+YIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAXSISrz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763009605; x=1794545605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+RnNgJxnLCpjiL4aWVpfdB/7glQSfIJsvV6SyEJUxwg=;
  b=RAXSISrzKkfegsKpzUX92t/M58S4TbxAuYYnC0PkBbFKKe8KJT2W233n
   RJVNQ5JP3F/xrCrn2oiiO5lW93pTlN43udkVBZefiZLk15wD823N0zezV
   XF16umst25whxDPEs72EM4oG0VkzKRCZxpqh6WqMuOAIOf+B76OOYCTyP
   wpc8+TIn5HZCG5ty8HpJBf/yt5M1ktOVMJCWLMUHW7d5JK0cc+6Z5LFE0
   +AkHE9Jg6SPOpK9GnrpWEOqSgFWMeY+0+ccrn8/O+YNXoF+V2KJyPDX1K
   G1pJ/hbczUWQmTAqFwMJIDmB25jK3n8skYNdbx3LOq/Vsnk7XSRWZINZB
   g==;
X-CSE-ConnectionGUID: k3DXSrQdQ5muXkuh9CeJ7w==
X-CSE-MsgGUID: R/xfohPmQPaA/0PBatZL0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82480079"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="82480079"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 20:53:24 -0800
X-CSE-ConnectionGUID: 6lhh0uK5Qq+lEfWdF3px+w==
X-CSE-MsgGUID: HP701mBmQ1iHdlrOACrSTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="189415460"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Nov 2025 20:53:21 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJPKh-0004tv-1B;
	Thu, 13 Nov 2025 04:53:19 +0000
Date: Thu, 13 Nov 2025 12:52:29 +0800
From: kernel test robot <lkp@intel.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 1/4] bpf: arena: populate vm_area without
 allocating memory
Message-ID: <202511122020.eyONeHrW-lkp@intel.com>
References: <20251111163424.16471-2-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111163424.16471-2-puranjay@kernel.org>

Hi Puranjay,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Puranjay-Mohan/bpf-arena-populate-vm_area-without-allocating-memory/20251112-004253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251111163424.16471-2-puranjay%40kernel.org
patch subject: [PATCH bpf-next 1/4] bpf: arena: populate vm_area without allocating memory
config: loongarch-randconfig-002-20251112 (https://download.01.org/0day-ci/archive/20251112/202511122020.eyONeHrW-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251112/202511122020.eyONeHrW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511122020.eyONeHrW-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/arena.c: In function 'apply_range_clear_cb':
>> kernel/bpf/arena.c:139:9: error: implicit declaration of function 'flush_tlb_kernel_range' [-Werror=implicit-function-declaration]
     139 |         flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/flush_tlb_kernel_range +139 kernel/bpf/arena.c

   119	
   120	static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *data)
   121	{
   122		struct mm_struct *mm = &init_mm;
   123		pte_t old_pte;
   124		struct page *page;
   125	
   126		/* sanity check */
   127		old_pte = ptep_get(pte);
   128		if (pte_none(old_pte) || !pte_present(old_pte))
   129			return 0; /* nothing to do */
   130	
   131		/* get page and free it */
   132		page = pte_page(old_pte);
   133		if (WARN_ON_ONCE(!page))
   134			return -EINVAL;
   135	
   136		pte_clear(mm, addr, pte);
   137	
   138		/* ensure no stale TLB entries */
 > 139		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
   140	
   141		__free_page(page);
   142	
   143		return 0;
   144	}
   145	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

