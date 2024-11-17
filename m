Return-Path: <bpf+bounces-45055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4D19D06BA
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 23:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E721F21830
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 22:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71E91DDC2C;
	Sun, 17 Nov 2024 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKmFH1SB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7C1DDC00
	for <bpf@vger.kernel.org>; Sun, 17 Nov 2024 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731884150; cv=none; b=EQ7u0/vPcYXuTETKXGvTI3QCPV0+WVZrrKbcJNuKkeKMQNvG0/FyBWuLX2wRTB8+1dQvhtYmIfRHKh6ZIeTcO4e0PTa0HTk4t0RptF8hc2Qi2H2OzdBGYjvQ6TeZ/PFZ19oycnpFSQwekScsG6Vbz8hax3SH0WRqF5nH0Lnk320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731884150; c=relaxed/simple;
	bh=piTjRQr7XQsU1tQqsqvztFMe5RZSFWOQ1K6HyKhIqP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjCL5+RUS/E+JTFfqU7YNOin9NCDq1cGAcz6cnkC6fVbGjYQnb/TIMWNP5wey9wLdJlvIRtpYtn+OZkNUGPovPuRKlg+aE8dElf0BgBDF8MWoC1Vz+HeUPaEltY5gYoh3DteY+vUCWxMaJS/UM6fVqLaez7SPZjXs2q2BpcpGtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKmFH1SB; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731884149; x=1763420149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=piTjRQr7XQsU1tQqsqvztFMe5RZSFWOQ1K6HyKhIqP0=;
  b=EKmFH1SB8wB70XN/7ZnB+Wi36cfDRbhOhKkZ/ng+pOY8HHOyWfjzIjsI
   GyowCLf1sMefGDP4+j0Kt3gOiuYqtxcZMltNQuiPyBb1bEhRbReoMJjed
   xd0//SCBcEeFSl6lhHKo6sauvlc31PUDRmid/ITu0URNzxlLvWweXZlGP
   2h6pb9z/Xd72d0LWC3dAexrrLTLBMGJA2NfxNRLlsWPWWuO/fFBjoZ4uI
   72sZVW7yqA8eRue68xvGQytKMjVHr2ijIsBUETJ4WH3+qqTyw6hmxfn76
   Vb4W0pXhhI2pFxXcuQwwBmNlhHE5kkrpTb8CoozqUYjcWAiInQliobGpu
   w==;
X-CSE-ConnectionGUID: P2SGH0gSTaKcFgSlIyPJTQ==
X-CSE-MsgGUID: HJWIgFulQmqcN+lVsxtPEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="31580756"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="31580756"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 14:55:48 -0800
X-CSE-ConnectionGUID: ntX0LrGmR6uxKVPJfQJkPA==
X-CSE-MsgGUID: Yd1NgFFPTTSp4O6wcnD9TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="119999087"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2024 14:55:45 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCoBC-00024X-24;
	Sun, 17 Nov 2024 22:55:42 +0000
Date: Mon, 18 Nov 2024 06:55:17 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>
Cc: oe-kbuild-all@lists.linux.dev, x86@kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v6 1/4] bpf: add bpf_get_cpu_cycles kfunc
Message-ID: <202411180657.c0eoNysc-lkp@intel.com>
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
config: x86_64-randconfig-075-20241117 (https://download.01.org/0day-ci/archive/20241118/202411180657.c0eoNysc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241118/202411180657.c0eoNysc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411180657.c0eoNysc-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `vread_pvclock':
>> arch/x86/include/asm/vdso/gettimeofday.h:198: undefined reference to `pvclock_page'
>> ld: arch/x86/include/asm/vdso/gettimeofday.h:198: undefined reference to `pvclock_page'
   ld: vmlinux.o: in function `pvclock_read_begin':
>> arch/x86/include/asm/pvclock.h:25: undefined reference to `pvclock_page'
   ld: vmlinux.o: in function `vread_pvclock':
   arch/x86/include/asm/vdso/gettimeofday.h:228: undefined reference to `pvclock_page'
   ld: vmlinux.o: in function `__pvclock_read_cycles':
   arch/x86/include/asm/pvclock.h:86: undefined reference to `pvclock_page'
   ld: vmlinux.o:arch/x86/include/asm/pvclock.h:88: more undefined references to `pvclock_page' follow
   ld: .tmp_vmlinux1: hidden symbol `pvclock_page' isn't defined
   ld: final link failed: bad value


vim +198 arch/x86/include/asm/vdso/gettimeofday.h

7ac8707479886c Vincenzo Frascino 2019-06-21  195  
7ac8707479886c Vincenzo Frascino 2019-06-21  196  #ifdef CONFIG_PARAVIRT_CLOCK
7ac8707479886c Vincenzo Frascino 2019-06-21  197  static u64 vread_pvclock(void)
7ac8707479886c Vincenzo Frascino 2019-06-21 @198  {
ecf9db3d1f1a8f Andy Lutomirski   2019-06-22  199  	const struct pvclock_vcpu_time_info *pvti = &pvclock_page.pvti;
7ac8707479886c Vincenzo Frascino 2019-06-21  200  	u32 version;
7ac8707479886c Vincenzo Frascino 2019-06-21  201  	u64 ret;
7ac8707479886c Vincenzo Frascino 2019-06-21  202  
7ac8707479886c Vincenzo Frascino 2019-06-21  203  	/*
7ac8707479886c Vincenzo Frascino 2019-06-21  204  	 * Note: The kernel and hypervisor must guarantee that cpu ID
7ac8707479886c Vincenzo Frascino 2019-06-21  205  	 * number maps 1:1 to per-CPU pvclock time info.
7ac8707479886c Vincenzo Frascino 2019-06-21  206  	 *
7ac8707479886c Vincenzo Frascino 2019-06-21  207  	 * Because the hypervisor is entirely unaware of guest userspace
7ac8707479886c Vincenzo Frascino 2019-06-21  208  	 * preemption, it cannot guarantee that per-CPU pvclock time
7ac8707479886c Vincenzo Frascino 2019-06-21  209  	 * info is updated if the underlying CPU changes or that that
7ac8707479886c Vincenzo Frascino 2019-06-21  210  	 * version is increased whenever underlying CPU changes.
7ac8707479886c Vincenzo Frascino 2019-06-21  211  	 *
7ac8707479886c Vincenzo Frascino 2019-06-21  212  	 * On KVM, we are guaranteed that pvti updates for any vCPU are
7ac8707479886c Vincenzo Frascino 2019-06-21  213  	 * atomic as seen by *all* vCPUs.  This is an even stronger
7ac8707479886c Vincenzo Frascino 2019-06-21  214  	 * guarantee than we get with a normal seqlock.
7ac8707479886c Vincenzo Frascino 2019-06-21  215  	 *
7ac8707479886c Vincenzo Frascino 2019-06-21  216  	 * On Xen, we don't appear to have that guarantee, but Xen still
7ac8707479886c Vincenzo Frascino 2019-06-21  217  	 * supplies a valid seqlock using the version field.
7ac8707479886c Vincenzo Frascino 2019-06-21  218  	 *
7ac8707479886c Vincenzo Frascino 2019-06-21  219  	 * We only do pvclock vdso timing at all if
7ac8707479886c Vincenzo Frascino 2019-06-21  220  	 * PVCLOCK_TSC_STABLE_BIT is set, and we interpret that bit to
7ac8707479886c Vincenzo Frascino 2019-06-21  221  	 * mean that all vCPUs have matching pvti and that the TSC is
7ac8707479886c Vincenzo Frascino 2019-06-21  222  	 * synced, so we can just look at vCPU 0's pvti.
7ac8707479886c Vincenzo Frascino 2019-06-21  223  	 */
7ac8707479886c Vincenzo Frascino 2019-06-21  224  
7ac8707479886c Vincenzo Frascino 2019-06-21  225  	do {
7ac8707479886c Vincenzo Frascino 2019-06-21  226  		version = pvclock_read_begin(pvti);
7ac8707479886c Vincenzo Frascino 2019-06-21  227  
7ac8707479886c Vincenzo Frascino 2019-06-21  228  		if (unlikely(!(pvti->flags & PVCLOCK_TSC_STABLE_BIT)))
7ac8707479886c Vincenzo Frascino 2019-06-21  229  			return U64_MAX;
7ac8707479886c Vincenzo Frascino 2019-06-21  230  
7ac8707479886c Vincenzo Frascino 2019-06-21  231  		ret = __pvclock_read_cycles(pvti, rdtsc_ordered());
7ac8707479886c Vincenzo Frascino 2019-06-21  232  	} while (pvclock_read_retry(pvti, version));
7ac8707479886c Vincenzo Frascino 2019-06-21  233  
77750f78b0b324 Peter Zijlstra    2023-05-19  234  	return ret & S64_MAX;
7ac8707479886c Vincenzo Frascino 2019-06-21  235  }
7ac8707479886c Vincenzo Frascino 2019-06-21  236  #endif
7ac8707479886c Vincenzo Frascino 2019-06-21  237  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

