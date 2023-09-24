Return-Path: <bpf+bounces-10712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ED57AC99D
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 15:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5D2ED28167A
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80827C8F3;
	Sun, 24 Sep 2023 13:36:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F549C8CC;
	Sun, 24 Sep 2023 13:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1710AC433C8;
	Sun, 24 Sep 2023 13:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695562565;
	bh=LhYnyuDASlXkoXmwCgKG/bRCaq518SQW1Kv1bqMglGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oqIRRymLElY+P25kTdNjEVyJB1A9ldCYTxgORJ2fY34/Up+1xmNu/blxLvgvO5d9v
	 YiLVnE8f+DqJ9TRtFd+qISOHrQMIzP3no7VHIYYfltA8O88TF9oWSzN1loDL1H8+Av
	 y2pog5Q99aZxCYiO+eGs+EcZEK5QCFRKxQ1H0BoMXnKzdM7ZmuvT++GsX3E5aZ6zkP
	 RcNxCFEkV5UQYuJsW4OtyYkLV7KQiGlqwJLrJvlkTB1UERoEbXgseOI6XFhvKBFitR
	 O+Q57mxrGf5S2tiOPkc0LYv4MVrdrsoBejfM774lHvH+n9ZtLBCoy5+6jnf/Ar9sx+
	 WlJQquCgwUxMg==
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
Subject: [PATCH v5 01/12] riscv: ftrace: Fix to pass correct ftrace_regs to ftrace_func_t functions
Date: Sun, 24 Sep 2023 22:35:59 +0900
Message-Id: <169556255915.146934.16583650430641758878.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169556254640.146934.5654329452696494756.stgit@devnote2>
References: <169556254640.146934.5654329452696494756.stgit@devnote2>
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

Since ftrace_func_t requires to pass 'struct ftrace_regs *' as the 4th
argument even if FTRACE_OPS_FL_SAVE_REGS is not set, ftrace_caller must
pass 'struct ftrace_regs *', which is a partial pt_regs, on the stack
to the ftrace_func_t functions, so that the ftrace_func_t functions can
access some partial registers.

Fix to allocate 'struct ftrace_regs' (which has the same size of 'struct
pt_regs') on the stack and save partial (argument) registers on it
instead of reduced size custom data structure.

Fixes: afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/riscv/kernel/mcount-dyn.S |   65 +++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 669b8697aa38..84963680eff4 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -14,46 +14,37 @@
 	.text
 
 #define FENTRY_RA_OFFSET	8
-#define ABI_SIZE_ON_STACK	80
-#define ABI_A0			0
-#define ABI_A1			8
-#define ABI_A2			16
-#define ABI_A3			24
-#define ABI_A4			32
-#define ABI_A5			40
-#define ABI_A6			48
-#define ABI_A7			56
-#define ABI_T0			64
-#define ABI_RA			72
 
 	.macro SAVE_ABI
-	addi	sp, sp, -ABI_SIZE_ON_STACK
-
-	REG_S	a0, ABI_A0(sp)
-	REG_S	a1, ABI_A1(sp)
-	REG_S	a2, ABI_A2(sp)
-	REG_S	a3, ABI_A3(sp)
-	REG_S	a4, ABI_A4(sp)
-	REG_S	a5, ABI_A5(sp)
-	REG_S	a6, ABI_A6(sp)
-	REG_S	a7, ABI_A7(sp)
-	REG_S	t0, ABI_T0(sp)
-	REG_S	ra, ABI_RA(sp)
+	addi	sp, sp, -PT_SIZE_ON_STACK
+
+	/* Save t0 as epc for ftrace_regs_get_instruction_pointer() */
+	REG_S	t0, PT_EPC(sp)
+	REG_S	a0, PT_A0(sp)
+	REG_S	a1, PT_A1(sp)
+	REG_S	a2, PT_A2(sp)
+	REG_S	a3, PT_A3(sp)
+	REG_S	a4, PT_A4(sp)
+	REG_S	a5, PT_A5(sp)
+	REG_S	a6, PT_A6(sp)
+	REG_S	a7, PT_A7(sp)
+	REG_S	t0, PT_T0(sp)
+	REG_S	ra, PT_RA(sp)
 	.endm
 
 	.macro RESTORE_ABI
-	REG_L	a0, ABI_A0(sp)
-	REG_L	a1, ABI_A1(sp)
-	REG_L	a2, ABI_A2(sp)
-	REG_L	a3, ABI_A3(sp)
-	REG_L	a4, ABI_A4(sp)
-	REG_L	a5, ABI_A5(sp)
-	REG_L	a6, ABI_A6(sp)
-	REG_L	a7, ABI_A7(sp)
-	REG_L	t0, ABI_T0(sp)
-	REG_L	ra, ABI_RA(sp)
-
-	addi	sp, sp, ABI_SIZE_ON_STACK
+	REG_L	a0, PT_A0(sp)
+	REG_L	a1, PT_A1(sp)
+	REG_L	a2, PT_A2(sp)
+	REG_L	a3, PT_A3(sp)
+	REG_L	a4, PT_A4(sp)
+	REG_L	a5, PT_A5(sp)
+	REG_L	a6, PT_A6(sp)
+	REG_L	a7, PT_A7(sp)
+	REG_L	t0, PT_T0(sp)
+	REG_L	ra, PT_RA(sp)
+
+	addi	sp, sp, PT_SIZE_ON_STACK
 	.endm
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
@@ -96,8 +87,8 @@ ftrace_call:
 	call	ftrace_stub
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	addi	a0, sp, ABI_RA
-	REG_L	a1, ABI_T0(sp)
+	addi	a0, sp, PT_RA
+	REG_L	a1, PT_T0(sp)
 	addi	a1, a1, -FENTRY_RA_OFFSET
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	mv	a2, s0


