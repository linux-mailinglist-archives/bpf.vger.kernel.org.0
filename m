Return-Path: <bpf+bounces-15926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 213AD7FA1B8
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 14:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8225B2129B
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABB830676;
	Mon, 27 Nov 2023 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhIzkEBU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631182FE12;
	Mon, 27 Nov 2023 13:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFFBC433CB;
	Mon, 27 Nov 2023 13:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701093454;
	bh=XgejxEeSUCgC78mdpML2P/NZltFSt+DFPHLOkxfE4cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AhIzkEBUjsZmIX7dBCEzhF6+8hcCIffZrHxn4j0PEX6cacO0NeiAE0mrJzYrloJcc
	 YX0S1gxD6Y+Vux81EMxp99RHo6nG1X/78Zhli8DrYQDhEki3Oo2l0KnS2yD1NJDhmI
	 kgDgWxM1sMONq3aMX2mEmd+5DkgHJHJYFiVg7tgdttcV3sIQyY8qXALxZNhVbp6DCV
	 SbgVOkTNKG/epk0nSgIsp5pIQ0I+H7nVZqsYbHuOMhOgX3MOR4aQKmLmlF6zVQe3JP
	 AAjvIqyu2srbtBOBDb0LfTRi0SU30j50yeTHUP/e/pPNiCrFfvyV2IZYZZjRLIw/45
	 kUSThxUX2jnFA==
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
Subject: [PATCH v3 22/33] tracing: Rename ftrace_regs_return_value to ftrace_regs_get_return_value
Date: Mon, 27 Nov 2023 22:57:27 +0900
Message-Id: <170109344719.343914.7390510141635028198.stgit@devnote2>
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

Rename ftrace_regs_return_value to ftrace_regs_get_return_value as same as
other ftrace_regs_get/set_* APIs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Newly added.
---
 arch/loongarch/include/asm/ftrace.h |    2 +-
 arch/powerpc/include/asm/ftrace.h   |    2 +-
 arch/s390/include/asm/ftrace.h      |    2 +-
 arch/x86/include/asm/ftrace.h       |    2 +-
 include/linux/ftrace.h              |    2 +-
 kernel/trace/fgraph.c               |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index a11996eb5892..a9c3d0f2f941 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -70,7 +70,7 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs, unsigned long ip)
 	regs_get_kernel_argument(&(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&(fregs)->regs, ret)
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 9e5a39b6a311..7e138e0e3baf 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -69,7 +69,7 @@ ftrace_regs_get_instruction_pointer(struct ftrace_regs *fregs)
 	regs_get_kernel_argument(&(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&(fregs)->regs, ret)
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 5a82b08f03cd..01e775c98425 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -88,7 +88,7 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 	regs_get_kernel_argument(&(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&(fregs)->regs, ret)
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 0b306c82855d..a061f8832b20 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -64,7 +64,7 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 	regs_get_kernel_argument(&(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&(fregs)->regs, ret)
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 79875a00c02b..da2a23f5a9ed 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -187,7 +187,7 @@ static __always_inline bool ftrace_regs_has_args(struct ftrace_regs *fregs)
 	regs_get_kernel_argument(ftrace_get_regs(fregs), n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(ftrace_get_regs(fregs))
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(ftrace_get_regs(fregs))
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(ftrace_get_regs(fregs), ret)
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 6faf04740908..d1740f990ce7 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -754,7 +754,7 @@ static void fgraph_call_retfunc(struct ftrace_regs *fregs,
 	trace.rettime = trace_clock_local();
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	if (fregs)
-		trace.retval = ftrace_regs_return_value(fregs);
+		trace.retval = ftrace_regs_get_return_value(fregs);
 	else
 		trace.retval = fgraph_ret_regs_return_value(ret_regs);
 #endif


