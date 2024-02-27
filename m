Return-Path: <bpf+bounces-22813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E2586A20E
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 23:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E517D1F29974
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 22:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290D9157E98;
	Tue, 27 Feb 2024 22:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RL532pKU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DEC1552FD
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 22:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071334; cv=none; b=d6W/O2OS44fyXphRF7Huxxk0MGCAnOD/oM8kfA0YtAmf7QzL68VGSFkhFVaaAMqwVdX7Sb7xFcvQ93l1v+Ey+dwNNQM91x4mAk6MGANZ1r1edC8M4GoDd3uJ/+oRQYmq1VEZRntUYPQiYQ1JJ3Q73hzs17T8syOOvd63+JJELiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071334; c=relaxed/simple;
	bh=BwcV35MQ9IkUkXfZ67mXHHWsr4b/gkiZgBHtVuRfRT8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=d5OZocfkhKYTVFNptfVEJ4V0xGsisxnFnqAzUIvUkn8XywswYJDR5DEKi1uXa+RLDIUy2l9UUCAfJCuOzF6O++uhhs/KUjzyNky7Mg4a3VxkBo4JgYT/QIVMi3v7RKCb/RdtOz26F7p+QK0DrB04qe+dMEL0QM0b6II3pppevn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RL532pKU; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc15b03287so6315359276.3
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 14:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709071331; x=1709676131; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ImEDViDBOcqCHKqHKXmTVraxu3CYSvL5VkrRz+GpsCo=;
        b=RL532pKU8yYvYtM1DYrnK0nqiCSzXF4pq4zwV9m63odZJJxR3dnA8GCuF/eUvGdjUT
         xP1e02aH+ZlyhkWkJQz5wt+QqPIQibrJ9O7ZmqE10XiwMxbRE679X5aMXdeaxBX1fN4S
         hMQxQy0dZJEpmO2dH9lxXPmRr3M46BBmvHyKBpEgnu4wMpM3+0/rRftg6IoXEONpMmiV
         Pe/l0uddR2ST0stQ03jQCDtKULMX9bHJgcBTCwzkbLO1mKM3oVMLCVlUsJ5Yo8KCXibY
         iyGBNns5NLyjD0kwPt9ttOjyjOxqy6KYsUmhno9ToCWgZ22yUBgWJRDgelJ4nsmad2ZK
         s9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071331; x=1709676131;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImEDViDBOcqCHKqHKXmTVraxu3CYSvL5VkrRz+GpsCo=;
        b=RlO8ePy4EkhSn/BU9WaVWxJCNKjlbkv1+gBG9PlgqbyB6O/ghtL9xaSmGwu+b9IWMK
         nsiC+agY4ywTrFVgnv3Ln97GkXX6AZAGYQsY/WmDsMN/bEzoHc/K6yTfzWxwUn8VTDrJ
         kwF1jTDipTOAxPOnZ9xJ0AnP/do0UomgfuisT25AWcgD1rMAa2Gr51Ozt3YtMYNoF1ll
         zpfwH7/pJq2W2T0/ylSeKyYFjBSgoYS59Ddra+p7eeT8O5Hdj0n/WssHugrBrz5RCufO
         8aWBFCOrmvXaHbx6EPZIpZ/dIHw1yovkY6rxzGP/CzslMb+zgnz+y1kFA4LcJZsq0C33
         VfWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkhXLWUIFb8LwE63/v8SxG5Ke7kbEaXNHURacvaAGXMSH4ZGwynTuLvpmfT6DwuD4VNIejZXcuCUfFsv4nOJfn90gs
X-Gm-Message-State: AOJu0YxmGYObEE8X+xMBVjwExMLDa378452Wca4uoRy9m6ThGvFsSp9L
	Qp4sx7hKES7IEhhw8uFGc26NcHDahNTy/xv3itwjoNyEtshwf8lMGQ0guPgNII4zoeGNG5W98FY
	IRvcB4g==
X-Google-Smtp-Source: AGHT+IEkU3Paxse6i6srVQ9LQV039G6k1vXfGWkkJhO4+paQjo06nXXo066vGFP40z3JgTRNAHccZpZIqlk0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ff1:8af6:9e1a:6382])
 (user=irogers job=sendgmr) by 2002:a25:d8d3:0:b0:dcc:4785:b51e with SMTP id
 p202-20020a25d8d3000000b00dcc4785b51emr54008ybg.12.1709071331258; Tue, 27 Feb
 2024 14:02:11 -0800 (PST)
Date: Tue, 27 Feb 2024 14:01:48 -0800
In-Reply-To: <20240227220150.3876198-1-irogers@google.com>
Message-Id: <20240227220150.3876198-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227220150.3876198-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v2 4/6] perf threads: Move threads to its own files
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move threads out of machine and move thread_rb_node into the C
file. This hides the implementation of threads from the rest of the
code allowing for it to be refactored. Note, the implementation here
is removed in the next patch in the series which moves to a hashtable.

Locking discipline is tightened up in this change. When a function is
added to threads.c care is taken that the threads lock is held
appropriately. This replaces somewhat adhoc use of the lock in
machine, and adds the lock in places it was missed primarily
threads__nr. In the previous code it was the caller's responsibility
to hold the right lock before calling an internal "__" version of the
function.

As the lock is now encapsulated in threads, the findnew function
requires holding it (as it already did in machine). Rather than do
conditionals with locks based on whether the thread should be created
(which could potentially be error prone with a read lock match with a
write unlock), have a separate threads__find that won't create the
thread and only holds the read lock. This effectively duplicates the
findnew logic, with the existing findnew logic only operating under a
write lock assuming creation is necessary as a previous find
failed. The creation may still fail with the write lock due to another
thread. The duplication is removed in the next patch that delegates
the implementation to hashtable.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build                 |   1 +
 tools/perf/util/bpf_lock_contention.c |   8 +-
 tools/perf/util/machine.c             | 287 ++++----------------------
 tools/perf/util/machine.h             |  20 +-
 tools/perf/util/thread.c              |   2 +-
 tools/perf/util/thread.h              |   6 -
 tools/perf/util/threads.c             | 244 ++++++++++++++++++++++
 tools/perf/util/threads.h             |  35 ++++
 8 files changed, 325 insertions(+), 278 deletions(-)
 create mode 100644 tools/perf/util/threads.c
 create mode 100644 tools/perf/util/threads.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2cbeeb79b6ef..e0a723e24503 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -72,6 +72,7 @@ perf-y += ordered-events.o
 perf-y += namespaces.o
 perf-y += comm.o
 perf-y += thread.o
+perf-y += threads.o
 perf-y += thread_map.o
 perf-y += parse-events-flex.o
 perf-y += parse-events-bison.o
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 31ff19afc20c..3992c8a9fd96 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -210,7 +210,7 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 
 		/* do not update idle comm which contains CPU number */
 		if (pid) {
-			struct thread *t = __machine__findnew_thread(machine, /*pid=*/-1, pid);
+			struct thread *t = machine__findnew_thread(machine, /*pid=*/-1, pid);
 
 			if (t == NULL)
 				return name;
@@ -302,9 +302,9 @@ int lock_contention_read(struct lock_contention *con)
 		return -1;
 
 	if (con->aggr_mode == LOCK_AGGR_TASK) {
-		struct thread *idle = __machine__findnew_thread(machine,
-								/*pid=*/0,
-								/*tid=*/0);
+		struct thread *idle = machine__findnew_thread(machine,
+							      /*pid=*/0,
+							      /*tid=*/0);
 		thread__set_comm(idle, "swapper", /*timestamp=*/0);
 	}
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e072b2115b64..e668a97255f8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -43,9 +43,6 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 
-static void __machine__remove_thread(struct machine *machine, struct thread_rb_node *nd,
-				     struct thread *th, bool lock);
-
 static struct dso *machine__kernel_dso(struct machine *machine)
 {
 	return map__dso(machine->vmlinux_map);
@@ -58,35 +55,6 @@ static void dsos__init(struct dsos *dsos)
 	init_rwsem(&dsos->lock);
 }
 
-static void machine__threads_init(struct machine *machine)
-{
-	int i;
-
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
-		threads->entries = RB_ROOT_CACHED;
-		init_rwsem(&threads->lock);
-		threads->nr = 0;
-		threads->last_match = NULL;
-	}
-}
-
-static int thread_rb_node__cmp_tid(const void *key, const struct rb_node *nd)
-{
-	int to_find = (int) *((pid_t *)key);
-
-	return to_find - (int)thread__tid(rb_entry(nd, struct thread_rb_node, rb_node)->thread);
-}
-
-static struct thread_rb_node *thread_rb_node__find(const struct thread *th,
-						   struct rb_root *tree)
-{
-	pid_t to_find = thread__tid(th);
-	struct rb_node *nd = rb_find(&to_find, tree, thread_rb_node__cmp_tid);
-
-	return rb_entry(nd, struct thread_rb_node, rb_node);
-}
-
 static int machine__set_mmap_name(struct machine *machine)
 {
 	if (machine__is_host(machine))
@@ -120,7 +88,7 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	RB_CLEAR_NODE(&machine->rb_node);
 	dsos__init(&machine->dsos);
 
-	machine__threads_init(machine);
+	threads__init(&machine->threads);
 
 	machine->vdso_info = NULL;
 	machine->env = NULL;
@@ -221,27 +189,11 @@ static void dsos__exit(struct dsos *dsos)
 
 void machine__delete_threads(struct machine *machine)
 {
-	struct rb_node *nd;
-	int i;
-
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
-		down_write(&threads->lock);
-		nd = rb_first_cached(&threads->entries);
-		while (nd) {
-			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
-
-			nd = rb_next(nd);
-			__machine__remove_thread(machine, trb, trb->thread, false);
-		}
-		up_write(&threads->lock);
-	}
+	threads__remove_all_threads(&machine->threads);
 }
 
 void machine__exit(struct machine *machine)
 {
-	int i;
-
 	if (machine == NULL)
 		return;
 
@@ -254,12 +206,7 @@ void machine__exit(struct machine *machine)
 	zfree(&machine->current_tid);
 	zfree(&machine->kallsyms_filename);
 
-	machine__delete_threads(machine);
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
-
-		exit_rwsem(&threads->lock);
-	}
+	threads__exit(&machine->threads);
 }
 
 void machine__delete(struct machine *machine)
@@ -526,7 +473,7 @@ static void machine__update_thread_pid(struct machine *machine,
 	if (thread__pid(th) == thread__tid(th))
 		return;
 
-	leader = __machine__findnew_thread(machine, thread__pid(th), thread__pid(th));
+	leader = machine__findnew_thread(machine, thread__pid(th), thread__pid(th));
 	if (!leader)
 		goto out_err;
 
@@ -560,160 +507,55 @@ static void machine__update_thread_pid(struct machine *machine,
 	goto out_put;
 }
 
-/*
- * Front-end cache - TID lookups come in blocks,
- * so most of the time we dont have to look up
- * the full rbtree:
- */
-static struct thread*
-__threads__get_last_match(struct threads *threads, struct machine *machine,
-			  int pid, int tid)
-{
-	struct thread *th;
-
-	th = threads->last_match;
-	if (th != NULL) {
-		if (thread__tid(th) == tid) {
-			machine__update_thread_pid(machine, th, pid);
-			return thread__get(th);
-		}
-		thread__put(threads->last_match);
-		threads->last_match = NULL;
-	}
-
-	return NULL;
-}
-
-static struct thread*
-threads__get_last_match(struct threads *threads, struct machine *machine,
-			int pid, int tid)
-{
-	struct thread *th = NULL;
-
-	if (perf_singlethreaded)
-		th = __threads__get_last_match(threads, machine, pid, tid);
-
-	return th;
-}
-
-static void
-__threads__set_last_match(struct threads *threads, struct thread *th)
-{
-	thread__put(threads->last_match);
-	threads->last_match = thread__get(th);
-}
-
-static void
-threads__set_last_match(struct threads *threads, struct thread *th)
-{
-	if (perf_singlethreaded)
-		__threads__set_last_match(threads, th);
-}
-
 /*
  * Caller must eventually drop thread->refcnt returned with a successful
  * lookup/new thread inserted.
  */
-static struct thread *____machine__findnew_thread(struct machine *machine,
-						  struct threads *threads,
-						  pid_t pid, pid_t tid,
-						  bool create)
+static struct thread *__machine__findnew_thread(struct machine *machine,
+						pid_t pid,
+						pid_t tid,
+						bool create)
 {
-	struct rb_node **p = &threads->entries.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct thread *th;
-	struct thread_rb_node *nd;
-	bool leftmost = true;
+	struct thread *th = threads__find(&machine->threads, tid);
+	bool created;
 
-	th = threads__get_last_match(threads, machine, pid, tid);
-	if (th)
+	if (th) {
+		machine__update_thread_pid(machine, th, pid);
 		return th;
-
-	while (*p != NULL) {
-		parent = *p;
-		th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
-
-		if (thread__tid(th) == tid) {
-			threads__set_last_match(threads, th);
-			machine__update_thread_pid(machine, th, pid);
-			return thread__get(th);
-		}
-
-		if (tid < thread__tid(th))
-			p = &(*p)->rb_left;
-		else {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		}
 	}
-
 	if (!create)
 		return NULL;
 
-	th = thread__new(pid, tid);
-	if (th == NULL)
-		return NULL;
-
-	nd = malloc(sizeof(*nd));
-	if (nd == NULL) {
-		thread__put(th);
-		return NULL;
-	}
-	nd->thread = th;
-
-	rb_link_node(&nd->rb_node, parent, p);
-	rb_insert_color_cached(&nd->rb_node, &threads->entries, leftmost);
-	/*
-	 * We have to initialize maps separately after rb tree is updated.
-	 *
-	 * The reason is that we call machine__findnew_thread within
-	 * thread__init_maps to find the thread leader and that would screwed
-	 * the rb tree.
-	 */
-	if (thread__init_maps(th, machine)) {
-		pr_err("Thread init failed thread %d\n", pid);
-		rb_erase_cached(&nd->rb_node, &threads->entries);
-		RB_CLEAR_NODE(&nd->rb_node);
-		free(nd);
-		thread__put(th);
-		return NULL;
-	}
-	/*
-	 * It is now in the rbtree, get a ref
-	 */
-	threads__set_last_match(threads, th);
-	++threads->nr;
-
-	return thread__get(th);
-}
+	th = threads__findnew(&machine->threads, pid, tid, &created);
+	if (created) {
+		/*
+		 * We have to initialize maps separately after rb tree is
+		 * updated.
+		 *
+		 * The reason is that we call machine__findnew_thread within
+		 * thread__init_maps to find the thread leader and that would
+		 * screwed the rb tree.
+		 */
+		if (thread__init_maps(th, machine)) {
+			pr_err("Thread init failed thread %d\n", pid);
+			threads__remove(&machine->threads, th);
+			thread__put(th);
+			return NULL;
+		}
+	} else
+		machine__update_thread_pid(machine, th, pid);
 
-struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid)
-{
-	return ____machine__findnew_thread(machine, machine__threads(machine, tid), pid, tid, true);
+	return th;
 }
 
-struct thread *machine__findnew_thread(struct machine *machine, pid_t pid,
-				       pid_t tid)
+struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid)
 {
-	struct threads *threads = machine__threads(machine, tid);
-	struct thread *th;
-
-	down_write(&threads->lock);
-	th = __machine__findnew_thread(machine, pid, tid);
-	up_write(&threads->lock);
-	return th;
+	return __machine__findnew_thread(machine, pid, tid, /*create=*/true);
 }
 
-struct thread *machine__find_thread(struct machine *machine, pid_t pid,
-				    pid_t tid)
+struct thread *machine__find_thread(struct machine *machine, pid_t pid, pid_t tid)
 {
-	struct threads *threads = machine__threads(machine, tid);
-	struct thread *th;
-
-	down_read(&threads->lock);
-	th =  ____machine__findnew_thread(machine, threads, pid, tid, false);
-	up_read(&threads->lock);
-	return th;
+	return __machine__findnew_thread(machine, pid, tid, /*create=*/false);
 }
 
 /*
@@ -1127,23 +969,13 @@ static int machine_fprintf_cb(struct thread *thread, void *data)
 	return 0;
 }
 
-static size_t machine__threads_nr(const struct machine *machine)
-{
-	size_t nr = 0;
-
-	for (int i = 0; i < THREADS__TABLE_SIZE; i++)
-		nr += machine->threads[i].nr;
-
-	return nr;
-}
-
 size_t machine__fprintf(struct machine *machine, FILE *fp)
 {
 	struct machine_fprintf_cb_args args = {
 		.fp = fp,
 		.printed = 0,
 	};
-	size_t ret = fprintf(fp, "Threads: %zu\n", machine__threads_nr(machine));
+	size_t ret = fprintf(fp, "Threads: %zu\n", threads__nr(&machine->threads));
 
 	machine__for_each_thread(machine, machine_fprintf_cb, &args);
 	return ret + args.printed;
@@ -2069,36 +1901,9 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 	return 0;
 }
 
-static void __machine__remove_thread(struct machine *machine, struct thread_rb_node *nd,
-				     struct thread *th, bool lock)
-{
-	struct threads *threads = machine__threads(machine, thread__tid(th));
-
-	if (!nd)
-		nd = thread_rb_node__find(th, &threads->entries.rb_root);
-
-	if (threads->last_match && RC_CHK_EQUAL(threads->last_match, th))
-		threads__set_last_match(threads, NULL);
-
-	if (lock)
-		down_write(&threads->lock);
-
-	BUG_ON(refcount_read(thread__refcnt(th)) == 0);
-
-	thread__put(nd->thread);
-	rb_erase_cached(&nd->rb_node, &threads->entries);
-	RB_CLEAR_NODE(&nd->rb_node);
-	--threads->nr;
-
-	free(nd);
-
-	if (lock)
-		up_write(&threads->lock);
-}
-
 void machine__remove_thread(struct machine *machine, struct thread *th)
 {
-	return __machine__remove_thread(machine, NULL, th, true);
+	return threads__remove(&machine->threads, th);
 }
 
 int machine__process_fork_event(struct machine *machine, union perf_event *event,
@@ -3232,23 +3037,7 @@ int machine__for_each_thread(struct machine *machine,
 			     int (*fn)(struct thread *thread, void *p),
 			     void *priv)
 {
-	struct threads *threads;
-	struct rb_node *nd;
-	int rc = 0;
-	int i;
-
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		threads = &machine->threads[i];
-		for (nd = rb_first_cached(&threads->entries); nd;
-		     nd = rb_next(nd)) {
-			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
-
-			rc = fn(trb->thread, priv);
-			if (rc != 0)
-				return rc;
-		}
-	}
-	return rc;
+	return threads__for_each_thread(&machine->threads, fn, priv);
 }
 
 int machines__for_each_thread(struct machines *machines,
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index b738ce84817b..e28c787616fe 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -7,6 +7,7 @@
 #include "maps.h"
 #include "dsos.h"
 #include "rwsem.h"
+#include "threads.h"
 
 struct addr_location;
 struct branch_stack;
@@ -28,16 +29,6 @@ extern const char *ref_reloc_sym_names[];
 
 struct vdso_info;
 
-#define THREADS__TABLE_BITS	8
-#define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
-
-struct threads {
-	struct rb_root_cached  entries;
-	struct rw_semaphore    lock;
-	unsigned int	       nr;
-	struct thread	       *last_match;
-};
-
 struct machine {
 	struct rb_node	  rb_node;
 	pid_t		  pid;
@@ -48,7 +39,7 @@ struct machine {
 	char		  *root_dir;
 	char		  *mmap_name;
 	char		  *kallsyms_filename;
-	struct threads    threads[THREADS__TABLE_SIZE];
+	struct threads    threads;
 	struct vdso_info  *vdso_info;
 	struct perf_env   *env;
 	struct dsos	  dsos;
@@ -69,12 +60,6 @@ struct machine {
 	bool		  trampolines_mapped;
 };
 
-static inline struct threads *machine__threads(struct machine *machine, pid_t tid)
-{
-	/* Cast it to handle tid == -1 */
-	return &machine->threads[(unsigned int)tid % THREADS__TABLE_SIZE];
-}
-
 /*
  * The main kernel (vmlinux) map
  */
@@ -220,7 +205,6 @@ bool machine__is(struct machine *machine, const char *arch);
 bool machine__normalized_is(struct machine *machine, const char *arch);
 int machine__nr_cpus_avail(struct machine *machine);
 
-struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
 struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
 
 struct dso *machine__findnew_dso_id(struct machine *machine, const char *filename, struct dso_id *id);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index c59ab4d79163..1aa8962dcf52 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -26,7 +26,7 @@ int thread__init_maps(struct thread *thread, struct machine *machine)
 	if (pid == thread__tid(thread) || pid == -1) {
 		thread__set_maps(thread, maps__new(machine));
 	} else {
-		struct thread *leader = __machine__findnew_thread(machine, pid, pid);
+		struct thread *leader = machine__findnew_thread(machine, pid, pid);
 
 		if (leader) {
 			thread__set_maps(thread, maps__get(thread__maps(leader)));
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index df344262eaee..8b4a3c69bad1 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -3,7 +3,6 @@
 #define __PERF_THREAD_H
 
 #include <linux/refcount.h>
-#include <linux/rbtree.h>
 #include <linux/list.h>
 #include <stdio.h>
 #include <unistd.h>
@@ -29,11 +28,6 @@ struct lbr_stitch {
 	struct callchain_cursor_node	*prev_lbr_cursor;
 };
 
-struct thread_rb_node {
-	struct rb_node rb_node;
-	struct thread *thread;
-};
-
 DECLARE_RC_STRUCT(thread) {
 	/** @maps: mmaps associated with this thread. */
 	struct maps		*maps;
diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
new file mode 100644
index 000000000000..d984ec939c7b
--- /dev/null
+++ b/tools/perf/util/threads.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "threads.h"
+#include "machine.h"
+#include "thread.h"
+
+struct thread_rb_node {
+	struct rb_node rb_node;
+	struct thread *thread;
+};
+
+static struct threads_table_entry *threads__table(struct threads *threads, pid_t tid)
+{
+	/* Cast it to handle tid == -1 */
+	return &threads->table[(unsigned int)tid % THREADS__TABLE_SIZE];
+}
+
+void threads__init(struct threads *threads)
+{
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads_table_entry *table = &threads->table[i];
+
+		table->entries = RB_ROOT_CACHED;
+		init_rwsem(&table->lock);
+		table->nr = 0;
+		table->last_match = NULL;
+	}
+}
+
+void threads__exit(struct threads *threads)
+{
+	threads__remove_all_threads(threads);
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads_table_entry *table = &threads->table[i];
+
+		exit_rwsem(&table->lock);
+	}
+}
+
+size_t threads__nr(struct threads *threads)
+{
+	size_t nr = 0;
+
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads_table_entry *table = &threads->table[i];
+
+		down_read(&table->lock);
+		nr += table->nr;
+		up_read(&table->lock);
+	}
+	return nr;
+}
+
+/*
+ * Front-end cache - TID lookups come in blocks,
+ * so most of the time we dont have to look up
+ * the full rbtree:
+ */
+static struct thread *__threads_table_entry__get_last_match(struct threads_table_entry *table,
+							    pid_t tid)
+{
+	struct thread *th, *res = NULL;
+
+	th = table->last_match;
+	if (th != NULL) {
+		if (thread__tid(th) == tid)
+			res = thread__get(th);
+	}
+	return res;
+}
+
+static void __threads_table_entry__set_last_match(struct threads_table_entry *table,
+						  struct thread *th)
+{
+	thread__put(table->last_match);
+	table->last_match = thread__get(th);
+}
+
+static void threads_table_entry__set_last_match(struct threads_table_entry *table,
+						struct thread *th)
+{
+	down_write(&table->lock);
+	__threads_table_entry__set_last_match(table, th);
+	up_write(&table->lock);
+}
+
+struct thread *threads__find(struct threads *threads, pid_t tid)
+{
+	struct threads_table_entry *table  = threads__table(threads, tid);
+	struct rb_node **p;
+	struct thread *res = NULL;
+
+	down_read(&table->lock);
+	res = __threads_table_entry__get_last_match(table, tid);
+	if (res)
+		return res;
+
+	p = &table->entries.rb_root.rb_node;
+	while (*p != NULL) {
+		struct rb_node *parent = *p;
+		struct thread *th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
+
+		if (thread__tid(th) == tid) {
+			res = thread__get(th);
+			break;
+		}
+
+		if (tid < thread__tid(th))
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	up_read(&table->lock);
+	if (res)
+		threads_table_entry__set_last_match(table, res);
+	return res;
+}
+
+struct thread *threads__findnew(struct threads *threads, pid_t pid, pid_t tid, bool *created)
+{
+	struct threads_table_entry *table  = threads__table(threads, tid);
+	struct rb_node **p;
+	struct rb_node *parent = NULL;
+	struct thread *res = NULL;
+	struct thread_rb_node *nd;
+	bool leftmost = true;
+
+	*created = false;
+	down_write(&table->lock);
+	p = &table->entries.rb_root.rb_node;
+	while (*p != NULL) {
+		struct thread *th;
+
+		parent = *p;
+		th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
+
+		if (thread__tid(th) == tid) {
+			__threads_table_entry__set_last_match(table, th);
+			res = thread__get(th);
+			goto out_unlock;
+		}
+
+		if (tid < thread__tid(th))
+			p = &(*p)->rb_left;
+		else {
+			leftmost = false;
+			p = &(*p)->rb_right;
+		}
+	}
+	nd = malloc(sizeof(*nd));
+	if (nd == NULL)
+		goto out_unlock;
+	res = thread__new(pid, tid);
+	if (!res)
+		free(nd);
+	else {
+		*created = true;
+		nd->thread = thread__get(res);
+		rb_link_node(&nd->rb_node, parent, p);
+		rb_insert_color_cached(&nd->rb_node, &table->entries, leftmost);
+		++table->nr;
+		__threads_table_entry__set_last_match(table, res);
+	}
+out_unlock:
+	up_write(&table->lock);
+	return res;
+}
+
+void threads__remove_all_threads(struct threads *threads)
+{
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads_table_entry *table = &threads->table[i];
+		struct rb_node *nd;
+
+		down_write(&table->lock);
+		__threads_table_entry__set_last_match(table, NULL);
+		nd = rb_first_cached(&table->entries);
+		while (nd) {
+			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
+
+			nd = rb_next(nd);
+			thread__put(trb->thread);
+			rb_erase_cached(&trb->rb_node, &table->entries);
+			RB_CLEAR_NODE(&trb->rb_node);
+			--table->nr;
+
+			free(trb);
+		}
+		assert(table->nr == 0);
+		up_write(&table->lock);
+	}
+}
+
+void threads__remove(struct threads *threads, struct thread *thread)
+{
+	struct rb_node **p;
+	struct threads_table_entry *table  = threads__table(threads, thread__tid(thread));
+	pid_t tid = thread__tid(thread);
+
+	down_write(&table->lock);
+	if (table->last_match && RC_CHK_EQUAL(table->last_match, thread))
+		__threads_table_entry__set_last_match(table, NULL);
+
+	p = &table->entries.rb_root.rb_node;
+	while (*p != NULL) {
+		struct rb_node *parent = *p;
+		struct thread_rb_node *nd = rb_entry(parent, struct thread_rb_node, rb_node);
+		struct thread *th = nd->thread;
+
+		if (RC_CHK_EQUAL(th, thread)) {
+			thread__put(nd->thread);
+			rb_erase_cached(&nd->rb_node, &table->entries);
+			RB_CLEAR_NODE(&nd->rb_node);
+			--table->nr;
+			free(nd);
+			break;
+		}
+
+		if (tid < thread__tid(th))
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	up_write(&table->lock);
+}
+
+int threads__for_each_thread(struct threads *threads,
+			     int (*fn)(struct thread *thread, void *data),
+			     void *data)
+{
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads_table_entry *table = &threads->table[i];
+		struct rb_node *nd;
+
+		for (nd = rb_first_cached(&table->entries); nd; nd = rb_next(nd)) {
+			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
+			int rc = fn(trb->thread, data);
+
+			if (rc != 0)
+				return rc;
+		}
+	}
+	return 0;
+
+}
diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
new file mode 100644
index 000000000000..ed67de627578
--- /dev/null
+++ b/tools/perf/util/threads.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_THREADS_H
+#define __PERF_THREADS_H
+
+#include <linux/rbtree.h>
+#include "rwsem.h"
+
+struct thread;
+
+#define THREADS__TABLE_BITS	8
+#define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
+
+struct threads_table_entry {
+	struct rb_root_cached  entries;
+	struct rw_semaphore    lock;
+	unsigned int	       nr;
+	struct thread	       *last_match;
+};
+
+struct threads {
+	struct threads_table_entry table[THREADS__TABLE_SIZE];
+};
+
+void threads__init(struct threads *threads);
+void threads__exit(struct threads *threads);
+size_t threads__nr(struct threads *threads);
+struct thread *threads__find(struct threads *threads, pid_t tid);
+struct thread *threads__findnew(struct threads *threads, pid_t pid, pid_t tid, bool *created);
+void threads__remove_all_threads(struct threads *threads);
+void threads__remove(struct threads *threads, struct thread *thread);
+int threads__for_each_thread(struct threads *threads,
+			     int (*fn)(struct thread *thread, void *data),
+			     void *data);
+
+#endif	/* __PERF_THREADS_H */
-- 
2.44.0.rc1.240.g4c46232300-goog


