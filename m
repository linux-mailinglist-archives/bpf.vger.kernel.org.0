Return-Path: <bpf+bounces-15927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9DC7FA1BA
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 14:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63912B2130C
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 13:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B2330CF9;
	Mon, 27 Nov 2023 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjl1gU6E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62CC30CE5;
	Mon, 27 Nov 2023 13:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BF8C433C7;
	Mon, 27 Nov 2023 13:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701093466;
	bh=laXiPq6pCZezVsgqy2AbYoST02LKOiIN00hspmTWaV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjl1gU6E/H4SivudDYeoneFcQjDJLVwxkwxIB9sH92a8mwKwj4fGQiTQNOHHDC3tu
	 J0P+AoSuDghoMThhLLoWMMxQw5jaEWhi5zj8N9bzLZy2IFSwzFhzFZqhU+BWNR2zfi
	 mCQme+LXphmTC9L6W+akPXsWajpZfajpiqNsSPHl/W2PhMPyI0i2nhsjV/Qcvp4S/v
	 qsNYBw3iHERLhrXwbdiLtqXY+/dZqDGRnQPxA4L+LMVNYcDaq23KhbVNja/lpr7SWK
	 9kXStCyPUn1fmeQMOG6iRXO62PL3tWoN9iOJEY5WkHAMp81fPUZdA+DJXBUDCtfc0A
	 kpQ3oqJhOwciA==
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
Subject: [PATCH v3 23/33] arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Date: Mon, 27 Nov 2023 22:57:40 +0900
Message-Id: <170109345963.343914.8985762897942714493.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170109317214.343914.4784420430328654397.stgit@devnote2>
References: <170109317214.343914.4784420430328654397.stgit@devnote2>
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

Enable CONFIG_HAVE_FUNCTION_GRAPH_FREGS on arm64. Note that this
depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS which is enabled if the
compiler supports "-fpatchable-function-entry=2". If not, it
continue to use ftrace_ret_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
   - Newly added.
---
 arch/arm64/Kconfig               |    2 ++
 arch/arm64/include/asm/ftrace.h  |    6 ++++++
 arch/arm64/kernel/entry-ftrace.S |   28 ++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 78f20e632712..373f6e113141 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -192,6 +192,8 @@ config ARM64
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
 		if $(cc-option,-fpatchable-function-entry=2)
+	select HAVE_FUNCTION_GRAPH_FREGS \
+		if HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
 		if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
 	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index ab158196480c..efd5dbf74dd6 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -131,6 +131,12 @@ ftrace_regs_set_return_value(struct ftrace_regs *fregs,
 	fregs->regs[0] = ret;
 }
 
+static __always_inline unsigned long
+ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
+{
+	return fregs->fp;
+}
+
 static __always_inline void
 ftrace_override_function_with_return(struct ftrace_regs *fregs)
 {
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index f0c16640ef21..d87ccdb9e678 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -328,6 +328,33 @@ SYM_FUNC_END(ftrace_stub_graph)
  * Run ftrace_return_to_handler() before going back to parent.
  * @fp is checked against the value passed by ftrace_graph_caller().
  */
+#ifdef CONFIG_HAVE_FUNCTION_GRAPH_FREGS
+SYM_CODE_START(return_to_handler)
+	/* save ftrace_regs except for PC */
+	sub	sp, sp, #FREGS_SIZE
+	stp	x0, x1, [sp, #FREGS_X0]
+	stp	x2, x3, [sp, #FREGS_X2]
+	stp	x4, x5, [sp, #FREGS_X4]
+	stp	x6, x7, [sp, #FREGS_X6]
+	str	x8,     [sp, #FREGS_X8]
+	str	x29, [sp, #FREGS_FP]
+	str	x9,  [sp, #FREGS_LR]
+	str	x10, [sp, #FREGS_SP]
+
+	mov	x0, sp
+	bl	ftrace_return_to_handler	// addr = ftrace_return_to_hander(fregs);
+	mov	x30, x0				// restore the original return address
+
+	/* restore return value regs */
+	ldp x0, x1, [sp, #FREGS_X0]
+	ldp x2, x3, [sp, #FREGS_X2]
+	ldp x4, x5, [sp, #FREGS_X4]
+	ldp x6, x7, [sp, #FREGS_X6]
+	add sp, sp, #FREGS_SIZE
+
+	ret
+SYM_CODE_END(return_to_handler)
+#else /* !CONFIG_HAVE_FUNCTION_GRAPH_FREGS */
 SYM_CODE_START(return_to_handler)
 	/* save return value regs */
 	sub sp, sp, #FGRET_REGS_SIZE
@@ -350,4 +377,5 @@ SYM_CODE_START(return_to_handler)
 
 	ret
 SYM_CODE_END(return_to_handler)
+#endif /* CONFIG_HAVE_FUNCTION_GRAPH_FREGS */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */


