Return-Path: <bpf+bounces-22439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E56A85E415
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 18:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552F1285224
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160FD83A00;
	Wed, 21 Feb 2024 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0VeoA2R"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5682D9F
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535473; cv=none; b=dsbxG4a7sK+oUciwXEOqTFX6qi2AvwJfApNK1f9+EzRYlUcc21C+E4SEd/AZYXdb1VMPcaj94u5GEQ++NKSY6YFh2rZeFO9aBFiFXD236Iye2N3A32m9mDnv7hd9WXYTXbWt9Y1VJ6yfhz39r0QOeICJ797twcp4aAGbLEztA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535473; c=relaxed/simple;
	bh=W054sNogcz/u7+HyZtTEQSEfmbl3wqZqXM3Iq30J+ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLYa0gpjq7FPSnw681BzlddyDhWxxQ2pg5oGUMO9JXsZGPXq817+IF7O76209rIykH4w0t/TS8/pNJhhwj16GmBhKSJ5Pe5fFnYpu8SdzJxrljr2TDPWLsxf1DklhKXPf1kCx1crTkVoulpV9wYd+G/wgn81X66NOI2Y8SzI37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0VeoA2R; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708535472; x=1740071472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W054sNogcz/u7+HyZtTEQSEfmbl3wqZqXM3Iq30J+ZA=;
  b=J0VeoA2R46NgFjIndI8UK1bqrRKSO85eyTv1D9ynp+P0vHfxo9GuQmB7
   OnuFnrL6OHOOtUc1MBPHKxa69sXz88jbnMXlygWLUIe/2A86AIf1quYyY
   ImJkjn5y+odZoWGDUKbrAAcntSlf01slPq2cnOonKiuDjQ7Xh/TCuTxd4
   KbP+Onqv1Iay0026j3IFlIRQxqpksTaL/Pos5+fB4/rp4+Wy0og6Jb18A
   IgcjL/NUi6moiiOHXLfwz3a5z5uGsA+QN+Cp2p2fDSBEqyVH0aiG3orEU
   HIsFTlh7HOxSvsWD2evpFObjqoHox8OKwhGWmo0xkMbbUtKJyZ8Uf+WQO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="5662499"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="5662499"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 09:11:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="9892954"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 21 Feb 2024 09:10:59 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcq79-0005Ws-23;
	Wed, 21 Feb 2024 17:10:41 +0000
Date: Thu, 22 Feb 2024 01:08:33 +0800
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
Message-ID: <202402220052.S3IUgmez-lkp@intel.com>
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
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20240222/202402220052.S3IUgmez-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 36adfec155de366d722f2bac8ff9162289dcf06c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240222/202402220052.S3IUgmez-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402220052.S3IUgmez-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from kernel/fork.c:34:
   In file included from include/linux/mempolicy.h:15:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from kernel/fork.c:34:
   In file included from include/linux/mempolicy.h:15:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from kernel/fork.c:34:
   In file included from include/linux/mempolicy.h:15:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from kernel/fork.c:105:
   In file included from arch/um/include/asm/pgalloc.h:13:
>> include/asm-generic/pgalloc.h:149:20: warning: function 'pmd_populate_kernel' has internal linkage but is not defined [-Wundefined-internal]
     149 | static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
         |                    ^
   include/asm-generic/pgalloc.h:159:2: note: used here
     159 |         pmd_populate_kernel(mm, pmdp, ptep);
         |         ^
   13 warnings generated.
--
   In file included from mm/mremap.c:12:
   In file included from include/linux/mm_inline.h:8:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from mm/mremap.c:12:
   In file included from include/linux/mm_inline.h:8:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from mm/mremap.c:12:
   In file included from include/linux/mm_inline.h:8:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from mm/mremap.c:31:
   In file included from arch/um/include/asm/pgalloc.h:13:
>> include/asm-generic/pgalloc.h:149:20: warning: function 'pmd_populate_kernel' has internal linkage but is not defined [-Wundefined-internal]
     149 | static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
         |                    ^
   include/asm-generic/pgalloc.h:159:2: note: used here
     159 |         pmd_populate_kernel(mm, pmdp, ptep);
         |         ^
   mm/mremap.c:228:20: warning: unused function 'arch_supports_page_table_move' [-Wunused-function]
     228 | static inline bool arch_supports_page_table_move(void)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/mremap.c:227:39: note: expanded from macro 'arch_supports_page_table_move'
     227 | #define arch_supports_page_table_move arch_supports_page_table_move
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   14 warnings generated.
--
   arch/um/kernel/skas/mmu.c:17:5: warning: no previous prototype for function 'init_new_context' [-Wmissing-prototypes]
      17 | int init_new_context(struct task_struct *task, struct mm_struct *mm)
         |     ^
   arch/um/kernel/skas/mmu.c:17:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      17 | int init_new_context(struct task_struct *task, struct mm_struct *mm)
         | ^
         | static 
   arch/um/kernel/skas/mmu.c:60:6: warning: no previous prototype for function 'destroy_context' [-Wmissing-prototypes]
      60 | void destroy_context(struct mm_struct *mm)
         |      ^
   arch/um/kernel/skas/mmu.c:60:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      60 | void destroy_context(struct mm_struct *mm)
         | ^
         | static 
   In file included from arch/um/kernel/skas/mmu.c:11:
   In file included from arch/um/include/asm/pgalloc.h:13:
>> include/asm-generic/pgalloc.h:149:20: warning: function 'pmd_populate_kernel' has internal linkage but is not defined [-Wundefined-internal]
     149 | static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
         |                    ^
   include/asm-generic/pgalloc.h:159:2: note: used here
     159 |         pmd_populate_kernel(mm, pmdp, ptep);
         |         ^
   3 warnings generated.
--
   /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
   /usr/bin/ld: mm/memory.o: in function `pmd_populate_kernel_at':
>> include/asm-generic/pgalloc.h:159: undefined reference to `pmd_populate_kernel'
   clang: error: linker command failed with exit code 1 (use -v to see invocation)


vim +159 include/asm-generic/pgalloc.h

   144	
   145	#ifdef __HAVE_ARCH_ADDR_COND_PMD
   146	static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
   147				pte_t *ptep, unsigned long address);
   148	#else
 > 149	static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
   150				pte_t *ptep);
   151	#endif
   152	
   153	static inline void pmd_populate_kernel_at(struct mm_struct *mm, pmd_t *pmdp,
   154				pte_t *ptep, unsigned long address)
   155	{
   156	#ifdef __HAVE_ARCH_ADDR_COND_PMD
   157		pmd_populate_kernel(mm, pmdp, ptep, address);
   158	#else
 > 159		pmd_populate_kernel(mm, pmdp, ptep);
   160	#endif
   161	}
   162	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

