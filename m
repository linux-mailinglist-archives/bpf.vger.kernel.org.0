Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4FA3439BD
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 07:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCVGln (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 02:41:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230240AbhCVGlY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 02:41:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0ECCC6196C;
        Mon, 22 Mar 2021 06:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616395284;
        bh=KJfN3dfQ7CgYxygr2eqTq1OdnbRKmnmwZLg3RsPDjzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mmfjAiI7wmAMav4vBnCNXWv0yelH9DCetohOtfWYdq3RGLIzHe0oTpW4DjYYN0Mzg
         UCSG6dg5F8FZgMREHg06LMv41J0AsGHT/ZNiIL6SdaT+4JtSJsEOAme704X8vbjnmS
         zSJF+ICv4zzZrdb/0kaL9hDy/6hrk4rXFIbtk6PkNzcCmMTJBvITEjpiHtd9lJ6wkA
         Q+01YmznXNxcttO11s0c83J/cySg+ZBV72U+QCdxVQhZIhBURTs7R81vWt7RccPmFP
         RIkZRrGs04FD9GAS/37CpKAtxnUm63QoDuJgYLdYCMCMqqpBMMzXDUrC5vyVnPkkpf
         0R3JNl5lbtskQ==
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
Subject: [PATCH -tip v4 08/12] arm: kprobes: Make a space for regs->ARM_pc at kretprobe_trampoline
Date:   Mon, 22 Mar 2021 15:41:18 +0900
Message-Id: <161639527851.895304.14313883616251450754.stgit@devnote2>
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

