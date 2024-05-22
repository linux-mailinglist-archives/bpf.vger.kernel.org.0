Return-Path: <bpf+bounces-30337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE598CC857
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 23:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3711F212DF
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 21:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5A4147C7E;
	Wed, 22 May 2024 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWael7eS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E981474C0;
	Wed, 22 May 2024 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414980; cv=none; b=bgkrr3HfTdTLT/LuYUEssQepiL4pJ2xnG4X0OXrqoYvMuWT0t8EX7k2RQFYATMrWTuQsGycNMJYUufdYmyzygtC5TeTfjTfLlOmbkv6+RKvF9Z0Xe6FOYzRP+NNVDCWJjvaffXxArEJk7j1eDuCD0hWzrat8rIzDK4LrTDz6Cms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414980; c=relaxed/simple;
	bh=yAYFbGmjGhvJIkcoRRf+aOEVh50XwtRzoVVUOUa9xeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4aI2BL2XmcCGN2aLFNw8gfh3396Se3Gyd4YlcObsBaiol5V0tczfVJ2UCC/wP6IbrADPGtDJnMa6aqDQWrb9TYUdSDVrcVvIsOPKc3Asdbu7xnt5XMB2N9ocBXoBQ+JibPDMc9U7CDe/KvhN7MKwlpGIAbeKaxJNrPc45WLt6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWael7eS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48802C4AF17;
	Wed, 22 May 2024 21:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716414979;
	bh=yAYFbGmjGhvJIkcoRRf+aOEVh50XwtRzoVVUOUa9xeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWael7eSgdCAGNUrNkqy7ZTtZUGQ1TzEfKCfNd3FRqQgXm5g/FioZrGyPJskQISXx
	 VgRU8ptZuCFinHWGoydK6Nmo41sY7s0fOFxHY/SATq0h7YuDE+o8HGYqea76JviO3k
	 DA94w0HBYlD3oQFFIST+pWKt/O5qA7kutjLl7QKYitInBGo1CM50W3XbIZOEAkzhW2
	 RWjg/9yx2hH1f5Jj2X1L7gZXvNB9Nzor3qeH3Z6Q5k/0sjKRk3eI7XJ74bQRODirPH
	 4HpoowlrElAlHIDFEw1CG+xy3lozWoO+yoTOEbqvjT05LNmDUpYsYhvwmtWKbQJmAj
	 GudycpABegpHw==
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
Subject: [PATCH 3/6] perf bpf-filter: Split per-task filter use case
Date: Wed, 22 May 2024 14:56:13 -0700
Message-ID: <20240522215616.762195-4-namhyung@kernel.org>
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

If the target is a list of tasks, it can use a shared hash map for
filter expressions.  The key of the filter map is an integer index like
in an array.  A separate pid_hash map is added to get the index for the
filter map using the tgid.

For system-wide mode including per-cpu or per-user targets are handled
by the single entry map like before.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf-filter.c                 | 186 +++++++++++++++----
 tools/perf/util/bpf_skel/sample-filter.h     |   1 +
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  23 ++-
 3 files changed, 168 insertions(+), 42 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index f43b9e61bf42..2187975189c9 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -3,10 +3,13 @@
 
 #include <bpf/bpf.h>
 #include <linux/err.h>
+#include <api/fs/fs.h>
 #include <internal/xyarray.h>
+#include <perf/threadmap.h>
 
 #include "util/debug.h"
 #include "util/evsel.h"
+#include "util/target.h"
 
 #include "util/bpf-filter.h"
 #include <util/bpf-filter-flex.h>
@@ -85,38 +88,17 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 	return -1;
 }
 
-int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target __maybe_unused)
+static int get_filter_entries(struct evsel *evsel, struct perf_bpf_filter_entry *entry)
 {
-	int i, x, y, fd, ret;
-	struct sample_filter_bpf *skel;
-	struct bpf_program *prog;
-	struct bpf_link *link;
+	int i = 0;
 	struct perf_bpf_filter_expr *expr;
-	struct perf_bpf_filter_entry *entry;
-
-	entry = calloc(MAX_FILTERS, sizeof(*entry));
-	if (entry == NULL)
-		return -1;
-
-	skel = sample_filter_bpf__open_and_load();
-	if (!skel) {
-		pr_err("Failed to load perf sample-filter BPF skeleton\n");
-		ret = -EPERM;
-		goto err;
-	}
 
-	i = 0;
-	fd = bpf_map__fd(skel->maps.filters);
 	list_for_each_entry(expr, &evsel->bpf_filters, list) {
-		if (check_sample_flags(evsel, expr) < 0) {
-			ret = -EINVAL;
-			goto err;
-		}
+		if (check_sample_flags(evsel, expr) < 0)
+			return -EINVAL;
 
-		if (i == MAX_FILTERS) {
-			ret = -E2BIG;
-			goto err;
-		}
+		if (i == MAX_FILTERS)
+			return -E2BIG;
 
 		entry[i].op = expr->op;
 		entry[i].part = expr->part;
@@ -128,10 +110,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target __maybe_
 			struct perf_bpf_filter_expr *group;
 
 			list_for_each_entry(group, &expr->groups, list) {
-				if (i == MAX_FILTERS) {
-					ret = -E2BIG;
-					goto err;
-				}
+				if (i == MAX_FILTERS)
+					return -E2BIG;
 
 				entry[i].op = group->op;
 				entry[i].part = group->part;
@@ -140,10 +120,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target __maybe_
 				i++;
 			}
 
-			if (i == MAX_FILTERS) {
-				ret = -E2BIG;
-				goto err;
-			}
+			if (i == MAX_FILTERS)
+				return -E2BIG;
 
 			entry[i].op = PBF_OP_GROUP_END;
 			i++;
@@ -155,15 +133,143 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target __maybe_
 		entry[i].op = PBF_OP_DONE;
 		i++;
 	}
+	return 0;
+}
+
+static int convert_to_tgid(int tid)
+{
+	char path[128];
+	char *buf, *p, *q;
+	int tgid;
+	size_t len;
+
+	scnprintf(path, sizeof(path), "%d/status", tid);
+	if (procfs__read_str(path, &buf, &len) < 0)
+		return -1;
 
-	/* The filters map has only one entry for now */
-	i = 0;
-	if (bpf_map_update_elem(fd, &i, entry, BPF_ANY) < 0) {
-		ret = -errno;
-		pr_err("Failed to update the filter map\n");
+	p = strstr(buf, "Tgid:");
+	if (p == NULL) {
+		free(buf);
+		return -1;
+	}
+
+	tgid = strtol(p + 6, &q, 0);
+	free(buf);
+	if (*q != '\n')
+		return -1;
+
+	return tgid;
+}
+
+static int update_pid_hash(struct sample_filter_bpf *skel, struct evsel *evsel,
+			   struct perf_bpf_filter_entry *entry)
+{
+	int filter_idx;
+	int nr, last;
+	int fd = bpf_map__fd(skel->maps.filters);
+	struct perf_thread_map *threads;
+
+	/* Find the first available entry in the filters map */
+	for (filter_idx = 0; filter_idx < MAX_FILTERS; filter_idx++) {
+		if (bpf_map_update_elem(fd, &filter_idx, entry, BPF_NOEXIST) == 0)
+			break;
+	}
+
+	if (filter_idx == MAX_FILTERS) {
+		pr_err("Too many users for the filter map\n");
+		return -EBUSY;
+	}
+
+	threads = perf_evsel__threads(&evsel->core);
+	if (threads == NULL) {
+		pr_err("Cannot get the thread list of the event\n");
+		return -EINVAL;
+	}
+
+	/* save the index to a hash map */
+	fd = bpf_map__fd(skel->maps.pid_hash);
+
+	last = -1;
+	nr = perf_thread_map__nr(threads);
+	for (int i = 0; i < nr; i++) {
+		int pid = perf_thread_map__pid(threads, i);
+		int tgid;
+
+		/* it actually needs tgid, let's get tgid from /proc. */
+		tgid = convert_to_tgid(pid);
+		if (tgid < 0) {
+			/* the thread may be dead, ignore. */
+			continue;
+		}
+
+		if (tgid == last)
+			continue;
+		last = tgid;
+
+		if (bpf_map_update_elem(fd, &tgid, &filter_idx, BPF_ANY) < 0) {
+			pr_err("Failed to update the pid hash\n");
+			return -errno;
+		}
+		pr_debug("pid hash: %d -> %d\n", tgid, filter_idx);
+	}
+	return 0;
+}
+
+int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
+{
+	int i, x, y, fd, ret;
+	struct sample_filter_bpf *skel = NULL;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	struct perf_bpf_filter_entry *entry;
+	bool needs_pid_hash = !target__has_cpu(target) && !target->uid_str;
+
+	entry = calloc(MAX_FILTERS, sizeof(*entry));
+	if (entry == NULL)
+		return -1;
+
+	ret = get_filter_entries(evsel, entry);
+	if (ret < 0) {
+		pr_err("Failed to process filter entries\n");
+		goto err;
+	}
+
+	skel = sample_filter_bpf__open();
+	if (!skel) {
+		pr_err("Failed to open perf sample-filter BPF skeleton\n");
+		ret = -EPERM;
 		goto err;
 	}
 
+	if (needs_pid_hash) {
+		bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
+		bpf_map__set_max_entries(skel->maps.pid_hash, MAX_PIDS);
+		skel->rodata->use_pid_hash = 1;
+	}
+
+	if (sample_filter_bpf__load(skel) < 0) {
+		pr_err("Failed to load perf sample-filter BPF skeleton\n");
+		ret = -EPERM;
+		goto err;
+	}
+
+	if (needs_pid_hash) {
+		/* The filters map is shared among other processes  */
+		ret = update_pid_hash(skel, evsel, entry);
+		if (ret < 0)
+			goto err;
+	} else {
+		i = 0;
+		fd = bpf_map__fd(skel->maps.filters);
+
+		/* The filters map has only one entry in this case */
+		if (bpf_map_update_elem(fd, &i, entry, BPF_ANY) < 0) {
+			ret = -errno;
+			pr_err("Failed to update the filter map\n");
+			goto err;
+		}
+	}
+
 	prog = skel->progs.perf_sample_filter;
 	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
 		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index cf18f570eef4..375e27206640 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -2,6 +2,7 @@
 #define PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H
 
 #define MAX_FILTERS  64
+#define MAX_PIDS     (16 * 1024)
 
 /* supported filter operations */
 enum perf_bpf_filter_op {
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 5f17cd6458b7..1ccb0e8be73b 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -15,7 +15,16 @@ struct filters {
 	__uint(max_entries, 1);
 } filters SEC(".maps");
 
+/* tgid to filter index */
+struct pid_hash {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1);
+} pid_hash SEC(".maps");
+
 int dropped;
+volatile const int use_pid_hash;
 
 void *bpf_cast_to_kern_ctx(void *) __ksym;
 
@@ -140,11 +149,21 @@ int perf_sample_filter(void *ctx)
 	__u64 sample_data;
 	int in_group = 0;
 	int group_result = 0;
-	int i;
+	int i = 0;
 
 	kctx = bpf_cast_to_kern_ctx(ctx);
 
-	i = 0;
+	if (use_pid_hash) {
+		int tgid = bpf_get_current_pid_tgid() >> 32;
+		int *idx;
+
+		idx = bpf_map_lookup_elem(&pid_hash, &tgid);
+		if (idx)
+			i = *idx;
+		else
+			goto drop;
+	}
+
 	entry = bpf_map_lookup_elem(&filters, &i);
 	if (entry == NULL)
 		goto drop;
-- 
2.45.1.288.g0e0cd299f1-goog


