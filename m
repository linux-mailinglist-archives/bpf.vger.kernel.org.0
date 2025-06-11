Return-Path: <bpf+bounces-60274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D336AD47AE
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749F117D522
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1057A1A5BA4;
	Wed, 11 Jun 2025 01:03:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736818FDD5;
	Wed, 11 Jun 2025 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603790; cv=none; b=G81XsHm0TJaMpRHqFWQ0/VqF+80dDXxgyGEmUBU6V15YpqNrkodW6dg6W6KEny/3vwW+3eq51g1Odt6xEGPs3VtflcEfhHMz1ID9VIZ0IhE+mi5FzkPRyTImQqX3oLOTNwk20ZqVa7tA+wqabpOMg29uApt7Y5xVx1qfdRI9apU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603790; c=relaxed/simple;
	bh=FEdFYcHE9hiNNH0v0kJvOh5Nf4CYXvUN8o4+V7c20RE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=M0RVb8uS4F253K8sMDnAZUHNnSraAqBz5hotfNjPWD0gw+W91IfWl4v7d144bIBkm3jvrqUaICeq42ayW8vENImG+UKdBUUxoauTRNOvkutaSqpRxGGyme5GcJgqMV3aiJHnC0ssdWYsMEuvI/iSWPk0IfJadLP9oze9liKbT3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 8A61B1A14A1;
	Wed, 11 Jun 2025 01:02:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 6516A20016;
	Wed, 11 Jun 2025 01:02:56 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uP9tE-00000000v8l-1ioR;
	Tue, 10 Jun 2025 21:04:28 -0400
Message-ID: <20250611010428.261095906@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 20:54:24 -0400
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
Subject: [PATCH v10 03/14] unwind_user: Add compat mode frame pointer support
References: <20250611005421.144238328@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 6516A20016
X-Stat-Signature: qhubogz66cku8w11ugwsoq3j9m6qy8es
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18D/Otjcnc4hYwtwLxywwau0hsT2HDNzLM=
X-HE-Tag: 1749603776-935033
X-HE-Meta: U2FsdGVkX1/J/7m/TUWAbEfJ9dG/cOQggKjAX/hEMf3c78hTrVMRzh7huHhJZeFIgQI8h0aTIxT6aKfl2/5Ma8xfXolYVAo8BIE0LqzW56LhHAr+KQH7zXlpC3jHJkAZBSspDmCuyvEgyYYJNdgu14MklhD7pSy0/Z13ehZYh72R3TCjxr5EmZUSJneeUVsibB0TmbbixjvDVh4xNKrVepikGgw0n7xorksvCvX7oINWaQiqA7MiSP7q4R40s0gsB0rGuIxVtxZuyKArSGgtA2yWIPOmPAVTAJF5tX5aGejh6wAlcR7YgKCuAubXLTIDkiimtOI91SRflFS+nx5Aw+wdJBnxAgx5IC2lgepR2WiMPJmUm7LM0xzrAH4dIKqTv9YJLycyWuluqWqTtd0umm/i42GGSvD7Q9aSvY8I57I=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add optional support for user space compat mode frame pointer unwinding.
If supported, the arch needs to enable CONFIG_HAVE_UNWIND_USER_COMPAT_FP
and define ARCH_INIT_USER_COMPAT_FP_FRAME.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v9: https://lore.kernel.org/linux-trace-kernel/20250513223551.459986355@goodmis.org/

As asm-generic headers are not included when an architecture defines the
header, having more than one #ifndef and setting variables does not work
with those checks in the asm-generic header and the architecture header
does not define all the values.

- Move #indef arch_unwind_user_state to linux/user_unwind_types.h

- Move the following to linux/unwind_user.h:
   #ifndef ARCH_INIT_USER_COMPAT_FP_FRAME
   #ifndef arch_unwind_user_init
   #ifndef arch_unwind_user_next

- Changed UNWIND_GET_USER_LONG() to use "unsigned long" instead of u64 as
  this can be called on 32 bit architectures and just because
  "compat_state()" returns false doesn't mean that the value is 64 bit.

 arch/Kconfig                            |  4 +++
 include/asm-generic/Kbuild              |  1 +
 include/asm-generic/unwind_user_types.h |  5 ++++
 include/linux/unwind_user.h             | 13 +++++++++
 include/linux/unwind_user_types.h       |  7 +++++
 kernel/unwind/user.c                    | 36 ++++++++++++++++++++++---
 6 files changed, 62 insertions(+), 4 deletions(-)
 create mode 100644 include/asm-generic/unwind_user_types.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 8e3fd723bd74..2c41d3072910 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -442,6 +442,10 @@ config HAVE_UNWIND_USER_FP
 	bool
 	select UNWIND_USER
 
+config HAVE_UNWIND_USER_COMPAT_FP
+	bool
+	depends on HAVE_UNWIND_USER_FP
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 295c94a3ccc1..b797a2434396 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -60,6 +60,7 @@ mandatory-y += topology.h
 mandatory-y += trace_clock.h
 mandatory-y += uaccess.h
 mandatory-y += unwind_user.h
+mandatory-y += unwind_user_types.h
 mandatory-y += vermagic.h
 mandatory-y += vga.h
 mandatory-y += video.h
diff --git a/include/asm-generic/unwind_user_types.h b/include/asm-generic/unwind_user_types.h
new file mode 100644
index 000000000000..f568b82e52cd
--- /dev/null
+++ b/include/asm-generic/unwind_user_types.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_UNWIND_USER_TYPES_H
+#define _ASM_GENERIC_UNWIND_USER_TYPES_H
+
+#endif /* _ASM_GENERIC_UNWIND_USER_TYPES_H */
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index a405111c41b0..c70da8f7e54c 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -9,6 +9,19 @@
  #define ARCH_INIT_USER_FP_FRAME
 #endif
 
+#ifndef ARCH_INIT_USER_COMPAT_FP_FRAME
+ #define ARCH_INIT_USER_COMPAT_FP_FRAME
+ #define in_compat_mode(regs) false
+#endif
+
+#ifndef arch_unwind_user_init
+static inline void arch_unwind_user_init(struct unwind_user_state *state, struct pt_regs *reg) {}
+#endif
+
+#ifndef arch_unwind_user_next
+static inline void arch_unwind_user_next(struct unwind_user_state *state) {}
+#endif
+
 int unwind_user_start(struct unwind_user_state *state);
 int unwind_user_next(struct unwind_user_state *state);
 
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 65bd070eb6b0..0b6563951ca4 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -3,10 +3,16 @@
 #define _LINUX_UNWIND_USER_TYPES_H
 
 #include <linux/types.h>
+#include <asm/unwind_user_types.h>
+
+#ifndef arch_unwind_user_state
+struct arch_unwind_user_state {};
+#endif
 
 enum unwind_user_type {
 	UNWIND_USER_TYPE_NONE,
 	UNWIND_USER_TYPE_FP,
+	UNWIND_USER_TYPE_COMPAT_FP,
 };
 
 struct unwind_stacktrace {
@@ -25,6 +31,7 @@ struct unwind_user_state {
 	unsigned long ip;
 	unsigned long sp;
 	unsigned long fp;
+	struct arch_unwind_user_state arch;
 	enum unwind_user_type type;
 	bool done;
 };
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 4fc550356b33..29e1f497a26e 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -12,12 +12,32 @@ static struct unwind_user_frame fp_frame = {
 	ARCH_INIT_USER_FP_FRAME
 };
 
+static struct unwind_user_frame compat_fp_frame = {
+	ARCH_INIT_USER_COMPAT_FP_FRAME
+};
+
 static inline bool fp_state(struct unwind_user_state *state)
 {
 	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP) &&
 	       state->type == UNWIND_USER_TYPE_FP;
 }
 
+static inline bool compat_state(struct unwind_user_state *state)
+{
+	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) &&
+	       state->type == UNWIND_USER_TYPE_COMPAT_FP;
+}
+
+#define UNWIND_GET_USER_LONG(to, from, state)				\
+({									\
+	int __ret;							\
+	if (compat_state(state))					\
+		__ret = get_user(to, (u32 __user *)(from));		\
+	else								\
+		__ret = get_user(to, (unsigned long __user *)(from));	\
+	__ret;								\
+})
+
 int unwind_user_next(struct unwind_user_state *state)
 {
 	struct unwind_user_frame *frame;
@@ -26,7 +46,9 @@ int unwind_user_next(struct unwind_user_state *state)
 	if (state->done)
 		return -EINVAL;
 
-	if (fp_state(state))
+	if (compat_state(state))
+		frame = &compat_fp_frame;
+	else if (fp_state(state))
 		frame = &fp_frame;
 	else
 		goto the_end;
@@ -37,10 +59,10 @@ int unwind_user_next(struct unwind_user_state *state)
 	if (cfa <= state->sp)
 		goto the_end;
 
-	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
+	if (UNWIND_GET_USER_LONG(ra, cfa + frame->ra_off, state))
 		goto the_end;
 
-	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
+	if (frame->fp_off && UNWIND_GET_USER_LONG(fp, cfa + frame->fp_off, state))
 		goto the_end;
 
 	state->ip = ra;
@@ -48,6 +70,8 @@ int unwind_user_next(struct unwind_user_state *state)
 	if (frame->fp_off)
 		state->fp = fp;
 
+	arch_unwind_user_next(state);
+
 	return 0;
 
 the_end:
@@ -66,7 +90,9 @@ int unwind_user_start(struct unwind_user_state *state)
 		return -EINVAL;
 	}
 
-	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
+	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) && in_compat_mode(regs))
+		state->type = UNWIND_USER_TYPE_COMPAT_FP;
+	else if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
 		state->type = UNWIND_USER_TYPE_FP;
 	else
 		state->type = UNWIND_USER_TYPE_NONE;
@@ -75,6 +101,8 @@ int unwind_user_start(struct unwind_user_state *state)
 	state->sp = user_stack_pointer(regs);
 	state->fp = frame_pointer(regs);
 
+	arch_unwind_user_init(state, regs);
+
 	return 0;
 }
 
-- 
2.47.2



