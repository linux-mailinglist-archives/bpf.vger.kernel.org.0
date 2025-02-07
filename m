Return-Path: <bpf+bounces-50767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CC8A2C403
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 14:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA267A5568
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F621F5617;
	Fri,  7 Feb 2025 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJcrWYj8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515E1E98F4;
	Fri,  7 Feb 2025 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935857; cv=none; b=X3m4acHs1YJ2p6jSL+O7EYtV2oFawZ+aSRe1uQWvPoan7rsexDhlbwCrHElCOr+beI26AkMiEvRtlt4CgOg8V8BUQQ9exr8VMuTO1ije0QfDljYJlzDkkavUNaT1VK0CG67YsjY0qvaUOp16nWkFeYIlt3mpfgldQ5Y/ZYoRHCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935857; c=relaxed/simple;
	bh=yvDb/9al0b5cbGYGz+egPFvQ2z5zm9IAuwXMbV2aY9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCV45qB507VuFAcO3DYHJmiRvTwL3WFIiKhj6Z7pm5sLjIbEJWcvqQ+gub6HojVgQmYaWHam3uBqk3708hvHoloOzCOvYXZKdw045P4zDOlqbZz2WX36xY98glacjEwyhyhIYfkFSR93PylcrMoOTTRpN4HEyHRhYY1lnFDf9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJcrWYj8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738935856; x=1770471856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yvDb/9al0b5cbGYGz+egPFvQ2z5zm9IAuwXMbV2aY9g=;
  b=UJcrWYj8vxwHNBuwzgZYTu4L3Gr4BSKf/1Tje0gr+JbAW655GQPLKk6A
   ZIoZZ+q9WBlkNn7CULRyzZKdSbSWimV8jQ/AxbSVGamcWzO5UqHuc/S12
   GTt/UuSimA5N+cGjxLo/9lJurXQv+vtCKqQ37/QIYruOceGxk5NuIbwWn
   YNcj+gQYnHT2Htf1bki//aRd9giraY8q3WQE29lJtVxNwgjj2vWYFE4Dj
   HP/iMhWXflyix+2Y+nWZf1naWby1IUzgIFUqGAYTZPuNH69bEcenZgvth
   lsERRQBWqgx37XCBohXJr+zFzPZvlkFC9avTCZT4gW7SH3fnPcSEvLj2T
   w==;
X-CSE-ConnectionGUID: 9xHJAJrXSgOU5j+m+aPSzQ==
X-CSE-MsgGUID: pIfWsmu6TgaTzgdEglFd+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39448796"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39448796"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 05:44:15 -0800
X-CSE-ConnectionGUID: YD3vx1NJSq2zirfoHgButQ==
X-CSE-MsgGUID: ndUXSvlTQgKqyCDXne74cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="116533405"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 07 Feb 2025 05:44:10 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgOeN-000yPD-1L;
	Fri, 07 Feb 2025 13:44:07 +0000
Date: Fri, 7 Feb 2025 21:43:45 +0800
From: kernel test robot <lkp@intel.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 22/26] bpf: Introduce rqspinlock kfuncs
Message-ID: <202502072155.DbOeX8Le-lkp@intel.com>
References: <20250206105435.2159977-23-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206105435.2159977-23-memxor@gmail.com>

Hi Kumar,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0abff462d802a352c87b7f5e71b442b09bf9cfff]

url:    https://github.com/intel-lab-lkp/linux/commits/Kumar-Kartikeya-Dwivedi/locking-Move-MCS-struct-definition-to-public-header/20250206-190258
base:   0abff462d802a352c87b7f5e71b442b09bf9cfff
patch link:    https://lore.kernel.org/r/20250206105435.2159977-23-memxor%40gmail.com
patch subject: [PATCH bpf-next v2 22/26] bpf: Introduce rqspinlock kfuncs
config: x86_64-buildonly-randconfig-004-20250207 (https://download.01.org/0day-ci/archive/20250207/202502072155.DbOeX8Le-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250207/202502072155.DbOeX8Le-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502072155.DbOeX8Le-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/timerfd.c:26:
   In file included from include/linux/syscalls.h:94:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:62:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:33:
   In file included from arch/x86/include/asm/rqspinlock.h:27:
>> include/asm-generic/rqspinlock.h:40:12: error: conflicting types for 'resilient_tas_spin_lock'
      40 | extern int resilient_tas_spin_lock(rqspinlock_t *lock, u64 timeout);
         |            ^
   arch/x86/include/asm/rqspinlock.h:17:12: note: previous declaration is here
      17 | extern int resilient_tas_spin_lock(struct qspinlock *lock, u64 timeout);
         |            ^
   1 error generated.
--
   In file included from fs/splice.c:27:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
   In file included from fs/splice.c:31:
   In file included from include/linux/syscalls.h:94:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:62:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:33:
   In file included from arch/x86/include/asm/rqspinlock.h:27:
>> include/asm-generic/rqspinlock.h:40:12: error: conflicting types for 'resilient_tas_spin_lock'
      40 | extern int resilient_tas_spin_lock(rqspinlock_t *lock, u64 timeout);
         |            ^
   arch/x86/include/asm/rqspinlock.h:17:12: note: previous declaration is here
      17 | extern int resilient_tas_spin_lock(struct qspinlock *lock, u64 timeout);
         |            ^
   2 warnings and 1 error generated.
--
   In file included from fs/aio.c:20:
   In file included from include/linux/syscalls.h:94:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:62:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:33:
   In file included from arch/x86/include/asm/rqspinlock.h:27:
>> include/asm-generic/rqspinlock.h:40:12: error: conflicting types for 'resilient_tas_spin_lock'
      40 | extern int resilient_tas_spin_lock(rqspinlock_t *lock, u64 timeout);
         |            ^
   arch/x86/include/asm/rqspinlock.h:17:12: note: previous declaration is here
      17 | extern int resilient_tas_spin_lock(struct qspinlock *lock, u64 timeout);
         |            ^
   In file included from fs/aio.c:29:
   include/linux/mman.h:159:9: warning: division by zero is undefined [-Wdivision-by-zero]
     159 |                _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:137:21: note: expanded from macro '_calc_vm_trans'
     137 |    : ((x) & (bit1)) / ((bit1) / (bit2))))
         |                     ^ ~~~~~~~~~~~~~~~~~
   include/linux/mman.h:160:9: warning: division by zero is undefined [-Wdivision-by-zero]
     160 |                _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE) |
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:137:21: note: expanded from macro '_calc_vm_trans'
     137 |    : ((x) & (bit1)) / ((bit1) / (bit2))))
         |                     ^ ~~~~~~~~~~~~~~~~~
   2 warnings and 1 error generated.


vim +/resilient_tas_spin_lock +40 include/asm-generic/rqspinlock.h

c34e46edef2a89 Kumar Kartikeya Dwivedi 2025-02-06  39  
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06 @40  extern int resilient_tas_spin_lock(rqspinlock_t *lock, u64 timeout);
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  41  #ifdef CONFIG_QUEUED_SPINLOCKS
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06  42  extern int resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val, u64 timeout);
7a9d3b27f7bf9c Kumar Kartikeya Dwivedi 2025-02-06  43  #endif
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06  44  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

