Return-Path: <bpf+bounces-44312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCB89C13CF
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 02:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED3F1C22695
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 01:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83081BC3F;
	Fri,  8 Nov 2024 01:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHaohrQr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD2DF60
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 01:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731030949; cv=none; b=En+o/VFrwSlhWueHrIS+8v4VxSMwH4p60as6NDpckIiuFGgXSPJBmpLQcfSPEd4il3nHdL4+HBRLCSfh2BOIMMzv7JogrDFkDj3AJCp7NTAB1VFJfxj8NzhvbQ7quhgrP8FUzoiOdmCIstyQiErnziWb0pkp/kioogGKBnwcIN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731030949; c=relaxed/simple;
	bh=nlzBpRjRUaUzfSO5CUUpdYIFv2IBxD96gDmX2RmEqkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijkSDWjQpYi5Avct2+Kfyu9K5N+huU8DMJJAPRUvxbkJcF+pfjVRYBIUMQGuop/ULR+wKyNBdARcObqAq1/RnaH1eYTKQ3E5A/6J22XMGJnr4eFlxcENM8oXC183PPnHLx4fb3KYvWqv+FPulYtshfeHK/VNZ/BBfFoXdqBiyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHaohrQr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731030948; x=1762566948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nlzBpRjRUaUzfSO5CUUpdYIFv2IBxD96gDmX2RmEqkc=;
  b=lHaohrQr2Ic7WzPcjygsGIErmlNOPUkh33zcdZE2pzCsJ4i7jsYM9Rmn
   1DNK3z3ysphgbQqGXippXUYzLOMPMwufuT2R5fO3QGTP/vfvnIcRNalAN
   xI8j/MKw/yvDyj1jL2DZ76/v2bcX47xvbwRz+jy4YCRdCuUBCXzYi80mU
   ym8yGOE01I1sOASPJuopCKefRPBgeh6odcMTQgFCvaODhEzZbZkdlzD1F
   gaoie6wTS9RtRnz5yKO2i2lVi4BwXK1fugfCY/Keqf3qW2LH28w63NeUe
   f6hBeBtERmxTXdaFoY22Sd8DJo9oic2tjS3xXpLE9TQKEk11yWSLhaYPa
   Q==;
X-CSE-ConnectionGUID: rxSjdfqpRW6HW46cyE0CFw==
X-CSE-MsgGUID: 5foS+8FPQY2WJokh4LkiRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31072780"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31072780"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 17:55:45 -0800
X-CSE-ConnectionGUID: gBLhMHYsRGqPl2WuQSfmyw==
X-CSE-MsgGUID: LdCUPZoFQ8W9BbKSU+nvPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="89865671"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Nov 2024 17:55:41 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9EDr-000qta-0r;
	Fri, 08 Nov 2024 01:55:39 +0000
Date: Fri, 8 Nov 2024 09:54:54 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski <kuba@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, x86@kernel.org,
	bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: add bpf_get_cpu_cycles kfunc
Message-ID: <202411080939.hiAmVBIM-lkp@intel.com>
References: <20241107211206.2814069-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107211206.2814069-1-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bpf-add-bpf_cpu_cycles_to_ns-helper/20241108-051950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241107211206.2814069-1-vadfed%40meta.com
patch subject: [PATCH bpf-next v4 1/4] bpf: add bpf_get_cpu_cycles kfunc
config: arm-randconfig-004-20241108 (https://download.01.org/0day-ci/archive/20241108/202411080939.hiAmVBIM-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411080939.hiAmVBIM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411080939.hiAmVBIM-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/bpf/helpers.c:4:
   In file included from include/linux/bpf.h:21:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   kernel/bpf/helpers.c:117:36: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     117 |         .arg2_type      = ARG_PTR_TO_MAP_VALUE | MEM_UNINIT | MEM_WRITE,
         |                           ~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:130:36: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     130 |         .arg2_type      = ARG_PTR_TO_MAP_VALUE | MEM_UNINIT | MEM_WRITE,
         |                           ~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:541:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     541 |         .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:544:41: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     544 |         .arg4_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:569:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     569 |         .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:572:41: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     572 |         .arg4_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:585:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     585 |         .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:655:35: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     655 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:727:39: warning: bitwise operation between different enumeration types ('enum bpf_return_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     727 |         .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:740:39: warning: bitwise operation between different enumeration types ('enum bpf_return_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     740 |         .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:1082:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1082 |         .arg4_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1643:44: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1643 |         .arg2_type    = ARG_PTR_TO_BTF_ID_OR_NULL | OBJ_RELEASE,
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   kernel/bpf/helpers.c:1748:33: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1748 |         .arg4_type      = ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT | MEM_WRITE,
         |                           ~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1791:33: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1791 |         .arg3_type      = ARG_PTR_TO_DYNPTR | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:1839:33: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1839 |         .arg1_type      = ARG_PTR_TO_DYNPTR | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:1841:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1841 |         .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:1881:33: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1881 |         .arg1_type      = ARG_PTR_TO_DYNPTR | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:3029:18: warning: extra tokens at end of #ifdef directive [-Wextra-tokens]
    3029 | #ifdef IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
         |                  ^
         |                  //
>> kernel/bpf/helpers.c:3032:9: error: call to undeclared function '__arch_get_hw_counter'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3032 |         return __arch_get_hw_counter(1, NULL);
         |                ^
   kernel/bpf/helpers.c:3128:18: warning: extra tokens at end of #ifdef directive [-Wextra-tokens]
    3128 | #ifdef IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
         |                  ^
         |                  //
   20 warnings and 1 error generated.


vim +/__arch_get_hw_counter +3032 kernel/bpf/helpers.c

  3028	
  3029	#ifdef IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
  3030	__bpf_kfunc u64 bpf_get_cpu_cycles(void)
  3031	{
> 3032		return __arch_get_hw_counter(1, NULL);
  3033	}
  3034	#endif
  3035	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

