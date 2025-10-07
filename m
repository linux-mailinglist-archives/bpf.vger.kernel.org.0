Return-Path: <bpf+bounces-70543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA1FBC2C4F
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 23:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53B319A1AC5
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 21:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F902594BD;
	Tue,  7 Oct 2025 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V808DNoc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809E257AC7;
	Tue,  7 Oct 2025 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873172; cv=none; b=Pd20lfsJk3uNAL7VDLpAJF8na8v+a1/mbCgsOAr9upGRPBfarYhHhdq3H+oxnvR48oUWeLdaf4DBtoLfEPXXgmggFhxz0gAbWbitZfoM9tkMeBS6N/v/FitlkgtUsazM6ZPiER37sAmBWE67uIdc9kfiULqTCjOURtnJCg0qvjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873172; c=relaxed/simple;
	bh=D06TbRvbVUHVeuqDOyzHwBOpkcOYTaaD6lbumAflENI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RqKQzoAqJuxvSP5mjrjk99L07cxEF+n2qfcXBA0aG0gBgSzNwzeu2fLc/ZpAc7420IO8hz/PQvCC9W80MxSgVcynYVNpXqWwriCVuRVhsXvtySvnPi5IfugllaOVh1p2HE5J/gXiLAI3YgUDOpCl9ZbpeZLcegeRyX2iVsLXwIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V808DNoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE00C4CEF1;
	Tue,  7 Oct 2025 21:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759873171;
	bh=D06TbRvbVUHVeuqDOyzHwBOpkcOYTaaD6lbumAflENI=;
	h=Date:From:To:Cc:Subject:References:From;
	b=V808DNochsSz23Wt5h2hCDYkiU+D91eOcVnejAcf29WHh1slPBfvNnY+yvVR+w7NT
	 O+03GDRS8g7rt/Fz+RNivRcaRl/efJAfRUF/XTjb8VIk0+4ZyvlshHK07S55mvOGK+
	 RV1ec/gcV0vW3hGdJL2X48RBNyGFMrqw1ABKd5qiWhGv8miRbGZEHEOKV/OExtM47H
	 1RJXBUglBRpqusAV6vp79mZfBxfqnOywWmSbTsxufs6qtfxsu3ZOaJn+5suBEPbGv9
	 tBPHYgPXv9jZBFcAIznVA42rduebpp1bBUN27ir2Yw+EQ7r3AIuxiy3Wt9lQfT8oKC
	 JFi5ZkcAlG3lg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v6FQy-00000007XhB-0ows;
	Tue, 07 Oct 2025 17:41:24 -0400
Message-ID: <20251007214124.043929009@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 07 Oct 2025 17:40:12 -0400
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
Subject: [PATCH v16 4/4] perf: Support deferred user callchains for per CPU events
References: <20251007214008.080852573@kernel.org>
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
just individual event buffers. This is problematic if a delayed request
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
 kernel/events/core.c       | 260 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 260 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a0f95f751b44..b6b7cd6d67a5 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -733,6 +733,7 @@ struct swevent_hlist {
 struct bpf_prog;
 struct perf_cgroup;
 struct perf_buffer;
+struct perf_unwind_deferred;
 
 struct pmu_event_list {
 	raw_spinlock_t			lock;
@@ -883,6 +884,9 @@ struct perf_event {
 
 	struct unwind_work		unwind_work;
 
+	struct perf_unwind_deferred	*unwind_deferred;
+	struct list_head		unwind_list;
+
 	atomic_t			event_limit;
 
 	/* address range filters */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f003a1f9497a..f3e48cc4b32d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5582,10 +5582,192 @@ static bool exclusive_event_installable(struct perf_event *event,
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
+ * use the current->group_leader->pid as the identifier of what
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
 	struct unwind_work *work = &event->unwind_work;
 
+	perf_remove_unwind_deferred(event);
 	unwind_deferred_cancel(work);
 }
 
@@ -5643,6 +5825,54 @@ static void perf_event_deferred_task(struct unwind_work *work,
 	local_dec(&event->ctx->nr_no_switch_fast);
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
@@ -8256,6 +8486,22 @@ static u64 perf_get_page_size(unsigned long addr)
 
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
+
+static int deferred_unwind_request(struct perf_unwind_deferred *defer,
+				   u64 *defer_cookie)
+{
+	int ret;
+
+	ret = unwind_deferred_request(&defer->unwind_work, defer_cookie);
+
+	/*
+	 * Return 1 on success or negative on error.
+	 * Do not return zero as not to increment nr_no_switch_fast.
+	 * That's not needed here.
+	 */
+	return ret < 0 ? ret : 1;
+}
+
 /*
  * Returns:
 *     > 0 : if already queued.
@@ -8265,15 +8511,16 @@ static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 static int deferred_request(struct perf_event *event, u64 *defer_cookie)
 {
 	struct unwind_work *work = &event->unwind_work;
-
-	/* Only defer for task events */
-	if (!event->ctx->task)
-		return -EINVAL;
+	struct perf_unwind_deferred *defer;
 
 	if ((current->flags & (PF_KTHREAD | PF_USER_WORKER)) ||
 	    !user_mode(task_pt_regs(current)))
 		return -EINVAL;
 
+	defer = READ_ONCE(event->unwind_deferred);
+	if (defer)
+		return deferred_unwind_request(defer, defer_cookie);
+
 	return unwind_deferred_request(work, defer_cookie);
 }
 
@@ -13149,6 +13396,11 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		if (task) {
 			err = unwind_deferred_task_init(&event->unwind_work,
 							perf_event_deferred_task);
+		} else {
+			/* Setup unwind deferring for per CPU events */
+			err = perf_add_unwind_deferred(event);
+			if (err)
+				return ERR_PTR(err);
 		}
 	}
 
-- 
2.50.1



