Return-Path: <bpf+bounces-76340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B091CAED52
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 04:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47170301C3CA
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 03:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22E9273D7B;
	Tue,  9 Dec 2025 03:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWi2rZx4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3321F5E6;
	Tue,  9 Dec 2025 03:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765252577; cv=none; b=P0UA2GBgTlAYnzwMbP3trHxsgzCCwMnUOE43ASXwxethaUjFPEcwY/7mjdkLlxe+JTfu6pjul8mwoTOwa8KPcfcZtDqF9bkY0wfAwtGmXuuzcJUj6AJU9r0vFghcqsaV5XF6c+h3BEfME/qrUPG3cH5gZtyvwWeEI7KaUH+CsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765252577; c=relaxed/simple;
	bh=7BP/S/pgzhOWIgTxUdCLG8fbFzYoQrglr8XUeSf1EHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQA9ZVTCC9ekt+utBiNR6fya6KS1hK83trh7nGGP/cTSqCi5y68JjjiCLAqbygTav4j0T428jqpCy1UMF1S+79OX1CBys3pYZqao+dnMJAx87fms2JtewTuwmorBds7R4SKCwCj2S72BE9cmP/iYouNZABFrkWSo1dqda1LzKPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWi2rZx4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765252576; x=1796788576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7BP/S/pgzhOWIgTxUdCLG8fbFzYoQrglr8XUeSf1EHs=;
  b=DWi2rZx4l4GTtvoUQabzVNqO08ftdLyjaSxa9w9J7P+8kAPVRNqMD8SO
   KJ1g7RhN6L2Wq19jO/3BLGFGNM20kUarDFLlFuuTeCMlx6fVmQ850ji1N
   r7EdDjM0lRY0R8Ph2OaTg9dQ7+vz6PJM2ufC6z7lRWVfBfsx0Oeif0W2b
   XqhrpAhJH24IBmLZyAa02epOKXd/1i2Ofg4UxL+XRo97x+wEi2jdY9tCl
   IBewzbXaHCY80xMtieFVykStHLnqWMroLeHjds5YXurS4iywZcFWKhxCh
   LrtG/tm9o68BWbYmwyNUImpjZuwJA18pnBEJ01efSu8/H7xO7RbCXiuFu
   w==;
X-CSE-ConnectionGUID: N5/QSTDIR9y5XacEmhDu+A==
X-CSE-MsgGUID: qBUjuJGmSmiYVsXHQEJeeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67284330"
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="67284330"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 19:56:15 -0800
X-CSE-ConnectionGUID: GP2DZnxMQm+Hrj5HWbbDlA==
X-CSE-MsgGUID: 1Rq14/z4TO2zsMNQ7ndFqQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 08 Dec 2025 19:56:08 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vSopa-000000001ID-0gUl;
	Tue, 09 Dec 2025 03:56:06 +0000
Date: Tue, 9 Dec 2025 11:55:54 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/3] riscv: introduce percpu.h into include/asm
Message-ID: <202512091137.3Qw1dX94-lkp@intel.com>
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
[also build test ERROR on v6.18 next-20251209]
[cannot apply to bpf-next/net bpf-next/master bpf/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunhui-Cui/riscv-remove-irqflags-h-inclusion-in-asm-bitops-h/20251208-115407
base:   linus/master
patch link:    https://lore.kernel.org/r/20251208034944.73113-3-cuiyunhui%40bytedance.com
patch subject: [PATCH v2 2/3] riscv: introduce percpu.h into include/asm
config: riscv-randconfig-002-20251209 (https://download.01.org/0day-ci/archive/20251209/202512091137.3Qw1dX94-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251209/202512091137.3Qw1dX94-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512091137.3Qw1dX94-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/slub.c:4380:9: error: call to undeclared function 'arch_cmpxchg128_local'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    4380 |         return this_cpu_try_cmpxchg_freelist(s->cpu_slab->freelist_tid,
         |                ^
   mm/slab.h:24:39: note: expanded from macro 'this_cpu_try_cmpxchg_freelist'
      24 | #define this_cpu_try_cmpxchg_freelist   this_cpu_try_cmpxchg128
         |                                         ^
   include/asm-generic/percpu.h:529:47: note: expanded from macro 'this_cpu_try_cmpxchg128'
     529 |         __cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg128)
         |                                                      ^
   1 error generated.


vim +/arch_cmpxchg128_local +4380 mm/slub.c

0b303fb402862d Vlastimil Babka 2021-05-08  4371  
6801be4f2653e5 Peter Zijlstra  2023-05-31  4372  static inline bool
6801be4f2653e5 Peter Zijlstra  2023-05-31  4373  __update_cpu_freelist_fast(struct kmem_cache *s,
6801be4f2653e5 Peter Zijlstra  2023-05-31  4374  			   void *freelist_old, void *freelist_new,
6801be4f2653e5 Peter Zijlstra  2023-05-31  4375  			   unsigned long tid)
6801be4f2653e5 Peter Zijlstra  2023-05-31  4376  {
b244358e9a1cd6 Vlastimil Babka 2025-11-07  4377  	struct freelist_tid old = { .freelist = freelist_old, .tid = tid };
b244358e9a1cd6 Vlastimil Babka 2025-11-07  4378  	struct freelist_tid new = { .freelist = freelist_new, .tid = next_tid(tid) };
6801be4f2653e5 Peter Zijlstra  2023-05-31  4379  
b244358e9a1cd6 Vlastimil Babka 2025-11-07 @4380  	return this_cpu_try_cmpxchg_freelist(s->cpu_slab->freelist_tid,
b244358e9a1cd6 Vlastimil Babka 2025-11-07  4381  					     &old.freelist_tid, new.freelist_tid);
6801be4f2653e5 Peter Zijlstra  2023-05-31  4382  }
6801be4f2653e5 Peter Zijlstra  2023-05-31  4383  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

