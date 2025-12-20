Return-Path: <bpf+bounces-77254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E0DCD338F
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 17:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6070B30124E5
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 16:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB30D27B4E8;
	Sat, 20 Dec 2025 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXxewUwd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCE91F4606;
	Sat, 20 Dec 2025 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766248295; cv=none; b=eXaFyIXRE9ix1PRNIzLyo5xgNOfVuafeGAJfnOfh9YjWrzLkbOwWMHFo6D7KlF96Js3HruognQvTfvoM43fLxfJsB7KenAY5Ui9rhl2ejbPxM4uYsKGICTL8AzMLz3DJvSPezxtsX/pb5sKnEn2Kx9a+B3kOg/5qmO4yI1lCy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766248295; c=relaxed/simple;
	bh=gFxpIXF13nGXH8jcMN3U6G/SWnqn2l0yxiGSNIRPPzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L02FbAOxig7C0vLjKNe3IzQQPNomycYX67xBt//Kc0Yso+as5hqEZTM2oWxzwyAKuqMRuDjoM5NGU59VdT0gIwD7nHCar48MbxMYMHKOsaT+wIc1vOGBKoDzwnED1MvA0mdmSDLbPr9YhEUSzJ3/kaNEj9aETjIxjV12oDGO0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXxewUwd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766248293; x=1797784293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gFxpIXF13nGXH8jcMN3U6G/SWnqn2l0yxiGSNIRPPzs=;
  b=GXxewUwdK9GLt3yuVWEqdz5l0lWJKWRtCAgeWuIURmQsjnG2iSLEuhhd
   2sSOfXdTfpOXuy9a0iXIcckJF1X36LTpP2DGYTQDFryfFdVSAt+gszGAX
   zWW6rfs+LQ/JSJbYN3qGzdXb6P2cX4gKc7xjYS3SkJKg36oFRf4zaV0km
   jJJf32+VyuLDR+HnRfaNo8ZNk/X53wE6HtvNWhQzk6jm566XYM89iw4AR
   fFvsZIxlzBoIGCpjZTwlg/qszWCBdwQNVz1ot99g+X7pxgqx2Z6g+ykAJ
   caiJurFa9flMjPXtairDsF8voBWub18IRJ6FGUdBE1eoRS/lswIOQnFYy
   A==;
X-CSE-ConnectionGUID: Qwg2DAkhTHy16TPfaucvwg==
X-CSE-MsgGUID: gMIeyX9gQOy8IcAWF/YgLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="67375601"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="67375601"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 08:31:32 -0800
X-CSE-ConnectionGUID: 2zwW58zfTPKjCecmEA7d3Q==
X-CSE-MsgGUID: ub5ZTe6sRmib9MeS8+2Qkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="222605833"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 20 Dec 2025 08:31:25 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWzrX-000000004sd-0pgl;
	Sat, 20 Dec 2025 16:31:23 +0000
Date: Sun, 21 Dec 2025 00:31:08 +0800
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
Subject: Re: [PATCH v3 2/3] riscv: introduce percpu.h into include/asm
Message-ID: <202512210052.w0bpUAAO-lkp@intel.com>
References: <20251216014721.42262-3-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216014721.42262-3-cuiyunhui@bytedance.com>

Hi Yunhui,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.19-rc1 next-20251219]
[cannot apply to bpf-next/net bpf-next/master bpf/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunhui-Cui/riscv-remove-irqflags-h-inclusion-in-asm-bitops-h/20251216-094956
base:   linus/master
patch link:    https://lore.kernel.org/r/20251216014721.42262-3-cuiyunhui%40bytedance.com
patch subject: [PATCH v3 2/3] riscv: introduce percpu.h into include/asm
config: riscv-randconfig-002-20251217 (https://download.01.org/0day-ci/archive/20251221/202512210052.w0bpUAAO-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512210052.w0bpUAAO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512210052.w0bpUAAO-lkp@intel.com/

All errors (new ones prefixed by >>):

     109 | #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from net/core/page_pool.c:14:
   In file included from include/net/netdev_lock.h:7:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:854:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     854 |         insl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:110:53: note: expanded from macro 'insl'
     110 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from net/core/page_pool.c:14:
   In file included from include/net/netdev_lock.h:7:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:863:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     863 |         outsb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:122:55: note: expanded from macro 'outsb'
     122 | #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from net/core/page_pool.c:14:
   In file included from include/net/netdev_lock.h:7:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:872:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     872 |         outsw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:123:55: note: expanded from macro 'outsw'
     123 | #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from net/core/page_pool.c:14:
   In file included from include/net/netdev_lock.h:7:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:881:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     881 |         outsl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:124:55: note: expanded from macro 'outsl'
     124 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from net/core/page_pool.c:14:
   In file included from include/net/netdev_lock.h:7:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
   In file included from net/core/page_pool.c:11:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:19:
>> arch/riscv/include/asm/percpu.h:43:1: error: instruction requires the following: RV64I Base Instruction Set
      43 | PERCPU_OP(add, add)
         | ^
   arch/riscv/include/asm/percpu.h:41:2: note: expanded from macro 'PERCPU_OP'
      41 |         __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
         |         ^
   arch/riscv/include/asm/percpu.h:33:3: note: expanded from macro '__PERCPU_AMO_OP_CASE'
      33 |                 "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
         |                 ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         amoadd.d zero, s4, 0(a1)
         |         ^
   In file included from net/core/page_pool.c:11:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:19:
>> arch/riscv/include/asm/percpu.h:43:1: error: instruction requires the following: RV64I Base Instruction Set
      43 | PERCPU_OP(add, add)
         | ^
   arch/riscv/include/asm/percpu.h:41:2: note: expanded from macro 'PERCPU_OP'
      41 |         __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
         |         ^
   arch/riscv/include/asm/percpu.h:33:3: note: expanded from macro '__PERCPU_AMO_OP_CASE'
      33 |                 "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
         |                 ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         amoadd.d zero, a2, 0(a1)
         |         ^
   In file included from net/core/page_pool.c:11:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:19:
>> arch/riscv/include/asm/percpu.h:43:1: error: instruction requires the following: RV64I Base Instruction Set
      43 | PERCPU_OP(add, add)
         | ^
   arch/riscv/include/asm/percpu.h:41:2: note: expanded from macro 'PERCPU_OP'
      41 |         __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
         |         ^
   arch/riscv/include/asm/percpu.h:33:3: note: expanded from macro '__PERCPU_AMO_OP_CASE'
      33 |                 "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
         |                 ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         amoadd.d zero, a2, 0(a1)
         |         ^
   In file included from net/core/page_pool.c:11:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:19:
>> arch/riscv/include/asm/percpu.h:43:1: error: instruction requires the following: RV64I Base Instruction Set
      43 | PERCPU_OP(add, add)
         | ^
   arch/riscv/include/asm/percpu.h:41:2: note: expanded from macro 'PERCPU_OP'
      41 |         __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
         |         ^
   arch/riscv/include/asm/percpu.h:33:3: note: expanded from macro '__PERCPU_AMO_OP_CASE'
      33 |                 "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
         |                 ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         amoadd.d zero, s9, 0(a1)
         |         ^
   In file included from net/core/page_pool.c:11:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:19:
>> arch/riscv/include/asm/percpu.h:43:1: error: instruction requires the following: RV64I Base Instruction Set
      43 | PERCPU_OP(add, add)
         | ^
   arch/riscv/include/asm/percpu.h:41:2: note: expanded from macro 'PERCPU_OP'
      41 |         __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
         |         ^
   arch/riscv/include/asm/percpu.h:33:3: note: expanded from macro '__PERCPU_AMO_OP_CASE'
      33 |                 "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
         |                 ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         amoadd.d zero, s9, 0(a0)
         |         ^
   In file included from net/core/page_pool.c:11:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:19:
>> arch/riscv/include/asm/percpu.h:43:1: error: instruction requires the following: RV64I Base Instruction Set
      43 | PERCPU_OP(add, add)
         | ^
   arch/riscv/include/asm/percpu.h:41:2: note: expanded from macro 'PERCPU_OP'
      41 |         __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
         |         ^
   arch/riscv/include/asm/percpu.h:33:3: note: expanded from macro '__PERCPU_AMO_OP_CASE'
      33 |                 "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
         |                 ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         amoadd.d zero, s7, 0(a1)
         |         ^
   In file included from net/core/page_pool.c:11:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:19:
>> arch/riscv/include/asm/percpu.h:43:1: error: instruction requires the following: RV64I Base Instruction Set
      43 | PERCPU_OP(add, add)
         | ^
   arch/riscv/include/asm/percpu.h:41:2: note: expanded from macro 'PERCPU_OP'
      41 |         __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
         |         ^
   arch/riscv/include/asm/percpu.h:33:3: note: expanded from macro '__PERCPU_AMO_OP_CASE'
      33 |                 "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
         |                 ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         amoadd.d zero, a2, 0(a1)
         |         ^
   In file included from net/core/page_pool.c:11:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:19:
>> arch/riscv/include/asm/percpu.h:43:1: error: instruction requires the following: RV64I Base Instruction Set
      43 | PERCPU_OP(add, add)
         | ^
   arch/riscv/include/asm/percpu.h:41:2: note: expanded from macro 'PERCPU_OP'
      41 |         __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
         |         ^
   arch/riscv/include/asm/percpu.h:33:3: note: expanded from macro '__PERCPU_AMO_OP_CASE'
      33 |                 "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
         |                 ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         amoadd.d zero, a2, 0(a1)
         |         ^
   In file included from net/core/page_pool.c:11:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:19:
>> arch/riscv/include/asm/percpu.h:43:1: error: instruction requires the following: RV64I Base Instruction Set
      43 | PERCPU_OP(add, add)
         | ^
   arch/riscv/include/asm/percpu.h:41:2: note: expanded from macro 'PERCPU_OP'
      41 |         __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
         |         ^
   arch/riscv/include/asm/percpu.h:33:3: note: expanded from macro '__PERCPU_AMO_OP_CASE'
      33 |                 "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
         |                 ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         amoadd.d zero, a2, 0(a1)
         |         ^
   7 warnings and 9 errors generated.
--
   include/asm-generic/io.h:854:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     854 |         insl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:110:53: note: expanded from macro 'insl'
     110 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from net/batman-adv/routing.c:7:
   In file included from net/batman-adv/routing.h:10:
   In file included from net/batman-adv/main.h:207:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:863:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     863 |         outsb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:122:55: note: expanded from macro 'outsb'
     122 | #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from net/batman-adv/routing.c:7:
   In file included from net/batman-adv/routing.h:10:
   In file included from net/batman-adv/main.h:207:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:872:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     872 |         outsw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:123:55: note: expanded from macro 'outsw'
     123 | #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from net/batman-adv/routing.c:7:
   In file included from net/batman-adv/routing.h:10:
   In file included from net/batman-adv/main.h:207:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:881:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     881 |         outsl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:124:55: note: expanded from macro 'outsl'
     124 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from net/batman-adv/routing.c:7:
   In file included from net/batman-adv/routing.h:10:
   In file included from net/batman-adv/main.h:207:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
   In file included from net/batman-adv/routing.c:7:
   In file included from net/batman-adv/routing.h:10:
   In file included from net/batman-adv/main.h:207:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:5:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:7:
   In file included from include/linux/list_lru.h:13:
   In file included from include/linux/shrinker.h:8:
   In file included from include/linux/completion.h:12:
   In file included from include/linux/swait.h:7:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:19:
>> arch/riscv/include/asm/percpu.h:43:1: error: instruction requires the following: RV64I Base Instruction Set
      43 | PERCPU_OP(add, add)
         | ^
   arch/riscv/include/asm/percpu.h:41:2: note: expanded from macro 'PERCPU_OP'
      41 |         __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
         |         ^
   arch/riscv/include/asm/percpu.h:33:3: note: expanded from macro '__PERCPU_AMO_OP_CASE'
      33 |                 "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
         |                 ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         amoadd.d zero, a2, 0(a1)
         |         ^
   In file included from net/batman-adv/routing.c:7:
   In file included from net/batman-adv/routing.h:10:
   In file included from net/batman-adv/main.h:207:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:5:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:7:
   In file included from include/linux/list_lru.h:13:
   In file included from include/linux/shrinker.h:8:
   In file included from include/linux/completion.h:12:
   In file included from include/linux/swait.h:7:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:19:
>> arch/riscv/include/asm/percpu.h:43:1: error: instruction requires the following: RV64I Base Instruction Set
      43 | PERCPU_OP(add, add)
         | ^
   arch/riscv/include/asm/percpu.h:41:2: note: expanded from macro 'PERCPU_OP'
      41 |         __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
         |         ^
   arch/riscv/include/asm/percpu.h:33:3: note: expanded from macro '__PERCPU_AMO_OP_CASE'
      33 |                 "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
         |                 ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         amoadd.d zero, s6, 0(a1)
         |         ^
   In file included from net/batman-adv/routing.c:7:
   In file included from net/batman-adv/routing.h:10:
   In file included from net/batman-adv/main.h:207:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:5:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:7:
   In file included from include/linux/list_lru.h:13:
   In file included from include/linux/shrinker.h:8:
   In file included from include/linux/completion.h:12:
   In file included from include/linux/swait.h:7:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:19:
>> arch/riscv/include/asm/percpu.h:43:1: error: instruction requires the following: RV64I Base Instruction Set
      43 | PERCPU_OP(add, add)
         | ^
   arch/riscv/include/asm/percpu.h:41:2: note: expanded from macro 'PERCPU_OP'
      41 |         __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
         |         ^
   arch/riscv/include/asm/percpu.h:33:3: note: expanded from macro '__PERCPU_AMO_OP_CASE'
      33 |                 "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
         |                 ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         amoadd.d zero, a2, 0(a1)
         |         ^
   In file included from net/batman-adv/routing.c:7:
   In file included from net/batman-adv/routing.h:10:
   In file included from net/batman-adv/main.h:207:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:5:
   In file included from include/linux/fs.h:5:
   In file included from include/linux/fs/super.h:5:
   In file included from include/linux/fs/super_types.h:7:
   In file included from include/linux/list_lru.h:13:
   In file included from include/linux/shrinker.h:8:
   In file included from include/linux/completion.h:12:
   In file included from include/linux/swait.h:7:
   In file included from include/linux/spinlock.h:59:
   In file included from include/linux/irqflags.h:19:
>> arch/riscv/include/asm/percpu.h:43:1: error: instruction requires the following: RV64I Base Instruction Set
      43 | PERCPU_OP(add, add)
         | ^
   arch/riscv/include/asm/percpu.h:41:2: note: expanded from macro 'PERCPU_OP'
      41 |         __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
         |         ^
   arch/riscv/include/asm/percpu.h:33:3: note: expanded from macro '__PERCPU_AMO_OP_CASE'
      33 |                 "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
         |                 ^
   <inline asm>:1:2: note: instantiated into assembly here
       1 |         amoadd.d zero, a1, 0(a2)
         |         ^
   7 warnings and 4 errors generated.
..


vim +43 arch/riscv/include/asm/percpu.h

    38	
    39	#define PERCPU_OP(name, amo_insn)					\
    40		__PERCPU_AMO_OP_CASE(.w, name, 32, amo_insn)			\
    41		__PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
    42	
  > 43	PERCPU_OP(add, add)
    44	PERCPU_OP(andnot, and)
    45	PERCPU_OP(or, or)
    46	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

