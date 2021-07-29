Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3C53DA5C6
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 16:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbhG2OJm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 10:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238647AbhG2OHd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 10:07:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE33D60F5C;
        Thu, 29 Jul 2021 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627567616;
        bh=ycaasLRNKeb4PrJCUm1tk0Rz6wHrs2EJsJbv1cIxaz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EWegB5VL/daZljB6yFptDSgMUcmjJ+Ut0IxnlsLjW/o7PP/Tc+XZksOe/p5wM3Bih
         49pwb/lLrAZKh5kVHSuuO3lawMlx6QtOyVl9xoEDyibSnQv1eYOv4ToIlpURox243r
         348upTkksj6r03c+iU3Gltqo6H1lwNfiUdizoMV95n8j6shO8oBvjZp9nQXxcpWwPX
         d7UV7hyuDdSNes51Q/2vH0gdoNER4qMH2ujXynvzrlyucIPqPPypeTUqG/AIdw1Wp4
         oqpGctBI9Gj+SAQqbVxi3RO6wuU1LBIblQhHXtbu9p5J30nPu+osCFPxypHH+0JO9S
         IdSZY2V+A5SZw==
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
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip v10 06/16] objtool: Add frame-pointer-specific function ignore
Date:   Thu, 29 Jul 2021 23:06:52 +0900
Message-Id: <162756761247.301564.17977809654703678605.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162756755600.301564.4957591913842010341.stgit@devnote2>
References: <162756755600.301564.4957591913842010341.stgit@devnote2>
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

