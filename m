Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4040B1A0
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 16:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbhINOng (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 10:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234299AbhINOmg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:42:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 315A761107;
        Tue, 14 Sep 2021 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630477;
        bh=ycaasLRNKeb4PrJCUm1tk0Rz6wHrs2EJsJbv1cIxaz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2/jYfcXXtOvHiN1w9cVkLFItB/sxD4wBMXcJ3Rx449BhYcrkBxsEbBJQv++3CwOY
         Esxv6m0IZ+Zf8lJfPQq16gGK0pLFqu6HtugCvYAH075CR/RqZQh+XJxqc7dllTGtSY
         /Y14sUOuNP1PN0a5mqqC+0NjXmi9Sobq7ie/UW04qJJn6vhWGD+Plo9NtHGsWzTw5a
         K5hP5AktYpW9ecur7hNP0jX2AxXyrPm9nM+bBI6yKBZj3mhhAHZ6bet6os+q8xlXJW
         xgpMfOUGmi6oBoPeHmpuevZjsJC0YRi6a6hYZEIR236nFKvCP1yAG9mi3fs6kxcYaT
         NGV4csZTMRykQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: [PATCH -tip v11 17/27] objtool: Add frame-pointer-specific function ignore
Date:   Tue, 14 Sep 2021 23:41:13 +0900
Message-Id: <163163047364.489837.17377799909553689661.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163163030719.489837.2236069935502195491.stgit@devnote2>
References: <163163030719.489837.2236069935502195491.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

Add a CONFIG_FRAME_POINTER-specific version of
STACK_FRAME_NON_STANDARD() for the case where a function is
intentionally missing frame pointer setup, but otherwise needs
objtool/ORC coverage when frame pointers are disabled.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v10:
  - Fixes error in CONFIG_STACK_VALIDATION=n case.
---
 include/linux/objtool.h       |   12 ++++++++++++
 tools/include/linux/objtool.h |   12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 7e72d975cb76..aca52db2f3f3 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -66,6 +66,17 @@ struct unwind_hint {
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+/*
+ * STACK_FRAME_NON_STANDARD_FP() is a frame-pointer-specific function ignore
+ * for the case where a function is intentionally missing frame pointer setup,
+ * but otherwise needs objtool/ORC coverage when frame pointers are disabled.
+ */
+#ifdef CONFIG_FRAME_POINTER
+#define STACK_FRAME_NON_STANDARD_FP(func) STACK_FRAME_NON_STANDARD(func)
+#else
+#define STACK_FRAME_NON_STANDARD_FP(func)
+#endif
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -127,6 +138,7 @@ struct unwind_hint {
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
+#define STACK_FRAME_NON_STANDARD_FP(func)
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 7e72d975cb76..aca52db2f3f3 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -66,6 +66,17 @@ struct unwind_hint {
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+/*
+ * STACK_FRAME_NON_STANDARD_FP() is a frame-pointer-specific function ignore
+ * for the case where a function is intentionally missing frame pointer setup,
+ * but otherwise needs objtool/ORC coverage when frame pointers are disabled.
+ */
+#ifdef CONFIG_FRAME_POINTER
+#define STACK_FRAME_NON_STANDARD_FP(func) STACK_FRAME_NON_STANDARD(func)
+#else
+#define STACK_FRAME_NON_STANDARD_FP(func)
+#endif
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -127,6 +138,7 @@ struct unwind_hint {
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
+#define STACK_FRAME_NON_STANDARD_FP(func)
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0

