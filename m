Return-Path: <bpf+bounces-72011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA3DC05A3A
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 12:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A36A35BEB3
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 10:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FEF307AE0;
	Fri, 24 Oct 2025 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f8SBe+CV"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80C7146585;
	Fri, 24 Oct 2025 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302506; cv=none; b=u12PPbqHCNLdU0SkaZsAl/0yFvZVrl3VF3PKc0pY7w+eD4SOl6EvTqmlyuA79/Wl0Hq7X+S3exqebZkFfY+dsS55M1gWp4wMUH+7UdVRCloDgRulQxQe7IJkHu17mIymc2s2QZnMFWnudyITfj8VMtd1D/uXDyUePS/2PEa8Fw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302506; c=relaxed/simple;
	bh=fXL/XYAKyPRWPyekI6E49EFt8QJxlnZtekWFaIU9Yeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+AzWEYKTBnkLpSrDEDoPKC/UXskhweo9Xxfypp8PLNALlG/Rov3PawiCSyHj6Nt4LjfxU+huRTYkuFtruWusf/GibDt3usZLWpfg0sy9iwnwrw6B5NKq7Rlk8LTED9Vp8EKP9bozveZfEq43vuTygfOM0tfVSAU4I1ZlqOK5E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f8SBe+CV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Er4bARwpXMjZqI0mWGWcvCvZFUERMQG43Oiv5EcZcgA=; b=f8SBe+CV3BMAK4ghr54SE+SpLC
	+gVTsUS3+wRihhplqA5eA2ATGVPTheQgcWNdoP653YNPWw5S0okwwA2pg+SnJpibrwr7h8antvYJV
	XbgtgyOYh9sQpobuigPaFCtJ1gFBN2D5G/sFmz6ESkt482ul60Wi5XrwiI1lY66Hya08wfqYx4T4b
	nMW+xOyOn2WWBBW23fQ74mI7+VZ1zop7/HYVw3WjoeZZm9ASAfR9C0uUj3MDnWFo1hwHso4fmwOX0
	pTXto9hi9Lg4gUMoI8MVNZVhl6dv5EE+YrSCCZ8A0KUEPDqQ3owDxjbSk7Xih97mSNy92CuozGP5T
	PO37CfEg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCFEV-0000000FRAD-3qyi;
	Fri, 24 Oct 2025 10:41:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5FD6030023C; Fri, 24 Oct 2025 12:41:19 +0200 (CEST)
Date: Fri, 24 Oct 2025 12:41:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>, jremus@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
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
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: Re: [PATCH v16 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20251024104119.GJ4068168@noisy.programming.kicks-ass.net>
References: <20251007214008.080852573@kernel.org>
 <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
 <20251024092926.GI4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024092926.GI4068168@noisy.programming.kicks-ass.net>

On Fri, Oct 24, 2025 at 11:29:26AM +0200, Peter Zijlstra wrote:
> On Thu, Oct 23, 2025 at 05:00:02PM +0200, Peter Zijlstra wrote:
> 
> > Trouble is, pretty much every unwind is 510 entries long -- this cannot
> > be right. I'm sure there's a silly mistake in unwind/user.c but I'm too
> > tired to find it just now. I'll try again tomorrow.
> 
> PEBKAC

Anyway, while staring at this, I noted that the perf userspace unwind
code has a few bits that are missing from the new shiny thing.

How about something like so? This add an optional arch specific unwinder
at the very highest priority (bit 0) and uses that to do a few extra
bits before disabling itself and falling back to whatever lower prio
unwinder to do the actual unwinding.

---
 arch/x86/events/core.c             |   40 ---------------------------
 arch/x86/include/asm/unwind_user.h |    4 ++
 arch/x86/include/asm/uprobes.h     |    9 ++++++
 arch/x86/kernel/unwind_user.c      |   53 +++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/uprobes.c          |   32 ++++++++++++++++++++++
 include/linux/unwind_user_types.h  |    5 ++-
 kernel/unwind/user.c               |    7 ++++
 7 files changed, 109 insertions(+), 41 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2845,46 +2845,6 @@ static unsigned long get_segment_base(un
 	return get_desc_base(desc);
 }
 
-#ifdef CONFIG_UPROBES
-/*
- * Heuristic-based check if uprobe is installed at the function entry.
- *
- * Under assumption of user code being compiled with frame pointers,
- * `push %rbp/%ebp` is a good indicator that we indeed are.
- *
- * Similarly, `endbr64` (assuming 64-bit mode) is also a common pattern.
- * If we get this wrong, captured stack trace might have one extra bogus
- * entry, but the rest of stack trace will still be meaningful.
- */
-static bool is_uprobe_at_func_entry(struct pt_regs *regs)
-{
-	struct arch_uprobe *auprobe;
-
-	if (!current->utask)
-		return false;
-
-	auprobe = current->utask->auprobe;
-	if (!auprobe)
-		return false;
-
-	/* push %rbp/%ebp */
-	if (auprobe->insn[0] == 0x55)
-		return true;
-
-	/* endbr64 (64-bit only) */
-	if (user_64bit_mode(regs) && is_endbr((u32 *)auprobe->insn))
-		return true;
-
-	return false;
-}
-
-#else
-static bool is_uprobe_at_func_entry(struct pt_regs *regs)
-{
-	return false;
-}
-#endif /* CONFIG_UPROBES */
-
 #ifdef CONFIG_IA32_EMULATION
 
 #include <linux/compat.h>
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -8,4 +8,8 @@
 	.fp_off		= -2*(ws),			\
 	.use_fp		= true,
 
+#define HAVE_UNWIND_USER_ARCH 1
+
+extern int unwind_user_next_arch(struct unwind_user_state *state);
+
 #endif /* _ASM_X86_UNWIND_USER_H */
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -62,4 +62,13 @@ struct arch_uprobe_task {
 	unsigned int			saved_tf;
 };
 
+#ifdef CONFIG_UPROBES
+extern bool is_uprobe_at_func_entry(struct pt_regs *regs);
+#else
+static bool is_uprobe_at_func_entry(struct pt_regs *regs)
+{
+	return false;
+}
+#endif /* CONFIG_UPROBES */
+
 #endif	/* _ASM_UPROBES_H */
--- /dev/null
+++ b/arch/x86/kernel/unwind_user.c
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/unwind_user.h>
+#include <linux/uprobes.h>
+#include <linux/uaccess.h>
+#include <linux/sched/task_stack.h>
+#include <asm/processor.h>
+#include <asm/tlbflush.h>
+
+int unwind_user_next_arch(struct unwind_user_state *state)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+
+	/* only once, on the first iteration */
+	state->available_types &= ~UNWIND_USER_TYPE_ARCH;
+
+	/* We don't know how to unwind VM86 stacks. */
+	if (regs->flags & X86_VM_MASK) {
+		state->done = true;
+		return 0;
+	}
+
+	/*
+	 * If we are called from uprobe handler, and we are indeed at the very
+	 * entry to user function (which is normally a `push %rbp` instruction,
+	 * under assumption of application being compiled with frame pointers),
+	 * we should read return address from *regs->sp before proceeding
+	 * to follow frame pointers, otherwise we'll skip immediate caller
+	 * as %rbp is not yet setup.
+	 */
+	if (!is_uprobe_at_func_entry(regs))
+		return -EINVAL;
+
+#ifdef CONFIG_COMPAT
+	if (state->ws == sizeof(int)) {
+		unsigned int retaddr;
+		int ret = get_user(retaddr, (unsigned int __user *)regs->sp);
+		if (ret)
+			return ret;
+
+		state->ip = retaddr;
+		return 0;
+	}
+#endif
+	unsigned long retaddr;
+	int ret = get_user(retaddr, (unsigned long __user *)regs->sp);
+	if (ret)
+		return ret;
+
+	state->ip = retaddr;
+	return 0;
+}
+
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1791,3 +1791,35 @@ bool arch_uretprobe_is_alive(struct retu
 	else
 		return regs->sp <= ret->stack;
 }
+
+/*
+ * Heuristic-based check if uprobe is installed at the function entry.
+ *
+ * Under assumption of user code being compiled with frame pointers,
+ * `push %rbp/%ebp` is a good indicator that we indeed are.
+ *
+ * Similarly, `endbr64` (assuming 64-bit mode) is also a common pattern.
+ * If we get this wrong, captured stack trace might have one extra bogus
+ * entry, but the rest of stack trace will still be meaningful.
+ */
+bool is_uprobe_at_func_entry(struct pt_regs *regs)
+{
+	struct arch_uprobe *auprobe;
+
+	if (!current->utask)
+		return false;
+
+	auprobe = current->utask->auprobe;
+	if (!auprobe)
+		return false;
+
+	/* push %rbp/%ebp */
+	if (auprobe->insn[0] == 0x55)
+		return true;
+
+	/* endbr64 (64-bit only) */
+	if (user_64bit_mode(regs) && is_endbr((u32 *)auprobe->insn))
+		return true;
+
+	return false;
+}
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -3,13 +3,15 @@
 #define _LINUX_UNWIND_USER_TYPES_H
 
 #include <linux/types.h>
+#include <linux/bits.h>
 
 /*
  * Unwind types, listed in priority order: lower numbers are attempted first if
  * available.
  */
 enum unwind_user_type_bits {
-	UNWIND_USER_TYPE_FP_BIT =		0,
+	UNWIND_USER_TYPE_ARCH_BIT = 0,
+	UNWIND_USER_TYPE_FP_BIT,
 
 	NR_UNWIND_USER_TYPE_BITS,
 };
@@ -17,6 +19,7 @@ enum unwind_user_type_bits {
 enum unwind_user_type {
 	/* Type "none" for the start of stack walk iteration. */
 	UNWIND_USER_TYPE_NONE =			0,
+	UNWIND_USER_TYPE_ARCH =			BIT(UNWIND_USER_TYPE_ARCH_BIT),
 	UNWIND_USER_TYPE_FP =			BIT(UNWIND_USER_TYPE_FP_BIT),
 };
 
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -79,6 +79,10 @@ static int unwind_user_next(struct unwin
 
 		state->current_type = type;
 		switch (type) {
+		case UNWIND_USER_TYPE_ARCH:
+			if (!unwind_user_next_arch(state))
+				return 0;
+			continue;
 		case UNWIND_USER_TYPE_FP:
 			if (!unwind_user_next_fp(state))
 				return 0;
@@ -107,6 +111,9 @@ static int unwind_user_start(struct unwi
 		return -EINVAL;
 	}
 
+	if (HAVE_UNWIND_USER_ARCH)
+		state->available_types |= UNWIND_USER_TYPE_ARCH;
+
 	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
 		state->available_types |= UNWIND_USER_TYPE_FP;
 

