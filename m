Return-Path: <bpf+bounces-68058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEBEB52195
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 22:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21AC0565854
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 20:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6F32EDD7C;
	Wed, 10 Sep 2025 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQNcVLkh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1682BB1D;
	Wed, 10 Sep 2025 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535010; cv=none; b=bx3bXYa6IEpB023wMKUTNFCRQVqROTnWjuAAI4XePZ5H+320S162eNk/LOBH1TzYezUqPlNUKC2isskh8VEEFQdaTn5xJ/qLkQwjMXc3vFqo49ulZStxWpEFt3Wcxx9b+Id4rA6EUmfEDZ4Bfrw0TgA/YSbfzicZghXgNFF53z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535010; c=relaxed/simple;
	bh=+yiJU8+sYTuK9LC7OMfaaOJDvJ/NzyjCJTRJpw2kHbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1Eh//H+qvZ+KaSZNxO9E4q8E12Hz8+H0HFIlagbMESfhx6V8DSQnuJOhdMsDYv0RPIMP+7d9yZbOXgdRXzTiQi1ZSkv8IL2n6ByAoBJZB/iBY+OeiorpwzPpnoy5XaW+KzdwIcz/AUrA6Ot43rSwrio0mTqnDAa6dqBd6gisXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQNcVLkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997F6C4CEEB;
	Wed, 10 Sep 2025 20:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757535010;
	bh=+yiJU8+sYTuK9LC7OMfaaOJDvJ/NzyjCJTRJpw2kHbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQNcVLkhrYoCn02+k0aVBrGRs1pRsUM7abtCQ8H7jCFHNAlW1J4ENcz6XZXad9TG+
	 yT5+/AkVjqbCuQ5MpMjbtEzZ2XOd05j80C27h5JqUlYXy9Fftz8YYWjmTDSuz5I7f2
	 5VRa+yqQtTOiJKgVtTlmACakMw6w54M0yrvSisHzpJ8CPySyTlvg7B2eok1M7+yp1W
	 4e4JfKMyd5/ih2Pwebu9U+pqn63KaRe6JPJaTDGJj1bIu62oViFU/2+lJx5dZkv7EX
	 VbITrMTuDCROm2h+t4a4qLiBtIKkplN3qo+EVsz6r3RjcClKIZbWajW4rjN8c9NNeJ
	 5ImqojhyFUUnw==
Date: Wed, 10 Sep 2025 13:10:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Atish Patra <atishp@rivosinc.com>,
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
	Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCH v3 00/15] Legacy hardware/cache events as json
Message-ID: <aMHbIGRFeQlq9ABx@google.com>
References: <20250828205930.4007284-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828205930.4007284-1-irogers@google.com>

Hi Ian,

On Thu, Aug 28, 2025 at 01:59:15PM -0700, Ian Rogers wrote:
> Mirroring similar work for software events in commit 6e9fa4131abb
> ("perf parse-events: Remove non-json software events"). These changes
> migrate the legacy hardware and cache events to json.  With no hard
> coded legacy hardware or cache events the wild card, case
> insensitivity, etc. is consistent for events. This does, however, mean
> events like cycles will wild card against all PMUs. A change doing the
> same was originally posted and merged from:
> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
> parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
> his dislike for the cycles behavior on ARM with perf record. Earlier
> patches in this series make perf record event opening failures
> non-fatal and hide the cycles event's failure to open on ARM in perf
> record, so it is expected the behavior will now be transparent in perf
> record on ARM. perf stat with a cycles event will wildcard open the
> event on all PMUs.
> 
> The change to support legacy events with PMUs was done to clean up
> Intel's hybrid PMU implementation. Having sysfs/json events with
> increased priority to legacy was requested by Mark Rutland
>  <mark.rutland@arm.com> to fix Apple-M PMU issues wrt broken legacy
> events on that PMU. It is believed the PMU driver is now fixed, but
> this has only been confirmed on ARM Juno boards. It was requested that
> RISC-V be able to add events to the perf tool json so the PMU driver
> didn't need to map legacy events to config encodings:
> https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/
> This patch series achieves this.
> 
> A previous series of patches decreasing legacy hardware event
> priorities was posted in:
> https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.com/
> Namhyung Kim <namhyung@kernel.org> mentioned that hardware and
> software events can be implemented similarly:
> https://lore.kernel.org/lkml/aIJmJns2lopxf3EK@google.com/
> and this patch series achieves this.

Thanks for working on this.  Yeah, I think it's be easier to handle all
events consistently with JSON.  I expect the sysfs encoding will be used
in a higher priority if it comes with <PMU>/<EVENT>/ format.

> 
> Note, patch 1 (perf parse-events: Fix legacy cache events if event is
> duplicated in a PMU) fixes a function deleted by patch 15 (perf
> parse-events: Remove hard coded legacy hardware and cache
> parsing). Adding the json exposed an issue when legacy cache (not
> legacy hardware) and sysfs/json events exist. The fix is necessary to
> keep tests passing through the series. It is also posted for backports
> to stable trees.

Sounds ok.

> 
> The perf list behavior includes a lot more information and events. The
> before behavior on a hybrid alderlake is:
> ```
> $ perf list hw
> 
> List of pre-defined events (to be used in -e or -M):
> 
>   branch-instructions OR branches                    [Hardware event]
>   branch-misses                                      [Hardware event]
>   bus-cycles                                         [Hardware event]
>   cache-misses                                       [Hardware event]
>   cache-references                                   [Hardware event]
>   cpu-cycles OR cycles                               [Hardware event]
>   instructions                                       [Hardware event]
>   ref-cycles                                         [Hardware event]
> $ perf list hwcache
> 
> List of pre-defined events (to be used in -e or -M):
> 
> 
> cache:
>   L1-dcache-loads OR cpu_atom/L1-dcache-loads/
>   L1-dcache-stores OR cpu_atom/L1-dcache-stores/
>   L1-icache-loads OR cpu_atom/L1-icache-loads/
>   L1-icache-load-misses OR cpu_atom/L1-icache-load-misses/
>   LLC-loads OR cpu_atom/LLC-loads/
>   LLC-load-misses OR cpu_atom/LLC-load-misses/
>   LLC-stores OR cpu_atom/LLC-stores/
>   LLC-store-misses OR cpu_atom/LLC-store-misses/
>   dTLB-loads OR cpu_atom/dTLB-loads/
>   dTLB-load-misses OR cpu_atom/dTLB-load-misses/
>   dTLB-stores OR cpu_atom/dTLB-stores/
>   dTLB-store-misses OR cpu_atom/dTLB-store-misses/
>   iTLB-load-misses OR cpu_atom/iTLB-load-misses/
>   branch-loads OR cpu_atom/branch-loads/
>   branch-load-misses OR cpu_atom/branch-load-misses/
>   L1-dcache-loads OR cpu_core/L1-dcache-loads/
>   L1-dcache-load-misses OR cpu_core/L1-dcache-load-misses/
>   L1-dcache-stores OR cpu_core/L1-dcache-stores/
>   L1-icache-load-misses OR cpu_core/L1-icache-load-misses/
>   LLC-loads OR cpu_core/LLC-loads/
>   LLC-load-misses OR cpu_core/LLC-load-misses/
>   LLC-stores OR cpu_core/LLC-stores/
>   LLC-store-misses OR cpu_core/LLC-store-misses/
>   dTLB-loads OR cpu_core/dTLB-loads/
>   dTLB-load-misses OR cpu_core/dTLB-load-misses/
>   dTLB-stores OR cpu_core/dTLB-stores/
>   dTLB-store-misses OR cpu_core/dTLB-store-misses/
>   iTLB-load-misses OR cpu_core/iTLB-load-misses/
>   branch-loads OR cpu_core/branch-loads/
>   branch-load-misses OR cpu_core/branch-load-misses/
>   node-loads OR cpu_core/node-loads/
>   node-load-misses OR cpu_core/node-load-misses/
> ```
> and after it is:
> ```
> $ perf list hw
> 
> legacy hardware:
>   branch-instructions
>        [Retired branch instructions [This event is an alias of branches].
>         Unit: cpu_atom]
>   branch-misses
>        [Mispredicted branch instructions. Unit: cpu_atom]
>   branches
>        [Retired branch instructions [This event is an alias of
>         branch-instructions]. Unit: cpu_atom]

A nit.  Can we have one actual event and an alias of it?

I think 'branch-instructions' will be the actual event and 'branches'
will be the alias.  Then the description will be like

  branch-instructions
      [Retired branch instructions.  Unit: cpu_atom]
  ...

  branches
      [This event is an alias of branch-instructions.]

The same goes to 'cycles' and 'cpu-cycles'.

Thanks,
Namhyung


>   bus-cycles
>        [Bus cycles,which can be different from total cycles. Unit: cpu_atom]
>   cache-misses
>        [Cache misses. Usually this indicates Last Level Cache misses; this is
>         intended to be used in conjunction with the
>         PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss rates.
>         Unit: cpu_atom]
>   cache-references
>        [Cache accesses. Usually this indicates Last Level Cache accesses but
>         this may vary depending on your CPU. This may include prefetches and
>         coherency messages; again this depends on the design of your CPU.
>         Unit: cpu_atom]
>   cpu-cycles
>        [Total cycles. Be wary of what happens during CPU frequency scaling
>         [This event is an alias of cycles]. Unit: cpu_atom]
>   cycles
>        [Total cycles. Be wary of what happens during CPU frequency scaling
>         [This event is an alias of cpu-cycles]. Unit: cpu_atom]
>   instructions
>        [Retired instructions. Be careful,these can be affected by various
>         issues,most notably hardware interrupt counts. Unit: cpu_atom]
>   ref-cycles
>        [Total cycles; not affected by CPU frequency scaling. Unit: cpu_atom]
>   branch-instructions
>        [Retired branch instructions [This event is an alias of branches].
>         Unit: cpu_core]
>   branch-misses
>        [Mispredicted branch instructions. Unit: cpu_core]
>   branches
>        [Retired branch instructions [This event is an alias of
>         branch-instructions]. Unit: cpu_core]
>   bus-cycles
>        [Bus cycles,which can be different from total cycles. Unit: cpu_core]
>   cache-misses
>        [Cache misses. Usually this indicates Last Level Cache misses; this is
>         intended to be used in conjunction with the
>         PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss rates.
>         Unit: cpu_core]
>   cache-references
>        [Cache accesses. Usually this indicates Last Level Cache accesses but
>         this may vary depending on your CPU. This may include prefetches and
>         coherency messages; again this depends on the design of your CPU.
>         Unit: cpu_core]
>   cpu-cycles
>        [Total cycles. Be wary of what happens during CPU frequency scaling
>         [This event is an alias of cycles]. Unit: cpu_core]
>   cycles
>        [Total cycles. Be wary of what happens during CPU frequency scaling
>         [This event is an alias of cpu-cycles]. Unit: cpu_core]
>   instructions
>        [Retired instructions. Be careful,these can be affected by various
>         issues,most notably hardware interrupt counts. Unit: cpu_core]
>   ref-cycles
>        [Total cycles; not affected by CPU frequency scaling. Unit: cpu_core]
> $ perf list hwcache
> 
> legacy cache:
>   branch-load-misses
>        [Branch prediction unit read misses. Unit: cpu_atom]
>   branch-loads
>        [Branch prediction unit read accesses. Unit: cpu_atom]
>   dtlb-load-misses
>        [Data TLB read misses. Unit: cpu_atom]
>   dtlb-loads
>        [Data TLB read accesses. Unit: cpu_atom]
>   dtlb-store-misses
>        [Data TLB write misses. Unit: cpu_atom]
>   dtlb-stores
>        [Data TLB write accesses. Unit: cpu_atom]
>   itlb-load-misses
>        [Instruction TLB read misses. Unit: cpu_atom]
>   l1-dcache-loads
>        [Level 1 data cache read accesses. Unit: cpu_atom]
>   l1-dcache-stores
>        [Level 1 data cache write accesses. Unit: cpu_atom]
>   l1-icache-load-misses
>        [Level 1 instruction cache read misses. Unit: cpu_atom]
>   l1-icache-loads
>        [Level 1 instruction cache read accesses. Unit: cpu_atom]
>   llc-load-misses
>        [Last level cache read misses. Unit: cpu_atom]
>   llc-loads
>        [Last level cache read accesses. Unit: cpu_atom]
>   llc-store-misses
>        [Last level cache write misses. Unit: cpu_atom]
>   llc-stores
>        [Last level cache write accesses. Unit: cpu_atom]
>   branch-load-misses
>        [Branch prediction unit read misses. Unit: cpu_core]
>   branch-loads
>        [Branch prediction unit read accesses. Unit: cpu_core]
>   dtlb-load-misses
>        [Data TLB read misses. Unit: cpu_core]
>   dtlb-loads
>        [Data TLB read accesses. Unit: cpu_core]
>   dtlb-store-misses
>        [Data TLB write misses. Unit: cpu_core]
>   dtlb-stores
>        [Data TLB write accesses. Unit: cpu_core]
>   itlb-load-misses
>        [Instruction TLB read misses. Unit: cpu_core]
>   l1-dcache-load-misses
>        [Level 1 data cache read misses. Unit: cpu_core]
>   l1-dcache-loads
>        [Level 1 data cache read accesses. Unit: cpu_core]
>   l1-dcache-stores
>        [Level 1 data cache write accesses. Unit: cpu_core]
>   l1-icache-load-misses
>        [Level 1 instruction cache read misses. Unit: cpu_core]
>   llc-load-misses
>        [Last level cache read misses. Unit: cpu_core]
>   llc-loads
>        [Last level cache read accesses. Unit: cpu_core]
>   llc-store-misses
>        [Last level cache write misses. Unit: cpu_core]
>   llc-stores
>        [Last level cache write accesses. Unit: cpu_core]
>   node-load-misses
>        [Local memory read misses. Unit: cpu_core]
>   node-loads
>        [Local memory read accesses. Unit: cpu_core]
> ```
> 
> v3: Deprecate the legacy cache events that aren't shown in the
>     previous perf list to avoid the perf list output being too verbose.
> 
> v2: Additional details to the cover letter. Credit to Vince Weaver
>     added to the commit message for the event details. Additional
>     patches to clean up perf_pmu new_alias by removing an unused term
>     scanner argument and avoid stdio usage.
>     https://lore.kernel.org/lkml/20250828163225.3839073-1-irogers@google.com/
> 
> v1: https://lore.kernel.org/lkml/20250828064231.1762997-1-irogers@google.com/
> 
> Ian Rogers (15):
>   perf parse-events: Fix legacy cache events if event is duplicated in a
>     PMU
>   perf perf_api_probe: Avoid scanning all PMUs, try software PMU first
>   perf record: Skip don't fail for events that don't open
>   perf jevents: Support copying the source json files to OUTPUT
>   perf pmu: Don't eagerly parse event terms
>   perf parse-events: Remove unused FILE input argument to scanner
>   perf pmu: Use fd rather than FILE from new_alias
>   perf pmu: Factor term parsing into a perf_event_attr into a helper
>   perf parse-events: Add terms for legacy hardware and cache config
>     values
>   perf jevents: Add legacy json terms and default_core event table
>     helper
>   perf pmu: Add and use legacy_terms in alias information
>   perf jevents: Add legacy-hardware and legacy-cache json
>   perf print-events: Remove print_hwcache_events
>   perf print-events: Remove print_symbol_events
>   perf parse-events: Remove hard coded legacy hardware and cache parsing
> 
>  tools/perf/Makefile.perf                      |   21 +-
>  tools/perf/arch/x86/util/intel-pt.c           |    2 +-
>  tools/perf/builtin-list.c                     |   34 +-
>  tools/perf/builtin-record.c                   |   89 +-
>  tools/perf/pmu-events/Build                   |   24 +-
>  .../arch/common/common/legacy-hardware.json   |   72 +
>  tools/perf/pmu-events/empty-pmu-events.c      | 2763 ++++++++++++++++-
>  tools/perf/pmu-events/jevents.py              |   24 +
>  tools/perf/pmu-events/make_legacy_cache.py    |  129 +
>  tools/perf/pmu-events/pmu-events.h            |    1 +
>  tools/perf/tests/parse-events.c               |    2 +-
>  tools/perf/tests/pmu-events.c                 |   24 +-
>  tools/perf/tests/pmu.c                        |    3 +-
>  tools/perf/util/parse-events.c                |  283 +-
>  tools/perf/util/parse-events.h                |   16 +-
>  tools/perf/util/parse-events.l                |   54 +-
>  tools/perf/util/parse-events.y                |  114 +-
>  tools/perf/util/perf_api_probe.c              |   27 +-
>  tools/perf/util/pmu.c                         |  302 +-
>  tools/perf/util/print-events.c                |  112 -
>  tools/perf/util/print-events.h                |    4 -
>  21 files changed, 3330 insertions(+), 770 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/common/common/legacy-hardware.json
>  create mode 100755 tools/perf/pmu-events/make_legacy_cache.py
> 
> -- 
> 2.51.0.318.gd7df087d1a-goog
> 

