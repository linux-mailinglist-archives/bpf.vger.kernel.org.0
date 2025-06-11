Return-Path: <bpf+bounces-60264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86899AD479D
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D14189E0E2
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22BD286A9;
	Wed, 11 Jun 2025 01:03:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B504C80;
	Wed, 11 Jun 2025 01:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603784; cv=none; b=m8cJED9fTt157O+dlvtvqCoBco8HTL45rYJ+PI6USuOu7sJzqTyrV2LCTIAdX6AY5shVX9uHdlPG17uOj1uKnTra/5WXkpx2AwD1TydP4YDT8lgpwjK3FKd/cGCPNuaarpjOoJTSrj3ff2vFd/m6VcNTFkPvYyqD8HR2m/yH8uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603784; c=relaxed/simple;
	bh=GkcfV+ZHCvd7P4aVWtjysL4L/glnQ1G8j6U3jNYg0yk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=teTpZwKjde7NNQWgCDW1JxX3jcTPRvTFSGEMEj6o1piyBZxLKEqL179XoxvcWP0OCT3qXzOGnNXRpW9ZTK/OSdwtz+aLmUjlRle/sPMo3t7wg6MVOyOXUKoHkNqI3iTQmqunziGdxkxXrbEMkoFXTB/zMBHQMRbrzI6sAKWBsaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id A09F781473;
	Wed, 11 Jun 2025 01:02:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 8A39120010;
	Wed, 11 Jun 2025 01:02:56 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uP9tE-00000000v9F-2Rhg;
	Tue, 10 Jun 2025 21:04:28 -0400
Message-ID: <20250611010428.433111891@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 20:54:25 -0400
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
Subject: [PATCH v10 04/14] unwind_user/deferred: Add unwind_deferred_trace()
References: <20250611005421.144238328@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 8A39120010
X-Stat-Signature: d1sd67rsay336rropajpju8x4iyaw1jq
X-Rspamd-Server: rspamout06
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18s4Fht9zOCaOpUtgl/qgh+t7hS1DhCsZM=
X-HE-Tag: 1749603776-184028
X-HE-Meta: U2FsdGVkX182XWrvivxISvy8k+rDzRpftjL+HLhibTBHBTuVTxbNndIytvyPK49g3IjrkC7X9QdetfNDCbDqC1GE3a2Octol2BvVX8AcvMiApR2UqKfAfbDNk4ihWxtK6KFIopQOjOL2xZXdPyIU1fciZuxhbiswW4mB5Vfcr0LiU/+wBz9M7ACHrH9wq6TUlOR/NsK7kegh+qKn4wYYjLiQFIZ5NGYOG7uX7xCFsSsP5o1MdzRN1XQPgH+a59BGEHYasXHhjWdeoD1rlug5JaQF5qQIWZAEbi2BQkWzHUWFmUcka5y0VdEbWQNsHVI11fm9GAbx0t2Ebfq8V1K4kq2Sz7b+PIJgtobZgEOCoPgM6oTs/omxFpqtiEGt3U8Jwsh2tDBUWezOZ6zN0FiI9WnAtWvnhF8WtnnTiqoGkmI=

From: Steven Rostedt <rostedt@goodmis.org>

Add a function that must be called inside a faultable context that will
retrieve a user space stack trace. The function unwind_deferred_trace()
can be called by a tracer when a task is about to enter user space, or has
just come back from user space and has interrupts enabled.

This code is based on work by Josh Poimboeuf's deferred unwinding code:

Link: https://lore.kernel.org/all/6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
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
index 4f78a64beb52..59fdf7d9bb1e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -46,6 +46,7 @@
 #include <linux/rv.h>
 #include <linux/uidgid_types.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/unwind_deferred_types.h>
 #include <asm/kmap_size.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
@@ -1654,6 +1655,10 @@ struct task_struct {
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
index 1ee8eb11f38b..3341d50c61f2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -105,6 +105,7 @@
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
 #include <linux/tick.h>
+#include <linux/unwind_deferred.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -732,6 +733,7 @@ void __put_task_struct(struct task_struct *tsk)
 	WARN_ON(refcount_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+	unwind_task_free(tsk);
 	sched_ext_free(tsk);
 	io_uring_free(tsk);
 	cgroup_free(tsk);
@@ -2135,6 +2137,8 @@ __latent_entropy struct task_struct *copy_process(
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



