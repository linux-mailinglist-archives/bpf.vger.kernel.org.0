Return-Path: <bpf+bounces-43055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F0A9AEB94
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 18:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1500C285788
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 16:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF731F76B6;
	Thu, 24 Oct 2024 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7lsjtDq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DCF139578
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786450; cv=none; b=H2B2IESCFHbAP8HnKFcgdGpj4cHArKcvnryA0tXcCwJPP5s9jTF1fG4Q4W4uDt03TFoIEpwc4wcOuJobRl2Vl0N5NmL1M5eCXKpWVSVj6iDBMCPdyBOERgIR7BEFz7GVuc532JL4b1XEiUPqkU+f0CjpGutVlu5gEXkI2Omff2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786450; c=relaxed/simple;
	bh=xErujhmSB5ghLTs0tclOBAHSN7AE7TSES38pwinpm4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+7EEjiQ8+Kx39r0Hr48sndSuOR7tWdXhwPoE2lNtK7m2CKDwtg57ehT5O0PaxQuas/+s6c1J0hoiHDd8Gkvu50GSq01jsl1HgFl713HBRLgv7YycH7JChKay30lk+eWbTyY3ceLGF6W1Cs4GOACNdpl488rY54UPQKhqTkqgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7lsjtDq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729786448; x=1761322448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xErujhmSB5ghLTs0tclOBAHSN7AE7TSES38pwinpm4E=;
  b=a7lsjtDqLYvLfTV+hESRBXqDjuVq5YDHvdrcVkPeALlMdoYDiVVQdmju
   jlQA2UiS4aq8mvxjWm8gPOyEILBIVYvEytAnx27ffT8LQg4BOs7PJmodY
   olEnc9VLi/mxV/EYbraPxVq6olYwY3ZkELOO4fKwGYXEwhDt9zGCr5q5V
   ChNpqslQ7lR7Q27ayyq81uAUDX4p9jS/ES7napc1OulbnU7NOyJZK70kL
   DzHWiZAE55ffcOSdGjSsVFh6EyRLBz7ATMbwgll/myOF8v1jQJcd7jELD
   A3OB6C9LFkrGBD56A5uUKdyt1yc2pxX3g6r8JI6Tw+Wh341jtDcdiSnQY
   g==;
X-CSE-ConnectionGUID: PX617ay0QPeYSiTEGc6o/g==
X-CSE-MsgGUID: eRhVgeCjQ4mI+KlKLwGlCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40541453"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40541453"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 09:14:07 -0700
X-CSE-ConnectionGUID: kGmDSDKyRgCU1BAVB9FN9Q==
X-CSE-MsgGUID: xUeawweuTo21Fg5GYZapgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80941084"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 24 Oct 2024 09:14:04 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t40TK-000Wfg-18;
	Thu, 24 Oct 2024 16:14:02 +0000
Date: Fri, 25 Oct 2024 00:13:56 +0800
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
Message-ID: <202410242310.od2UFxiK-lkp@intel.com>
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
config: arm64-randconfig-001-20241024 (https://download.01.org/0day-ci/archive/20241024/202410242310.od2UFxiK-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241024/202410242310.od2UFxiK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410242310.od2UFxiK-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from kernel/bpf/helpers.c:4:
   In file included from include/linux/bpf.h:21:
   In file included from include/linux/kallsyms.h:13:
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
   In file included from kernel/bpf/helpers.c:26:
>> arch/arm64/include/asm/vdso/gettimeofday.h:70:21: warning: declaration of 'struct vdso_data' will not be visible outside of this function [-Wvisibility]
      70 |                                                  const struct vdso_data *vd)
         |                                                               ^
>> arch/arm64/include/asm/vdso/gettimeofday.h:79:20: error: use of undeclared identifier 'VDSO_CLOCKMODE_NONE'
      79 |         if (clock_mode == VDSO_CLOCKMODE_NONE)
         |                           ^
>> arch/arm64/include/asm/vdso/gettimeofday.h:105:9: error: use of undeclared identifier '_vdso_data'
     105 |         return _vdso_data;
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
   21 warnings and 2 errors generated.


vim +/VDSO_CLOCKMODE_NONE +79 arch/arm64/include/asm/vdso/gettimeofday.h

28b1a824a4f44d Vincenzo Frascino 2019-06-21   68  
4c5a116ada953b Thomas Gleixner   2020-08-04   69  static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
4c5a116ada953b Thomas Gleixner   2020-08-04  @70  						 const struct vdso_data *vd)
28b1a824a4f44d Vincenzo Frascino 2019-06-21   71  {
28b1a824a4f44d Vincenzo Frascino 2019-06-21   72  	u64 res;
28b1a824a4f44d Vincenzo Frascino 2019-06-21   73  
27e11a9fe2e2e7 Vincenzo Frascino 2019-06-25   74  	/*
5e3c6a312a0946 Thomas Gleixner   2020-02-07   75  	 * Core checks for mode already, so this raced against a concurrent
5e3c6a312a0946 Thomas Gleixner   2020-02-07   76  	 * update. Return something. Core will do another round and then
5e3c6a312a0946 Thomas Gleixner   2020-02-07   77  	 * see the mode change and fallback to the syscall.
27e11a9fe2e2e7 Vincenzo Frascino 2019-06-25   78  	 */
5e3c6a312a0946 Thomas Gleixner   2020-02-07  @79  	if (clock_mode == VDSO_CLOCKMODE_NONE)
5e3c6a312a0946 Thomas Gleixner   2020-02-07   80  		return 0;
27e11a9fe2e2e7 Vincenzo Frascino 2019-06-25   81  
27e11a9fe2e2e7 Vincenzo Frascino 2019-06-25   82  	/*
9025cebf12d176 Joey Gouly        2022-08-30   83  	 * If FEAT_ECV is available, use the self-synchronizing counter.
9025cebf12d176 Joey Gouly        2022-08-30   84  	 * Otherwise the isb is required to prevent that the counter value
27e11a9fe2e2e7 Vincenzo Frascino 2019-06-25   85  	 * is speculated.
27e11a9fe2e2e7 Vincenzo Frascino 2019-06-25   86  	*/
9025cebf12d176 Joey Gouly        2022-08-30   87  	asm volatile(
9025cebf12d176 Joey Gouly        2022-08-30   88  	ALTERNATIVE("isb\n"
9025cebf12d176 Joey Gouly        2022-08-30   89  		    "mrs %0, cntvct_el0",
9025cebf12d176 Joey Gouly        2022-08-30   90  		    "nop\n"
9025cebf12d176 Joey Gouly        2022-08-30   91  		    __mrs_s("%0", SYS_CNTVCTSS_EL0),
9025cebf12d176 Joey Gouly        2022-08-30   92  		    ARM64_HAS_ECV)
9025cebf12d176 Joey Gouly        2022-08-30   93  	: "=r" (res)
9025cebf12d176 Joey Gouly        2022-08-30   94  	:
9025cebf12d176 Joey Gouly        2022-08-30   95  	: "memory");
9025cebf12d176 Joey Gouly        2022-08-30   96  
77ec462536a13d Will Deacon       2021-03-18   97  	arch_counter_enforce_ordering(res);
28b1a824a4f44d Vincenzo Frascino 2019-06-21   98  
28b1a824a4f44d Vincenzo Frascino 2019-06-21   99  	return res;
28b1a824a4f44d Vincenzo Frascino 2019-06-21  100  }
28b1a824a4f44d Vincenzo Frascino 2019-06-21  101  
28b1a824a4f44d Vincenzo Frascino 2019-06-21  102  static __always_inline
28b1a824a4f44d Vincenzo Frascino 2019-06-21  103  const struct vdso_data *__arch_get_vdso_data(void)
28b1a824a4f44d Vincenzo Frascino 2019-06-21  104  {
28b1a824a4f44d Vincenzo Frascino 2019-06-21 @105  	return _vdso_data;
28b1a824a4f44d Vincenzo Frascino 2019-06-21  106  }
28b1a824a4f44d Vincenzo Frascino 2019-06-21  107  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

