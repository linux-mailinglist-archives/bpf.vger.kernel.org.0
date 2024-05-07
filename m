Return-Path: <bpf+bounces-28867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A838BE592
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873221F23CBD
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865F016DED2;
	Tue,  7 May 2024 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwbmmOjG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0363C16190B;
	Tue,  7 May 2024 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091240; cv=none; b=OAyAIIDcJjKNwkmsXTDWVOr5ShYwqaz57+wcSXCd+l6uF7XV3x8pqh9Wd5Vpy1BteB1r28H/HLOEMmCMBUCGly8lPGats5iNhOBVwC+ytLEZGtm6on7PiMRNOg3Q8Ipyk9lw/sFYXBVy94h3tAai/qKoFaqBd88P2XhAbRRqg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091240; c=relaxed/simple;
	bh=luUp+uu0oFKIjV/gk8O+fPSqFMHg0gN7kVes9334cs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oO7pSpNE5KEGVzt4J0RFr0F/PxV4SQBTu5xqTK0aAtIhiNDbDUkGdtHDi+YKfJpcfLW2dgyRoh5jWFdv/BLCYYbwVOnHh0I0RX8rJAoh1SN4Q5Qr1fZoLe1JC0EWOIJv8UMPHfqAZsF0hu0dc9lCoMA5kyoxxe2kNJ6b9r7QvxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwbmmOjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD07C2BBFC;
	Tue,  7 May 2024 14:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715091239;
	bh=luUp+uu0oFKIjV/gk8O+fPSqFMHg0gN7kVes9334cs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bwbmmOjGGVh8+XfBbJFrf/IHFwHDwfBhI6yjia9i+DvvMv5UuDGAWhqqZlPKGI1EX
	 0qvs6DQTsWpskQfg8A/G4/Rxg2VGByEk1qZsoq12++rsm4cfXs0RxMpw6mnrOYUyH/
	 zQ8i5ykwKUioirgL+3v5wq6pf9LTRMpV/EjqJ/T/PUKjwdBU5L42V6oR0oluyA0wEn
	 u1CsL1aBxYFjyyLLJB0ct5AFPCrdoYYG1e3rfemSk1av4j5C95Zw4OSVVmDgZTig7w
	 4FWvDCzeXMz6B6ZbxIR3dlTe/M1rrWLPEPPluLrORy3jdH5LADBY1BzRC7RlqaXUuR
	 vEH6jXLs0wJlA==
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
Subject: [PATCH v10 30/36] ftrace: Add CONFIG_HAVE_FTRACE_GRAPH_FUNC
Date: Tue,  7 May 2024 23:13:53 +0900
Message-Id: <171509123327.162236.8914387678237087834.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171509088006.162236.7227326999861366050.stgit@devnote2>
References: <171509088006.162236.7227326999861366050.stgit@devnote2>
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
index 21dc39ae6bc2..0276a6825e6d 100644
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
index 4da23dc0b07c..bd86e598e31d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -225,6 +225,7 @@ config X86
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
+	select HAVE_FTRACE_GRAPH_FUNC		if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_FREGS	if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER	if X86_32 || (X86_64 && DYNAMIC_FTRACE)
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 0b6ce0a38967..0e4c33f1ab43 100644
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


