Return-Path: <bpf+bounces-22454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F5085E5FC
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 19:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEA9FB21392
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 18:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8325B85C7B;
	Wed, 21 Feb 2024 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4ZxiS5W"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345485950
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540026; cv=none; b=deuKk/sPZxtfEgsGFdbLxYL0wPQ5bNkoNYweMcxHMY3NxWUaLOGloCq6jq4kCPPZ2oS8sGgHjJhetsCYJGz/CPuFh/wZQsE2tYXHAaNkL6dMWd5C3MwgaPCC9bZDqRuGnZt8xy151PSSfaIp54b+IsVNQ7z2kmp9OcGq7+TaDHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540026; c=relaxed/simple;
	bh=yHv4YLihaI4wjBJjCVU/hu18mkRLgE84I+vpF5Fdl/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSnqKKRQNZzEu3D83ClL+wqBxkLqLJOhmjhUEoo5BWNwnoRN83l8fJQ6mS6shLIigwITeHm/jeZxOKrBXywoOrwqCLB1zntg4qlrVs9NPQkuQJtN9SbC9mDv/z2dTBkcv9ogeTorimTJTSTDaFjO3YghuU/mUaxFhW0juBtttyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4ZxiS5W; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708540025; x=1740076025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yHv4YLihaI4wjBJjCVU/hu18mkRLgE84I+vpF5Fdl/0=;
  b=F4ZxiS5WDdE/+RGDZ5fnb3TXay4mU1I1crJXXusIag322pIUAzLA0shf
   DK4AAQhWzZN5TVAN5k0mcKFZ2qR6vYaPhUbDy3zUjbf9tVbzLe9R+69W4
   27PPctnE0q0YnSUGx3Zdziy0bu4XygL7VQYwXfemHcTDvn98Ww53N7Rky
   +AnjaMKEP4sXz/1apP1NmuKaj5bRTE0VPrqSugAW+FyW6ZfvUPIMbdoRY
   8NhyrEabXfqE/Cym8lhxsWbUI963apLMMcOzJEMZBK0XaOTEKBRtsSGos
   f/iY7+tWoecA4hkT6PBmQ100u24uEL7BxVJAXRctC14xEY4C4+UWrCMPZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="6495324"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="6495324"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 10:27:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="5383021"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 21 Feb 2024 10:26:57 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcrIS-0005ae-1U;
	Wed, 21 Feb 2024 18:26:26 +0000
Date: Thu, 22 Feb 2024 02:25:09 +0800
From: kernel test robot <lkp@intel.com>
To: Maxwell Bland <mbland@motorola.com>,
	linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
	agordeev@linux.ibm.com, akpm@linux-foundation.org,
	andreyknvl@gmail.com, andrii@kernel.org, aneesh.kumar@kernel.org,
	aou@eecs.berkeley.edu, ardb@kernel.org, arnd@arndb.de,
	ast@kernel.org, borntraeger@linux.ibm.com, bpf@vger.kernel.org,
	brauner@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, cl@linux.com, daniel@iogearbox.net,
	dave.hansen@linux.intel.com, david@redhat.com, dennis@kernel.org,
	dvyukov@google.com, glider@google.com, gor@linux.ibm.com,
	guoren@kernel.org, haoluo@google.com, hca@linux.ibm.com,
	hch@infradead.org, john.fastabend@gmail.com, jolsa@kernel.org
Subject: Re: [PATCH 1/4] mm/vmalloc: allow arch-specific vmalloc_node
 overrides
Message-ID: <202402220229.5xZWdZBK-lkp@intel.com>
References: <20240220203256.31153-2-mbland@motorola.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220203256.31153-2-mbland@motorola.com>

Hi Maxwell,

kernel test robot noticed the following build errors:

[auto build test ERROR on b401b621758e46812da61fa58a67c3fd8d91de0d]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxwell-Bland/mm-vmalloc-allow-arch-specific-vmalloc_node-overrides/20240221-043458
base:   b401b621758e46812da61fa58a67c3fd8d91de0d
patch link:    https://lore.kernel.org/r/20240220203256.31153-2-mbland%40motorola.com
patch subject: [PATCH 1/4] mm/vmalloc: allow arch-specific vmalloc_node overrides
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20240222/202402220229.5xZWdZBK-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240222/202402220229.5xZWdZBK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402220229.5xZWdZBK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/nommu.c:160:7: error: conflicting types for '__vmalloc_node'; have 'void *(long unsigned int,  long unsigned int,  gfp_t,  int,  const void *)' {aka 'void *(long unsigned int,  long unsigned int,  unsigned int,  int,  const void *)'}
     160 | void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
         |       ^~~~~~~~~~~~~~
   In file included from include/asm-generic/io.h:994,
                    from arch/m68k/include/asm/io.h:14,
                    from arch/m68k/include/asm/pgtable_no.h:14,
                    from arch/m68k/include/asm/pgtable.h:6,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from mm/nommu.c:20:
   include/linux/vmalloc.h:152:7: note: previous declaration of '__vmalloc_node' with type 'void *(long unsigned int,  long unsigned int,  gfp_t,  long unsigned int,  int,  const void *)' {aka 'void *(long unsigned int,  long unsigned int,  unsigned int,  long unsigned int,  int,  const void *)'}
     152 | void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
         |       ^~~~~~~~~~~~~~


vim +160 mm/nommu.c

041de93ff86fc5 Christoph Hellwig 2020-06-01  159  
2b9059489c839e Christoph Hellwig 2020-06-01 @160  void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
2b9059489c839e Christoph Hellwig 2020-06-01  161  		int node, const void *caller)
a7c3e901a46ff5 Michal Hocko      2017-05-08  162  {
2b9059489c839e Christoph Hellwig 2020-06-01  163  	return __vmalloc(size, gfp_mask);
a7c3e901a46ff5 Michal Hocko      2017-05-08  164  }
a7c3e901a46ff5 Michal Hocko      2017-05-08  165  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

