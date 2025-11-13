Return-Path: <bpf+bounces-74347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BCDC55B1E
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 05:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419CC3AD07A
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 04:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE34305053;
	Thu, 13 Nov 2025 04:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCV/DECI"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AE301000
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009426; cv=none; b=NOj+ULS+uRxt/laHTjPcBltfNqg/lzg+VdnpO3zNpRAxdS6spixu6pzQ+y3WwSpnKRjhKN7gEH2hrcvzbXT3Zm070qMCBMwGm1MLk2TFYyNYYVxGIYzbULQ3OVnjuTSBV7508TnCYkYjvzPrx32jLdRnYN7WcKlzJVGbV5mHI6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009426; c=relaxed/simple;
	bh=vj11y1lwKZD2kwb5TCZMGnzf37/CZwEIwmuELzhZsFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0fWC9LuxZT0+mL9jSlyxqAfOvxWbqgJH8me83RqjPUACM3WTPu+IiXAG3rDmtNJgHjD1+Uv+RP4FxmXkXMLOrTDu0QJjj1PjLm+VjynvFtp22j6DIS7w6noLPJsXpozPGEq5/a2dY2GrwEcjw5bdsNUdMwIXlQITr55JuVgQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCV/DECI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763009425; x=1794545425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vj11y1lwKZD2kwb5TCZMGnzf37/CZwEIwmuELzhZsFM=;
  b=GCV/DECIXXNbz+orrTH20lKtN4mfCLM4pgT5nWCA5VBpj36RPrAsKD/v
   0wiDyPtY+mHQTUKHErY9p2SyC9EcuBfDAfzHoW292kq1CrW45VpzDffPE
   Hoa8G3jsaZHFDdgo1Q3PPyX3tbtKm7Bwrzk6BSe//uiIwEmYyXg8sAc6Z
   5cGp8hUy3Yc7V1hquTntFIi3shc/LmwiYnZhNzBiShu1hLE3q5C+P/Dpz
   wWROZd5E+ziQQQGwiEQIH35UxWNUts5XiUiaAk9jNq3zd1dqbnXpcwvP0
   xZBhMQq0aOl3C5ac1EYI2WspfLFEqlPafEOd+sL7CODXuYlT0p0S3Ti/+
   A==;
X-CSE-ConnectionGUID: BVSc8dR4RG61SqMCwRX5uQ==
X-CSE-MsgGUID: 2WZwo4f9RUSziMvme5PKbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="68947836"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="68947836"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 20:50:23 -0800
X-CSE-ConnectionGUID: ObfaRa59Tha3zyqhECHhig==
X-CSE-MsgGUID: pWpA78LRRXK7yFi0Ut8iuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="212789105"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Nov 2025 20:50:20 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJPHm-0004sd-28;
	Thu, 13 Nov 2025 04:50:18 +0000
Date: Thu, 13 Nov 2025 12:49:33 +0800
From: kernel test robot <lkp@intel.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 1/4] bpf: arena: populate vm_area without
 allocating memory
Message-ID: <202511122229.mivV7opC-lkp@intel.com>
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
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20251112/202511122229.mivV7opC-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251112/202511122229.mivV7opC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511122229.mivV7opC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/arena.c:139:2: error: call to undeclared function 'flush_tlb_kernel_range'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     139 |         flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
         |         ^
   1 error generated.


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

