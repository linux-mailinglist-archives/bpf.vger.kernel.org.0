Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862DF3AC4A1
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 09:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhFRHJA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 03:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232927AbhFRHJA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 03:09:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4D4460FF0;
        Fri, 18 Jun 2021 07:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624000011;
        bh=eLCimkEr/J/o+KbLoEoS4uAKhWtQiwGcopMFmWAEMUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYZtQqdo99z7lWRgReN9YVZTzeyJG56BXb8WJJqzpQ9yLbAZzfQCWVmf+BxWY6wJB
         SmdFXOoYJa/Bxd9brzVxjgZHM5DB++C75tCeZaoyXmZhGHdzLD5xv0gpVF66DmdoFy
         GNR9ZU24kYOEHE4k394YcswDRN4yUvAi3jRXLhK9vS9Sc4ErLOnWqyDbDBdsVnnU7Q
         t+3/pEAr7EhwRgyowCFcqubeXZWvxaBpvWu3+agHopktEWst4RImq8+vycH42HKEGd
         BVpzMwslbGoAR/c1KCalD/HgPg48X/EQ3oaX3JqotDfrd5CvZ2RTd4MAbhuNxWaFYc
         Dv1MJBkDALdiQ==
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
Subject: [PATCH -tip v8 09/13] kprobes: Enable stacktrace from pt_regs in kretprobe handler
Date:   Fri, 18 Jun 2021 16:06:46 +0900
Message-Id: <162400000592.506599.4695807810528866713.stgit@devnote2>
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

Since the ORC unwinder from pt_regs requires setting up regs->ip
correctly, set the correct return address to the regs->ip before
calling user kretprobe handler.

This allows the kretrprobe handler to trace stack from the
kretprobe's pt_regs by stack_trace_save_regs() (eBPF will do
this), instead of stack tracing from the handler context by
stack_trace_save() (ftrace will do this).

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Andrii Nakryik <andrii@kernel.org>
---
 Changes in v8:
  - Update comment to clarify why this is needed.
 Changes in v3:
  - Cast the correct_ret_addr to unsigned long.
---
 kernel/kprobes.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 650cbe738666..ba729ed05cb3 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1896,6 +1896,9 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 		BUG_ON(1);
 	}
 
+	/* Set the instruction pointer to the correct address */
+	instruction_pointer_set(regs, (unsigned long)correct_ret_addr);
+
 	/* Run them. */
 	first = current->kretprobe_instances.first;
 	while (first) {

