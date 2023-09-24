Return-Path: <bpf+bounces-10716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C797AC9AF
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 15:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id D992CB209C7
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2F8CA53;
	Sun, 24 Sep 2023 13:36:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F36ADE;
	Sun, 24 Sep 2023 13:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DC8C433C7;
	Sun, 24 Sep 2023 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695562614;
	bh=jmHWZoJzNc7w2WNK0aSXMKcROawBX8r9FSb7vj/g9k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQRxpZ9URRHAkZC5HdJ8I8W4mys6wynoEVlftisU26BNvb9oiXK0Ro0PXYd9qLB2l
	 UL3C0Oy+xI57Izrd/yxuWzsvG4CXpOxOGRD78wJxDt02xtJijhUFSWR7QcUorUwFdx
	 O5hf0wkh9BjAh382ei6TnpnBPotUpzDvkt+JUKJwJnCdDi+nKlNZVymAvIk54keZYY
	 BW4+MqOrdmXmTAfaZXd8nd359ake5zpaQynZsXrSQENdGQz9VryIndwLRoYQVqp8+n
	 R/DUZZZ+mgL/oGSxsVqdK92HPyXr6YtPOR6dFKfl+Ty7MWFdnNNnzqBRbH37eg1mOI
	 eDmk2HLeM2faQ==
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
Subject: [PATCH v5 05/12] tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
Date: Sun, 24 Sep 2023 22:36:48 +0900
Message-Id: <169556260811.146934.12334081780807613682.stgit@devnote2>
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

In order to be able to use ftrace_regs even from features unrelated to
function tracer (e.g. kretprobe), expose ftrace_regs structures and
APIs even if the CONFIG_FUNCTION_TRACER=n.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Florent Revest <revest@chromium.org>
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
index 5a82b08f03cd..6de3bf4d0092 100644
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
@@ -97,6 +99,8 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 #define ftrace_regs_query_register_offset(name) \
 	regs_query_register_offset(name)
 
+#endif /* CONFIG_FUNCTION_TRACER */
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /*
  * When an ftrace registered caller is tracing a function that is
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 5da70f238645..15f4865a4083 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -112,11 +112,11 @@ static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *val
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
 
 /*
  * The ftrace_regs will be just a wrapper of the pt_regs if
@@ -131,13 +131,33 @@ struct ftrace_regs {
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
@@ -159,22 +179,9 @@ static __always_inline bool ftrace_regs_has_args(struct ftrace_regs *fregs)
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


