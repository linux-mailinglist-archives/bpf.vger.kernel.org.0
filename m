Return-Path: <bpf+bounces-70126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE45BB1751
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 20:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8A83BFC60
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292DE2D47F6;
	Wed,  1 Oct 2025 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALNkCant"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343CD2D3A9C
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759342374; cv=none; b=GSSRdK33MeORm7qqAoV+MNnrvNvftryf4hDhcvuBaMe5vHb852xCkK3wuG3hPiAQz+4IgVhjIY0amu1wMGJzQywkFuoWbaNpC67AIczDah0wl5sfsQdASycWzOidQY7egTmG/zX+WHqoL7+gxxk/5foRT7jo9S+3fwLgQc/dh+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759342374; c=relaxed/simple;
	bh=HX9oew4e1XAYFrT5AT7h78qJ1smpZAnVIIJYFY+JefI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ABkuce1fe+4d500B5i2rY5QqLJ2tYhJl1mmGUDTfPeoAAXa1YXIA0OQ6rl1JRvmAjL5omZCGTO5Xfv7D0d/j5Tj0wIApApR3h+paV8DMSggsC6QcoIHDmrzUcsRvsA1UG28ndlVRfLr0R6uW9JRPNXtskdsd5jiEm21cWxEh0p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ALNkCant; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2697410e7f9so1264055ad.2
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759342371; x=1759947171; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EH7kbbVLdziTCdAjxXm5Ue6gNSX07dTrc9Cjc+NPVyU=;
        b=ALNkCant5jeeKO+LIS6cMCVBRd4+gVeaMrsIdtD12GqcSKUI3yT3qpnJtxUdpa2BMd
         cgeocP2C2Q63sA4SFS9OU94RYOo9IWzj4ha8SPXAVK0/63B1jFxL7AYEkQ3t/mGSirw2
         2e4Rdb0DFELWjKwx0j94b89tGMv6y6myWGwf66Xli9ZEEvOoeu8DvHTQaUUOB35fP3Cw
         nABX3R65FdwfHWARRib3NdCZcRFMguLA567BPsGAewwwbrT1foQtFG2HW8RJ3B0rb+lc
         aU1lVoxASrBFK/5Epwt37+VUeMs9ApBq/TpYu4E8RAHTATrI0eFKTFQT3BlJoB3b23Au
         y5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759342371; x=1759947171;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EH7kbbVLdziTCdAjxXm5Ue6gNSX07dTrc9Cjc+NPVyU=;
        b=snJZqJ7HxUWTE+zNwjJr5nDYmvwOK/J16Hreb/+xeZbzGuP11xGk7eYk3Q1oaFZgaI
         lYXHSgHOE0dTgVuB5MP2/ZoA3j1EA2rR5HrTbvX1tJBh6e/U63Y+EZCfiyLIOu5zzVwi
         AFSziDf0kI1v1gGF0mgo+8p7AFqjzep9PmJizrAyWY1UKTUYyJhM4eX2wLfzbIY6HL5S
         KAR/b/2frtRiOnXz0E+ncoz6HcXHUiuHLxzvRlxHFyRQwzsspwA8o9gPrPLLM+18nhZg
         hd5PITR5XM/ywZ88+7vVtXluf3DyQXIes7th/mvo2JpVOG75U6YrkAsRarsTEosqF0xs
         sDZA==
X-Forwarded-Encrypted: i=1; AJvYcCU+KfAvPzWTkqG+DUdeuufXzBsQvm38LU1n1BbvFzYT8USpRPkMmpXs0Y3KVrR6lYL55hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFdBDankyXkfXDzO/lA3dIHZB4Ql2zOkddgs+sfJfMNktx7uQb
	kx+cHJs7ci3pQ9nWaQFXR2De/UePtjh/jE9NnATA1cwWDZXwXeuLq1phtZ0NY3pN0HRKDttoN8Z
	4B8x5hADISg==
X-Google-Smtp-Source: AGHT+IES+2nYbttOTnv0Js78KqzEulqo5E60Y3lSDZcRX9EumMk5CNUcMSfc2W4thLIdEfbe5dzGHZXjJ9s6
X-Received: from pjob2.prod.google.com ([2002:a17:90a:8c82:b0:330:6513:c709])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3847:b0:278:9051:8e9c
 with SMTP id d9443c01a7336-28e7f440874mr63024935ad.42.1759342371336; Wed, 01
 Oct 2025 11:12:51 -0700 (PDT)
Date: Wed,  1 Oct 2025 11:12:28 -0700
In-Reply-To: <20251001181229.1010340-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001181229.1010340-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001181229.1010340-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf bpf_counter: Fix handling of cpumap fixing hybrid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, Gabriele Monaco <gmonaco@redhat.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Song Liu <songliubraving@fb.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Don't open evsels on all CPUs, open them just on the CPUs they
support. This avoids opening say an e-core event on a p-core and
getting a failure - achieve this by getting rid of the "all_cpu_map".

In install_pe functions don't use the cpu_map_idx as a CPU number,
translate the cpu_map_idx, which is a dense index into the cpu_map
skipping holes at the beginning, to a proper CPU number.

Before:
```
$ perf stat --bpf-counters -a -e cycles,instructions -- sleep 1

 Performance counter stats for 'system wide':

   <not supported>      cpu_atom/cycles/
       566,270,672      cpu_core/cycles/
   <not supported>      cpu_atom/instructions/
       572,792,836      cpu_core/instructions/           #    1.01  insn per cycle

       1.001595384 seconds time elapsed
```

After:
```
$ perf stat --bpf-counters -a -e cycles,instructions -- sleep 1

 Performance counter stats for 'system wide':

       443,299,201      cpu_atom/cycles/
     1,233,919,737      cpu_core/cycles/
       213,634,112      cpu_atom/instructions/           #    0.48  insn per cycle
     2,758,965,527      cpu_core/instructions/           #    2.24  insn per cycle

       1.001699485 seconds time elapsed
```

Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware PMCs with BPF")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_counter.c        | 26 ++++++++++----------------
 tools/perf/util/bpf_counter_cgroup.c |  3 ++-
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 1c6cb5ea077e..ca5d01b9017d 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -336,6 +336,7 @@ static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu_map_idx
 {
 	struct bpf_prog_profiler_bpf *skel;
 	struct bpf_counter *counter;
+	int cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx).cpu;
 	int ret;
 
 	list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
@@ -343,7 +344,7 @@ static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu_map_idx
 		assert(skel != NULL);
 
 		ret = bpf_map_update_elem(bpf_map__fd(skel->maps.events),
-					  &cpu_map_idx, &fd, BPF_ANY);
+					  &cpu, &fd, BPF_ANY);
 		if (ret)
 			return ret;
 	}
@@ -451,7 +452,6 @@ static int bperf_check_target(struct evsel *evsel,
 	return 0;
 }
 
-static	struct perf_cpu_map *all_cpu_map;
 static __u32 filter_entry_cnt;
 
 static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
@@ -495,7 +495,7 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 	 * following evsel__open_per_cpu call
 	 */
 	evsel->leader_skel = skel;
-	evsel__open_per_cpu(evsel, all_cpu_map, -1);
+	evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
 
 out:
 	bperf_leader_bpf__destroy(skel);
@@ -533,12 +533,6 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 	if (bperf_check_target(evsel, target, &filter_type, &filter_entry_cnt))
 		return -1;
 
-	if (!all_cpu_map) {
-		all_cpu_map = perf_cpu_map__new_online_cpus();
-		if (!all_cpu_map)
-			return -1;
-	}
-
 	evsel->bperf_leader_prog_fd = -1;
 	evsel->bperf_leader_link_fd = -1;
 
@@ -656,9 +650,10 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 static int bperf__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
 {
 	struct bperf_leader_bpf *skel = evsel->leader_skel;
+	int cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx).cpu;
 
 	return bpf_map_update_elem(bpf_map__fd(skel->maps.events),
-				   &cpu_map_idx, &fd, BPF_ANY);
+				   &cpu, &fd, BPF_ANY);
 }
 
 /*
@@ -667,13 +662,12 @@ static int bperf__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
  */
 static int bperf_sync_counters(struct evsel *evsel)
 {
-	int num_cpu, i, cpu;
+	struct perf_cpu cpu;
+	int idx;
+
+	perf_cpu_map__for_each_cpu(cpu, idx, evsel->core.cpus)
+		bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu.cpu);
 
-	num_cpu = perf_cpu_map__nr(all_cpu_map);
-	for (i = 0; i < num_cpu; i++) {
-		cpu = perf_cpu_map__cpu(all_cpu_map, i).cpu;
-		bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu);
-	}
 	return 0;
 }
 
diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index ed6a29b106b4..690be3ce3e11 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -186,7 +186,8 @@ static int bperf_cgrp__load(struct evsel *evsel,
 }
 
 static int bperf_cgrp__install_pe(struct evsel *evsel __maybe_unused,
-				  int cpu __maybe_unused, int fd __maybe_unused)
+				  int cpu_map_idx __maybe_unused,
+				  int fd __maybe_unused)
 {
 	/* nothing to do */
 	return 0;
-- 
2.51.0.618.g983fd99d29-goog


