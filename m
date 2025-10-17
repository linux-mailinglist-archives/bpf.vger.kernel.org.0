Return-Path: <bpf+bounces-71219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12764BEA464
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 17:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FD17C52E1
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EE230CD9F;
	Fri, 17 Oct 2025 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JQqfcX1M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E82F12B0;
	Fri, 17 Oct 2025 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715024; cv=none; b=nDOzW+Q74o9Vocm4xoWoRRJ6li6qRANQGTHWJK60vUxqoaoaKUD/wWraqPr91EC3oAGPEC+Hoj+Zw1ha+kH7AZq6zFgrDTxxQ7TtWTEmImA6jBL6PN+zNPkTKsIjxGjGuu7ftrI4OZnCj0Y9L6cMhXkDznAs6yOO6FDYoOZF+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715024; c=relaxed/simple;
	bh=O26ZE/uvZx0ixvT2ylORup2xgo3f1aZoip+UKeDn8eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJ5pJ9VfG9wCkFkjg1jCCxWdn8Dy98iyQ8tWR3IKYwL4U72iTS1YdsDjPQT/+fz8eLHo5MZmQ4ls9X8/mNYJhxtTeNPbema6rGbAbJZ1WBpWWBgNiBI5cOylWlkeR1WlPEbTu/OSdfshuyA1BLldTQuYpKlj9/mKTC9p/GEl7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JQqfcX1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B752DC4CEE7;
	Fri, 17 Oct 2025 15:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715024;
	bh=O26ZE/uvZx0ixvT2ylORup2xgo3f1aZoip+UKeDn8eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQqfcX1MOPdty2YIGUiKz5DKqqwWx4gQ/Iu7rQiu+WcYnIHVl63YWbA9s67d3K4YD
	 ITEhUBsD8p0iDI10bnPfdHRP11lL77Z2Y6osYYuD7UQKCymu5cN07BLX6yVQ+lTCEo
	 p6/KJrauHMjJU0+FMz2BSw7zEvBBWrEyO1194XBU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	bpf@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Song Liu <songliubraving@fb.com>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 072/371] perf bpf_counter: Fix handling of cpumap fixing hybrid
Date: Fri, 17 Oct 2025 16:50:47 +0200
Message-ID: <20251017145204.547129944@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit b91917c0c6fa6df97ec0222d8d6285ab2d60c21b ]

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

Fixes: 7fac83aaf2eecc9e ("perf stat: Introduce 'bperf' to share hardware PMCs with BPF")
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: bpf@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Tengda Wu <wutengda@huaweicloud.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/bpf_counter.c        | 26 ++++++++++----------------
 tools/perf/util/bpf_counter_cgroup.c |  3 ++-
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 73fcafbffc6a6..ed88ba570c80a 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -278,6 +278,7 @@ static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu_map_idx
 {
 	struct bpf_prog_profiler_bpf *skel;
 	struct bpf_counter *counter;
+	int cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx).cpu;
 	int ret;
 
 	list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
@@ -285,7 +286,7 @@ static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu_map_idx
 		assert(skel != NULL);
 
 		ret = bpf_map_update_elem(bpf_map__fd(skel->maps.events),
-					  &cpu_map_idx, &fd, BPF_ANY);
+					  &cpu, &fd, BPF_ANY);
 		if (ret)
 			return ret;
 	}
@@ -393,7 +394,6 @@ static int bperf_check_target(struct evsel *evsel,
 	return 0;
 }
 
-static	struct perf_cpu_map *all_cpu_map;
 static __u32 filter_entry_cnt;
 
 static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
@@ -437,7 +437,7 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 	 * following evsel__open_per_cpu call
 	 */
 	evsel->leader_skel = skel;
-	evsel__open_per_cpu(evsel, all_cpu_map, -1);
+	evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
 
 out:
 	bperf_leader_bpf__destroy(skel);
@@ -475,12 +475,6 @@ static int bperf__load(struct evsel *evsel, struct target *target)
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
 
@@ -598,9 +592,10 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 static int bperf__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
 {
 	struct bperf_leader_bpf *skel = evsel->leader_skel;
+	int cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx).cpu;
 
 	return bpf_map_update_elem(bpf_map__fd(skel->maps.events),
-				   &cpu_map_idx, &fd, BPF_ANY);
+				   &cpu, &fd, BPF_ANY);
 }
 
 /*
@@ -609,13 +604,12 @@ static int bperf__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
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
index 6ff42619de12b..883ce8a670bcd 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -185,7 +185,8 @@ static int bperf_cgrp__load(struct evsel *evsel,
 }
 
 static int bperf_cgrp__install_pe(struct evsel *evsel __maybe_unused,
-				  int cpu __maybe_unused, int fd __maybe_unused)
+				  int cpu_map_idx __maybe_unused,
+				  int fd __maybe_unused)
 {
 	/* nothing to do */
 	return 0;
-- 
2.51.0




