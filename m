Return-Path: <bpf+bounces-76331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCECCAEB25
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 03:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0888F300985C
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 02:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D8C301005;
	Tue,  9 Dec 2025 02:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDNa51IP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD217D2;
	Tue,  9 Dec 2025 02:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765246389; cv=none; b=o98jl65U2JDo0/1DZRcJ3d6OKac6ez9xlhDMbSJNm3r+BdLHVTK8GeI4sy4bbxg+L/139UOMjTpzNMPCi9JWGwY//Zd6gCvdflaYBv+ywhASRx4RliWohUm5c0IdVgBmAEi0BzDaEtAww5Iq1O/fyVMvq+j1+uGeGGzGDSoEQqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765246389; c=relaxed/simple;
	bh=t/n0Kb2PQ4ho9yOiWbXGt8ntdqBp4Egqu5F/G8IrLH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNvIKLKoueeff14Ci4hzXDYRykSN1hhc+VQVRtJs2IjN6gqmdADPouK+MC3nu2IFyU4M/4+zxq+emb8B1qZmv7cACYoiKlQ9HEJh/J6BwwH+fDHER7ZV/i4bmeooXnKgNWKkWEGUYRkOol5IsDt2W+9QXmPlwZkjzxvul0HGmto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDNa51IP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765246386; x=1796782386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t/n0Kb2PQ4ho9yOiWbXGt8ntdqBp4Egqu5F/G8IrLH4=;
  b=BDNa51IPSdCYzCC7yJaSHB4MIwyXpumKfWmctY8rCZ4l/88fKq87fxpQ
   XjKWNTKL2NVYdSHcaojZe1PB3iRLqw0kZy6CMS3eWZDCvnnbxpx5jXJj7
   xwv2Kjvji7y56iqSEtSlKSCRkCvcJi2yyA499N1Ijn1COY1YO7kVHgzhH
   kpIilO9nmbQm6pAgKXhCa/0bZh16kHb3noM2fvjflxtx3I5XkdQUTCzIk
   2VZZ/Ft8nfSPNeQhirN8VT0jHy0dIGkKOKYI8KrmPSd6iDv3dCw3CErwp
   xdlAOasoZOEteKbhWBRVMX8AClnsdX/a6t4jUTyMqqrB3RjmyWyvvEtJ2
   A==;
X-CSE-ConnectionGUID: ZBmP8M0mRtys3TWk51W4dA==
X-CSE-MsgGUID: HD0lPCJ6SE+ix62OgFJz/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="92673868"
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="92673868"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 18:13:04 -0800
X-CSE-ConnectionGUID: kMd9kbGSTMiVFdT/ioshHQ==
X-CSE-MsgGUID: 7VGMrLKDT/GWc4gYkwlMOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="219442996"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Dec 2025 18:12:58 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vSnDj-000000001Be-2v6q;
	Tue, 09 Dec 2025 02:12:55 +0000
Date: Tue, 9 Dec 2025 10:12:47 +0800
From: kernel test robot <lkp@intel.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>, aou@eecs.berkeley.edu,
	alex@ghiti.fr, andii@kernel.org, andybnac@gmail.com,
	apatel@ventanamicro.com, ast@kernel.org, ben.dooks@codethink.co.uk,
	bjorn@kernel.org, bpf@vger.kernel.org, charlie@rivosinc.com,
	cl@gentwo.org, conor.dooley@microchip.com, cyrilbur@tenstorrent.com,
	daniel@iogearbox.net, debug@rivosinc.com, dennis@kernel.org,
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	linux@rasmusvillemoes.dk, martin.lau@linux.dev, palmer@dabbelt.com,
	pjw@kernel.org, puranjay@kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/3] riscv: introduce percpu.h into include/asm
Message-ID: <202512090907.agDhp0Nd-lkp@intel.com>
References: <20251208034944.73113-3-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208034944.73113-3-cuiyunhui@bytedance.com>

Hi Yunhui,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.18 next-20251208]
[cannot apply to bpf-next/net bpf-next/master bpf/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunhui-Cui/riscv-remove-irqflags-h-inclusion-in-asm-bitops-h/20251208-115407
base:   linus/master
patch link:    https://lore.kernel.org/r/20251208034944.73113-3-cuiyunhui%40bytedance.com
patch subject: [PATCH v2 2/3] riscv: introduce percpu.h into include/asm
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20251209/202512090907.agDhp0Nd-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251209/202512090907.agDhp0Nd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512090907.agDhp0Nd-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/atomic.h:80,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from mm/slub.c:13:
   mm/slub.c: In function '__update_cpu_freelist_fast':
>> include/linux/atomic/atomic-arch-fallback.h:414:30: error: implicit declaration of function 'arch_cmpxchg128_local'; did you mean 'arch_cmpxchg64_local'? [-Wimplicit-function-declaration]
     414 | #define raw_cmpxchg128_local arch_cmpxchg128_local
         |                              ^~~~~~~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:5005:9: note: in expansion of macro 'raw_cmpxchg128_local'
    5005 |         raw_cmpxchg128_local(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/percpu.h:231:17: note: in expansion of macro 'cmpxchg128_local'
     231 |         ret__ = cmpxchg128_local(ptr__, old__, new__);                  \
         |                 ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:110:17: note: in expansion of macro 'this_cpu_cmpxchg128'
     110 |         __val = _cmpxchg(pcp, __old, nval);                             \
         |                 ^~~~~~~~
   include/asm-generic/percpu.h:529:9: note: in expansion of macro '__cpu_fallback_try_cmpxchg'
     529 |         __cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg128)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/slab.h:24:41: note: in expansion of macro 'this_cpu_try_cmpxchg128'
      24 | #define this_cpu_try_cmpxchg_freelist   this_cpu_try_cmpxchg128
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   mm/slub.c:4380:16: note: in expansion of macro 'this_cpu_try_cmpxchg_freelist'
    4380 |         return this_cpu_try_cmpxchg_freelist(s->cpu_slab->freelist_tid,
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +414 include/linux/atomic/atomic-arch-fallback.h

9257959a6e5b4f Mark Rutland 2023-06-05  413  
9257959a6e5b4f Mark Rutland 2023-06-05 @414  #define raw_cmpxchg128_local arch_cmpxchg128_local
e6ce9d741163af Uros Bizjak  2023-04-05  415  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

