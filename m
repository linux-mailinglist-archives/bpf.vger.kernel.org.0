Return-Path: <bpf+bounces-44311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C5E9C13CE
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 02:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C865B1C226FF
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 01:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5440F1773A;
	Fri,  8 Nov 2024 01:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KnQJ3l5w"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5918C1F
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 01:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731030948; cv=none; b=IsMfrXI2WECIoXBHngqpMKdCIxkPJfspmrNR4Wt+u+cD1q7aue0InFJ57d/TTtk/era6nTtsVGncsngNEZWS8noQuPW8z9oAjLK7oQXa+A/mpDTQhZYsqJMV0odD4/7xdXrAi7sGwTQCKFwEH0sIpXRUdY6W+WB8tRjplUpxpRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731030948; c=relaxed/simple;
	bh=ltx9LvhO7jDkXantAxEy0W4DABjxEuwiQL0xJLNs8Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNNJ7yaJ9z7cnJBznbZb/egZo/nlB2r+p2pFZVQBUK51M30btRoSbl+g0Tj56cHWHqIK4Z0IzwacUa41C3W234HeKadefI38ZR9eRiJ2n5uDQZ1xMGNrSwzjg/ZH3dIemHRwIor9HYxWgA8tP7QPpTbIQ54+3oiw+7BQUp2Q96k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KnQJ3l5w; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731030947; x=1762566947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ltx9LvhO7jDkXantAxEy0W4DABjxEuwiQL0xJLNs8Zw=;
  b=KnQJ3l5wybwFJmg66n9QG1+aOnHr6rdv7XeuPBKcikdMnpjqpH+tbINx
   3kNs1rpegYXYGkCja0oSXTP7ZbXXfOxtrgAZr1cWrmkB/zihMDXjaN2r4
   mJIMEE3onWghe+u5QUw+e1Yjtszi9IKWXBuuBZnE+0FSKNfIEA3ZIENxU
   pK2VSxT4nzNQXGSVNj3coYcZppKDH5MSPVdQP5KDGzmfmzMBLY6389d3o
   KkpuxSsPL6CzZlWFucIg/NdCPWyL/56MxMpADfskOH6wA5aYFUlkKXBmB
   XceXPqfkBeXqJjVHNXDxk6l9nPAXGVjH4/ZnnU3IUjPPFTZ7txChwyk9g
   g==;
X-CSE-ConnectionGUID: 8HHMFGodRQOIuEegNDF8Ng==
X-CSE-MsgGUID: Q7no4IGDS6qVHmIVjX4HzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31072773"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31072773"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 17:55:45 -0800
X-CSE-ConnectionGUID: Za+JHk8pRzeOIdKdoS+u/w==
X-CSE-MsgGUID: m353ayLMRJeOm1dE0PYKcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="89865670"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Nov 2024 17:55:41 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9EDr-000qtc-0w;
	Fri, 08 Nov 2024 01:55:39 +0000
Date: Fri, 8 Nov 2024 09:54:55 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski <kuba@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, x86@kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: add bpf_cpu_cycles_to_ns helper
Message-ID: <202411080952.bCRm4YHx-lkp@intel.com>
References: <20241107211206.2814069-2-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107211206.2814069-2-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bpf-add-bpf_cpu_cycles_to_ns-helper/20241108-051950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241107211206.2814069-2-vadfed%40meta.com
patch subject: [PATCH bpf-next v4 2/4] bpf: add bpf_cpu_cycles_to_ns helper
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20241108/202411080952.bCRm4YHx-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411080952.bCRm4YHx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411080952.bCRm4YHx-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/helpers.c:3030:18: warning: extra tokens at end of #ifdef directive
    3030 | #ifdef IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
         |                  ^
   kernel/bpf/helpers.c: In function 'bpf_get_cpu_cycles':
   kernel/bpf/helpers.c:3033:16: error: implicit declaration of function '__arch_get_hw_counter' [-Wimplicit-function-declaration]
    3033 |         return __arch_get_hw_counter(1, NULL);
         |                ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c: In function 'bpf_cpu_cycles_to_ns':
   kernel/bpf/helpers.c:3038:38: error: implicit declaration of function '__arch_get_k_vdso_data' [-Wimplicit-function-declaration]
    3038 |         const struct vdso_data *vd = __arch_get_k_vdso_data();
         |                                      ^~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/helpers.c:3038:38: error: initialization of 'const struct vdso_data *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   kernel/bpf/helpers.c:3040:42: error: invalid use of undefined type 'const struct vdso_data'
    3040 |         return mul_u64_u32_shr(cycles, vd->mult, vd->shift);
         |                                          ^~
   kernel/bpf/helpers.c:3040:52: error: invalid use of undefined type 'const struct vdso_data'
    3040 |         return mul_u64_u32_shr(cycles, vd->mult, vd->shift);
         |                                                    ^~
   kernel/bpf/helpers.c: At top level:
   kernel/bpf/helpers.c:3135:18: warning: extra tokens at end of #ifdef directive
    3135 | #ifdef IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
         |                  ^
   kernel/bpf/helpers.c: In function 'bpf_cpu_cycles_to_ns':
   kernel/bpf/helpers.c:3041:1: warning: control reaches end of non-void function [-Wreturn-type]
    3041 | }
         | ^


vim +3038 kernel/bpf/helpers.c

  3035	
  3036	__bpf_kfunc u64 bpf_cpu_cycles_to_ns(u64 cycles)
  3037	{
> 3038		const struct vdso_data *vd = __arch_get_k_vdso_data();
  3039	
  3040		return mul_u64_u32_shr(cycles, vd->mult, vd->shift);
  3041	}
  3042	#endif
  3043	__bpf_kfunc_end_defs();
  3044	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

