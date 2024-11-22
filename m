Return-Path: <bpf+bounces-45443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344B29D583D
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 03:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED997281AA7
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 02:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0064C156665;
	Fri, 22 Nov 2024 02:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oA/Otanz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31909230988
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 02:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732241913; cv=none; b=aAEK6DCygwIZPRMLhkRru3+H+eYUzqxk1lGoRYgpP+PulK9iIUrYMa6zw8Ch1l6G2TG8CkTx/mMF2DYpj94ESHB1k9fEV+Y+mUrWfsI+Bfbm0p7w9DSClA/6LBW7bwUuFjkUZgxkNvFgTrAnnG9HihmDI0v6chFWUe4NaFk/UU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732241913; c=relaxed/simple;
	bh=ODWvk7E+SEFZ4Rsus9/BcA0x+W4duyZuK6WXYa4dn/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRTJqhkhpec/EMqXUsN35LQswDg5F9qXUYn+uthrp6V//KCQDWO6W7jF3x68Pry9T9MIpAJ88WlQ9ArOLZQ+Rhk+SUZKv4Y6PIvn9cS2YYkhLu8YNGtXxugPNEPCylW5bb5weBTWr0w9Y/4Ln/Fvp/L3fSHykttDYxYnOW9shPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oA/Otanz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732241911; x=1763777911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ODWvk7E+SEFZ4Rsus9/BcA0x+W4duyZuK6WXYa4dn/4=;
  b=oA/OtanzooJz3bHJCQkNptdatLxUAH01FlmH1fQDnn482aErmg6XpvJg
   pHdjuj0kDj1ohQRfhhZ6/tcfYUatH46LO1sgx8md8+3Op0l0ZhcyNXgPv
   NRUoHpML41FNj4ntRCC9XAEYsCoBCvqMlUbBR8PQ4mB4z903OcwT6TIsV
   QP+YNhYziS7jUbDqm2ltgT2NVdz2q9Z14foFO1k3UFWAVam9otEztycPx
   fPichHRNsSq+OU7HSQnnQ9txpKWpkS9v/GvU19ubUlUg6RJWfmPmxY1bk
   jmdQaIitkt8tdxg2YwgbL/bTAi0ok8HB0GJKvm8iItSmnOInP6vgyBFsO
   w==;
X-CSE-ConnectionGUID: oRR9b42IQySyBeSKEyYTCw==
X-CSE-MsgGUID: b92LChOtQVW865R01bvDHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32443325"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="32443325"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 18:18:31 -0800
X-CSE-ConnectionGUID: BMcMDJnbRO6oAv81lF3Elg==
X-CSE-MsgGUID: j9g2ctH3SPeA96RlquntIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="90854441"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 21 Nov 2024 18:18:30 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEJFb-0003aR-0e;
	Fri, 22 Nov 2024 02:18:27 +0000
Date: Fri, 22 Nov 2024 10:17:39 +0800
From: kernel test robot <lkp@intel.com>
To: Alastair Robertson <ajor@meta.com>, bpf@vger.kernel.org,
	andrii@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alastair Robertson <ajor@meta.com>
Subject: Re: [PATCH bpf-next] libbpf: Extend linker API to support in-memory
 ELF files
Message-ID: <202411221039.4cgeHanS-lkp@intel.com>
References: <20241120170206.2592931-1-ajor@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120170206.2592931-1-ajor@meta.com>

Hi Alastair,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Alastair-Robertson/libbpf-Extend-linker-API-to-support-in-memory-ELF-files/20241121-152231
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241120170206.2592931-1-ajor%40meta.com
patch subject: [PATCH bpf-next] libbpf: Extend linker API to support in-memory ELF files
config: i386-buildonly-randconfig-001-20241122 (https://download.01.org/0day-ci/archive/20241122/202411221039.4cgeHanS-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411221039.4cgeHanS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411221039.4cgeHanS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> linker.c:2733:5: error: no previous prototype for function 'linker_finalize_common' [-Werror,-Wmissing-prototypes]
    2733 | int linker_finalize_common(struct bpf_linker *linker)
         |     ^
   linker.c:2733:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    2733 | int linker_finalize_common(struct bpf_linker *linker)
         | ^
         | static 
   1 error generated.
   make[6]: *** [tools/build/Makefile.build:105: tools/bpf/resolve_btfids/libbpf/staticobjs/linker.o] Error 1
   make[6]: *** Waiting for unfinished jobs....
   make[5]: *** [Makefile:165: tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o] Error 2
   make[4]: *** [Makefile:63: tools/bpf/resolve_btfids//libbpf/libbpf.a] Error 2
   make[3]: *** [Makefile:76: bpf/resolve_btfids] Error 2 shuffle=3701184676
   make[2]: *** [Makefile:1370: tools/bpf/resolve_btfids] Error 2 shuffle=3701184676
   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   1 warning generated.
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2 shuffle=3701184676
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2 shuffle=3701184676
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

