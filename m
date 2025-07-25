Return-Path: <bpf+bounces-64399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF327B12479
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 20:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBDF7AE06C3
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 18:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4E025A2A2;
	Fri, 25 Jul 2025 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHyjmwds"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F8155C97;
	Fri, 25 Jul 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469854; cv=none; b=BbcrgZvpnzVnIyWQWGfwk7kyji60Usi9KZ1o8eIi7OTxNC50KuITmzJNDLycG08apjfkBc5Nq5VZDFRu/q3CpZZTqkkJIrWsLeop8WLhGNtUWz+JcdVxivxt6DwPbp1q2y3dwmV1Ny6DI7+v++ixwrLXvDFC4M9/vaKz89pcyGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469854; c=relaxed/simple;
	bh=D6WzydJYTzpIkcTqf6Eb08Cdq6+JZu7JrzcdUkXXQ6w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=avaUoG3TEIoXLC8bQaNwfZJ783z8M8R4Ryfc10QzyhlLqri1GocqDXfELX61frkbvpxas04MShWiyLuUo8QCaniyHVpjOirAWQpVKycb6JpZLQf/Z6DgTSTWi/b3x1MR0Sa3yb/imO36NtWFCPYw5VoZ7sMcNVqIld0/uI97Efg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHyjmwds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B041C4CEFA;
	Fri, 25 Jul 2025 18:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753469853;
	bh=D6WzydJYTzpIkcTqf6Eb08Cdq6+JZu7JrzcdUkXXQ6w=;
	h=Date:From:To:Cc:Subject:References:From;
	b=QHyjmwdsc5PQouUrn1cN6CqEVKnd8hwCpBRcvcoXcKRd3sYUT0T0OkxmucI73sNJP
	 qFY0jipgokP+qx2Gxx3OhrVlc2fJGYyFZoi8db7CQ4rtlHlRlQfo4Bz7uSBsAutLGl
	 qEGNsITHc1lkg8LsumO12/yfr+2loyQQY/+y+KNxSkNLgz2RlEBrWgEaNeCZRGFyVB
	 UeFqIFCtcH0VzR/1jk2W67UhSJSseYdJcdRJmbRW1DS5GXviQ8oxcW0GEndCIijZtE
	 Vzd1zZIX/fL4EzG2s0YL7ddEXyH+JU7tH1vhKtffUum8AsRlg23aHR7TFUUzu9hhJU
	 Q0kbez3eGi/9Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufNbv-00000001N40-2JNF;
	Fri, 25 Jul 2025 14:57:39 -0400
Message-ID: <20250725185739.399622407@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 14:55:14 -0400
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
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v15 02/10] unwind_user/deferred: Add unwind_user_faultable()
References: <20250725185512.673587297@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add a new API to retrieve a user space callstack called
unwind_user_faultable(). The difference between this user space stack
tracer from the current user space stack tracer is that this must be
called from faultable context as it may use routines to access user space
data that needs to be faulted in.

It can be safely called from entering or exiting a system call as the code
can still be faulted in there.

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
index 000000000000..a5f6e8f8a1a2
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
+int unwind_user_faultable(struct unwind_stacktrace *trace);
+
+#else /* !CONFIG_UNWIND_USER */
+
+static inline void unwind_task_init(struct task_struct *task) {}
+static inline void unwind_task_free(struct task_struct *task) {}
+
+static inline int unwind_user_faultable(struct unwind_stacktrace *trace) { return -ENOSYS; }
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
index 349ce3677526..eae37bea54fd 100644
--- a/kernel/unwind/Makefile
+++ b/kernel/unwind/Makefile
@@ -1 +1 @@
- obj-$(CONFIG_UNWIND_USER) += user.o
+ obj-$(CONFIG_UNWIND_USER)	+= user.o deferred.o
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
new file mode 100644
index 000000000000..a0badbeb3cc1
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
+ * unwind_user_faultable - Produce a user stacktrace in faultable context
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
+int unwind_user_faultable(struct unwind_stacktrace *trace)
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



