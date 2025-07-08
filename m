Return-Path: <bpf+bounces-62586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F8CAFBFD4
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 03:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559B14A2357
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17132040AB;
	Tue,  8 Jul 2025 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNxErGid"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688DA1E2838;
	Tue,  8 Jul 2025 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937838; cv=none; b=Vl+qTiUEp4z2oBdltZ/OeuOGqO+cyc91qxy8OaPumf3yCGtyJ6tM53JP5KlwEgCegHHkI5y3wwUgVBY8s6lR8fAtyFjGrxf7xzzslnGXvZR8DE6J+7F76zkM09rGePDbaQ4I5o0suzSDJ6HQbQiHsWPkyzmsUNm0Lao3FwSWm0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937838; c=relaxed/simple;
	bh=Jou/EsDJ2wcQGX4ZAo7Tpn6oE93Ilh584sRGb96jknA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VoxKmzNxqx6KLbTWWxs2zfazOXJriDrs01iKDK9xYETMfZuy2WwnO52y5Xt816hwa4YzdrvyzDAtT+WBMSOx4RL7toKfgD2Je/Az47z5b8gqBobWZJapuV2PQ7+qWtteWUHcN81VJ1BCn70dNvV9kOj/nbqPtLFxP7r8obNV+9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNxErGid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E2BC4CEF5;
	Tue,  8 Jul 2025 01:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751937837;
	bh=Jou/EsDJ2wcQGX4ZAo7Tpn6oE93Ilh584sRGb96jknA=;
	h=Date:From:To:Cc:Subject:References:From;
	b=iNxErGidMD470AqiPxX9E0nD+uKeLnfxsnD2tKVt3INeXATSVWkQPxK0LwF8+usdb
	 rFi+Xee1lmfqe0mY7toTQXuzbH3eFjd12e3HCZNsj7ZgdebxXzLdGKbeudbyLsnJhf
	 0I4e3zWPhUJ0dK143k8MVSDs7c4Qs+flWH9iZUDKkL2RhZWFmj6F8COsLvRQXGRly7
	 8Efmk8YwpqF0O3WI4kK1JtwkDUBLxZ1g23j0+862COscw1KaNxzVbjp0Iil+G5ZMwT
	 GRHeSqsS54vVQJEtIBUEfEFZyUZcrDBK93R08vsQSc0LjtCCFukolVaNJkwlbozuwF
	 NptugoP1UDRSQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYx3t-00000000BpW-42Av;
	Mon, 07 Jul 2025 21:23:57 -0400
Message-ID: <20250708012357.814042587@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 21:22:40 -0400
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
Subject: [PATCH v13 01/14] unwind_user: Add user space unwinding API
References: <20250708012239.268642741@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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
Changes since v12: https://lore.kernel.org/20250701005450.721228270@goodmis.org

- Make unwind_user_start() and unwind_user_next() static. There's no
  reason that they need to be used by other files.

- Move for_each_user_frame() macro into user.c

- Remove extra parenthesis around start in for_each_user_frame() macro
  (Mathieu Desnoyers)

 MAINTAINERS                       |  8 +++++
 arch/Kconfig                      |  3 ++
 include/linux/unwind_user.h       |  9 +++++
 include/linux/unwind_user_types.h | 31 +++++++++++++++++
 kernel/Makefile                   |  1 +
 kernel/unwind/Makefile            |  1 +
 kernel/unwind/user.c              | 58 +++++++++++++++++++++++++++++++
 7 files changed, 111 insertions(+)
 create mode 100644 include/linux/unwind_user.h
 create mode 100644 include/linux/unwind_user_types.h
 create mode 100644 kernel/unwind/Makefile
 create mode 100644 kernel/unwind/user.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fad6cb025a19..370d780fd5f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25928,6 +25928,14 @@ F:	Documentation/driver-api/uio-howto.rst
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
index 000000000000..1d77bed8de2c
--- /dev/null
+++ b/include/linux/unwind_user.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_H
+#define _LINUX_UNWIND_USER_H
+
+#include <linux/unwind_user_types.h>
+
+int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
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
index 000000000000..d0cf3ee2706d
--- /dev/null
+++ b/kernel/unwind/user.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+* Generic interfaces for unwinding user space
+*/
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/unwind_user.h>
+
+#define for_each_user_frame(state) \
+	for (unwind_user_start(state); !(state)->done; unwind_user_next(state))
+
+static int unwind_user_next(struct unwind_user_state *state)
+{
+	/* no implementation yet */
+	return -EINVAL;
+}
+
+static int unwind_user_start(struct unwind_user_state *state)
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



