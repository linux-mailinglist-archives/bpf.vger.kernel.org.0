Return-Path: <bpf+bounces-74348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F2BC55B49
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 05:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C631A4E25B9
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 04:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B935305E33;
	Thu, 13 Nov 2025 04:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqXZ6YB1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F29D2FFDE3
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 04:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009486; cv=none; b=FDdoyj8wwsdtwztL7wknjufwX80p4hbX+yHziJxBHP4MZ8fL6OrUpmNlnkcxZXG6oK8Y/NbgA1i5wPE4e+jHH7860XWwOEak6SKy8JbJpTz18baB3uflMN58s6BrSNxASZD4zzWsA4u/frzvhQpX7Q6kk0rzlWUuB/R0OnLN1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009486; c=relaxed/simple;
	bh=Pu7JCh+uZQ+wAjeaVzQzIHM60xa65wVtxbks+jBVGCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obCPka5QWRPiGsXRuqxfg2mBNJnWUdysYz9y/l6cMqsioa631AjUoUV2xgOckUzlivZSHnEgCilY0OXB7Hj991Jar1K36LOYvzI3WOy2YbvRWQFHXtsueWEfIAM1rMYhFcCjOm8hF7lMkGdaJJNSyg0Ad5mfpGzShl74L+xC+as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqXZ6YB1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763009485; x=1794545485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pu7JCh+uZQ+wAjeaVzQzIHM60xa65wVtxbks+jBVGCw=;
  b=XqXZ6YB12G7JnLenH/fpQ8GcWYHnYNtiv5MTIaJb+agP3SUrNHJexfmZ
   aUwKHqTlf+mpP8uVMW+6JfkwRj3NN/ZsypGk+jmAS4R8RIh9dK5n6a0eu
   8zTzA3UlwWgUmN/cE5ss/QIlGJ+iYverOlRgKVYsWLUkmGHcekAkddVfz
   JCg1qiQxmg7syU6P9R5f3OSfmPIki4iSKeYNHny7flrxZGLE9xU5v2Miq
   k9J4TWAxf7B2739XrzdaFWRM9NhAzs5DibZfaeMXcr4uMiwzl/4frng7U
   GgSYn30+H7F95Qo7qGzXGB1P/nsdrlEU7jKeDA4UAMc8MikNVk70SDMFv
   w==;
X-CSE-ConnectionGUID: wTZ6OL0wQXW4zwVSeKnK9Q==
X-CSE-MsgGUID: MiAFG7gpQ8ua31lcE5IsMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65008607"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65008607"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 20:51:23 -0800
X-CSE-ConnectionGUID: yeX6xk15RoqAxx0O+4o3JQ==
X-CSE-MsgGUID: fA5wbbIKQbGrsZzt8amQug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="220161056"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Nov 2025 20:51:21 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJPIk-0004tH-34;
	Thu, 13 Nov 2025 04:51:18 +0000
Date: Thu, 13 Nov 2025 12:51:06 +0800
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
Message-ID: <202511130329.jSq8tSKf-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Puranjay-Mohan/bpf-arena-populate-vm_area-without-allocating-memory/20251112-004253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251111163424.16471-2-puranjay%40kernel.org
patch subject: [PATCH bpf-next 1/4] bpf: arena: populate vm_area without allocating memory
config: arm64-randconfig-003-20251112 (https://download.01.org/0day-ci/archive/20251113/202511130329.jSq8tSKf-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511130329.jSq8tSKf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511130329.jSq8tSKf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/arena.c: In function 'apply_range_clear_cb':
>> kernel/bpf/arena.c:122:20: warning: unused variable 'mm' [-Wunused-variable]
     struct mm_struct *mm = &init_mm;
                       ^~


vim +/mm +122 kernel/bpf/arena.c

   119	
   120	static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *data)
   121	{
 > 122		struct mm_struct *mm = &init_mm;
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
   139		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
   140	
   141		__free_page(page);
   142	
   143		return 0;
   144	}
   145	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

