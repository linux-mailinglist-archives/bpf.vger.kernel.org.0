Return-Path: <bpf+bounces-21684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77B7850271
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 04:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2AE1C24993
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 03:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A34736121;
	Sat, 10 Feb 2024 03:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qQ+khKCR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350732C686
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707535091; cv=none; b=AzIhQ36VdRq2PpWXCXg49ekf9gG4UAxy2nToN/+hMVjPVVFkPy+syrDe//ZQy1vSf8A55GFcByOXLfP7U0aXjPXaDj9brKLFIyPdKqtKlu+YkWRjJ0OKQxh4EwS1JmC79HRh7afXQwYViqnGEBHT6J/OIbDX0ime4rO7wDEw0hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707535091; c=relaxed/simple;
	bh=xyFWl0t5tQrGKImtBTcwXyMpOMwAEg6HdGtYNTFX5ys=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eXX8p6OzXWRrQi1OOj7C0b8U/XPZxrpiR6igjlXaNqH+VAHXunN5Mi1AxfYri2vS26ttR/c2MWtFKkpv3HECd7lJcEw129MS/gy0eeOvjZ+ZJLWXBiRiRRRGtcDJW1tXW8ltYbF5E4XRKrxx/GKvHKmyl9/D9P8B14Kiw8VmXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qQ+khKCR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso3578338276.0
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 19:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707535088; x=1708139888; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aecajzuAUbLyDINCOUJ2904TGx9lyLVYBI9SEPdZlww=;
        b=qQ+khKCR170TtU1QSndlo1ghTc5FvV2c9clsxhN8Dpo6fdut4wOIg5/5rXC/VW6Ckg
         TOg8Wei82OMJP4vlCBxjz+aydeJg3JC7qYvnimJuNlZyGPfXPP6aloZ5Ifjyvq08S55o
         z92pqU774IPv01WM7nHxwnohj9wxlVNcEpwvT8LH6le9TT1JEA+9RcQTHcYzA/rAhBTz
         OzrlFcNgRunHUiLa+l4oNBcIzB0QAZvEps3gaoR18c6oxRT7Ga7OurcHY3J5C+XFjzep
         yBrqchdkajFQx07Bbibmk8OV8qWshUQf/IfEcClTzhg9/2qccmNbVhCZkfZtiYhLhQRs
         /ZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707535088; x=1708139888;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aecajzuAUbLyDINCOUJ2904TGx9lyLVYBI9SEPdZlww=;
        b=boMNeo/UXz0I0T0B4zs20xGofKfnD5mskv8UAhQEx+IXKVCSdKg43NjiMJHlfRV74h
         FVy7D+l4xnyX8VMdhjeQiUS2Onpqa3Lv6GmhOkteUwx5p4FoKTussxQQzZzEwgmaZ+oC
         wh0OCNSf+OGtWwK4OyD+JGJFCg1iDCUbLNS1l9Cyj9gOFwoVJ9h7gwRsKxES9fQMUrBk
         mgjGnvXmKGDIiyMSXFU92yG8yoe3mGgFLceQmL1LeDaYjGpiVNeaTxvLcdLZr0PsAK9z
         LU2UYBsPB4HbhDwgBIUur8EWcFO1fQFjhxSxz0tt0XOMzr0pLd728lWw6/fPbJshXoTE
         xE+w==
X-Gm-Message-State: AOJu0Yya1mnPYdkFRRzZMnNP7qrV/lOKCaaoQBYgUyBV2e9em5OXYH6i
	x/Ukk2AbK1JGHxb8KoUnEFxrS6+QzTgie1a+B62SpUAejs9hlspDrYwCs84Iezj6f2rtykbce7o
	gYcfZ0A==
X-Google-Smtp-Source: AGHT+IF+IDa+aLIF8Kf+VH8Z+YgplfD7EIXErA2tiS18PzbdC6rixCoV/jzICa2Mf1sqUmGFjCL6IjQEaX1a
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a25:ab65:0:b0:dc2:2e5c:a21d with SMTP id
 u92-20020a25ab65000000b00dc22e5ca21dmr287758ybi.6.1707535088063; Fri, 09 Feb
 2024 19:18:08 -0800 (PST)
Date: Fri,  9 Feb 2024 19:17:45 -0800
In-Reply-To: <20240210031746.4057262-1-irogers@google.com>
Message-Id: <20240210031746.4057262-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210031746.4057262-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 5/6] perf maps: Hide maps internals
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

Move the struct into the C file. Add maps__equal to work around
exposing the struct for reference count checking. Add accessors for
the unwind_libunwind_ops. Move maps_list_node to its only use in
symbol.c.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/thread-maps-share.c     |  8 +-
 tools/perf/util/callchain.c              |  2 +-
 tools/perf/util/maps.c                   | 96 +++++++++++++++++++++++
 tools/perf/util/maps.h                   | 97 +++---------------------
 tools/perf/util/symbol.c                 | 10 +++
 tools/perf/util/thread.c                 |  2 +-
 tools/perf/util/unwind-libdw.c           |  2 +-
 tools/perf/util/unwind-libunwind-local.c |  2 +-
 tools/perf/util/unwind-libunwind.c       |  7 +-
 9 files changed, 124 insertions(+), 102 deletions(-)

diff --git a/tools/perf/tests/thread-maps-share.c b/tools/perf/tests/thread-maps-share.c
index 7fa6f7c568e2..e9ecd30a5c05 100644
--- a/tools/perf/tests/thread-maps-share.c
+++ b/tools/perf/tests/thread-maps-share.c
@@ -46,9 +46,9 @@ static int test__thread_maps_share(struct test_suite *test __maybe_unused, int s
 	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(maps__refcnt(maps)), 4);
 
 	/* test the maps pointer is shared */
-	TEST_ASSERT_VAL("maps don't match", RC_CHK_EQUAL(maps, thread__maps(t1)));
-	TEST_ASSERT_VAL("maps don't match", RC_CHK_EQUAL(maps, thread__maps(t2)));
-	TEST_ASSERT_VAL("maps don't match", RC_CHK_EQUAL(maps, thread__maps(t3)));
+	TEST_ASSERT_VAL("maps don't match", maps__equal(maps, thread__maps(t1)));
+	TEST_ASSERT_VAL("maps don't match", maps__equal(maps, thread__maps(t2)));
+	TEST_ASSERT_VAL("maps don't match", maps__equal(maps, thread__maps(t3)));
 
 	/*
 	 * Verify the other leader was created by previous call.
@@ -73,7 +73,7 @@ static int test__thread_maps_share(struct test_suite *test __maybe_unused, int s
 	other_maps = thread__maps(other);
 	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(maps__refcnt(other_maps)), 2);
 
-	TEST_ASSERT_VAL("maps don't match", RC_CHK_EQUAL(other_maps, thread__maps(other_leader)));
+	TEST_ASSERT_VAL("maps don't match", maps__equal(other_maps, thread__maps(other_leader)));
 
 	/* release thread group */
 	thread__put(t3);
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 8262f69118db..7517d16c02ec 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1157,7 +1157,7 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 		if (al->map == NULL)
 			goto out;
 	}
-	if (RC_CHK_EQUAL(al->maps, machine__kernel_maps(machine))) {
+	if (maps__equal(al->maps, machine__kernel_maps(machine))) {
 		if (machine__is_host(machine)) {
 			al->cpumode = PERF_RECORD_MISC_KERNEL;
 			al->level = 'k';
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index df0c8041899e..439cefab112a 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -6,9 +6,63 @@
 #include "dso.h"
 #include "map.h"
 #include "maps.h"
+#include "rwsem.h"
 #include "thread.h"
 #include "ui/ui.h"
 #include "unwind.h"
+#include <internal/rc_check.h>
+
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
+
+DECLARE_RC_STRUCT(maps) {
+	struct rw_semaphore lock;
+	/**
+	 * @maps_by_address: array of maps sorted by their starting address if
+	 * maps_by_address_sorted is true.
+	 */
+	struct map	 **maps_by_address;
+	/**
+	 * @maps_by_name: optional array of maps sorted by their dso name if
+	 * maps_by_name_sorted is true.
+	 */
+	struct map	 **maps_by_name;
+	struct machine	 *machine;
+#ifdef HAVE_LIBUNWIND_SUPPORT
+	void		*addr_space;
+	const struct unwind_libunwind_ops *unwind_libunwind_ops;
+#endif
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
+};
 
 static void check_invariants(const struct maps *maps __maybe_unused)
 {
@@ -118,6 +172,43 @@ static void maps__set_maps_by_name_sorted(struct maps *maps, bool value)
 	RC_CHK_ACCESS(maps)->maps_by_name_sorted = value;
 }
 
+struct machine *maps__machine(const struct maps *maps)
+{
+	return RC_CHK_ACCESS(maps)->machine;
+}
+
+unsigned int maps__nr_maps(const struct maps *maps)
+{
+	return RC_CHK_ACCESS(maps)->nr_maps;
+}
+
+refcount_t *maps__refcnt(struct maps *maps)
+{
+	return &RC_CHK_ACCESS(maps)->refcnt;
+}
+
+#ifdef HAVE_LIBUNWIND_SUPPORT
+void *maps__addr_space(const struct maps *maps)
+{
+	return RC_CHK_ACCESS(maps)->addr_space;
+}
+
+void maps__set_addr_space(struct maps *maps, void *addr_space)
+{
+	RC_CHK_ACCESS(maps)->addr_space = addr_space;
+}
+
+const struct unwind_libunwind_ops *maps__unwind_libunwind_ops(const struct maps *maps)
+{
+	return RC_CHK_ACCESS(maps)->unwind_libunwind_ops;
+}
+
+void maps__set_unwind_libunwind_ops(struct maps *maps, const struct unwind_libunwind_ops *ops)
+{
+	RC_CHK_ACCESS(maps)->unwind_libunwind_ops = ops;
+}
+#endif
+
 static struct rw_semaphore *maps__lock(struct maps *maps)
 {
 	/*
@@ -453,6 +544,11 @@ bool maps__empty(struct maps *maps)
 	return maps__nr_maps(maps) == 0;
 }
 
+bool maps__equal(struct maps *a, struct maps *b)
+{
+	return RC_CHK_EQUAL(a, b);
+}
+
 int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data), void *data)
 {
 	bool done = false;
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index df9dd5a0e3c0..4bcba136ffe5 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -3,80 +3,15 @@
 #define __PERF_MAPS_H
 
 #include <linux/refcount.h>
-#include <linux/rbtree.h>
 #include <stdio.h>
 #include <stdbool.h>
 #include <linux/types.h>
-#include "rwsem.h"
-#include <internal/rc_check.h>
 
 struct ref_reloc_sym;
 struct machine;
 struct map;
 struct maps;
 
-struct map_list_node {
-	struct list_head node;
-	struct map *map;
-};
-
-static inline struct map_list_node *map_list_node__new(void)
-{
-	return malloc(sizeof(struct map_list_node));
-}
-
-/*
- * Locking/sorting note:
- *
- * Sorting is done with the write lock, iteration and binary searching happens
- * under the read lock requiring being sorted. There is a race between sorting
- * releasing the write lock and acquiring the read lock for iteration/searching
- * where another thread could insert and break the sorting of the maps. In
- * practice inserting maps should be rare meaning that the race shouldn't lead
- * to live lock. Removal of maps doesn't break being sorted.
- */
-
-DECLARE_RC_STRUCT(maps) {
-	struct rw_semaphore lock;
-	/**
-	 * @maps_by_address: array of maps sorted by their starting address if
-	 * maps_by_address_sorted is true.
-	 */
-	struct map	 **maps_by_address;
-	/**
-	 * @maps_by_name: optional array of maps sorted by their dso name if
-	 * maps_by_name_sorted is true.
-	 */
-	struct map	 **maps_by_name;
-	struct machine	 *machine;
-#ifdef HAVE_LIBUNWIND_SUPPORT
-	void		*addr_space;
-	const struct unwind_libunwind_ops *unwind_libunwind_ops;
-#endif
-	refcount_t	 refcnt;
-	/**
-	 * @nr_maps: number of maps_by_address, and possibly maps_by_name,
-	 * entries that contain maps.
-	 */
-	unsigned int	 nr_maps;
-	/**
-	 * @nr_maps_allocated: number of entries in maps_by_address and possibly
-	 * maps_by_name.
-	 */
-	unsigned int	 nr_maps_allocated;
-	/**
-	 * @last_search_by_name_idx: cache of last found by name entry's index
-	 * as frequent searches for the same dso name are common.
-	 */
-	unsigned int	 last_search_by_name_idx;
-	/** @maps_by_address_sorted: is maps_by_address sorted. */
-	bool		 maps_by_address_sorted;
-	/** @maps_by_name_sorted: is maps_by_name sorted. */
-	bool		 maps_by_name_sorted;
-	/** @ends_broken: does the map contain a map where end values are unset/unsorted? */
-	bool		 ends_broken;
-};
-
 #define KMAP_NAME_LEN 256
 
 struct kmap {
@@ -100,36 +35,22 @@ static inline void __maps__zput(struct maps **map)
 
 #define maps__zput(map) __maps__zput(&map)
 
+bool maps__equal(struct maps *a, struct maps *b);
+
 /* Iterate over map calling cb for each entry. */
 int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data), void *data);
 /* Iterate over map removing an entry if cb returns true. */
 void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data);
 
-static inline struct machine *maps__machine(struct maps *maps)
-{
-	return RC_CHK_ACCESS(maps)->machine;
-}
-
-static inline unsigned int maps__nr_maps(const struct maps *maps)
-{
-	return RC_CHK_ACCESS(maps)->nr_maps;
-}
-
-static inline refcount_t *maps__refcnt(struct maps *maps)
-{
-	return &RC_CHK_ACCESS(maps)->refcnt;
-}
+struct machine *maps__machine(const struct maps *maps);
+unsigned int maps__nr_maps(const struct maps *maps);
+refcount_t *maps__refcnt(struct maps *maps);
 
 #ifdef HAVE_LIBUNWIND_SUPPORT
-static inline void *maps__addr_space(struct maps *maps)
-{
-	return RC_CHK_ACCESS(maps)->addr_space;
-}
-
-static inline const struct unwind_libunwind_ops *maps__unwind_libunwind_ops(const struct maps *maps)
-{
-	return RC_CHK_ACCESS(maps)->unwind_libunwind_ops;
-}
+void *maps__addr_space(const struct maps *maps);
+void maps__set_addr_space(struct maps *maps, void *addr_space);
+const struct unwind_libunwind_ops *maps__unwind_libunwind_ops(const struct maps *maps);
+void maps__set_unwind_libunwind_ops(struct maps *maps, const struct unwind_libunwind_ops *ops);
 #endif
 
 size_t maps__fprintf(struct maps *maps, FILE *fp);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 0785a54e832e..35975189999b 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -63,6 +63,16 @@ struct symbol_conf symbol_conf = {
 	.res_sample		= 0,
 };
 
+struct map_list_node {
+	struct list_head node;
+	struct map *map;
+};
+
+static struct map_list_node *map_list_node__new(void)
+{
+	return malloc(sizeof(struct map_list_node));
+}
+
 static enum dso_binary_type binary_type_symtab[] = {
 	DSO_BINARY_TYPE__KALLSYMS,
 	DSO_BINARY_TYPE__GUEST_KALLSYMS,
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 89c47a5098e2..c59ab4d79163 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -383,7 +383,7 @@ static int thread__clone_maps(struct thread *thread, struct thread *parent, bool
 	if (thread__pid(thread) == thread__pid(parent))
 		return thread__prepare_access(thread);
 
-	if (RC_CHK_EQUAL(thread__maps(thread), thread__maps(parent))) {
+	if (maps__equal(thread__maps(thread), thread__maps(parent))) {
 		pr_debug("broken map groups on thread %d/%d parent %d/%d\n",
 			 thread__pid(thread), thread__tid(thread),
 			 thread__pid(parent), thread__tid(parent));
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 6013335a8dae..b38d322734b4 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -263,7 +263,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	struct unwind_info *ui, ui_buf = {
 		.sample		= data,
 		.thread		= thread,
-		.machine	= RC_CHK_ACCESS(thread__maps(thread))->machine,
+		.machine	= maps__machine((thread__maps(thread))),
 		.cb		= cb,
 		.arg		= arg,
 		.max_stack	= max_stack,
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index dac536e28360..6a5ac0faa6f4 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -706,7 +706,7 @@ static int _unwind__prepare_access(struct maps *maps)
 {
 	void *addr_space = unw_create_addr_space(&accessors, 0);
 
-	RC_CHK_ACCESS(maps)->addr_space = addr_space;
+	maps__set_addr_space(maps, addr_space);
 	if (!addr_space) {
 		pr_err("unwind: Can't create unwind address space.\n");
 		return -ENOMEM;
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 76cd63de80a8..2728eb4f13ea 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -12,11 +12,6 @@ struct unwind_libunwind_ops __weak *local_unwind_libunwind_ops;
 struct unwind_libunwind_ops __weak *x86_32_unwind_libunwind_ops;
 struct unwind_libunwind_ops __weak *arm64_unwind_libunwind_ops;
 
-static void unwind__register_ops(struct maps *maps, struct unwind_libunwind_ops *ops)
-{
-	RC_CHK_ACCESS(maps)->unwind_libunwind_ops = ops;
-}
-
 int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized)
 {
 	const char *arch;
@@ -60,7 +55,7 @@ int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized
 		return 0;
 	}
 out_register:
-	unwind__register_ops(maps, ops);
+	maps__set_unwind_libunwind_ops(maps, ops);
 
 	err = maps__unwind_libunwind_ops(maps)->prepare_access(maps);
 	if (initialized)
-- 
2.43.0.687.g38aa6559b0-goog


