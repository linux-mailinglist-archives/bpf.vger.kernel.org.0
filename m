Return-Path: <bpf+bounces-66888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5D9B3AC33
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 23:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6AD97AE236
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E907C2D1932;
	Thu, 28 Aug 2025 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uzj/uSOS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F02BE051
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414798; cv=none; b=PNOlT3ru8zeOm+O7OCphUq0FgLE4dja/4KBsN4ob1nYZQuFIDW94qXjjq0YZ2AQ8dvOP88yZvb8dR3ItvGRvZSlXV5SMbx41oHW3wkFPql+bUvze1/lzJXvL6eUtpKu4SMypauGaINF0PfsBxbxFMaurMMC90zLow58UtbXU1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414798; c=relaxed/simple;
	bh=svOTJag/ZLjZEjzV1ufdwDhtfrG3XLSInHSNVL/2fGk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=oqmTT0wSynA5ndcS0MyGvqr1cV3ooW2xonLbaKM8gFzUmqMok+nANsrXjGfs93aaClekL08NqjNIwceruEAyJZuDhxq0V9QEWWZpLZ88zDtXls5tSLFpUUp4qd7WLZ+KNdntn5KeTy7FM6z8uAkRfAvSuHBL3LiA44QrQXlTzWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uzj/uSOS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-327706e0642so2351988a91.3
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756414793; x=1757019593; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P5FCMb3MK9tcA2rTPEiWfJ7E6xU+WM6otEOzcIt2ksc=;
        b=Uzj/uSOSZRke4PzRV+25gmILBZsIr2qnRUVclf//WR0jHcIdv9Iq+A4J/o9Nw5L7Em
         dNHLbAReIOyPCPtSC0fbGKQBoPhVYfigPJNIZco0je3jip6X7RRFvuyh5jJwCi2gMFv7
         gnJqgZmWTgcnNEKJ8aBmFQLkzNsW0kbxyK6vpgNVC4tPRTdeXmoImoL+j/oEUbPJq8wj
         b0zqYwsWHsjBz6l62ZL0sJPyK+wAzvSTwMTmGYhz03oqRVjue2aR8Ly8BKpmg+o8T7S6
         8U9Z/S7XtgEW0DTLlP8B75XBwcdwv/OoCArYPRpLRQKTBs+ysNumKO5nsRfVMKarSpna
         yzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414793; x=1757019593;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P5FCMb3MK9tcA2rTPEiWfJ7E6xU+WM6otEOzcIt2ksc=;
        b=MOtwi0k8Py5xpOT9nUNBsUmiwg4corMmB8cJuec4nkvRb60Unsy2WITdwXXr99stMm
         UKw5TokrVwsCu+5oCrb6nRuVz+1cKZlpq3CzLG3gYNHdiE12ePuIMcktCzWeWCZ3y80t
         bxy8lL85GqN/1dGc8ojEYUEx/KlNDUoUJhheRtZmnTmEsubIDncCp5L/qCCtmoIyXldo
         Wqtow1RzFx/Rn2j4F+7RDqNbyaSFFAjrX5eVXvGR+R1RLcaCjLqtRIYijq7r9wlLH/KH
         CMAdlGe3Yi/6g8AjaJ+Q+LCMEIA2Ovg4jBOCtgCsucn+7RmcWn5oIV93i0noUK2+SD5L
         P5NA==
X-Forwarded-Encrypted: i=1; AJvYcCUsB8kZ5TovBf5CZbEUkSAtcNnPotB1hu2EU2uwGdZJWq4lguoIBVuWr20EO9V9AWDEEeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOznfLsad/+I7Cim+VTZFr4DdcecZI/XTp347kAXxj1SQsTqSz
	Qzoky7zCyEc9TwcJXGjQeOGwwnL/UVQHOO6fVoAR+lV4QwDRwpYpDchCLBWSRO1ZV538XosPu9h
	owKj+yaeecQ==
X-Google-Smtp-Source: AGHT+IG2psQ+MPJ5ZulAz233ZLh6wFva0vi2PqJ+SlAV0FxqKuJ2pIUo1FtLJ+BZmziozSZA85RNYf0JijMB
X-Received: from pjvb15.prod.google.com ([2002:a17:90a:d88f:b0:31f:1ed:c76e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c6:b0:327:e2ab:d92b
 with SMTP id 98e67ed59e1d1-327e2abdc20mr371094a91.35.1756414793311; Thu, 28
 Aug 2025 13:59:53 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:59:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828205930.4007284-1-irogers@google.com>
Subject: [PATCH v3 00/15] Legacy hardware/cache events as json
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Mirroring similar work for software events in commit 6e9fa4131abb
("perf parse-events: Remove non-json software events"). These changes
migrate the legacy hardware and cache events to json.  With no hard
coded legacy hardware or cache events the wild card, case
insensitivity, etc. is consistent for events. This does, however, mean
events like cycles will wild card against all PMUs. A change doing the
same was originally posted and merged from:
https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
and reverted by Linus in commit 4f1b067359ac ("Revert "perf
parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
his dislike for the cycles behavior on ARM with perf record. Earlier
patches in this series make perf record event opening failures
non-fatal and hide the cycles event's failure to open on ARM in perf
record, so it is expected the behavior will now be transparent in perf
record on ARM. perf stat with a cycles event will wildcard open the
event on all PMUs.

The change to support legacy events with PMUs was done to clean up
Intel's hybrid PMU implementation. Having sysfs/json events with
increased priority to legacy was requested by Mark Rutland
 <mark.rutland@arm.com> to fix Apple-M PMU issues wrt broken legacy
events on that PMU. It is believed the PMU driver is now fixed, but
this has only been confirmed on ARM Juno boards. It was requested that
RISC-V be able to add events to the perf tool json so the PMU driver
didn't need to map legacy events to config encodings:
https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/
This patch series achieves this.

A previous series of patches decreasing legacy hardware event
priorities was posted in:
https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.com/
Namhyung Kim <namhyung@kernel.org> mentioned that hardware and
software events can be implemented similarly:
https://lore.kernel.org/lkml/aIJmJns2lopxf3EK@google.com/
and this patch series achieves this.

Note, patch 1 (perf parse-events: Fix legacy cache events if event is
duplicated in a PMU) fixes a function deleted by patch 15 (perf
parse-events: Remove hard coded legacy hardware and cache
parsing). Adding the json exposed an issue when legacy cache (not
legacy hardware) and sysfs/json events exist. The fix is necessary to
keep tests passing through the series. It is also posted for backports
to stable trees.

The perf list behavior includes a lot more information and events. The
before behavior on a hybrid alderlake is:
```
$ perf list hw

List of pre-defined events (to be used in -e or -M):

  branch-instructions OR branches                    [Hardware event]
  branch-misses                                      [Hardware event]
  bus-cycles                                         [Hardware event]
  cache-misses                                       [Hardware event]
  cache-references                                   [Hardware event]
  cpu-cycles OR cycles                               [Hardware event]
  instructions                                       [Hardware event]
  ref-cycles                                         [Hardware event]
$ perf list hwcache

List of pre-defined events (to be used in -e or -M):


cache:
  L1-dcache-loads OR cpu_atom/L1-dcache-loads/
  L1-dcache-stores OR cpu_atom/L1-dcache-stores/
  L1-icache-loads OR cpu_atom/L1-icache-loads/
  L1-icache-load-misses OR cpu_atom/L1-icache-load-misses/
  LLC-loads OR cpu_atom/LLC-loads/
  LLC-load-misses OR cpu_atom/LLC-load-misses/
  LLC-stores OR cpu_atom/LLC-stores/
  LLC-store-misses OR cpu_atom/LLC-store-misses/
  dTLB-loads OR cpu_atom/dTLB-loads/
  dTLB-load-misses OR cpu_atom/dTLB-load-misses/
  dTLB-stores OR cpu_atom/dTLB-stores/
  dTLB-store-misses OR cpu_atom/dTLB-store-misses/
  iTLB-load-misses OR cpu_atom/iTLB-load-misses/
  branch-loads OR cpu_atom/branch-loads/
  branch-load-misses OR cpu_atom/branch-load-misses/
  L1-dcache-loads OR cpu_core/L1-dcache-loads/
  L1-dcache-load-misses OR cpu_core/L1-dcache-load-misses/
  L1-dcache-stores OR cpu_core/L1-dcache-stores/
  L1-icache-load-misses OR cpu_core/L1-icache-load-misses/
  LLC-loads OR cpu_core/LLC-loads/
  LLC-load-misses OR cpu_core/LLC-load-misses/
  LLC-stores OR cpu_core/LLC-stores/
  LLC-store-misses OR cpu_core/LLC-store-misses/
  dTLB-loads OR cpu_core/dTLB-loads/
  dTLB-load-misses OR cpu_core/dTLB-load-misses/
  dTLB-stores OR cpu_core/dTLB-stores/
  dTLB-store-misses OR cpu_core/dTLB-store-misses/
  iTLB-load-misses OR cpu_core/iTLB-load-misses/
  branch-loads OR cpu_core/branch-loads/
  branch-load-misses OR cpu_core/branch-load-misses/
  node-loads OR cpu_core/node-loads/
  node-load-misses OR cpu_core/node-load-misses/
```
and after it is:
```
$ perf list hw

legacy hardware:
  branch-instructions
       [Retired branch instructions [This event is an alias of branches].
        Unit: cpu_atom]
  branch-misses
       [Mispredicted branch instructions. Unit: cpu_atom]
  branches
       [Retired branch instructions [This event is an alias of
        branch-instructions]. Unit: cpu_atom]
  bus-cycles
       [Bus cycles,which can be different from total cycles. Unit: cpu_atom]
  cache-misses
       [Cache misses. Usually this indicates Last Level Cache misses; this is
        intended to be used in conjunction with the
        PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss rates.
        Unit: cpu_atom]
  cache-references
       [Cache accesses. Usually this indicates Last Level Cache accesses but
        this may vary depending on your CPU. This may include prefetches and
        coherency messages; again this depends on the design of your CPU.
        Unit: cpu_atom]
  cpu-cycles
       [Total cycles. Be wary of what happens during CPU frequency scaling
        [This event is an alias of cycles]. Unit: cpu_atom]
  cycles
       [Total cycles. Be wary of what happens during CPU frequency scaling
        [This event is an alias of cpu-cycles]. Unit: cpu_atom]
  instructions
       [Retired instructions. Be careful,these can be affected by various
        issues,most notably hardware interrupt counts. Unit: cpu_atom]
  ref-cycles
       [Total cycles; not affected by CPU frequency scaling. Unit: cpu_atom]
  branch-instructions
       [Retired branch instructions [This event is an alias of branches].
        Unit: cpu_core]
  branch-misses
       [Mispredicted branch instructions. Unit: cpu_core]
  branches
       [Retired branch instructions [This event is an alias of
        branch-instructions]. Unit: cpu_core]
  bus-cycles
       [Bus cycles,which can be different from total cycles. Unit: cpu_core]
  cache-misses
       [Cache misses. Usually this indicates Last Level Cache misses; this is
        intended to be used in conjunction with the
        PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss rates.
        Unit: cpu_core]
  cache-references
       [Cache accesses. Usually this indicates Last Level Cache accesses but
        this may vary depending on your CPU. This may include prefetches and
        coherency messages; again this depends on the design of your CPU.
        Unit: cpu_core]
  cpu-cycles
       [Total cycles. Be wary of what happens during CPU frequency scaling
        [This event is an alias of cycles]. Unit: cpu_core]
  cycles
       [Total cycles. Be wary of what happens during CPU frequency scaling
        [This event is an alias of cpu-cycles]. Unit: cpu_core]
  instructions
       [Retired instructions. Be careful,these can be affected by various
        issues,most notably hardware interrupt counts. Unit: cpu_core]
  ref-cycles
       [Total cycles; not affected by CPU frequency scaling. Unit: cpu_core]
$ perf list hwcache

legacy cache:
  branch-load-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  branch-loads
       [Branch prediction unit read accesses. Unit: cpu_atom]
  dtlb-load-misses
       [Data TLB read misses. Unit: cpu_atom]
  dtlb-loads
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-store-misses
       [Data TLB write misses. Unit: cpu_atom]
  dtlb-stores
       [Data TLB write accesses. Unit: cpu_atom]
  itlb-load-misses
       [Instruction TLB read misses. Unit: cpu_atom]
  l1-dcache-loads
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-stores
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-icache-load-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-icache-loads
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  llc-load-misses
       [Last level cache read misses. Unit: cpu_atom]
  llc-loads
       [Last level cache read accesses. Unit: cpu_atom]
  llc-store-misses
       [Last level cache write misses. Unit: cpu_atom]
  llc-stores
       [Last level cache write accesses. Unit: cpu_atom]
  branch-load-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  branch-loads
       [Branch prediction unit read accesses. Unit: cpu_core]
  dtlb-load-misses
       [Data TLB read misses. Unit: cpu_core]
  dtlb-loads
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-store-misses
       [Data TLB write misses. Unit: cpu_core]
  dtlb-stores
       [Data TLB write accesses. Unit: cpu_core]
  itlb-load-misses
       [Instruction TLB read misses. Unit: cpu_core]
  l1-dcache-load-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-dcache-loads
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-stores
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-icache-load-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  llc-load-misses
       [Last level cache read misses. Unit: cpu_core]
  llc-loads
       [Last level cache read accesses. Unit: cpu_core]
  llc-store-misses
       [Last level cache write misses. Unit: cpu_core]
  llc-stores
       [Last level cache write accesses. Unit: cpu_core]
  node-load-misses
       [Local memory read misses. Unit: cpu_core]
  node-loads
       [Local memory read accesses. Unit: cpu_core]
```

v3: Deprecate the legacy cache events that aren't shown in the
    previous perf list to avoid the perf list output being too verbose.

v2: Additional details to the cover letter. Credit to Vince Weaver
    added to the commit message for the event details. Additional
    patches to clean up perf_pmu new_alias by removing an unused term
    scanner argument and avoid stdio usage.
    https://lore.kernel.org/lkml/20250828163225.3839073-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20250828064231.1762997-1-irogers@google.com/

Ian Rogers (15):
  perf parse-events: Fix legacy cache events if event is duplicated in a
    PMU
  perf perf_api_probe: Avoid scanning all PMUs, try software PMU first
  perf record: Skip don't fail for events that don't open
  perf jevents: Support copying the source json files to OUTPUT
  perf pmu: Don't eagerly parse event terms
  perf parse-events: Remove unused FILE input argument to scanner
  perf pmu: Use fd rather than FILE from new_alias
  perf pmu: Factor term parsing into a perf_event_attr into a helper
  perf parse-events: Add terms for legacy hardware and cache config
    values
  perf jevents: Add legacy json terms and default_core event table
    helper
  perf pmu: Add and use legacy_terms in alias information
  perf jevents: Add legacy-hardware and legacy-cache json
  perf print-events: Remove print_hwcache_events
  perf print-events: Remove print_symbol_events
  perf parse-events: Remove hard coded legacy hardware and cache parsing

 tools/perf/Makefile.perf                      |   21 +-
 tools/perf/arch/x86/util/intel-pt.c           |    2 +-
 tools/perf/builtin-list.c                     |   34 +-
 tools/perf/builtin-record.c                   |   89 +-
 tools/perf/pmu-events/Build                   |   24 +-
 .../arch/common/common/legacy-hardware.json   |   72 +
 tools/perf/pmu-events/empty-pmu-events.c      | 2763 ++++++++++++++++-
 tools/perf/pmu-events/jevents.py              |   24 +
 tools/perf/pmu-events/make_legacy_cache.py    |  129 +
 tools/perf/pmu-events/pmu-events.h            |    1 +
 tools/perf/tests/parse-events.c               |    2 +-
 tools/perf/tests/pmu-events.c                 |   24 +-
 tools/perf/tests/pmu.c                        |    3 +-
 tools/perf/util/parse-events.c                |  283 +-
 tools/perf/util/parse-events.h                |   16 +-
 tools/perf/util/parse-events.l                |   54 +-
 tools/perf/util/parse-events.y                |  114 +-
 tools/perf/util/perf_api_probe.c              |   27 +-
 tools/perf/util/pmu.c                         |  302 +-
 tools/perf/util/print-events.c                |  112 -
 tools/perf/util/print-events.h                |    4 -
 21 files changed, 3330 insertions(+), 770 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/legacy-hardware.json
 create mode 100755 tools/perf/pmu-events/make_legacy_cache.py

-- 
2.51.0.318.gd7df087d1a-goog


