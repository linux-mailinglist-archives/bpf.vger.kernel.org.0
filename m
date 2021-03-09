Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1B73330FB
	for <lists+bpf@lfdr.de>; Tue,  9 Mar 2021 22:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhCIVfV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Mar 2021 16:35:21 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:40673 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231788AbhCIVet (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Mar 2021 16:34:49 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 63BD71256;
        Tue,  9 Mar 2021 16:34:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 09 Mar 2021 16:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=YlUIQR4L4LxoCFIMyODsPfmF0lh
        BC4MLW4hVWAhi88g=; b=iA/1u3Ihxgx8Mg/qGYs4tPZy86yUg24LVmj2t7jdxQb
        10uJfctsqQmGAsLMxqT0jPiOTIjzcEwE06e7Uomyc/5FCmr9/ThmX6hXgBuo2CMJ
        z/Gzfpur9tuJ7sc0iF2hz0f25CUTA46OUbLomgyHx7AYQV/AifxE37WsKYgtetdV
        Gih5pGfs10+YjRmV3Fp+Gj6iA339qYJ63jnnjSFeILYlqP/TSe2QdhClnvtDZi4l
        evrHfhtTIwRz+FCxZPQNonv0cFDXDJbZO8WOTE/Ud1X1fbF7Ez6xBu4KVagbZHGU
        lI/MUfqYkdQb7XyovFHGXZpC4rHogn5ynhw7GkYYZgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=YlUIQR
        4L4LxoCFIMyODsPfmF0lhBC4MLW4hVWAhi88g=; b=VzlSui7P0lMEGUnO4HVB+9
        wC5RnjDi0+T7ISsbdVJSDKDz2XQkYy4Bv/4w5fBLWcrAHqVaTILKq4r9bz9SUlwA
        n1qghuXa2ijM+ioHXSb8grUHGtsEqQwGaRsudlpj3TfnoV/mbPAs7vB2LIeqJ3Ei
        2ca2jjJOiB54Pwr7R59sys90bN6FDES8Plud2paeOAcVlLSGbpW+ORuIUvuHfkU2
        CYUxI4Q3p0JKwj3R+vgOrS1cBqXCYC3AhvkF6u6eTT6ZAE2qEXX5oBztr4J3WAlJ
        6diVCDVZ92jj0p/YOFqufMpyZisEnh5IMykgThYBz+oefWBzjML6c8lntEKd25Qw
        ==
X-ME-Sender: <xms:9ulHYNrxdNne6LM-X18-Ju0wLN3Q1ifbbGQ42qp8BqYyRNJMoRSTmw>
    <xme:9ulHYPrxAvGjjYjH1pviqUu78yNPeonX6gvOBsUFA5-5ZRqHFhQyddTF6OSJdrZBb
    1cLAP0jLFeOiVjlFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudduiedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepueduvdejfefflefgueevheefgeefteefteeuudduhfduhfeh
    veelteevudelheejnecukfhppeduieefrdduudegrddufedvrdegnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:9ulHYKP7fxnW6wGiDZ8FWS3mLhN4FB5zl3iJ2SLjdyVgd3heOoOu3Q>
    <xmx:9ulHYI4CunBgiW0T0tWi50O4eRt9X3YhBrs5LmMpR7fGlmeq0S2WLA>
    <xmx:9ulHYM5uqtiQj0TkB4SlSLhVu2XkYJWatuzQvDHhxM_fyl_nSTFakQ>
    <xmx:9-lHYJxQ4l2OzpC4bpcC8G7DrA_swqm-vmOoh_Q5NkaBHkUkc14qsV_znJU>
Received: from dlxu-fedora-R90QNFJV (unknown [163.114.132.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id A69A624005B;
        Tue,  9 Mar 2021 16:34:44 -0500 (EST)
Date:   Tue, 9 Mar 2021 13:34:42 -0800
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Message-ID: <20210309213442.fyhxozdcyxfjljih@dlxu-fedora-R90QNFJV>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
 <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
 <20210306101357.6f947b063a982da9c949f1ba@kernel.org>
 <20210307212333.7jqmdnahoohpxabn@maharaja.localdomain>
 <20210308115210.732f2c42bf347c15fbb2a828@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308115210.732f2c42bf347c15fbb2a828@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Masami,

Just want to clarify a few points:

On Mon, Mar 08, 2021 at 11:52:10AM +0900, Masami Hiramatsu wrote:
> On Sun, 7 Mar 2021 13:23:33 -0800
> Daniel Xu <dxu@dxuuu.xyz> wrote:
> To help your understanding, let me explain.
> 
> If we have a code here
> 
> caller_func:
> 0x00 add sp, 0x20	/* 0x20 bytes stack frame allocated */
> ...
> 0x10 call target_func
> 0x15 ... /* return address */
> 
> On the stack in the entry of target_func, we have
> 
> [stack]
> 0x0e0 caller_func+0x15
> ... /* 0x20 bytes = 4 entries  are stack frame of caller_func */
> 0x100 /* caller_func return address */
> 
> And when we put a kretprobe on the target_func, the stack will be
> 
> [stack]
> 0x0e0 kretprobe_trampoline
> ... /* 0x20 bytes = 4 entries  are stack frame of caller_func */
> 0x100 /* caller_func return address */
> 
> * "caller_func+0x15" is saved in current->kretprobe_instances.first.
> 
> When returning from the target_func, call consumed the 0x0e0 and
> jump to kretprobe_trampoline. Let's see the assembler code.
> 
>         ".text\n"
>         ".global kretprobe_trampoline\n"
>         ".type kretprobe_trampoline, @function\n"
>         "kretprobe_trampoline:\n"
>         /* We don't bother saving the ss register */
>         "       pushq %rsp\n"
>         "       pushfq\n"
>         SAVE_REGS_STRING
>         "       movq %rsp, %rdi\n"
>         "       call trampoline_handler\n"
>         /* Replace saved sp with true return address. */
>         "       movq %rax, 19*8(%rsp)\n"
>         RESTORE_REGS_STRING
>         "       popfq\n"
>         "       ret\n"
> 
> When the entry of trampoline_handler, stack is like this;
> 
> [stack]
> 0x040 kretprobe_trampoline+0x25
> 0x048 r15
> ...     /* pt_regs */
> 0x0d8 flags
> 0x0e0 rsp (=0x0e0)
> ... /* 0x20 bytes = 4 entries  are stack frame of caller_func */
> 0x100 /* caller_func return address */
> 
> And after returned from trampoline_handler, "movq" changes the
> stack like this.
> 
> [stack]
> 0x040 kretprobe_trampoline+0x25
> 0x048 r15
> ...     /* pt_regs */
> 0x0d8 flags
> 0x0e0 caller_func+0x15
> ... /* 0x20 bytes = 4 entries  are stack frame of caller_func */
> 0x100 /* caller_func return address */

Thanks for the detailed explanation. I think I understand kretprobe
mechanics from a somewhat high level (kprobe saves real return address
on entry, overwrites return address to trampoline, then trampoline
runs handler and finally resets return address to real return address).

I don't usually write much assembly so the details escape me somewhat.

> So at the kretprobe handler, we have 2 issues.
> 1) the return address (caller_func+0x15) is not on the stack.
>    this can be solved by searching from current->kretprobe_instances.

Yes, agreed.

> 2) the stack frame size of kretprobe_trampoline is unknown
>    Since the stackframe is fixed, the fixed number (0x98) can be used.

I'm confused why this is relevant. Is it so ORC knows where to find
saved return address in the frame?

> However, those solutions are only for the kretprobe handler. The stacktrace
> from interrupt handler hit in the kretprobe_trampoline still doesn't work.
> 
> So, here is my idea;
> 
> 1) Change the trampline code to prepare stack frame at first and save
>    registers on it, instead of "push". This will makes ORC easy to setup
>    stackframe information for this code.

I'm confused on the details here. But this is what Josh solves in his
patch, right?

> 2) change the return addres fixup timing. Instead of using return value
>    of trampoline handler, before removing the real return address from
>    current->kretprobe_instances.

Is the idea to have `kretprobe_trampoline` place the real return address
on the stack (while telling ORC where to find it) _before_ running `call
trampoline_handler` ? So that an unwind from inside the user defined
kretprobe handler simply unwinds correctly?

And to be extra clear, this would only work for stack_trace_save() and
not stack_trace_save_regs()?

> 3) Then, if orc_find() finds the ip is in the kretprobe_trampoline, it
>    checks the contents of the end of stackframe (at the place of regs->sp)
>    is same as the address of it. If it is, it can find the correct address
>    from current->kretprobe_instances. If not, there is a correct address.

What do you mean by "it" w.r.t. "is the same address of it"? I'm
confused on this point.

Thanks,
Daniel
