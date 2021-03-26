Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2003334A746
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 13:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCZMah (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 08:30:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhCZMaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 08:30:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EA6861949;
        Fri, 26 Mar 2021 12:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616761804;
        bh=KJfN3dfQ7CgYxygr2eqTq1OdnbRKmnmwZLg3RsPDjzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ax68D1BtQrD6/z9bA+GSokvG1SWwLa2EqN6G/0V7lNwLT7hKALHdYfO1afh/5qx/K
         qQ1+wr3yHsQIlRRm6wPHhcSAqwzsaPRVgWhwerCD8ucHI2+tu7zDEzYUwLN1FfqwHD
         yKDq1CqB9EdUD5UheTwnIGYHq2isU4moaBV8TiInEoBMjUYGYOFmf9fQOQZ6XOgzQL
         Vkyl8vwsDflbHGxIpoDTleJRjcUP8RbvQ27xvGCBZZudBqD94fS2bJstWx6myT9Jxq
         AswbNQtqlkiXuRccr+4GcNByJXV1pk4qzenmaalAH+ZQG9CEW4FTR0Mkz+bLrrgrbA
         7uL7dOQ+uxGuw==
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
Subject: [PATCH -tip v5 08/12] arm: kprobes: Make a space for regs->ARM_pc at kretprobe_trampoline
Date:   Fri, 26 Mar 2021 21:30:00 +0900
Message-Id: <161676180010.330141.3364405359635711987.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161676170650.330141.6214727134265514123.stgit@devnote2>
References: <161676170650.330141.6214727134265514123.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Change kretprobe_trampoline to make a space for regs->ARM_pc so that
kretprobe_trampoline_handler can call instruction_pointer_set()
safely.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm/probes/kprobes/core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 1782b41df095..5f3c2b42787f 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -397,11 +397,13 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 void __naked __kprobes kretprobe_trampoline(void)
 {
 	__asm__ __volatile__ (
+		"sub	sp, sp, #16		\n\t"
 		"stmdb	sp!, {r0 - r11}		\n\t"
 		"mov	r0, sp			\n\t"
 		"bl	trampoline_handler	\n\t"
 		"mov	lr, r0			\n\t"
 		"ldmia	sp!, {r0 - r11}		\n\t"
+		"add	sp, sp, #16		\n\t"
 #ifdef CONFIG_THUMB2_KERNEL
 		"bx	lr			\n\t"
 #else

