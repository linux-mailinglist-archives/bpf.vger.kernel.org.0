Return-Path: <bpf+bounces-62597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 954CAAFBFE4
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 03:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DE11AA6886
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B971224AF2;
	Tue,  8 Jul 2025 01:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKfFHVeo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F7721D00A;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937839; cv=none; b=OQEEJC7EfQqNtUoJ4zyoJS0CE8rZ6+Lg6/MCCkPaf20kZbzTBY38MOTb2laovU+65hKljJC7dbqNkWUe/dVFiHz/PVzuTwC59n6A2/a2zV/RBufE/aqr1s9699mg1OiWwkW/um4Hb3G0zdooCGmLoSEFI0cveTh5/A+Ug/xsNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937839; c=relaxed/simple;
	bh=1woBRSwvr3+dsgRe82q4LxBYj4eV2D2BoGtGwhUkrU4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=D9QMQECSgMFe6DHfzs9LNuzJcVZDYQVZfikySfBB/rzO5sluQXiDLEMSb9orflCrxoaJprsPzmpCeqgItl7OufvWKCLf+C3vPBJHj3aprjAAFtbsVWmp+/Oh2wQPaEAsKooR638KrKaAlDrjAZ8CSH/1tG3HTozR40b0iqGr5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKfFHVeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B90C4CEE3;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751937839;
	bh=1woBRSwvr3+dsgRe82q4LxBYj4eV2D2BoGtGwhUkrU4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=AKfFHVeo+Y0gT7guMc4TDba4/IPgGPWmnsS+HWwrRcSRhRlNDn2tS5Mm3bWksHhqQ
	 VqE3Cx0KZrqR6F3pfG80GoGREcE2tyg13QTuUfrMgJOrGV3UWalNLs/CkQOqBPmwjj
	 HNmxBzAReWa9pn5ScJnuqyHzVCmoEgC7RvmxomiEz8gq8BCpitnYd//mBJNMTPRU2W
	 TSXQ8p2oCn9JxM9fkpo3bEQfnZnriXAYSbUaGMavU83FdiUQWef38Miaeiz0KVLq6x
	 zmDnBsEsMaJYIHHFNM2mhoxrHuvhf8n98ArpW+K4RCFpi0+Dduf1XciPGc5TmPai67
	 /ZQ95hBcwxx1w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYx3v-00000000Bux-3U2D;
	Mon, 07 Jul 2025 21:23:59 -0400
Message-ID: <20250708012359.685166151@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 21:22:51 -0400
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
Subject: [PATCH v13 12/14] unwind: Finish up unwind when a task exits
References: <20250708012239.268642741@kernel.org>
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
index 376bfd50ff75..a9d5b100d6b2 100644
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
index 9299974b6562..039e12700d49 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -113,7 +113,7 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
 	/* Should always be called from faultable context */
 	might_fault();
 
-	if (current->flags & PF_EXITING)
+	if (!current->mm)
 		return -EINVAL;
 
 	if (!info->cache) {
@@ -146,9 +146,9 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
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
@@ -183,6 +183,23 @@ static void unwind_deferred_task_work(struct callback_head *head)
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



