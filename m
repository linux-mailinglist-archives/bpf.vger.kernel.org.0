Return-Path: <bpf+bounces-73388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6CFC2E370
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 23:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D78A188B298
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 22:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB5134D3A7;
	Mon,  3 Nov 2025 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYoJ7Hqx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9235D2D480F;
	Mon,  3 Nov 2025 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762207795; cv=none; b=LiwdCan0NzS8SGp1c3DtQalLURIaCfKelkWJ7YRCtwvVrna7UjmHkghNtdyRVoVmKKJ+76X+emf+KVEBgjFFP/FtcG4YBpc28jLoAAscNAV458fI1TnUP9vr/G12VtyJK8kVW3x2bV2RESOqL6d4FtjAFYTd79YswqJJ7FoF08k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762207795; c=relaxed/simple;
	bh=l2wyzjmEnojzfg5Q8Q5XiFpD3wwNz5jl75pLyFELats=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGbhUSxXvOOzQgS95D1TxElHEJNprzqpQtlOkAwfDAEtq5wdxvCDi6EqBXbn8eh029W4jtD5rQ4RBAo66HoltAlSuF8oZ2sfav/ILSQvYtk+MQhPT/w655ayoQdCOPIBESik13ocNLKQH9Gi5GiJM4d2PAmfBOtihyMpBIsLA6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYoJ7Hqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89681C4CEE7;
	Mon,  3 Nov 2025 22:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762207795;
	bh=l2wyzjmEnojzfg5Q8Q5XiFpD3wwNz5jl75pLyFELats=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NYoJ7HqxuUdUWtdlT75jOr20LJNADF57YiqbpkwkCQ+Iyu30fZhSwHJM1u49euNDr
	 DwkcV49SIOhjeVHCrK8zgOyDh+u1dUlsT+On80V1U+2zLk+BRrKFdJXSaM99GZ3WDr
	 sIuOsHAWpPR4VRB3dDQJm5dTJJ6YjcAzRUdUhXws8UUiaggLU1ZYpxyttUo6VvzyTn
	 pTkwlhfM71zndYY91U2BVOprVdo7FeRWtY6MEJx+2NeHEjiA+1UZwpGbC3dvXEJpHL
	 9oGM8OyBB5R7PbuOGmcYLre9wCChW8MlCKCYD17wP97INpxwHrIoWbavJMW/N5Bo8K
	 669bswdZ46LvA==
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
Subject: [PATCHv2 2/4] x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe
Date: Mon,  3 Nov 2025 23:09:22 +0100
Message-ID: <20251103220924.36371-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103220924.36371-1-jolsa@kernel.org>
References: <20251103220924.36371-1-jolsa@kernel.org>
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


