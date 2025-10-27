Return-Path: <bpf+bounces-72321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EFAC0DF70
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 14:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34C33BD9A3
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 13:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA01925B30D;
	Mon, 27 Oct 2025 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+Octpgg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8032571D7;
	Mon, 27 Oct 2025 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570866; cv=none; b=ogUZjFlR5sla2ECr/WRkBed+D+7TG/qhMRosUpoSD519tClcbcNSPw1WwwemrwZmC31M7GJo4HS127A4dj5gY2rzHfLrkknIpB76IesqjVDwI8iyM4dPAnMn0i9N7NX+HPNIEBxZI2Bx1LQnYcnl7GscsMRgMKLULKHKta16mL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570866; c=relaxed/simple;
	bh=Fz1tu0mzcidGzthNvqcB+rfBjYZ08d3OyGUaWr8e94w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgWszHNj8zDpu2J3DAM6M/+5Z7cLFE15jjoMt8MJPa9DINV5Ps5dNZuXqcp/NyTttNPv2urk1sGwxxzSOQHCofYqRI8Ubi0fy7ZIrCOmsgysK9ew/8KBPXn9FaIn/0jkTNjzlPKw7MM7rgB8ekBq+Icjd6u0TELKWGqtnqoK2sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+Octpgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F646C4CEF1;
	Mon, 27 Oct 2025 13:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761570865;
	bh=Fz1tu0mzcidGzthNvqcB+rfBjYZ08d3OyGUaWr8e94w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+OctpggykHXh937o/Bs3bFENJBoZbBeLvhBwdACqNoSQc9E6S9elqWFefAOn3IY6
	 YmcSmKRpHs+duwqY3wRdcv0OjCYJQ+9sAsKgw7Qjmp6ShXikWBJTqUT1Tfy8vhiRSS
	 3y8lzJBK8/dtTY7/8D2/DIoMUvaw8VGPy3Zs1ZlpEoAZs3jhYdYoMhlvMTNXo5YJH/
	 HPXKmjIPtsCqwEZof7RWi8TLt/yEO+tLYKPr958rmG1yWevC3lZ9+7uSi9AE2cpQ38
	 CYmY4QB/V7sCVCuKN0fvj6fLP9pRajXwvnvXnn7j/n6QmH+haDaFyQfEoMBdidPaZA
	 QQ+APffGf1sFA==
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
Subject: [PATCH 2/3] x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe
Date: Mon, 27 Oct 2025 14:13:53 +0100
Message-ID: <20251027131354.1984006-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027131354.1984006-1-jolsa@kernel.org>
References: <20251027131354.1984006-1-jolsa@kernel.org>
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

Note I feel like it'd be better to set those directly in return_to_handler,
but Steven suggested setting them later in kprobe_multi code path.

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


