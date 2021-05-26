Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAF63911DF
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 10:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhEZIFH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 04:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233182AbhEZIFG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 04:05:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18DCF613E6;
        Wed, 26 May 2021 08:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622016215;
        bh=KJfN3dfQ7CgYxygr2eqTq1OdnbRKmnmwZLg3RsPDjzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kkbZNFAlElCzi6LGQjjUJQU/iCNABwBGAgnA/kH6P9ZdVZD/h7NnkSZaimEUKHkJS
         OxLR8zNwBfaLPF10N38fRqWvzy6IeSpVybUsnABMZ7/PVSykXDB5t/pjQNQOpBfXJD
         rKXnCovY/UFLuYkbpH8WWb0Xn5rJ+ZCacSbVADDGA9umdIMAmyjgFZzfAuy6h23lnL
         n5/2CMpdMd3xAuf5N2boJpUawDOQNLSv1K3EMEhGPShTiWoGfaHcOuvcrSFF7Qb8aP
         7o+jVfujFLtL0mgziFzeOvB4vT/AC1DFeKhWcxCiqaFablB2Vdv3GgKi9Tga5m+dvc
         RheKmaiYbixAQ==
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
Subject: [PATCH -tip v6 08/13] arm: kprobes: Make a space for regs->ARM_pc at kretprobe_trampoline
Date:   Wed, 26 May 2021 17:03:31 +0900
Message-Id: <162201621112.278331.7300612749929513135.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162201612941.278331.5293566981784464165.stgit@devnote2>
References: <162201612941.278331.5293566981784464165.stgit@devnote2>
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

