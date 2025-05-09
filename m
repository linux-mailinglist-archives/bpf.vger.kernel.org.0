Return-Path: <bpf+bounces-57879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA6AAB1AF0
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FD1A2473B
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 16:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B69923C8C9;
	Fri,  9 May 2025 16:51:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20D23A9BF;
	Fri,  9 May 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809499; cv=none; b=VSputoJJB/35f66qdQU/BXKtl7xj0JCM1fX9FZhU4kMtyC9u50EbVyQu/qGJTGh7taS4E7NwFJ9PZNO6uZ0wzthYIL7M1M9Iq1Ggx7syTueN8C+Fbcjf7hQm3BYpWKJWkbNtE46UGEd3EoPKkRJ3rEs27naXF4SgQygZ7z+E/0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809499; c=relaxed/simple;
	bh=oSppW/Xo92Q7JQgTgYM1Vhe4SN1cEBvoZwAoUT4fSZo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dE3NVg3yALOcy0YSzxff60HpbygWMGOOOnr+Jzc/lduU5XbQOkiHoLzr7tdij+o6xjSWuHE9nQLPF8V7DzrRD/uc9FUMaJ9PoupFs1XD0qVFc9a+Klq/OiXEAYSgFAPBwv6yUNi2C+u25YWJwBuRZ1mu+sL4JGmGjRyZFRoMAK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB18C4CEF4;
	Fri,  9 May 2025 16:51:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uDQx0-00000002gGg-3w4X;
	Fri, 09 May 2025 12:51:54 -0400
Message-ID: <20250509165154.789938318@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 09 May 2025 12:45:31 -0400
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
 Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v8 07/18] unwind_user/deferred: Add unwind_deferred_trace()
References: <20250509164524.448387100@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add a function that must be called inside a faultable context that will
retrieve a user space stack trace. The function unwind_deferred_trace()
can be called by a tracer when a task is about to enter user space, or has
just come back from user space and has interrupts enabled.

This code is based on work by Josh Poimboeuf's deferred unwinding code:

Link: https://lore.kernel.org/all/6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v7: https://lore.kernel.org/20250502165008.564172398@goodmis.org

- Fixed whitespace issues

- Added kerneldoc to unwind_deferred_trace()

 include/linux/sched.h                 |  5 +++
 include/linux/unwind_deferred.h       | 24 +++++++++++
 include/linux/unwind_deferred_types.h |  9 ++++
 kernel/fork.c                         |  4 ++
 kernel/unwind/Makefile                |  2 +-
 kernel/unwind/deferred.c              | 60 +++++++++++++++++++++++++++
 6 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/unwind_deferred.h
 create mode 100644 include/linux/unwind_deferred_types.h
 create mode 100644 kernel/unwind/deferred.c

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4ecc0c6b1cb0..a1e1c07cadfb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -47,6 +47,7 @@
 #include <linux/livepatch_sched.h>
 #include <linux/uidgid_types.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/unwind_deferred_types.h>
 #include <asm/kmap_size.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
@@ -1646,6 +1647,10 @@ struct task_struct {
 	struct user_event_mm		*user_event_mm;
 #endif
 
+#ifdef CONFIG_UNWIND_USER
+	struct unwind_task_info		unwind_info;
+#endif
+
 	/* CPU-specific state of this task: */
 	struct thread_struct		thread;
 
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
new file mode 100644
index 000000000000..5064ebe38c4f
--- /dev/null
+++ b/include/linux/unwind_deferred.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_DEFERRED_H
+#define _LINUX_UNWIND_USER_DEFERRED_H
+
+#include <linux/unwind_user.h>
+#include <linux/unwind_deferred_types.h>
+
+#ifdef CONFIG_UNWIND_USER
+
+void unwind_task_init(struct task_struct *task);
+void unwind_task_free(struct task_struct *task);
+
+int unwind_deferred_trace(struct unwind_stacktrace *trace);
+
+#else /* !CONFIG_UNWIND_USER */
+
+static inline void unwind_task_init(struct task_struct *task) {}
+static inline void unwind_task_free(struct task_struct *task) {}
+
+static inline int unwind_deferred_trace(struct unwind_stacktrace *trace) { return -ENOSYS; }
+
+#endif /* !CONFIG_UNWIND_USER */
+
+#endif /* _LINUX_UNWIND_USER_DEFERRED_H */
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
new file mode 100644
index 000000000000..aa32db574e43
--- /dev/null
+++ b/include/linux/unwind_deferred_types.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
+#define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
+
+struct unwind_task_info {
+	unsigned long		*entries;
+};
+
+#endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index c4b26cd8998b..8c79c7c2c553 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -105,6 +105,7 @@
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
 #include <linux/tick.h>
+#include <linux/unwind_deferred.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -991,6 +992,7 @@ void __put_task_struct(struct task_struct *tsk)
 	WARN_ON(refcount_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+	unwind_task_free(tsk);
 	sched_ext_free(tsk);
 	io_uring_free(tsk);
 	cgroup_free(tsk);
@@ -2395,6 +2397,8 @@ __latent_entropy struct task_struct *copy_process(
 	p->bpf_ctx = NULL;
 #endif
 
+	unwind_task_init(p);
+
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
 	if (retval)
diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
index 349ce3677526..6752ac96d7e2 100644
--- a/kernel/unwind/Makefile
+++ b/kernel/unwind/Makefile
@@ -1 +1 @@
- obj-$(CONFIG_UNWIND_USER) += user.o
+ obj-$(CONFIG_UNWIND_USER)		+= user.o deferred.o
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
new file mode 100644
index 000000000000..0bafb95e6336
--- /dev/null
+++ b/kernel/unwind/deferred.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Deferred user space unwinding
+ */
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/unwind_deferred.h>
+
+#define UNWIND_MAX_ENTRIES 512
+
+/**
+ * unwind_deferred_trace - Produce a user stacktrace in faultable context
+ * @trace: The descriptor that will store the user stacktrace
+ *
+ * This must be called in a known faultable context (usually when entering
+ * or exiting user space). Depending on the available implementations
+ * the @trace will be loaded with the addresses of the user space stacktrace
+ * if it can be found.
+ *
+ * Return: 0 on success and negative on error
+ *         On success @trace will contain the user space stacktrace
+ */
+int unwind_deferred_trace(struct unwind_stacktrace *trace)
+{
+	struct unwind_task_info *info = &current->unwind_info;
+
+	/* Should always be called from faultable context */
+	might_fault();
+
+	if (current->flags & PF_EXITING)
+		return -EINVAL;
+
+	if (!info->entries) {
+		info->entries = kmalloc_array(UNWIND_MAX_ENTRIES, sizeof(long),
+					      GFP_KERNEL);
+		if (!info->entries)
+			return -ENOMEM;
+	}
+
+	trace->nr = 0;
+	trace->entries = info->entries;
+	unwind_user(trace, UNWIND_MAX_ENTRIES);
+
+	return 0;
+}
+
+void unwind_task_init(struct task_struct *task)
+{
+	struct unwind_task_info *info = &task->unwind_info;
+
+	memset(info, 0, sizeof(*info));
+}
+
+void unwind_task_free(struct task_struct *task)
+{
+	struct unwind_task_info *info = &task->unwind_info;
+
+	kfree(info->entries);
+}
-- 
2.47.2



