Return-Path: <bpf+bounces-51395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA242A33D1B
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 11:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D98188BD91
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 10:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048A82139C8;
	Thu, 13 Feb 2025 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j30VancN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6C32139B0;
	Thu, 13 Feb 2025 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444306; cv=none; b=ujd0zvTRbWVPs8pd6f2xyCu4s7zktiGSYizJskoVDIkuchBRg4ZSOnq+jJhOg0p9vGRd0bOaJvkXcj3DcHOod5m5Fq560iKOV2Tmdq+Qax5vJq9dliFfZr6u+39+VKCUaUEXFYh5inmN1Hggsy2CakipAt6wlDpcdPwbu9Vjo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444306; c=relaxed/simple;
	bh=pTt4Dk/mWDy0iReP/udyoCzdyuN4y/N0LeolOL9CKSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIJ3CDhiOc/LhvwCkZq2TWup5XC/1HXoctK9GJkQxOQDGyo2FdO8e1u0CXO3d03gR1VeXH/arV3uXu9Apcr1b2SvyIAsqS1wg6ct8VSggWj/HJXam8V4ox580k+5FVURowk5j0sV2Mub0SWmdTz4o2slKuccrnpFsCKz0y0ImGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j30VancN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739444304; x=1770980304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pTt4Dk/mWDy0iReP/udyoCzdyuN4y/N0LeolOL9CKSo=;
  b=j30VancNgMMQOMCDRfluWbQhe2NYbPUNnpY4Nu2Ibx+yQCAdLUFKxvWM
   ygbpivIf+VxOl63qysB1Kocz4LPsnJK93yZsj5X3F3ej7OSV8bprhHPXj
   QV2o1/4a1K5qIxHkiwlqGqrNTTuNfkpzt+HTfl/JhafAfa8JUOPY61uOm
   Z7L9wALx2CzBNLIXfEyjTYqXsb4m4tJTMuIliVXhXmuyy5rK60ukZu+iG
   HnyIr0w8L0qP5J0HLyT4xISUes7JXD8AjuK3kH4P6HyAOkZqXaN94r6mf
   Pr7bOgYMOOnN4wIhKjdFurFPCHBBudPFrieyMl30dTzKnosupFBwh1fEn
   A==;
X-CSE-ConnectionGUID: MIKYbMxvSE629s8YAMZJ+w==
X-CSE-MsgGUID: 9WT2fEaETSum8ONvDLIbjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="57542064"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="57542064"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 02:58:23 -0800
X-CSE-ConnectionGUID: zI83mEhvQIKfX2/42nUXVg==
X-CSE-MsgGUID: ubMBOrkqR02OfjXgd6sv2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112942474"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Feb 2025 02:58:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiWvA-0016wl-0J;
	Thu, 13 Feb 2025 10:58:16 +0000
Date: Thu, 13 Feb 2025 18:57:25 +0800
From: kernel test robot <lkp@intel.com>
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 6/7] sched_ext: idle: Per-node idle cpumasks
Message-ID: <202502131834.ni8ojoRO-lkp@intel.com>
References: <20250212165006.490130-7-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212165006.490130-7-arighi@nvidia.com>

Hi Andrea,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250212]
[cannot apply to tip/sched/core akpm-mm/mm-everything tip/master linus/master tip/auto-latest v6.14-rc2 v6.14-rc1 v6.13 v6.14-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrea-Righi/mm-numa-Introduce-nearest_node_nodemask/20250213-014857
base:   next-20250212
patch link:    https://lore.kernel.org/r/20250212165006.490130-7-arighi%40nvidia.com
patch subject: [PATCH 6/7] sched_ext: idle: Per-node idle cpumasks
config: i386-buildonly-randconfig-005-20250213 (https://download.01.org/0day-ci/archive/20250213/202502131834.ni8ojoRO-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502131834.ni8ojoRO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502131834.ni8ojoRO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:63:
   kernel/sched/ext.c:6014:31: warning: bitwise operation between different enumeration types ('enum scx_enq_flags' and 'enum scx_deq_flags') [-Wenum-enum-conversion]
    6014 |         WRITE_ONCE(v, SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP | SCX_KICK_PREEMPT |
         |                       ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:61:18: note: expanded from macro 'WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |                         ^~~
   include/asm-generic/rwonce.h:55:33: note: expanded from macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   In file included from kernel/sched/build_policy.c:64:
>> kernel/sched/ext_idle.c:136:9: error: '__section__' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
     136 |         static DEFINE_PER_CPU(nodemask_t, per_cpu_unvisited);
         |                ^
   include/linux/percpu-defs.h:115:2: note: expanded from macro 'DEFINE_PER_CPU'
     115 |         DEFINE_PER_CPU_SECTION(type, name, "")
         |         ^
   include/linux/percpu-defs.h:93:2: note: expanded from macro 'DEFINE_PER_CPU_SECTION'
      93 |         __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;                   \
         |         ^
   include/linux/percpu-defs.h:54:2: note: expanded from macro '__PCPU_DUMMY_ATTRS'
      54 |         __section(".discard") __attribute__((unused))
         |         ^
   include/linux/compiler_attributes.h:321:56: note: expanded from macro '__section'
     321 | #define __section(section)              __attribute__((__section__(section)))
         |                                                        ^
   In file included from kernel/sched/build_policy.c:64:
>> kernel/sched/ext_idle.c:136:9: error: non-extern declaration of '__pcpu_unique_per_cpu_unvisited' follows extern declaration
   include/linux/percpu-defs.h:115:2: note: expanded from macro 'DEFINE_PER_CPU'
     115 |         DEFINE_PER_CPU_SECTION(type, name, "")
         |         ^
   include/linux/percpu-defs.h:93:26: note: expanded from macro 'DEFINE_PER_CPU_SECTION'
      93 |         __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;                   \
         |                                 ^
   <scratch space>:82:1: note: expanded from here
      82 | __pcpu_unique_per_cpu_unvisited
         | ^
   kernel/sched/ext_idle.c:136:9: note: previous declaration is here
   include/linux/percpu-defs.h:115:2: note: expanded from macro 'DEFINE_PER_CPU'
     115 |         DEFINE_PER_CPU_SECTION(type, name, "")
         |         ^
   include/linux/percpu-defs.h:92:33: note: expanded from macro 'DEFINE_PER_CPU_SECTION'
      92 |         extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;            \
         |                                        ^
   <scratch space>:81:1: note: expanded from here
      81 | __pcpu_unique_per_cpu_unvisited
         | ^
   In file included from kernel/sched/build_policy.c:64:
>> kernel/sched/ext_idle.c:136:9: error: 'section' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
     136 |         static DEFINE_PER_CPU(nodemask_t, per_cpu_unvisited);
         |                ^
   include/linux/percpu-defs.h:115:2: note: expanded from macro 'DEFINE_PER_CPU'
     115 |         DEFINE_PER_CPU_SECTION(type, name, "")
         |         ^
   include/linux/percpu-defs.h:95:2: note: expanded from macro 'DEFINE_PER_CPU_SECTION'
      95 |         __PCPU_ATTRS(sec) __weak __typeof__(type) name
         |         ^
   include/linux/percpu-defs.h:50:26: note: expanded from macro '__PCPU_ATTRS'
      50 |         __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))     \
         |                                 ^
   In file included from kernel/sched/build_policy.c:64:
>> kernel/sched/ext_idle.c:136:36: error: non-extern declaration of 'per_cpu_unvisited' follows extern declaration
     136 |         static DEFINE_PER_CPU(nodemask_t, per_cpu_unvisited);
         |                                           ^
   kernel/sched/ext_idle.c:136:36: note: previous declaration is here
>> kernel/sched/ext_idle.c:136:9: error: weak declaration cannot have internal linkage
     136 |         static DEFINE_PER_CPU(nodemask_t, per_cpu_unvisited);
         |                ^
   include/linux/percpu-defs.h:115:2: note: expanded from macro 'DEFINE_PER_CPU'
     115 |         DEFINE_PER_CPU_SECTION(type, name, "")
         |         ^
   include/linux/percpu-defs.h:95:20: note: expanded from macro 'DEFINE_PER_CPU_SECTION'
      95 |         __PCPU_ATTRS(sec) __weak __typeof__(type) name
         |                           ^
   include/linux/compiler_attributes.h:403:56: note: expanded from macro '__weak'
     403 | #define __weak                          __attribute__((__weak__))
         |                                                        ^
   1 warning and 5 errors generated.


vim +/__section__ +136 kernel/sched/ext_idle.c

   133	
   134	static s32 pick_idle_cpu_from_other_nodes(const struct cpumask *cpus_allowed, int node, u64 flags)
   135	{
 > 136		static DEFINE_PER_CPU(nodemask_t, per_cpu_unvisited);
   137		nodemask_t *unvisited = this_cpu_ptr(&per_cpu_unvisited);
   138		s32 cpu = -EBUSY;
   139	
   140		preempt_disable();
   141		unvisited = this_cpu_ptr(&per_cpu_unvisited);
   142	
   143		/*
   144		 * Restrict the search to the online nodes, excluding the current
   145		 * one.
   146		 */
   147		nodes_clear(*unvisited);
   148		nodes_or(*unvisited, *unvisited, node_states[N_ONLINE]);
   149		node_clear(node, *unvisited);
   150	
   151		/*
   152		 * Traverse all nodes in order of increasing distance, starting
   153		 * from @node.
   154		 *
   155		 * This loop is O(N^2), with N being the amount of NUMA nodes,
   156		 * which might be quite expensive in large NUMA systems. However,
   157		 * this complexity comes into play only when a scheduler enables
   158		 * SCX_OPS_BUILTIN_IDLE_PER_NODE and it's requesting an idle CPU
   159		 * without specifying a target NUMA node, so it shouldn't be a
   160		 * bottleneck is most cases.
   161		 *
   162		 * As a future optimization we may want to cache the list of nodes
   163		 * in a per-node array, instead of actually traversing them every
   164		 * time.
   165		 */
   166		for_each_node_numadist(node, *unvisited) {
   167			cpu = pick_idle_cpu_in_node(cpus_allowed, node, flags);
   168			if (cpu >= 0)
   169				break;
   170		}
   171		preempt_enable();
   172	
   173		return cpu;
   174	}
   175	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

