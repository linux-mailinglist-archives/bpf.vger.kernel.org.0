Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04AC3927DE
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 08:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhE0GmD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 02:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234451AbhE0Gl4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 02:41:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF85F613CC;
        Thu, 27 May 2021 06:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622097624;
        bh=KJfN3dfQ7CgYxygr2eqTq1OdnbRKmnmwZLg3RsPDjzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvmUgiThXObXnaZ1DON9V9l0PJJQnVdkOp0CrIArBUon9XndgzFYA+pfZK0RE7lP8
         +jdBGHDvECpHx20E20pcHA7PaQKICJTHvLT/YGcpZVeC+6zP6kRTpUaaN4aAMi11y2
         Uu/6gOrbQ5u0mKTa/QA4oXlU1tsb64xlA2AcrDHNa29R1/kFLnu2pm2emEWMJxakjg
         qtcRd9/hKEWu6ZmyKSnYaDFHxZbWntN8eU9c2zwAUGZx8B9Rbk2ibh/zs96wm2jFkX
         /aZljN5+buMVGPKilafwU9enoL7GykBQ3PU8SlseT0gjfVfP4P6VFgAr7L9kKjW/ZR
         coELu1vVAi0wg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip v7 08/13] arm: kprobes: Make a space for regs->ARM_pc at kretprobe_trampoline
Date:   Thu, 27 May 2021 15:40:20 +0900
Message-Id: <162209761982.436794.14123705787131288439.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162209754288.436794.3904335049560916855.stgit@devnote2>
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
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

