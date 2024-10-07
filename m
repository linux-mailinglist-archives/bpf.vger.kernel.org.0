Return-Path: <bpf+bounces-41159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A973C993852
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 22:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D401C23276
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 20:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7702189BBE;
	Mon,  7 Oct 2024 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vhh+yQ6X"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D07320F
	for <bpf@vger.kernel.org>; Mon,  7 Oct 2024 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333200; cv=none; b=A3HQ82/2Rc7+L/8tHE/2Yxuuc4kmxH2VPEKfxMXL0lLhlOrHXvGT2DIZZ/ee633VEP3gId5gXyWEd7/jrEPNHAVxiyMJa+W4k4cbSrXRwuolYeNMdzago9jLR7yqwN1l/4G7JHazJcPg8JCCX1J3mxgiy5TPC8mhJzysted2anw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333200; c=relaxed/simple;
	bh=TjjBb5fKZp0UK0qeNyoIlUSup4FUvOReuGdIKpPHp6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3jHjv6YvFw+vFxrQIMzMSlmBPUWs2GGxahJIJRQFangjAXLxwAfEbKbIEKJeAA9zIGteon4kdXfh9OwnThBaKlcmEh71Hebgn2nQYFSpjqpP2lE/6G+ytoQ+HUu/I3fcdMVER78Ji7J3xVgEIhTYrbwI18kJDPuYXoN5Av3Vxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vhh+yQ6X; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728333198; x=1759869198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TjjBb5fKZp0UK0qeNyoIlUSup4FUvOReuGdIKpPHp6Q=;
  b=Vhh+yQ6XkR5ZP39N1G6oQFTpMSNW21cnLTB4su+vvjeE+pctSV4Snl1v
   mMI0NLrDmbRzD+67h0prtWfpOUDMu/yKqFNcwKa3fzmBvUiHiaf2p2wZr
   oMoa4fNvMpnmOWEhitirttGC6a7TTT+789Wdw0xyc5mdv+tswleisHxea
   5kM+QO7CgvHn7GJPK60arkLfpxMTh6YADHxf8cWb/oBoO7qLg/kvTW19X
   HlM7m9Bc7bVXmwH/Z+vJLMkQc9HUREEqN0ID5Syhi13qyDzZhLRo5I6Q8
   r4/VrXEIRJA5ckB3NkrWrSRDCIq/fSKYtESnR9UL/YpX+1SJs4VA/I98/
   w==;
X-CSE-ConnectionGUID: BQ9EIUdCSHWo7Um5sNU8xA==
X-CSE-MsgGUID: mXuHOoH9Sz2tWXWpzc0Bnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="26994634"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="26994634"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 13:33:17 -0700
X-CSE-ConnectionGUID: Qur5gHvSTbWXapcEHzkbGQ==
X-CSE-MsgGUID: X9FBS0qYREmQCe04xJgDzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75711879"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 Oct 2024 13:33:14 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxuPo-0005VI-00;
	Mon, 07 Oct 2024 20:33:12 +0000
Date: Tue, 8 Oct 2024 04:32:17 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
	martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
	xukuohai@huaweicloud.com, eddyz87@gmail.com, iii@linux.ibm.com,
	leon.hwang@linux.dev, kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Prevent tailcall infinite loop
 caused by freplace
Message-ID: <202410080455.vy5GT8Vz-lkp@intel.com>
References: <20241006130130.77125-2-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006130130.77125-2-leon.hwang@linux.dev>

Hi Leon,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Leon-Hwang/bpf-Prevent-tailcall-infinite-loop-caused-by-freplace/20241006-210309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241006130130.77125-2-leon.hwang%40linux.dev
patch subject: [PATCH bpf-next v5 1/3] bpf: Prevent tailcall infinite loop caused by freplace
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20241008/202410080455.vy5GT8Vz-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241008/202410080455.vy5GT8Vz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410080455.vy5GT8Vz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/fork.c:53:
   In file included from include/linux/security.h:35:
>> include/linux/bpf.h:1392:5: warning: no previous prototype for function 'bpf_extension_link_prog' [-Wmissing-prototypes]
    1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
         |     ^
   include/linux/bpf.h:1392:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
         | ^
         | static 
>> include/linux/bpf.h:1398:5: warning: no previous prototype for function 'bpf_extension_unlink_prog' [-Wmissing-prototypes]
    1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
         |     ^
   include/linux/bpf.h:1398:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
         | ^
         | static 
   2 warnings generated.
--
   In file included from kernel/cpu.c:41:
   In file included from include/trace/events/power.h:12:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:62:
   In file included from include/linux/security.h:35:
>> include/linux/bpf.h:1392:5: warning: no previous prototype for function 'bpf_extension_link_prog' [-Wmissing-prototypes]
    1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
         |     ^
   include/linux/bpf.h:1392:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
         | ^
         | static 
>> include/linux/bpf.h:1398:5: warning: no previous prototype for function 'bpf_extension_unlink_prog' [-Wmissing-prototypes]
    1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
         |     ^
   include/linux/bpf.h:1398:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
         | ^
         | static 
   kernel/cpu.c:112:20: warning: unused function 'cpuhp_lock_acquire' [-Wunused-function]
     112 | static inline void cpuhp_lock_acquire(bool bringup) { }
         |                    ^~~~~~~~~~~~~~~~~~
   kernel/cpu.c:113:20: warning: unused function 'cpuhp_lock_release' [-Wunused-function]
     113 | static inline void cpuhp_lock_release(bool bringup) { }
         |                    ^~~~~~~~~~~~~~~~~~
   4 warnings generated.
--
   In file included from kernel/sched/core.c:14:
   In file included from include/linux/syscalls_api.h:1:
   In file included from include/linux/syscalls.h:93:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:62:
   In file included from include/linux/security.h:35:
>> include/linux/bpf.h:1392:5: warning: no previous prototype for function 'bpf_extension_link_prog' [-Wmissing-prototypes]
    1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
         |     ^
   include/linux/bpf.h:1392:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
         | ^
         | static 
>> include/linux/bpf.h:1398:5: warning: no previous prototype for function 'bpf_extension_unlink_prog' [-Wmissing-prototypes]
    1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
         |     ^
   include/linux/bpf.h:1398:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
         | ^
         | static 
   kernel/sched/core.c:3595:20: warning: unused function 'rq_has_pinned_tasks' [-Wunused-function]
    3595 | static inline bool rq_has_pinned_tasks(struct rq *rq)
         |                    ^~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:5751:20: warning: unused function 'sched_tick_start' [-Wunused-function]
    5751 | static inline void sched_tick_start(int cpu) { }
         |                    ^~~~~~~~~~~~~~~~
   kernel/sched/core.c:5752:20: warning: unused function 'sched_tick_stop' [-Wunused-function]
    5752 | static inline void sched_tick_stop(int cpu) { }
         |                    ^~~~~~~~~~~~~~~
   kernel/sched/core.c:6470:20: warning: unused function 'sched_core_cpu_starting' [-Wunused-function]
    6470 | static inline void sched_core_cpu_starting(unsigned int cpu) {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:6471:20: warning: unused function 'sched_core_cpu_deactivate' [-Wunused-function]
    6471 | static inline void sched_core_cpu_deactivate(unsigned int cpu) {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:6472:20: warning: unused function 'sched_core_cpu_dying' [-Wunused-function]
    6472 | static inline void sched_core_cpu_dying(unsigned int cpu) {}
         |                    ^~~~~~~~~~~~~~~~~~~~
   8 warnings generated.
--
   In file included from kernel/sched/fair.c:54:
   In file included from kernel/sched/sched.h:61:
   In file included from include/linux/syscalls_api.h:1:
   In file included from include/linux/syscalls.h:93:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:62:
   In file included from include/linux/security.h:35:
>> include/linux/bpf.h:1392:5: warning: no previous prototype for function 'bpf_extension_link_prog' [-Wmissing-prototypes]
    1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
         |     ^
   include/linux/bpf.h:1392:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
         | ^
         | static 
>> include/linux/bpf.h:1398:5: warning: no previous prototype for function 'bpf_extension_unlink_prog' [-Wmissing-prototypes]
    1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
         |     ^
   include/linux/bpf.h:1398:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
         | ^
         | static 
   kernel/sched/fair.c:481:20: warning: unused function 'list_del_leaf_cfs_rq' [-Wunused-function]
     481 | static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:502:19: warning: unused function 'tg_is_idle' [-Wunused-function]
     502 | static inline int tg_is_idle(struct task_group *tg)
         |                   ^~~~~~~~~~
   kernel/sched/fair.c:526:19: warning: unused function 'max_vruntime' [-Wunused-function]
     526 | static inline u64 max_vruntime(u64 max_vruntime, u64 vruntime)
         |                   ^~~~~~~~~~~~
   kernel/sched/fair.c:1389:20: warning: unused function 'is_core_idle' [-Wunused-function]
    1389 | static inline bool is_core_idle(int cpu)
         |                    ^~~~~~~~~~~~
   kernel/sched/fair.c:3650:20: warning: unused function 'account_numa_enqueue' [-Wunused-function]
    3650 | static inline void account_numa_enqueue(struct rq *rq, struct task_struct *p)
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:3654:20: warning: unused function 'account_numa_dequeue' [-Wunused-function]
    3654 | static inline void account_numa_dequeue(struct rq *rq, struct task_struct *p)
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:3658:20: warning: unused function 'update_scan_period' [-Wunused-function]
    3658 | static inline void update_scan_period(struct task_struct *p, int new_cpu)
         |                    ^~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:5225:20: warning: unused function 'cfs_rq_is_decayed' [-Wunused-function]
    5225 | static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
         |                    ^~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:5240:20: warning: unused function 'remove_entity_load_avg' [-Wunused-function]
    5240 | static inline void remove_entity_load_avg(struct sched_entity *se) {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:6753:20: warning: unused function 'cfs_bandwidth_used' [-Wunused-function]
    6753 | static inline bool cfs_bandwidth_used(void)
         |                    ^~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:6761:20: warning: unused function 'sync_throttle' [-Wunused-function]
    6761 | static inline void sync_throttle(struct task_group *tg, int cpu) {}
         |                    ^~~~~~~~~~~~~
   kernel/sched/fair.c:6774:19: warning: unused function 'throttled_lb_pair' [-Wunused-function]
    6774 | static inline int throttled_lb_pair(struct task_group *tg,
         |                   ^~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:6785:37: warning: unused function 'tg_cfs_bandwidth' [-Wunused-function]
    6785 | static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
         |                                     ^~~~~~~~~~~~~~~~
   kernel/sched/fair.c:6789:20: warning: unused function 'destroy_cfs_bandwidth' [-Wunused-function]
    6789 | static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
         |                    ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:6790:20: warning: unused function 'update_runtime_enabled' [-Wunused-function]
    6790 | static inline void update_runtime_enabled(struct rq *rq) {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:6791:20: warning: unused function 'unthrottle_offline_cfs_rqs' [-Wunused-function]
    6791 | static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   18 warnings generated.
--
   In file included from kernel/time/hrtimer.c:30:
   In file included from include/linux/syscalls.h:93:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:62:
   In file included from include/linux/security.h:35:
>> include/linux/bpf.h:1392:5: warning: no previous prototype for function 'bpf_extension_link_prog' [-Wmissing-prototypes]
    1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
         |     ^
   include/linux/bpf.h:1392:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
         | ^
         | static 
>> include/linux/bpf.h:1398:5: warning: no previous prototype for function 'bpf_extension_unlink_prog' [-Wmissing-prototypes]
    1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
         |     ^
   include/linux/bpf.h:1398:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
         | ^
         | static 
   kernel/time/hrtimer.c:121:21: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     121 |         [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:119:27: note: previous initialization is here
     119 |         [0 ... MAX_CLOCKS - 1]  = HRTIMER_MAX_CLOCK_BASES,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:22: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     122 |         [CLOCK_MONOTONIC]       = HRTIMER_BASE_MONOTONIC,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:119:27: note: previous initialization is here
     119 |         [0 ... MAX_CLOCKS - 1]  = HRTIMER_MAX_CLOCK_BASES,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:21: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     123 |         [CLOCK_BOOTTIME]        = HRTIMER_BASE_BOOTTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:119:27: note: previous initialization is here
     119 |         [0 ... MAX_CLOCKS - 1]  = HRTIMER_MAX_CLOCK_BASES,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:124:17: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     124 |         [CLOCK_TAI]             = HRTIMER_BASE_TAI,
         |                                   ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:119:27: note: previous initialization is here
     119 |         [0 ... MAX_CLOCKS - 1]  = HRTIMER_MAX_CLOCK_BASES,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:278:20: warning: unused function 'is_migration_base' [-Wunused-function]
     278 | static inline bool is_migration_base(struct hrtimer_clock_base *base)
         |                    ^~~~~~~~~~~~~~~~~
   7 warnings generated.
--
   In file included from kernel/events/core.c:34:
   In file included from include/linux/syscalls.h:93:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:62:
   In file included from include/linux/security.h:35:
>> include/linux/bpf.h:1392:5: warning: no previous prototype for function 'bpf_extension_link_prog' [-Wmissing-prototypes]
    1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
         |     ^
   include/linux/bpf.h:1392:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
         | ^
         | static 
>> include/linux/bpf.h:1398:5: warning: no previous prototype for function 'bpf_extension_unlink_prog' [-Wmissing-prototypes]
    1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
         |     ^
   include/linux/bpf.h:1398:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
         | ^
         | static 
   kernel/events/core.c:9789:19: warning: unused function 'perf_event_set_bpf_handler' [-Wunused-function]
    9789 | static inline int perf_event_set_bpf_handler(struct perf_event *event,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/events/core.c:9796:20: warning: unused function 'perf_event_free_bpf_handler' [-Wunused-function]
    9796 | static inline void perf_event_free_bpf_handler(struct perf_event *event)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   4 warnings generated.


vim +/bpf_extension_link_prog +1392 include/linux/bpf.h

  1348	
  1349	#define DEFINE_BPF_DISPATCHER(name)					\
  1350		__BPF_DISPATCHER_SC(name);					\
  1351		noinline __bpfcall unsigned int bpf_dispatcher_##name##_func(	\
  1352			const void *ctx,					\
  1353			const struct bpf_insn *insnsi,				\
  1354			bpf_func_t bpf_func)					\
  1355		{								\
  1356			return __BPF_DISPATCHER_CALL(name);			\
  1357		}								\
  1358		EXPORT_SYMBOL(bpf_dispatcher_##name##_func);			\
  1359		struct bpf_dispatcher bpf_dispatcher_##name =			\
  1360			BPF_DISPATCHER_INIT(bpf_dispatcher_##name);
  1361	
  1362	#define DECLARE_BPF_DISPATCHER(name)					\
  1363		unsigned int bpf_dispatcher_##name##_func(			\
  1364			const void *ctx,					\
  1365			const struct bpf_insn *insnsi,				\
  1366			bpf_func_t bpf_func);					\
  1367		extern struct bpf_dispatcher bpf_dispatcher_##name;
  1368	
  1369	#define BPF_DISPATCHER_FUNC(name) bpf_dispatcher_##name##_func
  1370	#define BPF_DISPATCHER_PTR(name) (&bpf_dispatcher_##name)
  1371	void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
  1372					struct bpf_prog *to);
  1373	/* Called only from JIT-enabled code, so there's no need for stubs. */
  1374	void bpf_image_ksym_add(void *data, unsigned int size, struct bpf_ksym *ksym);
  1375	void bpf_image_ksym_del(struct bpf_ksym *ksym);
  1376	void bpf_ksym_add(struct bpf_ksym *ksym);
  1377	void bpf_ksym_del(struct bpf_ksym *ksym);
  1378	int bpf_jit_charge_modmem(u32 size);
  1379	void bpf_jit_uncharge_modmem(u32 size);
  1380	bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
  1381	#else
  1382	static inline int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
  1383						   struct bpf_trampoline *tr)
  1384	{
  1385		return -ENOTSUPP;
  1386	}
  1387	static inline int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
  1388						     struct bpf_trampoline *tr)
  1389	{
  1390		return -ENOTSUPP;
  1391	}
> 1392	int bpf_extension_link_prog(struct bpf_tramp_link *link,
  1393				    struct bpf_trampoline *tr,
  1394				    struct bpf_prog *tgt_prog)
  1395	{
  1396		return -ENOTSUPP;
  1397	}
> 1398	int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
  1399				      struct bpf_trampoline *tr,
  1400				      struct bpf_prog *tgt_prog)
  1401	{
  1402		return -ENOTSUPP;
  1403	}
  1404	static inline struct bpf_trampoline *bpf_trampoline_get(u64 key,
  1405								struct bpf_attach_target_info *tgt_info)
  1406	{
  1407		return NULL;
  1408	}
  1409	static inline void bpf_trampoline_put(struct bpf_trampoline *tr) {}
  1410	#define DEFINE_BPF_DISPATCHER(name)
  1411	#define DECLARE_BPF_DISPATCHER(name)
  1412	#define BPF_DISPATCHER_FUNC(name) bpf_dispatcher_nop_func
  1413	#define BPF_DISPATCHER_PTR(name) NULL
  1414	static inline void bpf_dispatcher_change_prog(struct bpf_dispatcher *d,
  1415						      struct bpf_prog *from,
  1416						      struct bpf_prog *to) {}
  1417	static inline bool is_bpf_image_address(unsigned long address)
  1418	{
  1419		return false;
  1420	}
  1421	static inline bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
  1422	{
  1423		return false;
  1424	}
  1425	#endif
  1426	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

