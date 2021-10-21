Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9932A436A00
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhJUSGJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 14:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbhJUSGB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 14:06:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12424C061570;
        Thu, 21 Oct 2021 11:03:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id g5so991396plg.1;
        Thu, 21 Oct 2021 11:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bu+DqqPSt1Mym31+dj/HEy52Ec/jlkL2ncI05eobZN0=;
        b=L3jTKuj0F3dY0YrSKGCxdKn7u/U83u07sp5jRyB/JD43H4raVayciLESfqLa4MRXFs
         uLUSceAR0SIFvxa2L5K50yd2CkkyLk9iGnou6njZL34jy4t8mT0KjIifV66IFzcEioFX
         3HviMhgwWAr436kvMnQZ36sZOM0DDwADReahtofK0kJLqLTEgDXPvMUtVmmorjAd+1V/
         VpIkfKZsg0aEkIdrZxT0Z3ou4jtXVoiQyFx1H1IXjjleFmHw1LjvigwiDp3/WsZIAEWj
         fBdVzc/ZKpqDAA4Idjdd4nghXVB0Hp/fOsh0m38XVuCUGcn/CcLhDOCLzBsK8MJ49sx9
         TRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bu+DqqPSt1Mym31+dj/HEy52Ec/jlkL2ncI05eobZN0=;
        b=DeFqB0DlWofvrfB/23VwKbBXhNxL6P374CePdeGhMAgRfAvB3LkeKCytPo1OBchWit
         90mZE2kG8EJlkC/frz2paa8YWYOC0d8V82Mac8fXsGtIO7n8i4uIGgQWVAKnXG/WCNkp
         /ORH0mborLHUNYJmLEwrSK/I3D6DAEdYP8Lc5FlrezGAAZxGxgus8tGSaFdCu1osjrJE
         2ol6C08YcrlDcY52l5tLeO3XYK0gk/Aats15p22ho83e8hvwv2fyllD+wkXogTcZ8+Xe
         EhftKmPYqWhIjWDB/YsABd66PUCjtICKPEBoWHy0nE5pDZIiJD5XV5rOmjJ/eO8uRKBM
         Fnhw==
X-Gm-Message-State: AOAM532+9fEJc1YzVpp1g41nOwUL3t8l57omVW+PLm9vZew18cGRUv+4
        BICxI9EJhyh7oL+gcGioZuUjrCdReI2D0FOvGQQ=
X-Google-Smtp-Source: ABdhPJwNuR+9yVmwnadPKCvsoh4T58kppUuXsHNhUxiWhBwruu9dgIVbGELb5I45Qp4+jYNSEzjD4ohRyQMoAWuTT44=
X-Received: by 2002:a17:90b:4a4d:: with SMTP id lb13mr7764698pjb.122.1634839424497;
 Thu, 21 Oct 2021 11:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211020104442.021802560@infradead.org> <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net> <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
 <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net>
In-Reply-To: <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 21 Oct 2021 11:03:33 -0700
Message-ID: <CAADnVQKD6=HwmnTw=Shup7Rav-+OTWJERRYSAn-as6iikqoHEA@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 21, 2021 at 1:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 20, 2021 at 05:05:02PM -0700, Alexei Starovoitov wrote:
> > On Wed, Oct 20, 2021 at 01:09:51PM +0200, Peter Zijlstra wrote:
>
> > > @@ -446,25 +440,8 @@ static void emit_bpf_tail_call_indirect(
> > >  {
> > >     int tcc_off = -4 - round_up(stack_depth, 8);
> > >     u8 *prog = *pprog, *start = *pprog;
> > > -   int pop_bytes = 0;
> > > -   int off1 = 42;
> > > -   int off2 = 31;
> > > -   int off3 = 9;
> > > -
> > > -   /* count the additional bytes used for popping callee regs from stack
> > > -    * that need to be taken into account for each of the offsets that
> > > -    * are used for bailing out of the tail call
> > > -    */
> > > -   pop_bytes = get_pop_bytes(callee_regs_used);
> > > -   off1 += pop_bytes;
> > > -   off2 += pop_bytes;
> > > -   off3 += pop_bytes;
> > > -
> > > -   if (stack_depth) {
> > > -           off1 += 7;
> > > -           off2 += 7;
> > > -           off3 += 7;
> > > -   }
> > > +   static int out_label = -1;
> >
> > Interesting idea!
>
> I nicked it from emit_bpf_tail_call() in the 32bit jit :-) It seemed a
> lot more robust than the 64bit one and I couldn't figure out why the
> difference.

Interesting. Daniel will recognize that trick then :)

> > All insn emits trying to do the right thing from the start.
> > Here the logic assumes that there will be at least two passes over image.
> > I think that is correct, but we never had such assumption.
>
> That's not exactly true; I think image is NULL on every first run, so
> all insn that depend on it will be wrong to start with. Equally there's
> a number of insn that seem to depend on addrs[i], that also requires at
> least two passes.

Right. The image will be allocated after size converges and
addrs[] is inited with 64.
So there is certainly more than one pass.
I was saying that emit* helpers didn't have that assumption.
Looks like 32-bit JIT had.

> > A comment is certainly must have.
>
> I can certainly add one, although I think we'll disagree on the comment
> style :-)

I think we're on the same page actually.

> > The race is possible too. Not sure whether READ_ONCE/WRITE_ONCE
> > are really warranted though. Might be overkill.
>
> Is there concurrency on the jit?

The JIT of different progs can happen in parallel.

> > Once you have a git branch with all the changes I can give it a go.
>
> Ok, I'll go polish this thing and stick it in the tree mentioned in the
> cover letter.
>
> > Also you can rely on our BPF CI.
> > Just cc your patchset to bpf@vger and add [PATCH bpf-next] to a subject.
> > In patchwork there will be "bpf/vmtest-bpf-next" link that
> > builds kernel, selftests and runs everything.
>
> What's a patchwork and where do I find it?

https://patchwork.kernel.org/project/netdevbpf/list/?delegate=121173
Click on any patch, search for 'bpf/vmtest-bpf-next' and follow the
'VM_Test' link.
The summary of the test run is available without logging in into github.
To see detailed logs you need to be logged in with your github account.
It's a silly limitation they have.
They even have a button 'Sign in to view logs'. Oh well.

> > It's pretty much the same as selftests/bpf/vmtest.sh, but with the latest
> > clang nightly and other deps like pahole.
>
> nice.

One more thing. There is test_bpf.ko.
Just insmod it and it will run a ton of JIT tests that we cannot do
from user space.
Please use bpf-next tree though. Few weeks ago Johan Almbladh added
a lot more tests to it.
