Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF34D3AC49E
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 09:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhFRHIv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 03:08:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232939AbhFRHIt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 03:08:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AA8261369;
        Fri, 18 Jun 2021 07:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624000000;
        bh=ZVJBoicxr63FzkH5ZvJFmdAYToq8ylWnJuw9ei63N1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IYqYUs67MX1omOtVDmo+FFuklcanudADon/9N1rO71k374ozEIyYEzjfiF5e0m+H2
         QMAx60kzNwOHQIMtXkvNqDeapCcoQ9ZMkl0uCwDvyUvU6pZuF1OigcHj+OkAruAlTa
         xJtlQml7Kn30HuBH9ZTPzf2wp90mwO3s6IjO2cx5f8pvnXdJTkZEu/JJK7/Nbcqcdk
         +6JCHmLleIVl00AwBWPJU+vKifc3LNb0226gIzDLTXZth8bTRe7r6R0Jj5Y/lbSZzM
         H1fTBeJkWQqaTL8ejwXygKVfI1PUQDDCYQk4xwiOMfIbG3hx6UszB4rkFdcoDQK2lG
         8niAVRkp9chNg==
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
Subject: [PATCH -tip v8 08/13] arm: kprobes: Make a space for regs->ARM_pc at kretprobe_trampoline
Date:   Fri, 18 Jun 2021 16:06:37 +0900
Message-Id: <162399999702.506599.16339931387573094059.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162399992186.506599.8457763707951687195.stgit@devnote2>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
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
index 583f6b1a2a6f..556b1560fb2c 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -374,11 +374,13 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
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

