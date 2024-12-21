Return-Path: <bpf+bounces-47523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F799FA232
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 20:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B73F188C8A4
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 19:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38A4189F2F;
	Sat, 21 Dec 2024 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="duvjJAKM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D04E15B554
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734809222; cv=none; b=fbKIuakawtJ5l97uzFd2hVi76hoI83qQIoSJN97CnYS465DGa1J25E8cznA5gEjGlC9iXGZDygru4P9hQ9ZzmoJDU2uOaSFiTiIHxhQYIhztAalt5Gb2GGNVy+qHRfs12btu6GuVjZqNh1IokIjEOiZVRUFdcjZpvSCs9Zwf3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734809222; c=relaxed/simple;
	bh=CYhbP77Y+itdUk9EZRAHbUqOOAzcfzJ5Z6fc96Q2VVY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=QSNenOfqGEIn5Qt+JjFAgURoOLhlESqXxNEQPqU5nHZZM8B8uqWmC7j6PZjny9TG8Xx46wljdMvUIjoFPh3MnVLxaHLEIAKo+DVQU2jsZxbpCIRuz585iNs5gJ4r+C3VrLNIEBnBNdjz2erCv29+ceg4XRdSregHPQBShj7s1uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=duvjJAKM; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f28f5f2c5eso36135797b3.0
        for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 11:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734809218; x=1735414018; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=khbaf3YPAMV9CfglLchWYjPoJjw6OVX8mcR2dtFxUQs=;
        b=duvjJAKMAkFPP1NGKT7xZBCbLR866WvazlZE6pwjDxP06WiaLVCI/YUUEo2BMiqzJg
         AiFDjvNpE/6v7EOthlyIHhDb3B0BbYx2HUHX+tFJ0nwmqvCAXZ7fWoxjWuXnKOdsTXkb
         MgwDor7YLBhdZ6DFPiRuWbieLNM6W/HMtd47AxL7qvbMJJoR+Rz61sUNBgoNoSoFAoGr
         WKg9PMCdoSPO3mJ0AXQBG9MbfljBcAx7M+x9ic1ZHkOOGfnaNB8bWRxqTJ9xa9GiKST2
         hq9J2P6nAoNh3OELqMt1KW3UGwEe51KBEZQ1QBtnKF9gdofvXa9E538lTgVlTOb4B/7o
         k8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734809218; x=1735414018;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khbaf3YPAMV9CfglLchWYjPoJjw6OVX8mcR2dtFxUQs=;
        b=O3Va/zHYkdB+w1pTsiriiZchjeK0JOUpw3AvfbVXIm+kK3j8H4s/QXK2+Yly5av/Tn
         yeidHeGuTqwVqkdtDApM9jw47VXrunsnNZiPgbK6639qcrtDCRRosy+DwEiteXKdWeGf
         OLLzg3UG9/2dO89Dt5ZpTJ46LOj20tsPw4MXOFqtZ+uiJ031gkE3Yi6/QG4x6BdOcehq
         9HAAZq92Fbj2dM7WjTDyOcVJrKoS66tQ19REuc022AsM3PKtPofH6hYFA+Szmlt9uwYz
         Wr9M5jzvcwj3ozd8GvjOz55F9eszpFGKkZo2A8OKDZ78B0rUTAyUc1OQvyGK0V2FdsE5
         dDAA==
X-Forwarded-Encrypted: i=1; AJvYcCX4oXQMBIByZX//l+cU0XsQrVT1dT5ujELPZmnYDyqWXcLS5i58zNGmDq0y++nf2l8g9oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWlCdlEqX3B3Inkh/YRLlHesSN1z/tlpMhxKRTkcNNULFJywve
	8tPI8Tlxc/Aj3Vtka0R5IYLEJxRwBsxhyLfGg7df73Uq3GPVECdUPy9j2xwVLd5job9rZWY65lW
	3SU336w==
X-Google-Smtp-Source: AGHT+IEUPVSq8lBgYTPQFcTqPnjauWVaFibsYrI1AVzY9v9JhHQtrgLP0tfvy5Nuebxp1GkuuHWp20EUvSdz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a2bc:ec03:1143:41ab])
 (user=irogers job=sendgmr) by 2002:a05:690c:2502:b0:6ef:7372:10f8 with SMTP
 id 00721157ae682-6f3f822b63emr238087b3.5.1734809218491; Sat, 21 Dec 2024
 11:26:58 -0800 (PST)
Date: Sat, 21 Dec 2024 11:26:50 -0800
Message-Id: <20241221192654.94344-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 0/4] Prefer sysfs/JSON events also when no PMU is provided
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

 tools/perf/builtin-record.c    | 34 ++++++++++++---
 tools/perf/util/evsel.c        | 10 +++++
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/parse-events.c | 26 +++++++++---
 tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
 tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
 tools/perf/util/pmus.c         | 20 +++++++--
 tools/perf/util/stat-shadow.c  |  3 +-
 8 files changed, 156 insertions(+), 74 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


