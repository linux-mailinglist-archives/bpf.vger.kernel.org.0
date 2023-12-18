Return-Path: <bpf+bounces-18201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565D3817047
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 14:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7941F20F71
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 13:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DF849884;
	Mon, 18 Dec 2023 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW3jbQAF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219D342364;
	Mon, 18 Dec 2023 13:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68185C433C8;
	Mon, 18 Dec 2023 13:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702905354;
	bh=pPNJXjygt/V4vNYQ4X8NJkqM9twm0EdHZQuhceTJqsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MW3jbQAFUY++NKujPrh3jiyQS0LoHlI+A+kZKcQJLi0s180v6xCV9CGus7fmtqi7D
	 ByE2fltburI8QA/1NDWiV1iSGk6tJsxZi3NXM+5/RBhpOvfrlUYDkBUmRicYuUgwO8
	 0QgoB1AmHAndv5A3xSDG56lgfLUxHrUPCuNMACr9WOBTRE+a/cMEFe7UqVcVhH4Oxx
	 vRUvHm80kOeiBkUdo+Exanm9NU2Oll9o7R2Obqo59BjQNzNTviTasjJIh519mgYasn
	 ismkfK21vdI/cx5c3SX2JHl2EMdMtiUS4LFGBGQzSRiDiuhx+dirIJAHcILPcLZkZB
	 9T1AboeN2OQKw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guo Ren <guoren@kernel.org>
Subject: [PATCH v5 21/34] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Date: Mon, 18 Dec 2023 22:15:47 +0900
Message-Id: <170290534735.220107.11399065444521677554.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170290509018.220107.1347127510564358608.stgit@devnote2>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Support HAVE_FUNCTION_GRAPH_FREGS on x86-64, which saves ftrace_regs
on the stack in ftrace_graph return trampoline so that the callbacks
can access registers via ftrace_regs APIs.

Note that this only recovers 'rax' and 'rdx' registers because other
registers are not used anymore and recovered by caller. 'rax' and
'rdx' will be used for passing the return value.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Add a comment about rip.
 Changes in v2:
  - Save rsp register and drop clearing orig_ax.
---
 arch/x86/Kconfig            |    3 ++-
 arch/x86/kernel/ftrace_64.S |   37 +++++++++++++++++++++++++++++--------
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3762f41bb092..3b955c9e4eb6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -219,7 +219,8 @@ config X86
 	select HAVE_FAST_GUP
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
-	select HAVE_FUNCTION_GRAPH_RETVAL	if HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_FREGS	if HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	select HAVE_FUNCTION_GRAPH_RETVAL	if !HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_FUNCTION_GRAPH_TRACER	if X86_32 || (X86_64 && DYNAMIC_FTRACE)
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 214f30e9f0c0..8a16f774604e 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -348,21 +348,42 @@ STACK_FRAME_NON_STANDARD_FP(__fentry__)
 SYM_CODE_START(return_to_handler)
 	UNWIND_HINT_UNDEFINED
 	ANNOTATE_NOENDBR
-	subq  $24, %rsp
+	/*
+	 * Save the registers requires for ftrace_regs;
+	 * rax, rcx, rdx, rdi, rsi, r8, r9 and rbp
+	 */
+	subq $(FRAME_SIZE), %rsp
+	movq %rax, RAX(%rsp)
+	movq %rcx, RCX(%rsp)
+	movq %rdx, RDX(%rsp)
+	movq %rsi, RSI(%rsp)
+	movq %rdi, RDI(%rsp)
+	movq %r8, R8(%rsp)
+	movq %r9, R9(%rsp)
+	movq %rbp, RBP(%rsp)
+	/*
+	 * orig_ax is not cleared because it is used for indicating the direct
+	 * trampoline in the fentry. And rip is not set because we don't know
+	 * the correct return address here.
+	 */
+
+	leaq FRAME_SIZE(%rsp), %rcx
+	movq %rcx, RSP(%rsp)
 
-	/* Save the return values */
-	movq %rax, (%rsp)
-	movq %rdx, 8(%rsp)
-	movq %rbp, 16(%rsp)
 	movq %rsp, %rdi
 
 	call ftrace_return_to_handler
 
 	movq %rax, %rdi
-	movq 8(%rsp), %rdx
-	movq (%rsp), %rax
 
-	addq $24, %rsp
+	/*
+	 * Restore only rax and rdx because other registers are not used
+	 * for return value nor callee saved. Caller will reuse/recover it.
+	 */
+	movq RDX(%rsp), %rdx
+	movq RAX(%rsp), %rax
+
+	addq $(FRAME_SIZE), %rsp
 	/*
 	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi
 	 * since IBT would demand that contain ENDBR, which simply isn't so for


