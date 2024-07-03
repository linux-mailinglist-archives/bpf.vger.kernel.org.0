Return-Path: <bpf+bounces-33830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5251F926B94
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 00:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08B31F21CBF
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1035A194C6D;
	Wed,  3 Jul 2024 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elHEBRlg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F636194A73;
	Wed,  3 Jul 2024 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045839; cv=none; b=RPWcHNLni55a1FaHPISehmAFGPSuN5E2+8Fy+pZwNinwH8z07fSOqoHHbvDb3EmOSCnN/DC75pgEWM3vfgAq/pH9WSSUDFq2vqSgMgK4vCRDLJb89YqT65pIPzac77VQx3Sb/DyD887x+iRdRwNQS85ccDr3+KD0/Gj/rB2m468=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045839; c=relaxed/simple;
	bh=a/vQ9nQc8NEhneTRitImTcXL8xixYG3rfate3UALpBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPo+n/7cOgyfMcPX0OhRGckEsKvshTD8UjmfYBsWxITvEcycC3RmlbmAIky6k2Gg3x1j6Yi/8LT4DF8x4bajRCg8l9ftIrNLDy84Afhg4WG0+HNhcc/VF2b5awbSjz36K4tfSSW8QFCXUI3HtQEwtRIpHhUK/9c6qKaHcl1lJ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elHEBRlg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9322BC4AF12;
	Wed,  3 Jul 2024 22:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720045839;
	bh=a/vQ9nQc8NEhneTRitImTcXL8xixYG3rfate3UALpBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=elHEBRlgHhMaDfqpafJ+4Z/KZvJ+OfPyNEOpRpO+ztVlZnDpIXr5qrmBXPtIur/nD
	 P5G9t8wlpjYgI2tuO3lVVx6icZ9HkHeoQOpCPVXMsDzmHi3iQvxWXeT5dzpWCr+sQ3
	 LRshx2PDdOpSroJDrdAKhz3Bx8mXi44L6PWPDs/VptIAQ0ryDbS+Kbz4lcz3VEukmt
	 9OS3Nb0Q6A6mzKjVlrMPrO4KGdpWPO/OeQzDRFABLz/QOnHeuFZU41/jY8q4qG24pX
	 M40+PqbnW4qYPBRV5TUE1wqxVZ/Vd0/2x6zFpGlwOk/dp4ZCy6huiu7Vp8ncFtCyZJ
	 exM70MtvXl4fA==
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
Subject: [PATCH v3 4/8] perf bpf-filter: Support pin/unpin BPF object
Date: Wed,  3 Jul 2024 15:30:31 -0700
Message-ID: <20240703223035.2024586-5-namhyung@kernel.org>
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

And use the pinned objects for unprivileged users to profile their own
tasks.  The BPF objects need to be pinned in the BPF-fs by root first
and it'll be handled in the later patch.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf-filter.c | 230 +++++++++++++++++++++++++++++------
 tools/perf/util/bpf-filter.h |  13 ++
 2 files changed, 209 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 5ec0e0955ec4..37ed6c48debf 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -1,5 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <stdlib.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
 
 #include <bpf/bpf.h>
 #include <linux/err.h>
@@ -23,6 +26,9 @@
 #define __PERF_SAMPLE_TYPE(tt, st, opt)	{ tt, #st, opt }
 #define PERF_SAMPLE_TYPE(_st, opt)	__PERF_SAMPLE_TYPE(PBF_TERM_##_st, PERF_SAMPLE_##_st, opt)
 
+/* Index in the pinned 'filters' map.  Should be released after use. */
+static int pinned_filter_idx = -1;
+
 static const struct perf_sample_info {
 	enum perf_bpf_filter_term type;
 	const char *name;
@@ -47,6 +53,8 @@ static const struct perf_sample_info {
 	PERF_SAMPLE_TYPE(DATA_PAGE_SIZE, "--data-page-size"),
 };
 
+static int get_pinned_fd(const char *name);
+
 static const struct perf_sample_info *get_sample_info(enum perf_bpf_filter_term type)
 {
 	size_t i;
@@ -167,19 +175,26 @@ static int convert_to_tgid(int tid)
 	return tgid;
 }
 
-static int update_pid_hash(struct sample_filter_bpf *skel, struct evsel *evsel,
-			   struct perf_bpf_filter_entry *entry)
+static int update_pid_hash(struct evsel *evsel, struct perf_bpf_filter_entry *entry)
 {
 	int filter_idx;
-	int nr, last;
-	int fd = bpf_map__fd(skel->maps.filters);
+	int fd, nr, last;
 	struct perf_thread_map *threads;
 
+	fd = get_pinned_fd("filters");
+	if (fd < 0) {
+		pr_debug("cannot get fd for 'filters' map\n");
+		return fd;
+	}
+
 	/* Find the first available entry in the filters map */
 	for (filter_idx = 0; filter_idx < MAX_FILTERS; filter_idx++) {
-		if (bpf_map_update_elem(fd, &filter_idx, entry, BPF_NOEXIST) == 0)
+		if (bpf_map_update_elem(fd, &filter_idx, entry, BPF_NOEXIST) == 0) {
+			pinned_filter_idx = filter_idx;
 			break;
+		}
 	}
+	close(fd);
 
 	if (filter_idx == MAX_FILTERS) {
 		pr_err("Too many users for the filter map\n");
@@ -193,7 +208,9 @@ static int update_pid_hash(struct sample_filter_bpf *skel, struct evsel *evsel,
 	}
 
 	/* save the index to a hash map */
-	fd = bpf_map__fd(skel->maps.pid_hash);
+	fd = get_pinned_fd("pid_hash");
+	if (fd < 0)
+		return fd;
 
 	last = -1;
 	nr = perf_thread_map__nr(threads);
@@ -214,10 +231,12 @@ static int update_pid_hash(struct sample_filter_bpf *skel, struct evsel *evsel,
 
 		if (bpf_map_update_elem(fd, &tgid, &filter_idx, BPF_ANY) < 0) {
 			pr_err("Failed to update the pid hash\n");
-			return -errno;
+			close(fd);
+			return -1;
 		}
 		pr_debug("pid hash: %d -> %d\n", tgid, filter_idx);
 	}
+	close(fd);
 	return 0;
 }
 
@@ -240,40 +259,48 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
-	skel = sample_filter_bpf__open();
-	if (!skel) {
-		pr_err("Failed to open perf sample-filter BPF skeleton\n");
-		ret = -EPERM;
-		goto err;
-	}
+	if (needs_pid_hash && geteuid() != 0) {
+		/* The filters map is shared among other processes */
+		ret = update_pid_hash(evsel, entry);
+		if (ret < 0)
+			goto err;
 
-	if (needs_pid_hash) {
-		bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
-		bpf_map__set_max_entries(skel->maps.pid_hash, MAX_PIDS);
-		skel->rodata->use_pid_hash = 1;
+		fd = get_pinned_fd("perf_sample_filter");
+		if (fd < 0) {
+			ret = fd;
+			goto err;
+		}
+
+		for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
+			for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
+				ret = ioctl(FD(evsel, x, y), PERF_EVENT_IOC_SET_BPF, fd);
+				if (ret < 0) {
+					pr_err("Failed to attach perf sample-filter\n");
+					goto err;
+				}
+			}
+		}
+
+		close(fd);
+		free(entry);
+		return 0;
 	}
 
-	if (sample_filter_bpf__load(skel) < 0) {
+	skel = sample_filter_bpf__open_and_load();
+	if (!skel) {
+		ret = -errno;
 		pr_err("Failed to load perf sample-filter BPF skeleton\n");
-		ret = -EPERM;
 		goto err;
 	}
 
-	if (needs_pid_hash) {
-		/* The filters map is shared among other processes  */
-		ret = update_pid_hash(skel, evsel, entry);
-		if (ret < 0)
-			goto err;
-	} else {
-		i = 0;
-		fd = bpf_map__fd(skel->maps.filters);
-
-		/* The filters map has only one entry in this case */
-		if (bpf_map_update_elem(fd, &i, entry, BPF_ANY) < 0) {
-			ret = -errno;
-			pr_err("Failed to update the filter map\n");
-			goto err;
-		}
+	i = 0;
+	fd = bpf_map__fd(skel->maps.filters);
+
+	/* The filters map has only one entry in this case */
+	if (bpf_map_update_elem(fd, &i, entry, BPF_ANY) < 0) {
+		ret = -errno;
+		pr_err("Failed to update the filter map\n");
+		goto err;
 	}
 
 	prog = skel->progs.perf_sample_filter;
@@ -306,6 +333,15 @@ int perf_bpf_filter__destroy(struct evsel *evsel)
 		free(expr);
 	}
 	sample_filter_bpf__destroy(evsel->bpf_skel);
+
+	if (pinned_filter_idx >= 0) {
+		int fd = get_pinned_fd("filters");
+
+		bpf_map_delete_elem(fd, &pinned_filter_idx);
+		pinned_filter_idx = -1;
+		close(fd);
+	}
+
 	return 0;
 }
 
@@ -349,3 +385,129 @@ int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
 
 	return ret;
 }
+
+int perf_bpf_filter__pin(void)
+{
+	struct sample_filter_bpf *skel;
+	char *path = NULL;
+	int dir_fd, ret = -1;
+
+	skel = sample_filter_bpf__open();
+	if (!skel) {
+		ret = -errno;
+		pr_err("Failed to open perf sample-filter BPF skeleton\n");
+		goto err;
+	}
+
+	/* pinned program will use pid-hash */
+	bpf_map__set_max_entries(skel->maps.filters, MAX_FILTERS);
+	bpf_map__set_max_entries(skel->maps.pid_hash, MAX_PIDS);
+	skel->rodata->use_pid_hash = 1;
+
+	if (sample_filter_bpf__load(skel) < 0) {
+		ret = -errno;
+		pr_err("Failed to load perf sample-filter BPF skeleton\n");
+		goto err;
+	}
+
+	if (asprintf(&path, "%s/fs/bpf/%s", sysfs__mountpoint(),
+		     PERF_BPF_FILTER_PIN_PATH) < 0) {
+		ret = -errno;
+		pr_err("Failed to allocate pathname in the BPF-fs\n");
+		goto err;
+	}
+
+	ret = bpf_object__pin(skel->obj, path);
+	if (ret < 0) {
+		pr_err("Failed to pin BPF filter objects\n");
+		goto err;
+	}
+
+	/* setup access permissions for the pinned objects */
+	dir_fd = open(path, O_PATH);
+	if (dir_fd < 0) {
+		bpf_object__unpin(skel->obj, path);
+		ret = dir_fd;
+		goto err;
+	}
+
+	/* BPF-fs root has the sticky bit */
+	if (fchmodat(dir_fd, "..", 01755, 0) < 0) {
+		pr_debug("chmod for BPF-fs failed\n");
+		ret = -errno;
+		goto err_close;
+	}
+
+	/* perf_filter directory */
+	if (fchmodat(dir_fd, ".", 0755, 0) < 0) {
+		pr_debug("chmod for perf_filter directory failed?\n");
+		ret = -errno;
+		goto err_close;
+	}
+
+	/* programs need write permission for some reason */
+	if (fchmodat(dir_fd, "perf_sample_filter", 0777, 0) < 0) {
+		pr_debug("chmod for perf_sample_filter failed\n");
+		ret = -errno;
+	}
+	/* maps */
+	if (fchmodat(dir_fd, "filters", 0666, 0) < 0) {
+		pr_debug("chmod for filters failed\n");
+		ret = -errno;
+	}
+	if (fchmodat(dir_fd, "pid_hash", 0666, 0) < 0) {
+		pr_debug("chmod for pid_hash failed\n");
+		ret = -errno;
+	}
+
+err_close:
+	close(dir_fd);
+
+err:
+	free(path);
+	sample_filter_bpf__destroy(skel);
+	return ret;
+}
+
+int perf_bpf_filter__unpin(void)
+{
+	struct sample_filter_bpf *skel;
+	char *path = NULL;
+	int ret = -1;
+
+	skel = sample_filter_bpf__open_and_load();
+	if (!skel) {
+		ret = -errno;
+		pr_err("Failed to open perf sample-filter BPF skeleton\n");
+		goto err;
+	}
+
+	if (asprintf(&path, "%s/fs/bpf/%s", sysfs__mountpoint(),
+		     PERF_BPF_FILTER_PIN_PATH) < 0) {
+		ret = -errno;
+		pr_err("Failed to allocate pathname in the BPF-fs\n");
+		goto err;
+	}
+
+	ret = bpf_object__unpin(skel->obj, path);
+
+err:
+	free(path);
+	sample_filter_bpf__destroy(skel);
+	return ret;
+}
+
+static int get_pinned_fd(const char *name)
+{
+	char *path = NULL;
+	int fd;
+
+	if (asprintf(&path, "%s/fs/bpf/%s/%s", sysfs__mountpoint(),
+		     PERF_BPF_FILTER_PIN_PATH, name) < 0)
+		return -1;
+
+	fd = bpf_obj_get(path);
+
+	free(path);
+	return fd;
+}
diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
index 605a3d0226e0..916ed7770b73 100644
--- a/tools/perf/util/bpf-filter.h
+++ b/tools/perf/util/bpf-filter.h
@@ -18,6 +18,9 @@ struct perf_bpf_filter_expr {
 struct evsel;
 struct target;
 
+/* path in BPF-fs for the pinned program and maps */
+#define PERF_BPF_FILTER_PIN_PATH  "perf_filter"
+
 #ifdef HAVE_BPF_SKEL
 struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term term,
 						       int part,
@@ -27,6 +30,8 @@ int perf_bpf_filter__parse(struct list_head *expr_head, const char *str);
 int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target);
 int perf_bpf_filter__destroy(struct evsel *evsel);
 u64 perf_bpf_filter__lost_count(struct evsel *evsel);
+int perf_bpf_filter__pin(void);
+int perf_bpf_filter__unpin(void);
 
 #else /* !HAVE_BPF_SKEL */
 
@@ -48,5 +53,13 @@ static inline u64 perf_bpf_filter__lost_count(struct evsel *evsel __maybe_unused
 {
 	return 0;
 }
+static inline int perf_bpf_filter__pin(void)
+{
+	return -EOPNOTSUPP;
+}
+static inline int perf_bpf_filter__unpin(void)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* HAVE_BPF_SKEL*/
 #endif /* PERF_UTIL_BPF_FILTER_H */
-- 
2.45.2.803.g4e1b14247a-goog


