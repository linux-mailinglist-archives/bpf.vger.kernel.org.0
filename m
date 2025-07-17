Return-Path: <bpf+bounces-63513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D7EB081DC
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B501AA6A17
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 00:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B678C1E2614;
	Thu, 17 Jul 2025 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToV6T7CH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181391C863B;
	Thu, 17 Jul 2025 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752713378; cv=none; b=qGx+4sHnWw5/BkZYKB8iITZehJTJgcoPh0E0vAtg/ADpQ9qV5RXF3DJuIPeVFh5cD6dPpj+3aNMYFk/YpBYGPRy7cDQHOJ4FzO1P9qi1L42VjmX8i6U6pQZf60dxB4j+9sylAC9sj3R4OtKgB6GHuSYxlIjok6Mg2IAdxrAaw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752713378; c=relaxed/simple;
	bh=obS18RSAQSyZJe5k/e/Smr0PkWg/1HWjU7eiVMPKseY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Eifu9sGInlG3zwETII/gkFVRDIQqQLf0dm7WQgXPY/TA3sKROLEcPTg/Fv8jR3DmGYokRsN3H3KeJFtPhiEXm+HnqNjF0AL/LQa8VxCmXBhJc1b6ssq/EEHdXWmQj8SLp4ye6D0QjPHq/kPBNHD00V8l83jgEk51pbuVmU/dh78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToV6T7CH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E969BC116C6;
	Thu, 17 Jul 2025 00:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752713378;
	bh=obS18RSAQSyZJe5k/e/Smr0PkWg/1HWjU7eiVMPKseY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ToV6T7CHqkVmcbmg3HyKC9IBkf8b8R10cQoiLELsiQ1CoFxMwEeDj4HvVR0/F22+m
	 RcCSwx0pXBfeVEPvciPC0ssZA7th1IqjBXxOpenhxaKGXd2EnSN2wdiotoxmCL8jA1
	 wNOUKBXXpHGwsdJDorzz2aVzcJIvk08t0+ATgIt3gafsmbheNz26imk/Tj1GseDyDF
	 r++55od+WK6D9zBy3hwA5dS53/cszuyOZWwQ31Mkh9lxn0zCt7ydGZasYP+I6/agOo
	 c8URWvUPETV7C54AqaBDPgSCU5mr1vSCSboy0dzYxwuRJCAHJij6eGUULfwHTVusVA
	 davyqjKR5Fdpw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucCow-000000067WS-10m6;
	Wed, 16 Jul 2025 20:49:58 -0400
Message-ID: <20250717004958.090095968@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 16 Jul 2025 20:49:20 -0400
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
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v14 10/12] unwind: Finish up unwind when a task exits
References: <20250717004910.297898999@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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
index 2efbda01e959..26122d00708a 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -39,6 +39,8 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
 int unwind_deferred_request(struct unwind_work *work, u64 *cookie);
 void unwind_deferred_cancel(struct unwind_work *work);
 
+void unwind_deferred_task_exit(struct task_struct *task);
+
 static __always_inline void unwind_reset_info(void)
 {
 	struct unwind_task_info *info = &current->unwind_info;
@@ -71,6 +73,7 @@ static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback
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
index 353f7af610bf..53a75f8f9b7e 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -114,7 +114,7 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
 	/* Should always be called from faultable context */
 	might_fault();
 
-	if (current->flags & PF_EXITING)
+	if (!current->mm)
 		return -EINVAL;
 
 	if (!info->cache) {
@@ -147,9 +147,9 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
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
@@ -186,6 +186,23 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	}
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
  * unwind_deferred_request - Request a user stacktrace on task kernel exit
  * @work: Unwind descriptor requesting the trace
-- 
2.47.2



