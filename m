Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC283439B1
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 07:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCVGlJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 02:41:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhCVGkq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 02:40:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB12E61937;
        Mon, 22 Mar 2021 06:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616395246;
        bh=L1amE4pN+dzCxhegh4FIiZ3BtGj/dNOZfgKXrmzrSOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmgtgkA8V5sK1N0mMfvmcKpP3Dbe1eaN6k5soNDsiU2/ImD082ZQinnz5QRG1sMu+
         z5wd77kRsu5gobaScxtkTsJpauf0Jg6IJA+yWjzmcyBCu5C32oBLftag2XXzlVX72U
         E+qfVhvB7oHAg0aJp8Tm0dIXyWZslrRVMgConAMen49rj9Bvw7y0IZtzSoHbpioVrF
         rZowZHGhnSOdNiaAm209ZSwVarpAgNxZ5QqBg3S8/sWTEj4DCHOPpiC0F86SWf0Unu
         QTtPrH33EoyuMb469Y23zx92v6HtxUudw+R+qAqJV3w1arUa+cxSxNipVeFR1txcVG
         KO2w8lWXPIayA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: [PATCH -tip v4 05/12] x86/kprobes: Add UNWIND_HINT_FUNC on kretprobe_trampoline code
Date:   Mon, 22 Mar 2021 15:40:41 +0900
Message-Id: <161639524092.895304.18260567810957090246.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161639518354.895304.15627519393073806809.stgit@devnote2>
References: <161639518354.895304.15627519393073806809.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

Add UNWIND_HINT_FUNC on kretporbe_trampoline code so that ORC
information is generated on the kretprobe_trampoline correctly.

Note that when the CONFIG_FRAME_POINTER=y, since the
kretprobe_trampoline skips updating frame pointer, the stack frame
of the kretprobe_trampoline seems non-standard. So this marks it
is STACK_FRAME_NON_STANDARD() and undefine UNWIND_HINT_FUNC.
Anyway, with the frame pointer, FP unwinder can unwind the stack
frame correctly without that hint.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v4:
  - Apply UNWIND_HINT_FUNC only if CONFIG_FRAME_POINTER=n.
---
 arch/x86/include/asm/unwind_hints.h |    5 +++++
 arch/x86/kernel/kprobes/core.c      |   17 +++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

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
index 427d648fffcd..23255663c434 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -760,6 +760,19 @@ int kprobe_int3_handler(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(kprobe_int3_handler);
 
+#ifdef CONFIG_FRAME_POINTER
+/*
+ * kretprobe_trampoline skips updating frame pointer. The frame pointer
+ * saved in trampoline_handler points to the real caller function's
+ * frame pointer. Thus the kretprobe_trampoline doesn't seems to have a
+ * standard stack frame with CONFIG_FRAME_POINTER=y.
+ * Let's mark it non-standard function. Anyway, FP unwinder can correctly
+ * unwind without the hint.
+ */
+STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
+#undef UNWIND_HINT_FUNC
+#define UNWIND_HINT_FUNC
+#endif
 /*
  * When a retprobed function returns, this code saves registers and
  * calls trampoline_handler() runs, which calls the kretprobe's handler.
@@ -772,6 +785,7 @@ asm(
 	/* We don't bother saving the ss register */
 #ifdef CONFIG_X86_64
 	"	pushq %rsp\n"
+	UNWIND_HINT_FUNC
 	"	pushfq\n"
 	SAVE_REGS_STRING
 	"	movq %rsp, %rdi\n"
@@ -782,6 +796,7 @@ asm(
 	"	popfq\n"
 #else
 	"	pushl %esp\n"
+	UNWIND_HINT_FUNC
 	"	pushfl\n"
 	SAVE_REGS_STRING
 	"	movl %esp, %eax\n"
@@ -795,8 +810,6 @@ asm(
 	".size kretprobe_trampoline, .-kretprobe_trampoline\n"
 );
 NOKPROBE_SYMBOL(kretprobe_trampoline);
-STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
-
 
 /*
  * Called from kretprobe_trampoline

