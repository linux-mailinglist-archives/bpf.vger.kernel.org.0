Return-Path: <bpf+bounces-72291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C9C0B677
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 00:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539ED3B7D49
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 23:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D9F2FFDFE;
	Sun, 26 Oct 2025 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2YWgJPW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C842FFDF6
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761519609; cv=none; b=PmRcc8M60fH9pqlwpWuvUdDXjQ7SPpwtSHRlomm0CaESYRBa1530gwwkJgxuGkoe9A5L/mR+gRTHQLY4Obst5X1cbPsiSuyw7IaRWDHhVVbEjmrvruGSSA+suXgbZctwweHCRHfwGfNS9hMZdVTMaGC5907EtRJUf1jTxF4L2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761519609; c=relaxed/simple;
	bh=GG2gG2Zm5sdOiN2dn/HSEsofdKUhfYLNrH9FfHdlQSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0AoYxxep8jFNTj62eyDj2aTRde61jWNYpfuXMOBWuuUNaiwA4XXMus0Xxt6mVwuUUauVHLm/I/LB+aqBs+/UAx7QV8IB9BsNUdoQmcTa/HhgEXQU67gH4XCERXvOZLK/76x+IStMjAMb+UGPHq3xxnwKKvDxCsGud1wZecYiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2YWgJPW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761519608; x=1793055608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GG2gG2Zm5sdOiN2dn/HSEsofdKUhfYLNrH9FfHdlQSw=;
  b=A2YWgJPW0iruhIPhNtkECsjSSiyHcMkgF+W57X8eL3pCxwEsNK1WcJsv
   6Eitym0WF+rd3HIp6io5QmFlXOlbMP2vCuhtJhWM6FS6MBfPB2UJR9Lzs
   VxeZdvQvtLFyCQB7i1gfXNgJa56viIUKLhfK+9jHm3hSnUmzODE3j7gPc
   /TzoxaM2ssYRRO5DpzupWQ4fedbZtXYDu9aJAC+k0VM+qUn1nAaNTIt02
   igF4Jt2MRc/GQd/oXGYHlzMJ9pw0Ylf+7u5OuyjvAcb97cmEg434HCkTO
   ciZCRcUPZnWODgbF4rjce6ca/RO/gZCuwGv2LIByMbmDfYhi+Xm5meD2o
   w==;
X-CSE-ConnectionGUID: lf0Ty56yQ7qujrtcSFeXkA==
X-CSE-MsgGUID: k4FWuDLgTxqL5HKJhIgviw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67433358"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67433358"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 16:00:08 -0700
X-CSE-ConnectionGUID: XC5IWdxUT3CWsELSkY4vIw==
X-CSE-MsgGUID: G1L2gNZJQ3ySXDIHZASnzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="184594560"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 26 Oct 2025 16:00:04 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vD9iT-000GNZ-1H;
	Sun, 26 Oct 2025 23:00:01 +0000
Date: Mon, 27 Oct 2025 06:59:45 +0800
From: kernel test robot <lkp@intel.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v7 bpf-next 01/12] bpf, x86: add new map type:
 instructions array
Message-ID: <202510270614.av6f72iy-lkp@intel.com>
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
config: i386-buildonly-randconfig-005-20251027 (https://download.01.org/0day-ci/archive/20251027/202510270614.av6f72iy-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251027/202510270614.av6f72iy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510270614.av6f72iy-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/rq-offsets.c:5:
   In file included from kernel/sched/sched.h:61:
   In file included from include/linux/syscalls_api.h:1:
   In file included from include/linux/syscalls.h:95:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:53:
   In file included from include/linux/security.h:35:
>> include/linux/bpf.h:3807:1: error: expected identifier or '('
    3807 | {
         | ^
   In file included from kernel/sched/rq-offsets.c:5:
   kernel/sched/sched.h:3743:18: warning: variable 'cpumask' set but not used [-Wunused-but-set-variable]
    3743 |         struct cpumask *cpumask;
         |                         ^
   1 warning and 1 error generated.
   make[3]: *** [scripts/Makefile.build:182: kernel/sched/rq-offsets.s] Error 1 shuffle=3282044347
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1280: prepare0] Error 2 shuffle=3282044347
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=3282044347
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=3282044347
   make: Target 'prepare' not remade because of errors.


vim +3807 include/linux/bpf.h

  3799	
  3800	#ifdef CONFIG_BPF_SYSCALL
  3801	void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, void *jit_priv,
  3802				       update_insn_ptr_func_t update_insn_ptr);
  3803	#else
  3804	static inline void
  3805	bpf_prog_update_insn_ptrs(struct bpf_prog *prog, void *jit_priv,
  3806				  update_insn_ptr_func_t update_insn_ptr);
> 3807	{
  3808	}
  3809	#endif
  3810	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

