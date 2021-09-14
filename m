Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9630C40B1B3
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 16:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhINOom (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 10:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234718AbhINOne (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:43:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CC9260698;
        Tue, 14 Sep 2021 14:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630536;
        bh=3BqLLykrOHv7GrNy26CHO6BhcUQk9jcyV1ViRuIHq5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqIHQ0Gt2EqUIueVcGydp3rBk92Jdp1Pe3e5fWRbDSm2kyzTdJvKEpyqGHpEIrANP
         OyawhObNC4MAXVJhvwuAF+DA53+bAXuF5x4eUnyIttUXMkEmc3W9oKJ7G9NPmZeOIk
         SYOInDQ1VAHSxPOQQyxHI+TxrtRP6ALShyNQVLXPdNN9Zr45COpRSFOICRPbJmo/V1
         /qziE1BEjbDAmjCEyhJ8K676C0F5hhuh4GPDTb1g011ivk3HBXIKfmvmpX5Q5NUuVc
         q9SC5o476A9aVXCVHz9jLnq6x78vlj/l9NTSH130E4IcmqIVUCj+RpVhv6W7TDA55m
         V2DzkOor2RwIQ==
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
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: [PATCH -tip v11 23/27] kprobes: Enable stacktrace from pt_regs in kretprobe handler
Date:   Tue, 14 Sep 2021 23:42:12 +0900
Message-Id: <163163053237.489837.4272653874525136832.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163163030719.489837.2236069935502195491.stgit@devnote2>
References: <163163030719.489837.2236069935502195491.stgit@devnote2>
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
Tested-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 Changes in v9:
  - Update comment to explain specifically why this is necessary.
 Changes in v8:
  - Update comment to clarify why this is needed.
 Changes in v3:
  - Cast the correct_ret_addr to unsigned long.
---
 kernel/kprobes.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 833f07f33115..ebc587b9a346 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1937,6 +1937,13 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 		BUG_ON(1);
 	}
 
+	/*
+	 * Set the return address as the instruction pointer, because if the
+	 * user handler calls stack_trace_save_regs() with this 'regs',
+	 * the stack trace will start from the instruction pointer.
+	 */
+	instruction_pointer_set(regs, (unsigned long)correct_ret_addr);
+
 	/* Run the user handler of the nodes. */
 	first = current->kretprobe_instances.first;
 	while (first) {

