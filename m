Return-Path: <bpf+bounces-21336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C059384B923
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7630328FFBB
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78F11353EF;
	Tue,  6 Feb 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aS27veMw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D34113398C;
	Tue,  6 Feb 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232321; cv=none; b=KmppwIiTOJgbC1lNSAoKfT63NFU3mhb6ndSJhkAUyI4Q9q3hqCc+06y0YD+xdeTeyzPFaaiXW6IQzMiiDhbuxn05Tmw2lrPATlfyTPjcZG1OkiFoYdN0xlqw05dJdsQqeI6fz+Ds139dXVR7JoMkxWHl0c2Xb89GPyW7Mrdw4xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232321; c=relaxed/simple;
	bh=9YSxRXR2HSbZYZbflQVAgOR2is0PYbfum3hhAgIy/jA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZEK0HtRTebFSpP8olD/sPlkzLTTzIz16VHHnWDqjLl9hJUmolYtijoPpKsQWES+mk+J41SfvvcKDTJrVN2pFpSp8DE3+j1wjLemQEgUeAAWDxNtw7UCEp1wEvn1bt66FR+0ls3MQZ6QGPWPu8M55Mk9RyHwlJNWyNdPKzBiGv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aS27veMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F1EC433F1;
	Tue,  6 Feb 2024 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707232321;
	bh=9YSxRXR2HSbZYZbflQVAgOR2is0PYbfum3hhAgIy/jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aS27veMwGRZG8E880jNoZMHZEjVF2UWAuNu7Wr7Nnwu0kBYaVKxyo8YyQcreyAFJ+
	 crxhYGzmhyfqHSMiXC2PzQfPCLyrDwqo72jfcHlVoHdAgDRMtCq2cpvIFgJ9rhDdFW
	 Eyr/fyJDDLZtKxRckOz4W8fbRdfzMHqI/QYGLU4XY/26FA6LpylexMrReD6xGZ6usC
	 ajSEeTXQxCmgbKxxSS9DTGCrmwAQeaRl7xM8hJe3Llb7cwXemi1qLVT/oF0S7B4GFx
	 FAx4IhwZBl3PZCOOoq4YRmErnR4vn9WYo+fsqqIbjCeH32ncQ9tZ+PXdUHEDRBf0jN
	 BSeHT2kaOAyyQ==
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
Subject: [PATCH v7 24/36] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Date: Wed,  7 Feb 2024 00:11:56 +0900
Message-Id: <170723231592.502590.12367006830540525214.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170723204881.502590.11906735097521170661.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
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
index 5edec175b9bf..ccf17d8b6f5f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -223,7 +223,8 @@ config X86
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


