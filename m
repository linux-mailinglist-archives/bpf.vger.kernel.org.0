Return-Path: <bpf+bounces-60275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E85FAD47B0
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811353A8E79
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268FC1A8F60;
	Wed, 11 Jun 2025 01:03:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7731A18EFD1;
	Wed, 11 Jun 2025 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603790; cv=none; b=EJDHqqqWgI0XCYspXiSvTH9R+Fj/m43mwhrgurlaHFfzgsxwzwoqVN9Lpj9U9amgJ9orjqzRkAfGPuDEKbO0wAwXeLvu9lRa4E2ZxD+I1hx5tZMKGNPR3cF2U2d8T9h85eRQwMeFzZJlx5VQv4xzUqoUDtTtXs2jTWZk2Ie7l7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603790; c=relaxed/simple;
	bh=JMGALe8NBV0afyaihQpFztZ463RRAe1+FbMrIliyHKI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=TEqquum8ZKj9v++ugaeubMMsv1Fb39ZbJNjUQVJU/7/mflTcTsi7vPsyeRk8gye8e85virlNRvHwkiNUg80fT3CPbef72Z17juw6sl6qfKCwMHqYD+apy6FZaYckaa3K7ascu/nYEJ6vu5uiUa0fI27570A730UdPTA6NGQPSIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id AF36B141480;
	Wed, 11 Jun 2025 01:03:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 9AD2120018;
	Wed, 11 Jun 2025 01:02:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uP9tF-00000000vCd-3CtF;
	Tue, 10 Jun 2025 21:04:29 -0400
Message-ID: <20250611010429.615420889@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 20:54:32 -0400
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
Subject: [PATCH v10 11/14] unwind: Finish up unwind when a task exits
References: <20250611005421.144238328@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 9AD2120018
X-Rspamd-Server: rspamout08
X-Stat-Signature: pefpzyuk7dkqaumf8tbxifgjnf9e4q3e
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+F6qH0ZBVkCT2MTqVaXgAI/nfOofUpnuc=
X-HE-Tag: 1749603777-237719
X-HE-Meta: U2FsdGVkX1/V3hKepsGXv1c8Lr4ogUhjysQDKh0bK2168/tgUsLTi4phS9f/YF6+6uAK5yB7GFnHUgV9gZjJuGZyAnU1xWyGsYf4Xjk0q3iikjcHFZsB21KdLLTXWJ9/CpE71r5aZU5JMaUCTog6a2dHX6LkpLpKifzOqNDihfAJLjziH/t+XP1B8ABJgykYLnJ+KqNnpJ07VuPNDsVSGyP57jD1Rj+0h6CDxyK41Wy5DBjALKS714nF8HqVmmlB/QeRJhCLZ9N1aJEWD+aKr7qN1hu0Q6zZLb0EWwpHaRUlM80elWqdz/gmgabPBVsKhJQPgK1WHrvb2JAv2dERYfOEP4g/G6WVx5JJ72JCXw1Sw1Dl2tjh3kjVtgVXyK5D7YYOaVmTunwZUhXRWwrM0jeyCbMqTAH3+9vjke55u6PMulMFTviQRzKW7N+NX8/t

From: Steven Rostedt <rostedt@goodmis.org>

On do_exit() when a task is exiting, if a unwind is requested and the
deferred user stacktrace is deferred via the task_work, the task_work
callback is called after exit_mm() is called in do_exit(). This means that
the user stack trace will not be retrieved and an empty stack is created.

Instead, add a function unwind_deferred_task_exit() and call it just
before exit_mm() so that the unwinder can call the requested callbacks
with the user space stack.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/unwind_deferred.h |  4 +++-
 kernel/exit.c                   |  2 ++
 kernel/unwind/deferred.c        | 23 ++++++++++++++++++++---
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 426e21457606..bf0cc0477b2e 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -35,6 +35,8 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
 int unwind_deferred_request(struct unwind_work *work, u64 *timestamp);
 void unwind_deferred_cancel(struct unwind_work *work);
 
+void unwind_deferred_task_exit(struct task_struct *task);
+
 static __always_inline void unwind_exit_to_user_mode(void)
 {
 	struct unwind_task_info *info = &current->unwind_info;
@@ -65,7 +67,7 @@ static inline int unwind_deferred_trace(struct unwind_stacktrace *trace) { retur
 static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func) { return -ENOSYS; }
 static inline int unwind_deferred_request(struct unwind_work *work, u64 *timestamp) { return -ENOSYS; }
 static inline void unwind_deferred_cancel(struct unwind_work *work) {}
-
+static inline void unwind_deferred_task_exit(struct task_struct *task) {}
 static inline void unwind_exit_to_user_mode(void) {}
 
 #endif /* !CONFIG_UNWIND_USER */
diff --git a/kernel/exit.c b/kernel/exit.c
index bd743900354c..6599f9518436 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -68,6 +68,7 @@
 #include <linux/rethook.h>
 #include <linux/sysfs.h>
 #include <linux/user_events.h>
+#include <linux/unwind_deferred.h>
 #include <linux/uaccess.h>
 #include <linux/pidfs.h>
 
@@ -938,6 +939,7 @@ void __noreturn do_exit(long code)
 
 	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
+	unwind_deferred_task_exit(tsk);
 	trace_sched_process_exit(tsk, group_dead);
 
 	exit_mm();
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 8a6caaae04d3..6c95f484568e 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -77,7 +77,7 @@ int unwind_deferred_trace(struct unwind_stacktrace *trace)
 	/* Should always be called from faultable context */
 	might_fault();
 
-	if (current->flags & PF_EXITING)
+	if (!current->mm)
 		return -EINVAL;
 
 	if (!info->cache) {
@@ -107,9 +107,9 @@ int unwind_deferred_trace(struct unwind_stacktrace *trace)
 	return 0;
 }
 
-static void unwind_deferred_task_work(struct callback_head *head)
+static void process_unwind_deferred(struct task_struct *task)
 {
-	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
+	struct unwind_task_info *info = &task->unwind_info;
 	struct unwind_stacktrace trace;
 	struct unwind_work *work;
 	unsigned long bits;
@@ -151,6 +151,23 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	srcu_read_unlock(&unwind_srcu, idx);
 }
 
+static void unwind_deferred_task_work(struct callback_head *head)
+{
+	process_unwind_deferred(current);
+}
+
+void unwind_deferred_task_exit(struct task_struct *task)
+{
+	struct unwind_task_info *info = &current->unwind_info;
+
+	if (!unwind_pending(info))
+		return;
+
+	process_unwind_deferred(task);
+
+	task_work_cancel(task, &info->work);
+}
+
 static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
 {
 	struct unwind_task_info *info = &current->unwind_info;
-- 
2.47.2



