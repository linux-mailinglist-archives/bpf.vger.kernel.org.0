Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C63304D4
	for <lists+bpf@lfdr.de>; Sun,  7 Mar 2021 22:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhCGVYG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Mar 2021 16:24:06 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:33217 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233029AbhCGVXl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Mar 2021 16:23:41 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id BD78E30DB;
        Sun,  7 Mar 2021 16:23:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 07 Mar 2021 16:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=nlxRFNzfOcigzTV3RuqFb68nzCJ
        QMa4Zxw5zE3eY08k=; b=gR3q9OgbrI+yqTeMWxmOufzltR1UL1HqjTX3jlUqFFJ
        uIETMjo5y6whF2u872Q4WTgY+hd9YLoQZKsGaMG/W05wOs62rdsopo/DKGP/el/j
        CfjqHVDSHNjXjZzbE2Q0ztwrdFjeRLJxV4qivauPa0A3aA8uAnYPVmXlt7XhySNj
        4aAE9Ier17Do+jJmcpp/rM7htYnrAAbaKWPo+KTGjFecM+arrWVLvOChnxciND6u
        ucKbgYhWM3gg0jWpuNY/73a6BPgcVVO8jk6lkWTvMmaYcFfa6+/dAcIK5+PsqqjV
        rOKLfyqA8fCH06zlAWfypDQgslLBfbtB800AAVoCDhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=nlxRFN
        zfOcigzTV3RuqFb68nzCJQMa4Zxw5zE3eY08k=; b=uetpmlVM7rsk0Co/mkB9bv
        Oxp8LpBqyvo8TrJX+wIhzszSy8Gv1yEtKS1ctstPwTjaFRRiikyOycGQVaX3pJpw
        glk6O+YS3cTiggXVhA02pOq4Y4UnkoWUkRgl2o6faePVGp6VRejIfIXeRF6jxZbC
        +TPMHj9aVgLae9PXKnQnE4wN737gmVhk87TZk3t1fSXihefRpaDy0Oh3+HZ3gqO8
        t7wgLAlGs6vL60fstE4WTxKXZDIVf3v0AzAGJuT+DQB91AJEFpzjAR0D8SObmUdm
        06M2rBQTOovE5NNVvQHJPgTm+G8YY9QPr9NZ2m6l22xEXSCihBp0T5fivzYydgOg
        ==
X-ME-Sender: <xms:WkRFYHFiilkkFkq-x1IXbBtqo377Z0mxe0NlXEOyYjGTnBaaBfLJeQ>
    <xme:WkRFYEWMf3qu90bwJIpv0B13L8SyRmZrg4z0D8JtxFqqIE-xomXoKMk20PoUe_QnZ
    hVNOXsxptEfH5xDLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddutddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepueduvdejfefflefgueevheefgeefteefteeuudduhfduhfeh
    veelteevudelheejnecukfhppeeiledrudekuddruddthedrieegnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:WkRFYJIPUd37Mp3grELaPiBjX1gM71MTsZCaprfqwcjb8QC1yFV6aA>
    <xmx:WkRFYFE5_EoekiJ9OX9n-Fto-THldacUNvYX8ICrtghiVcRdGSWmcQ>
    <xmx:WkRFYNXx0tleXVEZ5-PbESzeuWRlqAitlj3WyZwQHPkNovyC0cy24w>
    <xmx:W0RFYGOjXfn1IFWU9qI00JWT0P92-XjRtTx80wyiWKuLuO8eABZz43sblOs>
Received: from maharaja.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id EDAAC108005F;
        Sun,  7 Mar 2021 16:23:36 -0500 (EST)
Date:   Sun, 7 Mar 2021 13:23:33 -0800
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Message-ID: <20210307212333.7jqmdnahoohpxabn@maharaja.localdomain>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
 <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
 <20210306101357.6f947b063a982da9c949f1ba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210306101357.6f947b063a982da9c949f1ba@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 06, 2021 at 10:13:57AM +0900, Masami Hiramatsu wrote:
> On Fri, 5 Mar 2021 11:16:45 -0800
> Daniel Xu <dxu@dxuuu.xyz> wrote:
> 
> > Hi Masami,
> > 
> > On Sat, Mar 06, 2021 at 12:38:57AM +0900, Masami Hiramatsu wrote:
> > > Hello,
> > > 
> > > Here is a series of patches for kprobes and stacktracer to fix the kretprobe
> > > entries in the kernel stack. This was reported by Daniel Xu. I thought that
> > > was in the bpftrace, but it is actually more generic issue.
> > > So I decided to fix the issue in arch independent part.
> > > 
> > > While fixing the issue, I found a bug in ia64 related to kretprobe, which is
> > > fixed by [1/5]. [2/5] and [3/5] is a kind of cleanup before fixing the main
> > > issue. [4/5] is the patch to fix the stacktrace, which involves kretprobe
> > > internal change. And [5/5] removing the stacktrace kretprobe fixup code in
> > > ftrace. 
> > > 
> > > Daniel, can you also check that this fixes your issue too? I hope it is.
> > 
> > Unfortunately, this patch series does not fix the issue I reported.
> 
> Ah, OK. This was my mistake I didn't choose ORC unwinder for test kernel.
> 
> > 
> > I think the reason your tests work is because you're using ftrace and
> > the ORC unwinder is aware of ftrace trampolines (see
> > arch/x86/kernel/unwind_orc.c:orc_ftrace_find).
> 
> OK, so it has to be fixed in ORC unwinder.
> 
> > 
> > bpftrace kprobes go through perf event subsystem (ie not ftrace) so
> > naturally orc_ftrace_find() does not find an associated trampoline. ORC
> > unwinding fails in this case because
> > arch/x86/kernel/kprobes/core.c:trampoline_handler sets
> > 
> >     regs->ip = (unsigned long)&kretprobe_trampoline;
> > 
> > and `kretprobe_trampoline` is marked
> > 
> >     STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
> > 
> > so it doesn't have a valid ORC entry. Thus, ORC immediately bails when
> > trying to unwind past the first frame.
> 
> Hm, in ftrace case, it decode kretprobe's stackframe and stoped right
> after kretprobe_trampoline callsite.
> 
>  => kretprobe_trace_func+0x21f/0x340
>  => kretprobe_dispatcher+0x73/0xb0
>  => __kretprobe_trampoline_handler+0xcd/0x1a0
>  => trampoline_handler+0x3d/0x50
>  => kretprobe_trampoline+0x25/0x50
>  => 0
> 
> kretprobe replaces the real return address with kretprobe_trampoline
> and kretprobe_trampoline *calls* trampoline_handler (this part depends
> on architecture implementation).
> Thus, if kretprobe_trampoline has no stack frame information, ORC may
> fails at the first kretprobe_trampoline+0x25, that is different from
> the kretprobe_trampoline+0, so the hack doesn't work.

I'm not sure I follow 100% what you're saying, but assuming you're
asking why bpftrace fails at `kretprobe_trampoline+0` instead of
`kretprobe_trampoline+0x25`:

`regs` is set to &kretprobe_trampoline:

    regs->ip = (unsigned long)&kretprobe_trampoline;

Then the kretprobe event is dispatched like this:

    kretprobe_trampoline_handler
      __kretprobe_trampoline_handler
        rp->handler // ie kernel/trace/trace_kprobe.c:kretprobe_dispatcher
          kretprobe_perf_func
            trace_bpf_call(.., regs)
              BPF_PROG_RUN_ARRAY_CHECK
                bpf_get_stackid(regs, .., ..) // in bpftrace prog 

And then `bpf_get_stackid` unwinds the stack via:

    bpf_get_stackid
      get_perf_callchain(regs, ...)
        perf_callchain_kernel(.., regs)
          perf_callchain_store(.., regs->ip) // !!! first unwound entry
          unwind_start
          unwind_next_frame

In summary: unwinding via BPF begins at regs->ip, which
`trampoline_handler` sets to `&kretprobe_trampoline+0x0`.

> Hmm, how the other inline-asm function makes its stackframe info?
> If I get the kretprobe_trampoline+0, I can fix it up.

So I think I misunderstood the mechanics before. I think `call
trampoline_handler` does set up a new frame. My current guess is that
ftrace doesn't thread through `regs` like the bpf code path does. I'm
not very familiar with ftrace internals so I haven't looked.

> 
> > The only way I can think of to fix this issue is to make the ORC
> > unwinder aware of kretprobe (ie the patch I sent earlier). I'm hoping
> > you have another idea if my patch isn't acceptable.
> 
> OK, anyway, your patch doesn't care the case that the multiple functions
> are probed by kretprobes. In that case, you'll see several entries are
> replaced by the kretprobe_trampoline. To find it correctly, you have
> to pass a state-holder (@cur of the kretprobe_find_ret_addr())
> to the fixup entries.

I'll see if I can figure something out tomorrow.

Thanks,
Daniel
