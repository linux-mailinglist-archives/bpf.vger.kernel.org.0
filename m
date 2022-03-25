Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE394E7500
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 15:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245473AbiCYOZ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 10:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359350AbiCYOZZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 10:25:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2242E9C8;
        Fri, 25 Mar 2022 07:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E22361B54;
        Fri, 25 Mar 2022 14:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3EBC340E9;
        Fri, 25 Mar 2022 14:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648218223;
        bh=GPBnrR38vldcM8pzwaRlh5Fu/HDIL2hc4on8+T36Er8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EAAhFGkhi1aX7fVJg/Bib2z5DjRp+ujnvhI0mqyoJK5rtNf6oOHxZjlqRCsIl9jQq
         eh/ri5oEnker+VUfn3+nod5blYUqRHXzuuG0Z1z9RGXu06B4a0tvA8yDN3oONXF/bw
         7Q2uszm0uAu5Culp8xJUxDTGsbTJ7+xa4QTNkGx+Bjo+MqphS3RZr+r3K7d53Y+UhW
         1S4uVHxl4AP2wVFbSQSJO7qpUZdl6ItlNeDnC0o6z7T/71zJx3o5/ZXxcBVGwTQfMS
         W41H5UwdIgCS2T9g8h9/bXyH/gzqFjQOChijAcZ7x86TieweoOQ5DaEwshfcPc8G23
         zcYY8gspMVICw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 4/4] x86,kprobes: Fix optprobe trampoline to generate complete pt_regs
Date:   Fri, 25 Mar 2022 23:23:38 +0900
Message-Id: <164821821812.2373735.10590204580147294378.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164821817332.2373735.12048266953420821089.stgit@devnote2>
References: <164821817332.2373735.12048266953420821089.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently the optprobe trampoline template code ganerate an
almost complete pt_regs on-stack, everything except regs->ss.
The 'regs->ss' points to the top of stack, which is not a
valid segment decriptor.

As same as the rethook does, complete the job by also pushing ss.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/opt.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index b4a54a52aa59..e6b8c5362b94 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -106,7 +106,8 @@ asm (
 			".global optprobe_template_entry\n"
 			"optprobe_template_entry:\n"
 #ifdef CONFIG_X86_64
-			/* We don't bother saving the ss register */
+			"       pushq $" __stringify(__KERNEL_DS) "\n"
+			/* Save the 'sp - 8', this will be fixed later. */
 			"	pushq %rsp\n"
 			"	pushfq\n"
 			".global optprobe_template_clac\n"
@@ -121,14 +122,17 @@ asm (
 			".global optprobe_template_call\n"
 			"optprobe_template_call:\n"
 			ASM_NOP5
-			/* Move flags to rsp */
+			/* Copy 'regs->flags' into 'regs->ss'. */
 			"	movq 18*8(%rsp), %rdx\n"
-			"	movq %rdx, 19*8(%rsp)\n"
+			"	movq %rdx, 20*8(%rsp)\n"
 			RESTORE_REGS_STRING
-			/* Skip flags entry */
-			"	addq $8, %rsp\n"
+			/* Skip 'regs->flags' and 'regs->sp'. */
+			"	addq $16, %rsp\n"
+			/* And pop flags register from 'regs->ss'. */
 			"	popfq\n"
 #else /* CONFIG_X86_32 */
+			"	pushl %ss\n"
+			/* Save the 'sp - 4', this will be fixed later. */
 			"	pushl %esp\n"
 			"	pushfl\n"
 			".global optprobe_template_clac\n"
@@ -142,12 +146,13 @@ asm (
 			".global optprobe_template_call\n"
 			"optprobe_template_call:\n"
 			ASM_NOP5
-			/* Move flags into esp */
+			/* Copy 'regs->flags' into 'regs->ss'. */
 			"	movl 14*4(%esp), %edx\n"
-			"	movl %edx, 15*4(%esp)\n"
+			"	movl %edx, 16*4(%esp)\n"
 			RESTORE_REGS_STRING
-			/* Skip flags entry */
-			"	addl $4, %esp\n"
+			/* Skip 'regs->flags' and 'regs->sp'. */
+			"	addl $8, %esp\n"
+			/* And pop flags register from 'regs->ss'. */
 			"	popfl\n"
 #endif
 			".global optprobe_template_end\n"
@@ -179,6 +184,8 @@ optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
 		kprobes_inc_nmissed_count(&op->kp);
 	} else {
 		struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+		/* Adjust stack pointer */
+		regs->sp += sizeof(long);
 		/* Save skipped registers */
 		regs->cs = __KERNEL_CS;
 #ifdef CONFIG_X86_32

