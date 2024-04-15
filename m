Return-Path: <bpf+bounces-26802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D059F8A50B2
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 15:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C62C1F2266E
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 13:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D6513C91A;
	Mon, 15 Apr 2024 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNxIUufI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B9713C8E8;
	Mon, 15 Apr 2024 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185698; cv=none; b=PKzkQGuZHPSltuXpGr3G3ynPE8Daf9itpUJTq//dYbrioCbEZfESLmDfs60dGZx4bUIOCaN0O+iJgcK/YnhIpOCRMZZp8qCBfjFbQuW06jBb+ep35gl4i3BYvXQi/WgUK/Jp+CywbHoEsis1iDOtGFgkDnvQjsv23dPc5fax9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185698; c=relaxed/simple;
	bh=RbypeWQOX05HisYlbv4xybC/xnM5UHQ+9ggHc7UbKEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpT7nUx7tE/6l5Yj85nzhVsWtcLAEGdawwFqzUkIVNZqdWGMHCUoslpVQokjzk/MyKFNj3miKhRIHj4G7r15qfCgSPqQ6SnALPgLuhFCzOPdhBUHIp860PLeadgp0+lhEyaWLqcTlvvFJzSV3JibdQOlh7Ufpvj6cva2P80kTVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNxIUufI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD7BC113CC;
	Mon, 15 Apr 2024 12:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185697;
	bh=RbypeWQOX05HisYlbv4xybC/xnM5UHQ+9ggHc7UbKEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNxIUufI9VaYWNgnMm4Wllqn7oKSMEwgOPs5FULnjO6L5/olOeYRnk0yPxKRzyM0v
	 mAIabRcYS1gpuhhWJZiIzvzeXCfyPTYGIFsRRIqp3cBEiGH4EnsR4ycTqNs+/SqSPR
	 H4ADcV8Rgg5vRR7QcZN3LIJYD34XgtS0E16wrCHl1X+73Q1ffp/2vKd0TSrMoXbjZn
	 ZZ+0t5kcdtO6jHas3obUQdkJpb7IvqAFWIN13M6M7b1lXfjzosJxDf5IXi9/3cpZ22
	 WRwpNw41IhgHNnHtHKB0+AsSBElsmA7Bbfc+otSSq2JUgPWGRBpVeHj/YIfiapgzKY
	 CNZzkX2aZ2PsA==
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
Subject: [PATCH v9 30/36] ftrace: Add CONFIG_HAVE_FTRACE_GRAPH_FUNC
Date: Mon, 15 Apr 2024 21:54:52 +0900
Message-Id: <171318569215.254850.6744316511327845278.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171318533841.254850.15841395205784342850.stgit@devnote2>
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
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

Add CONFIG_HAVE_FTRACE_GRAPH_FUNC kconfig in addition to ftrace_graph_func
macro check. This is for the other feature (e.g. FPROBE) which requires to
access ftrace_regs from fgraph_ops::entryfunc() can avoid compiling if
the fgraph can not pass the valid ftrace_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v8:
  - Newly added.
---
 arch/arm64/Kconfig     |    1 +
 arch/loongarch/Kconfig |    1 +
 arch/powerpc/Kconfig   |    1 +
 arch/riscv/Kconfig     |    1 +
 arch/x86/Kconfig       |    1 +
 kernel/trace/Kconfig   |    5 +++++
 6 files changed, 10 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8d5047bc13bc..e0a5c69eeda2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -206,6 +206,7 @@ config ARM64
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FAST_GUP
+	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index dbcba61b6acf..9e94eff7f7cb 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -121,6 +121,7 @@ config LOONGARCH
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !ARCH_STRICT_ALIGN
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
+	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1c4be3373686..b79d16c5846a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -237,6 +237,7 @@ config PPC
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FAST_GUP
+	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_DESCRIPTORS	if PPC64_ELF_ABI_V1
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b58b8e81b510..6fd2a166904b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -127,6 +127,7 @@ config RISCV
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
+	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_FREGS
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 188edde1db4d..4a4fdcd294d2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -224,6 +224,7 @@ config X86
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
+	select HAVE_FTRACE_GRAPH_FUNC		if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_FREGS	if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER	if X86_32 || (X86_64 && DYNAMIC_FTRACE)
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e2fc600f0ef2..9056315d56ed 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -34,6 +34,11 @@ config HAVE_FUNCTION_GRAPH_TRACER
 config HAVE_FUNCTION_GRAPH_FREGS
 	bool
 
+config HAVE_FTRACE_GRAPH_FUNC
+	bool
+	help
+	  True if ftrace_graph_func() is defined.
+
 config HAVE_DYNAMIC_FTRACE
 	bool
 	help


