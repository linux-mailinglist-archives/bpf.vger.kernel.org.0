Return-Path: <bpf+bounces-57688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64078AAE7E6
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E7B3AB8F7
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0A128C840;
	Wed,  7 May 2025 17:34:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA41DE8A0;
	Wed,  7 May 2025 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746639291; cv=none; b=ZO65RrKbKUPlBTyxEN5ZnQ8U7FKuKD8trdl+OjB6jwiLwKrOHJK4EHLX3Ifp9sdBRD8sozpnLjKGPnaTYaA2dI+gOoEWpwiyiZT35+HvbmsdgWvk6fKf9gyQhYmNr9nMHAtzr/iL4RCUfPsq/jpXHP3Zfy1q1FGiMof0uLcRo2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746639291; c=relaxed/simple;
	bh=bvfTT/c7PtSh5mfjONtRBKUwBzWauHatYMl5dd7rveI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kseYFD9EMAjJH2QpRhPTLCgZwxSIDrNshCKZNw28u8Mdx8YCP2QPhj662LZW1CO3kJPRtCRwFqR0x+aTp+opPCdp23G7Z+89t7BbnonVkFqVpewJDMArhY26jvjVU9iUiKS7IourV54isxC1WSKvx0keWLzOhH457aE+A4et76w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E26BC4CEE2;
	Wed,  7 May 2025 17:34:48 +0000 (UTC)
Date: Wed, 7 May 2025 13:34:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Bhupesh <bhupesh@igalia.com>, Andrew
 Morton <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, arnaldo.melo@gmail.com, Juri Lelli
 <juri.lelli@redhat.com>
Subject: [RFC][PATCH] tracing/sched: Use __string() instead of fixed lengths
 for task->comm
Message-ID: <20250507133458.51bafd95@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The sched_switch and sched_waking events hardcoded the length of the comm
it recorded because these events were created before the dynamic strings
were implemented. Unfortunately, several other events copied this method.

As the size of the comm may change in the future, make the string dynamic.
The dynamic string requires a 4 byte meta data to hold the size and offset
of the string. The amount stored in the ring buffer will then be the
strlen(comm) + 5 (for the \n), and aligned to 4 bytes if there's no other
strings. This means that a task comm can have up to 10 characters before it
requires another 4 bytes in the ring buffer. Most tasks are usually less
than that, so this should not be a problem, and it also allows the name to
be extended over the TASK_COMM_LEN [1]

Note, sched_switch and the sched_waking trace events still hardcode the
length, as there is tooling that still requires that. An effort to update
the tooling will be made to allow this to change in the future.

[1] https://lore.kernel.org/all/20250507110444.963779-1-bhupesh@igalia.com/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/sched.h | 94 ++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 8994e97d86c1..d9bc808f4d2a 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -20,16 +20,16 @@ TRACE_EVENT(sched_kthread_stop,
 	TP_ARGS(t),
 
 	TP_STRUCT__entry(
-		__array(	char,	comm,	TASK_COMM_LEN	)
-		__field(	pid_t,	pid			)
+		__string(	comm,	t->comm		)
+		__field(	pid_t,	pid		)
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
+		__assign_str(comm);
 		__entry->pid	= t->pid;
 	),
 
-	TP_printk("comm=%s pid=%d", __entry->comm, __entry->pid)
+	TP_printk("comm=%s pid=%d", __get_str(comm), __entry->pid)
 );
 
 /*
@@ -276,15 +276,15 @@ TRACE_EVENT(sched_migrate_task,
 	TP_ARGS(p, dest_cpu),
 
 	TP_STRUCT__entry(
-		__array(	char,	comm,	TASK_COMM_LEN	)
-		__field(	pid_t,	pid			)
-		__field(	int,	prio			)
-		__field(	int,	orig_cpu		)
-		__field(	int,	dest_cpu		)
+		__string(	comm,	p->comm		)
+		__field(	pid_t,	pid		)
+		__field(	int,	prio		)
+		__field(	int,	orig_cpu	)
+		__field(	int,	dest_cpu	)
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		__assign_str(comm);
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
 		__entry->orig_cpu	= task_cpu(p);
@@ -292,7 +292,7 @@ TRACE_EVENT(sched_migrate_task,
 	),
 
 	TP_printk("comm=%s pid=%d prio=%d orig_cpu=%d dest_cpu=%d",
-		  __entry->comm, __entry->pid, __entry->prio,
+		  __get_str(comm), __entry->pid, __entry->prio,
 		  __entry->orig_cpu, __entry->dest_cpu)
 );
 
@@ -303,19 +303,19 @@ DECLARE_EVENT_CLASS(sched_process_template,
 	TP_ARGS(p),
 
 	TP_STRUCT__entry(
-		__array(	char,	comm,	TASK_COMM_LEN	)
-		__field(	pid_t,	pid			)
-		__field(	int,	prio			)
+		__string(	comm,	p->comm		)
+		__field(	pid_t,	pid		)
+		__field(	int,	prio		)
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		__assign_str(comm);
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
 	),
 
 	TP_printk("comm=%s pid=%d prio=%d",
-		  __entry->comm, __entry->pid, __entry->prio)
+		  __get_str(comm), __entry->pid, __entry->prio)
 );
 
 /*
@@ -349,19 +349,19 @@ TRACE_EVENT(sched_process_wait,
 	TP_ARGS(pid),
 
 	TP_STRUCT__entry(
-		__array(	char,	comm,	TASK_COMM_LEN	)
+		__string(	comm,	current->comm		)
 		__field(	pid_t,	pid			)
 		__field(	int,	prio			)
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__assign_str(comm);
 		__entry->pid		= pid_nr(pid);
 		__entry->prio		= current->prio; /* XXX SCHED_DEADLINE */
 	),
 
 	TP_printk("comm=%s pid=%d prio=%d",
-		  __entry->comm, __entry->pid, __entry->prio)
+		  __get_str(comm), __entry->pid, __entry->prio)
 );
 
 /*
@@ -374,22 +374,22 @@ TRACE_EVENT(sched_process_fork,
 	TP_ARGS(parent, child),
 
 	TP_STRUCT__entry(
-		__array(	char,	parent_comm,	TASK_COMM_LEN	)
-		__field(	pid_t,	parent_pid			)
-		__array(	char,	child_comm,	TASK_COMM_LEN	)
-		__field(	pid_t,	child_pid			)
+		__string(	parent_comm,	parent->comm	)
+		__field(	pid_t,		parent_pid	)
+		__string(	child_comm,	child->comm	)
+		__field(	pid_t,		child_pid	)
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->parent_comm, parent->comm, TASK_COMM_LEN);
+		__assign_str(parent_comm);
 		__entry->parent_pid	= parent->pid;
-		memcpy(__entry->child_comm, child->comm, TASK_COMM_LEN);
+		__assign_str(child_comm);
 		__entry->child_pid	= child->pid;
 	),
 
 	TP_printk("comm=%s pid=%d child_comm=%s child_pid=%d",
-		__entry->parent_comm, __entry->parent_pid,
-		__entry->child_comm, __entry->child_pid)
+		__get_str(parent_comm), __entry->parent_pid,
+		__get_str(child_comm), __entry->child_pid)
 );
 
 /*
@@ -473,19 +473,19 @@ DECLARE_EVENT_CLASS_SCHEDSTAT(sched_stat_template,
 	TP_ARGS(__perf_task(tsk), __perf_count(delay)),
 
 	TP_STRUCT__entry(
-		__array( char,	comm,	TASK_COMM_LEN	)
-		__field( pid_t,	pid			)
-		__field( u64,	delay			)
+		__string( comm,	tsk->comm	)
+		__field(  pid_t,	pid	)
+		__field(  u64,		delay	)
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__assign_str(comm);
 		__entry->pid	= tsk->pid;
 		__entry->delay	= delay;
 	),
 
 	TP_printk("comm=%s pid=%d delay=%Lu [ns]",
-			__entry->comm, __entry->pid,
+			__get_str(comm), __entry->pid,
 			(unsigned long long)__entry->delay)
 );
 
@@ -531,19 +531,19 @@ DECLARE_EVENT_CLASS(sched_stat_runtime,
 	TP_ARGS(tsk, __perf_count(runtime)),
 
 	TP_STRUCT__entry(
-		__array( char,	comm,	TASK_COMM_LEN	)
-		__field( pid_t,	pid			)
-		__field( u64,	runtime			)
+		__string( comm,		tsk->comm	)
+		__field(  pid_t,	pid		)
+		__field(  u64,		runtime		)
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__assign_str(comm);
 		__entry->pid		= tsk->pid;
 		__entry->runtime	= runtime;
 	),
 
 	TP_printk("comm=%s pid=%d runtime=%Lu [ns]",
-			__entry->comm, __entry->pid,
+			__get_str(comm), __entry->pid,
 			(unsigned long long)__entry->runtime)
 );
 
@@ -562,14 +562,14 @@ TRACE_EVENT(sched_pi_setprio,
 	TP_ARGS(tsk, pi_task),
 
 	TP_STRUCT__entry(
-		__array( char,	comm,	TASK_COMM_LEN	)
-		__field( pid_t,	pid			)
-		__field( int,	oldprio			)
-		__field( int,	newprio			)
+		__string( comm,		tsk->comm	)
+		__field(  pid_t,	pid		)
+		__field(  int,		oldprio		)
+		__field(  int,		newprio		)
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__assign_str(comm);
 		__entry->pid		= tsk->pid;
 		__entry->oldprio	= tsk->prio;
 		__entry->newprio	= pi_task ?
@@ -579,7 +579,7 @@ TRACE_EVENT(sched_pi_setprio,
 	),
 
 	TP_printk("comm=%s pid=%d oldprio=%d newprio=%d",
-			__entry->comm, __entry->pid,
+			__get_str(comm), __entry->pid,
 			__entry->oldprio, __entry->newprio)
 );
 
@@ -589,16 +589,16 @@ TRACE_EVENT(sched_process_hang,
 	TP_ARGS(tsk),
 
 	TP_STRUCT__entry(
-		__array( char,	comm,	TASK_COMM_LEN	)
-		__field( pid_t,	pid			)
+		__string( comm,		tsk->comm	)
+		__field(  pid_t,	pid		)
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__assign_str(comm);
 		__entry->pid = tsk->pid;
 	),
 
-	TP_printk("comm=%s pid=%d", __entry->comm, __entry->pid)
+	TP_printk("comm=%s pid=%d", __get_str(comm), __entry->pid)
 );
 #endif /* CONFIG_DETECT_HUNG_TASK */
 
-- 
2.47.2


