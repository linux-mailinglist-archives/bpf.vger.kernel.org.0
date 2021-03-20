Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7685C342CF8
	for <lists+bpf@lfdr.de>; Sat, 20 Mar 2021 14:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhCTNGA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Mar 2021 09:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhCTNFs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Mar 2021 09:05:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FCE561961;
        Sat, 20 Mar 2021 13:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616245548;
        bh=QXdaST1hot6+jYq0oDK7muVDY+aF5hPeweOnMuFWDCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NydJpk1snnUb6dtJ3ZHVlpmHmHA2q14dEvUBuB0jJFMpTdDmqu/qwgRRbY0n6v2Gy
         Ix/wCW4nQ4qR9WeEborqVTAbWBQgbMSyqOF3qnwwGhryXy5SmB9jrJz0f8WFY2GiH/
         klxCX3q38Y4Q0gl7kitV6r+mQXBbX9Li9FIWO5x8FfmzCi6yHF4BFsLTs6ku6yg/Kv
         2+4ED1VkoHQecF2OHyU27+JmTIFl7IKPT3Bsjfudo11Mfb+Iwg8q+jORyMC+URCKmZ
         7Ta2AeQELSGacKdCasQzz5ethCyiqe6B8z+AIoOdFU+GXEhksadHdGdSRrItVXMO92
         3PN+YfIR3UVow==
Date:   Sat, 20 Mar 2021 22:05:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH -tip v3 05/11] x86/kprobes: Add UNWIND_HINT_FUNC on
 kretprobe_trampoline code
Message-Id: <20210320220543.e1558ce3a351554c6be3ea26@kernel.org>
In-Reply-To: <20210320211616.a976fc66d0c51e13d3121e2f@kernel.org>
References: <161615650355.306069.17260992641363840330.stgit@devnote2>
        <161615655969.306069.4545805781593088526.stgit@devnote2>
        <20210320211616.a976fc66d0c51e13d3121e2f@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 20 Mar 2021 21:16:16 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Fri, 19 Mar 2021 21:22:39 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > 
> > Add UNWIND_HINT_FUNC on kretporbe_trampoline code so that ORC
> > information is generated on the kretprobe_trampoline correctly.
> > 
> 
> Test bot also found a new warning for this.
> 
> > >> arch/x86/kernel/kprobes/core.o: warning: objtool: kretprobe_trampoline()+0x25: call without frame pointer save/setup
> 
> With CONFIG_FRAME_POINTER=y.
> 
> Of course this can be fixed with additional "push %bp; mov %sp, %bp" before calling
> trampoline_handler. But actually we know that this function has a bit special
> stack frame too. 
> 
> Can I recover STACK_FRAME_NON_STANDARD(kretprobe_trampoline) when CONFIG_FRAME_POINTER=y ?

So something like this. Does it work?

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index b31058a152b6..651f337dc880 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -760,6 +760,10 @@ int kprobe_int3_handler(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(kprobe_int3_handler);
 
+#ifdef CONFIG_FRAME_POINTER
+#undef UNWIND_HINT_FUNC
+#define UNWIND_HINT_FUNC
+#endif
 /*
  * When a retprobed function returns, this code saves registers and
  * calls trampoline_handler() runs, which calls the kretprobe's handler.
@@ -797,7 +801,14 @@ asm(
 	".size kretprobe_trampoline, .-kretprobe_trampoline\n"
 );
 NOKPROBE_SYMBOL(kretprobe_trampoline);
-
+#ifdef CONFIG_FRAME_POINTER
+/*
+ * kretprobe_trampoline skips updating frame pointer. The frame pointer
+ * saved in trampoline_handler points to the real caller function's
+ * frame pointer.
+ */
+STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
+#endif
 
 /*
  * Called from kretprobe_trampoline

-- 
Masami Hiramatsu <mhiramat@kernel.org>
