Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF077341CC0
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 13:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhCSMWu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 08:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhCSMWo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 08:22:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD0D56146D;
        Fri, 19 Mar 2021 12:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616156564;
        bh=ukedJXvpQTbwD5ndIACI9Ikh1mH7iQqGENUZObVcIwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQXlPgdGSdAwo/qrfXPCoR+3vURgm8A00MpzX042Oe1kgE4C1KtRI9DjAOTXpVqgM
         Ih3jwfoF6KheL/9Yf0aOVO5R3NgekjdZXSKntZmAKXcKL09fsVboSILwYo0hfVTvzT
         BSgzwB1Co8Xhki8hc0e2o3uNfOu/VpqQx64P0Guzx+rU1Izm4yUBm3lsOykOUvEgOl
         iBNNl4q3d0n3KjgBVZFhCzfeqgnv4xG7NBMG/IyYNV2zyWV5ZyEYWUAXLzvXuc5edA
         gsyar+YXWUZCuNhfnBPJ+WrRdGj/sm/m9MjfMIVFyUdJpA15lvUGkFrmQErSma4v7O
         xEA0SbYZdiRlQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org
Subject: [PATCH -tip v3 05/11] x86/kprobes: Add UNWIND_HINT_FUNC on kretprobe_trampoline code
Date:   Fri, 19 Mar 2021 21:22:39 +0900
Message-Id: <161615655969.306069.4545805781593088526.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161615650355.306069.17260992641363840330.stgit@devnote2>
References: <161615650355.306069.17260992641363840330.stgit@devnote2>
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

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 [MH] Add patch description.
---
 arch/x86/include/asm/unwind_hints.h |    5 +++++
 arch/x86/kernel/kprobes/core.c      |    3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

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
index 427d648fffcd..b31058a152b6 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -772,6 +772,7 @@ asm(
 	/* We don't bother saving the ss register */
 #ifdef CONFIG_X86_64
 	"	pushq %rsp\n"
+	UNWIND_HINT_FUNC
 	"	pushfq\n"
 	SAVE_REGS_STRING
 	"	movq %rsp, %rdi\n"
@@ -782,6 +783,7 @@ asm(
 	"	popfq\n"
 #else
 	"	pushl %esp\n"
+	UNWIND_HINT_FUNC
 	"	pushfl\n"
 	SAVE_REGS_STRING
 	"	movl %esp, %eax\n"
@@ -795,7 +797,6 @@ asm(
 	".size kretprobe_trampoline, .-kretprobe_trampoline\n"
 );
 NOKPROBE_SYMBOL(kretprobe_trampoline);
-STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
 
 
 /*

