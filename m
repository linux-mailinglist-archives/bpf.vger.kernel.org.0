Return-Path: <bpf+bounces-64354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E316B11BE6
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA66AA742B
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 10:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF582EBBB5;
	Fri, 25 Jul 2025 10:08:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CB62EB5B0;
	Fri, 25 Jul 2025 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438132; cv=none; b=Lltz98Bd2ysP8Y2fukyZnCtzp+VUCylSCDyHcNoZrvG1IwB6xmO1lj/XZlfd7VJIqBLuLHv52RQ5SRCFv3HBDr6qrms4t2de+rHF8LKTUvZ8USLrND8KeP8n6J5lBB6g8lE5BZ7021+3KRfh2g5qDJ1dz9m+Ies2WmB2l0iSlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438132; c=relaxed/simple;
	bh=ifOQzVmV3VBtSmlMlao+ybmiD4XeSzgUN/D+ollwJ44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JOhYm6ucFYFYvcN0qtxbc9+fs2CtlZdLzydLysZN/ieqLlmpW2nDxRNKJTI6/2vPg2/5U+dUr6vqvG8C3YnLQWpYLL5EIH3H0XK1nMQdunzIE1b7nX9Ds6oPhW5zywDkkME6EbRwlEegG768jps1EuH9UOFSrI3RpjkJnwHNCwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0BF92C1E;
	Fri, 25 Jul 2025 03:08:41 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6F9B3F5A1;
	Fri, 25 Jul 2025 03:08:44 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 25 Jul 2025 11:08:15 +0100
Subject: [PATCH RESEND v3 5/6] perf record: Support AUX pause and resume
 with BPF
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-perf_aux_pause_resume_bpf_rebase-v3-5-ae21deb49d1a@arm.com>
References: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-ae21deb49d1a@arm.com>
In-Reply-To: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-ae21deb49d1a@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 James Clark <james.clark@linaro.org>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753438103; l=4080;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=ifOQzVmV3VBtSmlMlao+ybmiD4XeSzgUN/D+ollwJ44=;
 b=m+cK9FnmZwIAI4vIv1MC3AUo27DgY1gTzcTlpM5EstdtWUeu7DzuE2d6h43FCgpjcClWx3YmU
 GBTPXPLl6U1AQk3FiwxmsmggR11FUifvP5Io0g2t3ppHzhONLti1qPX
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This commit introduces an option "--bpf-aux-pause" for loading BPF
program to trigger AUX pause and resume.

After:

  perf record -e cs_etm/aux-action=start-paused/ \
    --bpf-aux-pause="kretprobe:p:__arm64_sys_openat,kprobe:r:__arm64_sys_openat,tp:r:sched:sched_switch" \
    -a -- ls

  perf record -e cs_etm/aux-action=start-paused/ \
    --bpf-aux-pause="kretprobe:p:__arm64_sys_openat,kprobe:r:__arm64_sys_openat,tp:r:sched:sched_switch" \
    --per-thread -- ls

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/builtin-record.c | 20 +++++++++++++++++++-
 tools/perf/util/evsel.c     |  6 ++++++
 tools/perf/util/record.h    |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8059bce85a510b2dddc66f1b8b0013276840eddc..793609c0a59e8abcd248608f55e0af03a253138d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -880,7 +880,12 @@ static int record__auxtrace_init(struct record *rec)
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
@@ -2506,6 +2511,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	evlist__config(rec->evlist, opts, &callchain_param);
 
+	err = auxtrace__set_bpf_filter(rec->evlist, opts);
+	if (err)
+		goto out_free_threads;
+
 	/* Debug message used by test scripts */
 	pr_debug3("perf record opening and mmapping events\n");
 	if (record__open(rec) != 0) {
@@ -2579,6 +2588,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (record__start_threads(rec))
 		goto out_free_threads;
 
+	if (auxtrace__enable_bpf())
+		goto out_free_threads;
+
 	/*
 	 * When perf is starting the traced process, all the events
 	 * (apart from group members) have enable_on_exec=1 set,
@@ -2907,6 +2919,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 out_delete_session:
+	auxtrace__cleanup_bpf();
 #ifdef HAVE_EVENTFD_SUPPORT
 	if (done_fd >= 0) {
 		fd = done_fd;
@@ -3629,6 +3642,11 @@ static struct option __record_options[] = {
 	OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "ms",
 		     "Dump off-cpu samples if off-cpu time exceeds this threshold (in milliseconds). (Default: 500ms)",
 		     record__parse_off_cpu_thresh),
+	OPT_STRING_OPTARG(0, "bpf-aux-pause", &record.opts.auxtrace_bpf_aux_pause_opts,
+			  "{kprobe|kretprobe}:{p|r}:function_name\n"
+			  "\t\t\t  {uprobe|uretprobe}:{p|r}:executable:function_name\n"
+			  "\t\t\t  {tp|tracepoint}:{p|r}:category:tracepoint\n",
+			  "Enable AUX pause with BPF backend", ""),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d55482f094bf95ac7b5c5173c1341baeb0fa9c93..f240e48f41a3e7ca5ba81733efc58a25c5c829ba 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2650,6 +2650,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
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
index ea3a6c4657eefb743dc3d54b0b791ea39117cc10..1b1c2ed7fcadae8b56408b3b1b154faef3996eb3 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -65,6 +65,7 @@ struct record_opts {
 	size_t	      auxtrace_snapshot_size;
 	const char    *auxtrace_snapshot_opts;
 	const char    *auxtrace_sample_opts;
+	const char    *auxtrace_bpf_aux_pause_opts;
 	bool	      sample_transaction;
 	bool	      use_clockid;
 	clockid_t     clockid;

-- 
2.34.1


