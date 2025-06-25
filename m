Return-Path: <bpf+bounces-61623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8C2AE921C
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 01:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 452A17B6A73
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 23:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083322FD874;
	Wed, 25 Jun 2025 23:16:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C22F5499;
	Wed, 25 Jun 2025 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893367; cv=none; b=lAHLJBKJhVn8sn0wF/+898my/dCxL8fjJoEKZvRKnFYJRgf4xbLP1Xp35OQHKTvrSAwn8yAvTV7NR7uVlCEcedAqlve9WmIhTDnZVMZX1Er/m/0fVC3SZn9iDYoq7TQQdrMrmYbZZQlDKIQk8fKic11VN8e3vBDrrth1ClGwJLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893367; c=relaxed/simple;
	bh=6hlWRK7eLiQbBAOxoeYh7opCi7gLvsIfLDxBI5Z0v3s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=f9j7yYr5cmD/b84QRYN83jtzFjdDraytgApNh++uBwmtRg3e81bFMNmMYWjfXn9i9f0gKU7/5wOcCQ3JTei2rlh1zPNcKzzXPczX/n9KFU1g62h6Tqj4zaNb9xp623y3z9xQVxJjAYFhzyuKZ2TBLfSZAK5BFCq3q4Ed/yubevc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 3E67A104843;
	Wed, 25 Jun 2025 23:16:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id BFDF21B;
	Wed, 25 Jun 2025 23:15:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZLq-000000044ii-4BkQ;
	Wed, 25 Jun 2025 19:16:23 -0400
Message-ID: <20250625231622.846993672@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 19:15:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
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
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v11 07/11] perf: Support deferred user callchains for per CPU events
References: <20250625231541.584226205@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: yjq1tr6yetzywuuijugseduxxxrt7oer
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BFDF21B
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18VE1wvHbsVhsZxHaoGdht5wkOxc4u2b1M=
X-HE-Tag: 1750893357-619582
X-HE-Meta: U2FsdGVkX19/3MZH75rEkuFB8YQW8PvqgiQ2d1mTGaapD49apgEP0L7zz8GepQ3FfFdaJZ9hVZ5n5sh3nDXLztspNDYHcTBBwZ5Xl+2PJ9zIk0Byh1sTPa6R9InpiwZR3vXaUA1UeZh7ybIILaeV4KrCAIcHzFbz/SB5IyYv9xyDIXEK2fvk09du/zpWesaTJ8oVoppBpd4M/TLDeKaDFrB0u8AoR9AQZbJNw10eV40Y+3i4TCvQA8Z2kqdEiutX9RK8Jrr470V0eGosz1KhnGwjvZP3/0c5JA3YYHYDvh3O1KmaqXIww23XRc98Xu7YYOJUZ1mhi5prevkB9mYd89CTxcIuakuUzXk6cUajLNt0NpcewEj8hSKS41U5qjXUReJbiAF3vIAe8tKfslsHWYatU7RdbSlBOYinNt/xpuA=

From: Steven Rostedt <rostedt@goodmis.org>

The deferred unwinder works fine for task events (events that trace only a
specific task), as it can use a task_work from an interrupt or NMI and
when the task goes back to user space it will call the event's callback to
do the deferred unwinding.

But for per CPU events things are not so simple. When a per CPU event
wants a deferred unwinding to occur, it can not simply use a task_work as
there's a many to many relationship. If the task migrates and another task
is scheduled in where the per CPU event wants a deferred unwinding to
occur on that task as well, and the task that migrated to another CPU has
that CPU's event want to unwind it too, each CPU may need unwinding from
more than one task, and each task may have requests from many CPUs.

To solve this, when a per CPU event is created that has defer_callchain
attribute set, it will do a lookup from a global list
(unwind_deferred_list), for a perf_unwind_deferred descriptor that has the
id that matches the PID of the current task's group_leader.

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
perf_deferred_unwind descriptor is already created, it just adds itself to
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
Changes since v10: https://lore.kernel.org/20250614024716.798086123@goodmis.org

- Added another smp_mb() between the call to perf_event_callchain_deferred()
  and clearing of cpu_unwind->processing.

- Update using the renamed function that was renamed from
  unwind_deferred_trace() to unwind_user_faultable().

 include/linux/perf_event.h |   5 +
 kernel/events/core.c       | 303 ++++++++++++++++++++++++++++++++++---
 2 files changed, 283 insertions(+), 25 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c7d474391e51..04d9e6fb64c4 100644
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
@@ -925,6 +929,7 @@ struct perf_event {
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
+
 	struct list_head		sb_list;
 	struct list_head		pmu_list;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1bb76c39ccb1..ded734045e07 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5582,10 +5582,185 @@ static bool exclusive_event_installable(struct perf_event *event,
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
+				    struct unwind_stacktrace *trace, u64 timestamp);
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
+	if (list_empty(&cpu_events[event->cpu].list))
+		defer->nr_cpu_events++;
+	list_add_tail_rcu(&event->unwind_list, &cpu_events[event->cpu].list);
+
+	event->unwind_deferred = defer;
+	return 0;
+free:
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
+	/*
+	 * This is called by call_rcu() and there are no more
+	 * references to cpu_events.
+	 */
+	cpu_events = rcu_dereference_protected(defer->cpu_events, 1);
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
 
@@ -5609,62 +5784,119 @@ static void perf_pending_unwind_sync(struct perf_event *event)
 
 struct perf_callchain_deferred_event {
 	struct perf_event_header	header;
+	u64				timestamp;
 	u64				nr;
 	u64				ips[];
 };
 
-static void perf_event_callchain_deferred(struct callback_head *work)
+static void perf_event_callchain_deferred(struct perf_event *event,
+					  struct unwind_stacktrace *trace,
+					  u64 timestamp)
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
-	if (unwind_deferred_trace(&trace) < 0)
-		goto out;
-
-	/*
-	 * All accesses to the event must belong to the same implicit RCU
-	 * read-side critical section as the ->pending_unwind_callback reset.
-	 * See comment in perf_pending_unwind_sync().
-	 */
-	guard(rcu)();
-
 	if (current->flags & PF_KTHREAD)
-		goto out;
+		return;
 
-	nr = trace.nr + 1 ; /* '+1' == callchain_context */
+	nr = trace->nr + 1 ; /* '+1' == callchain_context */
 
 	deferred_event.header.type = PERF_RECORD_CALLCHAIN_DEFERRED;
 	deferred_event.header.misc = PERF_RECORD_MISC_USER;
 	deferred_event.header.size = sizeof(deferred_event) + (nr * sizeof(u64));
 
+	deferred_event.timestamp = timestamp;
 	deferred_event.nr = nr;
 
 	perf_event_header__init_id(&deferred_event.header, &data, event);
 
 	if (perf_output_begin(&handle, &data, event, deferred_event.header.size))
-		goto out;
+		return;
 
 	perf_output_put(&handle, deferred_event);
 	perf_output_put(&handle, callchain_context);
-	perf_output_copy(&handle, trace.entries, trace.nr * sizeof(u64));
+	perf_output_copy(&handle, trace->entries, trace->nr * sizeof(u64));
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
+
+		/*
+		 * All accesses to the event must belong to the same implicit RCU
+		 * read-side critical section as the ->pending_unwind_callback reset.
+		 * See comment in perf_pending_unwind_sync().
+		 */
+		guard(rcu)();
+		perf_event_callchain_deferred(event, &trace, 0);
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
+				    struct unwind_stacktrace *trace, u64 timestamp)
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
+		perf_event_callchain_deferred(event, trace, timestamp);
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
@@ -8263,6 +8495,15 @@ static int deferred_request_nmi(struct perf_event *event)
 	return 0;
 }
 
+static int deferred_unwind_request(struct perf_unwind_deferred *defer)
+{
+	u64 timestamp;
+	int ret;
+
+	ret = unwind_deferred_request(&defer->unwind_work, &timestamp);
+	return ret < 0 ? ret : 0;
+}
+
 /*
  * Returns:
 *     > 0 : if already queued.
@@ -8272,14 +8513,19 @@ static int deferred_request_nmi(struct perf_event *event)
 static int deferred_request(struct perf_event *event)
 {
 	struct callback_head *work = &event->pending_unwind_work;
+	struct perf_unwind_deferred *defer;
 	int pending;
 	int ret;
 
-	/* Only defer for task events */
-	if (!event->ctx->task)
+	if ((current->flags & PF_KTHREAD) || !user_mode(task_pt_regs(current)))
 		return -EINVAL;
 
-	if ((current->flags & PF_KTHREAD) || !user_mode(task_pt_regs(current)))
+	defer = READ_ONCE(event->unwind_deferred);
+	if (defer)
+		return deferred_unwind_request(defer);
+
+	/* Per CPU events should have had unwind_deferred set! */
+	if (WARN_ON_ONCE(!event->ctx->task))
 		return -EINVAL;
 
 	if (in_nmi())
@@ -13174,13 +13420,20 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
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
2.47.2



