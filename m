Return-Path: <bpf+bounces-44310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7773C9C13CD
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 02:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BAE1C2261D
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 01:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5381BD9E0;
	Fri,  8 Nov 2024 01:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTroKPKg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3255E7E9
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731030947; cv=none; b=uzKcIEDDcViXFQiihIPQz23tdELuRMC/cA3reXcgPiwbYTOd5k+vi4zt6mHN2HazMnD+Uo5k0IhWGzDvoyNUvYnm/tvyJL4BEjPSlPCGuq5YGO1B5GAbJqk1UEbAhFNFevE4Pps/X9/75nAeWSzWFby7LUBkU5oK6U3zxQCEY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731030947; c=relaxed/simple;
	bh=wGy1Wsb1E4yL+Ca1HhWlwyNDxjAwf6T3rfN5JIN+Aag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfKyqKKBtLIhx9B2b9Bvgb31STeeM/2jUcFOLJaD5ICOsEq7qE9mZ0oRwXHXAgVtUMjtot3/KYMNW+LwHKMDRt6wB9V5yxs774fu1ITDF2doD5vBeUKPX7y7Ix331TLG5YcvZF568Ys3hsoCjDVsTPvUe0bG6VbraiBjJqiMsJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTroKPKg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731030946; x=1762566946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wGy1Wsb1E4yL+Ca1HhWlwyNDxjAwf6T3rfN5JIN+Aag=;
  b=XTroKPKgZeg6WrdT+E4yKDa2m6MFRf/yhm54WPgVVxGOzZAFujwnhenq
   3DSARITgtsFT6CiBQFQCEvh0aU58u7HmkqdxfqIXDAP9cPa1Wj+Do+dJt
   xDskEiKCDMww1mERF88UxoBHqB1nKGPkIUQbm0YtpElpcj5KeSptkFBsm
   XoRf8mBXl1jCNXSxLwjWcPJIvcuTEMlfJqUw7ymmVWiXkFrB8QXf05lCP
   VLXOlwmAT6f2uybIppU93hsR1xPIFaaIoVV5DDEbna6w9SuIjH7vZV/PY
   NLIHpLSlhv9jCLeBu7+/IY4iHOARa5Uqex5qW7uQYuy40+2u+9HROneg0
   A==;
X-CSE-ConnectionGUID: z9tmltcPQFy5M4dcCpfD+w==
X-CSE-MsgGUID: BXRj01YZSAuqrxzaKhKOQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31072764"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31072764"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 17:55:45 -0800
X-CSE-ConnectionGUID: ONa7SasNTeOWSey1f7g4xg==
X-CSE-MsgGUID: LubL3y6hQCGM3Ch3OhWJZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="89865669"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Nov 2024 17:55:41 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9EDr-000qtU-0g;
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
Message-ID: <202411080912.TtCTNymw-lkp@intel.com>
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
config: arm-randconfig-003-20241108 (https://download.01.org/0day-ci/archive/20241108/202411080912.TtCTNymw-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411080912.TtCTNymw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411080912.TtCTNymw-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/helpers.c:3029:18: warning: extra tokens at end of #ifdef directive [-Wextra-tokens]
   #ifdef IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
                    ^
                    //
>> kernel/bpf/helpers.c:3032:9: error: call to undeclared function '__arch_get_hw_counter'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           return __arch_get_hw_counter(1, NULL);
                  ^
   kernel/bpf/helpers.c:3128:18: warning: extra tokens at end of #ifdef directive [-Wextra-tokens]
   #ifdef IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
                    ^
                    //
   2 warnings and 1 error generated.


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

