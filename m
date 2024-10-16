Return-Path: <bpf+bounces-42186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE389A099E
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 14:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E73D1C22D9D
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 12:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44DC20B1ED;
	Wed, 16 Oct 2024 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+on9mNZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC09209F50;
	Wed, 16 Oct 2024 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081581; cv=none; b=NeP2/tGPUqGla7/rVsQN2r/x6pO/ibRG6UBpf32+yAtET3M/Wt8h27RcT3D4z4vhLQ0metuWpTDQg8mH7c0t8pElbkM09+kH/Ar3xIuU8yQm8jiq/ucMTnXmc9hghHKQsOLNQaqIbmQv6HRKfB1nuX2kErE1jq1u2EEbmK2OAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081581; c=relaxed/simple;
	bh=hAG4Aq/HVk5v5L3NiTsWWHcxwaGleX3poinTXxCQO3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EagyL184qUcaFcojTzDBdcjiRIlKtAAveib3muFKwa/CGRn7piAFWCd08FiiPu4YMfNUarvvV/XhoUx4GMA+RG2yr3wU8f1gelkCNnyrb7sqMSRynYFBiQoj+IJ9a6icFaQxQ6kOfqZyJD+PudN1S7MaiPUgBHwqCwKj2YYwR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+on9mNZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729081579; x=1760617579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hAG4Aq/HVk5v5L3NiTsWWHcxwaGleX3poinTXxCQO3c=;
  b=A+on9mNZ9thTCstIlAkc2UHRf927/RWVVbnUoM3j1frSQ4qcbXRA3zhV
   /dBWAfj953nmTWFXBL0A+M8f1Du/810TvAKnxj/a9cw6X+sIHunMwFB77
   1ykcps/okZK32JhodWDiZkqnw05Kd5wETGg26W3H3GNIxYgE2UyOqrdXe
   rFRqgXx3R1kFD/t40DuWa4DpYatu1lY5sYjMHtRTHkCMTEwWyByMxaZ14
   Rd0kd82wvGdpGl7LiQvHQS5qrDYaX+w/ejiMlc1EbRt3tNYEqvMx/U2rc
   nuJM0vkAbsxdZ3tEIJ2UFxpgxLruNRFXW7BpC/v7PX0OdPY9RDJ5oHdQT
   g==;
X-CSE-ConnectionGUID: woP6nVXRQEibEbFL9ccCtg==
X-CSE-MsgGUID: etapYRR/TUGSx8dadGg+jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28670564"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28670564"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:26:18 -0700
X-CSE-ConnectionGUID: fSV+sNEET7Or5OyD7VKQ2A==
X-CSE-MsgGUID: obcVvpc7T4+Y0lv3l/wd4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="83288733"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Oct 2024 05:26:14 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t136S-000KtL-1E;
	Wed, 16 Oct 2024 12:26:12 +0000
Date: Wed, 16 Oct 2024 20:26:07 +0800
From: kernel test robot <lkp@intel.com>
To: Andrea Righi <andrea.righi@linux.dev>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4] sched_ext: Trigger ops.update_idle() from
 pick_task_idle()
Message-ID: <202410161955.CsmEsAy8-lkp@intel.com>
References: <20241015111539.12136-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015111539.12136-1-andrea.righi@linux.dev>

Hi Andrea,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on linus/master v6.12-rc3 next-20241016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrea-Righi/sched_ext-Trigger-ops-update_idle-from-pick_task_idle/20241015-191701
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20241015111539.12136-1-andrea.righi%40linux.dev
patch subject: [PATCH v4] sched_ext: Trigger ops.update_idle() from pick_task_idle()
config: x86_64-randconfig-122-20241016 (https://download.01.org/0day-ci/archive/20241016/202410161955.CsmEsAy8-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410161955.CsmEsAy8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410161955.CsmEsAy8-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/build_policy.c: note: in included file:
>> kernel/sched/idle.c:481:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/idle.c:481:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/idle.c:481:22: sparse:    struct task_struct *
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/rt.c:991:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:991:38: sparse:     expected struct task_struct *curr
   kernel/sched/rt.c:991:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:1529:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1529:31: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:1529:31: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/deadline.c:2341:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:2341:42: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:2341:42: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:1242:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1242:39: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1242:39: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1242:85: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:1242:85: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:1242:85: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:1342:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1342:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1342:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1651:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1651:31: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1651:31: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1651:70: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:1651:70: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:1651:70: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:1739:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1739:38: sparse:     expected struct task_struct *curr
   kernel/sched/deadline.c:1739:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:3054:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:3054:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:3054:22: sparse:    struct task_struct *
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/syscalls.c:206:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/syscalls.c:206:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/syscalls.c:206:22: sparse:    struct task_struct *
   kernel/sched/build_policy.c: note: in included file (through include/linux/smp.h, include/linux/sched/clock.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/sched.h:2265:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2265:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2265:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2265:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2265:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2265:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2265:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2265:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2265:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2265:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2265:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2265:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2265:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2265:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2265:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2451:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2451:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2451:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2265:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2265:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2265:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2451:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2451:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2451:9: sparse:    struct task_struct *
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/syscalls.c:1331:6: sparse: sparse: context imbalance in 'sched_getaffinity' - different lock contexts for basic block
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/sched.h:2265:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2265:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2265:25: sparse:    struct task_struct *

vim +481 kernel/sched/idle.c

   466	
   467	struct task_struct *pick_task_idle(struct rq *rq)
   468	{
   469		/*
   470		 * When switching from a non-idle to the idle class, .set_next_task()
   471		 * is called only once during the transition.
   472		 *
   473		 * However, the CPU may remain active for multiple rounds running the
   474		 * idle task (e.g., by calling scx_bpf_kick_cpu() from the
   475		 * ops.update_idle() callback).
   476		 *
   477		 * In such cases, we need to keep updating the scx idle state to
   478		 * properly re-trigger the ops.update_idle() callback and ensure
   479		 * correct handling of scx idle state transitions.
   480		 */
 > 481		if (rq->curr == rq->idle)
   482			scx_update_idle(rq, true);
   483		return rq->idle;
   484	}
   485	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

