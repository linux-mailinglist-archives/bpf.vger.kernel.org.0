Return-Path: <bpf+bounces-66787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D44BB393F5
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 08:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D24E04E059A
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 06:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4384827B35A;
	Thu, 28 Aug 2025 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UzqoFQ6k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832ED1F3B96
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363359; cv=none; b=Ss0RD5YYF5TCoRq8MDdhjIUYEH1JsUAbGX+yO7d99Rawm3j6e6ijpx9Nvpx61IZ1bcUEr25JKNehIiFhrGINO0IW5Uuhbca9Nn88Ed3WuVhMW3J54vTf9vU1KtvTbzn0MUh1368n/TB8PJpkvIqRQjSzJi4HjloIDrPdL+Tkvv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363359; c=relaxed/simple;
	bh=t1M+f2xRnS8zztJzavA/0ed9pYjRbVpNZN4/vCSwL3g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=FOn3hwNsBaAV+pwValXtB4X/YgJuc4dCZ1wDdetb2FD6a8U/DCDh0152VNI55m8YbxasB7NcaF33KVBaV46qwUiJ6Tpp27jDwz399FWhj/DBChMHxV6wMJA0UDdke3wW/3B1rbilg1GKbmMUkVIq0koMCIgNfsRYK2tgwztxDuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UzqoFQ6k; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b49de40e845so524505a12.1
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 23:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756363355; x=1756968155; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HmQ98ikckj0X+Nh+EPf1MzU7pWhsDlhpKkFUCFW/Wko=;
        b=UzqoFQ6k1i6IT6Jqhb9C1ljNCRAjloXiybXSQGLNnf8qE9TK9zZxHXGer5B+7z1/Eo
         U/4t48K7duuTR57W7qlTtxKqZQ7+UPZ4BJSlSRZ5QdGGiI7cTjl1Tzapy6y01qow3RJD
         24ouKiKD6RYJfGWx9586tmTWG1wpjljKZtCZw0X4wLtt6YnNyzkPJvbSwy9/hb83w+aL
         n+9HGhhO0msbRAipMqp70V1e9Eo+wHZpA38+HQyQPDQEzQuZSW+VTc+fm2Y4i2CDn2pH
         twgm2+XTm7SACyxVwXHNRvl0dzNqbamvxAVpglUVhoUuNBbbm8tvL9P6nii4jjoe9YCL
         +pYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363355; x=1756968155;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmQ98ikckj0X+Nh+EPf1MzU7pWhsDlhpKkFUCFW/Wko=;
        b=G/pBJHukLvZYByTwEdrQWU2eM5vPEF7Pz4rXrzS4V0eMxNi2PSxajsETruhPJNRwm2
         o/0gRJ40ky8I/OVRjpWfT/SP4NGxG3hxKDjNeJO3jQj3HAZpgC2Kj46NFMocnMlD4ivW
         rgDdQ3unldUqZ01g7/zzONfeVQ3OKN5L/665jgm6UeGZcCRClsOc7O1JqDRd4OLbQIxj
         4D/uijODhTVYEybwv11yvNW1cLU2dFaXRiAVH/EBWKuj7dEg4KDqz+2AQO4MrhpZG4TK
         Z5cMurQMOTp4AiekvC4UC2JaAhEXJnMVSBtGfs8cwA+sZI/SvGe7+8igLqTXLfedTE5U
         5ocg==
X-Forwarded-Encrypted: i=1; AJvYcCVwJ3oL4OVIkQRX0eApD1LQObU8fuUpLnngo0llZZZI1a7OhZ3CaYAxuBOyoz43g5CoZz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmynCwW49s06uuki2unpeupj8LuBmkNoOotyiKCahkVspNGmjI
	Uil522b2A30kFa9mglhIvjNIzey8j983b7WFdPLhMIW3PJYaY2CctW9H9kcoKSJlwzgqM97PWCz
	ZlxJSqtMn4Q==
X-Google-Smtp-Source: AGHT+IEDiR8z9X43uwtAZR4ePaK3XYkBfqFQFbKfC0/guT06VjZzb6RtcQSTHywLjTn1v1+inR4rooFCxkI9
X-Received: from plkq6.prod.google.com ([2002:a17:902:edc6:b0:240:1f2a:423f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:943:b0:244:6c39:3361
 with SMTP id d9443c01a7336-2462ef8aeb1mr275023105ad.44.1756363354865; Wed, 27
 Aug 2025 23:42:34 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:42:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828064231.1762997-1-irogers@google.com>
Subject: [PATCH v1 00/13] Legacy hardware/cache events as json
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
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Mirroring similar work for software events in commit 6e9fa4131abb
("perf parse-events: Remove non-json software events"). These changes
migrate the legacy hardware and cache events to json.  With no hard
coded legacy hardware or cache events the wild card, case
insensitivity, etc. is consistent for events. This does, however, mean
events like cycles will wild card against all PMUs. A change does the
same was originally posted and merged from:
https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
and reverted by Linus in commit 4f1b067359ac ("Revert "perf
parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
his dislike for the cycles behavior on ARM. Earlier patches in this
series make perf record event opening failures non-fatal and hide the
cycles event's failure to open on ARM in perf record, so it is
expected the behavior will now be transparent in perf record on
ARM. perf stat with a cycles event will wildcard open the event on all
PMUs.

The change to support legacy events with PMUs was done to clean up
Intel's hybrid PMU implementation.  Having sysfs/json events with
increased priority to legacy was requested by Mark Rutland
 <mark.rutland@arm.com> to fix Apple-M PMU issues wrt broken legacy
events on that PMU. It was requested that RISC-V be able to add events
to the perf tool json so the PMU driver didn't need to map legacy
events to config encodings:
https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/

A previous series of patches decreasing legacy hardware event
priorities was posted in:
https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.com/
Namhyung Kim <namhyung@kernel.org> mentioned that hardware and
software events can be implemented similarly:
https://lore.kernel.org/lkml/aIJmJns2lopxf3EK@google.com/
and this patch series achieves this.

The perf list behavior before is:
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

Ian Rogers (13):
  perf parse-events: Fix legacy cache events if event is duplicated in a
    PMU
  perf perf_api_probe: Avoid scanning all PMUs, try software PMU first
  perf record: Skip don't fail for events that don't open
  perf jevents: Support copying the source json files to OUTPUT
  perf pmu: Don't eagerly parse event terms
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
 tools/perf/builtin-list.c                     |   34 +-
 tools/perf/builtin-record.c                   |   89 +-
 tools/perf/pmu-events/Build                   |   24 +-
 .../arch/common/common/legacy-hardware.json   |   72 +
 tools/perf/pmu-events/empty-pmu-events.c      | 2763 ++++++++++++++++-
 tools/perf/pmu-events/jevents.py              |   24 +
 tools/perf/pmu-events/make_legacy_cache.py    |  131 +
 tools/perf/pmu-events/pmu-events.h            |    1 +
 tools/perf/tests/pmu-events.c                 |   24 +-
 tools/perf/util/parse-events.c                |  265 +-
 tools/perf/util/parse-events.h                |   13 +-
 tools/perf/util/parse-events.l                |   54 +-
 tools/perf/util/parse-events.y                |  114 +-
 tools/perf/util/perf_api_probe.c              |   27 +-
 tools/perf/util/pmu.c                         |  282 +-
 tools/perf/util/print-events.c                |  112 -
 tools/perf/util/print-events.h                |    4 -
 18 files changed, 3313 insertions(+), 741 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/legacy-hardware.json
 create mode 100755 tools/perf/pmu-events/make_legacy_cache.py

-- 
2.51.0.268.g9569e192d0-goog


