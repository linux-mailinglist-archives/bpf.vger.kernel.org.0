Return-Path: <bpf+bounces-21680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E56850269
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 04:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FC21F24C35
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 03:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41F9134DD;
	Sat, 10 Feb 2024 03:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r0p5h5lp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E9F5697
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707535082; cv=none; b=MHQvW4HypsUFUKTcpWTZIQdHGa4vV9K8CEnwMVfxXMBJg5zio3QPUa87cnGv77VndOcp/aQMNY3mtFfBh+fhaEgeqLhv+sWpgmjKpS2Or4MBURLQi9YtkEVBEocaJwQhTvpbO0wijlNGKD9po/zGY8tiqJzTt52aJ74cotOYOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707535082; c=relaxed/simple;
	bh=ab2ODxE6GlvpjmLSgMwqepikk+cEX//9VNIKtWzFkYs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JYzvrxslhV5dywMgt1MBTFjRO6XpLlJ/N0EhI+I1WDMtZ/ZRJ0QP5QOOQQqaSUTf1CX00m7mEUsG525unLr7iNu5ZRvMZoFE3YcmWFowqoqtVnQvRCweRh7jSjeApu9dYon0EnvBD0MoaW7cVs1g+GvH72nYTExMYnlrMNEWcV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r0p5h5lp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6049b563243so31125807b3.1
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 19:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707535078; x=1708139878; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nss9Wgztp1FrON3T/RuDaAUwyjmNbGUpkokUwWOGyTw=;
        b=r0p5h5lpDkwuQ8jDFXLNSbeiF3tjXD5JNmxgPI5P0Ai+wDuYjxxB7pkKnPBgYYsGdk
         aGYTs25vh5zZMbvLxWgYBoq1A1QRfCw7sHt9BMEolOitOz15cfRdFHZKbg9yg2tc5YNT
         +mpA0h3gfwEiAswfMdcABIZHGID/PA4TezSV1PRP+9OtEzYKB/CrC2tji6/vZzoBX1fJ
         Ctf+Q7O51G7PEeIRFJp/FYiXP3YxZMiMQTI885mbCNUqSAMN7leXjnbj61tTcTuCskyq
         xuI54NQTIXV7BkgjOstItvAkjc8GDiNGvoO/3fzbzEZ0ZiVBM+pNdhDvGSoiXLH711xD
         O6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707535078; x=1708139878;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nss9Wgztp1FrON3T/RuDaAUwyjmNbGUpkokUwWOGyTw=;
        b=U5M9yiCyFS6md8g7XZrXMSb22YwBlP8vw4+TA52YZo+X2rs5Flin/BqIwroHNv9hEH
         7TVtrLbp7/G4GT64iXFZOoMk+twEPxxgSXJjOS1cZt1UDC0CeJJtlZH5ISgJ1lHdrAYw
         9s1UQ0EFjjGJMedlArNf/x3g3lIWimfD3W0Al3f4ljyAv7A0F67j0dASykri8GPy+cmv
         fs1dYC7oCr/8ce+Mjxf30LsQa0RPK+1q1M6P95ch+6bQKBgGMAFMGS7zaHCCK8+I6LeS
         Kj6VYPw/ereTo+11eGFPsBTF+FlKgY410NATLlB7tVd6dwa0rfpd0muV233byziEYvq4
         pNDw==
X-Forwarded-Encrypted: i=1; AJvYcCXDf7qOLvZVAe+9Isn0qMf1zzy5kZxU2tVVC2+PagO5V5Pa7rhcuKphBWzUPPmg6cIihgP5GLyqAbleKvy0ztSLpv59
X-Gm-Message-State: AOJu0YyX6CAVT8Tp6j+MoyvfQc5ZGobE8s1pyNyphmUx8ZE+ypN39J7s
	6R9n+9jztbfQ7m+roA0dl/wu1cvuKcISDj1RF/72ROPWZiRf9KkCtoaF3IQgZY8KsbJZYKmLjS9
	vNB7ewg==
X-Google-Smtp-Source: AGHT+IFFEOKw6iRo4G2qzNnodZdUlnIIrhL1mxfhzE77VaCuAbMSTlGsamTVCIgAU9ftESOtChXegFypcJtL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a0d:ddd4:0:b0:5fb:455a:df08 with SMTP id
 g203-20020a0dddd4000000b005fb455adf08mr323728ywe.7.1707535078323; Fri, 09 Feb
 2024 19:17:58 -0800 (PST)
Date: Fri,  9 Feb 2024 19:17:41 -0800
In-Reply-To: <20240210031746.4057262-1-irogers@google.com>
Message-Id: <20240210031746.4057262-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210031746.4057262-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 1/6] perf maps: Switch from rbtree to lazily sorted array
 for addresses
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Liam Howlett <liam.howlett@oracle.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Artem Savkov <asavkov@redhat.com>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>, 
	James Clark <james.clark@arm.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Maps is a collection of maps primarily sorted by the starting address
of the map. Prior to this change the maps were held in an rbtree
requiring 4 pointers per node. Prior to reference count checking, the
rbnode was embedded in the map so 3 pointers per node were
necessary. This change switches the rbtree to an array lazily sorted
by address, much as the array sorting nodes by name. 1 pointer is
needed per node, but to avoid excessive resizing the backing array may
be twice the number of used elements. Meaning the memory overhead is
roughly half that of the rbtree. For a perf record with
"--no-bpf-event -g -a" of true, the memory overhead of perf inject is
reduce fom 3.3MB to 3MB, so 10% or 300KB is saved.

Map inserts always happen at the end of the array. The code tracks
whether the insertion violates the sorting property. O(log n) rb-tree
complexity is switched to O(1).

Remove slides the array, so O(log n) rb-tree complexity is degraded to
O(n).

A find may need to sort the array using qsort which is O(n*log n), but
in general the maps should be sorted and so average performance should
be O(log n) as with the rbtree.

An rbtree node consumes a cache line, but with the array 4 nodes fit
on a cache line. Iteration is simplified to scanning an array rather
than pointer chasing.

Overall it is expected the performance after the change should be
comparable to before, but with half of the memory consumed.

To avoid a list and repeated logic around splitting maps,
maps__merge_in is rewritten in terms of
maps__fixup_overlap_and_insert. maps_merge_in splits the given mapping
inserting remaining gaps. maps__fixup_overlap_and_insert splits the
existing mappings, then adds the incoming mapping. By adding the new
mapping first, then re-inserting the existing mappings the splitting
behavior matches.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/maps.c |    3 +
 tools/perf/util/map.c   |    1 +
 tools/perf/util/maps.c  | 1203 ++++++++++++++++++++++++---------------
 tools/perf/util/maps.h  |   54 +-
 4 files changed, 777 insertions(+), 484 deletions(-)

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index bb3fbfe5a73e..b15417a0d617 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -156,6 +156,9 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 	TEST_ASSERT_VAL("merge check failed", !ret);
 
 	maps__zput(maps);
+	map__zput(map_kcore1);
+	map__zput(map_kcore2);
+	map__zput(map_kcore3);
 	return TEST_OK;
 }
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 7a785a47467e..14a5ea70d81e 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -168,6 +168,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		if (dso == NULL)
 			goto out_delete;
 
+		assert(!dso->kernel);
 		map__init(result, start, start + len, pgoff, dso);
 
 		if (anon || no_dso) {
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 0334fc18d9c6..13dec408b931 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -10,286 +10,496 @@
 #include "ui/ui.h"
 #include "unwind.h"
 
-struct map_rb_node {
-	struct rb_node rb_node;
-	struct map *map;
-};
-
-#define maps__for_each_entry(maps, map) \
-	for (map = maps__first(maps); map; map = map_rb_node__next(map))
+static void check_invariants(const struct maps *maps __maybe_unused)
+{
+#ifndef NDEBUG
+	assert(RC_CHK_ACCESS(maps)->nr_maps <= RC_CHK_ACCESS(maps)->nr_maps_allocated);
+	for (unsigned int i = 0; i < RC_CHK_ACCESS(maps)->nr_maps; i++) {
+		struct map *map = RC_CHK_ACCESS(maps)->maps_by_address[i];
+
+		/* Check map is well-formed. */
+		assert(map__end(map) == 0 || map__start(map) <= map__end(map));
+		/* Expect at least 1 reference count. */
+		assert(refcount_read(map__refcnt(map)) > 0);
+
+		if (map__dso(map) && map__dso(map)->kernel)
+			assert(RC_CHK_EQUAL(map__kmap(map)->kmaps, maps));
+
+		if (i > 0) {
+			struct map *prev = RC_CHK_ACCESS(maps)->maps_by_address[i - 1];
+
+			/* If addresses are sorted... */
+			if (RC_CHK_ACCESS(maps)->maps_by_address_sorted) {
+				/* Maps should be in start address order. */
+				assert(map__start(prev) <= map__start(map));
+				/*
+				 * If the ends of maps aren't broken (during
+				 * construction) then they should be ordered
+				 * too.
+				 */
+				if (!RC_CHK_ACCESS(maps)->ends_broken) {
+					assert(map__end(prev) <= map__end(map));
+					assert(map__end(prev) <= map__start(map) ||
+					       map__start(prev) == map__start(map));
+				}
+			}
+		}
+	}
+	if (RC_CHK_ACCESS(maps)->maps_by_name) {
+		for (unsigned int i = 0; i < RC_CHK_ACCESS(maps)->nr_maps; i++) {
+			struct map *map = RC_CHK_ACCESS(maps)->maps_by_name[i];
 
-#define maps__for_each_entry_safe(maps, map, next) \
-	for (map = maps__first(maps), next = map_rb_node__next(map); map; \
-	     map = next, next = map_rb_node__next(map))
+			/*
+			 * Maps by name maps should be in maps_by_address, so
+			 * the reference count should be higher.
+			 */
+			assert(refcount_read(map__refcnt(map)) > 1);
+		}
+	}
+#endif
+}
 
-static struct rb_root *maps__entries(struct maps *maps)
+static struct map **maps__maps_by_address(const struct maps *maps)
 {
-	return &RC_CHK_ACCESS(maps)->entries;
+	return RC_CHK_ACCESS(maps)->maps_by_address;
 }
 
-static struct rw_semaphore *maps__lock(struct maps *maps)
+static void maps__set_maps_by_address(struct maps *maps, struct map **new)
 {
-	return &RC_CHK_ACCESS(maps)->lock;
+	RC_CHK_ACCESS(maps)->maps_by_address = new;
+
 }
 
-static struct map **maps__maps_by_name(struct maps *maps)
+static struct map ***maps__maps_by_name_addr(struct maps *maps)
 {
-	return RC_CHK_ACCESS(maps)->maps_by_name;
+	return &RC_CHK_ACCESS(maps)->maps_by_name;
 }
 
-static struct map_rb_node *maps__first(struct maps *maps)
+static void maps__set_nr_maps_allocated(struct maps *maps, unsigned int nr_maps_allocated)
 {
-	struct rb_node *first = rb_first(maps__entries(maps));
+	RC_CHK_ACCESS(maps)->nr_maps_allocated = nr_maps_allocated;
+}
 
-	if (first)
-		return rb_entry(first, struct map_rb_node, rb_node);
-	return NULL;
+static void maps__set_nr_maps(struct maps *maps, unsigned int nr_maps)
+{
+	RC_CHK_ACCESS(maps)->nr_maps = nr_maps;
 }
 
-static struct map_rb_node *map_rb_node__next(struct map_rb_node *node)
+/* Not in the header, to aid reference counting. */
+static struct map **maps__maps_by_name(const struct maps *maps)
 {
-	struct rb_node *next;
+	return RC_CHK_ACCESS(maps)->maps_by_name;
 
-	if (!node)
-		return NULL;
+}
 
-	next = rb_next(&node->rb_node);
+static void maps__set_maps_by_name(struct maps *maps, struct map **new)
+{
+	RC_CHK_ACCESS(maps)->maps_by_name = new;
 
-	if (!next)
-		return NULL;
+}
 
-	return rb_entry(next, struct map_rb_node, rb_node);
+static bool maps__maps_by_address_sorted(const struct maps *maps)
+{
+	return RC_CHK_ACCESS(maps)->maps_by_address_sorted;
 }
 
-static struct map_rb_node *maps__find_node(struct maps *maps, struct map *map)
+static void maps__set_maps_by_address_sorted(struct maps *maps, bool value)
 {
-	struct map_rb_node *rb_node;
+	RC_CHK_ACCESS(maps)->maps_by_address_sorted = value;
+}
 
-	maps__for_each_entry(maps, rb_node) {
-		if (rb_node->RC_CHK_ACCESS(map) == RC_CHK_ACCESS(map))
-			return rb_node;
-	}
-	return NULL;
+static bool maps__maps_by_name_sorted(const struct maps *maps)
+{
+	return RC_CHK_ACCESS(maps)->maps_by_name_sorted;
 }
 
-static void maps__init(struct maps *maps, struct machine *machine)
+static void maps__set_maps_by_name_sorted(struct maps *maps, bool value)
 {
-	refcount_set(maps__refcnt(maps), 1);
-	init_rwsem(maps__lock(maps));
-	RC_CHK_ACCESS(maps)->entries = RB_ROOT;
-	RC_CHK_ACCESS(maps)->machine = machine;
-	RC_CHK_ACCESS(maps)->last_search_by_name = NULL;
-	RC_CHK_ACCESS(maps)->nr_maps = 0;
-	RC_CHK_ACCESS(maps)->maps_by_name = NULL;
+	RC_CHK_ACCESS(maps)->maps_by_name_sorted = value;
 }
 
-static void __maps__free_maps_by_name(struct maps *maps)
+static struct rw_semaphore *maps__lock(struct maps *maps)
 {
 	/*
-	 * Free everything to try to do it from the rbtree in the next search
+	 * When the lock is acquired or released the maps invariants should
+	 * hold.
 	 */
-	for (unsigned int i = 0; i < maps__nr_maps(maps); i++)
-		map__put(maps__maps_by_name(maps)[i]);
+	check_invariants(maps);
+	return &RC_CHK_ACCESS(maps)->lock;
+}
 
-	zfree(&RC_CHK_ACCESS(maps)->maps_by_name);
+static void maps__init(struct maps *maps, struct machine *machine)
+{
+	init_rwsem(maps__lock(maps));
+	RC_CHK_ACCESS(maps)->maps_by_address = NULL;
+	RC_CHK_ACCESS(maps)->maps_by_name = NULL;
+	RC_CHK_ACCESS(maps)->machine = machine;
+#ifdef HAVE_LIBUNWIND_SUPPORT
+	RC_CHK_ACCESS(maps)->addr_space = NULL;
+	RC_CHK_ACCESS(maps)->unwind_libunwind_ops = NULL;
+#endif
+	refcount_set(maps__refcnt(maps), 1);
+	RC_CHK_ACCESS(maps)->nr_maps = 0;
 	RC_CHK_ACCESS(maps)->nr_maps_allocated = 0;
+	RC_CHK_ACCESS(maps)->last_search_by_name_idx = 0;
+	RC_CHK_ACCESS(maps)->maps_by_address_sorted = true;
+	RC_CHK_ACCESS(maps)->maps_by_name_sorted = false;
 }
 
-static int __maps__insert(struct maps *maps, struct map *map)
+static void maps__exit(struct maps *maps)
 {
-	struct rb_node **p = &maps__entries(maps)->rb_node;
-	struct rb_node *parent = NULL;
-	const u64 ip = map__start(map);
-	struct map_rb_node *m, *new_rb_node;
+	struct map **maps_by_address = maps__maps_by_address(maps);
+	struct map **maps_by_name = maps__maps_by_name(maps);
 
-	new_rb_node = malloc(sizeof(*new_rb_node));
-	if (!new_rb_node)
-		return -ENOMEM;
+	for (unsigned int i = 0; i < maps__nr_maps(maps); i++) {
+		map__zput(maps_by_address[i]);
+		if (maps_by_name)
+			map__zput(maps_by_name[i]);
+	}
+	zfree(&maps_by_address);
+	zfree(&maps_by_name);
+	unwind__finish_access(maps);
+}
 
-	RB_CLEAR_NODE(&new_rb_node->rb_node);
-	new_rb_node->map = map__get(map);
+struct maps *maps__new(struct machine *machine)
+{
+	struct maps *result;
+	RC_STRUCT(maps) *maps = zalloc(sizeof(*maps));
 
-	while (*p != NULL) {
-		parent = *p;
-		m = rb_entry(parent, struct map_rb_node, rb_node);
-		if (ip < map__start(m->map))
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
-	}
+	if (ADD_RC_CHK(result, maps))
+		maps__init(result, machine);
 
-	rb_link_node(&new_rb_node->rb_node, parent, p);
-	rb_insert_color(&new_rb_node->rb_node, maps__entries(maps));
-	return 0;
+	return result;
 }
 
-int maps__insert(struct maps *maps, struct map *map)
+static void maps__delete(struct maps *maps)
 {
-	int err;
-	const struct dso *dso = map__dso(map);
-
-	down_write(maps__lock(maps));
-	err = __maps__insert(maps, map);
-	if (err)
-		goto out;
+	maps__exit(maps);
+	RC_CHK_FREE(maps);
+}
 
-	++RC_CHK_ACCESS(maps)->nr_maps;
+struct maps *maps__get(struct maps *maps)
+{
+	struct maps *result;
 
-	if (dso && dso->kernel) {
-		struct kmap *kmap = map__kmap(map);
+	if (RC_CHK_GET(result, maps))
+		refcount_inc(maps__refcnt(maps));
 
-		if (kmap)
-			kmap->kmaps = maps;
-		else
-			pr_err("Internal error: kernel dso with non kernel map\n");
-	}
+	return result;
+}
 
+void maps__put(struct maps *maps)
+{
+	if (maps && refcount_dec_and_test(maps__refcnt(maps)))
+		maps__delete(maps);
+	else
+		RC_CHK_PUT(maps);
+}
 
+static void __maps__free_maps_by_name(struct maps *maps)
+{
 	/*
-	 * If we already performed some search by name, then we need to add the just
-	 * inserted map and resort.
+	 * Free everything to try to do it from the rbtree in the next search
 	 */
-	if (maps__maps_by_name(maps)) {
-		if (maps__nr_maps(maps) > RC_CHK_ACCESS(maps)->nr_maps_allocated) {
-			int nr_allocate = maps__nr_maps(maps) * 2;
-			struct map **maps_by_name = realloc(maps__maps_by_name(maps),
-							    nr_allocate * sizeof(map));
+	for (unsigned int i = 0; i < maps__nr_maps(maps); i++)
+		map__put(maps__maps_by_name(maps)[i]);
 
-			if (maps_by_name == NULL) {
-				__maps__free_maps_by_name(maps);
-				err = -ENOMEM;
-				goto out;
-			}
+	zfree(&RC_CHK_ACCESS(maps)->maps_by_name);
+}
 
-			RC_CHK_ACCESS(maps)->maps_by_name = maps_by_name;
-			RC_CHK_ACCESS(maps)->nr_maps_allocated = nr_allocate;
+static int map__start_cmp(const void *a, const void *b)
+{
+	const struct map *map_a = *(const struct map * const *)a;
+	const struct map *map_b = *(const struct map * const *)b;
+	u64 map_a_start = map__start(map_a);
+	u64 map_b_start = map__start(map_b);
+
+	if (map_a_start == map_b_start) {
+		u64 map_a_end = map__end(map_a);
+		u64 map_b_end = map__end(map_b);
+
+		if  (map_a_end == map_b_end) {
+			/* Ensure maps with the same addresses have a fixed order. */
+			if (RC_CHK_ACCESS(map_a) == RC_CHK_ACCESS(map_b))
+				return 0;
+			return (intptr_t)RC_CHK_ACCESS(map_a) > (intptr_t)RC_CHK_ACCESS(map_b)
+				? 1 : -1;
 		}
-		maps__maps_by_name(maps)[maps__nr_maps(maps) - 1] = map__get(map);
-		__maps__sort_by_name(maps);
+		return map_a_end > map_b_end ? 1 : -1;
 	}
- out:
-	up_write(maps__lock(maps));
-	return err;
+	return map_a_start > map_b_start ? 1 : -1;
 }
 
-static void __maps__remove(struct maps *maps, struct map_rb_node *rb_node)
+static void __maps__sort_by_address(struct maps *maps)
 {
-	rb_erase_init(&rb_node->rb_node, maps__entries(maps));
-	map__put(rb_node->map);
-	free(rb_node);
+	if (maps__maps_by_address_sorted(maps))
+		return;
+
+	qsort(maps__maps_by_address(maps),
+		maps__nr_maps(maps),
+		sizeof(struct map *),
+		map__start_cmp);
+	maps__set_maps_by_address_sorted(maps, true);
 }
 
-void maps__remove(struct maps *maps, struct map *map)
+static void maps__sort_by_address(struct maps *maps)
 {
-	struct map_rb_node *rb_node;
-
 	down_write(maps__lock(maps));
-	if (RC_CHK_ACCESS(maps)->last_search_by_name == map)
-		RC_CHK_ACCESS(maps)->last_search_by_name = NULL;
-
-	rb_node = maps__find_node(maps, map);
-	assert(rb_node->RC_CHK_ACCESS(map) == RC_CHK_ACCESS(map));
-	__maps__remove(maps, rb_node);
-	if (maps__maps_by_name(maps))
-		__maps__free_maps_by_name(maps);
-	--RC_CHK_ACCESS(maps)->nr_maps;
+	__maps__sort_by_address(maps);
 	up_write(maps__lock(maps));
 }
 
-static void __maps__purge(struct maps *maps)
+static int map__strcmp(const void *a, const void *b)
 {
-	struct map_rb_node *pos, *next;
-
-	if (maps__maps_by_name(maps))
-		__maps__free_maps_by_name(maps);
+	const struct map *map_a = *(const struct map * const *)a;
+	const struct map *map_b = *(const struct map * const *)b;
+	const struct dso *dso_a = map__dso(map_a);
+	const struct dso *dso_b = map__dso(map_b);
+	int ret = strcmp(dso_a->short_name, dso_b->short_name);
 
-	maps__for_each_entry_safe(maps, pos, next) {
-		rb_erase_init(&pos->rb_node,  maps__entries(maps));
-		map__put(pos->map);
-		free(pos);
+	if (ret == 0 && RC_CHK_ACCESS(map_a) != RC_CHK_ACCESS(map_b)) {
+		/* Ensure distinct but name equal maps have an order. */
+		return map__start_cmp(a, b);
 	}
+	return ret;
 }
 
-static void maps__exit(struct maps *maps)
+static int maps__sort_by_name(struct maps *maps)
 {
+	int err = 0;
 	down_write(maps__lock(maps));
-	__maps__purge(maps);
+	if (!maps__maps_by_name_sorted(maps)) {
+		struct map **maps_by_name = maps__maps_by_name(maps);
+
+		if (!maps_by_name) {
+			maps_by_name = malloc(RC_CHK_ACCESS(maps)->nr_maps_allocated *
+					sizeof(*maps_by_name));
+			if (!maps_by_name)
+				err = -ENOMEM;
+			else {
+				struct map **maps_by_address = maps__maps_by_address(maps);
+				unsigned int n = maps__nr_maps(maps);
+
+				maps__set_maps_by_name(maps, maps_by_name);
+				for (unsigned int i = 0; i < n; i++)
+					maps_by_name[i] = map__get(maps_by_address[i]);
+			}
+		}
+		if (!err) {
+			qsort(maps_by_name,
+				maps__nr_maps(maps),
+				sizeof(struct map *),
+				map__strcmp);
+			maps__set_maps_by_name_sorted(maps, true);
+		}
+	}
 	up_write(maps__lock(maps));
+	return err;
 }
 
-bool maps__empty(struct maps *maps)
+static unsigned int maps__by_address_index(const struct maps *maps, const struct map *map)
 {
-	return !maps__first(maps);
+	struct map **maps_by_address = maps__maps_by_address(maps);
+
+	if (maps__maps_by_address_sorted(maps)) {
+		struct map **mapp =
+			bsearch(&map, maps__maps_by_address(maps), maps__nr_maps(maps),
+				sizeof(*mapp), map__start_cmp);
+
+		if (mapp)
+			return mapp - maps_by_address;
+	} else {
+		for (unsigned int i = 0; i < maps__nr_maps(maps); i++) {
+			if (RC_CHK_ACCESS(maps_by_address[i]) == RC_CHK_ACCESS(map))
+				return i;
+		}
+	}
+	pr_err("Map missing from maps");
+	return -1;
 }
 
-struct maps *maps__new(struct machine *machine)
+static unsigned int maps__by_name_index(const struct maps *maps, const struct map *map)
 {
-	struct maps *result;
-	RC_STRUCT(maps) *maps = zalloc(sizeof(*maps));
+	struct map **maps_by_name = maps__maps_by_name(maps);
+
+	if (maps__maps_by_name_sorted(maps)) {
+		struct map **mapp =
+			bsearch(&map, maps_by_name, maps__nr_maps(maps),
+				sizeof(*mapp), map__strcmp);
+
+		if (mapp)
+			return mapp - maps_by_name;
+	} else {
+		for (unsigned int i = 0; i < maps__nr_maps(maps); i++) {
+			if (RC_CHK_ACCESS(maps_by_name[i]) == RC_CHK_ACCESS(map))
+				return i;
+		}
+	}
+	pr_err("Map missing from maps");
+	return -1;
+}
 
-	if (ADD_RC_CHK(result, maps))
-		maps__init(result, machine);
+static int __maps__insert(struct maps *maps, struct map *new)
+{
+	struct map **maps_by_address = maps__maps_by_address(maps);
+	struct map **maps_by_name = maps__maps_by_name(maps);
+	const struct dso *dso = map__dso(new);
+	unsigned int nr_maps = maps__nr_maps(maps);
+	unsigned int nr_allocate = RC_CHK_ACCESS(maps)->nr_maps_allocated;
+
+	if (nr_maps + 1 > nr_allocate) {
+		nr_allocate = !nr_allocate ? 32 : nr_allocate * 2;
+
+		maps_by_address = realloc(maps_by_address, nr_allocate * sizeof(new));
+		if (!maps_by_address)
+			return -ENOMEM;
+
+		maps__set_maps_by_address(maps, maps_by_address);
+		if (maps_by_name) {
+			maps_by_name = realloc(maps_by_name, nr_allocate * sizeof(new));
+			if (!maps_by_name) {
+				/*
+				 * If by name fails, just disable by name and it will
+				 * recompute next time it is required.
+				 */
+				__maps__free_maps_by_name(maps);
+			}
+			maps__set_maps_by_name(maps, maps_by_name);
+		}
+		RC_CHK_ACCESS(maps)->nr_maps_allocated = nr_allocate;
+	}
+	/* Insert the value at the end. */
+	maps_by_address[nr_maps] = map__get(new);
+	if (maps_by_name)
+		maps_by_name[nr_maps] = map__get(new);
 
-	return result;
+	nr_maps++;
+	RC_CHK_ACCESS(maps)->nr_maps = nr_maps;
+
+	/*
+	 * Recompute if things are sorted. If things are inserted in a sorted
+	 * manner, for example by processing /proc/pid/maps, then no
+	 * sorting/resorting will be necessary.
+	 */
+	if (nr_maps == 1) {
+		/* If there's just 1 entry then maps are sorted. */
+		maps__set_maps_by_address_sorted(maps, true);
+		maps__set_maps_by_name_sorted(maps, maps_by_name != NULL);
+	} else {
+		/* Sorted if maps were already sorted and this map starts after the last one. */
+		maps__set_maps_by_address_sorted(maps,
+			maps__maps_by_address_sorted(maps) &&
+			map__end(maps_by_address[nr_maps - 2]) <= map__start(new));
+		maps__set_maps_by_name_sorted(maps, false);
+	}
+	if (map__end(new) < map__start(new))
+		RC_CHK_ACCESS(maps)->ends_broken = true;
+	if (dso && dso->kernel) {
+		struct kmap *kmap = map__kmap(new);
+
+		if (kmap)
+			kmap->kmaps = maps;
+		else
+			pr_err("Internal error: kernel dso with non kernel map\n");
+	}
+	return 0;
 }
 
-static void maps__delete(struct maps *maps)
+int maps__insert(struct maps *maps, struct map *map)
 {
-	maps__exit(maps);
-	unwind__finish_access(maps);
-	RC_CHK_FREE(maps);
+	int ret;
+
+	down_write(maps__lock(maps));
+	ret = __maps__insert(maps, map);
+	up_write(maps__lock(maps));
+	return ret;
 }
 
-struct maps *maps__get(struct maps *maps)
+static void __maps__remove(struct maps *maps, struct map *map)
 {
-	struct maps *result;
+	struct map **maps_by_address = maps__maps_by_address(maps);
+	struct map **maps_by_name = maps__maps_by_name(maps);
+	unsigned int nr_maps = maps__nr_maps(maps);
+	unsigned int address_idx;
+
+	/* Slide later mappings over the one to remove */
+	address_idx = maps__by_address_index(maps, map);
+	map__put(maps_by_address[address_idx]);
+	memmove(&maps_by_address[address_idx],
+		&maps_by_address[address_idx + 1],
+		(nr_maps - address_idx - 1) * sizeof(*maps_by_address));
+
+	if (maps_by_name) {
+		unsigned int name_idx = maps__by_name_index(maps, map);
+
+		map__put(maps_by_name[name_idx]);
+		memmove(&maps_by_name[name_idx],
+			&maps_by_name[name_idx + 1],
+			(nr_maps - name_idx - 1) *  sizeof(*maps_by_name));
+	}
 
-	if (RC_CHK_GET(result, maps))
-		refcount_inc(maps__refcnt(maps));
+	--RC_CHK_ACCESS(maps)->nr_maps;
+}
 
-	return result;
+void maps__remove(struct maps *maps, struct map *map)
+{
+	down_write(maps__lock(maps));
+	__maps__remove(maps, map);
+	up_write(maps__lock(maps));
 }
 
-void maps__put(struct maps *maps)
+bool maps__empty(struct maps *maps)
 {
-	if (maps && refcount_dec_and_test(maps__refcnt(maps)))
-		maps__delete(maps);
-	else
-		RC_CHK_PUT(maps);
+	return maps__nr_maps(maps) == 0;
 }
 
 int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data), void *data)
 {
-	struct map_rb_node *pos;
+	bool done = false;
 	int ret = 0;
 
-	down_read(maps__lock(maps));
-	maps__for_each_entry(maps, pos)	{
-		ret = cb(pos->map, data);
-		if (ret)
-			break;
+	/* See locking/sorting note. */
+	while (!done) {
+		down_read(maps__lock(maps));
+		if (maps__maps_by_address_sorted(maps)) {
+			/*
+			 * maps__for_each_map callbacks may buggily/unsafely
+			 * insert into maps_by_address. Deliberately reload
+			 * maps__nr_maps and maps_by_address on each iteration
+			 * to avoid using memory freed by maps__insert growing
+			 * the array - this may cause maps to be skipped or
+			 * repeated.
+			 */
+			for (unsigned int i = 0; i < maps__nr_maps(maps); i++) {
+				struct map **maps_by_address = maps__maps_by_address(maps);
+				struct map *map = maps_by_address[i];
+
+				ret = cb(map, data);
+				if (ret)
+					break;
+			}
+			done = true;
+		}
+		up_read(maps__lock(maps));
+		if (!done)
+			maps__sort_by_address(maps);
 	}
-	up_read(maps__lock(maps));
 	return ret;
 }
 
 void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data)
 {
-	struct map_rb_node *pos, *next;
-	unsigned int start_nr_maps;
+	struct map **maps_by_address;
 
 	down_write(maps__lock(maps));
 
-	start_nr_maps = maps__nr_maps(maps);
-	maps__for_each_entry_safe(maps, pos, next)	{
-		if (cb(pos->map, data)) {
-			__maps__remove(maps, pos);
-			--RC_CHK_ACCESS(maps)->nr_maps;
-		}
+	maps_by_address = maps__maps_by_address(maps);
+	for (unsigned int i = 0; i < maps__nr_maps(maps);) {
+		if (cb(maps_by_address[i], data))
+			__maps__remove(maps, maps_by_address[i]);
+		else
+			i++;
 	}
-	if (maps__maps_by_name(maps) && start_nr_maps != maps__nr_maps(maps))
-		__maps__free_maps_by_name(maps);
-
 	up_write(maps__lock(maps));
 }
 
@@ -300,7 +510,7 @@ struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
 	/* Ensure map is loaded before using map->map_ip */
 	if (map != NULL && map__load(map) >= 0) {
 		if (mapp != NULL)
-			*mapp = map;
+			*mapp = map; // TODO: map_put on else path when find returns a get.
 		return map__find_symbol(map, map__map_ip(map, addr));
 	}
 
@@ -348,7 +558,7 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
 	if (ams->addr < map__start(ams->ms.map) || ams->addr >= map__end(ams->ms.map)) {
 		if (maps == NULL)
 			return -1;
-		ams->ms.map = maps__find(maps, ams->addr);
+		ams->ms.map = maps__find(maps, ams->addr);  // TODO: map_get
 		if (ams->ms.map == NULL)
 			return -1;
 	}
@@ -393,24 +603,28 @@ size_t maps__fprintf(struct maps *maps, FILE *fp)
  * Find first map where end > map->start.
  * Same as find_vma() in kernel.
  */
-static struct rb_node *first_ending_after(struct maps *maps, const struct map *map)
+static unsigned int first_ending_after(struct maps *maps, const struct map *map)
 {
-	struct rb_root *root;
-	struct rb_node *next, *first;
+	struct map **maps_by_address = maps__maps_by_address(maps);
+	int low = 0, high = (int)maps__nr_maps(maps) - 1, first = high + 1;
+
+	assert(maps__maps_by_address_sorted(maps));
+	if (low <= high && map__end(maps_by_address[0]) > map__start(map))
+		return 0;
 
-	root = maps__entries(maps);
-	next = root->rb_node;
-	first = NULL;
-	while (next) {
-		struct map_rb_node *pos = rb_entry(next, struct map_rb_node, rb_node);
+	while (low <= high) {
+		int mid = (low + high) / 2;
+		struct map *pos = maps_by_address[mid];
 
-		if (map__end(pos->map) > map__start(map)) {
-			first = next;
-			if (map__start(pos->map) <= map__start(map))
+		if (map__end(pos) > map__start(map)) {
+			first = mid;
+			if (map__start(pos) <= map__start(map)) {
+				/* Entry overlaps map. */
 				break;
-			next = next->rb_left;
+			}
+			high = mid - 1;
 		} else
-			next = next->rb_right;
+			low = mid + 1;
 	}
 	return first;
 }
@@ -419,171 +633,249 @@ static struct rb_node *first_ending_after(struct maps *maps, const struct map *m
  * Adds new to maps, if new overlaps existing entries then the existing maps are
  * adjusted or removed so that new fits without overlapping any entries.
  */
-int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
+static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 {
-
-	struct rb_node *next;
+	struct map **maps_by_address;
 	int err = 0;
 	FILE *fp = debug_file();
 
-	down_write(maps__lock(maps));
+sort_again:
+	if (!maps__maps_by_address_sorted(maps))
+		__maps__sort_by_address(maps);
 
-	next = first_ending_after(maps, new);
-	while (next && !err) {
-		struct map_rb_node *pos = rb_entry(next, struct map_rb_node, rb_node);
-		next = rb_next(&pos->rb_node);
+	maps_by_address = maps__maps_by_address(maps);
+	/*
+	 * Iterate through entries where the end of the existing entry is
+	 * greater-than the new map's start.
+	 */
+	for (unsigned int i = first_ending_after(maps, new); i < maps__nr_maps(maps); ) {
+		struct map *pos = maps_by_address[i];
+		struct map *before = NULL, *after = NULL;
 
 		/*
 		 * Stop if current map starts after map->end.
 		 * Maps are ordered by start: next will not overlap for sure.
 		 */
-		if (map__start(pos->map) >= map__end(new))
+		if (map__start(pos) >= map__end(new))
 			break;
 
-		if (verbose >= 2) {
-
-			if (use_browser) {
-				pr_debug("overlapping maps in %s (disable tui for more info)\n",
-					 map__dso(new)->name);
-			} else {
-				pr_debug("overlapping maps:\n");
-				map__fprintf(new, fp);
-				map__fprintf(pos->map, fp);
-			}
+		if (use_browser) {
+			pr_debug("overlapping maps in %s (disable tui for more info)\n",
+				map__dso(new)->name);
+		} else if (verbose >= 2) {
+			pr_debug("overlapping maps:\n");
+			map__fprintf(new, fp);
+			map__fprintf(pos, fp);
 		}
 
-		rb_erase_init(&pos->rb_node, maps__entries(maps));
 		/*
 		 * Now check if we need to create new maps for areas not
 		 * overlapped by the new map:
 		 */
-		if (map__start(new) > map__start(pos->map)) {
-			struct map *before = map__clone(pos->map);
+		if (map__start(new) > map__start(pos)) {
+			/* Map starts within existing map. Need to shorten the existing map. */
+			before = map__clone(pos);
 
 			if (before == NULL) {
 				err = -ENOMEM;
-				goto put_map;
+				goto out_err;
 			}
-
 			map__set_end(before, map__start(new));
-			err = __maps__insert(maps, before);
-			if (err) {
-				map__put(before);
-				goto put_map;
-			}
 
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(before, fp);
-			map__put(before);
 		}
-
-		if (map__end(new) < map__end(pos->map)) {
-			struct map *after = map__clone(pos->map);
+		if (map__end(new) < map__end(pos)) {
+			/* The new map isn't as long as the existing map. */
+			after = map__clone(pos);
 
 			if (after == NULL) {
+				map__zput(before);
 				err = -ENOMEM;
-				goto put_map;
+				goto out_err;
 			}
 
 			map__set_start(after, map__end(new));
-			map__add_pgoff(after, map__end(new) - map__start(pos->map));
-			assert(map__map_ip(pos->map, map__end(new)) ==
-				map__map_ip(after, map__end(new)));
-			err = __maps__insert(maps, after);
-			if (err) {
-				map__put(after);
-				goto put_map;
-			}
+			map__add_pgoff(after, map__end(new) - map__start(pos));
+			assert(map__map_ip(pos, map__end(new)) ==
+			       map__map_ip(after, map__end(new)));
+
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(after, fp);
-			map__put(after);
 		}
-put_map:
-		map__put(pos->map);
-		free(pos);
+		/*
+		 * If adding one entry, for `before` or `after`, we can replace
+		 * the existing entry. If both `before` and `after` are
+		 * necessary than an insert is needed. If the existing entry
+		 * entirely overlaps the existing entry it can just be removed.
+		 */
+		if (before) {
+			map__put(maps_by_address[i]);
+			maps_by_address[i] = before;
+			/* Maps are still ordered, go to next one. */
+			i++;
+			if (after) {
+				__maps__insert(maps, after);
+				map__put(after);
+				if (!maps__maps_by_address_sorted(maps)) {
+					/*
+					 * Sorting broken so invariants don't
+					 * hold, sort and go again.
+					 */
+					goto sort_again;
+				}
+				/*
+				 * Maps are still ordered, skip after and go to
+				 * next one (terminate loop).
+				 */
+				i++;
+			}
+		} else if (after) {
+			map__put(maps_by_address[i]);
+			maps_by_address[i] = after;
+			/* Maps are ordered, go to next one. */
+			i++;
+		} else {
+			__maps__remove(maps, pos);
+			/*
+			 * Maps are ordered but no need to increase `i` as the
+			 * later maps were moved down.
+			 */
+		}
+		check_invariants(maps);
 	}
 	/* Add the map. */
-	err = __maps__insert(maps, new);
-	up_write(maps__lock(maps));
+	__maps__insert(maps, new);
+out_err:
 	return err;
 }
 
-int maps__copy_from(struct maps *maps, struct maps *parent)
+int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 {
 	int err;
-	struct map_rb_node *rb_node;
 
+	down_write(maps__lock(maps));
+	err =  __maps__fixup_overlap_and_insert(maps, new);
+	up_write(maps__lock(maps));
+	return err;
+}
+
+int maps__copy_from(struct maps *dest, struct maps *parent)
+{
+	/* Note, if struct map were immutable then cloning could use ref counts. */
+	struct map **parent_maps_by_address;
+	int err = 0;
+	unsigned int n;
+
+	down_write(maps__lock(dest));
 	down_read(maps__lock(parent));
 
-	maps__for_each_entry(parent, rb_node) {
-		struct map *new = map__clone(rb_node->map);
+	parent_maps_by_address = maps__maps_by_address(parent);
+	n = maps__nr_maps(parent);
+	if (maps__empty(dest)) {
+		/* No existing mappings so just copy from parent to avoid reallocs in insert. */
+		unsigned int nr_maps_allocated = RC_CHK_ACCESS(parent)->nr_maps_allocated;
+		struct map **dest_maps_by_address =
+			malloc(nr_maps_allocated * sizeof(struct map *));
+		struct map **dest_maps_by_name = NULL;
 
-		if (new == NULL) {
+		if (!dest_maps_by_address)
 			err = -ENOMEM;
-			goto out_unlock;
+		else {
+			if (maps__maps_by_name(parent)) {
+				dest_maps_by_name =
+					malloc(nr_maps_allocated * sizeof(struct map *));
+			}
+
+			RC_CHK_ACCESS(dest)->maps_by_address = dest_maps_by_address;
+			RC_CHK_ACCESS(dest)->maps_by_name = dest_maps_by_name;
+			RC_CHK_ACCESS(dest)->nr_maps_allocated = nr_maps_allocated;
 		}
 
-		err = unwind__prepare_access(maps, new, NULL);
-		if (err)
-			goto out_unlock;
+		for (unsigned int i = 0; !err && i < n; i++) {
+			struct map *pos = parent_maps_by_address[i];
+			struct map *new = map__clone(pos);
 
-		err = maps__insert(maps, new);
-		if (err)
-			goto out_unlock;
+			if (!new)
+				err = -ENOMEM;
+			else {
+				err = unwind__prepare_access(dest, new, NULL);
+				if (!err) {
+					dest_maps_by_address[i] = new;
+					if (dest_maps_by_name)
+						dest_maps_by_name[i] = map__get(new);
+					RC_CHK_ACCESS(dest)->nr_maps = i + 1;
+				}
+			}
+			if (err)
+				map__put(new);
+		}
+		maps__set_maps_by_address_sorted(dest, maps__maps_by_address_sorted(parent));
+		if (!err) {
+			RC_CHK_ACCESS(dest)->last_search_by_name_idx =
+				RC_CHK_ACCESS(parent)->last_search_by_name_idx;
+			maps__set_maps_by_name_sorted(dest,
+						dest_maps_by_name &&
+						maps__maps_by_name_sorted(parent));
+		} else {
+			RC_CHK_ACCESS(dest)->last_search_by_name_idx = 0;
+			maps__set_maps_by_name_sorted(dest, false);
+		}
+	} else {
+		/* Unexpected copying to a maps containing entries. */
+		for (unsigned int i = 0; !err && i < n; i++) {
+			struct map *pos = parent_maps_by_address[i];
+			struct map *new = map__clone(pos);
 
-		map__put(new);
+			if (!new)
+				err = -ENOMEM;
+			else {
+				err = unwind__prepare_access(dest, new, NULL);
+				if (!err)
+					err = __maps__insert(dest, new);
+			}
+			map__put(new);
+		}
 	}
-
-	err = 0;
-out_unlock:
 	up_read(maps__lock(parent));
+	up_write(maps__lock(dest));
 	return err;
 }
 
-struct map *maps__find(struct maps *maps, u64 ip)
+static int map__addr_cmp(const void *key, const void *entry)
 {
-	struct rb_node *p;
-	struct map_rb_node *m;
-
-
-	down_read(maps__lock(maps));
-
-	p = maps__entries(maps)->rb_node;
-	while (p != NULL) {
-		m = rb_entry(p, struct map_rb_node, rb_node);
-		if (ip < map__start(m->map))
-			p = p->rb_left;
-		else if (ip >= map__end(m->map))
-			p = p->rb_right;
-		else
-			goto out;
-	}
+	const u64 ip = *(const u64 *)key;
+	const struct map *map = *(const struct map * const *)entry;
 
-	m = NULL;
-out:
-	up_read(maps__lock(maps));
-	return m ? m->map : NULL;
+	if (ip < map__start(map))
+		return -1;
+	if (ip >= map__end(map))
+		return 1;
+	return 0;
 }
 
-static int map__strcmp(const void *a, const void *b)
+struct map *maps__find(struct maps *maps, u64 ip)
 {
-	const struct map *map_a = *(const struct map **)a;
-	const struct map *map_b = *(const struct map **)b;
-	const struct dso *dso_a = map__dso(map_a);
-	const struct dso *dso_b = map__dso(map_b);
-	int ret = strcmp(dso_a->short_name, dso_b->short_name);
-
-	if (ret == 0 && map_a != map_b) {
-		/*
-		 * Ensure distinct but name equal maps have an order in part to
-		 * aid reference counting.
-		 */
-		ret = (int)map__start(map_a) - (int)map__start(map_b);
-		if (ret == 0)
-			ret = (int)((intptr_t)map_a - (intptr_t)map_b);
+	struct map *result = NULL;
+	bool done = false;
+
+	/* See locking/sorting note. */
+	while (!done) {
+		down_read(maps__lock(maps));
+		if (maps__maps_by_address_sorted(maps)) {
+			struct map **mapp =
+				bsearch(&ip, maps__maps_by_address(maps), maps__nr_maps(maps),
+					sizeof(*mapp), map__addr_cmp);
+
+			if (mapp)
+				result = *mapp; // map__get(*mapp);
+			done = true;
+		}
+		up_read(maps__lock(maps));
+		if (!done)
+			maps__sort_by_address(maps);
 	}
-
-	return ret;
+	return result;
 }
 
 static int map__strcmp_name(const void *name, const void *b)
@@ -593,126 +885,113 @@ static int map__strcmp_name(const void *name, const void *b)
 	return strcmp(name, dso->short_name);
 }
 
-void __maps__sort_by_name(struct maps *maps)
-{
-	qsort(maps__maps_by_name(maps), maps__nr_maps(maps), sizeof(struct map *), map__strcmp);
-}
-
-static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
-{
-	struct map_rb_node *rb_node;
-	struct map **maps_by_name = realloc(maps__maps_by_name(maps),
-					    maps__nr_maps(maps) * sizeof(struct map *));
-	int i = 0;
-
-	if (maps_by_name == NULL)
-		return -1;
-
-	up_read(maps__lock(maps));
-	down_write(maps__lock(maps));
-
-	RC_CHK_ACCESS(maps)->maps_by_name = maps_by_name;
-	RC_CHK_ACCESS(maps)->nr_maps_allocated = maps__nr_maps(maps);
-
-	maps__for_each_entry(maps, rb_node)
-		maps_by_name[i++] = map__get(rb_node->map);
-
-	__maps__sort_by_name(maps);
-
-	up_write(maps__lock(maps));
-	down_read(maps__lock(maps));
-
-	return 0;
-}
-
-static struct map *__maps__find_by_name(struct maps *maps, const char *name)
+struct map *maps__find_by_name(struct maps *maps, const char *name)
 {
-	struct map **mapp;
+	struct map *result = NULL;
+	bool done = false;
 
-	if (maps__maps_by_name(maps) == NULL &&
-	    map__groups__sort_by_name_from_rbtree(maps))
-		return NULL;
+	/* See locking/sorting note. */
+	while (!done) {
+		unsigned int i;
 
-	mapp = bsearch(name, maps__maps_by_name(maps), maps__nr_maps(maps),
-		       sizeof(*mapp), map__strcmp_name);
-	if (mapp)
-		return *mapp;
-	return NULL;
-}
+		down_read(maps__lock(maps));
 
-struct map *maps__find_by_name(struct maps *maps, const char *name)
-{
-	struct map_rb_node *rb_node;
-	struct map *map;
-
-	down_read(maps__lock(maps));
+		/* First check last found entry. */
+		i = RC_CHK_ACCESS(maps)->last_search_by_name_idx;
+		if (i < maps__nr_maps(maps) && maps__maps_by_name(maps)) {
+			struct dso *dso = map__dso(maps__maps_by_name(maps)[i]);
 
+			if (dso && strcmp(dso->short_name, name) == 0) {
+				result = maps__maps_by_name(maps)[i]; // TODO: map__get
+				done = true;
+			}
+		}
 
-	if (RC_CHK_ACCESS(maps)->last_search_by_name) {
-		const struct dso *dso = map__dso(RC_CHK_ACCESS(maps)->last_search_by_name);
+		/* Second search sorted array. */
+		if (!done && maps__maps_by_name_sorted(maps)) {
+			struct map **mapp =
+				bsearch(name, maps__maps_by_name(maps), maps__nr_maps(maps),
+					sizeof(*mapp), map__strcmp_name);
 
-		if (strcmp(dso->short_name, name) == 0) {
-			map = RC_CHK_ACCESS(maps)->last_search_by_name;
-			goto out_unlock;
+			if (mapp) {
+				result = *mapp; // TODO: map__get
+				i = mapp - maps__maps_by_name(maps);
+				RC_CHK_ACCESS(maps)->last_search_by_name_idx = i;
+			}
+			done = true;
 		}
-	}
-	/*
-	 * If we have maps->maps_by_name, then the name isn't in the rbtree,
-	 * as maps->maps_by_name mirrors the rbtree when lookups by name are
-	 * made.
-	 */
-	map = __maps__find_by_name(maps, name);
-	if (map || maps__maps_by_name(maps) != NULL)
-		goto out_unlock;
-
-	/* Fallback to traversing the rbtree... */
-	maps__for_each_entry(maps, rb_node) {
-		struct dso *dso;
-
-		map = rb_node->map;
-		dso = map__dso(map);
-		if (strcmp(dso->short_name, name) == 0) {
-			RC_CHK_ACCESS(maps)->last_search_by_name = map;
-			goto out_unlock;
+		up_read(maps__lock(maps));
+		if (!done) {
+			/* Sort and retry binary search. */
+			if (maps__sort_by_name(maps)) {
+				/*
+				 * Memory allocation failed do linear search
+				 * through address sorted maps.
+				 */
+				struct map **maps_by_address;
+				unsigned int n;
+
+				down_read(maps__lock(maps));
+				maps_by_address =  maps__maps_by_address(maps);
+				n = maps__nr_maps(maps);
+				for (i = 0; i < n; i++) {
+					struct map *pos = maps_by_address[i];
+					struct dso *dso = map__dso(pos);
+
+					if (dso && strcmp(dso->short_name, name) == 0) {
+						result = pos; // TODO: map__get
+						break;
+					}
+				}
+				up_read(maps__lock(maps));
+				done = true;
+			}
 		}
 	}
-	map = NULL;
-
-out_unlock:
-	up_read(maps__lock(maps));
-	return map;
+	return result;
 }
 
 struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 {
-	struct map_rb_node *rb_node = maps__find_node(maps, map);
-	struct map_rb_node *next = map_rb_node__next(rb_node);
+	unsigned int i;
+	struct map *result = NULL;
 
-	if (next)
-		return next->map;
+	down_read(maps__lock(maps));
+	i = maps__by_address_index(maps, map);
+	if (i < maps__nr_maps(maps))
+		result = maps__maps_by_address(maps)[i]; // TODO: map__get
 
-	return NULL;
+	up_read(maps__lock(maps));
+	return result;
 }
 
 void maps__fixup_end(struct maps *maps)
 {
-	struct map_rb_node *prev = NULL, *curr;
+	struct map **maps_by_address;
+	unsigned int n;
 
 	down_write(maps__lock(maps));
+	if (!maps__maps_by_address_sorted(maps))
+		__maps__sort_by_address(maps);
 
-	maps__for_each_entry(maps, curr) {
-		if (prev && (!map__end(prev->map) || map__end(prev->map) > map__start(curr->map)))
-			map__set_end(prev->map, map__start(curr->map));
+	maps_by_address = maps__maps_by_address(maps);
+	n = maps__nr_maps(maps);
+	for (unsigned int i = 1; i < n; i++) {
+		struct map *prev = maps_by_address[i - 1];
+		struct map *curr = maps_by_address[i];
 
-		prev = curr;
+		if (!map__end(prev) || map__end(prev) > map__start(curr))
+			map__set_end(prev, map__start(curr));
 	}
 
 	/*
 	 * We still haven't the actual symbols, so guess the
 	 * last map final address.
 	 */
-	if (curr && !map__end(curr->map))
-		map__set_end(curr->map, ~0ULL);
+	if (n > 0 && !map__end(maps_by_address[n - 1]))
+		map__set_end(maps_by_address[n - 1], ~0ULL);
+
+	RC_CHK_ACCESS(maps)->ends_broken = false;
 
 	up_write(maps__lock(maps));
 }
@@ -723,117 +1002,93 @@ void maps__fixup_end(struct maps *maps)
  */
 int maps__merge_in(struct maps *kmaps, struct map *new_map)
 {
-	struct map_rb_node *rb_node;
-	struct rb_node *first;
-	bool overlaps;
-	LIST_HEAD(merged);
-	int err = 0;
-
-	down_read(maps__lock(kmaps));
-	first = first_ending_after(kmaps, new_map);
-	rb_node = first ? rb_entry(first, struct map_rb_node, rb_node) : NULL;
-	overlaps = rb_node && map__start(rb_node->map) < map__end(new_map);
-	up_read(maps__lock(kmaps));
+	unsigned int first_after_, kmaps__nr_maps;
+	struct map **kmaps_maps_by_address;
+	struct map **merged_maps_by_address;
+	unsigned int merged_nr_maps_allocated;
+
+	/* First try under a read lock. */
+	while (true) {
+		down_read(maps__lock(kmaps));
+		if (maps__maps_by_address_sorted(kmaps))
+			break;
 
-	if (!overlaps)
-		return maps__insert(kmaps, new_map);
+		up_read(maps__lock(kmaps));
 
-	maps__for_each_entry(kmaps, rb_node) {
-		struct map *old_map = rb_node->map;
+		/* First after binary search requires sorted maps. Sort and try again. */
+		maps__sort_by_address(kmaps);
+	}
+	first_after_ = first_ending_after(kmaps, new_map);
+	kmaps_maps_by_address = maps__maps_by_address(kmaps);
 
-		/* no overload with this one */
-		if (map__end(new_map) < map__start(old_map) ||
-		    map__start(new_map) >= map__end(old_map))
-			continue;
+	if (first_after_ >= maps__nr_maps(kmaps) ||
+	    map__start(kmaps_maps_by_address[first_after_]) >= map__end(new_map)) {
+		/* No overlap so regular insert suffices. */
+		up_read(maps__lock(kmaps));
+		return maps__insert(kmaps, new_map);
+	}
+	up_read(maps__lock(kmaps));
 
-		if (map__start(new_map) < map__start(old_map)) {
-			/*
-			 * |new......
-			 *       |old....
-			 */
-			if (map__end(new_map) < map__end(old_map)) {
-				/*
-				 * |new......|     -> |new..|
-				 *       |old....| ->       |old....|
-				 */
-				map__set_end(new_map, map__start(old_map));
-			} else {
-				/*
-				 * |new.............| -> |new..|       |new..|
-				 *       |old....|    ->       |old....|
-				 */
-				struct map_list_node *m = map_list_node__new();
+	/* Plain insert with a read-lock failed, try again now with the write lock. */
+	down_write(maps__lock(kmaps));
+	if (!maps__maps_by_address_sorted(kmaps))
+		__maps__sort_by_address(kmaps);
+
+	first_after_ = first_ending_after(kmaps, new_map);
+	kmaps_maps_by_address = maps__maps_by_address(kmaps);
+	kmaps__nr_maps = maps__nr_maps(kmaps);
+
+	if (first_after_ >= kmaps__nr_maps ||
+	    map__start(kmaps_maps_by_address[first_after_]) >= map__end(new_map)) {
+		/* No overlap so regular insert suffices. */
+		int ret = __maps__insert(kmaps, new_map);
+		up_write(maps__lock(kmaps));
+		return ret;
+	}
+	/* Array to merge into, possibly 1 more for the sake of new_map. */
+	merged_nr_maps_allocated = RC_CHK_ACCESS(kmaps)->nr_maps_allocated;
+	if (kmaps__nr_maps + 1 == merged_nr_maps_allocated)
+		merged_nr_maps_allocated++;
+
+	merged_maps_by_address = malloc(merged_nr_maps_allocated * sizeof(*merged_maps_by_address));
+	if (!merged_maps_by_address) {
+		up_write(maps__lock(kmaps));
+		return -ENOMEM;
+	}
+	maps__set_maps_by_address(kmaps, merged_maps_by_address);
+	maps__set_maps_by_address_sorted(kmaps, true);
+	zfree(maps__maps_by_name_addr(kmaps));
+	maps__set_maps_by_name_sorted(kmaps, true);
+	maps__set_nr_maps_allocated(kmaps, merged_nr_maps_allocated);
 
-				if (!m) {
-					err = -ENOMEM;
-					goto out;
-				}
+	/* Copy entries before the new_map that can't overlap. */
+	for (unsigned int i = 0; i < first_after_; i++)
+		merged_maps_by_address[i] = map__get(kmaps_maps_by_address[i]);
 
-				m->map = map__clone(new_map);
-				if (!m->map) {
-					free(m);
-					err = -ENOMEM;
-					goto out;
-				}
+	maps__set_nr_maps(kmaps, first_after_);
 
-				map__set_end(m->map, map__start(old_map));
-				list_add_tail(&m->node, &merged);
-				map__add_pgoff(new_map, map__end(old_map) - map__start(new_map));
-				map__set_start(new_map, map__end(old_map));
-			}
-		} else {
-			/*
-			 *      |new......
-			 * |old....
-			 */
-			if (map__end(new_map) < map__end(old_map)) {
-				/*
-				 *      |new..|   -> x
-				 * |old.........| -> |old.........|
-				 */
-				map__put(new_map);
-				new_map = NULL;
-				break;
-			} else {
-				/*
-				 *      |new......| ->         |new...|
-				 * |old....|        -> |old....|
-				 */
-				map__add_pgoff(new_map, map__end(old_map) - map__start(new_map));
-				map__set_start(new_map, map__end(old_map));
-			}
-		}
-	}
+	/* Add the new map, it will be split when the later overlapping mappings are added. */
+	__maps__insert(kmaps, new_map);
 
-out:
-	while (!list_empty(&merged)) {
-		struct map_list_node *old_node;
+	/* Insert mappings after new_map, splitting new_map in the process. */
+	for (unsigned int i = first_after_; i < kmaps__nr_maps; i++)
+		__maps__fixup_overlap_and_insert(kmaps, kmaps_maps_by_address[i]);
 
-		old_node = list_entry(merged.next, struct map_list_node, node);
-		list_del_init(&old_node->node);
-		if (!err)
-			err = maps__insert(kmaps, old_node->map);
-		map__put(old_node->map);
-		free(old_node);
-	}
+	/* Copy the maps from merged into kmaps. */
+	for (unsigned int i = 0; i < kmaps__nr_maps; i++)
+		map__zput(kmaps_maps_by_address[i]);
 
-	if (new_map) {
-		if (!err)
-			err = maps__insert(kmaps, new_map);
-		map__put(new_map);
-	}
-	return err;
+	free(kmaps_maps_by_address);
+	up_write(maps__lock(kmaps));
+	return 0;
 }
 
 void maps__load_first(struct maps *maps)
 {
-	struct map_rb_node *first;
-
 	down_read(maps__lock(maps));
 
-	first = maps__first(maps);
-	if (first)
-		map__load(first->map);
+	if (maps__nr_maps(maps) > 0)
+		map__load(maps__maps_by_address(maps)[0]);
 
 	up_read(maps__lock(maps));
 }
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index d836d04c9402..df9dd5a0e3c0 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -25,21 +25,56 @@ static inline struct map_list_node *map_list_node__new(void)
 	return malloc(sizeof(struct map_list_node));
 }
 
-struct map *maps__find(struct maps *maps, u64 addr);
+/*
+ * Locking/sorting note:
+ *
+ * Sorting is done with the write lock, iteration and binary searching happens
+ * under the read lock requiring being sorted. There is a race between sorting
+ * releasing the write lock and acquiring the read lock for iteration/searching
+ * where another thread could insert and break the sorting of the maps. In
+ * practice inserting maps should be rare meaning that the race shouldn't lead
+ * to live lock. Removal of maps doesn't break being sorted.
+ */
 
 DECLARE_RC_STRUCT(maps) {
-	struct rb_root      entries;
 	struct rw_semaphore lock;
-	struct machine	 *machine;
-	struct map	 *last_search_by_name;
+	/**
+	 * @maps_by_address: array of maps sorted by their starting address if
+	 * maps_by_address_sorted is true.
+	 */
+	struct map	 **maps_by_address;
+	/**
+	 * @maps_by_name: optional array of maps sorted by their dso name if
+	 * maps_by_name_sorted is true.
+	 */
 	struct map	 **maps_by_name;
-	refcount_t	 refcnt;
-	unsigned int	 nr_maps;
-	unsigned int	 nr_maps_allocated;
+	struct machine	 *machine;
 #ifdef HAVE_LIBUNWIND_SUPPORT
-	void				*addr_space;
+	void		*addr_space;
 	const struct unwind_libunwind_ops *unwind_libunwind_ops;
 #endif
+	refcount_t	 refcnt;
+	/**
+	 * @nr_maps: number of maps_by_address, and possibly maps_by_name,
+	 * entries that contain maps.
+	 */
+	unsigned int	 nr_maps;
+	/**
+	 * @nr_maps_allocated: number of entries in maps_by_address and possibly
+	 * maps_by_name.
+	 */
+	unsigned int	 nr_maps_allocated;
+	/**
+	 * @last_search_by_name_idx: cache of last found by name entry's index
+	 * as frequent searches for the same dso name are common.
+	 */
+	unsigned int	 last_search_by_name_idx;
+	/** @maps_by_address_sorted: is maps_by_address sorted. */
+	bool		 maps_by_address_sorted;
+	/** @maps_by_name_sorted: is maps_by_name sorted. */
+	bool		 maps_by_name_sorted;
+	/** @ends_broken: does the map contain a map where end values are unset/unsorted? */
+	bool		 ends_broken;
 };
 
 #define KMAP_NAME_LEN 256
@@ -102,6 +137,7 @@ size_t maps__fprintf(struct maps *maps, FILE *fp);
 int maps__insert(struct maps *maps, struct map *map);
 void maps__remove(struct maps *maps, struct map *map);
 
+struct map *maps__find(struct maps *maps, u64 addr);
 struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp);
 struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp);
 
@@ -117,8 +153,6 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map);
 
 int maps__merge_in(struct maps *kmaps, struct map *new_map);
 
-void __maps__sort_by_name(struct maps *maps);
-
 void maps__fixup_end(struct maps *maps);
 
 void maps__load_first(struct maps *maps);
-- 
2.43.0.687.g38aa6559b0-goog


