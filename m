Return-Path: <bpf+bounces-29463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E78C08C2290
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 12:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240A61C216F3
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD1716DEDE;
	Fri, 10 May 2024 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bO+AvOdB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A135C16D9B4;
	Fri, 10 May 2024 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338508; cv=none; b=SyJfYgzQvjOzFk0lp9nwyzFrGUNBmfhfc5vJvu0ht0R8/st/JW2O3CG5kJ7fPkjKQkuPy2fOPoj0ZGGFHxwStri200M9/ZC3nxHKFhB0AOeBZyhMElJnhmbwBTf+MUv1+axbw4pCBaguGQiUgQlN1gNf9vlLgVZTey8FWbPRJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338508; c=relaxed/simple;
	bh=U9ppFWtQd6HThR/eg1djmH03B4xACasuWmxLlEJo+Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4C4SF+OxcNLe0Y2ihdzE2vwvyHw3cFZpESvsm08Ub9ougjO/xbm15q770XX1YfT97mjbfh6Jnrig+nprMoFgQnxsdK/FgsIVPxr4fDPqAWi/m1qXSucIf3pQDWWFnOryblm0I5v2aeYcrpwM8PGMYJgd0LmlCVmjX+eEKIT/uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bO+AvOdB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715338507; x=1746874507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U9ppFWtQd6HThR/eg1djmH03B4xACasuWmxLlEJo+Ls=;
  b=bO+AvOdB9c4IKtTP8g95SnND4soMoJoL1ir0PWq/4eAHpFApuKsIK4hN
   rNaEcMpCz6Hilkw6FT0k7WQ2UJCbaCBUYV7+J4JOiULX/+Y2d8E9YMf5P
   QJcuRarCpE8mA3c+RXqSiUvcQ4v/ArSMQ2qLrM9UBPHCw1uRiIGwocsz6
   WVJo8/Q7KWm7MPNo5TvjNYc5QIId1LK3Gc8WyWqBCJrD+1B4dBPYjlDl+
   6S8+OUPBmE7ptUeEp7vu4tzn+NYdKtKsAwJlCJj/mD9S9oXkvZd4h7jza
   en16GMfbAtQfbvJxiCWQO3P0m08yn4I0dMjRe1xEB/YvXiCbQusAd7kEw
   w==;
X-CSE-ConnectionGUID: 7VsJ2GICQo+1ZGSSyYiz5w==
X-CSE-MsgGUID: KV5kRFugQFK+eNkOFfhJBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11474096"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11474096"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 03:55:06 -0700
X-CSE-ConnectionGUID: swzHCHuRSH6CTTjTY/T78Q==
X-CSE-MsgGUID: CYQ0QnGITaWeKW8WN1MTGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29525536"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 May 2024 03:55:02 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5Nu0-00061H-0l;
	Fri, 10 May 2024 10:55:00 +0000
Date: Fri, 10 May 2024 18:54:58 +0800
From: kernel test robot <lkp@intel.com>
To: Yabin Cui <yabinc@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Yabin Cui <yabinc@google.com>
Subject: Re: [PATCH v3 3/3] perf: core: Check sample_type in
 perf_sample_save_brstack
Message-ID: <202405101855.doEob5FK-lkp@intel.com>
References: <20240510002424.1277314-4-yabinc@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510002424.1277314-4-yabinc@google.com>

Hi Yabin,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core linus/master v6.9-rc7 next-20240510]
[cannot apply to acme/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yabin-Cui/perf-core-Save-raw-sample-data-conditionally-based-on-sample-type/20240510-083817
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20240510002424.1277314-4-yabinc%40google.com
patch subject: [PATCH v3 3/3] perf: core: Check sample_type in perf_sample_save_brstack
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240510/202405101855.doEob5FK-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240510/202405101855.doEob5FK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405101855.doEob5FK-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:93,
                    from kernel/time/time.c:33:
   include/linux/perf_event.h: In function 'perf_sample_save_brstack':
>> include/linux/perf_event.h:1279:14: error: implicit declaration of function 'has_branch_stack' [-Werror=implicit-function-declaration]
    1279 |         if (!has_branch_stack(event))
         |              ^~~~~~~~~~~~~~~~
   include/linux/perf_event.h: At top level:
>> include/linux/perf_event.h:1671:20: error: conflicting types for 'has_branch_stack'; have 'bool(struct perf_event *)' {aka '_Bool(struct perf_event *)'}
    1671 | static inline bool has_branch_stack(struct perf_event *event)
         |                    ^~~~~~~~~~~~~~~~
   include/linux/perf_event.h:1279:14: note: previous implicit declaration of 'has_branch_stack' with type 'int()'
    1279 |         if (!has_branch_stack(event))
         |              ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:93,
                    from kernel/time/hrtimer.c:30:
   include/linux/perf_event.h: In function 'perf_sample_save_brstack':
>> include/linux/perf_event.h:1279:14: error: implicit declaration of function 'has_branch_stack' [-Werror=implicit-function-declaration]
    1279 |         if (!has_branch_stack(event))
         |              ^~~~~~~~~~~~~~~~
   include/linux/perf_event.h: At top level:
>> include/linux/perf_event.h:1671:20: error: conflicting types for 'has_branch_stack'; have 'bool(struct perf_event *)' {aka '_Bool(struct perf_event *)'}
    1671 | static inline bool has_branch_stack(struct perf_event *event)
         |                    ^~~~~~~~~~~~~~~~
   include/linux/perf_event.h:1279:14: note: previous implicit declaration of 'has_branch_stack' with type 'int()'
    1279 |         if (!has_branch_stack(event))
         |              ^~~~~~~~~~~~~~~~
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
   cc1: some warnings being treated as errors


vim +/has_branch_stack +1279 include/linux/perf_event.h

  1271	
  1272	static inline void perf_sample_save_brstack(struct perf_sample_data *data,
  1273						    struct perf_event *event,
  1274						    struct perf_branch_stack *brs,
  1275						    u64 *brs_cntr)
  1276	{
  1277		int size = sizeof(u64); /* nr */
  1278	
> 1279		if (!has_branch_stack(event))
  1280			return;
  1281	
  1282		if (branch_sample_hw_index(event))
  1283			size += sizeof(u64);
  1284		size += brs->nr * sizeof(struct perf_branch_entry);
  1285	
  1286		/*
  1287		 * The extension space for counters is appended after the
  1288		 * struct perf_branch_stack. It is used to store the occurrences
  1289		 * of events of each branch.
  1290		 */
  1291		if (brs_cntr)
  1292			size += brs->nr * sizeof(u64);
  1293	
  1294		data->br_stack = brs;
  1295		data->br_stack_cntr = brs_cntr;
  1296		data->dyn_size += size;
  1297		data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
  1298	}
  1299	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

