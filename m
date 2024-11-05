Return-Path: <bpf+bounces-44061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 526879BD35A
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 18:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E761C2263D
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A481E5728;
	Tue,  5 Nov 2024 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipRGSnc6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AACC1E379F;
	Tue,  5 Nov 2024 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827601; cv=none; b=SVWxN9j7WRl5BkhYQ3z8/AkYxv5iWitSLnhUVQ1u+0thnwCuDojt5WgW9rSis/qjUyZw1EUgGpwLg5VRl24N0I1ittfcleqGIHkficVRZnDGckqMYEUMuqLsDr6AMYF4L1MzHk7XYQcgWhLa1WqJe9rBdZKjYBXcEKuaeu1zwZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827601; c=relaxed/simple;
	bh=rCrRH2SCyNzpCWakImf0vWTxXAc5rQV0bb/Ub7r5nWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fe8lRsSQkHj2Bx7gdpLyATLUbwM6Gdp4Vs1KOYmdANy0UfW5ufyZ+jJP+abGDpS4GjQijGEtqzugslmQgwe1y0xgzFKiovUZbExvNVnDEwlUDHPRBKSBts1y+PKfaG9VsPwkOETRNIjZDy9B/nn3PV/vdLoKKsIY45j/70FaY1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipRGSnc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6670CC4CEE4;
	Tue,  5 Nov 2024 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730827600;
	bh=rCrRH2SCyNzpCWakImf0vWTxXAc5rQV0bb/Ub7r5nWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ipRGSnc6C7vR56Zs1f1AZEN4VhugITS8P5E+iL0kahd5mYHMWiLarIUx1ON7xbEMa
	 uhKH71KXi8tsklx1u/tI3uVbe63x30mMBkKm2v4M2z30XnEyoEtkXP89OtuPFebJUq
	 FB5OqVb/Y+7HaBc3Jxq6bQ025p5EpXZWkeVmqH1Q6ilCbi3RBoSZ+RhbFfB2jeTpfW
	 iH477Ln0WyaDlUEJbcyqhh/PNagxp91uo5cBtM+FzzOiXb6QMO4S+OMjcGgeV18eQU
	 vyia6PMQtFTGB6vM1yYWdgQNj+kJwWYZP9GUnLR51t90R+zD0ge9/m0+m7X8oLzl0E
	 jMxzH4ultBXzg==
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
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH 3/4] perf lock contention: Resolve slab object name using BPF
Date: Tue,  5 Nov 2024 09:26:34 -0800
Message-ID: <20241105172635.2463800-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
In-Reply-To: <20241105172635.2463800-1-namhyung@kernel.org>
References: <20241105172635.2463800-1-namhyung@kernel.org>
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
index a2efd40897bad316..50c3039c647d4d77 100644
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
 	ret = libbpf_get_error(btf);
 	if (ret) {
 		pr_debug("BTF loading failed: %d\n", ret);
@@ -50,6 +64,7 @@ static void run_slab_cache_iter(void)
 {
 	int fd;
 	char buf[256];
+	long key, *prev_key;
 
 	if (!has_slab_iter)
 		return;
@@ -65,6 +80,34 @@ static void run_slab_cache_iter(void)
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
@@ -398,6 +441,7 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 
 	if (con->aggr_mode == LOCK_AGGR_ADDR) {
 		int lock_fd = bpf_map__fd(skel->maps.lock_syms);
+		struct slab_cache_data *slab_data;
 
 		/* per-process locks set upper bits of the flags */
 		if (flags & LCD_F_MMAP_LOCK)
@@ -416,6 +460,12 @@ static const char *lock_contention_get_name(struct lock_contention *con,
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
 
@@ -590,5 +640,7 @@ int lock_contention_finish(struct lock_contention *con)
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
2.47.0.199.ga7371fff76-goog


