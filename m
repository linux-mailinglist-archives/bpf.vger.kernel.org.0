Return-Path: <bpf+bounces-22437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D79D85E3E0
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02221B20FEC
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 16:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B66839F6;
	Wed, 21 Feb 2024 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H++CgKO/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A027582D99
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534776; cv=none; b=Ba9oXlTKgiunSOpq1EdtSmip3NxfLUF5yNeNAnyiRxW99vHh7p8XlvhSPFMBzG3n66ppeveZYqNeM7q/UJ4CoKv88JPe4NWwIQHMsWn37MugniRrx9G8Zr7iaQjHuT1SxdMfE91xDdmjH5dzusOe6bB/6LWRw7Y8BmY18J6avDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534776; c=relaxed/simple;
	bh=ElQjTfhdvPQwFojyzHWUkU4RaRlFyaM9QtJjfwB8+60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMuW78qQn26Ye9XGB6j99XDgVx7uEUfh4jIDeyy1zN92FlBf//OzHNA5C8ZKajsdnbf0wQtUdyB8PxbCOJU9Uno3B1QDWmI3GkrPl3a0ujCTh6Hr2/H2XyF5Q1bR1GJYRgZAnFhIaeFK9DcwLU1eo66/QYgqLz9EaBG5fhqGHuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H++CgKO/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708534775; x=1740070775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ElQjTfhdvPQwFojyzHWUkU4RaRlFyaM9QtJjfwB8+60=;
  b=H++CgKO/2wRw4BaitXSI1YxKSgdN7AffO2LGVUtGcj5nmFer0yB+iw5E
   ZRKKRo7sRABFneMmugwyPKk/hwbjb0umRiKqpXmKASbichQuoC7IfJAA2
   aSJ5/iRvox6/80HO9xfsrLhI3cPoYtr0iOVXAL6BDQa/pfFVkmz7cLiFN
   dLZ6LIcIGAbqI0RgtZG9IQssRVk4hJ9swb/gueq4/vP+1RF1EbJPXRWcu
   esQcijxZ0zVOY8iQtIAxxb/3jYZL2LdFv6BLnwXqWJ6KbXk1PVnzVAqej
   7UkzA5WUMHr7yculUylnBqtMFssdS2oJdAH/dTErgVLeFIpQ/LinXdjr6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13325599"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="13325599"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 08:59:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="9815760"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 21 Feb 2024 08:59:18 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcpwB-0005WE-2W;
	Wed, 21 Feb 2024 16:59:15 +0000
Date: Thu, 22 Feb 2024 00:57:52 +0800
From: kernel test robot <lkp@intel.com>
To: Maxwell Bland <mbland@motorola.com>,
	linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gregkh@linuxfoundation.org, agordeev@linux.ibm.com,
	akpm@linux-foundation.org, andreyknvl@gmail.com, andrii@kernel.org,
	aneesh.kumar@kernel.org, aou@eecs.berkeley.edu, ardb@kernel.org,
	arnd@arndb.de, ast@kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, brauner@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, cl@linux.com, daniel@iogearbox.net,
	dave.hansen@linux.intel.com, david@redhat.com, dennis@kernel.org,
	dvyukov@google.com, glider@google.com, gor@linux.ibm.com,
	guoren@kernel.org, haoluo@google.com, hca@linux.ibm.com,
	hch@infradead.org, john.fastabend@gmail.com, jolsa@kernel.org
Subject: Re: [PATCH 2/4] mm: pgalloc: support address-conditional pmd
 allocation
Message-ID: <202402220006.5v6axq6B-lkp@intel.com>
References: <20240220203256.31153-3-mbland@motorola.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220203256.31153-3-mbland@motorola.com>

Hi Maxwell,

kernel test robot noticed the following build errors:

[auto build test ERROR on b401b621758e46812da61fa58a67c3fd8d91de0d]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxwell-Bland/mm-vmalloc-allow-arch-specific-vmalloc_node-overrides/20240221-043458
base:   b401b621758e46812da61fa58a67c3fd8d91de0d
patch link:    https://lore.kernel.org/r/20240220203256.31153-3-mbland%40motorola.com
patch subject: [PATCH 2/4] mm: pgalloc: support address-conditional pmd allocation
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240222/202402220006.5v6axq6B-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240222/202402220006.5v6axq6B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402220006.5v6axq6B-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/memory.c:459:3: error: implicit declaration of function 'pmd_populate_kernel_at' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   pmd_populate_kernel_at(&init_mm, pmd, new, address);
                   ^
   mm/memory.c:459:3: note: did you mean 'pmd_populate_kernel'?
   arch/arm/include/asm/pgalloc.h:125:1: note: 'pmd_populate_kernel' declared here
   pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
   ^
   1 error generated.


vim +/pmd_populate_kernel_at +459 mm/memory.c

   449	
   450	int __pte_alloc_kernel(pmd_t *pmd, unsigned long address)
   451	{
   452		pte_t *new = pte_alloc_one_kernel(&init_mm);
   453		if (!new)
   454			return -ENOMEM;
   455	
   456		spin_lock(&init_mm.page_table_lock);
   457		if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
   458			smp_wmb(); /* See comment in pmd_install() */
 > 459			pmd_populate_kernel_at(&init_mm, pmd, new, address);
   460			new = NULL;
   461		}
   462		spin_unlock(&init_mm.page_table_lock);
   463		if (new)
   464			pte_free_kernel(&init_mm, new);
   465		return 0;
   466	}
   467	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

