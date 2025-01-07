Return-Path: <bpf+bounces-48147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23359A048EC
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 19:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D6EF7A2460
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 18:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B509197A7A;
	Tue,  7 Jan 2025 18:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rQL3PEL5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9716F1993B9
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273358; cv=none; b=WM4v3OExvfi9K62IXTLW7DKhaLV5pszjcJ1OmuLC+fL7YCPMqG6aOVwPircILeXpiGo7jwZpT6+AU/AgWqcel0g91YZ22TJzizftsImwqpuZc89eSVaCRpcU8cNr4nJzGdz0ybNqd6Bxc7YrjAUZlb9r6C6CO0pXTW/jZ5SWkEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273358; c=relaxed/simple;
	bh=ncjPWjJ0UkY+9Jfy37kIcl4YJmFNEUvpjBRkTa5Uy9E=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Xkgp5ClDb7X+hoY3/CJPct8lJvHBAzs8I3M1qvDsKbTxD+zYrVnQ3bDcYR2gPnriKnqvnEl9xiPwqJd3qa9otzIUCq9AlmL/n6QVv8Ea0wIRHzgRKtWFVa7pOLZyD/fdkDVO6XqgH6iUkWEqhjQpL5g3qIGyX9FgbpVWkmgffD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rQL3PEL5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e450e8637cfso35274677276.3
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 10:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736273355; x=1736878155; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U8mIUVTTpSbSmAPF4S8EmoUYXCZWtaq1PxOIH8m4l+Q=;
        b=rQL3PEL5o9FeNs+CZIvN0+O5PGpc77zK6zp90NlNqoIJG8dkWVZNKFTONPqZhucQfH
         3Jq5TWGgdNH0v3EhXoxHU9cDZO+gQMB5Ec5qmS8/zd84OyH9q/J8+JpRkd23WUMmHDpv
         /PIjrsNSQJwp1HvgNNhCrMYQgqMj9YFWcy2sRGmDQd4Pk5scMm54myc241RqN5JF9yvt
         MdaZlfo98aSJzCFy7TR9QRu7pVeK4ou1nI3kV1ZeR65G6Hd80FvzmnDnrlqz2u1WfDM9
         aKGOc3/D1ric2E4jp8+PL8a1j5Y5THBBtTQjW1rvOmlJCu9z0jpx8d+SF3QzBtsCfgh9
         1ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736273355; x=1736878155;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8mIUVTTpSbSmAPF4S8EmoUYXCZWtaq1PxOIH8m4l+Q=;
        b=Lj5oOeesCNYbnWiWBfIiN1dujCPnzsxIDnUQRPIQDxSgaSDIsX6bViDExKcflPZVYQ
         pKJaWjyvv5I/Wzyzs5c9FzInWOp2wnmFbJESTpLb4mta341BOmImPKkxWPCgQ4Q3XLdb
         19ThNhQNAu1V/EQaqJnUxTMq9Y9NADH7U0L+LjuSUMXOEs1QpO4CSTPYYoDgxJLCW5MV
         IDRTAjNZOX9xAmLJhG1y8PiPK6FZ8YWGO1ivuKYpQ2ukAqDa315CToXGGz9PHuODGkCu
         88DvvzekvAIvldN6XO30zt5Z+BpOREskNKArYHsH3DrGd00W9m8XuhiF62rBsBw96soY
         Y9qw==
X-Forwarded-Encrypted: i=1; AJvYcCW4zJe6OVMxUdriqx2p7MxQXcY4GFbOb56xeSwW066FesaId/qJpQ257hiJq9krlxmn1iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2MXX8TG+i89zup3xLykrNoN4z3eiBmewPtZS0HXez/9G18miU
	7xj0CjhABDevKtv/fPVw5B5krIOSOdRS8sWasGhfWzmRU//S1ZQYUueYRFeH5JVo5LfMiYWvPHO
	17fivPQ==
X-Google-Smtp-Source: AGHT+IGTSKbFoxT3+VhfV/xITto4lQke3szQ1hf5EHpv8Sza0YPf3tzpfmNoZKyEdWjbeiQY0oelSgKCsZmE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ede7:40c7:c970:8d77])
 (user=irogers job=sendgmr) by 2002:a05:690c:fcc:b0:6ea:71c3:6cc3 with SMTP id
 00721157ae682-6f3f82c0d30mr2448867b3.8.1736273354973; Tue, 07 Jan 2025
 10:09:14 -0800 (PST)
Date: Tue,  7 Jan 2025 10:08:50 -0800
Message-Id: <20250107180854.770470-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v4 0/4] Prefer sysfs/JSON events also when no PMU is provided
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
Content-Type: text/plain; charset="UTF-8"

At the RISC-V summit the topic of avoiding event data being in the
RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
events being the priority when no PMU is provided so that legacy
events maybe supported via json. Originally Mark Rutland also
expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
M? processors, but James Clark more recently tested this and believes
the driver issues there may not have existed or have been resolved. In
any case, it is inconsistent that with a PMU event names avoid legacy
encodings, but when wildcarding PMUs (ie without a PMU with the event
name) the legacy encodings have priority.

The patch doing this work was reverted in a v6.10 release candidate
as, even though the patch was posted for weeks and had been on
linux-next for weeks without issue, Linus was in the habit of using
explicit legacy events with unsupported precision options on his
Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
where ARM decided to call the events bus_cycles and cycles, the latter
being also a legacy event name. ARM haven't renamed the cycles event
to a more consistent cpu_cycles and avoided the problem. With these
changes the problematic event will now be skipped, a large warning
produced, and perf record will continue for the other PMU events. This
solution was proposed by Arnaldo.

Two minor changes have been added to help with the error message and
to work around issues occurring with "perf stat metrics (shadow stat)
test".

The patches have only been tested on my x86 non-hybrid laptop.

v4: Rework the no events opening change from v3 to make it handle
    multiple dummy events. Sadly an evlist isn't empty if it just
    contains dummy events as the dummy event may be used with "perf
    record -e dummy .." as a way to determine whether permission
    issues exist. Other software events like cpu-clock would suffice
    for this, but the using dummy genie has left the bottle.

    Another problem is that we appear to have an excessive number of
    dummy events added, for example, we can likely avoid a dummy event
    and add sideband data to the original event. For auxtrace more
    dummy events may be opened too. Anyway, this has led to the
    approach taken in patch 3 where the number of dummy parsed events
    is computed. If the number of removed/failing-to-open non-dummy
    events matches the number of non-dummy events then we want to
    fail, but only if there are no parsed dummy events or if there was
    one then it must have opened. The math here is hard to read, but
    passes my manual testing.

v3: Make no events opening for perf record a failure as suggested by
    James Clark and Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>. Also,
    rebase.
v2: Rebase and add tested-by tags from James Clark, Leo Yan and Atish
    Patra who have tested on RISC-V and ARM CPUs, including the
    problem case from before.

Ian Rogers (4):
  perf evsel: Add pmu_name helper
  perf stat: Fix find_stat for mixed legacy/non-legacy events
  perf record: Skip don't fail for events that don't open
  perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
    legacy"

 tools/perf/builtin-record.c    | 54 +++++++++++++++++++++---
 tools/perf/util/evsel.c        | 10 +++++
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/parse-events.c | 26 +++++++++---
 tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
 tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
 tools/perf/util/pmus.c         | 20 +++++++--
 tools/perf/util/stat-shadow.c  |  3 +-
 8 files changed, 176 insertions(+), 74 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


