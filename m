Return-Path: <bpf+bounces-43056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C559AEB95
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 18:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216A91C224E6
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE54E1F76C7;
	Thu, 24 Oct 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QDG9AF5t"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078D01F76AF
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786453; cv=none; b=F2+sdp8CKu8jrgvFHx8HpMG6CBRMK49cNINw7I3rENM8nbNIlBC5eSTFjukcKSueLxAbIbXsWzJsqq41Pf2WESEj8oDI/Om4tvlXTFkEc+7hbKzEJvUHY5fgN8avsb1JHBV2cTMILZmpnXWehycgO5j8jsO/KcZ9DI5l6ARIR6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786453; c=relaxed/simple;
	bh=a4MM/5nou0YCi2Vim9bfmw1HMxf9hc6i55LNYdcuQNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6J5DY0ZTC3AHEVvIElmNwrCKO0ahm06RDHlFj/ry2mOq9sXwG3kBZdoCZ/HEVeRxBNC3LHnAg6Ootq8LkO6iq5F1qB15a/2IrxWxcc7MmA2a0AV/5zcZ9h3AbThgc3+iZ9rQjmpcriVlG69TLDbOBw2PxHSmfIepRwLpfqFss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QDG9AF5t; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729786451; x=1761322451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a4MM/5nou0YCi2Vim9bfmw1HMxf9hc6i55LNYdcuQNk=;
  b=QDG9AF5tHXyS+jPb4Mhf76PtxexQWy4QHJ5VcQj7Zyj6vCpSsLNlQouj
   G9GnfBI9G8KRjM9DGVvvR8FUYyDJhCiIlZy2c9dZ2h3yO2g5FHH8e6UkB
   7VcjbNmDEXl+lnzXe4lvaRFzPqW4HwpARsZO7/QFKBFSQPorBjJEJDlry
   S7mDW+VkTxK7Rp+UO64ai1N5ld8cFy4Ufq+KLqbGz5jIk9GpgIEuz8L3t
   wB5FZRnr4fpEqilRg7Oaf9ZMIt192kXOeM2GiiTrbE1Mm716wNk2z6D5v
   QOprT65tZko0KIcrQwGa0JH3pgvzLM5zZu9FXJ55VI4AP4nnIDR7KdK51
   g==;
X-CSE-ConnectionGUID: LlOIl6cTSKWXq5sksj+/nw==
X-CSE-MsgGUID: XRvAkTfgSISFPhwQYMnWgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40541459"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40541459"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 09:14:07 -0700
X-CSE-ConnectionGUID: 2pPKaNyaTvOCOQi4+eO1Vw==
X-CSE-MsgGUID: zy7vjvMbR8yh2RiiDxOnLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80941085"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 24 Oct 2024 09:14:04 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t40TK-000Wfk-1H;
	Thu, 24 Oct 2024 16:14:02 +0000
Date: Fri, 25 Oct 2024 00:13:58 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, x86@kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_get_hw_counter kfunc
Message-ID: <202410242317.RqcJ3H1k-lkp@intel.com>
References: <20241023210437.2266063-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023210437.2266063-1-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/selftests-bpf-add-selftest-to-check-rdtsc-jit/20241024-050747
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241023210437.2266063-1-vadfed%40meta.com
patch subject: [PATCH bpf-next 1/2] bpf: add bpf_get_hw_counter kfunc
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20241024/202410242317.RqcJ3H1k-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241024/202410242317.RqcJ3H1k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410242317.RqcJ3H1k-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from kernel/bpf/helpers.c:4:
   In file included from include/linux/bpf.h:21:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from kernel/bpf/helpers.c:26:
>> arch/riscv/include/asm/vdso/gettimeofday.h:72:21: warning: declaration of 'struct vdso_data' will not be visible outside of this function [-Wvisibility]
      72 |                                                  const struct vdso_data *vd)
         |                                                               ^
>> arch/riscv/include/asm/vdso/gettimeofday.h:84:9: error: use of undeclared identifier '_vdso_data'
      84 |         return _vdso_data;
         |                ^
>> arch/riscv/include/asm/vdso/gettimeofday.h:91:9: error: use of undeclared identifier '_timens_data'
      91 |         return _timens_data;
         |                ^
   kernel/bpf/helpers.c:115:36: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     115 |         .arg2_type      = ARG_PTR_TO_MAP_VALUE | MEM_UNINIT,
         |                           ~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:128:36: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     128 |         .arg2_type      = ARG_PTR_TO_MAP_VALUE | MEM_UNINIT,
         |                           ~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:539:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     539 |         .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:542:41: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     542 |         .arg4_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:567:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     567 |         .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:570:41: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     570 |         .arg4_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:583:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     583 |         .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:653:35: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     653 |         .arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:725:39: warning: bitwise operation between different enumeration types ('enum bpf_return_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     725 |         .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:738:39: warning: bitwise operation between different enumeration types ('enum bpf_return_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     738 |         .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:1080:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1080 |         .arg4_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1641:44: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1641 |         .arg2_type    = ARG_PTR_TO_BTF_ID_OR_NULL | OBJ_RELEASE,
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   kernel/bpf/helpers.c:1746:33: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1746 |         .arg4_type      = ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
         |                           ~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1789:33: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1789 |         .arg3_type      = ARG_PTR_TO_DYNPTR | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:1837:33: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1837 |         .arg1_type      = ARG_PTR_TO_DYNPTR | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:1839:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1839 |         .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/helpers.c:1879:33: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    1879 |         .arg1_type      = ARG_PTR_TO_DYNPTR | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   19 warnings and 2 errors generated.


vim +/_vdso_data +84 arch/riscv/include/asm/vdso/gettimeofday.h

aa5af0aa90bad3 Evan Green      2023-04-07  70  
4c5a116ada953b Thomas Gleixner 2020-08-04  71  static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
4c5a116ada953b Thomas Gleixner 2020-08-04 @72  						 const struct vdso_data *vd)
ad5d1122b82fbd Vincent Chen    2020-06-09  73  {
ad5d1122b82fbd Vincent Chen    2020-06-09  74  	/*
ad5d1122b82fbd Vincent Chen    2020-06-09  75  	 * The purpose of csr_read(CSR_TIME) is to trap the system into
ad5d1122b82fbd Vincent Chen    2020-06-09  76  	 * M-mode to obtain the value of CSR_TIME. Hence, unlike other
ad5d1122b82fbd Vincent Chen    2020-06-09  77  	 * architecture, no fence instructions surround the csr_read()
ad5d1122b82fbd Vincent Chen    2020-06-09  78  	 */
ad5d1122b82fbd Vincent Chen    2020-06-09  79  	return csr_read(CSR_TIME);
ad5d1122b82fbd Vincent Chen    2020-06-09  80  }
ad5d1122b82fbd Vincent Chen    2020-06-09  81  
ad5d1122b82fbd Vincent Chen    2020-06-09  82  static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
ad5d1122b82fbd Vincent Chen    2020-06-09  83  {
ad5d1122b82fbd Vincent Chen    2020-06-09 @84  	return _vdso_data;
ad5d1122b82fbd Vincent Chen    2020-06-09  85  }
ad5d1122b82fbd Vincent Chen    2020-06-09  86  
dffe11e280a42c Tong Tiangen    2021-09-01  87  #ifdef CONFIG_TIME_NS
dffe11e280a42c Tong Tiangen    2021-09-01  88  static __always_inline
dffe11e280a42c Tong Tiangen    2021-09-01  89  const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
dffe11e280a42c Tong Tiangen    2021-09-01  90  {
dffe11e280a42c Tong Tiangen    2021-09-01 @91  	return _timens_data;
dffe11e280a42c Tong Tiangen    2021-09-01  92  }
dffe11e280a42c Tong Tiangen    2021-09-01  93  #endif
ad5d1122b82fbd Vincent Chen    2020-06-09  94  #endif /* !__ASSEMBLY__ */
ad5d1122b82fbd Vincent Chen    2020-06-09  95  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

