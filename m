Return-Path: <bpf+bounces-48621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350D4A0A070
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 04:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9CE16A2E4
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 03:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB6A149C69;
	Sat, 11 Jan 2025 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FEkoW7tB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027E01420A8
	for <bpf@vger.kernel.org>; Sat, 11 Jan 2025 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736565624; cv=none; b=KccnRpsg+mLsS4ypWm517fuNAxYzf4RlCGM3nGccHDp7H5ZD2MblD1V3xrAQfBFFeEu6I6y9KpQofqbXQEsKBrlkUAXIeCLeKJbj+fmQAACl1dXPODLnpe5MeE/OXE8qv17HnZBmzOyfwlZYoMb1Tbu+euDqcR+a4uxMgUFCpbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736565624; c=relaxed/simple;
	bh=vv3etMNIsJNzKK13EcboMYfE7hFrWcDdMlsEoObsAtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9ESbLw+gLvTpPZoAhhOtfa3W+M8Xr9WMAblizagtGa1mPaRkpUlhA/HYVk/6eqRu7LkDArrkgn+/Uv3JvI+IHKwHEp2sMU0yAN9jYLpWg+XzijbUPyYiTTiD86I2t5+WqwW0A8rq400tcdyoninPFSpX9BY+csHXc5l1uiD340=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FEkoW7tB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736565623; x=1768101623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vv3etMNIsJNzKK13EcboMYfE7hFrWcDdMlsEoObsAtI=;
  b=FEkoW7tB3mfpvzQ1ZLAscyRmzyvZ85HW57mUHwiP9OBKoyRuTzmjiKe5
   RGLoXo+kTFLys6HxnthtHvuRsT9W94yQweIm9hkdRbyKsWnpzS2fBQrqF
   ZWQ4QAI4ZEe6ZVWewMW3r5Nzl8xOb9OeqQJfG1Ef7Mfui/UhcsiRZd/Bz
   VnuzDoMBW2Z6gruzb5rxsi274TtDhC08vsOp/m2i0/5orMVGXshzYpz3d
   dQvz9jN4G7qyVL5sabTJ9a1umKhadfnEqjVeBBSmXXYAdkXNunTXxE+tn
   2B9M5WQhfyNdmnQDBBsgPR3ScjXX4qtcl4Qf0ICo0oDa4iGUHmqUiRlDO
   w==;
X-CSE-ConnectionGUID: p3yFlrhTSgWRB26Bacr4hw==
X-CSE-MsgGUID: Kbw5083ZTm2ksPG9Hdi7zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="59352317"
X-IronPort-AV: E=Sophos;i="6.12,306,1728975600"; 
   d="scan'208";a="59352317"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 19:20:21 -0800
X-CSE-ConnectionGUID: 1t1XIpT/RSWWFZuobHp5TQ==
X-CSE-MsgGUID: GdM6t1eZQc69Rywb+l63eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103782415"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Jan 2025 19:20:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWS2p-000K5r-1n;
	Sat, 11 Jan 2025 03:20:15 +0000
Date: Sat, 11 Jan 2025 11:19:19 +0800
From: kernel test robot <lkp@intel.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, nkapron@google.com,
	teknoraver@meta.com, roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org, paul@paul-moore.com, code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: Re: [PATCH 10/14] bpf: Implement BTF fixup functionality
Message-ID: <202501111043.1XoiVhsx-lkp@intel.com>
References: <20250109214617.485144-11-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109214617.485144-11-bboscaccy@linux.microsoft.com>

Hi Blaise,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf/master]
[also build test ERROR on linus/master v6.13-rc6]
[cannot apply to bpf-next/master next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Blaise-Boscaccy/bpf-Add-data-structures-for-managing-in-kernel-eBPF-relocations/20250110-064354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20250109214617.485144-11-bboscaccy%40linux.microsoft.com
patch subject: [PATCH 10/14] bpf: Implement BTF fixup functionality
config: i386-buildonly-randconfig-006-20250111 (https://download.01.org/0day-ci/archive/20250111/202501111043.1XoiVhsx-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250111/202501111043.1XoiVhsx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501111043.1XoiVhsx-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/syscall.c:6438:22: error: incompatible pointer types passing 'Elf32_Sym *' (aka 'struct elf32_sym *') to parameter of type 'const Elf64_Sym *' (aka 'const struct elf64_sym *') [-Werror,-Wincompatible-pointer-types]
    6438 |                 if (!sym_is_extern(&sym[i]))
         |                                    ^~~~~~~
   kernel/bpf/syscall.c:6082:44: note: passing argument to parameter 'sym' here
    6082 | static bool sym_is_extern(const Elf64_Sym *sym)
         |                                            ^
   kernel/bpf/syscall.c:6463:20: error: call to undeclared function 'bpf_core_essential_name_len'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    6463 |                 ext_essent_len = bpf_core_essential_name_len(ext->name);
         |                                  ^
>> kernel/bpf/syscall.c:6664:11: error: incompatible pointer types returning 'Elf32_Sym *' (aka 'struct elf32_sym *') from a function with result type 'Elf64_Sym *' (aka 'struct elf64_sym *') [-Werror,-Wincompatible-pointer-types]
    6664 |                         return &sym[i];
         |                                ^~~~~~~
   kernel/bpf/syscall.c:7286:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7286 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/syscall.c:7336:41: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    7336 |         .arg4_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   2 warnings and 3 errors generated.


vim +6664 kernel/bpf/syscall.c

  6648	
  6649	static Elf64_Sym *find_elf_var_sym(const struct bpf_obj *obj, const char *name)
  6650	{
  6651		unsigned int i;
  6652		Elf_Shdr *symsec = &obj->sechdrs[obj->index.sym];
  6653		Elf_Sym *sym = (void *)obj->hdr + symsec->sh_offset;
  6654	
  6655		for (i = 1; i < symsec->sh_size / sizeof(Elf_Sym); i++) {
  6656			if (ELF64_ST_TYPE(sym[i].st_info) != STT_OBJECT)
  6657				continue;
  6658	
  6659			if (ELF64_ST_BIND(sym[i].st_info) != STB_GLOBAL &&
  6660			    ELF64_ST_BIND(sym[i].st_info) != STB_WEAK)
  6661				continue;
  6662	
  6663			if (strcmp(name,  obj->strtab + sym[i].st_name) == 0)
> 6664				return &sym[i];
  6665	
  6666		}
  6667		return ERR_PTR(-ENOENT);
  6668	}
  6669	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

