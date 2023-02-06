Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598F568C327
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 17:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjBFQZ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 11:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBFQZy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 11:25:54 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01121F5C2
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 08:25:52 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id u75so1963215pgc.10
        for <bpf@vger.kernel.org>; Mon, 06 Feb 2023 08:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=id8fSN6nCpuUHUWrLfLtNoBqG5vqrIF4k085X9FJUls=;
        b=EX1ehNIQKPbapcqwRXobBlBRI7Qc4WA0fHQ9k+98pKJp3/u8dYmBjgB/AL6ucgYTJf
         1IiQHxDMYBTymfbbe8J2vYQ+kIrFZK9kpmWsguhMrJ2ldVORBk6iJ844AuKcV0LXD9rb
         T/kIoLjhL8KgvAi4NhGoCkI/o/kMWczy2bCDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=id8fSN6nCpuUHUWrLfLtNoBqG5vqrIF4k085X9FJUls=;
        b=678gcBegn9Jxkn+J49FJE7kM9xAIFdZT6ih6CiO0qg8L9V7bJ0cjoTMsxHqvC/MrrY
         WVIuleY2dNmM+IKmHYFhizx6CYbxYvHQx+AxE7QuwHCgzwCKjDKiKECFM/kjKKnPtxKL
         5yXt51MNoJDpeqiRovlzKdbzeRz7sHw2lyjA1kTzqGPIxkAHdm3ijTFPuTcGwWEUNGQf
         wwUBzAmhABscIh6I5gOw9xeqIybsQaDy9wuquHZivwl8TTU/FDPkBEfofc9ODBkOeaLo
         a+aDlE6uss51fXGAVOa4vSWgnZtjxEii1gaM7NWnWouM8Lfy+qsXrb59Ol0myJOIhsjc
         jLfg==
X-Gm-Message-State: AO0yUKW/YuWBSmKUQXy1E/NWeviFimZVM+RCQTKNy2YormgpUOXZzOL5
        CUq4ALo3PjXI7q4PscEkFNpy9rBNFGodh7ffjrnDdQ==
X-Google-Smtp-Source: AK7set8zr0sS3lchCBKdSsYYwPtgNlfSunzSdRe+cJ0M5xjqOUyQ9+E8UhmyFdPu1nxSCQsMND4O2fS4n864oFLqMNQ=
X-Received: by 2002:aa7:8f27:0:b0:593:e2fd:ca4f with SMTP id
 y7-20020aa78f27000000b00593e2fdca4fmr37380pfr.0.1675700752311; Mon, 06 Feb
 2023 08:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20230201163420.1579014-1-revest@chromium.org> <20230201163420.1579014-8-revest@chromium.org>
 <Y90phLJfnz06Ilb+@FVFF77S0Q05N>
In-Reply-To: <Y90phLJfnz06Ilb+@FVFF77S0Q05N>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 6 Feb 2023 17:25:41 +0100
Message-ID: <CABRcYmJ7v0r+Pi5podwX0=zJQPY3S1mWWAdTdtFDVTCVy_PqiQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] arm64: ftrace: Add direct call support
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 3, 2023 at 4:34 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Feb 01, 2023 at 05:34:19PM +0100, Florent Revest wrote:
> > This builds up on the CALL_OPS work which extends the ftrace patchsite
> > on arm64 with an ops pointer usable by the ftrace trampoline.
> >
> > This ops pointer is valid at all time. Indeed, it is either pointing to
> > ftrace_list_ops or to the single ops which should be called from that
> > patchsite.
> >
> > There are a few cases to distinguish:
> > - If a direct call ops is the only one tracing a function:
> >   - If the direct called trampoline is within the reach of a BL
> >     instruction
> >      -> the ftrace patchsite jumps to the trampoline
> >   - Else
> >      -> the ftrace patchsite jumps to the ftrace_caller trampoline which
> >         reads the ops pointer in the patchsite and jumps to the direct
> >         call address stored in the ops
> > - Else
> >   -> the ftrace patchsite jumps to the ftrace_caller trampoline and its
> >      ops literal points to ftrace_list_ops so it iterates over all
> >      registered ftrace ops, including the direct call ops and calls its
> >      call_direct_funcs handler which stores the direct called
> >      trampoline's address in the ftrace_regs and the ftrace_caller
> >      trampoline will return to that address instead of returning to the
> >      traced function
>
> This looks pretty good!
>
> Overall I think this is the right shape, but I have a few minor comments that
> lead to a bit of churn. I've noted those below, and I've also pushed out a
> branch with suggested fixups (as discrete patches) to my
> arm64/ftrace/direct-call-testing branch, which you can find at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
>   git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
>
> Note that's based on a merge of the arm64 tree's for-next/ftrace branch and the
> trace tree's trace/for-next branch, and there were a couple of trivial
> conflicts I had to fix up when first picking this series (which I've noted in
> the affected patches)
>
> Those trees are at:
>
>   # arm64
>   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
>
>   # trace
>   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
>

Thanks for taking the time to publish these, that helps a lot.

> > @@ -80,6 +80,10 @@ struct ftrace_regs {
> >
> >       unsigned long sp;
> >       unsigned long pc;
> > +
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > +     unsigned long custom_tramp;
>
> Minor nit, but could we please s/custom_tramp/direct_tramp/?

Yes, that's better

> I forgot to add a comment here, but we require that sizeof(struct ftrace_regs)
> is a multiple of 16, as the AAPCS requires that the stack is 16-byte aligned at
> function call boundaries (and on arm64 we currently assume that it's *always*
> aligned).
>
> I'd suggest we make this:
>
> | /*
> |  * Note: sizeof(struct ftrace_regs) must be a multiple of 16 to ensure correct
> |  * stack alignment
> |  */
> | struct ftrace_regs {
> |       /* x0 - x8 */
> |       unsigned long regs[9];
> |
> | #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> |       unsigned long direct_tramp;
> | #else
> |       unsigned long __unused;
> | #endif
> |
> |       unsigned long fp;
> |       unsigned long lr;
> |
> |       unsigned long sp;
> |       unsigned long pc;
> | };

Oh good catch, that was easy to miss. I'm surprised I didn't hit
horrible bugs when testing this in qemu.

> For branching to the direct call trampoline, it would be better to use a
> forward branch (i.e. BR), as that won't unbalance return stack predictors.
> That'll need to use x16 or x17 to be compatible with a `BTI C` landing pad.
>
> I'd also prefer if we could move the direct call invocation to a stub at the
> end of ftrace_caller, e.g.
>
> | SYM_CODE_START(ftrace_caller)
> |       ... discover ops pointer here ...
> |
> |       ldr     w17, [x11, #FTRACE_OPS_DIRECT_CALL]
> |       cbnz    ftrace_caller_direct
> |
> |       ... usual save and handling logic here ...
> |
> |       // just prior to return
> |       ldr     x17, [sp, #FREGS_DIRECT_CALL]
> |       cbnz    ftrace_caller_direct_late
> |
> |       ...  usual restore logic here ...
> |
> |       ret     x9
> |
> | SYM_INNER_LABEL(ftrace_caller_direct_late, SYM_L_LOCAL)
> |
> |       ... shuffle registers for the trampoline here ...
> |
> |       // fallthrough to the usual invocation
> | SYM_INNER_LABEL(ftrace_caller_direct, SYM_L_LOCAL)
> |       br      x17
> | SYM_CODE_END(ftrace_caller)

Agreed, it makes things a lot easier to read and your branch makes
restoring LR and PC more sane too. I squashed your change in and will
send it as part of v2.

> > @@ -220,14 +227,21 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
> >                                     unsigned long *addr)
> >  {
> >       unsigned long pc = rec->ip;
> > -     long offset = (long)*addr - (long)pc;
> >       struct plt_entry *plt;
> >
> > +     /*
> > +      * If a custom trampoline is unreachable, rely on the ftrace_caller
> > +      * trampoline which knows how to indirectly reach that trampoline
> > +      * through ops->direct_call.
> > +      */
> > +     if (*addr != FTRACE_ADDR && !reachable_by_bl(*addr, pc))
> > +             *addr = FTRACE_ADDR;
> > +
>
> With this, the check in get_ftrace_plt() is now redundant, since that's always
> called with FTRACE_ADDR as the 'addr' argument. We could probably clean that
> up, but I'm happy to leave that for now and handle that as a follow-up, since
> I think that'll imply making some other structural changes, which qould obscure
> the bulk of this patch.

Fair enough, I'll add an extra patch for this in v2. It's fairly
simple and if other maintainers think it's too much for the scope of
the series, we can always pick it up later and merge it separately.
