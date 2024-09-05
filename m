Return-Path: <bpf+bounces-38965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8359796D14A
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 10:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC789B23C00
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DB91946A8;
	Thu,  5 Sep 2024 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFmwyCbe"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38257192590;
	Thu,  5 Sep 2024 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523587; cv=none; b=FK+rXAUse9KA6WsYQ4GzMLl+xLoZ49127iM6SfrflGviYY4JWZ5fETt4E1DJl+wP48GMnAuPEVyw5u/dQmerO9YftnQEcH7w+LOid9ES0IigPxjA0wchAWfRh9rXgF7iTqHFice1Fi+Dd60gAUYNW1K3530O1Km+wu+XOkM6uMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523587; c=relaxed/simple;
	bh=WKO2UxcqMLRTRaAeeOcyehq8cryN89yN45A4vVIyDGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOEtGTHyvuIr9OvQfs8q/4QaHf/Pb/5joVke+hpE19EVt74tDevHQ6rmrHHKRldVT3CS6/GNLZXGIHy22STlcx7syq6vvobmI/j3GrT00TDceAjKPZqa2ayKLiW/6t5SrwW7lUoujrH6b0FpqGlaBTnO3C/O1/8yG87Ta/60o1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFmwyCbe; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725523586; x=1757059586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WKO2UxcqMLRTRaAeeOcyehq8cryN89yN45A4vVIyDGo=;
  b=VFmwyCbevgxhEihgYTv1Qzy2Ze8kpE5NeZn+3lBihy4orMQ+bkntsYkl
   4so/2X0Z9Wy+LqMU3PvNBh2epvhRlyJJQTeteKgQ3n3LAjFLfCLfODaUC
   +3Wv9dKTIJHDKjTd3j44cFH54NXRW3BmbEg5+umRF//E15WpmgBpIqMFE
   +ZYG+PoNP1MfKrpphai2e0U4pgABxdDMS3WzbqjDlQ7Q/wfqfKOfR7qDM
   JjUEGduVdJihJomFVjOCLyXKKROESrhaWFHwkPKJUzrmI4XmJY15QPEmh
   zcsf42ZEa6/Ob8DrIgrrEe7y0Bev7Fr6ijjd7Amy7SmaBN3eFw/2CIhWv
   Q==;
X-CSE-ConnectionGUID: CuhTN51TQvSC3y3+oZYZ9g==
X-CSE-MsgGUID: dqnHl1ReTAC1gBUs2yy3aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34794252"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="34794252"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:06:08 -0700
X-CSE-ConnectionGUID: zjeypNDgQoqznjqWnM5HkA==
X-CSE-MsgGUID: OZnSaGoFTMKmGzXZwFuFgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="65527709"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 05 Sep 2024 01:06:06 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sm7VD-00095l-1J;
	Thu, 05 Sep 2024 08:06:03 +0000
Date: Thu, 5 Sep 2024 16:05:18 +0800
From: kernel test robot <lkp@intel.com>
To: Sven Schnelle <svens@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 6/7] tracing: add support for function argument to graph
 tracer
Message-ID: <202409051539.ZmGpuZIP-lkp@intel.com>
References: <20240904065908.1009086-7-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904065908.1009086-7-svens@linux.ibm.com>

Hi Sven,

kernel test robot noticed the following build errors:

[auto build test ERROR on s390/features]
[also build test ERROR on tip/x86/core linus/master v6.11-rc6]
[cannot apply to rostedt-trace/for-next rostedt-trace/for-next-urgent next-20240904]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sven-Schnelle/tracing-add-ftrace_regs-to-function_graph_enter/20240904-150232
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
patch link:    https://lore.kernel.org/r/20240904065908.1009086-7-svens%40linux.ibm.com
patch subject: [PATCH 6/7] tracing: add support for function argument to graph tracer
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240905/202409051539.ZmGpuZIP-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240905/202409051539.ZmGpuZIP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409051539.ZmGpuZIP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/perf_event.h:52,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:93,
                    from kernel/time/time.c:33:
>> include/linux/ftrace.h:1013:28: error: field 'regs' has incomplete type
    1013 |         struct ftrace_regs regs;
         |                            ^~~~
--
   In file included from include/linux/perf_event.h:52,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:93,
                    from kernel/time/hrtimer.c:30:
>> include/linux/ftrace.h:1013:28: error: field 'regs' has incomplete type
    1013 |         struct ftrace_regs regs;
         |                            ^~~~
   kernel/time/hrtimer.c:121:35: warning: initialized field overwritten [-Woverride-init]
     121 |         [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:35: note: (near initialization for 'hrtimer_clock_to_base_table[0]')
   kernel/time/hrtimer.c:122:35: warning: initialized field overwritten [-Woverride-init]
     122 |         [CLOCK_MONOTONIC]       = HRTIMER_BASE_MONOTONIC,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:35: note: (near initialization for 'hrtimer_clock_to_base_table[1]')
   kernel/time/hrtimer.c:123:35: warning: initialized field overwritten [-Woverride-init]
     123 |         [CLOCK_BOOTTIME]        = HRTIMER_BASE_BOOTTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:35: note: (near initialization for 'hrtimer_clock_to_base_table[7]')
   kernel/time/hrtimer.c:124:35: warning: initialized field overwritten [-Woverride-init]
     124 |         [CLOCK_TAI]             = HRTIMER_BASE_TAI,
         |                                   ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:124:35: note: (near initialization for 'hrtimer_clock_to_base_table[11]')


vim +/regs +1013 include/linux/ftrace.h

  1006	
  1007	/*
  1008	 * Structure that defines an entry function trace.
  1009	 * It's already packed but the attribute "packed" is needed
  1010	 * to remove extra padding at the end.
  1011	 */
  1012	struct ftrace_graph_ent {
> 1013		struct ftrace_regs regs;
  1014		unsigned long func; /* Current function */
  1015		int depth;
  1016	} __packed;
  1017	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

