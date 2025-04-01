Return-Path: <bpf+bounces-55097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D5AA7825F
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 20:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6A417019C
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 18:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B136720E6E3;
	Tue,  1 Apr 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/A7c/Us"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106BB1DB54C;
	Tue,  1 Apr 2025 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743532824; cv=none; b=BHlo9DKNTnb0UEakeE+NNB59cmE4IiT+Nb/jG0cwXntuvfJKNEiJmErYG5WwPRrX3wLmxhs5eGLPs4QbFHW0HXCtZq70o0xe5LnAMVn61itbfifQIpmgP2uTyku8fLcSDstAgndcYWiBR8kRctFv5ou+qcEvpngq6ftt7+6/jZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743532824; c=relaxed/simple;
	bh=gZ1+RQEab4vrqAsPEapyigxdzJWkp5QH7zI+l/5q5S8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gkbDozG8p1Q4YUNueocLulnxXzb7nV9swjcLp6GjBME5z4R5Xowe4bCU/9e/vWk1oJUf7eGUjd/xGN4wNWWeUf8/jSnbQviAvKoPIX8qQb1yjc0yo4lm5BoOrci6bsXoxRf4KgtfyrnwUvzHAiV1ILZfCJ2hrBpXrsJRZFNYt5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/A7c/Us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55326C4CEE4;
	Tue,  1 Apr 2025 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743532823;
	bh=gZ1+RQEab4vrqAsPEapyigxdzJWkp5QH7zI+l/5q5S8=;
	h=From:To:Cc:Subject:Date:From;
	b=H/A7c/Us1yDKaHJbJdN82uz2RHgMprCU/s4YHpO5ufSKanu/6hFsnuyNYWYumO9VC
	 6d8ZOWbS+ZV6ExDokfT1CSiL+oouUlD3Ih6WnBInvQFf4i0klcFVbMHmmKKFnchqpO
	 Ivkd2n8xE5m/xuMr/huKooP7QWSRcaWFf7ClVLQ+mw+/rRKWmH5Nu7bQ1QouHzJL6S
	 PsblQWvweMrcGunD6gr0t4nVsOtxQyXw7SA5cvS7PmipxBS9BCbE6EmUDpydJBUm8/
	 dV8V2n03nANAVaUTkvzgciaBDPwiy3Orj07igWay44Yuzt/Nr7Lp3nhyjnkSbsOo3e
	 1UGxUYRl0mbKg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	mhocko@kernel.org,
	rostedt@goodmis.org,
	oleg@redhat.com,
	brauner@kernel.org,
	glider@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH] exit: add trace_task_exit() tracepoint before current->mm is reset
Date: Tue,  1 Apr 2025 11:40:21 -0700
Message-ID: <20250401184021.2591443-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is useful to be able to access current->mm to, say, record a bunch of
VMA information right before the task exits (e.g., for stack
symbolization reasons when dealing with short-lived processes that exit
in the middle of profiling session). We currently do have
trace_sched_process_exit() in the exit path, but it is called a bit too
late, after exit_mm() resets current->mm to NULL, which makes it
unsuitable for inspecting and recording task's mm_struct-related data
when tracing process lifetimes.

There is a particularly suitable place, though, right after
taskstats_exit() is called, but before we do exit_mm(). taskstats
performs a similar kind of accounting that some applications do with
BPF, and so co-locating them seems like a good fit.

Moving trace_sched_process_exit() a bit earlier would solve this problem
as well, and I'm open to that. But this might potentially change its
semantics a little, and so instead of risking that, I went for adding
a new trace_task_exit() tracepoint instead. Tracepoints have zero
overhead at runtime, unless actively traced, so this seems acceptable.

Also, existing trace_sched_process_exit() tracepoint is notoriously
missing `group_dead` flag that is certainly useful in practice and some
of our production applications have to work around this. So plumb
`group_dead` through while at it, to have a richer and more complete
tracepoint.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/trace/events/task.h | 24 ++++++++++++++++++++++++
 kernel/exit.c               |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index af535b053033..98f4ec060073 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -53,6 +53,30 @@ TRACE_EVENT(task_rename,
 		  __entry->oldcomm, __entry->newcomm, __entry->oom_score_adj)
 );
 
+TRACE_EVENT(task_exit,
+
+	TP_PROTO(struct task_struct *task, bool group_dead),
+
+	TP_ARGS(task, group_dead),
+
+	TP_STRUCT__entry(
+		__field(	pid_t,	pid)
+		__array(	char,	comm, TASK_COMM_LEN)
+		__field(	bool,	group_dead)
+	),
+
+	TP_fast_assign(
+		__entry->pid = task->pid;
+		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
+		__entry->group_dead = group_dead;
+	),
+
+	TP_printk("pid=%d comm=%s group_dead=%s",
+		__entry->pid, __entry->comm,
+		__entry->group_dead ? "true" : "false"
+	)
+);
+
 /**
  * task_prctl_unknown - called on unknown prctl() option
  * @option:	option passed
diff --git a/kernel/exit.c b/kernel/exit.c
index c2e6c7b7779f..8496fc07f9c8 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -54,6 +54,7 @@
 #include <linux/init_task.h>
 #include <linux/perf_event.h>
 #include <trace/events/sched.h>
+#include <trace/events/task.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/oom.h>
 #include <linux/writeback.h>
@@ -937,6 +938,7 @@ void __noreturn do_exit(long code)
 
 	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
+	trace_task_exit(tsk, group_dead);
 
 	exit_mm();
 
-- 
2.47.1


