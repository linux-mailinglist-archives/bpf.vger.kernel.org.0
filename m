Return-Path: <bpf+bounces-47674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC019FD56A
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 16:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18108165C51
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 15:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138351F8904;
	Fri, 27 Dec 2024 15:13:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7014C1F8662;
	Fri, 27 Dec 2024 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735312382; cv=none; b=nrtq2ll8hqQBIx5K6kbG3HOTEMnZBlJz6LXuByIa50LkmArqDxS1rTdpMkxdu9LrbwGnR2S8YshMG2pPHvzAB/ZYrMKBl+vBGgYbfy5nZ3qq1PsUjrTgRwqjCNo/SW046cSNuf1hNYoMjBtDxIPlBWMlXIY8mqCnWppfDiMAhEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735312382; c=relaxed/simple;
	bh=qAdqS6IDt2omZUFarPZr/ZyIrEqcGjweEdZ+4zs3yGw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IbqJVjAHVhvxW/KrNJqnJ5uN62gI3NP0UV4bodgegqoAa03AQ9pZ3QTU3w2kwA89gdwLWEDIB/aaZKEwjLQwydECE9Ed90bjOemtTnkyvvhrFUjvuV78QCGTxU6SDSpyuaHbkpTK49aqs/Goufbg/hnHrWBKk1uG7oRj642f8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470D3C4CEEC;
	Fri, 27 Dec 2024 15:13:02 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tRC2N-0000000Gxaw-3Ihe;
	Fri, 27 Dec 2024 10:14:03 -0500
Message-ID: <20241227151403.634333633@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 27 Dec 2024 10:13:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 18/18] ftrace: Add ftrace_get_symaddr to convert fentry_ip to symaddr
References: <20241227151335.898746489@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

This introduces ftrace_get_symaddr() which tries to convert fentry_ip
passed by ftrace or fgraph callback to symaddr without calling
kallsyms API. It returns the symbol address or 0 if it fails to
convert it.

Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/173519011487.391279.5450806886342723151.stgit@devnote2
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412061423.K79V55Hd-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202412061804.5VRzF14E-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/arm64/include/asm/ftrace.h |  2 ++
 arch/arm64/kernel/ftrace.c      | 63 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/ftrace.h   | 21 +++++++++++
 include/linux/ftrace.h          | 13 +++++++
 4 files changed, 99 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 876e88ad4119..bfe3ce9df197 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -52,6 +52,8 @@ extern unsigned long ftrace_graph_call;
 extern void return_to_handler(void);
 
 unsigned long ftrace_call_adjust(unsigned long addr);
+unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip);
+#define ftrace_get_symaddr(fentry_ip) arch_ftrace_get_symaddr(fentry_ip)
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 #define HAVE_ARCH_FTRACE_REGS
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 570c38be833c..d7c0d023dfe5 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -143,6 +143,69 @@ unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
+/* Convert fentry_ip to the symbol address without kallsyms */
+unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
+{
+	u32 insn;
+
+	/*
+	 * When using patchable-function-entry without pre-function NOPS, ftrace
+	 * entry is the address of the first NOP after the function entry point.
+	 *
+	 * The compiler has either generated:
+	 *
+	 * func+00:	func:	NOP		// To be patched to MOV X9, LR
+	 * func+04:		NOP		// To be patched to BL <caller>
+	 *
+	 * Or:
+	 *
+	 * func-04:		BTI	C
+	 * func+00:	func:	NOP		// To be patched to MOV X9, LR
+	 * func+04:		NOP		// To be patched to BL <caller>
+	 *
+	 * The fentry_ip is the address of `BL <caller>` which is at `func + 4`
+	 * bytes in either case.
+	 */
+	if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
+		return fentry_ip - AARCH64_INSN_SIZE;
+
+	/*
+	 * When using patchable-function-entry with pre-function NOPs, BTI is
+	 * a bit different.
+	 *
+	 * func+00:	func:	NOP		// To be patched to MOV X9, LR
+	 * func+04:		NOP		// To be patched to BL <caller>
+	 *
+	 * Or:
+	 *
+	 * func+00:	func:	BTI	C
+	 * func+04:		NOP		// To be patched to MOV X9, LR
+	 * func+08:		NOP		// To be patched to BL <caller>
+	 *
+	 * The fentry_ip is the address of `BL <caller>` which is at either
+	 * `func + 4` or `func + 8` depends on whether there is a BTI.
+	 */
+
+	/* If there is no BTI, the func address should be one instruction before. */
+	if (!IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
+		return fentry_ip - AARCH64_INSN_SIZE;
+
+	/* We want to be extra safe in case entry ip is on the page edge,
+	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
+	 */
+	if ((fentry_ip & ~PAGE_MASK) < AARCH64_INSN_SIZE * 2) {
+		if (get_kernel_nofault(insn, (u32 *)(fentry_ip - AARCH64_INSN_SIZE * 2)))
+			return 0;
+	} else {
+		insn = *(u32 *)(fentry_ip - AARCH64_INSN_SIZE * 2);
+	}
+
+	if (aarch64_insn_is_bti(le32_to_cpu((__le32)insn)))
+		return fentry_ip - AARCH64_INSN_SIZE * 2;
+
+	return fentry_ip - AARCH64_INSN_SIZE;
+}
+
 /*
  * Replace a single instruction, which may be a branch or NOP.
  * If @validate == true, a replaced instruction is checked against 'old'.
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index cc92c99ef276..f9cb4d07df58 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -34,6 +34,27 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
+static inline unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
+{
+#ifdef CONFIG_X86_KERNEL_IBT
+	u32 instr;
+
+	/* We want to be extra safe in case entry ip is on the page edge,
+	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
+	 */
+	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
+		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
+			return fentry_ip;
+	} else {
+		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
+	}
+	if (is_endbr(instr))
+		fentry_ip -= ENDBR_INSN_SIZE;
+#endif
+	return fentry_ip;
+}
+#define ftrace_get_symaddr(fentry_ip)	arch_ftrace_get_symaddr(fentry_ip)
+
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
 #include <linux/ftrace_regs.h>
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 4c553fe9c026..07092dfb21a4 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -622,6 +622,19 @@ enum {
 	FTRACE_MAY_SLEEP		= (1 << 5),
 };
 
+/* Arches can override ftrace_get_symaddr() to convert fentry_ip to symaddr. */
+#ifndef ftrace_get_symaddr
+/**
+ * ftrace_get_symaddr - return the symbol address from fentry_ip
+ * @fentry_ip: the address of ftrace location
+ *
+ * Get the symbol address from @fentry_ip (fast path). If there is no fast
+ * search path, this returns 0.
+ * User may need to use kallsyms API to find the symbol address.
+ */
+#define ftrace_get_symaddr(fentry_ip) (0)
+#endif
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 void ftrace_arch_code_modify_prepare(void);
-- 
2.45.2



