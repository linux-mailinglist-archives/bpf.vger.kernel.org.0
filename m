Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A0232F772
	for <lists+bpf@lfdr.de>; Sat,  6 Mar 2021 02:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCFBOM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 20:14:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhCFBOD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Mar 2021 20:14:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F39516508F;
        Sat,  6 Mar 2021 01:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614993243;
        bh=DXFT/1IT9LLTpgWizl+noTVE9yRNg2kxXJH5bWRANWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=miRtcu1t21nub3ZEVqX0yb07yYvO7xQPXMXklm3NrVyb93jQ0prAC6n5+INgldwPt
         D73Yrx6zGVmLbzpnyrGS+O/Qq577Aso5FXjEh2D/e1CPjA4Knn4qVjnzBjO2Gh5DZa
         p/2rzQWXrYv3beRR6dhGWBX4i28IgmZVnAX9fFBLs2gptIMedHYdCgFjMXtaCN55nL
         h7RfHpRMr0O9seADSUOg9vfd26gCdVeV1RzMTDjyTnIJblRpfrIYqix9bG+DIrWXdj
         XLptg/mu1uqVvWF86l7IGsSX/yGflmZSEUV1oVCpQz0BRFG67YtUXwyJgombOxrYSj
         +5efvXL7lETiQ==
Date:   Sat, 6 Mar 2021 10:13:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Message-Id: <20210306101357.6f947b063a982da9c949f1ba@kernel.org>
In-Reply-To: <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
        <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 5 Mar 2021 11:16:45 -0800
Daniel Xu <dxu@dxuuu.xyz> wrote:

> Hi Masami,
> 
> On Sat, Mar 06, 2021 at 12:38:57AM +0900, Masami Hiramatsu wrote:
> > Hello,
> > 
> > Here is a series of patches for kprobes and stacktracer to fix the kretprobe
> > entries in the kernel stack. This was reported by Daniel Xu. I thought that
> > was in the bpftrace, but it is actually more generic issue.
> > So I decided to fix the issue in arch independent part.
> > 
> > While fixing the issue, I found a bug in ia64 related to kretprobe, which is
> > fixed by [1/5]. [2/5] and [3/5] is a kind of cleanup before fixing the main
> > issue. [4/5] is the patch to fix the stacktrace, which involves kretprobe
> > internal change. And [5/5] removing the stacktrace kretprobe fixup code in
> > ftrace. 
> > 
> > Daniel, can you also check that this fixes your issue too? I hope it is.
> 
> Unfortunately, this patch series does not fix the issue I reported.

Ah, OK. This was my mistake I didn't choose ORC unwinder for test kernel.

> 
> I think the reason your tests work is because you're using ftrace and
> the ORC unwinder is aware of ftrace trampolines (see
> arch/x86/kernel/unwind_orc.c:orc_ftrace_find).

OK, so it has to be fixed in ORC unwinder.

> 
> bpftrace kprobes go through perf event subsystem (ie not ftrace) so
> naturally orc_ftrace_find() does not find an associated trampoline. ORC
> unwinding fails in this case because
> arch/x86/kernel/kprobes/core.c:trampoline_handler sets
> 
>     regs->ip = (unsigned long)&kretprobe_trampoline;
> 
> and `kretprobe_trampoline` is marked
> 
>     STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
> 
> so it doesn't have a valid ORC entry. Thus, ORC immediately bails when
> trying to unwind past the first frame.

Hm, in ftrace case, it decode kretprobe's stackframe and stoped right
after kretprobe_trampoline callsite.

 => kretprobe_trace_func+0x21f/0x340
 => kretprobe_dispatcher+0x73/0xb0
 => __kretprobe_trampoline_handler+0xcd/0x1a0
 => trampoline_handler+0x3d/0x50
 => kretprobe_trampoline+0x25/0x50
 => 0

kretprobe replaces the real return address with kretprobe_trampoline
and kretprobe_trampoline *calls* trampoline_handler (this part depends
on architecture implementation).
Thus, if kretprobe_trampoline has no stack frame information, ORC may
fails at the first kretprobe_trampoline+0x25, that is different from
the kretprobe_trampoline+0, so the hack doesn't work.

Hmm, how the other inline-asm function makes its stackframe info?
If I get the kretprobe_trampoline+0, I can fix it up.

> The only way I can think of to fix this issue is to make the ORC
> unwinder aware of kretprobe (ie the patch I sent earlier). I'm hoping
> you have another idea if my patch isn't acceptable.

OK, anyway, your patch doesn't care the case that the multiple functions
are probed by kretprobes. In that case, you'll see several entries are
replaced by the kretprobe_trampoline. To find it correctly, you have
to pass a state-holder (@cur of the kretprobe_find_ret_addr())
to the fixup entries.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
