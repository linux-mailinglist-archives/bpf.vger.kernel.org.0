Return-Path: <bpf+bounces-44331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322239C1662
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 07:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D031F21AE0
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 06:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D58C1D0F47;
	Fri,  8 Nov 2024 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MY6++DNT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6881D1E86;
	Fri,  8 Nov 2024 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731046504; cv=none; b=IOSzMMyFewdajTXEjvXOk6sh05l3OP94IUkLmB6GmwAMHRoybjiWPzgFNMVnUwcuOs60DhkyV1aa3I6+iA+B0pf/zfd1lKG+zRW3plKq8c2HSWQ1nRi/wRD9KAxfJPQDceoh/WCsJBy/5wDwBEyHf4nXB7VpcRCK03S9bl7HPT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731046504; c=relaxed/simple;
	bh=nrwAbzpRbquX0yj+TlrCdMu+j6Pzyye3LrSzgiBYfbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKjJ18HqEQJR/4Cpv4hqKnSNBW2vo6T9ZQq3ywTz3sjwij8GF9CDooeyhUB+RL4Lkpn5blZbzRBoj5UcbL+vlAWJh182zdSMdJAnsHHWtL0MrmCBvBIseGj4E6DTUmeVLjSSBazPL8h5n0CmvG6K9m3X8amseZedrDgBxVr/rK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MY6++DNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B94C4CECE;
	Fri,  8 Nov 2024 06:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731046503;
	bh=nrwAbzpRbquX0yj+TlrCdMu+j6Pzyye3LrSzgiBYfbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MY6++DNTP1XC+jMaDWOmTY7q9/EJLIwibN+X9/BEtI9WSqmkafQ5yB6hRYzqD48fT
	 PPjmKsg5ejCamaQF7jYuJ81SrZDzvnuOgEiXc8cGqwvGFIx4zZp34f6NeUenut2a0E
	 3LUvnrvYhXtADQjSqOTFIbU2nss+5xPfAtPPRNSOTjAAIag8ZFjSNyciPUiVGqpyMY
	 W9O/F+a8rx+22koNLHr3/I3td3KmUIwXTaq3o94f+cML4GwYZgMWJ93mPbRRrJJjFW
	 7NbJgiD/fHABrNxol88GWgPEiVwLKEnTPWICu9vo7npoM9YraIzLn81j9W5/UwXXm+
	 VVwKHZCG9aTNQ==
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
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v2 3/4] perf lock contention: Resolve slab object name using BPF
Date: Thu,  7 Nov 2024 22:14:58 -0800
Message-ID: <20241108061500.2698340-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
In-Reply-To: <20241108061500.2698340-1-namhyung@kernel.org>
References: <20241108061500.2698340-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_get_kmem_cache() kfunc can return an address of the slab cache
(kmem_cache).  As it has the name of the slab cache from the iterator,
we can use it to symbolize some dynamic kernel locks in a slab.

Before:
  root@virtme-ng:/home/namhyung/project/linux# tools/perf/perf lock con -abl sleep 1
   contended   total wait     max wait     avg wait            address   symbol

           2      3.34 us      2.87 us      1.67 us   ffff9d7800ad9600    (mutex)
           2      2.16 us      1.93 us      1.08 us   ffff9d7804b992d8    (mutex)
           4      1.37 us       517 ns       343 ns   ffff9d78036e6e00    (mutex)
           1      1.27 us      1.27 us      1.27 us   ffff9d7804b99378    (mutex)
           2       845 ns       599 ns       422 ns   ffffffff9e1c3620   delayed_uprobe_lock (mutex)
           1       845 ns       845 ns       845 ns   ffffffff9da0b280   jiffies_lock (spinlock)
           2       377 ns       259 ns       188 ns   ffffffff9e1cf840   pcpu_alloc_mutex (mutex)
           1       305 ns       305 ns       305 ns   ffffffff9e1b4cf8   tracepoint_srcu_srcu_usage (mutex)
           1       295 ns       295 ns       295 ns   ffffffff9e1c0940   pack_mutex (mutex)
           1       232 ns       232 ns       232 ns   ffff9d7804b7d8d8    (mutex)
           1       180 ns       180 ns       180 ns   ffffffff9e1b4c28   tracepoint_srcu_srcu_usage (mutex)
           1       165 ns       165 ns       165 ns   ffffffff9da8b3a0   text_mutex (mutex)

After:
  root@virtme-ng:/home/namhyung/project/linux# tools/perf/perf lock con -abl sleep 1
   contended   total wait     max wait     avg wait            address   symbol

           2      1.95 us      1.77 us       975 ns   ffff9d5e852d3498   &task_struct (mutex)
           1      1.18 us      1.18 us      1.18 us   ffff9d5e852d3538   &task_struct (mutex)
           4      1.12 us       354 ns       279 ns   ffff9d5e841ca800   &kmalloc-cg-512 (mutex)
           2       859 ns       617 ns       429 ns   ffffffffa41c3620   delayed_uprobe_lock (mutex)
           3       691 ns       388 ns       230 ns   ffffffffa41c0940   pack_mutex (mutex)
           3       421 ns       164 ns       140 ns   ffffffffa3a8b3a0   text_mutex (mutex)
           1       409 ns       409 ns       409 ns   ffffffffa41b4cf8   tracepoint_srcu_srcu_usage (mutex)
           2       362 ns       239 ns       181 ns   ffffffffa41cf840   pcpu_alloc_mutex (mutex)
           1       220 ns       220 ns       220 ns   ffff9d5e82b534d8   &signal_cache (mutex)
           1       215 ns       215 ns       215 ns   ffffffffa41b4c28   tracepoint_srcu_srcu_usage (mutex)

Note that the name starts with '&' sign for slab objects to inform they
are dynamic locks.  It won't give the accurate lock or type names but
it's still useful.  We may add type info to the slab cache later to get
the exact name of the lock in the type later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_lock_contention.c         | 52 +++++++++++++++++++
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 21 +++++++-
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 558590c3111390fc..3f127fc6b95f8326 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -2,6 +2,7 @@
 #include "util/cgroup.h"
 #include "util/debug.h"
 #include "util/evlist.h"
+#include "util/hashmap.h"
 #include "util/machine.h"
 #include "util/map.h"
 #include "util/symbol.h"
@@ -20,12 +21,25 @@
 
 static struct lock_contention_bpf *skel;
 static bool has_slab_iter;
+static struct hashmap slab_hash;
+
+static size_t slab_cache_hash(long key, void *ctx __maybe_unused)
+{
+	return key;
+}
+
+static bool slab_cache_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
 
 static void check_slab_cache_iter(struct lock_contention *con)
 {
 	struct btf *btf = btf__load_vmlinux_btf();
 	s32 ret;
 
+	hashmap__init(&slab_hash, slab_cache_hash, slab_cache_equal, /*ctx=*/NULL);
+
 	if (btf == NULL) {
 		pr_debug("BTF loading failed: %s\n", strerror(errno));
 		return;
@@ -49,6 +63,7 @@ static void run_slab_cache_iter(void)
 {
 	int fd;
 	char buf[256];
+	long key, *prev_key;
 
 	if (!has_slab_iter)
 		return;
@@ -64,6 +79,34 @@ static void run_slab_cache_iter(void)
 		continue;
 
 	close(fd);
+
+	/* Read the slab cache map and build a hash with IDs */
+	fd = bpf_map__fd(skel->maps.slab_caches);
+	prev_key = NULL;
+	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
+		struct slab_cache_data *data;
+
+		data = malloc(sizeof(*data));
+		if (data == NULL)
+			break;
+
+		if (bpf_map_lookup_elem(fd, &key, data) < 0)
+			break;
+
+		hashmap__add(&slab_hash, data->id, data);
+		prev_key = &key;
+	}
+}
+
+static void exit_slab_cache_iter(void)
+{
+	struct hashmap_entry *cur;
+	unsigned bkt;
+
+	hashmap__for_each_entry(&slab_hash, cur, bkt)
+		free(cur->pvalue);
+
+	hashmap__clear(&slab_hash);
 }
 
 int lock_contention_prepare(struct lock_contention *con)
@@ -397,6 +440,7 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 
 	if (con->aggr_mode == LOCK_AGGR_ADDR) {
 		int lock_fd = bpf_map__fd(skel->maps.lock_syms);
+		struct slab_cache_data *slab_data;
 
 		/* per-process locks set upper bits of the flags */
 		if (flags & LCD_F_MMAP_LOCK)
@@ -415,6 +459,12 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 				return "rq_lock";
 		}
 
+		/* look slab_hash for dynamic locks in a slab object */
+		if (hashmap__find(&slab_hash, flags & LCB_F_SLAB_ID_MASK, &slab_data)) {
+			snprintf(name_buf, sizeof(name_buf), "&%s", slab_data->name);
+			return name_buf;
+		}
+
 		return "";
 	}
 
@@ -589,5 +639,7 @@ int lock_contention_finish(struct lock_contention *con)
 		cgroup__put(cgrp);
 	}
 
+	exit_slab_cache_iter();
+
 	return 0;
 }
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index fd24ccb00faec0ba..b5bc37955560a58e 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -123,6 +123,8 @@ struct mm_struct___new {
 	struct rw_semaphore mmap_lock;
 } __attribute__((preserve_access_index));
 
+extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym __weak;
+
 /* control flags */
 const volatile int has_cpu;
 const volatile int has_task;
@@ -496,8 +498,23 @@ int contention_end(u64 *ctx)
 		};
 		int err;
 
-		if (aggr_mode == LOCK_AGGR_ADDR)
-			first.flags |= check_lock_type(pelem->lock, pelem->flags);
+		if (aggr_mode == LOCK_AGGR_ADDR) {
+			first.flags |= check_lock_type(pelem->lock,
+						       pelem->flags & LCB_F_TYPE_MASK);
+
+			/* Check if it's from a slab object */
+			if (bpf_get_kmem_cache) {
+				struct kmem_cache *s;
+				struct slab_cache_data *d;
+
+				s = bpf_get_kmem_cache(pelem->lock);
+				if (s != NULL) {
+					d = bpf_map_lookup_elem(&slab_caches, &s);
+					if (d != NULL)
+						first.flags |= d->id;
+				}
+			}
+		}
 
 		err = bpf_map_update_elem(&lock_stat, &key, &first, BPF_NOEXIST);
 		if (err < 0) {
-- 
2.47.0.277.g8800431eea-goog


