Return-Path: <bpf+bounces-30336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CDD8CC855
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 23:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D2BB21566
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 21:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161A21474BC;
	Wed, 22 May 2024 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fc2ohLYU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C858146D64;
	Wed, 22 May 2024 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414979; cv=none; b=I6FBvLb7yD6Dy0vMWSdSrL/scubBnYgzpXMX+dz6sdTsLTq7WJ9IeO5Bhh9HqoarujFu7LR9xmp3Ng1bYRzQD/OOHqrhSRLXZu6JCX+o7ujDwXNUt4vupa7YU72tAwG8SYPL6mh4TPY71EWUglQyYB3ytLYMC51YgyOA4gNLH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414979; c=relaxed/simple;
	bh=H4qEb7INp0DiLgURAfSgMtv/G/oTOFtpH0HYRpgYhu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaajFVCSPoj53Zo2O24ZEHzMRmsLaSkzlOwmWpi4qMkgM0WxWAw4pSrRH1cIEQtW/bSaO6RnmAI9J9NODNW+fYe08B3K5ztt5xAUMKwewAFUKr/aiAieetWDyd2XJynmShOP8qqZghRz0shGTSMsJUdji3KlXH4wIPuhNcqGYOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fc2ohLYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC06C4AF09;
	Wed, 22 May 2024 21:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716414979;
	bh=H4qEb7INp0DiLgURAfSgMtv/G/oTOFtpH0HYRpgYhu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fc2ohLYU3yv1F49mEZmGaFKuXsw32EXxgmyQlFidnlCyn+1ENH4WN12uj5anfh2nW
	 auUn1KCXcDx4okMvZircffiCiTafKPuiyfFBsjZmjxclRT/xehywTu99Gysh6KEJxd
	 YHW7gxz4H5kdV9sXD5P8OG7VB9hS/FAHAyjBJGXhTRaamPJihDgDN0D35AgxQECxdL
	 EYsbHKf0yXg1U53O0W09oOZhjZ06yPDxwo4Yx6YTTTndkf0XV+WiJ4LbVZcz3yIQO3
	 zoR7cXzZBujt5xxmcaTnozT8astxzWCEmVtj8tRWqwinQx6U8kd6zIco76n9pxJkOB
	 +QUPmrHVLOolg==
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
	Stephane Eranian <eranian@google.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH 2/6] perf bpf-filter: Pass 'target' to perf_bpf_filter__prepare()
Date: Wed, 22 May 2024 14:56:12 -0700
Message-ID: <20240522215616.762195-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240522215616.762195-1-namhyung@kernel.org>
References: <20240522215616.762195-1-namhyung@kernel.org>
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
 tools/perf/builtin-trace.c   | 2 +-
 tools/perf/util/bpf-filter.c | 2 +-
 tools/perf/util/bpf-filter.h | 6 ++++--
 tools/perf/util/evlist.c     | 5 +++--
 tools/perf/util/evlist.h     | 4 +++-
 tools/perf/util/python.c     | 3 ++-
 8 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 66a3de8ac661..8ec0b1607603 100644
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
index 35f79b48e8dc..23ba1e54291b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -813,7 +813,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			return -1;
 	}
 
-	if (evlist__apply_filters(evsel_list, &counter)) {
+	if (evlist__apply_filters(evsel_list, &counter, &target)) {
 		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
 			counter->filter, evsel__name(counter), errno,
 			str_error_r(errno, msg, sizeof(msg)));
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 51eca671c797..fd005ebdec04 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3974,7 +3974,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	err = trace__expand_filters(trace, &evsel);
 	if (err)
 		goto out_delete_evlist;
-	err = evlist__apply_filters(evlist, &evsel);
+	err = evlist__apply_filters(evlist, &evsel, &trace->opts.target);
 	if (err < 0)
 		goto out_error_apply_filters;
 
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 12e9c7dbb4dd..f43b9e61bf42 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -85,7 +85,7 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 	return -1;
 }
 
-int perf_bpf_filter__prepare(struct evsel *evsel)
+int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target __maybe_unused)
 {
 	int i, x, y, fd, ret;
 	struct sample_filter_bpf *skel;
diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
index 7afd159411b8..955ef4e3a931 100644
--- a/tools/perf/util/bpf-filter.h
+++ b/tools/perf/util/bpf-filter.h
@@ -16,13 +16,14 @@ struct perf_bpf_filter_expr {
 };
 
 struct evsel;
+struct target;
 
 #ifdef HAVE_BPF_SKEL
 struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(unsigned long sample_flags, int part,
 						       enum perf_bpf_filter_op op,
 						       unsigned long val);
 int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
-int perf_bpf_filter__prepare(struct evsel *evsel);
+int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target);
 int perf_bpf_filter__destroy(struct evsel *evsel);
 u64 perf_bpf_filter__lost_count(struct evsel *evsel);
 
@@ -33,7 +34,8 @@ static inline int perf_bpf_filter__parse(struct list_head *expr_head __maybe_unu
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
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0aeb97c11c03..5e015d0c0df5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -175,7 +175,8 @@ int bpf_counter__disable(struct evsel *evsel __maybe_unused)
 
 // not to drag util/bpf-filter.c
 #ifdef HAVE_BPF_SKEL
-int perf_bpf_filter__prepare(struct evsel *evsel __maybe_unused)
+int perf_bpf_filter__prepare(struct evsel *evsel __maybe_unused,
+			     struct target *target __maybe_unused)
 {
 	return 0;
 }
-- 
2.45.1.288.g0e0cd299f1-goog


