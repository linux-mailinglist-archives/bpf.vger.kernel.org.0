Return-Path: <bpf+bounces-66847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3064DB3A664
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB04987D63
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 16:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7640F32A3CE;
	Thu, 28 Aug 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKUpwS7z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC4A233133
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398768; cv=none; b=d0ZgPrAO93LVuny2wpJjCuiRU5drv9sLgVGedG8AbvyQM7lhA6gsQ/OhHagDGCFTfgn2V8JRnQPY2ODcQdmDxx9BOaQqEzZ1WsqwoxbK53XWB/FshZ/WPe6wEPfdYgmDH7p7FtugwO8+dlGv69YKkkO7rrGPoC6bt5f+W1a0+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398768; c=relaxed/simple;
	bh=MIkWyjBasZFRkpOfKLng7lqEA9NLvEpAo2IhIq0Om08=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=kAgDQpA6hQ2eZEjyi9u44id7B+jmaaRUUdUK7qk0CCYA18o1rtA4ArNQvUVWnAoBQEm765eFtSUDcxx0yaqec4Bxc4uhpUlhaEUxK1onyLBzYNQdAQ9YVOE8q1PQMor/fBps2PQTu7Mo6xYP2KZvYE8ff+Cwn214tsNCsoljB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fKUpwS7z; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327b5e7f2f6so1020823a91.2
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 09:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756398761; x=1757003561; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HLFCueQawoQyJVXxbdF1BSYSeW/YbBq1j5LgrCBhc3g=;
        b=fKUpwS7z6MDvICWKB5DGFoamdShV7yrj+9bJ4JmOi/PsFysUMBDEXOjFEHl3TXY2l0
         EP3UylAwV2Ius0gjJXvpTD8oFKzj+dJfunzSsYDaRIP5vrrs3AujOhn9RT4FPGDGfxBU
         mpthyVC2DV5PFA3naNxlnq8CQEBHVZVOEdoMRH48pdk5ZcNENEFcfbaxAeBX4eakEg6M
         /D+ygnDn9B5A09mR+CjBytb35KcjH3YZOAsedSnKVMfzZ36TO7mU/ebhB2apyOp62Zsb
         q21gafXHJbGiZ9pe7RSnkCDoyQ12/okDCQ0TW1xPyjFqyE4zgcZ0tk+EmVPHy1xZ1rsl
         KG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398761; x=1757003561;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLFCueQawoQyJVXxbdF1BSYSeW/YbBq1j5LgrCBhc3g=;
        b=TOpI5EmPCYTVvx/sQxo4UnQ7BR87j0zgnvYvKDCAe+HZR87hbr0E3/dwoUErXfFfi1
         8aM2HUaH/dRYBll6R6TDZjXxZZcanhvz0wLC3NstLdGTu1piazAjmKucd58G11uZ7L6B
         wX/3W2kUUNfZw1NNBqdIiIgnxAA9SoOwf0kSM3I7UcqBiSA4YOtWpRju9reTALeb9Wtf
         oOyw3cE3HWHg2kzjwSB96k06XFJrhLlp7KPfCzLrRTtO4Y23MTzjiswH4C7xRWAUZ9dB
         5aA2Us4swQPit8gGjljci6na7FkR/L51WaKWyCWQU7INg9cQ5jnFqUFnuOH6gNuAwBrH
         DcuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqEfU/nEmbkr4Ie8ylF11FxyqiGy/t3FZPb9+mgbVG04ovtWO8/NqEJPOGUp1YdF+j+SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztcjjGqvZ+pRXtYDXjii9ROJF4rYc08IwGMv75xFNWrdRp7AMi
	0fXCbyCHlQ4fM5q29s0TEEWk11xPM66ChvE7epHDzmrU8aUHp8yl4Q77p432xGDXvR+RDwsRuGV
	RqcMYXwxtWw==
X-Google-Smtp-Source: AGHT+IG44p0/PgwNGPElO1mzvSRhoT8DpNLwTRG6sUmLBf+H7jfwGS6eVfdJdcFn2IgTYxAiKMin0IswFOV7
X-Received: from pjbpd6.prod.google.com ([2002:a17:90b:1dc6:b0:325:7130:ca17])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cc6:b0:327:96dd:6294
 with SMTP id 98e67ed59e1d1-32796dd6549mr7660303a91.37.1756398761105; Thu, 28
 Aug 2025 09:32:41 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:32:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828163225.3839073-1-irogers@google.com>
Subject: [PATCH v2 00/15] Legacy hardware/cache events as json
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

The perf list behavior includes a lot more information and
events. Previously only some of the legacy cache encodings were
displayed, similar could be done here by deprecating the encodings
that aren't show in perf list. The behavior before is:
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
  L1-dcache-loads OR cpu/L1-dcache-loads/
  L1-dcache-load-misses OR cpu/L1-dcache-load-misses/
  L1-dcache-stores OR cpu/L1-dcache-stores/
  L1-icache-load-misses OR cpu/L1-icache-load-misses/
  LLC-loads OR cpu/LLC-loads/
  LLC-load-misses OR cpu/LLC-load-misses/
  LLC-stores OR cpu/LLC-stores/
  LLC-store-misses OR cpu/LLC-store-misses/
  dTLB-loads OR cpu/dTLB-loads/
  dTLB-load-misses OR cpu/dTLB-load-misses/
  dTLB-stores OR cpu/dTLB-stores/
  dTLB-store-misses OR cpu/dTLB-store-misses/
  iTLB-load-misses OR cpu/iTLB-load-misses/
  branch-loads OR cpu/branch-loads/
  branch-load-misses OR cpu/branch-load-misses/
  node-loads OR cpu/node-loads/
  node-load-misses OR cpu/node-load-misses/
  node-stores OR cpu/node-stores/
  node-store-misses OR cpu/node-store-misses/
```
and after it is:
```
$ perf list hw

legacy hardware:
  branch-instructions
       [Retired branch instructions [This event is an alias of branches].
        Unit: cpu]
  branch-misses
       [Mispredicted branch instructions. Unit: cpu]
  branches
       [Retired branch instructions [This event is an alias of
        branch-instructions]. Unit: cpu]
  bus-cycles
       [Bus cycles,which can be different from total cycles. Unit: cpu]
  cache-misses
       [Cache misses. Usually this indicates Last Level Cache misses; this is
        intended to be used in conjunction with the
        PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss rates.
        Unit: cpu]
  cache-references
       [Cache accesses. Usually this indicates Last Level Cache accesses but
        this may vary depending on your CPU. This may include prefetches and
        coherency messages; again this depends on the design of your CPU.
        Unit: cpu]
  cpu-cycles
       [Total cycles. Be wary of what happens during CPU frequency scaling
        [This event is an alias of cycles]. Unit: cpu]
  cycles
       [Total cycles. Be wary of what happens during CPU frequency scaling
        [This event is an alias of cpu-cycles]. Unit: cpu]
  instructions
       [Retired instructions. Be careful,these can be affected by various
        issues,most notably hardware interrupt counts. Unit: cpu]
  ref-cycles
       [Total cycles; not affected by CPU frequency scaling. Unit: cpu]
$ perf list hwcache

legacy cache:
  bpc
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-access
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-load
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-load-access
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-load-miss
       [Branch prediction unit read misses. Unit: cpu]
  bpc-load-misses
       [Branch prediction unit read misses. Unit: cpu]
  bpc-load-ops
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-load-reference
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-load-refs
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-loads
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-loads-access
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-loads-miss
       [Branch prediction unit read misses. Unit: cpu]
  bpc-loads-misses
       [Branch prediction unit read misses. Unit: cpu]
  bpc-loads-ops
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-loads-reference
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-loads-refs
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-miss
       [Branch prediction unit read misses. Unit: cpu]
  bpc-misses
       [Branch prediction unit read misses. Unit: cpu]
  bpc-ops
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-read
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-read-access
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-read-miss
       [Branch prediction unit read misses. Unit: cpu]
  bpc-read-misses
       [Branch prediction unit read misses. Unit: cpu]
  bpc-read-ops
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-read-reference
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-read-refs
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-reference
       [Branch prediction unit read accesses. Unit: cpu]
  bpc-refs
       [Branch prediction unit read accesses. Unit: cpu]
  bpu
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-access
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-load
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-load-access
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-load-miss
       [Branch prediction unit read misses. Unit: cpu]
  bpu-load-misses
       [Branch prediction unit read misses. Unit: cpu]
  bpu-load-ops
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-load-reference
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-load-refs
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-loads
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-loads-access
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-loads-miss
       [Branch prediction unit read misses. Unit: cpu]
  bpu-loads-misses
       [Branch prediction unit read misses. Unit: cpu]
  bpu-loads-ops
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-loads-reference
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-loads-refs
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-miss
       [Branch prediction unit read misses. Unit: cpu]
  bpu-misses
       [Branch prediction unit read misses. Unit: cpu]
  bpu-ops
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-read
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-read-access
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-read-miss
       [Branch prediction unit read misses. Unit: cpu]
  bpu-read-misses
       [Branch prediction unit read misses. Unit: cpu]
  bpu-read-ops
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-read-reference
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-read-refs
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-reference
       [Branch prediction unit read accesses. Unit: cpu]
  bpu-refs
       [Branch prediction unit read accesses. Unit: cpu]
  branch
       [Branch prediction unit read accesses. Unit: cpu]
  branch-access
       [Branch prediction unit read accesses. Unit: cpu]
  branch-load
       [Branch prediction unit read accesses. Unit: cpu]
  branch-load-access
       [Branch prediction unit read accesses. Unit: cpu]
  branch-load-miss
       [Branch prediction unit read misses. Unit: cpu]
  branch-load-misses
       [Branch prediction unit read misses. Unit: cpu]
  branch-load-ops
       [Branch prediction unit read accesses. Unit: cpu]
  branch-load-reference
       [Branch prediction unit read accesses. Unit: cpu]
  branch-load-refs
       [Branch prediction unit read accesses. Unit: cpu]
  branch-loads
       [Branch prediction unit read accesses. Unit: cpu]
  branch-loads-access
       [Branch prediction unit read accesses. Unit: cpu]
  branch-loads-miss
       [Branch prediction unit read misses. Unit: cpu]
  branch-loads-misses
       [Branch prediction unit read misses. Unit: cpu]
  branch-loads-ops
       [Branch prediction unit read accesses. Unit: cpu]
  branch-loads-reference
       [Branch prediction unit read accesses. Unit: cpu]
  branch-loads-refs
       [Branch prediction unit read accesses. Unit: cpu]
  branch-miss
       [Branch prediction unit read misses. Unit: cpu]
  branch-ops
       [Branch prediction unit read accesses. Unit: cpu]
  branch-read
       [Branch prediction unit read accesses. Unit: cpu]
  branch-read-access
       [Branch prediction unit read accesses. Unit: cpu]
  branch-read-miss
       [Branch prediction unit read misses. Unit: cpu]
  branch-read-misses
       [Branch prediction unit read misses. Unit: cpu]
  branch-read-ops
       [Branch prediction unit read accesses. Unit: cpu]
  branch-read-reference
       [Branch prediction unit read accesses. Unit: cpu]
  branch-read-refs
       [Branch prediction unit read accesses. Unit: cpu]
  branch-reference
       [Branch prediction unit read accesses. Unit: cpu]
  branch-refs
       [Branch prediction unit read accesses. Unit: cpu]
  branches-access
       [Branch prediction unit read accesses. Unit: cpu]
  branches-load
       [Branch prediction unit read accesses. Unit: cpu]
  branches-load-access
       [Branch prediction unit read accesses. Unit: cpu]
  branches-load-miss
       [Branch prediction unit read misses. Unit: cpu]
  branches-load-misses
       [Branch prediction unit read misses. Unit: cpu]
  branches-load-ops
       [Branch prediction unit read accesses. Unit: cpu]
  branches-load-reference
       [Branch prediction unit read accesses. Unit: cpu]
  branches-load-refs
       [Branch prediction unit read accesses. Unit: cpu]
  branches-loads
       [Branch prediction unit read accesses. Unit: cpu]
  branches-loads-access
       [Branch prediction unit read accesses. Unit: cpu]
  branches-loads-miss
       [Branch prediction unit read misses. Unit: cpu]
  branches-loads-misses
       [Branch prediction unit read misses. Unit: cpu]
  branches-loads-ops
       [Branch prediction unit read accesses. Unit: cpu]
  branches-loads-reference
       [Branch prediction unit read accesses. Unit: cpu]
  branches-loads-refs
       [Branch prediction unit read accesses. Unit: cpu]
  branches-miss
       [Branch prediction unit read misses. Unit: cpu]
  branches-misses
       [Branch prediction unit read misses. Unit: cpu]
  branches-ops
       [Branch prediction unit read accesses. Unit: cpu]
  branches-read
       [Branch prediction unit read accesses. Unit: cpu]
  branches-read-access
       [Branch prediction unit read accesses. Unit: cpu]
  branches-read-miss
       [Branch prediction unit read misses. Unit: cpu]
  branches-read-misses
       [Branch prediction unit read misses. Unit: cpu]
  branches-read-ops
       [Branch prediction unit read accesses. Unit: cpu]
  branches-read-reference
       [Branch prediction unit read accesses. Unit: cpu]
  branches-read-refs
       [Branch prediction unit read accesses. Unit: cpu]
  branches-reference
       [Branch prediction unit read accesses. Unit: cpu]
  branches-refs
       [Branch prediction unit read accesses. Unit: cpu]
  btb
       [Branch prediction unit read accesses. Unit: cpu]
  btb-access
       [Branch prediction unit read accesses. Unit: cpu]
  btb-load
       [Branch prediction unit read accesses. Unit: cpu]
  btb-load-access
       [Branch prediction unit read accesses. Unit: cpu]
  btb-load-miss
       [Branch prediction unit read misses. Unit: cpu]
  btb-load-misses
       [Branch prediction unit read misses. Unit: cpu]
  btb-load-ops
       [Branch prediction unit read accesses. Unit: cpu]
  btb-load-reference
       [Branch prediction unit read accesses. Unit: cpu]
  btb-load-refs
       [Branch prediction unit read accesses. Unit: cpu]
  btb-loads
       [Branch prediction unit read accesses. Unit: cpu]
  btb-loads-access
       [Branch prediction unit read accesses. Unit: cpu]
  btb-loads-miss
       [Branch prediction unit read misses. Unit: cpu]
  btb-loads-misses
       [Branch prediction unit read misses. Unit: cpu]
  btb-loads-ops
       [Branch prediction unit read accesses. Unit: cpu]
  btb-loads-reference
       [Branch prediction unit read accesses. Unit: cpu]
  btb-loads-refs
       [Branch prediction unit read accesses. Unit: cpu]
  btb-miss
       [Branch prediction unit read misses. Unit: cpu]
  btb-misses
       [Branch prediction unit read misses. Unit: cpu]
  btb-ops
       [Branch prediction unit read accesses. Unit: cpu]
  btb-read
       [Branch prediction unit read accesses. Unit: cpu]
  btb-read-access
       [Branch prediction unit read accesses. Unit: cpu]
  btb-read-miss
       [Branch prediction unit read misses. Unit: cpu]
  btb-read-misses
       [Branch prediction unit read misses. Unit: cpu]
  btb-read-ops
       [Branch prediction unit read accesses. Unit: cpu]
  btb-read-reference
       [Branch prediction unit read accesses. Unit: cpu]
  btb-read-refs
       [Branch prediction unit read accesses. Unit: cpu]
  btb-reference
       [Branch prediction unit read accesses. Unit: cpu]
  btb-refs
       [Branch prediction unit read accesses. Unit: cpu]
  d-tlb
       [Data TLB read accesses. Unit: cpu]
  d-tlb-access
       [Data TLB read accesses. Unit: cpu]
  d-tlb-load
       [Data TLB read accesses. Unit: cpu]
  d-tlb-load-access
       [Data TLB read accesses. Unit: cpu]
  d-tlb-load-miss
       [Data TLB read misses. Unit: cpu]
  d-tlb-load-misses
       [Data TLB read misses. Unit: cpu]
  d-tlb-load-ops
       [Data TLB read accesses. Unit: cpu]
  d-tlb-load-reference
       [Data TLB read accesses. Unit: cpu]
  d-tlb-load-refs
       [Data TLB read accesses. Unit: cpu]
  d-tlb-loads
       [Data TLB read accesses. Unit: cpu]
  d-tlb-loads-access
       [Data TLB read accesses. Unit: cpu]
  d-tlb-loads-miss
       [Data TLB read misses. Unit: cpu]
  d-tlb-loads-misses
       [Data TLB read misses. Unit: cpu]
  d-tlb-loads-ops
       [Data TLB read accesses. Unit: cpu]
  d-tlb-loads-reference
       [Data TLB read accesses. Unit: cpu]
  d-tlb-loads-refs
       [Data TLB read accesses. Unit: cpu]
  d-tlb-miss
       [Data TLB read misses. Unit: cpu]
  d-tlb-misses
       [Data TLB read misses. Unit: cpu]
  d-tlb-ops
       [Data TLB read accesses. Unit: cpu]
  d-tlb-read
       [Data TLB read accesses. Unit: cpu]
  d-tlb-read-access
       [Data TLB read accesses. Unit: cpu]
  d-tlb-read-miss
       [Data TLB read misses. Unit: cpu]
  d-tlb-read-misses
       [Data TLB read misses. Unit: cpu]
  d-tlb-read-ops
       [Data TLB read accesses. Unit: cpu]
  d-tlb-read-reference
       [Data TLB read accesses. Unit: cpu]
  d-tlb-read-refs
       [Data TLB read accesses. Unit: cpu]
  d-tlb-reference
       [Data TLB read accesses. Unit: cpu]
  d-tlb-refs
       [Data TLB read accesses. Unit: cpu]
  d-tlb-store
       [Data TLB write accesses. Unit: cpu]
  d-tlb-store-access
       [Data TLB write accesses. Unit: cpu]
  d-tlb-store-miss
       [Data TLB write misses. Unit: cpu]
  d-tlb-store-misses
       [Data TLB write misses. Unit: cpu]
  d-tlb-store-ops
       [Data TLB write accesses. Unit: cpu]
  d-tlb-store-reference
       [Data TLB write accesses. Unit: cpu]
  d-tlb-store-refs
       [Data TLB write accesses. Unit: cpu]
  d-tlb-stores
       [Data TLB write accesses. Unit: cpu]
  d-tlb-stores-access
       [Data TLB write accesses. Unit: cpu]
  d-tlb-stores-miss
       [Data TLB write misses. Unit: cpu]
  d-tlb-stores-misses
       [Data TLB write misses. Unit: cpu]
  d-tlb-stores-ops
       [Data TLB write accesses. Unit: cpu]
  d-tlb-stores-reference
       [Data TLB write accesses. Unit: cpu]
  d-tlb-stores-refs
       [Data TLB write accesses. Unit: cpu]
  d-tlb-write
       [Data TLB write accesses. Unit: cpu]
  d-tlb-write-access
       [Data TLB write accesses. Unit: cpu]
  d-tlb-write-miss
       [Data TLB write misses. Unit: cpu]
  d-tlb-write-misses
       [Data TLB write misses. Unit: cpu]
  d-tlb-write-ops
       [Data TLB write accesses. Unit: cpu]
  d-tlb-write-reference
       [Data TLB write accesses. Unit: cpu]
  d-tlb-write-refs
       [Data TLB write accesses. Unit: cpu]
  data-tlb
       [Data TLB read accesses. Unit: cpu]
  data-tlb-access
       [Data TLB read accesses. Unit: cpu]
  data-tlb-load
       [Data TLB read accesses. Unit: cpu]
  data-tlb-load-access
       [Data TLB read accesses. Unit: cpu]
  data-tlb-load-miss
       [Data TLB read misses. Unit: cpu]
  data-tlb-load-misses
       [Data TLB read misses. Unit: cpu]
  data-tlb-load-ops
       [Data TLB read accesses. Unit: cpu]
  data-tlb-load-reference
       [Data TLB read accesses. Unit: cpu]
  data-tlb-load-refs
       [Data TLB read accesses. Unit: cpu]
  data-tlb-loads
       [Data TLB read accesses. Unit: cpu]
  data-tlb-loads-access
       [Data TLB read accesses. Unit: cpu]
  data-tlb-loads-miss
       [Data TLB read misses. Unit: cpu]
  data-tlb-loads-misses
       [Data TLB read misses. Unit: cpu]
  data-tlb-loads-ops
       [Data TLB read accesses. Unit: cpu]
  data-tlb-loads-reference
       [Data TLB read accesses. Unit: cpu]
  data-tlb-loads-refs
       [Data TLB read accesses. Unit: cpu]
  data-tlb-miss
       [Data TLB read misses. Unit: cpu]
  data-tlb-misses
       [Data TLB read misses. Unit: cpu]
  data-tlb-ops
       [Data TLB read accesses. Unit: cpu]
  data-tlb-read
       [Data TLB read accesses. Unit: cpu]
  data-tlb-read-access
       [Data TLB read accesses. Unit: cpu]
  data-tlb-read-miss
       [Data TLB read misses. Unit: cpu]
  data-tlb-read-misses
       [Data TLB read misses. Unit: cpu]
  data-tlb-read-ops
       [Data TLB read accesses. Unit: cpu]
  data-tlb-read-reference
       [Data TLB read accesses. Unit: cpu]
  data-tlb-read-refs
       [Data TLB read accesses. Unit: cpu]
  data-tlb-reference
       [Data TLB read accesses. Unit: cpu]
  data-tlb-refs
       [Data TLB read accesses. Unit: cpu]
  data-tlb-store
       [Data TLB write accesses. Unit: cpu]
  data-tlb-store-access
       [Data TLB write accesses. Unit: cpu]
  data-tlb-store-miss
       [Data TLB write misses. Unit: cpu]
  data-tlb-store-misses
       [Data TLB write misses. Unit: cpu]
  data-tlb-store-ops
       [Data TLB write accesses. Unit: cpu]
  data-tlb-store-reference
       [Data TLB write accesses. Unit: cpu]
  data-tlb-store-refs
       [Data TLB write accesses. Unit: cpu]
  data-tlb-stores
       [Data TLB write accesses. Unit: cpu]
  data-tlb-stores-access
       [Data TLB write accesses. Unit: cpu]
  data-tlb-stores-miss
       [Data TLB write misses. Unit: cpu]
  data-tlb-stores-misses
       [Data TLB write misses. Unit: cpu]
  data-tlb-stores-ops
       [Data TLB write accesses. Unit: cpu]
  data-tlb-stores-reference
       [Data TLB write accesses. Unit: cpu]
  data-tlb-stores-refs
       [Data TLB write accesses. Unit: cpu]
  data-tlb-write
       [Data TLB write accesses. Unit: cpu]
  data-tlb-write-access
       [Data TLB write accesses. Unit: cpu]
  data-tlb-write-miss
       [Data TLB write misses. Unit: cpu]
  data-tlb-write-misses
       [Data TLB write misses. Unit: cpu]
  data-tlb-write-ops
       [Data TLB write accesses. Unit: cpu]
  data-tlb-write-reference
       [Data TLB write accesses. Unit: cpu]
  data-tlb-write-refs
       [Data TLB write accesses. Unit: cpu]
  dtlb
       [Data TLB read accesses. Unit: cpu]
  dtlb-access
       [Data TLB read accesses. Unit: cpu]
  dtlb-load
       [Data TLB read accesses. Unit: cpu]
  dtlb-load-access
       [Data TLB read accesses. Unit: cpu]
  dtlb-load-miss
       [Data TLB read misses. Unit: cpu]
  dtlb-load-misses
       [Data TLB read misses. Unit: cpu]
  dtlb-load-ops
       [Data TLB read accesses. Unit: cpu]
  dtlb-load-reference
       [Data TLB read accesses. Unit: cpu]
  dtlb-load-refs
       [Data TLB read accesses. Unit: cpu]
  dtlb-loads
       [Data TLB read accesses. Unit: cpu]
  dtlb-loads-access
       [Data TLB read accesses. Unit: cpu]
  dtlb-loads-miss
       [Data TLB read misses. Unit: cpu]
  dtlb-loads-misses
       [Data TLB read misses. Unit: cpu]
  dtlb-loads-ops
       [Data TLB read accesses. Unit: cpu]
  dtlb-loads-reference
       [Data TLB read accesses. Unit: cpu]
  dtlb-loads-refs
       [Data TLB read accesses. Unit: cpu]
  dtlb-miss
       [Data TLB read misses. Unit: cpu]
  dtlb-misses
       [Data TLB read misses. Unit: cpu]
  dtlb-ops
       [Data TLB read accesses. Unit: cpu]
  dtlb-read
       [Data TLB read accesses. Unit: cpu]
  dtlb-read-access
       [Data TLB read accesses. Unit: cpu]
  dtlb-read-miss
       [Data TLB read misses. Unit: cpu]
  dtlb-read-misses
       [Data TLB read misses. Unit: cpu]
  dtlb-read-ops
       [Data TLB read accesses. Unit: cpu]
  dtlb-read-reference
       [Data TLB read accesses. Unit: cpu]
  dtlb-read-refs
       [Data TLB read accesses. Unit: cpu]
  dtlb-reference
       [Data TLB read accesses. Unit: cpu]
  dtlb-refs
       [Data TLB read accesses. Unit: cpu]
  dtlb-store
       [Data TLB write accesses. Unit: cpu]
  dtlb-store-access
       [Data TLB write accesses. Unit: cpu]
  dtlb-store-miss
       [Data TLB write misses. Unit: cpu]
  dtlb-store-misses
       [Data TLB write misses. Unit: cpu]
  dtlb-store-ops
       [Data TLB write accesses. Unit: cpu]
  dtlb-store-reference
       [Data TLB write accesses. Unit: cpu]
  dtlb-store-refs
       [Data TLB write accesses. Unit: cpu]
  dtlb-stores
       [Data TLB write accesses. Unit: cpu]
  dtlb-stores-access
       [Data TLB write accesses. Unit: cpu]
  dtlb-stores-miss
       [Data TLB write misses. Unit: cpu]
  dtlb-stores-misses
       [Data TLB write misses. Unit: cpu]
  dtlb-stores-ops
       [Data TLB write accesses. Unit: cpu]
  dtlb-stores-reference
       [Data TLB write accesses. Unit: cpu]
  dtlb-stores-refs
       [Data TLB write accesses. Unit: cpu]
  dtlb-write
       [Data TLB write accesses. Unit: cpu]
  dtlb-write-access
       [Data TLB write accesses. Unit: cpu]
  dtlb-write-miss
       [Data TLB write misses. Unit: cpu]
  dtlb-write-misses
       [Data TLB write misses. Unit: cpu]
  dtlb-write-ops
       [Data TLB write accesses. Unit: cpu]
  dtlb-write-reference
       [Data TLB write accesses. Unit: cpu]
  dtlb-write-refs
       [Data TLB write accesses. Unit: cpu]
  i-tlb-load-miss
       [Instruction TLB read misses. Unit: cpu]
  i-tlb-load-misses
       [Instruction TLB read misses. Unit: cpu]
  i-tlb-loads-miss
       [Instruction TLB read misses. Unit: cpu]
  i-tlb-loads-misses
       [Instruction TLB read misses. Unit: cpu]
  i-tlb-miss
       [Instruction TLB read misses. Unit: cpu]
  i-tlb-misses
       [Instruction TLB read misses. Unit: cpu]
  i-tlb-read-miss
       [Instruction TLB read misses. Unit: cpu]
  i-tlb-read-misses
       [Instruction TLB read misses. Unit: cpu]
  instruction-tlb-load-miss
       [Instruction TLB read misses. Unit: cpu]
  instruction-tlb-load-misses
       [Instruction TLB read misses. Unit: cpu]
  instruction-tlb-loads-miss
       [Instruction TLB read misses. Unit: cpu]
  instruction-tlb-loads-misses
       [Instruction TLB read misses. Unit: cpu]
  instruction-tlb-miss
       [Instruction TLB read misses. Unit: cpu]
  instruction-tlb-misses
       [Instruction TLB read misses. Unit: cpu]
  instruction-tlb-read-miss
       [Instruction TLB read misses. Unit: cpu]
  instruction-tlb-read-misses
       [Instruction TLB read misses. Unit: cpu]
  itlb-load-miss
       [Instruction TLB read misses. Unit: cpu]
  itlb-load-misses
       [Instruction TLB read misses. Unit: cpu]
  itlb-loads-miss
       [Instruction TLB read misses. Unit: cpu]
  itlb-loads-misses
       [Instruction TLB read misses. Unit: cpu]
  itlb-miss
       [Instruction TLB read misses. Unit: cpu]
  itlb-misses
       [Instruction TLB read misses. Unit: cpu]
  itlb-read-miss
       [Instruction TLB read misses. Unit: cpu]
  itlb-read-misses
       [Instruction TLB read misses. Unit: cpu]
  l1-d
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-access
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-load
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-load-access
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-load-miss
       [Level 1 data cache read misses. Unit: cpu]
  l1-d-load-misses
       [Level 1 data cache read misses. Unit: cpu]
  l1-d-load-ops
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-load-reference
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-load-refs
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-loads
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-loads-access
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-loads-miss
       [Level 1 data cache read misses. Unit: cpu]
  l1-d-loads-misses
       [Level 1 data cache read misses. Unit: cpu]
  l1-d-loads-ops
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-loads-reference
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-loads-refs
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-miss
       [Level 1 data cache read misses. Unit: cpu]
  l1-d-misses
       [Level 1 data cache read misses. Unit: cpu]
  l1-d-ops
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-read
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-read-access
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-read-miss
       [Level 1 data cache read misses. Unit: cpu]
  l1-d-read-misses
       [Level 1 data cache read misses. Unit: cpu]
  l1-d-read-ops
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-read-reference
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-read-refs
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-reference
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-refs
       [Level 1 data cache read accesses. Unit: cpu]
  l1-d-store
       [Level 1 data cache write accesses. Unit: cpu]
  l1-d-store-access
       [Level 1 data cache write accesses. Unit: cpu]
  l1-d-store-ops
       [Level 1 data cache write accesses. Unit: cpu]
  l1-d-store-reference
       [Level 1 data cache write accesses. Unit: cpu]
  l1-d-store-refs
       [Level 1 data cache write accesses. Unit: cpu]
  l1-d-stores
       [Level 1 data cache write accesses. Unit: cpu]
  l1-d-stores-access
       [Level 1 data cache write accesses. Unit: cpu]
  l1-d-stores-ops
       [Level 1 data cache write accesses. Unit: cpu]
  l1-d-stores-reference
       [Level 1 data cache write accesses. Unit: cpu]
  l1-d-stores-refs
       [Level 1 data cache write accesses. Unit: cpu]
  l1-d-write
       [Level 1 data cache write accesses. Unit: cpu]
  l1-d-write-access
       [Level 1 data cache write accesses. Unit: cpu]
  l1-d-write-ops
       [Level 1 data cache write accesses. Unit: cpu]
  l1-d-write-reference
       [Level 1 data cache write accesses. Unit: cpu]
  l1-d-write-refs
       [Level 1 data cache write accesses. Unit: cpu]
  l1-data
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-access
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-load
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-load-access
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-load-miss
       [Level 1 data cache read misses. Unit: cpu]
  l1-data-load-misses
       [Level 1 data cache read misses. Unit: cpu]
  l1-data-load-ops
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-load-reference
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-load-refs
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-loads
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-loads-access
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-loads-miss
       [Level 1 data cache read misses. Unit: cpu]
  l1-data-loads-misses
       [Level 1 data cache read misses. Unit: cpu]
  l1-data-loads-ops
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-loads-reference
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-loads-refs
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-miss
       [Level 1 data cache read misses. Unit: cpu]
  l1-data-misses
       [Level 1 data cache read misses. Unit: cpu]
  l1-data-ops
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-read
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-read-access
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-read-miss
       [Level 1 data cache read misses. Unit: cpu]
  l1-data-read-misses
       [Level 1 data cache read misses. Unit: cpu]
  l1-data-read-ops
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-read-reference
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-read-refs
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-reference
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-refs
       [Level 1 data cache read accesses. Unit: cpu]
  l1-data-store
       [Level 1 data cache write accesses. Unit: cpu]
  l1-data-store-access
       [Level 1 data cache write accesses. Unit: cpu]
  l1-data-store-ops
       [Level 1 data cache write accesses. Unit: cpu]
  l1-data-store-reference
       [Level 1 data cache write accesses. Unit: cpu]
  l1-data-store-refs
       [Level 1 data cache write accesses. Unit: cpu]
  l1-data-stores
       [Level 1 data cache write accesses. Unit: cpu]
  l1-data-stores-access
       [Level 1 data cache write accesses. Unit: cpu]
  l1-data-stores-ops
       [Level 1 data cache write accesses. Unit: cpu]
  l1-data-stores-reference
       [Level 1 data cache write accesses. Unit: cpu]
  l1-data-stores-refs
       [Level 1 data cache write accesses. Unit: cpu]
  l1-data-write
       [Level 1 data cache write accesses. Unit: cpu]
  l1-data-write-access
       [Level 1 data cache write accesses. Unit: cpu]
  l1-data-write-ops
       [Level 1 data cache write accesses. Unit: cpu]
  l1-data-write-reference
       [Level 1 data cache write accesses. Unit: cpu]
  l1-data-write-refs
       [Level 1 data cache write accesses. Unit: cpu]
  l1-dcache
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-access
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-load
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-load-access
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-load-miss
       [Level 1 data cache read misses. Unit: cpu]
  l1-dcache-load-misses
       [Level 1 data cache read misses. Unit: cpu]
  l1-dcache-load-ops
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-load-reference
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-load-refs
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-loads
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-loads-access
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-loads-miss
       [Level 1 data cache read misses. Unit: cpu]
  l1-dcache-loads-misses
       [Level 1 data cache read misses. Unit: cpu]
  l1-dcache-loads-ops
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-loads-reference
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-loads-refs
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-miss
       [Level 1 data cache read misses. Unit: cpu]
  l1-dcache-misses
       [Level 1 data cache read misses. Unit: cpu]
  l1-dcache-ops
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-read
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-read-access
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-read-miss
       [Level 1 data cache read misses. Unit: cpu]
  l1-dcache-read-misses
       [Level 1 data cache read misses. Unit: cpu]
  l1-dcache-read-ops
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-read-reference
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-read-refs
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-reference
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-refs
       [Level 1 data cache read accesses. Unit: cpu]
  l1-dcache-store
       [Level 1 data cache write accesses. Unit: cpu]
  l1-dcache-store-access
       [Level 1 data cache write accesses. Unit: cpu]
  l1-dcache-store-ops
       [Level 1 data cache write accesses. Unit: cpu]
  l1-dcache-store-reference
       [Level 1 data cache write accesses. Unit: cpu]
  l1-dcache-store-refs
       [Level 1 data cache write accesses. Unit: cpu]
  l1-dcache-stores
       [Level 1 data cache write accesses. Unit: cpu]
  l1-dcache-stores-access
       [Level 1 data cache write accesses. Unit: cpu]
  l1-dcache-stores-ops
       [Level 1 data cache write accesses. Unit: cpu]
  l1-dcache-stores-reference
       [Level 1 data cache write accesses. Unit: cpu]
  l1-dcache-stores-refs
       [Level 1 data cache write accesses. Unit: cpu]
  l1-dcache-write
       [Level 1 data cache write accesses. Unit: cpu]
  l1-dcache-write-access
       [Level 1 data cache write accesses. Unit: cpu]
  l1-dcache-write-ops
       [Level 1 data cache write accesses. Unit: cpu]
  l1-dcache-write-reference
       [Level 1 data cache write accesses. Unit: cpu]
  l1-dcache-write-refs
       [Level 1 data cache write accesses. Unit: cpu]
  l1-i-load-miss
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-i-load-misses
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-i-loads-miss
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-i-loads-misses
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-i-miss
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-i-misses
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-i-read-miss
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-i-read-misses
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-icache-load-miss
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-icache-load-misses
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-icache-loads-miss
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-icache-loads-misses
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-icache-miss
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-icache-misses
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-icache-read-miss
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-icache-read-misses
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-instruction-load-miss
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-instruction-load-misses
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-instruction-loads-miss
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-instruction-loads-misses
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-instruction-miss
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-instruction-misses
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-instruction-read-miss
       [Level 1 instruction cache read misses. Unit: cpu]
  l1-instruction-read-misses
       [Level 1 instruction cache read misses. Unit: cpu]
  l1d
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-access
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-load
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-load-access
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-load-miss
       [Level 1 data cache read misses. Unit: cpu]
  l1d-load-misses
       [Level 1 data cache read misses. Unit: cpu]
  l1d-load-ops
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-load-reference
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-load-refs
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-loads
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-loads-access
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-loads-miss
       [Level 1 data cache read misses. Unit: cpu]
  l1d-loads-misses
       [Level 1 data cache read misses. Unit: cpu]
  l1d-loads-ops
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-loads-reference
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-loads-refs
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-miss
       [Level 1 data cache read misses. Unit: cpu]
  l1d-misses
       [Level 1 data cache read misses. Unit: cpu]
  l1d-ops
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-read
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-read-access
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-read-miss
       [Level 1 data cache read misses. Unit: cpu]
  l1d-read-misses
       [Level 1 data cache read misses. Unit: cpu]
  l1d-read-ops
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-read-reference
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-read-refs
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-reference
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-refs
       [Level 1 data cache read accesses. Unit: cpu]
  l1d-store
       [Level 1 data cache write accesses. Unit: cpu]
  l1d-store-access
       [Level 1 data cache write accesses. Unit: cpu]
  l1d-store-ops
       [Level 1 data cache write accesses. Unit: cpu]
  l1d-store-reference
       [Level 1 data cache write accesses. Unit: cpu]
  l1d-store-refs
       [Level 1 data cache write accesses. Unit: cpu]
  l1d-stores
       [Level 1 data cache write accesses. Unit: cpu]
  l1d-stores-access
       [Level 1 data cache write accesses. Unit: cpu]
  l1d-stores-ops
       [Level 1 data cache write accesses. Unit: cpu]
  l1d-stores-reference
       [Level 1 data cache write accesses. Unit: cpu]
  l1d-stores-refs
       [Level 1 data cache write accesses. Unit: cpu]
  l1d-write
       [Level 1 data cache write accesses. Unit: cpu]
  l1d-write-access
       [Level 1 data cache write accesses. Unit: cpu]
  l1d-write-ops
       [Level 1 data cache write accesses. Unit: cpu]
  l1d-write-reference
       [Level 1 data cache write accesses. Unit: cpu]
  l1d-write-refs
       [Level 1 data cache write accesses. Unit: cpu]
  l1i-load-miss
       [Level 1 instruction cache read misses. Unit: cpu]
  l1i-load-misses
       [Level 1 instruction cache read misses. Unit: cpu]
  l1i-loads-miss
       [Level 1 instruction cache read misses. Unit: cpu]
  l1i-loads-misses
       [Level 1 instruction cache read misses. Unit: cpu]
  l1i-miss
       [Level 1 instruction cache read misses. Unit: cpu]
  l1i-misses
       [Level 1 instruction cache read misses. Unit: cpu]
  l1i-read-miss
       [Level 1 instruction cache read misses. Unit: cpu]
  l1i-read-misses
       [Level 1 instruction cache read misses. Unit: cpu]
  llc
       [Last level cache read accesses. Unit: cpu]
  llc-access
       [Last level cache read accesses. Unit: cpu]
  llc-load
       [Last level cache read accesses. Unit: cpu]
  llc-load-access
       [Last level cache read accesses. Unit: cpu]
  llc-load-miss
       [Last level cache read misses. Unit: cpu]
  llc-load-misses
       [Last level cache read misses. Unit: cpu]
  llc-load-ops
       [Last level cache read accesses. Unit: cpu]
  llc-load-reference
       [Last level cache read accesses. Unit: cpu]
  llc-load-refs
       [Last level cache read accesses. Unit: cpu]
  llc-loads
       [Last level cache read accesses. Unit: cpu]
  llc-loads-access
       [Last level cache read accesses. Unit: cpu]
  llc-loads-miss
       [Last level cache read misses. Unit: cpu]
  llc-loads-misses
       [Last level cache read misses. Unit: cpu]
  llc-loads-ops
       [Last level cache read accesses. Unit: cpu]
  llc-loads-reference
       [Last level cache read accesses. Unit: cpu]
  llc-loads-refs
       [Last level cache read accesses. Unit: cpu]
  llc-miss
       [Last level cache read misses. Unit: cpu]
  llc-misses
       [Last level cache read misses. Unit: cpu]
  llc-ops
       [Last level cache read accesses. Unit: cpu]
  llc-read
       [Last level cache read accesses. Unit: cpu]
  llc-read-access
       [Last level cache read accesses. Unit: cpu]
  llc-read-miss
       [Last level cache read misses. Unit: cpu]
  llc-read-misses
       [Last level cache read misses. Unit: cpu]
  llc-read-ops
       [Last level cache read accesses. Unit: cpu]
  llc-read-reference
       [Last level cache read accesses. Unit: cpu]
  llc-read-refs
       [Last level cache read accesses. Unit: cpu]
  llc-reference
       [Last level cache read accesses. Unit: cpu]
  llc-refs
       [Last level cache read accesses. Unit: cpu]
  llc-store
       [Last level cache write accesses. Unit: cpu]
  llc-store-access
       [Last level cache write accesses. Unit: cpu]
  llc-store-miss
       [Last level cache write misses. Unit: cpu]
  llc-store-misses
       [Last level cache write misses. Unit: cpu]
  llc-store-ops
       [Last level cache write accesses. Unit: cpu]
  llc-store-reference
       [Last level cache write accesses. Unit: cpu]
  llc-store-refs
       [Last level cache write accesses. Unit: cpu]
  llc-stores
       [Last level cache write accesses. Unit: cpu]
  llc-stores-access
       [Last level cache write accesses. Unit: cpu]
  llc-stores-miss
       [Last level cache write misses. Unit: cpu]
  llc-stores-misses
       [Last level cache write misses. Unit: cpu]
  llc-stores-ops
       [Last level cache write accesses. Unit: cpu]
  llc-stores-reference
       [Last level cache write accesses. Unit: cpu]
  llc-stores-refs
       [Last level cache write accesses. Unit: cpu]
  llc-write
       [Last level cache write accesses. Unit: cpu]
  llc-write-access
       [Last level cache write accesses. Unit: cpu]
  llc-write-miss
       [Last level cache write misses. Unit: cpu]
  llc-write-misses
       [Last level cache write misses. Unit: cpu]
  llc-write-ops
       [Last level cache write accesses. Unit: cpu]
  llc-write-reference
       [Last level cache write accesses. Unit: cpu]
  llc-write-refs
       [Last level cache write accesses. Unit: cpu]
  node
       [Local memory read accesses. Unit: cpu]
  node-access
       [Local memory read accesses. Unit: cpu]
  node-load
       [Local memory read accesses. Unit: cpu]
  node-load-access
       [Local memory read accesses. Unit: cpu]
  node-load-miss
       [Local memory read misses. Unit: cpu]
  node-load-misses
       [Local memory read misses. Unit: cpu]
  node-load-ops
       [Local memory read accesses. Unit: cpu]
  node-load-reference
       [Local memory read accesses. Unit: cpu]
  node-load-refs
       [Local memory read accesses. Unit: cpu]
  node-loads
       [Local memory read accesses. Unit: cpu]
  node-loads-access
       [Local memory read accesses. Unit: cpu]
  node-loads-miss
       [Local memory read misses. Unit: cpu]
  node-loads-misses
       [Local memory read misses. Unit: cpu]
  node-loads-ops
       [Local memory read accesses. Unit: cpu]
  node-loads-reference
       [Local memory read accesses. Unit: cpu]
  node-loads-refs
       [Local memory read accesses. Unit: cpu]
  node-miss
       [Local memory read misses. Unit: cpu]
  node-misses
       [Local memory read misses. Unit: cpu]
  node-ops
       [Local memory read accesses. Unit: cpu]
  node-read
       [Local memory read accesses. Unit: cpu]
  node-read-access
       [Local memory read accesses. Unit: cpu]
  node-read-miss
       [Local memory read misses. Unit: cpu]
  node-read-misses
       [Local memory read misses. Unit: cpu]
  node-read-ops
       [Local memory read accesses. Unit: cpu]
  node-read-reference
       [Local memory read accesses. Unit: cpu]
  node-read-refs
       [Local memory read accesses. Unit: cpu]
  node-reference
       [Local memory read accesses. Unit: cpu]
  node-refs
       [Local memory read accesses. Unit: cpu]
  node-store
       [Local memory write accesses. Unit: cpu]
  node-store-access
       [Local memory write accesses. Unit: cpu]
  node-store-miss
       [Local memory write misses. Unit: cpu]
  node-store-misses
       [Local memory write misses. Unit: cpu]
  node-store-ops
       [Local memory write accesses. Unit: cpu]
  node-store-reference
       [Local memory write accesses. Unit: cpu]
  node-store-refs
       [Local memory write accesses. Unit: cpu]
  node-stores
       [Local memory write accesses. Unit: cpu]
  node-stores-access
       [Local memory write accesses. Unit: cpu]
  node-stores-miss
       [Local memory write misses. Unit: cpu]
  node-stores-misses
       [Local memory write misses. Unit: cpu]
  node-stores-ops
       [Local memory write accesses. Unit: cpu]
  node-stores-reference
       [Local memory write accesses. Unit: cpu]
  node-stores-refs
       [Local memory write accesses. Unit: cpu]
  node-write
       [Local memory write accesses. Unit: cpu]
  node-write-access
       [Local memory write accesses. Unit: cpu]
  node-write-miss
       [Local memory write misses. Unit: cpu]
  node-write-misses
       [Local memory write misses. Unit: cpu]
  node-write-ops
       [Local memory write accesses. Unit: cpu]
  node-write-reference
       [Local memory write accesses. Unit: cpu]
  node-write-refs
       [Local memory write accesses. Unit: cpu]
```

On a hybrid Intel alderlake system the perf list behavior before is:
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
  bpc
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-load
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-load-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-load-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  bpc-load-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  bpc-load-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-load-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-load-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-loads
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-loads-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-loads-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  bpc-loads-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  bpc-loads-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-loads-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-loads-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  bpc-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  bpc-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-read
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-read-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-read-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  bpc-read-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  bpc-read-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-read-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-read-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpc-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-load
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-load-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-load-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  bpu-load-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  bpu-load-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-load-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-load-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-loads
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-loads-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-loads-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  bpu-loads-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  bpu-loads-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-loads-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-loads-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  bpu-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  bpu-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-read
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-read-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-read-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  bpu-read-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  bpu-read-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-read-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-read-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  bpu-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-load
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-load-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-load-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  branch-load-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  branch-load-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-load-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-load-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-loads
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-loads-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-loads-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  branch-loads-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  branch-loads-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-loads-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-loads-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  branch-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-read
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-read-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-read-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  branch-read-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  branch-read-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-read-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-read-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branch-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-load
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-load-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-load-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  branches-load-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  branches-load-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-load-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-load-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-loads
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-loads-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-loads-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  branches-loads-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  branches-loads-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-loads-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-loads-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  branches-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  branches-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-read
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-read-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-read-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  branches-read-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  branches-read-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-read-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-read-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  branches-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-load
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-load-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-load-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  btb-load-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  btb-load-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-load-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-load-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-loads
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-loads-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-loads-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  btb-loads-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  btb-loads-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-loads-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-loads-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  btb-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  btb-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-read
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-read-access
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-read-miss
       [Branch prediction unit read misses. Unit: cpu_atom]
  btb-read-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  btb-read-ops
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-read-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-read-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-reference
       [Branch prediction unit read accesses. Unit: cpu_atom]
  btb-refs
       [Branch prediction unit read accesses. Unit: cpu_atom]
  d-tlb
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-access
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-load
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-load-access
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-load-miss
       [Data TLB read misses. Unit: cpu_atom]
  d-tlb-load-misses
       [Data TLB read misses. Unit: cpu_atom]
  d-tlb-load-ops
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-load-reference
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-load-refs
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-loads
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-loads-access
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-loads-miss
       [Data TLB read misses. Unit: cpu_atom]
  d-tlb-loads-misses
       [Data TLB read misses. Unit: cpu_atom]
  d-tlb-loads-ops
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-loads-reference
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-loads-refs
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-miss
       [Data TLB read misses. Unit: cpu_atom]
  d-tlb-misses
       [Data TLB read misses. Unit: cpu_atom]
  d-tlb-ops
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-read
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-read-access
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-read-miss
       [Data TLB read misses. Unit: cpu_atom]
  d-tlb-read-misses
       [Data TLB read misses. Unit: cpu_atom]
  d-tlb-read-ops
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-read-reference
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-read-refs
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-reference
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-refs
       [Data TLB read accesses. Unit: cpu_atom]
  d-tlb-store
       [Data TLB write accesses. Unit: cpu_atom]
  d-tlb-store-access
       [Data TLB write accesses. Unit: cpu_atom]
  d-tlb-store-miss
       [Data TLB write misses. Unit: cpu_atom]
  d-tlb-store-misses
       [Data TLB write misses. Unit: cpu_atom]
  d-tlb-store-ops
       [Data TLB write accesses. Unit: cpu_atom]
  d-tlb-store-reference
       [Data TLB write accesses. Unit: cpu_atom]
  d-tlb-store-refs
       [Data TLB write accesses. Unit: cpu_atom]
  d-tlb-stores
       [Data TLB write accesses. Unit: cpu_atom]
  d-tlb-stores-access
       [Data TLB write accesses. Unit: cpu_atom]
  d-tlb-stores-miss
       [Data TLB write misses. Unit: cpu_atom]
  d-tlb-stores-misses
       [Data TLB write misses. Unit: cpu_atom]
  d-tlb-stores-ops
       [Data TLB write accesses. Unit: cpu_atom]
  d-tlb-stores-reference
       [Data TLB write accesses. Unit: cpu_atom]
  d-tlb-stores-refs
       [Data TLB write accesses. Unit: cpu_atom]
  d-tlb-write
       [Data TLB write accesses. Unit: cpu_atom]
  d-tlb-write-access
       [Data TLB write accesses. Unit: cpu_atom]
  d-tlb-write-miss
       [Data TLB write misses. Unit: cpu_atom]
  d-tlb-write-misses
       [Data TLB write misses. Unit: cpu_atom]
  d-tlb-write-ops
       [Data TLB write accesses. Unit: cpu_atom]
  d-tlb-write-reference
       [Data TLB write accesses. Unit: cpu_atom]
  d-tlb-write-refs
       [Data TLB write accesses. Unit: cpu_atom]
  data-tlb
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-access
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-load
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-load-access
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-load-miss
       [Data TLB read misses. Unit: cpu_atom]
  data-tlb-load-misses
       [Data TLB read misses. Unit: cpu_atom]
  data-tlb-load-ops
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-load-reference
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-load-refs
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-loads
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-loads-access
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-loads-miss
       [Data TLB read misses. Unit: cpu_atom]
  data-tlb-loads-misses
       [Data TLB read misses. Unit: cpu_atom]
  data-tlb-loads-ops
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-loads-reference
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-loads-refs
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-miss
       [Data TLB read misses. Unit: cpu_atom]
  data-tlb-misses
       [Data TLB read misses. Unit: cpu_atom]
  data-tlb-ops
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-read
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-read-access
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-read-miss
       [Data TLB read misses. Unit: cpu_atom]
  data-tlb-read-misses
       [Data TLB read misses. Unit: cpu_atom]
  data-tlb-read-ops
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-read-reference
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-read-refs
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-reference
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-refs
       [Data TLB read accesses. Unit: cpu_atom]
  data-tlb-store
       [Data TLB write accesses. Unit: cpu_atom]
  data-tlb-store-access
       [Data TLB write accesses. Unit: cpu_atom]
  data-tlb-store-miss
       [Data TLB write misses. Unit: cpu_atom]
  data-tlb-store-misses
       [Data TLB write misses. Unit: cpu_atom]
  data-tlb-store-ops
       [Data TLB write accesses. Unit: cpu_atom]
  data-tlb-store-reference
       [Data TLB write accesses. Unit: cpu_atom]
  data-tlb-store-refs
       [Data TLB write accesses. Unit: cpu_atom]
  data-tlb-stores
       [Data TLB write accesses. Unit: cpu_atom]
  data-tlb-stores-access
       [Data TLB write accesses. Unit: cpu_atom]
  data-tlb-stores-miss
       [Data TLB write misses. Unit: cpu_atom]
  data-tlb-stores-misses
       [Data TLB write misses. Unit: cpu_atom]
  data-tlb-stores-ops
       [Data TLB write accesses. Unit: cpu_atom]
  data-tlb-stores-reference
       [Data TLB write accesses. Unit: cpu_atom]
  data-tlb-stores-refs
       [Data TLB write accesses. Unit: cpu_atom]
  data-tlb-write
       [Data TLB write accesses. Unit: cpu_atom]
  data-tlb-write-access
       [Data TLB write accesses. Unit: cpu_atom]
  data-tlb-write-miss
       [Data TLB write misses. Unit: cpu_atom]
  data-tlb-write-misses
       [Data TLB write misses. Unit: cpu_atom]
  data-tlb-write-ops
       [Data TLB write accesses. Unit: cpu_atom]
  data-tlb-write-reference
       [Data TLB write accesses. Unit: cpu_atom]
  data-tlb-write-refs
       [Data TLB write accesses. Unit: cpu_atom]
  dtlb
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-access
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-load
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-load-access
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-load-miss
       [Data TLB read misses. Unit: cpu_atom]
  dtlb-load-misses
       [Data TLB read misses. Unit: cpu_atom]
  dtlb-load-ops
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-load-reference
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-load-refs
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-loads
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-loads-access
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-loads-miss
       [Data TLB read misses. Unit: cpu_atom]
  dtlb-loads-misses
       [Data TLB read misses. Unit: cpu_atom]
  dtlb-loads-ops
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-loads-reference
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-loads-refs
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-miss
       [Data TLB read misses. Unit: cpu_atom]
  dtlb-misses
       [Data TLB read misses. Unit: cpu_atom]
  dtlb-ops
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-read
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-read-access
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-read-miss
       [Data TLB read misses. Unit: cpu_atom]
  dtlb-read-misses
       [Data TLB read misses. Unit: cpu_atom]
  dtlb-read-ops
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-read-reference
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-read-refs
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-reference
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-refs
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-store
       [Data TLB write accesses. Unit: cpu_atom]
  dtlb-store-access
       [Data TLB write accesses. Unit: cpu_atom]
  dtlb-store-miss
       [Data TLB write misses. Unit: cpu_atom]
  dtlb-store-misses
       [Data TLB write misses. Unit: cpu_atom]
  dtlb-store-ops
       [Data TLB write accesses. Unit: cpu_atom]
  dtlb-store-reference
       [Data TLB write accesses. Unit: cpu_atom]
  dtlb-store-refs
       [Data TLB write accesses. Unit: cpu_atom]
  dtlb-stores
       [Data TLB write accesses. Unit: cpu_atom]
  dtlb-stores-access
       [Data TLB write accesses. Unit: cpu_atom]
  dtlb-stores-miss
       [Data TLB write misses. Unit: cpu_atom]
  dtlb-stores-misses
       [Data TLB write misses. Unit: cpu_atom]
  dtlb-stores-ops
       [Data TLB write accesses. Unit: cpu_atom]
  dtlb-stores-reference
       [Data TLB write accesses. Unit: cpu_atom]
  dtlb-stores-refs
       [Data TLB write accesses. Unit: cpu_atom]
  dtlb-write
       [Data TLB write accesses. Unit: cpu_atom]
  dtlb-write-access
       [Data TLB write accesses. Unit: cpu_atom]
  dtlb-write-miss
       [Data TLB write misses. Unit: cpu_atom]
  dtlb-write-misses
       [Data TLB write misses. Unit: cpu_atom]
  dtlb-write-ops
       [Data TLB write accesses. Unit: cpu_atom]
  dtlb-write-reference
       [Data TLB write accesses. Unit: cpu_atom]
  dtlb-write-refs
       [Data TLB write accesses. Unit: cpu_atom]
  i-tlb-load-miss
       [Instruction TLB read misses. Unit: cpu_atom]
  i-tlb-load-misses
       [Instruction TLB read misses. Unit: cpu_atom]
  i-tlb-loads-miss
       [Instruction TLB read misses. Unit: cpu_atom]
  i-tlb-loads-misses
       [Instruction TLB read misses. Unit: cpu_atom]
  i-tlb-miss
       [Instruction TLB read misses. Unit: cpu_atom]
  i-tlb-misses
       [Instruction TLB read misses. Unit: cpu_atom]
  i-tlb-read-miss
       [Instruction TLB read misses. Unit: cpu_atom]
  i-tlb-read-misses
       [Instruction TLB read misses. Unit: cpu_atom]
  instruction-tlb-load-miss
       [Instruction TLB read misses. Unit: cpu_atom]
  instruction-tlb-load-misses
       [Instruction TLB read misses. Unit: cpu_atom]
  instruction-tlb-loads-miss
       [Instruction TLB read misses. Unit: cpu_atom]
  instruction-tlb-loads-misses
       [Instruction TLB read misses. Unit: cpu_atom]
  instruction-tlb-miss
       [Instruction TLB read misses. Unit: cpu_atom]
  instruction-tlb-misses
       [Instruction TLB read misses. Unit: cpu_atom]
  instruction-tlb-read-miss
       [Instruction TLB read misses. Unit: cpu_atom]
  instruction-tlb-read-misses
       [Instruction TLB read misses. Unit: cpu_atom]
  itlb-load-miss
       [Instruction TLB read misses. Unit: cpu_atom]
  itlb-load-misses
       [Instruction TLB read misses. Unit: cpu_atom]
  itlb-loads-miss
       [Instruction TLB read misses. Unit: cpu_atom]
  itlb-loads-misses
       [Instruction TLB read misses. Unit: cpu_atom]
  itlb-miss
       [Instruction TLB read misses. Unit: cpu_atom]
  itlb-misses
       [Instruction TLB read misses. Unit: cpu_atom]
  itlb-read-miss
       [Instruction TLB read misses. Unit: cpu_atom]
  itlb-read-misses
       [Instruction TLB read misses. Unit: cpu_atom]
  l1-d
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-access
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-load
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-load-access
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-load-ops
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-load-reference
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-load-refs
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-loads
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-loads-access
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-loads-ops
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-loads-reference
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-loads-refs
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-ops
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-read
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-read-access
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-read-ops
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-read-reference
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-read-refs
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-reference
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-refs
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-d-store
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-d-store-access
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-d-store-ops
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-d-store-reference
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-d-store-refs
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-d-stores
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-d-stores-access
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-d-stores-ops
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-d-stores-reference
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-d-stores-refs
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-d-write
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-d-write-access
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-d-write-ops
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-d-write-reference
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-d-write-refs
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-data
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-access
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-load
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-load-access
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-load-ops
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-load-reference
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-load-refs
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-loads
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-loads-access
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-loads-ops
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-loads-reference
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-loads-refs
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-ops
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-read
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-read-access
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-read-ops
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-read-reference
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-read-refs
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-reference
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-refs
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-data-store
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-data-store-access
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-data-store-ops
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-data-store-reference
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-data-store-refs
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-data-stores
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-data-stores-access
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-data-stores-ops
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-data-stores-reference
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-data-stores-refs
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-data-write
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-data-write-access
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-data-write-ops
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-data-write-reference
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-data-write-refs
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-dcache
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-access
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-load
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-load-access
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-load-ops
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-load-reference
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-load-refs
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-loads
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-loads-access
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-loads-ops
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-loads-reference
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-loads-refs
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-ops
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-read
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-read-access
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-read-ops
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-read-reference
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-read-refs
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-reference
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-refs
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-store
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-dcache-store-access
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-dcache-store-ops
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-dcache-store-reference
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-dcache-store-refs
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-dcache-stores
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-dcache-stores-access
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-dcache-stores-ops
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-dcache-stores-reference
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-dcache-stores-refs
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-dcache-write
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-dcache-write-access
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-dcache-write-ops
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-dcache-write-reference
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-dcache-write-refs
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-i
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-access
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-load
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-load-access
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-load-miss
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-i-load-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-i-load-ops
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-load-reference
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-load-refs
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-loads
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-loads-access
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-loads-miss
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-i-loads-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-i-loads-ops
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-loads-reference
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-loads-refs
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-miss
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-i-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-i-ops
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-read
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-read-access
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-read-miss
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-i-read-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-i-read-ops
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-read-reference
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-read-refs
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-reference
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-i-refs
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-access
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-load
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-load-access
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-load-miss
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-icache-load-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-icache-load-ops
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-load-reference
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-load-refs
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-loads
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-loads-access
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-loads-miss
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-icache-loads-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-icache-loads-ops
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-loads-reference
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-loads-refs
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-miss
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-icache-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-icache-ops
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-read
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-read-access
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-read-miss
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-icache-read-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-icache-read-ops
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-read-reference
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-read-refs
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-reference
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-icache-refs
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-access
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-load
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-load-access
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-load-miss
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-instruction-load-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-instruction-load-ops
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-load-reference
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-load-refs
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-loads
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-loads-access
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-loads-miss
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-instruction-loads-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-instruction-loads-ops
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-loads-reference
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-loads-refs
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-miss
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-instruction-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-instruction-ops
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-read
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-read-access
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-read-miss
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-instruction-read-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-instruction-read-ops
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-read-reference
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-read-refs
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-reference
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1-instruction-refs
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1d
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-access
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-load
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-load-access
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-load-ops
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-load-reference
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-load-refs
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-loads
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-loads-access
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-loads-ops
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-loads-reference
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-loads-refs
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-ops
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-read
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-read-access
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-read-ops
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-read-reference
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-read-refs
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-reference
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-refs
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1d-store
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1d-store-access
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1d-store-ops
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1d-store-reference
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1d-store-refs
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1d-stores
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1d-stores-access
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1d-stores-ops
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1d-stores-reference
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1d-stores-refs
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1d-write
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1d-write-access
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1d-write-ops
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1d-write-reference
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1d-write-refs
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1i
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-access
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-load
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-load-access
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-load-miss
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1i-load-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1i-load-ops
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-load-reference
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-load-refs
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-loads
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-loads-access
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-loads-miss
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1i-loads-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1i-loads-ops
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-loads-reference
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-loads-refs
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-miss
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1i-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1i-ops
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-read
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-read-access
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-read-miss
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1i-read-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1i-read-ops
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-read-reference
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-read-refs
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-reference
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  l1i-refs
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  llc
       [Last level cache read accesses. Unit: cpu_atom]
  llc-access
       [Last level cache read accesses. Unit: cpu_atom]
  llc-load
       [Last level cache read accesses. Unit: cpu_atom]
  llc-load-access
       [Last level cache read accesses. Unit: cpu_atom]
  llc-load-miss
       [Last level cache read misses. Unit: cpu_atom]
  llc-load-misses
       [Last level cache read misses. Unit: cpu_atom]
  llc-load-ops
       [Last level cache read accesses. Unit: cpu_atom]
  llc-load-reference
       [Last level cache read accesses. Unit: cpu_atom]
  llc-load-refs
       [Last level cache read accesses. Unit: cpu_atom]
  llc-loads
       [Last level cache read accesses. Unit: cpu_atom]
  llc-loads-access
       [Last level cache read accesses. Unit: cpu_atom]
  llc-loads-miss
       [Last level cache read misses. Unit: cpu_atom]
  llc-loads-misses
       [Last level cache read misses. Unit: cpu_atom]
  llc-loads-ops
       [Last level cache read accesses. Unit: cpu_atom]
  llc-loads-reference
       [Last level cache read accesses. Unit: cpu_atom]
  llc-loads-refs
       [Last level cache read accesses. Unit: cpu_atom]
  llc-miss
       [Last level cache read misses. Unit: cpu_atom]
  llc-misses
       [Last level cache read misses. Unit: cpu_atom]
  llc-ops
       [Last level cache read accesses. Unit: cpu_atom]
  llc-read
       [Last level cache read accesses. Unit: cpu_atom]
  llc-read-access
       [Last level cache read accesses. Unit: cpu_atom]
  llc-read-miss
       [Last level cache read misses. Unit: cpu_atom]
  llc-read-misses
       [Last level cache read misses. Unit: cpu_atom]
  llc-read-ops
       [Last level cache read accesses. Unit: cpu_atom]
  llc-read-reference
       [Last level cache read accesses. Unit: cpu_atom]
  llc-read-refs
       [Last level cache read accesses. Unit: cpu_atom]
  llc-reference
       [Last level cache read accesses. Unit: cpu_atom]
  llc-refs
       [Last level cache read accesses. Unit: cpu_atom]
  llc-store
       [Last level cache write accesses. Unit: cpu_atom]
  llc-store-access
       [Last level cache write accesses. Unit: cpu_atom]
  llc-store-miss
       [Last level cache write misses. Unit: cpu_atom]
  llc-store-misses
       [Last level cache write misses. Unit: cpu_atom]
  llc-store-ops
       [Last level cache write accesses. Unit: cpu_atom]
  llc-store-reference
       [Last level cache write accesses. Unit: cpu_atom]
  llc-store-refs
       [Last level cache write accesses. Unit: cpu_atom]
  llc-stores
       [Last level cache write accesses. Unit: cpu_atom]
  llc-stores-access
       [Last level cache write accesses. Unit: cpu_atom]
  llc-stores-miss
       [Last level cache write misses. Unit: cpu_atom]
  llc-stores-misses
       [Last level cache write misses. Unit: cpu_atom]
  llc-stores-ops
       [Last level cache write accesses. Unit: cpu_atom]
  llc-stores-reference
       [Last level cache write accesses. Unit: cpu_atom]
  llc-stores-refs
       [Last level cache write accesses. Unit: cpu_atom]
  llc-write
       [Last level cache write accesses. Unit: cpu_atom]
  llc-write-access
       [Last level cache write accesses. Unit: cpu_atom]
  llc-write-miss
       [Last level cache write misses. Unit: cpu_atom]
  llc-write-misses
       [Last level cache write misses. Unit: cpu_atom]
  llc-write-ops
       [Last level cache write accesses. Unit: cpu_atom]
  llc-write-reference
       [Last level cache write accesses. Unit: cpu_atom]
  llc-write-refs
       [Last level cache write accesses. Unit: cpu_atom]
  bpc
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-load
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-load-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-load-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  bpc-load-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  bpc-load-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-load-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-load-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-loads
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-loads-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-loads-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  bpc-loads-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  bpc-loads-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-loads-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-loads-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  bpc-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  bpc-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-read
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-read-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-read-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  bpc-read-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  bpc-read-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-read-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-read-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpc-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-load
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-load-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-load-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  bpu-load-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  bpu-load-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-load-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-load-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-loads
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-loads-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-loads-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  bpu-loads-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  bpu-loads-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-loads-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-loads-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  bpu-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  bpu-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-read
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-read-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-read-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  bpu-read-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  bpu-read-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-read-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-read-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  bpu-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-load
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-load-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-load-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  branch-load-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  branch-load-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-load-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-load-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-loads
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-loads-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-loads-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  branch-loads-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  branch-loads-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-loads-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-loads-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  branch-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-read
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-read-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-read-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  branch-read-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  branch-read-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-read-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-read-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  branch-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-load
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-load-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-load-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  branches-load-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  branches-load-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-load-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-load-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-loads
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-loads-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-loads-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  branches-loads-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  branches-loads-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-loads-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-loads-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  branches-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  branches-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-read
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-read-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-read-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  branches-read-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  branches-read-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-read-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-read-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  branches-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-load
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-load-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-load-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  btb-load-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  btb-load-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-load-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-load-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-loads
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-loads-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-loads-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  btb-loads-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  btb-loads-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-loads-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-loads-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  btb-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  btb-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-read
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-read-access
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-read-miss
       [Branch prediction unit read misses. Unit: cpu_core]
  btb-read-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  btb-read-ops
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-read-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-read-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-reference
       [Branch prediction unit read accesses. Unit: cpu_core]
  btb-refs
       [Branch prediction unit read accesses. Unit: cpu_core]
  d-tlb
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-access
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-load
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-load-access
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-load-miss
       [Data TLB read misses. Unit: cpu_core]
  d-tlb-load-misses
       [Data TLB read misses. Unit: cpu_core]
  d-tlb-load-ops
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-load-reference
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-load-refs
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-loads
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-loads-access
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-loads-miss
       [Data TLB read misses. Unit: cpu_core]
  d-tlb-loads-misses
       [Data TLB read misses. Unit: cpu_core]
  d-tlb-loads-ops
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-loads-reference
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-loads-refs
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-miss
       [Data TLB read misses. Unit: cpu_core]
  d-tlb-misses
       [Data TLB read misses. Unit: cpu_core]
  d-tlb-ops
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-read
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-read-access
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-read-miss
       [Data TLB read misses. Unit: cpu_core]
  d-tlb-read-misses
       [Data TLB read misses. Unit: cpu_core]
  d-tlb-read-ops
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-read-reference
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-read-refs
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-reference
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-refs
       [Data TLB read accesses. Unit: cpu_core]
  d-tlb-store
       [Data TLB write accesses. Unit: cpu_core]
  d-tlb-store-access
       [Data TLB write accesses. Unit: cpu_core]
  d-tlb-store-miss
       [Data TLB write misses. Unit: cpu_core]
  d-tlb-store-misses
       [Data TLB write misses. Unit: cpu_core]
  d-tlb-store-ops
       [Data TLB write accesses. Unit: cpu_core]
  d-tlb-store-reference
       [Data TLB write accesses. Unit: cpu_core]
  d-tlb-store-refs
       [Data TLB write accesses. Unit: cpu_core]
  d-tlb-stores
       [Data TLB write accesses. Unit: cpu_core]
  d-tlb-stores-access
       [Data TLB write accesses. Unit: cpu_core]
  d-tlb-stores-miss
       [Data TLB write misses. Unit: cpu_core]
  d-tlb-stores-misses
       [Data TLB write misses. Unit: cpu_core]
  d-tlb-stores-ops
       [Data TLB write accesses. Unit: cpu_core]
  d-tlb-stores-reference
       [Data TLB write accesses. Unit: cpu_core]
  d-tlb-stores-refs
       [Data TLB write accesses. Unit: cpu_core]
  d-tlb-write
       [Data TLB write accesses. Unit: cpu_core]
  d-tlb-write-access
       [Data TLB write accesses. Unit: cpu_core]
  d-tlb-write-miss
       [Data TLB write misses. Unit: cpu_core]
  d-tlb-write-misses
       [Data TLB write misses. Unit: cpu_core]
  d-tlb-write-ops
       [Data TLB write accesses. Unit: cpu_core]
  d-tlb-write-reference
       [Data TLB write accesses. Unit: cpu_core]
  d-tlb-write-refs
       [Data TLB write accesses. Unit: cpu_core]
  data-tlb
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-access
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-load
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-load-access
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-load-miss
       [Data TLB read misses. Unit: cpu_core]
  data-tlb-load-misses
       [Data TLB read misses. Unit: cpu_core]
  data-tlb-load-ops
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-load-reference
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-load-refs
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-loads
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-loads-access
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-loads-miss
       [Data TLB read misses. Unit: cpu_core]
  data-tlb-loads-misses
       [Data TLB read misses. Unit: cpu_core]
  data-tlb-loads-ops
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-loads-reference
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-loads-refs
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-miss
       [Data TLB read misses. Unit: cpu_core]
  data-tlb-misses
       [Data TLB read misses. Unit: cpu_core]
  data-tlb-ops
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-read
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-read-access
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-read-miss
       [Data TLB read misses. Unit: cpu_core]
  data-tlb-read-misses
       [Data TLB read misses. Unit: cpu_core]
  data-tlb-read-ops
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-read-reference
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-read-refs
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-reference
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-refs
       [Data TLB read accesses. Unit: cpu_core]
  data-tlb-store
       [Data TLB write accesses. Unit: cpu_core]
  data-tlb-store-access
       [Data TLB write accesses. Unit: cpu_core]
  data-tlb-store-miss
       [Data TLB write misses. Unit: cpu_core]
  data-tlb-store-misses
       [Data TLB write misses. Unit: cpu_core]
  data-tlb-store-ops
       [Data TLB write accesses. Unit: cpu_core]
  data-tlb-store-reference
       [Data TLB write accesses. Unit: cpu_core]
  data-tlb-store-refs
       [Data TLB write accesses. Unit: cpu_core]
  data-tlb-stores
       [Data TLB write accesses. Unit: cpu_core]
  data-tlb-stores-access
       [Data TLB write accesses. Unit: cpu_core]
  data-tlb-stores-miss
       [Data TLB write misses. Unit: cpu_core]
  data-tlb-stores-misses
       [Data TLB write misses. Unit: cpu_core]
  data-tlb-stores-ops
       [Data TLB write accesses. Unit: cpu_core]
  data-tlb-stores-reference
       [Data TLB write accesses. Unit: cpu_core]
  data-tlb-stores-refs
       [Data TLB write accesses. Unit: cpu_core]
  data-tlb-write
       [Data TLB write accesses. Unit: cpu_core]
  data-tlb-write-access
       [Data TLB write accesses. Unit: cpu_core]
  data-tlb-write-miss
       [Data TLB write misses. Unit: cpu_core]
  data-tlb-write-misses
       [Data TLB write misses. Unit: cpu_core]
  data-tlb-write-ops
       [Data TLB write accesses. Unit: cpu_core]
  data-tlb-write-reference
       [Data TLB write accesses. Unit: cpu_core]
  data-tlb-write-refs
       [Data TLB write accesses. Unit: cpu_core]
  dtlb
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-access
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-load
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-load-access
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-load-miss
       [Data TLB read misses. Unit: cpu_core]
  dtlb-load-misses
       [Data TLB read misses. Unit: cpu_core]
  dtlb-load-ops
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-load-reference
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-load-refs
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-loads
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-loads-access
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-loads-miss
       [Data TLB read misses. Unit: cpu_core]
  dtlb-loads-misses
       [Data TLB read misses. Unit: cpu_core]
  dtlb-loads-ops
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-loads-reference
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-loads-refs
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-miss
       [Data TLB read misses. Unit: cpu_core]
  dtlb-misses
       [Data TLB read misses. Unit: cpu_core]
  dtlb-ops
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-read
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-read-access
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-read-miss
       [Data TLB read misses. Unit: cpu_core]
  dtlb-read-misses
       [Data TLB read misses. Unit: cpu_core]
  dtlb-read-ops
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-read-reference
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-read-refs
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-reference
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-refs
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-store
       [Data TLB write accesses. Unit: cpu_core]
  dtlb-store-access
       [Data TLB write accesses. Unit: cpu_core]
  dtlb-store-miss
       [Data TLB write misses. Unit: cpu_core]
  dtlb-store-misses
       [Data TLB write misses. Unit: cpu_core]
  dtlb-store-ops
       [Data TLB write accesses. Unit: cpu_core]
  dtlb-store-reference
       [Data TLB write accesses. Unit: cpu_core]
  dtlb-store-refs
       [Data TLB write accesses. Unit: cpu_core]
  dtlb-stores
       [Data TLB write accesses. Unit: cpu_core]
  dtlb-stores-access
       [Data TLB write accesses. Unit: cpu_core]
  dtlb-stores-miss
       [Data TLB write misses. Unit: cpu_core]
  dtlb-stores-misses
       [Data TLB write misses. Unit: cpu_core]
  dtlb-stores-ops
       [Data TLB write accesses. Unit: cpu_core]
  dtlb-stores-reference
       [Data TLB write accesses. Unit: cpu_core]
  dtlb-stores-refs
       [Data TLB write accesses. Unit: cpu_core]
  dtlb-write
       [Data TLB write accesses. Unit: cpu_core]
  dtlb-write-access
       [Data TLB write accesses. Unit: cpu_core]
  dtlb-write-miss
       [Data TLB write misses. Unit: cpu_core]
  dtlb-write-misses
       [Data TLB write misses. Unit: cpu_core]
  dtlb-write-ops
       [Data TLB write accesses. Unit: cpu_core]
  dtlb-write-reference
       [Data TLB write accesses. Unit: cpu_core]
  dtlb-write-refs
       [Data TLB write accesses. Unit: cpu_core]
  i-tlb-load-miss
       [Instruction TLB read misses. Unit: cpu_core]
  i-tlb-load-misses
       [Instruction TLB read misses. Unit: cpu_core]
  i-tlb-loads-miss
       [Instruction TLB read misses. Unit: cpu_core]
  i-tlb-loads-misses
       [Instruction TLB read misses. Unit: cpu_core]
  i-tlb-miss
       [Instruction TLB read misses. Unit: cpu_core]
  i-tlb-misses
       [Instruction TLB read misses. Unit: cpu_core]
  i-tlb-read-miss
       [Instruction TLB read misses. Unit: cpu_core]
  i-tlb-read-misses
       [Instruction TLB read misses. Unit: cpu_core]
  instruction-tlb-load-miss
       [Instruction TLB read misses. Unit: cpu_core]
  instruction-tlb-load-misses
       [Instruction TLB read misses. Unit: cpu_core]
  instruction-tlb-loads-miss
       [Instruction TLB read misses. Unit: cpu_core]
  instruction-tlb-loads-misses
       [Instruction TLB read misses. Unit: cpu_core]
  instruction-tlb-miss
       [Instruction TLB read misses. Unit: cpu_core]
  instruction-tlb-misses
       [Instruction TLB read misses. Unit: cpu_core]
  instruction-tlb-read-miss
       [Instruction TLB read misses. Unit: cpu_core]
  instruction-tlb-read-misses
       [Instruction TLB read misses. Unit: cpu_core]
  itlb-load-miss
       [Instruction TLB read misses. Unit: cpu_core]
  itlb-load-misses
       [Instruction TLB read misses. Unit: cpu_core]
  itlb-loads-miss
       [Instruction TLB read misses. Unit: cpu_core]
  itlb-loads-misses
       [Instruction TLB read misses. Unit: cpu_core]
  itlb-miss
       [Instruction TLB read misses. Unit: cpu_core]
  itlb-misses
       [Instruction TLB read misses. Unit: cpu_core]
  itlb-read-miss
       [Instruction TLB read misses. Unit: cpu_core]
  itlb-read-misses
       [Instruction TLB read misses. Unit: cpu_core]
  l1-d
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-access
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-load
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-load-access
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-load-miss
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-d-load-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-d-load-ops
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-load-reference
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-load-refs
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-loads
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-loads-access
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-loads-miss
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-d-loads-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-d-loads-ops
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-loads-reference
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-loads-refs
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-miss
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-d-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-d-ops
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-read
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-read-access
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-read-miss
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-d-read-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-d-read-ops
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-read-reference
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-read-refs
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-reference
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-refs
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-d-store
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-d-store-access
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-d-store-ops
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-d-store-reference
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-d-store-refs
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-d-stores
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-d-stores-access
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-d-stores-ops
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-d-stores-reference
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-d-stores-refs
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-d-write
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-d-write-access
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-d-write-ops
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-d-write-reference
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-d-write-refs
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-data
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-access
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-load
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-load-access
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-load-miss
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-data-load-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-data-load-ops
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-load-reference
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-load-refs
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-loads
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-loads-access
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-loads-miss
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-data-loads-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-data-loads-ops
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-loads-reference
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-loads-refs
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-miss
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-data-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-data-ops
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-read
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-read-access
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-read-miss
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-data-read-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-data-read-ops
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-read-reference
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-read-refs
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-reference
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-refs
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-data-store
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-data-store-access
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-data-store-ops
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-data-store-reference
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-data-store-refs
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-data-stores
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-data-stores-access
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-data-stores-ops
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-data-stores-reference
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-data-stores-refs
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-data-write
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-data-write-access
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-data-write-ops
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-data-write-reference
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-data-write-refs
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-dcache
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-access
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-load
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-load-access
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-load-miss
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-dcache-load-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-dcache-load-ops
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-load-reference
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-load-refs
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-loads
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-loads-access
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-loads-miss
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-dcache-loads-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-dcache-loads-ops
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-loads-reference
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-loads-refs
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-miss
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-dcache-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-dcache-ops
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-read
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-read-access
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-read-miss
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-dcache-read-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-dcache-read-ops
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-read-reference
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-read-refs
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-reference
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-refs
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-store
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-dcache-store-access
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-dcache-store-ops
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-dcache-store-reference
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-dcache-store-refs
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-dcache-stores
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-dcache-stores-access
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-dcache-stores-ops
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-dcache-stores-reference
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-dcache-stores-refs
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-dcache-write
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-dcache-write-access
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-dcache-write-ops
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-dcache-write-reference
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-dcache-write-refs
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-i-load-miss
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-i-load-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-i-loads-miss
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-i-loads-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-i-miss
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-i-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-i-read-miss
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-i-read-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-icache-load-miss
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-icache-load-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-icache-loads-miss
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-icache-loads-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-icache-miss
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-icache-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-icache-read-miss
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-icache-read-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-instruction-load-miss
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-instruction-load-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-instruction-loads-miss
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-instruction-loads-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-instruction-miss
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-instruction-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-instruction-read-miss
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1-instruction-read-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1d
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-access
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-load
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-load-access
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-load-miss
       [Level 1 data cache read misses. Unit: cpu_core]
  l1d-load-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1d-load-ops
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-load-reference
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-load-refs
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-loads
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-loads-access
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-loads-miss
       [Level 1 data cache read misses. Unit: cpu_core]
  l1d-loads-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1d-loads-ops
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-loads-reference
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-loads-refs
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-miss
       [Level 1 data cache read misses. Unit: cpu_core]
  l1d-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1d-ops
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-read
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-read-access
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-read-miss
       [Level 1 data cache read misses. Unit: cpu_core]
  l1d-read-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1d-read-ops
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-read-reference
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-read-refs
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-reference
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-refs
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1d-store
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1d-store-access
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1d-store-ops
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1d-store-reference
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1d-store-refs
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1d-stores
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1d-stores-access
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1d-stores-ops
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1d-stores-reference
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1d-stores-refs
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1d-write
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1d-write-access
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1d-write-ops
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1d-write-reference
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1d-write-refs
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1i-load-miss
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1i-load-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1i-loads-miss
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1i-loads-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1i-miss
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1i-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1i-read-miss
       [Level 1 instruction cache read misses. Unit: cpu_core]
  l1i-read-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  llc
       [Last level cache read accesses. Unit: cpu_core]
  llc-access
       [Last level cache read accesses. Unit: cpu_core]
  llc-load
       [Last level cache read accesses. Unit: cpu_core]
  llc-load-access
       [Last level cache read accesses. Unit: cpu_core]
  llc-load-miss
       [Last level cache read misses. Unit: cpu_core]
  llc-load-misses
       [Last level cache read misses. Unit: cpu_core]
  llc-load-ops
       [Last level cache read accesses. Unit: cpu_core]
  llc-load-reference
       [Last level cache read accesses. Unit: cpu_core]
  llc-load-refs
       [Last level cache read accesses. Unit: cpu_core]
  llc-loads
       [Last level cache read accesses. Unit: cpu_core]
  llc-loads-access
       [Last level cache read accesses. Unit: cpu_core]
  llc-loads-miss
       [Last level cache read misses. Unit: cpu_core]
  llc-loads-misses
       [Last level cache read misses. Unit: cpu_core]
  llc-loads-ops
       [Last level cache read accesses. Unit: cpu_core]
  llc-loads-reference
       [Last level cache read accesses. Unit: cpu_core]
  llc-loads-refs
       [Last level cache read accesses. Unit: cpu_core]
  llc-miss
       [Last level cache read misses. Unit: cpu_core]
  llc-misses
       [Last level cache read misses. Unit: cpu_core]
  llc-ops
       [Last level cache read accesses. Unit: cpu_core]
  llc-read
       [Last level cache read accesses. Unit: cpu_core]
  llc-read-access
       [Last level cache read accesses. Unit: cpu_core]
  llc-read-miss
       [Last level cache read misses. Unit: cpu_core]
  llc-read-misses
       [Last level cache read misses. Unit: cpu_core]
  llc-read-ops
       [Last level cache read accesses. Unit: cpu_core]
  llc-read-reference
       [Last level cache read accesses. Unit: cpu_core]
  llc-read-refs
       [Last level cache read accesses. Unit: cpu_core]
  llc-reference
       [Last level cache read accesses. Unit: cpu_core]
  llc-refs
       [Last level cache read accesses. Unit: cpu_core]
  llc-store
       [Last level cache write accesses. Unit: cpu_core]
  llc-store-access
       [Last level cache write accesses. Unit: cpu_core]
  llc-store-miss
       [Last level cache write misses. Unit: cpu_core]
  llc-store-misses
       [Last level cache write misses. Unit: cpu_core]
  llc-store-ops
       [Last level cache write accesses. Unit: cpu_core]
  llc-store-reference
       [Last level cache write accesses. Unit: cpu_core]
  llc-store-refs
       [Last level cache write accesses. Unit: cpu_core]
  llc-stores
       [Last level cache write accesses. Unit: cpu_core]
  llc-stores-access
       [Last level cache write accesses. Unit: cpu_core]
  llc-stores-miss
       [Last level cache write misses. Unit: cpu_core]
  llc-stores-misses
       [Last level cache write misses. Unit: cpu_core]
  llc-stores-ops
       [Last level cache write accesses. Unit: cpu_core]
  llc-stores-reference
       [Last level cache write accesses. Unit: cpu_core]
  llc-stores-refs
       [Last level cache write accesses. Unit: cpu_core]
  llc-write
       [Last level cache write accesses. Unit: cpu_core]
  llc-write-access
       [Last level cache write accesses. Unit: cpu_core]
  llc-write-miss
       [Last level cache write misses. Unit: cpu_core]
  llc-write-misses
       [Last level cache write misses. Unit: cpu_core]
  llc-write-ops
       [Last level cache write accesses. Unit: cpu_core]
  llc-write-reference
       [Last level cache write accesses. Unit: cpu_core]
  llc-write-refs
       [Last level cache write accesses. Unit: cpu_core]
  node
       [Local memory read accesses. Unit: cpu_core]
  node-access
       [Local memory read accesses. Unit: cpu_core]
  node-load
       [Local memory read accesses. Unit: cpu_core]
  node-load-access
       [Local memory read accesses. Unit: cpu_core]
  node-load-miss
       [Local memory read misses. Unit: cpu_core]
  node-load-misses
       [Local memory read misses. Unit: cpu_core]
  node-load-ops
       [Local memory read accesses. Unit: cpu_core]
  node-load-reference
       [Local memory read accesses. Unit: cpu_core]
  node-load-refs
       [Local memory read accesses. Unit: cpu_core]
  node-loads
       [Local memory read accesses. Unit: cpu_core]
  node-loads-access
       [Local memory read accesses. Unit: cpu_core]
  node-loads-miss
       [Local memory read misses. Unit: cpu_core]
  node-loads-misses
       [Local memory read misses. Unit: cpu_core]
  node-loads-ops
       [Local memory read accesses. Unit: cpu_core]
  node-loads-reference
       [Local memory read accesses. Unit: cpu_core]
  node-loads-refs
       [Local memory read accesses. Unit: cpu_core]
  node-miss
       [Local memory read misses. Unit: cpu_core]
  node-misses
       [Local memory read misses. Unit: cpu_core]
  node-ops
       [Local memory read accesses. Unit: cpu_core]
  node-read
       [Local memory read accesses. Unit: cpu_core]
  node-read-access
       [Local memory read accesses. Unit: cpu_core]
  node-read-miss
       [Local memory read misses. Unit: cpu_core]
  node-read-misses
       [Local memory read misses. Unit: cpu_core]
  node-read-ops
       [Local memory read accesses. Unit: cpu_core]
  node-read-reference
       [Local memory read accesses. Unit: cpu_core]
  node-read-refs
       [Local memory read accesses. Unit: cpu_core]
  node-reference
       [Local memory read accesses. Unit: cpu_core]
  node-refs
       [Local memory read accesses. Unit: cpu_core]
```

v2: Additional details to the cover letter. Credit to Vince Weaver
    added to the commit message for the event details. Additional
    patches to clean up perf_pmu new_alias by removing an unused term
    scanner argument and avoid stdio usage.

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
 tools/perf/pmu-events/make_legacy_cache.py    |  131 +
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
 21 files changed, 3332 insertions(+), 770 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/legacy-hardware.json
 create mode 100755 tools/perf/pmu-events/make_legacy_cache.py

-- 
2.51.0.268.g9569e192d0-goog


