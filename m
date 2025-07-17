Return-Path: <bpf+bounces-63504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B1CB081AB
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B928A7AFAD8
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 00:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4C719DFA2;
	Thu, 17 Jul 2025 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoBEal7P"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A36A2E41E;
	Thu, 17 Jul 2025 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752713377; cv=none; b=IRIz2ZVjGiZoEuouZCyZRmtQOIUqzAKgwFyIKpEdwFTDzMWzpmarBZ8uYiuDrHAigHMnF++W0M7L34OmzSeAnogm94i5TbkYyf1FAIYJhD/nWGkmqFZv3ctpGRlFFVRBtDqECjIIvyha2CpFEqfvBdBJGr0bEsrgelKMwRuEFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752713377; c=relaxed/simple;
	bh=AsuH+OSCVigLV9/UIpq3dLzZDvEtDiONtBr0EP45lwk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pYgU6Ae44VgczKAWj9qe4ZbE7eh6Hc/nG3Pv3r6XFHfhgZH7cTsMGWpOzEpC08SUE13PPAbFNI7IWoL5W9hMSeErb/Oa4JBL6ekN5xqtULI/CRF+LjWDCdRtDPbMlDQDVQlqy5YS+vLc6T+Y7nqOl5YWn2FtMJ4kbPrHldhQaSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoBEal7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8CDC4CEF4;
	Thu, 17 Jul 2025 00:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752713376;
	bh=AsuH+OSCVigLV9/UIpq3dLzZDvEtDiONtBr0EP45lwk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=BoBEal7P+6gJwByYY9HgJ7FoJE8t3x5TXjXPTStKpzl2GZPbFrUn/xlNSMB+AFpSs
	 twc47k8+KYFmSU9JVsetS9cPQ22G6otxapgcKCH7CyxP/3q7fqwy1n3h0OOYcyGBA6
	 idfwldrd6+4CBrc3lw4KUa/QILeXM8F7bcP3SFs6dAu55LssbiWyMP7n0r8a5DJ+6h
	 dI/Os9Y+HpEF9tI6XHlrfGDVOPcE57269IttGD2fPPuck9AaRLkx2gxb8sz8FmWeqf
	 ylPy1TyZZsYcwRH/ps9kuLvfWttmY1aSPwZlxIkZA+u8sGtOwUrwysHoxkK09Zv+ev
	 JdYpBQEV7wUKg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucCou-000000067S0-31wy;
	Wed, 16 Jul 2025 20:49:56 -0400
Message-ID: <20250717004956.575727809@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 16 Jul 2025 20:49:11 -0400
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
Subject: [PATCH v14 01/12] unwind_user: Add user space unwinding API with frame pointer support
References: <20250717004910.297898999@kernel.org>
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

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Co-developed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/all/20250710164301.3094-2-mathieu.desnoyers@efficios.com/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v13: https://lore.kernel.org/20250708012357.982692711@kernel.org

- Folded patch 1 ("unwind_user: Add user space unwinding API) into patch 2
  ("unwind_user: Add frame pointer support") as there was no real reason
  to separate the two.

  v13 of patch 1: https://lore.kernel.org/all/20250708012357.814042587@kernel.org/

- Only check alignment of cfa instead of cfa + frame->ra_off, that way
  both ra_off and fp_off should also be aligned.

- Incorporated some of Mathieu's changes (see Link below his name)

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
index 000000000000..85b8c764d2f7
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
+static struct unwind_user_frame fp_frame = {
+	ARCH_INIT_USER_FP_FRAME
+};
+
+#define for_each_user_frame(state) \
+	for (unwind_user_start(state); !(state)->done; unwind_user_next(state))
+
+static int unwind_user_next_fp(struct unwind_user_state *state)
+{
+	struct unwind_user_frame *frame = &fp_frame;
+	unsigned long cfa, fp, ra = 0;
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



