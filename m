Return-Path: <bpf+bounces-7133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3EB771AB3
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 08:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF051C2099B
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 06:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645B717F7;
	Mon,  7 Aug 2023 06:48:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2F02106
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 06:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7DDC433C7;
	Mon,  7 Aug 2023 06:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691390933;
	bh=5Wat1ZN9LgqYvlI6WEEnwpes5oBMUfxBgWSRXiQLnnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hP/8bBicWbi8v+hSGI+k4BO2VcLNAotrk4dOJVMcab817b0zRzX8ypsqYLRHJvw7N
	 YO5nrEEe6iHYBxxWCwI06qGbcGuRbU9ZQZN3XHtF0kO0a3Fhamq8F1FcCXoTlAFIHz
	 tKujFeyRbmGt1bYF28QMbBFASfdf6cJaGFAJ/8FHoXZBL20SpO3+Cd/WINNVRJrudF
	 gOdWqXERv5b27aNjbSQlrf+plT8X69i9oHgC8SgsIfZLXx1yKxHdUw+GBc5m1upmHT
	 7YM2kwz6rHs0O593GxtXHM+55P47G9bbS/uqrV+I2PsAok5p7I0VXPhoKUapsFddOZ
	 EGntGjnWBk7Ow==
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
Subject: [RFC PATCH v2 2/6] tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
Date: Mon,  7 Aug 2023 15:48:47 +0900
Message-Id: <169139092722.324433.16681957760325391475.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169139090386.324433.6412259486776991296.stgit@devnote2>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
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
 include/linux/ftrace.h |   45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ce156c7704ee..3fb94a1a2461 100644
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
+ * If the architecture doesn't support FTRACE_WITH_ARGS or disable function
+ * tracer, define the default(pt_regs compatible) ftrace_regs.
+ */
+#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || !defined(CONFIG_FUNCTION_TRACER)
 
 struct ftrace_regs {
 	struct pt_regs		regs;
@@ -129,6 +129,22 @@ struct ftrace_regs {
  * HAVE_DYNAMIC_FTRACE_WITH_ARGS is set and it supports live kernel patching.
  */
 #define ftrace_regs_set_instruction_pointer(fregs, ip) do { } while (0)
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
 #endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
 
 static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
@@ -151,22 +167,9 @@ static __always_inline bool ftrace_regs_has_args(struct ftrace_regs *fregs)
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


