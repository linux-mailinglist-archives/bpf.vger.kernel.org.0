Return-Path: <bpf+bounces-43146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 140909AFDD5
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 11:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876B11F2413B
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 09:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626041DD0F9;
	Fri, 25 Oct 2024 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMX2wLbv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1742D1DACB6;
	Fri, 25 Oct 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847708; cv=none; b=NYQ8G+kNhxwFprT3xeOA4ziU6y+mmJBWY6YOeEKYfP6alQsyTTySf2VlKDCg5k4YGkLtB+egAE9hXu7E9P0P0xUTB3xBBa7G/c/ZdwP7msMpyDnjqf/NA8yKIKFAupVmtMQfnz8L72yDepfpGGJ973mvu5Z1ujy/fXCLhs/R0EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847708; c=relaxed/simple;
	bh=4XMDoD+OeLfbg1UVKD38t5UItaObkTJ3EMHjIj5Uj94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDy3az4Rdp0KQgpSbg2rgGy0ktF06lKxeM//FG/aqIxqL3as9+PcUayKUK/kxz7GVdh945MnvEjulgZ5/8+/ZzAlxJTggSa2l+AQe3UVfr/9rKXLvlZsP3AZVEdRAJ8RNX1wPjV/mIacXpL6ECCd2kv69enWiB33zcE38v7hOio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMX2wLbv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729847706; x=1761383706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4XMDoD+OeLfbg1UVKD38t5UItaObkTJ3EMHjIj5Uj94=;
  b=EMX2wLbvBL+z++EU8aXIWmakBrS2W6+gSnZQAcAFZhn1cchMcslEfDJM
   0gs8jStoRqSzyz+tYMTXqBFY1UvzjZrP/kmkKnR9GUrFStk+P7QAVnsY7
   53+WNxBpJiVXjl9oq1TO5ndG0iX8uToUjaFCrn0qL8n/0HzhO8wVdfejP
   yga/DJ2GACQqzrUkE6PFJPdZKcLaoty0HQkclhxHY0215mTs9bnh23noK
   /2IgkSCgLIDozP8JrIQ3nKP4fsbQdsCCbP3UmWFKcpjso6oT5vOq8Vm2S
   xUgR6ZeJ4NuLcm/e0Tlov9RV+2bs0feDui7W7Xd+jAz0/+PAslb+Xs+5E
   g==;
X-CSE-ConnectionGUID: +H4Tfs8MS+m8Kq+JUvJ+Ng==
X-CSE-MsgGUID: iqwsR7vBRr6Otv3herqZuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52066589"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52066589"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 02:15:01 -0700
X-CSE-ConnectionGUID: UyiVqf9YRASFXPSsA9mn2Q==
X-CSE-MsgGUID: HLEMjEXGRF62b6hBGS5IGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="85653620"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 25 Oct 2024 02:14:54 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4GPD-000XyP-17;
	Fri, 25 Oct 2024 09:14:51 +0000
Date: Fri, 25 Oct 2024 17:14:26 +0800
From: kernel test robot <lkp@intel.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	guwen@linux.alibaba.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org, dtcccc@linux.alibaba.com
Subject: Re: [PATCH bpf-next 2/4] bpf: allow to access bpf_prog during
 bpf_struct_access
Message-ID: <202410251600.4VOzw93J-lkp@intel.com>
References: <1729737768-124596-3-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729737768-124596-3-git-send-email-alibuda@linux.alibaba.com>

Hi Wythe,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/D-Wythe/bpf-export-necessary-sympols-for-modules/20241024-104903
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/1729737768-124596-3-git-send-email-alibuda%40linux.alibaba.com
patch subject: [PATCH bpf-next 2/4] bpf: allow to access bpf_prog during bpf_struct_access
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241025/202410251600.4VOzw93J-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410251600.4VOzw93J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410251600.4VOzw93J-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/hid/bpf/hid_bpf_struct_ops.c:10:
   In file included from include/linux/bpf_verifier.h:7:
   In file included from include/linux/bpf.h:20:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/hid/bpf/hid_bpf_struct_ops.c:10:
   In file included from include/linux/bpf_verifier.h:9:
   In file included from include/linux/filter.h:12:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/hid/bpf/hid_bpf_struct_ops.c:10:
   In file included from include/linux/bpf_verifier.h:9:
   In file included from include/linux/filter.h:12:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/hid/bpf/hid_bpf_struct_ops.c:10:
   In file included from include/linux/bpf_verifier.h:9:
   In file included from include/linux/filter.h:12:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/hid/bpf/hid_bpf_struct_ops.c:146:23: error: incompatible function pointer types initializing 'int (*)(struct bpf_verifier_log *, const struct bpf_reg_state *, const struct bpf_prog *, int, int)' with an expression of type 'int (struct bpf_verifier_log *, const struct bpf_reg_state *, int, int)' [-Wincompatible-function-pointer-types]
     146 |         .btf_struct_access = hid_bpf_ops_btf_struct_access,
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   16 warnings and 1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]


vim +146 drivers/hid/bpf/hid_bpf_struct_ops.c

ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  142  
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  143  static const struct bpf_verifier_ops hid_bpf_verifier_ops = {
bd0747543b3d97 Benjamin Tissoires 2024-06-08  144  	.get_func_proto = bpf_base_func_proto,
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  145  	.is_valid_access = hid_bpf_ops_is_valid_access,
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08 @146  	.btf_struct_access = hid_bpf_ops_btf_struct_access,
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  147  };
ebc0d8093e8c97 Benjamin Tissoires 2024-06-08  148  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

