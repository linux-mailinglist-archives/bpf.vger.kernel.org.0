Return-Path: <bpf+bounces-67738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88783B496CB
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4157189944C
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495EA3148C4;
	Mon,  8 Sep 2025 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Asv1zW9F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD4313E10;
	Mon,  8 Sep 2025 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351680; cv=none; b=ZQxYQIr+DYPzmgtE/8kSt81E50zlJhZesXsPIJl0XJh3KIpW6jVJmdNGWCbnwLf9mmdSfP4o4hn+AmimY+mPgTyKtW5kUXHlycs9qptawoE5yQzpVE5qo5S7g+LOxZ7uI6BWYg5BwATy1LLDHOFQo2wkiC6QIlHwrEgA6IzsAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351680; c=relaxed/simple;
	bh=XDCQGzNCd5CfxCTBq8qB3GWeSBiyTPC2GtP9bJQSgdg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pGZugQtlSyJ9XBEdAJmKxZDTS0+iGxQ4ifxHGORvftSBxADsX2nxrikJmbW5u++JYynl+LvXYyndTU6TDarFZ/iPYyM9h/gseNVngfeV2DyEOaSIvSZd/51Z5fveUNhT2urxGfrBIBASN50XmfphRdRfCLpIpkDCoup89DpoWc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Asv1zW9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B491C4CEF5;
	Mon,  8 Sep 2025 17:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757351680;
	bh=XDCQGzNCd5CfxCTBq8qB3GWeSBiyTPC2GtP9bJQSgdg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Asv1zW9F4wNUP7Fbn4PRzKNcOa8tnxB7rHPQggoZXm6vgARf2OsqI7eowhcxHgLCC
	 Xp0KXiXC62c/1m1JX/vlC6zj+CPMNeako46iPXuuAtl/FB7PF46a8bJUU6hbfaLnq0
	 0QnKuqIdatv8uZmS6+q5e9eufiUR/NJ6Ud+09T+0VrFm6lJ+9V0L1gpwiM+Z9BAQBu
	 20kvu/I1ZERnykzVH6I4L2hSoWh2yTxI4oO7bJYlGG5U0oMTbt6CfdNn/TkCFVKErt
	 7yumtAXx7u17JGQxs+ZGDgArx4ZUu1fNGMzfzotUoe11we63Jrc0xsQEb0fvp/VndH
	 hVwr6nKpFRZeg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uvfSf-000000075Px-0O3e;
	Mon, 08 Sep 2025 13:15:25 -0400
Message-ID: <20250908171524.943453280@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 08 Sep 2025 13:14:16 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>,
 "Carlos O'Donell" <codonell@redhat.com>
Subject: [RESEND][PATCH v15 4/4] perf: Support deferred user callchains for per CPU events
References: <20250908171412.268168931@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The deferred unwinder works fine for task events (events that trace only a
specific task), as it can use a task_work from an interrupt or NMI and
when the task goes back to user space it will call the event's callback to
do the deferred unwinding.

But for per CPU events things are not so simple. When a per CPU event
wants a deferred unwinding to occur, it cannot simply use a task_work as
there's a many to many relationship. If the task migrates and another task
is scheduled in where the per CPU event wants a deferred unwinding to
occur on that task as well, and the task that migrated to another CPU has
that CPU's event want to unwind it too, each CPU may need unwinding from
more than one task, and each task may have requests from many CPUs.

The main issue is that from the kernel point of view, there's currently
nothing that associates a per CPU event for one CPU to the per CPU events
that cover the other CPUs for a given process. To the kernel, they are all
just individual events buffers. This is problematic if a delayed request
is made on one CPU and the task migrates to another CPU where the delayed
user stack trace will be performed. The kernel needs to know which CPU
buffer to add it to that belongs to the same process that initiated the
deferred request.

To solve this, when a per CPU event is created that has defer_callchain
attribute set, it will do a lookup from a global list
(unwind_deferred_list), for a perf_unwind_deferred descriptor that has the
id that matches the PID of the current task's group_leader. (The process
ID for all the threads of a process)

If it is not found, then it will create one and add it to the global list.
This descriptor contains an array of all possible CPUs, where each element
is a perf_unwind_cpu descriptor.

The perf_unwind_cpu descriptor has a list of all the per CPU events that
is tracing the matching CPU that corresponds to its index in the array,
where the events belong to a task that has the same group_leader.
It also has a processing bit and rcuwait to handle removal.

For each occupied perf_unwind_cpu descriptor in the array, the
perf_deferred_unwind descriptor increments its nr_cpu_events. When a
perf_unwind_cpu descriptor is empty, the nr_cpu_events is decremented.
This is used to know when to free the perf_deferred_unwind descriptor, as
when it becomes empty, it is no longer referenced.

Finally, the perf_deferred_unwind descriptor has an id that holds the PID
of the group_leader for the tasks that the events were created by.

When a second (or more) per CPU event is created where the
perf_deferred_unwind descriptor already exists, it just adds itself to
the perf_unwind_cpu array of that descriptor. Updating the necessary
counter. This is used to map different per CPU events to each other based
on their group leader PID.

Each of these perf_deferred_unwind descriptors have a unwind_work that
registers with the deferred unwind infrastructure via
unwind_deferred_init(), where it also registers a callback to
perf_event_deferred_cpu().

Now when a per CPU event requests a deferred unwinding, it calls
unwind_deferred_request() with the associated perf_deferred_unwind
descriptor. It is expected that the program that uses this has events on
all CPUs, as the deferred trace may not be called on the CPU event that
requested it. That is, the task may migrate and its user stack trace will
be recorded on the CPU event of the CPU that it exits back to user space
on.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/perf_event.h |   4 +
 kernel/events/core.c       | 320 +++++++++++++++++++++++++++++++++----
 2 files changed, 295 insertions(+), 29 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c8eefbc9ce51..0edc7ad4c914 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -733,6 +733,7 @@ struct swevent_hlist {
 struct bpf_prog;
 struct perf_cgroup;
 struct perf_buffer;
+struct perf_unwind_deferred;
 
 struct pmu_event_list {
 	raw_spinlock_t			lock;
@@ -885,6 +886,9 @@ struct perf_event {
 	struct callback_head		pending_unwind_work;
 	struct rcuwait			pending_unwind_wait;
 
+	struct perf_unwind_deferred	*unwind_deferred;
+	struct list_head		unwind_list;
+
 	atomic_t			event_limit;
 
 	/* address range filters */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index db4ca7e4afb1..303ab50eca8b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5582,10 +5582,193 @@ static bool exclusive_event_installable(struct perf_event *event,
 	return true;
 }
 
+/* Holds a list of per CPU events that registered for deferred unwinding */
+struct perf_unwind_cpu {
+	struct list_head	list;
+	struct rcuwait		pending_unwind_wait;
+	int			processing;
+};
+
+struct perf_unwind_deferred {
+	struct list_head		list;
+	struct unwind_work		unwind_work;
+	struct perf_unwind_cpu __rcu	*cpu_events;
+	struct rcu_head			rcu_head;
+	int				nr_cpu_events;
+	int				id;
+};
+
+static DEFINE_MUTEX(unwind_deferred_mutex);
+static LIST_HEAD(unwind_deferred_list);
+
+static void perf_event_deferred_cpu(struct unwind_work *work,
+				    struct unwind_stacktrace *trace, u64 cookie);
+
+/*
+ * Add a per CPU event.
+ *
+ * The deferred callstack can happen on a different CPU than what was
+ * requested. If one CPU event requests a deferred callstack, but the
+ * tasks migrates, it will execute on a different CPU and save the
+ * stack trace to that CPU event.
+ *
+ * In order to map all the CPU events with the same application,
+ * use the current->gorup_leader->pid as the identifier of what
+ * events share the same program.
+ *
+ * A perf_unwind_deferred descriptor is created for each unique
+ * group_leader pid, and all the events that have the same group_leader
+ * pid will be linked to the same deferred descriptor.
+ *
+ * If there's no descriptor that matches the current group_leader pid,
+ * one will be created.
+ */
+static int perf_add_unwind_deferred(struct perf_event *event)
+{
+	struct perf_unwind_deferred *defer;
+	struct perf_unwind_cpu *cpu_events;
+	int id = current->group_leader->pid;
+	bool found = false;
+	int ret = 0;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	guard(mutex)(&unwind_deferred_mutex);
+
+	list_for_each_entry(defer, &unwind_deferred_list, list) {
+		if (defer->id == id) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		defer = kzalloc(sizeof(*defer), GFP_KERNEL);
+		if (!defer)
+			return -ENOMEM;
+		list_add(&defer->list, &unwind_deferred_list);
+		defer->id = id;
+	}
+
+	/*
+	 * The deferred desciptor has an array for every CPU.
+	 * Each entry in this array is a link list of all the CPU
+	 * events for the corresponding CPU. This is a quick way to
+	 * find the associated event for a given CPU in
+	 * perf_event_deferred_cpu().
+	 */
+	if (!defer->nr_cpu_events) {
+		cpu_events = kcalloc(num_possible_cpus(),
+				     sizeof(*cpu_events),
+				     GFP_KERNEL);
+		if (!cpu_events) {
+			ret = -ENOMEM;
+			goto free;
+		}
+		for (int cpu = 0; cpu < num_possible_cpus(); cpu++) {
+			rcuwait_init(&cpu_events[cpu].pending_unwind_wait);
+			INIT_LIST_HEAD(&cpu_events[cpu].list);
+		}
+
+		rcu_assign_pointer(defer->cpu_events, cpu_events);
+
+		ret = unwind_deferred_init(&defer->unwind_work,
+					   perf_event_deferred_cpu);
+		if (ret)
+			goto free;
+	}
+	cpu_events = rcu_dereference_protected(defer->cpu_events,
+				lockdep_is_held(&unwind_deferred_mutex));
+
+	/*
+	 * The defer->nr_cpu_events is the count of the number
+	 * of non-empty lists in the cpu_events array. If the list
+	 * being added to is already occupied, the nr_cpu_events does
+	 * not need to get incremented.
+	 */
+	if (list_empty(&cpu_events[event->cpu].list))
+		defer->nr_cpu_events++;
+	list_add_tail_rcu(&event->unwind_list, &cpu_events[event->cpu].list);
+
+	event->unwind_deferred = defer;
+	return 0;
+free:
+	/* Nothing to do if there was already an existing event attached */
+	if (found)
+		return ret;
+
+	list_del(&defer->list);
+	kfree(cpu_events);
+	kfree(defer);
+	return ret;
+}
+
+static void free_unwind_deferred_rcu(struct rcu_head *head)
+{
+	struct perf_unwind_cpu *cpu_events;
+	struct perf_unwind_deferred *defer =
+		container_of(head, struct perf_unwind_deferred, rcu_head);
+
+	WARN_ON_ONCE(defer->nr_cpu_events);
+	/*
+	 * This is called by call_rcu() and there are no more
+	 * references to cpu_events.
+	 */
+	cpu_events = rcu_dereference_protected(defer->cpu_events, true);
+	kfree(cpu_events);
+	kfree(defer);
+}
+
+static void perf_remove_unwind_deferred(struct perf_event *event)
+{
+	struct perf_unwind_deferred *defer = event->unwind_deferred;
+	struct perf_unwind_cpu *cpu_events, *cpu_unwind;
+
+	if (!defer)
+		return;
+
+	guard(mutex)(&unwind_deferred_mutex);
+	list_del_rcu(&event->unwind_list);
+
+	cpu_events = rcu_dereference_protected(defer->cpu_events,
+				lockdep_is_held(&unwind_deferred_mutex));
+	cpu_unwind = &cpu_events[event->cpu];
+
+	if (list_empty(&cpu_unwind->list)) {
+		defer->nr_cpu_events--;
+		if (!defer->nr_cpu_events)
+			unwind_deferred_cancel(&defer->unwind_work);
+	}
+
+	event->unwind_deferred = NULL;
+
+	/*
+	 * Make sure perf_event_deferred_cpu() is done with this event.
+	 * That function will set cpu_unwind->processing and then
+	 * call smp_mb() before iterating the list of its events.
+	 * If the event's unwind_deferred is NULL, it will be skipped.
+	 * The smp_mb() in that function matches the mb() in
+	 * rcuwait_wait_event().
+	 */
+	rcuwait_wait_event(&cpu_unwind->pending_unwind_wait,
+				   !cpu_unwind->processing, TASK_UNINTERRUPTIBLE);
+
+	/* Is this still being used by other per CPU events? */
+	if (defer->nr_cpu_events)
+		return;
+
+	list_del(&defer->list);
+	/* The defer->cpu_events is protected by RCU */
+	call_rcu(&defer->rcu_head, free_unwind_deferred_rcu);
+}
+
 static void perf_pending_unwind_sync(struct perf_event *event)
 {
 	might_sleep();
 
+	perf_remove_unwind_deferred(event);
+
 	if (!event->pending_unwind_callback)
 		return;
 
@@ -5614,63 +5797,119 @@ struct perf_callchain_deferred_event {
 	u64				ips[];
 };
 
-static void perf_event_callchain_deferred(struct callback_head *work)
+static void perf_event_callchain_deferred(struct perf_event *event,
+					  struct unwind_stacktrace *trace,
+					  u64 cookie)
 {
-	struct perf_event *event = container_of(work, struct perf_event, pending_unwind_work);
 	struct perf_callchain_deferred_event deferred_event;
 	u64 callchain_context = PERF_CONTEXT_USER;
-	struct unwind_stacktrace trace;
 	struct perf_output_handle handle;
 	struct perf_sample_data data;
 	u64 nr;
 
-	if (!event->pending_unwind_callback)
-		return;
-
-	if (unwind_user_faultable(&trace) < 0)
-		goto out;
-
-	/*
-	 * All accesses to the event must belong to the same implicit RCU
-	 * read-side critical section as the ->pending_unwind_callback reset.
-	 * See comment in perf_pending_unwind_sync().
-	 */
-	guard(rcu)();
-
 	if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
-		goto out;
+		return;
 
-	nr = trace.nr + 1 ; /* '+1' == callchain_context */
+	nr = trace->nr + 1 ; /* '+1' == callchain_context */
 
 	deferred_event.header.type = PERF_RECORD_CALLCHAIN_DEFERRED;
 	deferred_event.header.misc = PERF_RECORD_MISC_USER;
 	deferred_event.header.size = sizeof(deferred_event) + (nr * sizeof(u64));
 
 	deferred_event.nr = nr;
-	deferred_event.cookie = unwind_user_get_cookie();
+	deferred_event.cookie = cookie;
 
 	perf_event_header__init_id(&deferred_event.header, &data, event);
 
 	if (perf_output_begin(&handle, &data, event, deferred_event.header.size))
-		goto out;
+		return;
 
 	perf_output_put(&handle, deferred_event);
 	perf_output_put(&handle, callchain_context);
-	/* trace.entries[] are not guaranteed to be 64bit */
-	for (int i = 0; i < trace.nr; i++) {
-		u64 entry = trace.entries[i];
+	/* trace->entries[] are not guaranteed to be 64bit */
+	for (int i = 0; i < trace->nr; i++) {
+		u64 entry = trace->entries[i];
 		perf_output_put(&handle, entry);
 	}
 	perf_event__output_id_sample(event, &handle, &data);
 
 	perf_output_end(&handle);
+}
+
+/* Deferred unwinding callback for task specific events */
+static void perf_event_deferred_task(struct callback_head *work)
+{
+	struct perf_event *event = container_of(work, struct perf_event, pending_unwind_work);
+	struct unwind_stacktrace trace;
+
+	if (!event->pending_unwind_callback)
+		return;
+
+	if (unwind_user_faultable(&trace) >= 0) {
+		u64 cookie = unwind_user_get_cookie();
+
+		/*
+		 * All accesses to the event must belong to the same implicit RCU
+		 * read-side critical section as the ->pending_unwind_callback reset.
+		 * See comment in perf_pending_unwind_sync().
+		 */
+		guard(rcu)();
+		perf_event_callchain_deferred(event, &trace, cookie);
+	}
 
-out:
 	event->pending_unwind_callback = 0;
 	local_dec(&event->ctx->nr_no_switch_fast);
 	rcuwait_wake_up(&event->pending_unwind_wait);
 }
 
+/*
+ * Deferred unwinding callback for per CPU events.
+ * Note, the request for the deferred unwinding may have happened
+ * on a different CPU.
+ */
+static void perf_event_deferred_cpu(struct unwind_work *work,
+				    struct unwind_stacktrace *trace, u64 cookie)
+{
+	struct perf_unwind_deferred *defer =
+		container_of(work, struct perf_unwind_deferred, unwind_work);
+	struct perf_unwind_cpu *cpu_events, *cpu_unwind;
+	struct perf_event *event;
+	int cpu;
+
+	guard(rcu)();
+	guard(preempt)();
+
+	cpu = smp_processor_id();
+	cpu_events = rcu_dereference(defer->cpu_events);
+	cpu_unwind = &cpu_events[cpu];
+
+	WRITE_ONCE(cpu_unwind->processing, 1);
+	/*
+	 * Make sure the above is seen before the event->unwind_deferred
+	 * is checked. This matches the mb() in rcuwait_rcu_wait_event() in
+	 * perf_remove_unwind_deferred().
+	 */
+	smp_mb();
+
+	list_for_each_entry_rcu(event, &cpu_unwind->list, unwind_list) {
+		/* If unwind_deferred is NULL the event is going away */
+		if (unlikely(!event->unwind_deferred))
+			continue;
+		perf_event_callchain_deferred(event, trace, cookie);
+		/* Only the first CPU event gets the trace */
+		break;
+	}
+
+	/*
+	 * The perf_event_callchain_deferred() must finish before setting
+	 * cpu_unwind->processing to zero. This is also to synchronize
+	 * with the rcuwait in perf_remove_unwind_deferred().
+	 */
+	smp_mb();
+	WRITE_ONCE(cpu_unwind->processing, 0);
+	rcuwait_wake_up(&cpu_unwind->pending_unwind_wait);
+}
+
 static void perf_free_addr_filters(struct perf_event *event);
 
 /* vs perf_event_alloc() error */
@@ -8284,6 +8523,17 @@ static u64 perf_get_page_size(unsigned long addr)
 
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
+
+static int deferred_unwind_request(struct perf_unwind_deferred *defer,
+				   u64 *defer_cookie)
+{
+	/*
+	 * Returns 0 for queued, 1 for already queued or executed,
+	 * and negative on error.
+	 */
+	return unwind_deferred_request(&defer->unwind_work, defer_cookie);
+}
+
 /*
  * Returns:
 *     > 0 : if already queued.
@@ -8293,17 +8543,22 @@ static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 static int deferred_request(struct perf_event *event, u64 *defer_cookie)
 {
 	struct callback_head *work = &event->pending_unwind_work;
+	struct perf_unwind_deferred *defer;
 	int pending;
 	int ret;
 
-	/* Only defer for task events */
-	if (!event->ctx->task)
-		return -EINVAL;
-
 	if ((current->flags & (PF_KTHREAD | PF_USER_WORKER)) ||
 	    !user_mode(task_pt_regs(current)))
 		return -EINVAL;
 
+	defer = READ_ONCE(event->unwind_deferred);
+	if (defer)
+		return deferred_unwind_request(defer, defer_cookie);
+
+	/* Per CPU events should have had unwind_deferred set! */
+	if (WARN_ON_ONCE(!event->ctx->task))
+		return -EINVAL;
+
 	guard(irqsave)();
 
 	*defer_cookie = unwind_user_get_cookie();
@@ -13197,13 +13452,20 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		}
 	}
 
+	/* Setup unwind deferring for per CPU events */
+	if (event->attr.defer_callchain && !task) {
+		err = perf_add_unwind_deferred(event);
+		if (err)
+			return ERR_PTR(err);
+	}
+
 	err = security_perf_event_alloc(event);
 	if (err)
 		return ERR_PTR(err);
 
 	if (event->attr.defer_callchain)
 		init_task_work(&event->pending_unwind_work,
-			       perf_event_callchain_deferred);
+			       perf_event_deferred_task);
 
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
-- 
2.50.1



