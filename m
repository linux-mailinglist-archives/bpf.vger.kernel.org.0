Return-Path: <bpf+bounces-72290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3593FC0B60A
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 23:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D13D94EB984
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 22:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBED9287257;
	Sun, 26 Oct 2025 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXHxmzzb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF68248F59
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761518160; cv=none; b=GI1PwTA9oOqmJh9jiRgSG8jvYHMARuG2ypIcLvopPGTODFvxwJyyh/Lm61D6bMilFcqizBl8av0d/vTCE4h06jywiOMUsj0mweiUG6Zsm8YgPhcqpvKDZXPRyrgiO2pXCoPigq5Op/1ecIa/xYkagrrNaMbuM3tMtcHRdnaj4Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761518160; c=relaxed/simple;
	bh=QVjyM9uxZ8VN4mp5Z+B4kQY7I8TfqddgD4VEx+Dt8ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMROlnz7ZbtDUbBGoZi5iqs5niGMcz+pcy8ewwTmtFrXF22LVvgp5s11E6m5SJ4OPhmIF/lGn9ixrA9YnSQyrGC9knyOwLDRZkZ54M/E1LGkMShvt7o/lAgLCLnBeCmNRgQV1I972pOtd02w/P+o7wOtOxNh67SAIDP2e5/67yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXHxmzzb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761518159; x=1793054159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QVjyM9uxZ8VN4mp5Z+B4kQY7I8TfqddgD4VEx+Dt8ZE=;
  b=ZXHxmzzbBf8f8BddxBTsiMRMNIoXnzfHuxTUanX8Jeb2S0AEIU48eH3/
   3cihWh7wYpxVcTh5S4G/fiiYwSOZZd+RwAJh4u5ME7fom+Muncilhr54u
   P0GB6LzJKkNy1R3DjeCT1kBY9s4hU+mUkV7EwbP3HcQsOCigRJN+rxUOb
   s5zvGy8VzZvVQ+jfXXjqSsViklY6/OvvuCcerugWbnWLQnRqmgW73BTtH
   GZmeCYnKL8ganNMyvHWSoFE4AnhgqJBWHyZUws+LyX117UJHH2oXZkcuS
   jKqibYLj6cl1drmrpPb/JNFtTHgE5MjqDgBJ4RirNIwdN1h3BhVygW66n
   w==;
X-CSE-ConnectionGUID: reiG3lrPSSS5O0kS0rHtiQ==
X-CSE-MsgGUID: EXV/m1ABRFehaQolLfltmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63304298"
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="63304298"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 15:35:59 -0700
X-CSE-ConnectionGUID: 7uHnqRYqSUyW5SC50gK+Ow==
X-CSE-MsgGUID: /FKdCeH+SGiyeSqgvdiqqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="184977700"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 26 Oct 2025 15:35:55 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vD9KP-000GMz-0X;
	Sun, 26 Oct 2025 22:35:22 +0000
Date: Mon, 27 Oct 2025 06:34:37 +0800
From: kernel test robot <lkp@intel.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v7 bpf-next 01/12] bpf, x86: add new map type:
 instructions array
Message-ID: <202510270615.wd4tivUA-lkp@intel.com>
References: <20251026192709.1964787-2-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026192709.1964787-2-a.s.protopopov@gmail.com>

Hi Anton,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Anton-Protopopov/bpf-x86-add-new-map-type-instructions-array/20251027-032442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251026192709.1964787-2-a.s.protopopov%40gmail.com
patch subject: [PATCH v7 bpf-next 01/12] bpf, x86: add new map type: instructions array
config: x86_64-buildonly-randconfig-003-20251027 (https://download.01.org/0day-ci/archive/20251027/202510270615.wd4tivUA-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251027/202510270615.wd4tivUA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510270615.wd4tivUA-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/security.h:35,
                    from include/linux/perf_event.h:53,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:95,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/sched.h:61,
                    from kernel/sched/rq-offsets.c:5:
>> include/linux/bpf.h:3807:1: error: expected identifier or '(' before '{' token
    3807 | {
         | ^
>> include/linux/bpf.h:3805:1: warning: 'bpf_prog_update_insn_ptrs' declared 'static' but never defined [-Wunused-function]
    3805 | bpf_prog_update_insn_ptrs(struct bpf_prog *prog, void *jit_priv,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:182: kernel/sched/rq-offsets.s] Error 1 shuffle=2043598271
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1280: prepare0] Error 2 shuffle=2043598271
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=2043598271
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=2043598271
   make: Target 'prepare' not remade because of errors.


vim +3807 include/linux/bpf.h

  3799	
  3800	#ifdef CONFIG_BPF_SYSCALL
  3801	void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, void *jit_priv,
  3802				       update_insn_ptr_func_t update_insn_ptr);
  3803	#else
  3804	static inline void
> 3805	bpf_prog_update_insn_ptrs(struct bpf_prog *prog, void *jit_priv,
  3806				  update_insn_ptr_func_t update_insn_ptr);
> 3807	{
  3808	}
  3809	#endif
  3810	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

