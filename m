Return-Path: <bpf+bounces-21955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F96D8542F9
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 07:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C96C7B25CC9
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 06:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5EC1773A;
	Wed, 14 Feb 2024 06:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rp3SkL3/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529C7171B8
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892656; cv=none; b=TRbd/Rq76MApiOaxBJMlZ+OSpaOmy60SmVLxFbVgOtG210wTk1EXTpLt3lBCcxJp4tCF6l071BPVAD0IRYytWHsWKOumYrwACWN2U41xtC75D04u9pUtpf0fAs6AmjNNsx7IBvnh2P8+lvpCc05xrOeyw1OVVSiVy6gPqOMTFfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892656; c=relaxed/simple;
	bh=792Y2/R9dEdTkzaXADVPj0kpCyae3uNsLmkPUNZ1lNw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=sso4s/nL9LXKDHKHdXgNrjvIy468IU60zBLzlwj2uf6IDw7SlZO9ckCFeuQsCf3f9Ar87nd8yxbn+3oSErjcf2R0Qp4FiiZmiFl7Fh+1oOvCfCjoaGPTwYlfq42rTMxqUhxYZdyjL/NxLUQ02f0Y41YIdf5R368AaLcbmJRyKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rp3SkL3/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so6484782276.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 22:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707892652; x=1708497452; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LrKC1v0yM6h/zxJwGsay7MbtcGdPOfBPN7PRv/fJOBQ=;
        b=rp3SkL3/xSSt1zY20iFf/e4GQ96s+RaDR35qqdvVsy0n9EWSXetnweWaCtlhGcunU4
         wHc7FY6eDvyHNddD+Pxa33AHggOshoMANnChEiIXzngTwXAKu0ft/g+a5EZ2bXypdCo7
         Lrnh5peXo1Pg6ZAX7Cd/MIoltz3nchMgTfh+8i7kkQjd/0nVY2SgyV+sUbnPc6eJCPf6
         l2+sG+0CFCfbUr5Dr0IxaPaylOAXIiF0uCkQy4u72i8/Zz4V6YvJEzUg9vPzcp5L0VF0
         aOVzEqbkZLTIQqNoCp0Mrgi8yJJ+OmPXH4pM0GL6M+IiWbDdEz1BFb/5XXxhfdTNp4LD
         843A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707892652; x=1708497452;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrKC1v0yM6h/zxJwGsay7MbtcGdPOfBPN7PRv/fJOBQ=;
        b=aDuauZxSCVicQv3zKTeCydLPMhbsONB5N4xUoPs75kR0swqdJeCDSchOwG+ioldBIj
         QbEu+FhFT9TzA0EhO+AntUJus/gBTQv09/9AcTZyNk3CD/aYXy+8300fxYOVPjxuDrQR
         2KUrWeAHEjPcrYM/WCEetj3p1hGV8wozX34W0MysY8DLnrfCt0sl2B8mZyWkWe5kbeKR
         lwCOmWogoAJFphsqNrya2E9nXBfW6Z9K8zvWQA1jzlbHTWvH0uzKWzeMYD4XmLsuS0u1
         ZwMUC6wK0JNB2eB0qSGHXz+u2tCClVuhfdTVX/7Y3KivShDJ18FSfzo6OoiOqWCddpNY
         633A==
X-Forwarded-Encrypted: i=1; AJvYcCW5smpI8pbJfuVBzavgcM57Y828by2MRxtGJieNRSoGa2WOqQvGXJKpkDEKhGm6HzjZLzvVtVBZJiInxxow+j951h8x
X-Gm-Message-State: AOJu0YwMZhjkFNEVdYEZTqwE0YuLIYxvfs+vPHlaHDTmOjN27AeFFdPr
	o7hG6zHTIo+ngQGm31a4o5umbAGBnbI2Yo5s48ABrsePWTcOJRaC6D5p260fpiEXPfOlhg6Ccur
	MVPNqxw==
X-Google-Smtp-Source: AGHT+IFxpm66soxGF2R35nActxrpJcf2dLNCJZEbxqNkNmnj4iP/+1JYyGr/baG/Lhmmy5+gV4jUbpR3jj9V
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:100f:b0:dc7:3189:4e75 with SMTP
 id w15-20020a056902100f00b00dc731894e75mr46963ybt.3.1707892652306; Tue, 13
 Feb 2024 22:37:32 -0800 (PST)
Date: Tue, 13 Feb 2024 22:37:07 -0800
In-Reply-To: <20240214063708.972376-1-irogers@google.com>
Message-Id: <20240214063708.972376-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 5/6] perf threads: Switch from rbtree to hashmap
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The rbtree provides a sorting on entries but this is unused. Switch to
using hashmap for O(1) rather than O(log n) find/insert/remove
complexity.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.c | 146 ++++++++++++--------------------------
 tools/perf/util/threads.h |   6 +-
 2 files changed, 47 insertions(+), 105 deletions(-)

diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
index d984ec939c7b..55923be53180 100644
--- a/tools/perf/util/threads.c
+++ b/tools/perf/util/threads.c
@@ -3,25 +3,30 @@
 #include "machine.h"
 #include "thread.h"
 
-struct thread_rb_node {
-	struct rb_node rb_node;
-	struct thread *thread;
-};
-
 static struct threads_table_entry *threads__table(struct threads *threads, pid_t tid)
 {
 	/* Cast it to handle tid == -1 */
 	return &threads->table[(unsigned int)tid % THREADS__TABLE_SIZE];
 }
 
+static size_t key_hash(long key, void *ctx __maybe_unused)
+{
+	/* The table lookup removes low bit entropy, but this is just ignored here. */
+	return key;
+}
+
+static bool key_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
+
 void threads__init(struct threads *threads)
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
 
-		table->entries = RB_ROOT_CACHED;
+		hashmap__init(&table->shard, key_hash, key_equal, NULL);
 		init_rwsem(&table->lock);
-		table->nr = 0;
 		table->last_match = NULL;
 	}
 }
@@ -32,6 +37,7 @@ void threads__exit(struct threads *threads)
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
 
+		hashmap__clear(&table->shard);
 		exit_rwsem(&table->lock);
 	}
 }
@@ -44,7 +50,7 @@ size_t threads__nr(struct threads *threads)
 		struct threads_table_entry *table = &threads->table[i];
 
 		down_read(&table->lock);
-		nr += table->nr;
+		nr += hashmap__size(&table->shard);
 		up_read(&table->lock);
 	}
 	return nr;
@@ -86,28 +92,13 @@ static void threads_table_entry__set_last_match(struct threads_table_entry *tabl
 struct thread *threads__find(struct threads *threads, pid_t tid)
 {
 	struct threads_table_entry *table  = threads__table(threads, tid);
-	struct rb_node **p;
-	struct thread *res = NULL;
+	struct thread *res;
 
 	down_read(&table->lock);
 	res = __threads_table_entry__get_last_match(table, tid);
-	if (res)
-		return res;
-
-	p = &table->entries.rb_root.rb_node;
-	while (*p != NULL) {
-		struct rb_node *parent = *p;
-		struct thread *th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
-
-		if (thread__tid(th) == tid) {
-			res = thread__get(th);
-			break;
-		}
-
-		if (tid < thread__tid(th))
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
+	if (!res) {
+		if (hashmap__find(&table->shard, tid, &res))
+			res = thread__get(res);
 	}
 	up_read(&table->lock);
 	if (res)
@@ -118,49 +109,25 @@ struct thread *threads__find(struct threads *threads, pid_t tid)
 struct thread *threads__findnew(struct threads *threads, pid_t pid, pid_t tid, bool *created)
 {
 	struct threads_table_entry *table  = threads__table(threads, tid);
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
 	struct thread *res = NULL;
-	struct thread_rb_node *nd;
-	bool leftmost = true;
 
 	*created = false;
 	down_write(&table->lock);
-	p = &table->entries.rb_root.rb_node;
-	while (*p != NULL) {
-		struct thread *th;
-
-		parent = *p;
-		th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
-
-		if (thread__tid(th) == tid) {
-			__threads_table_entry__set_last_match(table, th);
-			res = thread__get(th);
-			goto out_unlock;
-		}
-
-		if (tid < thread__tid(th))
-			p = &(*p)->rb_left;
-		else {
-			leftmost = false;
-			p = &(*p)->rb_right;
-		}
-	}
-	nd = malloc(sizeof(*nd));
-	if (nd == NULL)
-		goto out_unlock;
 	res = thread__new(pid, tid);
-	if (!res)
-		free(nd);
-	else {
-		*created = true;
-		nd->thread = thread__get(res);
-		rb_link_node(&nd->rb_node, parent, p);
-		rb_insert_color_cached(&nd->rb_node, &table->entries, leftmost);
-		++table->nr;
-		__threads_table_entry__set_last_match(table, res);
+	if (res) {
+		if (hashmap__add(&table->shard, tid, res)) {
+			/* Add failed. Assume a race so find other entry. */
+			thread__put(res);
+			res = NULL;
+			if (hashmap__find(&table->shard, tid, &res))
+				res = thread__get(res);
+		} else {
+			res = thread__get(res);
+			*created = true;
+		}
+		if (res)
+			__threads_table_entry__set_last_match(table, res);
 	}
-out_unlock:
 	up_write(&table->lock);
 	return res;
 }
@@ -169,57 +136,32 @@ void threads__remove_all_threads(struct threads *threads)
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
-		struct rb_node *nd;
+		struct hashmap_entry *cur, *tmp;
+		size_t bkt;
 
 		down_write(&table->lock);
 		__threads_table_entry__set_last_match(table, NULL);
-		nd = rb_first_cached(&table->entries);
-		while (nd) {
-			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
-
-			nd = rb_next(nd);
-			thread__put(trb->thread);
-			rb_erase_cached(&trb->rb_node, &table->entries);
-			RB_CLEAR_NODE(&trb->rb_node);
-			--table->nr;
+		hashmap__for_each_entry_safe((&table->shard), cur, tmp, bkt) {
+			struct thread *old_value;
 
-			free(trb);
+			hashmap__delete(&table->shard, cur->key, /*old_key=*/NULL, &old_value);
+			thread__put(old_value);
 		}
-		assert(table->nr == 0);
 		up_write(&table->lock);
 	}
 }
 
 void threads__remove(struct threads *threads, struct thread *thread)
 {
-	struct rb_node **p;
 	struct threads_table_entry *table  = threads__table(threads, thread__tid(thread));
-	pid_t tid = thread__tid(thread);
+	struct thread *old_value;
 
 	down_write(&table->lock);
 	if (table->last_match && RC_CHK_EQUAL(table->last_match, thread))
 		__threads_table_entry__set_last_match(table, NULL);
 
-	p = &table->entries.rb_root.rb_node;
-	while (*p != NULL) {
-		struct rb_node *parent = *p;
-		struct thread_rb_node *nd = rb_entry(parent, struct thread_rb_node, rb_node);
-		struct thread *th = nd->thread;
-
-		if (RC_CHK_EQUAL(th, thread)) {
-			thread__put(nd->thread);
-			rb_erase_cached(&nd->rb_node, &table->entries);
-			RB_CLEAR_NODE(&nd->rb_node);
-			--table->nr;
-			free(nd);
-			break;
-		}
-
-		if (tid < thread__tid(th))
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
-	}
+	hashmap__delete(&table->shard, thread__tid(thread), /*old_key=*/NULL, &old_value);
+	thread__put(old_value);
 	up_write(&table->lock);
 }
 
@@ -229,11 +171,11 @@ int threads__for_each_thread(struct threads *threads,
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
-		struct rb_node *nd;
+		struct hashmap_entry *cur;
+		size_t bkt;
 
-		for (nd = rb_first_cached(&table->entries); nd; nd = rb_next(nd)) {
-			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
-			int rc = fn(trb->thread, data);
+		hashmap__for_each_entry((&table->shard), cur, bkt) {
+			int rc = fn((struct thread *)cur->pvalue, data);
 
 			if (rc != 0)
 				return rc;
diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index ed67de627578..d03bd91a7769 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -2,7 +2,7 @@
 #ifndef __PERF_THREADS_H
 #define __PERF_THREADS_H
 
-#include <linux/rbtree.h>
+#include "hashmap.h"
 #include "rwsem.h"
 
 struct thread;
@@ -11,9 +11,9 @@ struct thread;
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads_table_entry {
-	struct rb_root_cached  entries;
+	/* Key is tid, value is struct thread. */
+	struct hashmap	       shard;
 	struct rw_semaphore    lock;
-	unsigned int	       nr;
 	struct thread	       *last_match;
 };
 
-- 
2.43.0.687.g38aa6559b0-goog


