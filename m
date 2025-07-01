Return-Path: <bpf+bounces-61916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9642AEEB71
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F071BC2E5C
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 00:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A6C1E9B1C;
	Tue,  1 Jul 2025 00:54:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869BE1CF7AF;
	Tue,  1 Jul 2025 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331267; cv=none; b=JeZILb/8RHyZmPkGSoY/1J8ZNr4VClGX5jEoX7GOrVNcjesnAA9WWXiLyDVxC0Uy/HPWhxiizGqnArl9esPbqEQ42OMnNPNBAz6gCZKfThUIWoQv0TRrUahpbx5RhmND7N2HBJoBguA/u1FyrMOn3PMm70Bc84pWmIz91yp3lg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331267; c=relaxed/simple;
	bh=QGBLnIi+j9zMG5Lbvu2woOu0wvn5YNbJ7OJKCcW7VMA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=so7qN0ONo/L9kqT0K4vvCd7mPkVJwpv60Inaj2Kivdp61rizont5qFFSxiYoUVOmlc8hUOfFCABpawn1ZZHH5ZPTCEfYTEWU5J6U29nrpfXPV0BdjwAcEHB/UztN868fQyo5+K5B1g7/FnH74oxbwjXGmI1rLiu/HpMS6IzoC9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 82D9356AE0;
	Tue,  1 Jul 2025 00:54:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 25D2120025;
	Tue,  1 Jul 2025 00:54:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWPGs-00000007Nek-3dM6;
	Mon, 30 Jun 2025 20:54:50 -0400
Message-ID: <20250701005450.721228270@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 30 Jun 2025 20:53:22 -0400
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
Subject: [PATCH v12 01/14] unwind_user: Add user space unwinding API
References: <20250701005321.942306427@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: w6ko9nhacixri3o94xuxaw78t4qr5hrd
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 25D2120025
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/jVWKF89UtBzqrdFvjGjru1Ie3KlXETcg=
X-HE-Tag: 1751331254-699482
X-HE-Meta: U2FsdGVkX18Z6kXyOqNf7JqlOMT1T3O3UEjxLPO+s6iw97i0tZNLv3/zjJ4w+Yk29Ft+UogZ7fXd18Q+yJZgkYOf/XIQy6ZK2NiwdyoKtSS3ExH1jgebgAyh9ycxmix0vWnkWKi4AZEQ4jApOOoFzQIWOUj5j29hK19woIhYQ0JDeWF+3sXgj8FyvKQyb8fK+ZGikdgKLU2q+lzvqXTq2dRUdefglU5fafGnv9aPAICNXDajq9SJf1OaUrF8n+t+tzAwiL2FA9r0jdDyCq7KAP2T93cluU253Ov8I1D50e5vdcOgn63E5GYR2gfhVre9qkzltnhZaV+UffOJFzzRfCOYfDD8d1rD+ASfbreRxy50Czy9Fj72n2UnUca1xn+ijkchJ6vg+zgAjyWiTpZQEQOrEIexoqG1y7x3sXBRAaLgGt/zTT7jTfHir5IbaJc2Ee4oU0UVuNo=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Introduce a generic API for unwinding user stacks.

In order to expand user space unwinding to be able to handle more complex
scenarios, such as deferred unwinding and reading user space information,
create a generic interface that all architectures can use that support the
various unwinding methods.

This is an alternative method for handling user space stack traces from
the simple stack_trace_save_user() API. This does not replace that
interface, but this interface will be used to expand the functionality of
user space stack walking.

None of the structures introduced will be exposed to user space tooling.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS                       |  8 +++++
 arch/Kconfig                      |  3 ++
 include/linux/unwind_user.h       | 15 +++++++++
 include/linux/unwind_user_types.h | 31 +++++++++++++++++
 kernel/Makefile                   |  1 +
 kernel/unwind/Makefile            |  1 +
 kernel/unwind/user.c              | 55 +++++++++++++++++++++++++++++++
 7 files changed, 114 insertions(+)
 create mode 100644 include/linux/unwind_user.h
 create mode 100644 include/linux/unwind_user_types.h
 create mode 100644 kernel/unwind/Makefile
 create mode 100644 kernel/unwind/user.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4bac4ea21b64..ed5705c4f7d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25924,6 +25924,14 @@ F:	Documentation/driver-api/uio-howto.rst
 F:	drivers/uio/
 F:	include/linux/uio_driver.h
 
+USERSPACE STACK UNWINDING
+M:	Josh Poimboeuf <jpoimboe@kernel.org>
+M:	Steven Rostedt <rostedt@goodmis.org>
+S:	Maintained
+F:	include/linux/unwind*.h
+F:	kernel/unwind/
+
+
 UTIL-LINUX PACKAGE
 M:	Karel Zak <kzak@redhat.com>
 L:	util-linux@vger.kernel.org
diff --git a/arch/Kconfig b/arch/Kconfig
index a3308a220f86..ea59e5d7cc69 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -435,6 +435,9 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	  It uses the same command line parameters, and sysctl interface,
 	  as the generic hardlockup detectors.
 
+config UNWIND_USER
+	bool
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
new file mode 100644
index 000000000000..aa7923c1384f
--- /dev/null
+++ b/include/linux/unwind_user.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_H
+#define _LINUX_UNWIND_USER_H
+
+#include <linux/unwind_user_types.h>
+
+int unwind_user_start(struct unwind_user_state *state);
+int unwind_user_next(struct unwind_user_state *state);
+
+int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
+
+#define for_each_user_frame(state) \
+	for (unwind_user_start((state)); !(state)->done; unwind_user_next((state)))
+
+#endif /* _LINUX_UNWIND_USER_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
new file mode 100644
index 000000000000..6ed1b4ae74e1
--- /dev/null
+++ b/include/linux/unwind_user_types.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_TYPES_H
+#define _LINUX_UNWIND_USER_TYPES_H
+
+#include <linux/types.h>
+
+enum unwind_user_type {
+	UNWIND_USER_TYPE_NONE,
+};
+
+struct unwind_stacktrace {
+	unsigned int	nr;
+	unsigned long	*entries;
+};
+
+struct unwind_user_frame {
+	s32 cfa_off;
+	s32 ra_off;
+	s32 fp_off;
+	bool use_fp;
+};
+
+struct unwind_user_state {
+	unsigned long ip;
+	unsigned long sp;
+	unsigned long fp;
+	enum unwind_user_type type;
+	bool done;
+};
+
+#endif /* _LINUX_UNWIND_USER_TYPES_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 32e80dd626af..541186050251 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -55,6 +55,7 @@ obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
+obj-y += unwind/
 obj-$(CONFIG_MODULES) += module/
 
 obj-$(CONFIG_KCMP) += kcmp.o
diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
new file mode 100644
index 000000000000..349ce3677526
--- /dev/null
+++ b/kernel/unwind/Makefile
@@ -0,0 +1 @@
+ obj-$(CONFIG_UNWIND_USER) += user.o
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
new file mode 100644
index 000000000000..d30449328981
--- /dev/null
+++ b/kernel/unwind/user.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+* Generic interfaces for unwinding user space
+*/
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/unwind_user.h>
+
+int unwind_user_next(struct unwind_user_state *state)
+{
+	/* no implementation yet */
+	return -EINVAL;
+}
+
+int unwind_user_start(struct unwind_user_state *state)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+
+	memset(state, 0, sizeof(*state));
+
+	if ((current->flags & PF_KTHREAD) || !user_mode(regs)) {
+		state->done = true;
+		return -EINVAL;
+	}
+
+	state->type = UNWIND_USER_TYPE_NONE;
+
+	state->ip = instruction_pointer(regs);
+	state->sp = user_stack_pointer(regs);
+	state->fp = frame_pointer(regs);
+
+	return 0;
+}
+
+int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries)
+{
+	struct unwind_user_state state;
+
+	trace->nr = 0;
+
+	if (!max_entries)
+		return -EINVAL;
+
+	if (current->flags & PF_KTHREAD)
+		return 0;
+
+	for_each_user_frame(&state) {
+		trace->entries[trace->nr++] = state.ip;
+		if (trace->nr >= max_entries)
+			break;
+	}
+
+	return 0;
+}
-- 
2.47.2



