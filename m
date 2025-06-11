Return-Path: <bpf+bounces-60426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EB5AD6517
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 03:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0253AC10F
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 01:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D04A13635E;
	Thu, 12 Jun 2025 01:22:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BCE1EB3D;
	Thu, 12 Jun 2025 01:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749691375; cv=none; b=fCFYxSN8Ja8PwR1dSlzONjWKoCRmE7wwX6PNgZ6t7ZfjmICxjxxL12BoSmRtkb4DAz2DCljjV6kdNbLGCcT1kwsnrCiGcZEjv0gYUbSMHAAJnhNQNkHgsPMLMkiNnEx1KsrE/vLls10FPlW/hfMCzJbkLqXtkm2wfRKkljcrha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749691375; c=relaxed/simple;
	bh=0oVl373wY21Xyj3OL1Cxn1wzA2vU1rJzvKxIilN4bFA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Spi/eC/QrxHCyAF2ct4BdinYOkM7eO8k+rpn+dcsnUlcVYALhV6AwJ5tDNqfx5NgjlfO4Yg90ohZXaWCu1lKOo0DFjJE0m24qRWnQJ+Cpw6AaJSiNHcyV6MSRzZgs2JxqDlQ1rpuoT/uwX6hYz9+IV68XkxRwflnPHCDMf1gj/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 1D645121825;
	Thu, 12 Jun 2025 01:22:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 01FA21C;
	Thu, 12 Jun 2025 01:22:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPAPM-00000000wRM-1c6Y;
	Tue, 10 Jun 2025 21:37:40 -0400
Message-ID: <20250611013740.234640670@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 21:34:32 -0400
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
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 11/11] perf: Support deferred user callchains for per CPU events
References: <20250611013421.040264741@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: 3ob3wz1ea1s3icbphmne47mn75jqac1k
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 01FA21C
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+NEE2+Rk1mkyIxDMKQzwj6ZDo8XXCMOcg=
X-HE-Tag: 1749691359-673213
X-HE-Meta: U2FsdGVkX19GRUEBLssl2TzSyf8E/HlqRc0SIMismRj1c3ZmTrNGnnQV5i0n8UtkRXkg8rMFx15HfH0GslHcfV+1WcwMTiWTP0cR2/S4pr4h8fLl1+kqQMhyB16Ob5VBRJPcc8y+BgxJaHngwTzuW6Wr4W2K5P1HcAopy/RBt7Ec08QR1TW7RuWF2Lsd3bZ8ehbN8vWRLRualIpGhQk6i5T52frTIktPTaPMJDRkN5AGucEHXz2QdMZS18556iWLJlfCZ5uh6d0W8B1CQDU30jqNMIV1wc+hXA4+LjMt92cO6C8a9uZZcv5K3sQ+x4l2uepGIglhM2IDSEApHhldVa+HtDcmc/e8UxemdBzUHficJiHShpZ85Em1Jj0LU3MwEYxfsdgv+vzupicxR15Mnw==

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
more than one task, and each task may has requests from many CPUs.

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
when it become empty, it is no longer referenced.

Finally, the perf_deferred_unwind descriptor has an id that holds the PID
of the group_leader for the tasks that the events were created by.

When a second (or more) per CPU event is created where the
perf_deferred_unwind descriptor is already created, it just adds itself to
the perf_unwind_cpu array of that descriptor. Updating the necessary
counter.

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
 include/linux/perf_event.h |   5 +
 kernel/events/core.c       | 229 +++++++++++++++++++++++++++++++++----
 2 files changed, 209 insertions(+), 25 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 416d55d2e81b..2a45d445be93 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -695,6 +695,7 @@ struct swevent_hlist {
 struct bpf_prog;
 struct perf_cgroup;
 struct perf_buffer;
+struct perf_unwind_deferred;
 
 struct pmu_event_list {
 	raw_spinlock_t			lock;
@@ -847,6 +848,9 @@ struct perf_event {
 	struct callback_head		pending_unwind_work;
 	struct rcuwait			pending_unwind_wait;
 
+	struct perf_unwind_deferred	*unwind_deferred;
+	struct list_head		unwind_list;
+
 	atomic_t			event_limit;
 
 	/* address range filters */
@@ -887,6 +891,7 @@ struct perf_event {
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
+
 	struct list_head		sb_list;
 	struct list_head		pmu_list;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5a31f5c30299..195bdc3f2a8f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5564,10 +5564,128 @@ static bool exclusive_event_installable(struct perf_event *event,
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
+	struct list_head	list;
+	struct unwind_work	unwind_work;
+	struct perf_unwind_cpu	*cpu_events;
+	int			nr_cpu_events;
+	int			id;
+};
+
+static DEFINE_MUTEX(unwind_deferred_mutex);
+static LIST_HEAD(unwind_deferred_list);
+
+static void perf_event_deferred_cpu(struct unwind_work *work,
+				    struct unwind_stacktrace *trace, u64 timestamp);
+
+static int perf_add_unwind_deferred(struct perf_event *event)
+{
+	struct perf_unwind_deferred *defer;
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
+	if (!defer->nr_cpu_events) {
+		defer->cpu_events = kcalloc(num_possible_cpus(),
+					    sizeof(*defer->cpu_events),
+					    GFP_KERNEL);
+		if (!defer->cpu_events) {
+			ret = -ENOMEM;
+			goto free;
+		}
+		for (int cpu = 0; cpu < num_possible_cpus(); cpu++) {
+			rcuwait_init(&defer->cpu_events[cpu].pending_unwind_wait);
+			INIT_LIST_HEAD(&defer->cpu_events[cpu].list);
+		}
+
+		ret = unwind_deferred_init(&defer->unwind_work,
+					   perf_event_deferred_cpu);
+		if (ret)
+			goto free;
+	}
+
+	if (list_empty(&defer->cpu_events[event->cpu].list))
+		defer->nr_cpu_events++;
+	list_add_tail_rcu(&event->unwind_list, &defer->cpu_events[event->cpu].list);
+
+	event->unwind_deferred = defer;
+	return 0;
+free:
+	if (found)
+		return ret;
+
+	list_del(&defer->list);
+	kfree(defer->cpu_events);
+	kfree(defer);
+	return ret;
+}
+
+static void perf_remove_unwind_deferred(struct perf_event *event)
+{
+	struct perf_unwind_deferred *defer = event->unwind_deferred;
+	struct perf_unwind_cpu *cpu_unwind;
+
+	if (!defer)
+		return;
+
+	guard(mutex)(&unwind_deferred_mutex);
+	list_del_rcu(&event->unwind_list);
+
+	cpu_unwind = &defer->cpu_events[event->cpu];
+
+	if (list_empty(&cpu_unwind->list)) {
+		defer->nr_cpu_events--;
+		if (!defer->nr_cpu_events)
+			unwind_deferred_cancel(&defer->unwind_work);
+	}
+	/* Make sure perf_event_deferred_cpu() is done with this event */
+	rcuwait_wait_event(&cpu_unwind->pending_unwind_wait,
+				   !cpu_unwind->processing, TASK_UNINTERRUPTIBLE);
+
+	event->unwind_deferred = NULL;
+
+	/* Is this still being used by other per CPU events? */
+	if (defer->nr_cpu_events)
+		return;
+
+	list_del(&defer->list);
+	kfree(defer->cpu_events);
+	kfree(defer);
+}
+
 static void perf_pending_unwind_sync(struct perf_event *event)
 {
 	might_sleep();
 
+	perf_remove_unwind_deferred(event);
+
 	if (!event->pending_unwind_callback)
 		return;
 
@@ -5591,62 +5709,104 @@ static void perf_pending_unwind_sync(struct perf_event *event)
 
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
+	if (unwind_deferred_trace(&trace) >= 0) {
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
 
+/* Deferred unwinding callback for per CPU events */
+static void perf_event_deferred_cpu(struct unwind_work *work,
+				    struct unwind_stacktrace *trace, u64 timestamp)
+{
+	struct perf_unwind_deferred *defer =
+		container_of(work, struct perf_unwind_deferred, unwind_work);
+	struct perf_unwind_cpu *cpu_unwind;
+	struct perf_event *event;
+	int cpu;
+
+	guard(rcu)();
+	guard(preempt)();
+
+	cpu = smp_processor_id();
+	cpu_unwind = &defer->cpu_events[cpu];
+
+	WRITE_ONCE(cpu_unwind->processing, 1);
+	/*
+	 * Make sure the above is seen for the rcuwait in
+	 * perf_remove_unwind_deferred() before iterating the loop.
+	 */
+	smp_mb();
+
+	list_for_each_entry_rcu(event, &cpu_unwind->list, unwind_list) {
+		perf_event_callchain_deferred(event, trace, timestamp);
+		/* Only the first CPU event gets the trace */
+		break;
+	}
+
+	WRITE_ONCE(cpu_unwind->processing, 0);
+	rcuwait_wake_up(&cpu_unwind->pending_unwind_wait);
+}
+
 static void perf_free_addr_filters(struct perf_event *event);
 
 /* vs perf_event_alloc() error */
@@ -8241,6 +8401,15 @@ static int deferred_request_nmi(struct perf_event *event)
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
@@ -8253,11 +8422,14 @@ static int deferred_request(struct perf_event *event)
 	int pending;
 	int ret;
 
-	/* Only defer for task events */
-	if (!event->ctx->task)
+	if ((current->flags & PF_KTHREAD) || !user_mode(task_pt_regs(current)))
 		return -EINVAL;
 
-	if ((current->flags & PF_KTHREAD) || !user_mode(task_pt_regs(current)))
+	if (event->unwind_deferred)
+		return deferred_unwind_request(event->unwind_deferred);
+
+	/* Per CPU events should have had unwind_deferred set! */
+	if (WARN_ON_ONCE(!event->ctx->task))
 		return -EINVAL;
 
 	if (in_nmi())
@@ -13142,13 +13314,20 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
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



