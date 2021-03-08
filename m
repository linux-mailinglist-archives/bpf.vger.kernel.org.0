Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937F0330ED8
	for <lists+bpf@lfdr.de>; Mon,  8 Mar 2021 14:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhCHNGM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 08:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhCHNGF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Mar 2021 08:06:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A7B4650BA;
        Mon,  8 Mar 2021 13:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615208765;
        bh=5UAf+zpa4h3l19dB35Q0+JDHIS+26hF5Ito7pRZ3+Kc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dDVyf2E2R/giRHNcunJk+GHbUo6XLVFhMhyy6LooFPf8M2oQFJZd240MtoMLNqxAr
         ZXWUExNIkaTnGbU82xW2b+QlzVzs7TUKJIU/DcKCOemWA00Qx8+klhSL/wWeXAIrkP
         CL/9ZOW8qkUdLlg8IZqedsgqx//FR9F3c+Xzsl3PJEts7f5FmWAapJ8lwG6ZxKN3+u
         OFmHpfkZevz+BbNAz8jr43eWjEB9gL+lAJ3lNtDy1jxZt6+PXIBFCkftbzaZ+lsmTD
         urH26TZbUa3E7vEk9qpkfg2+cJ4nIHzLvU8cnYmjk8ebt7rqW1TmGyUdKl1eeznJk7
         Q1sE9m1FA2YIQ==
Date:   Mon, 8 Mar 2021 22:05:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Message-Id: <20210308220559.ed5c7a074d7146f004388195@kernel.org>
In-Reply-To: <20210308115210.732f2c42bf347c15fbb2a828@kernel.org>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
        <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
        <20210306101357.6f947b063a982da9c949f1ba@kernel.org>
        <20210307212333.7jqmdnahoohpxabn@maharaja.localdomain>
        <20210308115210.732f2c42bf347c15fbb2a828@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 8 Mar 2021 11:52:10 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> So, here is my idea;
> 
> 1) Change the trampline code to prepare stack frame at first and save
>    registers on it, instead of "push". This will makes ORC easy to setup
>    stackframe information for this code.
> 2) change the return addres fixup timing. Instead of using return value
>    of trampoline handler, before removing the real return address from
>    current->kretprobe_instances.
> 3) Then, if orc_find() finds the ip is in the kretprobe_trampoline, it
>    checks the contents of the end of stackframe (at the place of regs->sp)
>    is same as the address of it. If it is, it can find the correct address
>    from current->kretprobe_instances. If not, there is a correct address.

Another trickly idea is put a call on top of kretprobe_trampoline like this.

        "__kretprobe_trampoline:\n"
        "       call kretprobe_trampoline\n"
        "kretprobe_trampoline:\n"
        "       pushq %rsp\n"
        "       pushfq\n"
        SAVE_REGS_STRING
        "       movq %rsp, %rdi\n"
        "       call trampoline_handler\n"
        /* Replace __kretprobe_trampoline with true return address. */
        "       movq %rax, 20*8(%rsp)\n"
        RESTORE_REGS_STRING
        "       popfq\n"
        "       popq %rsp\n"
        "       ret\n"

This will leave a marker (kretprobe_trampoline or __kretprobe_trampoline+5) on
the top of stack, and the stack frame seems like a normal function. If objtool
can make an ORC info by disassembling kretprobe_trampoline, I guess it is
easy to make a stack frame information.

But anyway, from the inside of target function, it still see "__kretprobe_trampoline"
on the stack instead of caller_func, so orc_kretprobe_find() is still needed.

I'm not familier with the UNWIND_HINT macro, so if it is easy to handle the original
case, I think my first idea will be better.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
