Return-Path: <bpf+bounces-64648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82580B152A3
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4464E77A7
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C7223D29F;
	Tue, 29 Jul 2025 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCgd0fai"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9C823817E;
	Tue, 29 Jul 2025 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813431; cv=none; b=OJ75+allL7FGhqbTFG6aJur5YeiVgPT8F8v2U567FK5hTRWyvtMrZUaMd4ia8mMzfHoMAylC4MqZVSaJa8e0IvARTvmOWS3IMLB+Fn/28vsoz9xS2fOv6yKU3RheymyRuRxgotlxi5W+d2HH+kDYP9A4ej0kFmoOBGoo8mMYQ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813431; c=relaxed/simple;
	bh=zwxbKH48sloOHgmdWM8djoKkpycyIxIwwDgrm6DCgmY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=b5Kibac3Iw6wD06U3A4pQrn6fWBa72d/HawwQ9C1ysf7TvBvYqF5d793ytEebRh5DwkXFeQV+/B8/FzB5QRaPGfgEBiO0CCTmRUhQzwRNXq3gIClPM0TZkASM+dO80LmfwBKs3pleTP9K2VDKB8pI5+lzMDASV0tWiGTIDHVvNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCgd0fai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492F1C4CEF7;
	Tue, 29 Jul 2025 18:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753813430;
	bh=zwxbKH48sloOHgmdWM8djoKkpycyIxIwwDgrm6DCgmY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=uCgd0faiXAavMKN8UxzkAAFfPma9pmL09kNBkC37FKPphB0qUBYqK9xuWlXs+pfa6
	 lrR7ml1LO6PSAHFYXofQUGS1OV38sY4iNuZ5W5oVmvUiEX/knEOsirdIjy4kHdPMQY
	 jIKOFhDGI0Y2hzuBGLiKJgVnA6mB4svjIjZmMHAqHI/UksTJoWFd0O+iFXq/tnsv2C
	 5uxWsSl37xrmJkdUTXDrdOITLp/q+4lm7oABogj5F0bD9K31keVRy4FcrpayOpk35g
	 r5IfaV+EnMQ02icQjAr4Lzdbpulm6ZVP0REwFpxA9LZPQGj4EPh16/yzh+FbHUU+44
	 MZ29uMTQfyXOA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugozd-000000054yS-0Wus;
	Tue, 29 Jul 2025 14:24:05 -0400
Message-ID: <20250729182404.975790139@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 29 Jul 2025 14:23:05 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
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
Subject: [PATCH v16 01/10] unwind_user: Add user space unwinding API with frame pointer support
References: <20250729182304.965835871@kernel.org>
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

Support for frame pointer unwinding is added. For an architecture to
support frame pointer unwinding it needs to enable
CONFIG_HAVE_UNWIND_USER_FP and define ARCH_INIT_USER_FP_FRAME.

By encoding the frame offsets in struct unwind_user_frame, much of this
code can also be reused for future unwinder implementations like sframe.

Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Co-developed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/all/20250710164301.3094-2-mathieu.desnoyers@efficios.com/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v15: https://lore.kernel.org/20250725185739.233988371@kernel.org

- Made fp_frame into a constant (Jens Remus)

- Removed useless initializing ra variable to zero (Jens Remus)

 MAINTAINERS                       |   8 ++
 arch/Kconfig                      |   7 ++
 include/asm-generic/Kbuild        |   1 +
 include/asm-generic/unwind_user.h |   5 ++
 include/linux/unwind_user.h       |  14 ++++
 include/linux/unwind_user_types.h |  44 ++++++++++
 kernel/Makefile                   |   1 +
 kernel/unwind/Makefile            |   1 +
 kernel/unwind/user.c              | 128 ++++++++++++++++++++++++++++++
 9 files changed, 209 insertions(+)
 create mode 100644 include/asm-generic/unwind_user.h
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
index a3308a220f86..8e3fd723bd74 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -435,6 +435,13 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	  It uses the same command line parameters, and sysctl interface,
 	  as the generic hardlockup detectors.
 
+config UNWIND_USER
+	bool
+
+config HAVE_UNWIND_USER_FP
+	bool
+	select UNWIND_USER
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 8675b7b4ad23..295c94a3ccc1 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -59,6 +59,7 @@ mandatory-y += tlbflush.h
 mandatory-y += topology.h
 mandatory-y += trace_clock.h
 mandatory-y += uaccess.h
+mandatory-y += unwind_user.h
 mandatory-y += vermagic.h
 mandatory-y += vga.h
 mandatory-y += video.h
diff --git a/include/asm-generic/unwind_user.h b/include/asm-generic/unwind_user.h
new file mode 100644
index 000000000000..b8882b909944
--- /dev/null
+++ b/include/asm-generic/unwind_user.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_UNWIND_USER_H
+#define _ASM_GENERIC_UNWIND_USER_H
+
+#endif /* _ASM_GENERIC_UNWIND_USER_H */
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
new file mode 100644
index 000000000000..7f7282516bf5
--- /dev/null
+++ b/include/linux/unwind_user.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_H
+#define _LINUX_UNWIND_USER_H
+
+#include <linux/unwind_user_types.h>
+#include <asm/unwind_user.h>
+
+#ifndef ARCH_INIT_USER_FP_FRAME
+ #define ARCH_INIT_USER_FP_FRAME
+#endif
+
+int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
+
+#endif /* _LINUX_UNWIND_USER_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
new file mode 100644
index 000000000000..a449f15be890
--- /dev/null
+++ b/include/linux/unwind_user_types.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_TYPES_H
+#define _LINUX_UNWIND_USER_TYPES_H
+
+#include <linux/types.h>
+
+/*
+ * Unwind types, listed in priority order: lower numbers are attempted first if
+ * available.
+ */
+enum unwind_user_type_bits {
+	UNWIND_USER_TYPE_FP_BIT =		0,
+
+	NR_UNWIND_USER_TYPE_BITS,
+};
+
+enum unwind_user_type {
+	/* Type "none" for the start of stack walk iteration. */
+	UNWIND_USER_TYPE_NONE =			0,
+	UNWIND_USER_TYPE_FP =			BIT(UNWIND_USER_TYPE_FP_BIT),
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
+	unsigned long				ip;
+	unsigned long				sp;
+	unsigned long				fp;
+	enum unwind_user_type			current_type;
+	unsigned int				available_types;
+	bool					done;
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
index 000000000000..97a8415e3216
--- /dev/null
+++ b/kernel/unwind/user.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+* Generic interfaces for unwinding user space
+*/
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/unwind_user.h>
+#include <linux/uaccess.h>
+
+static const struct unwind_user_frame fp_frame = {
+	ARCH_INIT_USER_FP_FRAME
+};
+
+#define for_each_user_frame(state) \
+	for (unwind_user_start(state); !(state)->done; unwind_user_next(state))
+
+static int unwind_user_next_fp(struct unwind_user_state *state)
+{
+	const struct unwind_user_frame *frame = &fp_frame;
+	unsigned long cfa, fp, ra;
+	unsigned int shift;
+
+	if (frame->use_fp) {
+		if (state->fp < state->sp)
+			return -EINVAL;
+		cfa = state->fp;
+	} else {
+		cfa = state->sp;
+	}
+
+	/* Get the Canonical Frame Address (CFA) */
+	cfa += frame->cfa_off;
+
+	/* stack going in wrong direction? */
+	if (cfa <= state->sp)
+		return -EINVAL;
+
+	/* Make sure that the address is word aligned */
+	shift = sizeof(long) == 4 ? 2 : 3;
+	if (cfa & ((1 << shift) - 1))
+		return -EINVAL;
+
+	/* Find the Return Address (RA) */
+	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
+		return -EINVAL;
+
+	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
+		return -EINVAL;
+
+	state->ip = ra;
+	state->sp = cfa;
+	if (frame->fp_off)
+		state->fp = fp;
+	return 0;
+}
+
+static int unwind_user_next(struct unwind_user_state *state)
+{
+	unsigned long iter_mask = state->available_types;
+	unsigned int bit;
+
+	if (state->done)
+		return -EINVAL;
+
+	for_each_set_bit(bit, &iter_mask, NR_UNWIND_USER_TYPE_BITS) {
+		enum unwind_user_type type = BIT(bit);
+
+		state->current_type = type;
+		switch (type) {
+		case UNWIND_USER_TYPE_FP:
+			if (!unwind_user_next_fp(state))
+				return 0;
+			continue;
+		default:
+			WARN_ONCE(1, "Undefined unwind bit %d", bit);
+			break;
+		}
+		break;
+	}
+
+	/* No successful unwind method. */
+	state->current_type = UNWIND_USER_TYPE_NONE;
+	state->done = true;
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
+	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
+		state->available_types |= UNWIND_USER_TYPE_FP;
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



