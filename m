Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD10734F856
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 07:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhCaFow (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 01:44:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233478AbhCaFok (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 01:44:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF75F619AB;
        Wed, 31 Mar 2021 05:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617169480;
        bh=3B0ZkPXCOBAuQFYAO1fQ2vSMhOLckudtbTWf+hCfgzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nh+wxpv3V4Ht3LbxCgN3CCbmkoIOI8I2U+muLmCtzinzhAv0iKfQLtiiTIfOLkZ5R
         47qO6j97C1oensgDWklQ/bTEI+wb6sXk6qlbVJ2PIU0Nh7+8dgmd6d4Hke9g5wv1RO
         0lyS9WEcFiI92hDUZQUFriqraW+VXElDUeM7dWPQ1VVFyeTOlCbb9XYaBO+qnUAoZJ
         DDJumwClNgN8FmKvbZJedsKss/Q7q1JDhrGQbHlZNk82XAkAKWI5IiaX4M+ltuOspD
         eYMPF2vJQp9t33ZpuXXUoMnbrCPqAz1JL95pb6sN9U4/Z+d+7Qbc1pGp5OVesomcJZ
         D+okqPzwYZRIg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC PATCH -tip 1/3] x86/kprobes: Add ORC information to optprobe template
Date:   Wed, 31 Mar 2021 14:44:34 +0900
Message-Id: <161716947469.721514.10958896582230159703.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161716946413.721514.4057380464113663840.stgit@devnote2>
References: <161716946413.721514.4057380464113663840.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As same as kretprobe_trampoline, move the optprobe template
code in the text for making ORC information on that.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/opt.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 4299fc865732..6d26e5cf2ba2 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -100,9 +100,13 @@ static void synthesize_set_arg1(kprobe_opcode_t *addr, unsigned long val)
 	*(unsigned long *)addr = val;
 }
 
+static void
+optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs);
+
 asm (
-			".pushsection .rodata\n"
+			".text\n"
 			"optprobe_template_func:\n"
+			".type optprobe_template_func, @function\n"
 			".global optprobe_template_entry\n"
 			"optprobe_template_entry:\n"
 #ifdef CONFIG_X86_64
@@ -120,7 +124,8 @@ asm (
 			ASM_NOP5
 			".global optprobe_template_call\n"
 			"optprobe_template_call:\n"
-			ASM_NOP5
+			/* Dummy call for ORC */
+			"	callq optimized_callback\n"
 			/* Move flags to rsp */
 			"	movq 18*8(%rsp), %rdx\n"
 			"	movq %rdx, 19*8(%rsp)\n"
@@ -141,7 +146,8 @@ asm (
 			ASM_NOP5
 			".global optprobe_template_call\n"
 			"optprobe_template_call:\n"
-			ASM_NOP5
+			/* Dummy call for ORC */
+			"	call optimized_callback\n"
 			/* Move flags into esp */
 			"	movl 14*4(%esp), %edx\n"
 			"	movl %edx, 15*4(%esp)\n"
@@ -152,10 +158,12 @@ asm (
 #endif
 			".global optprobe_template_end\n"
 			"optprobe_template_end:\n"
-			".popsection\n");
+			/* Dummy return for objtool */
+			"	ret\n"
+			".size optprobe_template_func, .-optprobe_template_func\n"
+);
 
 void optprobe_template_func(void);
-STACK_FRAME_NON_STANDARD(optprobe_template_func);
 
 #define TMPL_CLAC_IDX \
 	((long)optprobe_template_clac - (long)optprobe_template_entry)

