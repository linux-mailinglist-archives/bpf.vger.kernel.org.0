Return-Path: <bpf+bounces-73503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAFEC331D8
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 22:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BDBD18C0CD6
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 21:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830FA3469E3;
	Tue,  4 Nov 2025 21:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEEUO3Ij"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6E346798;
	Tue,  4 Nov 2025 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293277; cv=none; b=f3FrEmOTd0WDQz0A5yorgmu3M7AKwHsF/U+5V89rbSnyOd1wmxviY1+4/W5hZdWnQEEhV3NnpKztpuuwgEP44jhojpZ4OggZdTEXb22Gj0/5e98Z0tnY9gElhPU7Cbpc2a7Tv3bsBHKoSPpm2dtyzX8pVQdTsgvotslkXpoDpJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293277; c=relaxed/simple;
	bh=l2wyzjmEnojzfg5Q8Q5XiFpD3wwNz5jl75pLyFELats=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNjEqCc3Nxio+JY2vVG+5FsPEbhb932oTCX0SCozy6mr67GJKQ+xNUGwrxP91szBZdgdORX6tSk5PO5I/z902FuUbOM9N0lU5TKZO7nw77ihSkrbnDVeSke43aN5Sx7wWBxN0X0tQbSHxUJeS+L1JaseOZj0uSojl24Yhfme8SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEEUO3Ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9784CC4CEF8;
	Tue,  4 Nov 2025 21:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762293276;
	bh=l2wyzjmEnojzfg5Q8Q5XiFpD3wwNz5jl75pLyFELats=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEEUO3IjfyKyJWeNAFMxKAX7fwjUZEKpawOBmZDOKajREoptZt1nTKn+JzguSAPIr
	 6lnvFcRCosGLOSn1t27v9Sp8w8xeNSIopPpF0tQIfeD4BthwGQVMKKEbxlnepf6J8v
	 57rdB+7KoCeENp5w6dVwmBny8r0oEHjrx4gib+sON8dFbjb5d5Ba+OWR7WU3QW8T0P
	 pMdanCIhMRF6C9teVHT8Y4nUSg+mHNMVd8iZ54n/C+7vr8MiokTJrAuLhdLFs3paLc
	 Y2kck4IpZ3wHPwCvsWRJBQabuwKEhQ+t5uk28i/mG99fAOjiDd3TRBxjXnBWvzIbC1
	 vfSXFSCJE5+fQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCHv3 2/4] x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe
Date: Tue,  4 Nov 2025 22:54:03 +0100
Message-ID: <20251104215405.168643-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104215405.168643-1-jolsa@kernel.org>
References: <20251104215405.168643-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we don't get stack trace via ORC unwinder on top of fgraph exit
handler. We can see that when generating stacktrace from kretprobe_multi
bpf program which is based on fprobe/fgraph.

The reason is that the ORC unwind code won't get pass the return_to_handler
callback installed by fgraph return probe machinery.

Solving this by creating stack frame in return_to_handler expected by
ftrace_graph_ret_addr function to recover original return address and
continue with the unwind.

Also updating the pt_regs data with cs/flags/rsp which are needed for
successful stack retrieval from ebpf bpf_get_stackid helper.
 - in get_perf_callchain we check user_mode(regs) so CS has to be set
 - in perf_callchain_kernel we call perf_hw_regs(regs), so EFLAGS/FIXED
    has to be unset

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/ftrace.h |  5 +++++
 arch/x86/kernel/ftrace_64.S   |  8 +++++++-
 include/linux/ftrace.h        | 10 +++++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 93156ac4ffe0..b08c95872eed 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -56,6 +56,11 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 	return &arch_ftrace_regs(fregs)->regs;
 }
 
+#define arch_ftrace_partial_regs(regs) do {	\
+	regs->flags &= ~X86_EFLAGS_FIXED;	\
+	regs->cs = __KERNEL_CS;			\
+} while (0)
+
 #define arch_ftrace_fill_perf_regs(fregs, _regs) do {	\
 		(_regs)->ip = arch_ftrace_regs(fregs)->regs.ip;		\
 		(_regs)->sp = arch_ftrace_regs(fregs)->regs.sp;		\
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 367da3638167..823dbdd0eb41 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -354,12 +354,17 @@ SYM_CODE_START(return_to_handler)
 	UNWIND_HINT_UNDEFINED
 	ANNOTATE_NOENDBR
 
+	/* Restore return_to_handler value that got eaten by previous ret instruction. */
+	subq $8, %rsp
+	UNWIND_HINT_FUNC
+
 	/* Save ftrace_regs for function exit context  */
 	subq $(FRAME_SIZE), %rsp
 
 	movq %rax, RAX(%rsp)
 	movq %rdx, RDX(%rsp)
 	movq %rbp, RBP(%rsp)
+	movq %rsp, RSP(%rsp)
 	movq %rsp, %rdi
 
 	call ftrace_return_to_handler
@@ -368,7 +373,8 @@ SYM_CODE_START(return_to_handler)
 	movq RDX(%rsp), %rdx
 	movq RAX(%rsp), %rax
 
-	addq $(FRAME_SIZE), %rsp
+	addq $(FRAME_SIZE) + 8, %rsp
+
 	/*
 	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi
 	 * since IBT would demand that contain ENDBR, which simply isn't so for
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 7ded7df6e9b5..07f8c309e432 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -193,6 +193,10 @@ static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs
 #if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
 	defined(CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS)
 
+#ifndef arch_ftrace_partial_regs
+#define arch_ftrace_partial_regs(regs) do {} while (0)
+#endif
+
 static __always_inline struct pt_regs *
 ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
 {
@@ -202,7 +206,11 @@ ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
 	 * Since arch_ftrace_get_regs() will check some members and may return
 	 * NULL, we can not use it.
 	 */
-	return &arch_ftrace_regs(fregs)->regs;
+	regs = &arch_ftrace_regs(fregs)->regs;
+
+	/* Allow arch specific updates to regs. */
+	arch_ftrace_partial_regs(regs);
+	return regs;
 }
 
 #endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS */
-- 
2.51.0


