Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2713C3CEF
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 15:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhGKNig (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Jul 2021 09:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232793AbhGKNig (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Jul 2021 09:38:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6C7761245;
        Sun, 11 Jul 2021 13:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626010549;
        bh=Rdr5qCe1gNFYBhdSCbvzhAs4VdI1+Mgp+bv4Bzlp+MA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5R6TM0y3tqwruT9FNhCHqEQcpIpUA671S+D6ocqURgLBnEG2X+LW0c7WiV9XEass
         kyRnOQZ88E/Cls3f6v9fNdtdBWB1CVj4of4kTpPpxCDLdKlqezthO91pi4tcf5hM60
         tcGYB6GSdJNW7g3Q2Juivap6ndP42TVsY5UbEwiSrjUqhHGZ7rrT6yEY+OiFZZZdB+
         v9NghWWJW+jOEYa9iJQ0zUROGfHogM9BG05aT95s56tMJPNgHI8ECMO+lUWQHGIh2G
         uzxk8KYYWQ941bfyR2LVwwxObSIg0EQj63AR9wyfLmaRMBRwJ/8ZYWlu20Fo9Ga7xc
         6EBzAhw8RCg3w==
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
Subject: [PATCH -tip v9 06/14] x86/kprobes: Add UNWIND_HINT_FUNC on kretprobe_trampoline()
Date:   Sun, 11 Jul 2021 22:35:46 +0900
Message-Id: <162601054601.1318837.6067145827088507621.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162601048053.1318837.1550594515476777588.stgit@devnote2>
References: <162601048053.1318837.1550594515476777588.stgit@devnote2>
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

