Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123A240B1A3
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 16:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhINOnh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 10:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234420AbhINOmx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:42:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E254F603E8;
        Tue, 14 Sep 2021 14:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630496;
        bh=Rdr5qCe1gNFYBhdSCbvzhAs4VdI1+Mgp+bv4Bzlp+MA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vHG+giDP/dbUyac5wxc/wk2mx/ILtd1Htz1XmZB6NiW73iFZjLUoWsEP0hiJl2iPk
         eggeks+/ndGy5u9EglW237kI/e2TRDxpzjOdYUqTLNC93CzVJs0hLtXAaee9ScMcIE
         59ijkYdFS9xo3/79kCaR4DVycu9TDbFFpOp5IjK5YN/HysIXj5j2kGEIaQyKujTJaS
         43Xz2KVo0m5PuNJJuhOLV6fqvXtnE/JgDniwFkHEq/30j5a6xzJnn/IOgrJP+VlBD1
         4rP5LlmjMQSIztoUY3aw+Zf5wMCs8BmM2/lz6tTsef5c8O70nBjerXB31dQJp9ESrN
         4Bw+j8nEj0FPg==
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
Subject: [PATCH -tip v11 19/27] x86/kprobes: Add UNWIND_HINT_FUNC on kretprobe_trampoline()
Date:   Tue, 14 Sep 2021 23:41:32 +0900
Message-Id: <163163049242.489837.11970969750993364293.stgit@devnote2>
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

Add UNWIND_HINT_FUNC on __kretprobe_trampoline() code so that ORC
information is generated on the __kretprobe_trampoline() correctly.
Also, this uses STACK_FRAME_NON_STANDARD_FP(), CONFIG_FRAME_POINTER-
-specific version of STACK_FRAME_NON_STANDARD().

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org>
---
 Changes in v9:
  - Update changelog and fix comment.
  - Use STACK_FRAME_NON_STANDARD_FP().
 Changes in v4:
  - Apply UNWIND_HINT_FUNC only if CONFIG_FRAME_POINTER=n.
---
 arch/x86/include/asm/unwind_hints.h |    5 +++++
 arch/x86/kernel/kprobes/core.c      |   13 +++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index 8e574c0afef8..8b33674288ea 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -52,6 +52,11 @@
 	UNWIND_HINT sp_reg=ORC_REG_SP sp_offset=8 type=UNWIND_HINT_TYPE_FUNC
 .endm
 
+#else
+
+#define UNWIND_HINT_FUNC \
+	UNWIND_HINT(ORC_REG_SP, 8, UNWIND_HINT_TYPE_FUNC, 0)
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_UNWIND_HINTS_H */
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 79cd23dba5b5..d1436d7463fd 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1025,6 +1025,7 @@ asm(
 	/* We don't bother saving the ss register */
 #ifdef CONFIG_X86_64
 	"	pushq %rsp\n"
+	UNWIND_HINT_FUNC
 	"	pushfq\n"
 	SAVE_REGS_STRING
 	"	movq %rsp, %rdi\n"
@@ -1035,6 +1036,7 @@ asm(
 	"	popfq\n"
 #else
 	"	pushl %esp\n"
+	UNWIND_HINT_FUNC
 	"	pushfl\n"
 	SAVE_REGS_STRING
 	"	movl %esp, %eax\n"
@@ -1048,8 +1050,15 @@ asm(
 	".size __kretprobe_trampoline, .-__kretprobe_trampoline\n"
 );
 NOKPROBE_SYMBOL(__kretprobe_trampoline);
-STACK_FRAME_NON_STANDARD(__kretprobe_trampoline);
-
+/*
+ * __kretprobe_trampoline() skips updating frame pointer. The frame pointer
+ * saved in trampoline_handler() points to the real caller function's
+ * frame pointer. Thus the __kretprobe_trampoline() doesn't have a
+ * standard stack frame with CONFIG_FRAME_POINTER=y.
+ * Let's mark it non-standard function. Anyway, FP unwinder can correctly
+ * unwind without the hint.
+ */
+STACK_FRAME_NON_STANDARD_FP(__kretprobe_trampoline);
 
 /*
  * Called from __kretprobe_trampoline

