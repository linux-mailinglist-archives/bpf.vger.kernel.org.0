Return-Path: <bpf+bounces-33828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A42926B90
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 00:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E311F21F14
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C0A194A48;
	Wed,  3 Jul 2024 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNCPv1Q4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6456E194136;
	Wed,  3 Jul 2024 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045838; cv=none; b=mxpZaSJEj/fPK5ZrH1VWqTbWHYgyDkAz6CBNJ66QXat4fKnYSQYJTR/9soEqUkt3804AFH3WTeT73VkbiOo4SitfRLOUCGvFbMUxdZ7MbLd0TgIOpLpFrFGnpYD6yP4//EAeUZJsE2NmWwtVx51Ibhqcbt6fPMLcNvWRcpIKXs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045838; c=relaxed/simple;
	bh=RMGaifxTM+7upI+r5g93pzdKZLIfNspeQTFX+Ryz3SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxHIwQ86d0K+FnB84Q/8DcEoLrkp82sULzMaMJ3yfWIVKl5pg1rS4WBk1ogqjMI7V5IwfDrqRbmVt0FcEk9RoZ2zFizwXygRjUOmYBk8ad4kCxWXYyP52j6dDDOSozSEl9zfrbmy+noCyXdV6F8YCWUq90IioeAwjUK6Vbh8bBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNCPv1Q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FA9C4AF12;
	Wed,  3 Jul 2024 22:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720045837;
	bh=RMGaifxTM+7upI+r5g93pzdKZLIfNspeQTFX+Ryz3SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNCPv1Q4MNTnjfCkytaHXPTF1Uq7bcmtaiQ4/3zdPfOi0PmHOpVvPY7xf3UFPM+f9
	 IpdgNGrqWtrJIJuq0IFUbtGgR4OuwmBOQ1SuhVg7FAzAPK8A8m8yCK+1GNoBfx1zDY
	 6q1/RrXe1nELREErhfgLSgMiFiQCX31FC9x/PEwqBUh2Q3ehUnt5wyiAC/t88fSLuf
	 Wpd1HL0T2H3S8hFYrXIN0mNfvQ1T1qloEMDGqCBqpfCAcZxlX5XMdRkA529oX2R4kJ
	 BBpY6ZhZcps+NdPWL85FkTDW1X8WCUM5RvDJg5CTBx2N20vx/FEfYYAGi4czndeMis
	 F0DSM0inPz1OA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	KP Singh <kpsingh@kernel.org>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH v3 2/8] perf bpf-filter: Pass 'target' to perf_bpf_filter__prepare()
Date: Wed,  3 Jul 2024 15:30:29 -0700
Message-ID: <20240703223035.2024586-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240703223035.2024586-1-namhyung@kernel.org>
References: <20240703223035.2024586-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed to prepare target-specific actions in the later patch.
We want to reuse the pinned BPF program and map for regular users to
profile their own processes.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c  | 2 +-
 tools/perf/builtin-stat.c    | 2 +-
 tools/perf/builtin-top.c     | 2 +-
 tools/perf/builtin-trace.c   | 2 +-
 tools/perf/util/bpf-filter.c | 2 +-
 tools/perf/util/bpf-filter.h | 6 ++++--
 tools/perf/util/evlist.c     | 5 +++--
 tools/perf/util/evlist.h     | 4 +++-
 8 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 019305b94e5f..e855a7688008 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1389,7 +1389,7 @@ static int record__open(struct record *rec)
 "even with a suitable vmlinux or kallsyms file.\n\n");
 	}
 
-	if (evlist__apply_filters(evlist, &pos)) {
+	if (evlist__apply_filters(evlist, &pos, &opts->target)) {
 		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
 			pos->filter ?: "BPF", evsel__name(pos), errno,
 			str_error_r(errno, msg, sizeof(msg)));
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 661832756a24..1f92445f7480 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -833,7 +833,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			return -1;
 	}
 
-	if (evlist__apply_filters(evsel_list, &counter)) {
+	if (evlist__apply_filters(evsel_list, &counter, &target)) {
 		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
 			counter->filter, evsel__name(counter), errno,
 			str_error_r(errno, msg, sizeof(msg)));
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index e8cbbf10d361..d1a06a88d693 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1055,7 +1055,7 @@ static int perf_top__start_counters(struct perf_top *top)
 		}
 	}
 
-	if (evlist__apply_filters(evlist, &counter)) {
+	if (evlist__apply_filters(evlist, &counter, &opts->target)) {
 		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
 			counter->filter ?: "BPF", evsel__name(counter), errno,
 			str_error_r(errno, msg, sizeof(msg)));
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c42bc608954e..0f93ba83717d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3959,7 +3959,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	err = trace__expand_filters(trace, &evsel);
 	if (err)
 		goto out_delete_evlist;
-	err = evlist__apply_filters(evlist, &evsel);
+	err = evlist__apply_filters(evlist, &evsel, &trace->opts.target);
 	if (err < 0)
 		goto out_error_apply_filters;
 
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 2510832d83f9..0b2eca56aa10 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -91,7 +91,7 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 	return -1;
 }
 
-int perf_bpf_filter__prepare(struct evsel *evsel)
+int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target __maybe_unused)
 {
 	int i, x, y, fd, ret;
 	struct sample_filter_bpf *skel;
diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
index cd6764442c16..605a3d0226e0 100644
--- a/tools/perf/util/bpf-filter.h
+++ b/tools/perf/util/bpf-filter.h
@@ -16,6 +16,7 @@ struct perf_bpf_filter_expr {
 };
 
 struct evsel;
+struct target;
 
 #ifdef HAVE_BPF_SKEL
 struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term term,
@@ -23,7 +24,7 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term
 						       enum perf_bpf_filter_op op,
 						       unsigned long val);
 int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
-int perf_bpf_filter__prepare(struct evsel *evsel);
+int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target);
 int perf_bpf_filter__destroy(struct evsel *evsel);
 u64 perf_bpf_filter__lost_count(struct evsel *evsel);
 
@@ -34,7 +35,8 @@ static inline int perf_bpf_filter__parse(struct list_head *expr_head __maybe_unu
 {
 	return -EOPNOTSUPP;
 }
-static inline int perf_bpf_filter__prepare(struct evsel *evsel __maybe_unused)
+static inline int perf_bpf_filter__prepare(struct evsel *evsel __maybe_unused,
+					   struct target *target __maybe_unused)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3a719edafc7a..1417f9a23083 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1086,7 +1086,8 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	return -1;
 }
 
-int evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel)
+int evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel,
+			  struct target *target)
 {
 	struct evsel *evsel;
 	int err = 0;
@@ -1108,7 +1109,7 @@ int evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel)
 		 * non-tracepoint events can have BPF filters.
 		 */
 		if (!list_empty(&evsel->bpf_filters)) {
-			err = perf_bpf_filter__prepare(evsel);
+			err = perf_bpf_filter__prepare(evsel, target);
 			if (err) {
 				*err_evsel = evsel;
 				break;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index cb91dc9117a2..cccc34da5a02 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -20,6 +20,7 @@ struct pollfd;
 struct thread_map;
 struct perf_cpu_map;
 struct record_opts;
+struct target;
 
 /*
  * State machine of bkw_mmap_state:
@@ -212,7 +213,8 @@ void evlist__enable_non_dummy(struct evlist *evlist);
 void evlist__set_selected(struct evlist *evlist, struct evsel *evsel);
 
 int evlist__create_maps(struct evlist *evlist, struct target *target);
-int evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel);
+int evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel,
+			  struct target *target);
 
 u64 __evlist__combined_sample_type(struct evlist *evlist);
 u64 evlist__combined_sample_type(struct evlist *evlist);
-- 
2.45.2.803.g4e1b14247a-goog


