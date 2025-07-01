Return-Path: <bpf+bounces-61914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 367AAAEEB6A
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824993BA0C5
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 00:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AEF1B0F0A;
	Tue,  1 Jul 2025 00:54:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4AC156C6A;
	Tue,  1 Jul 2025 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331264; cv=none; b=rBDaOoc+OAgXgllVoBKXgThKJG/wP92GRWUNR1IQf38ATNjtBqDRcHDqVN2qNu2uPlsjSskxju4cj8sRhbgELxbyb9fgUl58J5fL4xCRFEgAR0dZTtzIjcH0Taoq7b+s7D0yha6a1+Ty/t5JNd9sBhoNWB6/0eW86zuyHury9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331264; c=relaxed/simple;
	bh=vzxhBtsz4jECiJNxO1EaySWJmuQOxKUvlb4C8TsO7rI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=r/t2AsYGleVhUs/dMCMW1E2u+mXWNnArRGeMZ/ju5Y3R0Byaj58Jp9pGlK6t1silYIhq9OV40EqtaU8uj3zMdTUBeyYcG7B5yZ6maUeqL7oJLw0JOO4n5uz+O7YskPdDunommAlBXDLcRd2s0/Xryl8EkBRZsRYuqNt29+KRf+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 2A69C1A01FF;
	Tue,  1 Jul 2025 00:54:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id C90B76000C;
	Tue,  1 Jul 2025 00:54:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWPGu-00000007Nk8-34ga;
	Mon, 30 Jun 2025 20:54:52 -0400
Message-ID: <20250701005452.580618259@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 30 Jun 2025 20:53:33 -0400
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
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v12 12/14] unwind: Finish up unwind when a task exits
References: <20250701005321.942306427@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: g7quk9eypuzgxj6o8phhjy5wgs5r7owe
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: C90B76000C
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18dNkJgtlObVhp8/H7i59W/Nc1msCf8frM=
X-HE-Tag: 1751331255-439594
X-HE-Meta: U2FsdGVkX19M/O81DunncGh3Yhen+OgjoK0kZzh64szJs3NPP/FhYXqK9jSqc03JhEDC7GeMlPRInqqLsZduqJEUZPkLcg5Eh+1Ds3e+oqs/PfUL0ga328X//W1334feAbhImzmcFkMenC35FCD/57YpZSJae4q5DS+X6aTM/cxMefSoW40GzWXa6IkTiezQj+EH7ifObrtCHXsPIouBRqdjBZsKROVzF5qbU/2XzhJpKidDr0WOMN5Q8Jck0CZzGvkTTIF8oKXJo0PZxKn7C9Xf5iY7+nvaYld5m4DoC7kUPmRWcHixL+iDLmw7lfSxG7WZWYETtOwhghLD15ZnrW4VTUzFhSQiTfJq4WmQLjLslmiLLcfxQwNFnS+jtigAC/Q29Dhx5ELzXH9Y6VyDSWsSg49qEhgB/Y2wsPjUuNmBlrfuKVqS+NB186sRdRnb

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
 include/linux/unwind_deferred.h |  3 +++
 kernel/exit.c                   |  2 ++
 kernel/unwind/deferred.c        | 23 ++++++++++++++++++++---
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index a1c62097f142..44654e6149ec 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -39,6 +39,8 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
 int unwind_deferred_request(struct unwind_work *work, u64 *timestamp);
 void unwind_deferred_cancel(struct unwind_work *work);
 
+void unwind_deferred_task_exit(struct task_struct *task);
+
 static __always_inline void unwind_reset_info(void)
 {
 	struct unwind_task_info *info = &current->unwind_info;
@@ -69,6 +71,7 @@ static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback
 static inline int unwind_deferred_request(struct unwind_work *work, u64 *timestamp) { return -ENOSYS; }
 static inline void unwind_deferred_cancel(struct unwind_work *work) {}
 
+static inline void unwind_deferred_task_exit(struct task_struct *task) {}
 static inline void unwind_reset_info(void) {}
 
 #endif /* !CONFIG_UNWIND_USER */
diff --git a/kernel/exit.c b/kernel/exit.c
index bb184a67ac73..1d8c8ac33c4f 100644
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
 
 	/*
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 5ab9b9045ae5..9ec1e74c6469 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -104,7 +104,7 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
 	/* Should always be called from faultable context */
 	might_fault();
 
-	if (current->flags & PF_EXITING)
+	if (!current->mm)
 		return -EINVAL;
 
 	if (!info->cache) {
@@ -137,9 +137,9 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
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
@@ -174,6 +174,23 @@ static void unwind_deferred_task_work(struct callback_head *head)
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
 /**
  * unwind_deferred_request - Request a user stacktrace on task exit
  * @work: Unwind descriptor requesting the trace
-- 
2.47.2



