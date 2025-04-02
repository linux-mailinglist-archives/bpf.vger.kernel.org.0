Return-Path: <bpf+bounces-55175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D213DA794D6
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 20:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922923B117C
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 18:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1416019006B;
	Wed,  2 Apr 2025 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YG4y6sUt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915E19F461;
	Wed,  2 Apr 2025 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617369; cv=none; b=qIk6Iop0RBTIFAB88h8ox2yTozRcqb15qqeLr2SmnckuLASCOK8n3FsArP6QmnI3h7elqid5pwQFAGeYRY34PfQWAIZB7rZBT9iMjXm0cBOAHM++YnzSkEQiKu+DK+KP6s0ajwWwgsJwI4yme4VZtrCCiOYTFVxwn7WruwC16tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617369; c=relaxed/simple;
	bh=rNmMO+u09D5zPnq+/pg7RkMy9c5EPySrQWya/Jy4H60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kn8nSLod5pxA4rO4fy5OjzmNCfBLkDP4i45mOj9oN8ZwmQYOs5b6fiPxJEIDKGg09YL66OmesKbcmFiWvrgyABSo1Nojh9QUlTNBbKBPWNU6cE8FcwJ8QOG3Rq605lxq1Vk3wmvvLF/9cKfavxVN2PmefX/PvJK/fH27LNHU5uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YG4y6sUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9B0C4CEDD;
	Wed,  2 Apr 2025 18:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743617368;
	bh=rNmMO+u09D5zPnq+/pg7RkMy9c5EPySrQWya/Jy4H60=;
	h=From:To:Cc:Subject:Date:From;
	b=YG4y6sUtR4ioGK8k00znOECE6AwnW1jKHtU3d4Yo28ZvmRpHcn9dZNADVqHntSJri
	 UQeLbECJ0saH0Y62Xrx95BcgTHsGuvTAa0eFkV01Lq8wFZuMdumb8zU+aEHDU7NY0c
	 rN0lSmFlt8dLaZFaxhr0e3p1I+hqUI8d8COStuGRNgnb3JgbFKRYUuLuvOlbk7Dtl+
	 6GqUXKzIe22z7+gmSUNiXPl4m0Os7dohc3a705Wh4dq3cgE8kxR2+1PUQfpQCVbX6J
	 xLQ+EmuLzsBKEabhRgZ45b1ndmLr9D0vrauaE4U79ZSWbOzQtAT87TBJqiOd4me1C0
	 eiHXf7kQTTTZQ==
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
Subject: [PATCH v2] exit: move and extend sched_process_exit() tracepoint
Date: Wed,  2 Apr 2025 11:09:25 -0700
Message-ID: <20250402180925.90914-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is useful to be able to access current->mm at task exit to, say,
record a bunch of VMA information right before the task exits (e.g., for
stack symbolization reasons when dealing with short-lived processes that
exit in the middle of profiling session). Currently,
trace_sched_process_exit() is triggered after exit_mm() which resets
current->mm to NULL making this tracepoint unsuitable for inspecting
and recording task's mm_struct-related data when tracing process
lifetimes.

There is a particularly suitable place, though, right after
taskstats_exit() is called, but before we do exit_mm() and other
exit_*() resource teardowns. taskstats performs a similar kind of
accounting that some applications do with BPF, and so co-locating them
seems like a good fit. So that's where trace_sched_process_exit() is
moved with this patch.

Also, existing trace_sched_process_exit() tracepoint is notoriously
missing `group_dead` flag that is certainly useful in practice and some
of our production applications have to work around this. So plumb
`group_dead` through while at it, to have a richer and more complete
tracepoint.

Note that we can't use sched_process_template anymore, and so we use
TRACE_EVENT()-based tracepoint definition. But all the field names and
order, as well as assign and output logic remain intact. We just add one
extra field at the end in backwards-compatible way.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/trace/events/sched.h | 28 +++++++++++++++++++++++++---
 kernel/exit.c                |  2 +-
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 8994e97d86c1..05a14f2b35c3 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -328,9 +328,31 @@ DEFINE_EVENT(sched_process_template, sched_process_free,
 /*
  * Tracepoint for a task exiting:
  */
-DEFINE_EVENT(sched_process_template, sched_process_exit,
-	     TP_PROTO(struct task_struct *p),
-	     TP_ARGS(p));
+TRACE_EVENT(sched_process_exit,
+
+	TP_PROTO(struct task_struct *p, bool group_dead),
+
+	TP_ARGS(p, group_dead),
+
+	TP_STRUCT__entry(
+		__array(	char,	comm,	TASK_COMM_LEN	)
+		__field(	pid_t,	pid			)
+		__field(	int,	prio			)
+		__field(	bool,	group_dead		)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		__entry->pid		= p->pid;
+		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
+		__entry->group_dead	= group_dead;
+	),
+
+	TP_printk("comm=%s pid=%d prio=%d group_dead=%s",
+		  __entry->comm, __entry->pid, __entry->prio,
+		  __entry->group_dead ? "true" : "false"
+	)
+);
 
 /*
  * Tracepoint for waiting on task to unschedule:
diff --git a/kernel/exit.c b/kernel/exit.c
index c2e6c7b7779f..4abd307b1586 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -937,12 +937,12 @@ void __noreturn do_exit(long code)
 
 	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
+	trace_sched_process_exit(tsk, group_dead);
 
 	exit_mm();
 
 	if (group_dead)
 		acct_process();
-	trace_sched_process_exit(tsk);
 
 	exit_sem(tsk);
 	exit_shm(tsk);
-- 
2.47.1


