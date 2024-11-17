Return-Path: <bpf+bounces-45042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6F39D022E
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 06:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCB4286BC0
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 05:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A132BB1B;
	Sun, 17 Nov 2024 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+SfCDbv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86772FB2
	for <bpf@vger.kernel.org>; Sun, 17 Nov 2024 05:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731823145; cv=none; b=JtSdLKAtDVftwkgX1iaNluDHXI8yKpkCk2tHvNqU/s9X71Lvs3bSh9z6f7ImtPvzwSr/QutdwLPzy0g537XLb1IH9uoJ5yBW2v970UaQk+7AMNeRqx1bStpnCSIq8/G1Kxg9MF2d43lBm6mMgi8kC4KjQ21MjIFqcakkQjzrWhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731823145; c=relaxed/simple;
	bh=T2GcPHJog4D0cnSWEIDBbIgrdlMYSsy57HStasQYYzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdCn4Qfm842aeBCfoRnXaUuYF/DOj8SetcdtQI2HUCMvZY7E2y6Gu/V+4izcU2eTOw5pyDbBlepErapI8HyzrXLX6FDjxteNxcPDCClVQJSU+w2f4TCbGma9bMdpFtEfpnLDZGgc4rSBLMf8G1wXO3dthBdGD8Hesi4yS6EoIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+SfCDbv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731823144; x=1763359144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T2GcPHJog4D0cnSWEIDBbIgrdlMYSsy57HStasQYYzw=;
  b=R+SfCDbvdixmDrEBE/LxWTSoNPf06TsX2v/hWCyzv1vsxUHDu6KINBCv
   DeA9WYk8lyCpI4zDkUcq8TXR656junve4WA0ZUqOXKAO/1ibVweRJx4Gi
   0AIauNpqWRRSQAGk40wNknUZTsVdPHpuaWYKPTJGnXeZnimfNJAEpBKhR
   FfKju0fyfMDT9XDrB/ZQQlc7XgNI8rUpzNiF3vkt3I8Opp3j94WfYg4u3
   XmCmv1K9KUMdc6O4oztnLg2OaLnBagSuateCF3mOU4cB58b8+dTNRDUgu
   dh+ZKnsBVaLNXJUqNDRLk01WgZkraLNwZchmp/VK0E9sqKuR/OhKvb1WO
   g==;
X-CSE-ConnectionGUID: rbf9hZHNS1y+eHVDlsfhdQ==
X-CSE-MsgGUID: 5+F6QHkJQieMGKx+39ILbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="31944472"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="31944472"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 21:59:04 -0800
X-CSE-ConnectionGUID: cxN6Bk2TRg2ZGIqOk/gaEw==
X-CSE-MsgGUID: AwqxCMpZRES9x6k+YRitAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="88920145"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 Nov 2024 21:59:00 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCYJF-0001a7-2g;
	Sun, 17 Nov 2024 05:58:57 +0000
Date: Sun, 17 Nov 2024 13:58:50 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, x86@kernel.org,
	bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v6 1/4] bpf: add bpf_get_cpu_cycles kfunc
Message-ID: <202411171347.9Yb9hhnX-lkp@intel.com>
References: <20241115194841.2108634-2-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115194841.2108634-2-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bpf-add-bpf_get_cpu_cycles-kfunc/20241117-002106
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241115194841.2108634-2-vadfed%40meta.com
patch subject: [PATCH bpf-next v6 1/4] bpf: add bpf_get_cpu_cycles kfunc
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241117/202411171347.9Yb9hhnX-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171347.9Yb9hhnX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171347.9Yb9hhnX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined hidden symbol: pvclock_page
   >>> referenced by pvclock.h:25 (arch/x86/include/asm/pvclock.h:25)
   >>>               vmlinux.o:(vread_pvclock)
   >>> referenced by gettimeofday.h:228 (arch/x86/include/asm/vdso/gettimeofday.h:228)
   >>>               vmlinux.o:(vread_pvclock)
   >>> referenced by pvclock.h:86 (arch/x86/include/asm/pvclock.h:86)
   >>>               vmlinux.o:(vread_pvclock)
   >>> referenced 4 more times
--
>> ld.lld: error: undefined hidden symbol: hvclock_page
   >>> referenced by hyperv_timer.h:65 (include/clocksource/hyperv_timer.h:65)
   >>>               vmlinux.o:(vread_hvclock)
   >>> referenced by hyperv_timer.h:74 (include/clocksource/hyperv_timer.h:74)
   >>>               vmlinux.o:(vread_hvclock)
   >>> referenced by hyperv_timer.h:75 (include/clocksource/hyperv_timer.h:75)
   >>>               vmlinux.o:(vread_hvclock)
   >>> referenced 1 more times

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

