Return-Path: <bpf+bounces-50826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B05BAA2D25B
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 01:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CEB188CE59
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 00:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D921DA3D;
	Sat,  8 Feb 2025 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4DDrIpN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C4B2CA6;
	Sat,  8 Feb 2025 00:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738975419; cv=none; b=njA3Vpg3F6JiGdDw5elQP+fIJ24KT9g3lrdQ5EV5h8i5GM/Oi3vBsJ0fXr/YPneq4i15W7SVAjH+AQ3cm0lExj/oxUhDcIA/mR8Yu1kp/4vm4RcDdUkekNzeTJHpScWZjMzX0gQZBoguOMg/Wn6X9zxnSor3wIhsjpKhvyfLvBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738975419; c=relaxed/simple;
	bh=Xg/MgPonWvECjQA65kTkegGR9LxFyeFNABlwMtYCpSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiGgawgiE16br+CZfWR8eFKtKWuZ3FfI7Vm/fPXDCR5le6WOOrCjErmri4p/TpYgUICS+z3VrIrRPi+P+VPgaartNyNKxSbnYo8OMrZDPXDuMA1RAyTcbzupBxI6hLnqTev2YzUHERDeGDxNnh1jbW41rfR1ZMJFpJAeHnQIWcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4DDrIpN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738975418; x=1770511418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xg/MgPonWvECjQA65kTkegGR9LxFyeFNABlwMtYCpSU=;
  b=C4DDrIpNf8vJJnJBzKMDonz9rnLAg6Q/aYS9ivdQH2rNqZPpJvWuDR1v
   b1QFeoOez57D3Lr2vbmrha0DpOYarmR4ZGjA/jWQqFRpSEvB4RjODnCCX
   XiPlAtIfHRHrtILpu6z6BaOr4cJxiK01g4gzdrqGlrGpCzKsyWaCEXbZk
   +YqknnLobo1yjzEskA41pRlHsOPxLp3qZP3eyjioEQU6fb5bthE0E8xq+
   xq89UqRqb6/R0+aZmB4nf0QrZutQD/n2dfZ2NU7+cifRZvaOJjAT+Bc/K
   SmjuB1svbaTtQOIrDjpuoMJb547he64trZ4NcP5iOBhaU6h2mPmULdHN/
   Q==;
X-CSE-ConnectionGUID: jFmxIjEdQVykWolBG3ldfw==
X-CSE-MsgGUID: VAFIXI9pS5KdQHrqHsXVng==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39892893"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="39892893"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:43:37 -0800
X-CSE-ConnectionGUID: Ge764EICRVGS8/4ATAXARw==
X-CSE-MsgGUID: gxJI/wlCTI2SpRIv2Y6toA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="116672578"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 07 Feb 2025 16:43:32 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgYwU-000zGd-14;
	Sat, 08 Feb 2025 00:43:30 +0000
Date: Sat, 8 Feb 2025 08:43:24 +0800
From: kernel test robot <lkp@intel.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH bpf-next v2 18/26] rqspinlock: Add entry to Makefile,
 MAINTAINERS
Message-ID: <202502080835.XRxxo7P5-lkp@intel.com>
References: <20250206105435.2159977-19-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206105435.2159977-19-memxor@gmail.com>

Hi Kumar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0abff462d802a352c87b7f5e71b442b09bf9cfff]

url:    https://github.com/intel-lab-lkp/linux/commits/Kumar-Kartikeya-Dwivedi/locking-Move-MCS-struct-definition-to-public-header/20250206-190258
base:   0abff462d802a352c87b7f5e71b442b09bf9cfff
patch link:    https://lore.kernel.org/r/20250206105435.2159977-19-memxor%40gmail.com
patch subject: [PATCH bpf-next v2 18/26] rqspinlock: Add entry to Makefile, MAINTAINERS
config: x86_64-randconfig-121-20250207 (https://download.01.org/0day-ci/archive/20250208/202502080835.XRxxo7P5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250208/202502080835.XRxxo7P5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502080835.XRxxo7P5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/locking/rqspinlock.c:101:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct rqspinlock_held * @@
   kernel/locking/rqspinlock.c:101:39: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/locking/rqspinlock.c:101:39: sparse:     got struct rqspinlock_held *
   kernel/locking/rqspinlock.c:123:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct rqspinlock_held * @@
   kernel/locking/rqspinlock.c:123:39: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/locking/rqspinlock.c:123:39: sparse:     got struct rqspinlock_held *
   kernel/locking/rqspinlock.c:136:51: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct rqspinlock_held * @@
   kernel/locking/rqspinlock.c:136:51: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/locking/rqspinlock.c:136:51: sparse:     got struct rqspinlock_held *
   kernel/locking/rqspinlock.c:206:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct rqspinlock_held * @@
   kernel/locking/rqspinlock.c:206:39: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/locking/rqspinlock.c:206:39: sparse:     got struct rqspinlock_held *
>> kernel/locking/rqspinlock.c:572:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct qnode *qnodes @@     got struct qnode [noderef] __percpu * @@
   kernel/locking/rqspinlock.c:572:41: sparse:     expected struct qnode *qnodes
   kernel/locking/rqspinlock.c:572:41: sparse:     got struct qnode [noderef] __percpu *
   kernel/locking/rqspinlock.c: note: in included file:
   kernel/locking/qspinlock.h:67:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct mcs_spinlock * @@
   kernel/locking/qspinlock.h:67:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/locking/qspinlock.h:67:16: sparse:     got struct mcs_spinlock *

vim +101 kernel/locking/rqspinlock.c

6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06   97  
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06   98  static noinline int check_deadlock_AA(rqspinlock_t *lock, u32 mask,
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06   99  				      struct rqspinlock_timeout *ts)
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06  100  {
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06 @101  	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06  102  	int cnt = min(RES_NR_HELD, rqh->cnt);
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06  103  
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06  104  	/*
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06  105  	 * Return an error if we hold the lock we are attempting to acquire.
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06  106  	 * We'll iterate over max 32 locks; no need to do is_lock_released.
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06  107  	 */
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06  108  	for (int i = 0; i < cnt - 1; i++) {
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06  109  		if (rqh->locks[i] == lock)
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06  110  			return -EDEADLK;
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06  111  	}
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06  112  	return 0;
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06  113  }
6516ce00a1482f Kumar Kartikeya Dwivedi 2025-02-06  114  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

