Return-Path: <bpf+bounces-33829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1383926B91
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 00:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8712A282F1A
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B81F194A68;
	Wed,  3 Jul 2024 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFusgQcZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2011946C7;
	Wed,  3 Jul 2024 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045838; cv=none; b=GSsJVDTQtEhVK6m6f5vta1c/kvb7fG+rgyYv1HKfm/o4R7qyNTCo+a5wePgYMF5djGvihqiZxJpXW+tLcv+QEBv2Ax2KXVm118FIRRMxNNnNdIssBI+QtNs9TjyVdlY6SipaYugl0DhJxQtj+NhW9El6x8I6RLqL5BqTbWIPYaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045838; c=relaxed/simple;
	bh=rbfHsY9w9hApFB/nzPkZ1WXn/UvGNLB9ZwR3TO7Io1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCAxEVEhzHEbg+uBBjbsdBBQw0n155MlOOMKyIvIV2+FqNdKah3VluFzq+TtSEJgf0l4vzc8DEeMdER1hvRzHovvmmh+CMmP/Nf3oWBvO9G3iXtYkvKkqnuY41zioaiJYcS2tJiFRhbJ8mVbHcsKSqhYYfWbdm5N+c+gplLXzQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFusgQcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A32FC4AF0F;
	Wed,  3 Jul 2024 22:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720045838;
	bh=rbfHsY9w9hApFB/nzPkZ1WXn/UvGNLB9ZwR3TO7Io1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFusgQcZ8Y1CKmW8MYconhT6c8VGS81/ysOZ3F0UKzNlUb8W3qwjdAR+Rhm7E1Sph
	 QbLUaU8la6ffE0cs2qiQ85JyYXirLR8iFKMyLaNfeqQruwpCa80zOMX0Fm+SxRzx9y
	 SihFFOlZoLfP+vuODH3nzrxFArr4pV3DpSQJFhLq1L1PQ/EhjgLuCdhfOkaBK6D8Tj
	 ZhuC/egpigeYeHWbJxEG8BXa6GbdeIUpLQfhmlxK6xRA1EbgkXkolgar+E/Mae6V9N
	 Ubb/kq7SzGJcY9GG7vNcWvV2HCxyU3oL127K8uZfJm2Gm4ng024nx5m0Xa73/rkxqQ
	 zz6UGms5OO70g==
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
Subject: [PATCH v3 3/8] perf bpf-filter: Split per-task filter use case
Date: Wed,  3 Jul 2024 15:30:30 -0700
Message-ID: <20240703223035.2024586-4-namhyung@kernel.org>
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
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  21 +++
 3 files changed, 168 insertions(+), 40 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 0b2eca56aa10..5ec0e0955ec4 100644
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
@@ -91,38 +94,17 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
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
@@ -134,10 +116,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target __maybe_
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
@@ -146,10 +126,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target __maybe_
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
@@ -161,15 +139,143 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target __maybe_
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
index bb6a1b91f1df..e666bfd5fbdd 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -2,6 +2,7 @@
 #define PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H
 
 #define MAX_FILTERS  64
+#define MAX_PIDS     (16 * 1024)
 
 /* supported filter operations */
 enum perf_bpf_filter_op {
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 0d56e52b922c..c5273f06fa45 100644
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
 
@@ -184,6 +193,18 @@ int perf_sample_filter(void *ctx)
 	kctx = bpf_cast_to_kern_ctx(ctx);
 
 	k = 0;
+
+	if (use_pid_hash) {
+		int tgid = bpf_get_current_pid_tgid() >> 32;
+		int *idx;
+
+		idx = bpf_map_lookup_elem(&pid_hash, &tgid);
+		if (idx)
+			k = *idx;
+		else
+			goto drop;
+	}
+
 	entry = bpf_map_lookup_elem(&filters, &k);
 	if (entry == NULL)
 		goto drop;
-- 
2.45.2.803.g4e1b14247a-goog


