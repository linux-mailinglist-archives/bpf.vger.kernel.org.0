Return-Path: <bpf+bounces-7638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EABBF779D46
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 07:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45672819CA
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 05:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62A6185F;
	Sat, 12 Aug 2023 05:37:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639381CCAF
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 05:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11119C433C7;
	Sat, 12 Aug 2023 05:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691818637;
	bh=idoIszjUW0P8tm6vGK/1+jb2ZV7Bg8zd/p0KkM3vUyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8QpAqBUkuiM8RM10CjO0bt6F+snrisBlXE96ECG4iI7Sklb0ivWpTnhtT34R4+mJ
	 O9GxVbEbXVSDQQnr7kMWSewhwrvuBaNn3hM4qhlsIScmNC9B8hkH3X9N3OrVcFQ4aS
	 PcJTEabk6rqtNWjvZMDa42EQ+NiKF3C+YPrZlYKaxx1zWWvZTE6nbYg43ULi5GOgQB
	 mFUMdD94N66E7kutMiEt4xzugICbCWFsE5r32PgDcj0p88k7EUIdFP6/BWEd0stHvB
	 m6BcyjWwM3EUT70bOuy0v4Ir1zV2pBKGpL6NLmxOzbFVkEL4E3BOZYreaVyBUm2PyR
	 ZA0NJRoP2bkNw==
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
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 3/8] tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
Date: Sat, 12 Aug 2023 14:37:11 +0900
Message-Id: <169181863118.505132.13233554057378608176.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169181859570.505132.10136520092011157898.stgit@devnote2>
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
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

In order to be able to use ftrace_regs even from features unrelated to
function tracer (e.g. kretprobe), expose ftrace_regs structures and
APIs even if the CONFIG_FUNCTION_TRACER=n.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - arch/s390/include/asm/ftrace.h: hide ftrace_regs parts if
    CONFIG_FUNCTION_TRACER=n to avoid conflict.
  - Fixed typo.
  - Define accessor macros only if HAVE_REGS_AND_STACK_ACCESS_API=y
---
 arch/s390/include/asm/ftrace.h |    4 +++
 include/linux/ftrace.h         |   51 +++++++++++++++++++++++-----------------
 2 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index e5c5cb1207e2..74cd2e8bf660 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -41,6 +41,8 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
+#ifdef CONFIG_FUNCTION_TRACER
+
 struct ftrace_regs {
 	struct pt_regs regs;
 };
@@ -80,6 +82,8 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 #define ftrace_regs_query_register_offset(name) \
 	regs_query_register_offset(name)
 
+#endif /* CONFIG_FUNCTION_TRACER */
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /*
  * When an ftrace registered caller is tracing a function that is
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index aad9cf8876b5..fe335d861f08 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -112,24 +112,44 @@ static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *val
 }
 #endif
 
-#ifdef CONFIG_FUNCTION_TRACER
-
-extern int ftrace_enabled;
-
-#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+/*
+ * If the architecture doesn't support FTRACE_WITH_ARGS or disables function
+ * tracer, define the default(pt_regs compatible) ftrace_regs.
+ */
+#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || !defined(CONFIG_FUNCTION_TRACER)
 
 struct ftrace_regs {
 	struct pt_regs		regs;
 };
 #define arch_ftrace_get_regs(fregs) (&(fregs)->regs)
 
+#ifdef CONFIG_HAVE_REGS_AND_STACK_ACCESS_API
+
 /*
  * ftrace_regs_set_instruction_pointer() is to be defined by the architecture
  * if to allow setting of the instruction pointer from the ftrace_regs when
  * HAVE_DYNAMIC_FTRACE_WITH_ARGS is set and it supports live kernel patching.
  */
 #define ftrace_regs_set_instruction_pointer(fregs, ip) do { } while (0)
-#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
+
+#define ftrace_regs_get_instruction_pointer(fregs) \
+	instruction_pointer(ftrace_get_regs(fregs))
+#define ftrace_regs_get_argument(fregs, n) \
+	regs_get_kernel_argument(ftrace_get_regs(fregs), n)
+#define ftrace_regs_get_stack_pointer(fregs) \
+	kernel_stack_pointer(ftrace_get_regs(fregs))
+#define ftrace_regs_return_value(fregs) \
+	regs_return_value(ftrace_get_regs(fregs))
+#define ftrace_regs_set_return_value(fregs, ret) \
+	regs_set_return_value(ftrace_get_regs(fregs), ret)
+#define ftrace_override_function_with_return(fregs) \
+	override_function_with_return(ftrace_get_regs(fregs))
+#define ftrace_regs_query_register_offset(name) \
+	regs_query_register_offset(name)
+
+#endif /* CONFIG_HAVE_REGS_AND_STACK_ACCESS_API */
+
+#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || !CONFIG_FUNCTION_TRACER */
 
 static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
 {
@@ -151,22 +171,9 @@ static __always_inline bool ftrace_regs_has_args(struct ftrace_regs *fregs)
 	return ftrace_get_regs(fregs) != NULL;
 }
 
-#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
-#define ftrace_regs_get_instruction_pointer(fregs) \
-	instruction_pointer(ftrace_get_regs(fregs))
-#define ftrace_regs_get_argument(fregs, n) \
-	regs_get_kernel_argument(ftrace_get_regs(fregs), n)
-#define ftrace_regs_get_stack_pointer(fregs) \
-	kernel_stack_pointer(ftrace_get_regs(fregs))
-#define ftrace_regs_return_value(fregs) \
-	regs_return_value(ftrace_get_regs(fregs))
-#define ftrace_regs_set_return_value(fregs, ret) \
-	regs_set_return_value(ftrace_get_regs(fregs), ret)
-#define ftrace_override_function_with_return(fregs) \
-	override_function_with_return(ftrace_get_regs(fregs))
-#define ftrace_regs_query_register_offset(name) \
-	regs_query_register_offset(name)
-#endif
+#ifdef CONFIG_FUNCTION_TRACER
+
+extern int ftrace_enabled;
 
 typedef void (*ftrace_func_t)(unsigned long ip, unsigned long parent_ip,
 			      struct ftrace_ops *op, struct ftrace_regs *fregs);


