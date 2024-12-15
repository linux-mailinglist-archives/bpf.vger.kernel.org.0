Return-Path: <bpf+bounces-47006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDAB9F25E5
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 20:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DC1188727B
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6E21CEAC3;
	Sun, 15 Dec 2024 19:35:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5362C1CDA19;
	Sun, 15 Dec 2024 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734291335; cv=none; b=LoyLj8soUCHMsoKs5na8R9cHMC+OIH8LviXKB5qsHt2uPtmsRMpH8tu6HNk33jNZsLuQLX74hVHx1khafWat1wPL0KRceehfrlViDUvTUil78h3lsXrFA+x2NygVvdH6glPG6adfbvvLTbi7LuJmMwbg0jossySysvkz7Va9aVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734291335; c=relaxed/simple;
	bh=uDvOKjWmh543OJYOozpRVVsvOuhBTFKYNsaJZyLB0CI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RPS7Yn+krVT7SgUoG8WyXn1givtYGtuoVy8u7sTBwb7aTRC/N6VwoEDruIcxN1P1wnkBabtKQmm+yU5E2G6eWiHx2rmt5Pvm3lwqzEJz33KsKTY1xPqBD1MczWgdB+GFYDD3duSHsRoJiGtKdhtZg+IBWJwJ55STzNuIItNla9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82BDA1424;
	Sun, 15 Dec 2024 11:36:01 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 893183F528;
	Sun, 15 Dec 2024 11:35:29 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 6/7] perf record: Support AUX pause with BPF
Date: Sun, 15 Dec 2024 19:34:35 +0000
Message-Id: <20241215193436.275278-7-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241215193436.275278-1-leo.yan@arm.com>
References: <20241215193436.275278-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit enables the BPF backend in a perf record session for AUX
pause.

It introduces an option "--bpf-aux-pause" for specifying kprobe and
tracepoint events for triggering AUX pause and resume.  The BPF
program will be loaded after the option is set, and the events will be
updated into the BPF map, so the BPF program in kernel knows to
control AUX pause and resume based on the event handler.

After:

  perf record -e cs_etm/aux-action=start-paused/ \
    --bpf-aux-pause="kretprobe:__arm64_sys_openat:p,kprobe:__arm64_sys_openat:r,tp:sched:sched_switch:r" \
    -a -- ls

  perf record -e cs_etm/aux-action=start-paused/ \
    --bpf-aux-pause="kretprobe:__arm64_sys_openat:p,kprobe:__arm64_sys_openat:r,tp:sched:sched_switch:r" \
    --per-thread -i -- ls

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/builtin-record.c | 18 +++++++++++++++++-
 tools/perf/util/evsel.c     |  6 ++++++
 tools/perf/util/record.h    |  1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 49361c5b2251..ae6bb23e0233 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -864,7 +864,12 @@ static int record__auxtrace_init(struct record *rec)
 	if (err)
 		return err;
 
-	return auxtrace_parse_filters(rec->evlist);
+	err = auxtrace_parse_filters(rec->evlist);
+	if (err)
+		return err;
+
+	return auxtrace__prepare_bpf(rec->itr,
+				     rec->opts.auxtrace_bpf_aux_pause_opts);
 }
 
 #else
@@ -2486,6 +2491,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	evlist__config(rec->evlist, opts, &callchain_param);
 
+	err = auxtrace__set_bpf_filter(rec->evlist, opts);
+	if (err)
+		goto out_free_threads;
+
 	/* Debug message used by test scripts */
 	pr_debug3("perf record opening and mmapping events\n");
 	if (record__open(rec) != 0) {
@@ -2556,6 +2565,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (record__start_threads(rec))
 		goto out_free_threads;
 
+	if (auxtrace__enable_bpf())
+		goto out_free_threads;
+
 	/*
 	 * When perf is starting the traced process, all the events
 	 * (apart from group members) have enable_on_exec=1 set,
@@ -2875,6 +2887,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 out_delete_session:
+	auxtrace__cleanup_bpf();
 #ifdef HAVE_EVENTFD_SUPPORT
 	if (done_fd >= 0) {
 		fd = done_fd;
@@ -3566,6 +3579,9 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
 	OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
 		   "BPF filter action"),
+	OPT_STRING_OPTARG(0, "bpf-aux-pause", &record.opts.auxtrace_bpf_aux_pause_opts,
+			  "{kprobe|kretprobe|tp|tracepoint}:{category}:trace_name:{p|r}",
+			  "Enable AUX pause with BPF backend", ""),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f6a5284ed5f9..a77053e546bc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2586,6 +2586,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			bpf_counter__install_pe(evsel, idx, fd);
 
+			/* Update event info into BPF map for AUX trace */
+			if (auxtrace__update_bpf_map(evsel, idx, fd)) {
+				err = -EINVAL;
+				goto out_close;
+			}
+
 			if (unlikely(test_attr__enabled())) {
 				test_attr__open(&evsel->core.attr, pid, cpu,
 						fd, group_fd, evsel->open_flags);
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index a6566134e09e..051a4b71721b 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -64,6 +64,7 @@ struct record_opts {
 	size_t	      auxtrace_snapshot_size;
 	const char    *auxtrace_snapshot_opts;
 	const char    *auxtrace_sample_opts;
+	const char    *auxtrace_bpf_aux_pause_opts;
 	bool	      sample_transaction;
 	bool	      use_clockid;
 	clockid_t     clockid;
-- 
2.34.1


