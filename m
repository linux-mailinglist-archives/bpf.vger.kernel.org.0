Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BD0436E88
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 01:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhJUXxj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 19:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhJUXxj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 19:53:39 -0400
Received: from mail-ot1-x364.google.com (mail-ot1-x364.google.com [IPv6:2607:f8b0:4864:20::364])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2577C061766
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 16:51:22 -0700 (PDT)
Received: by mail-ot1-x364.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so2438162otk.3
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 16:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc;
        bh=e+PTcSOFwWEcq9oTy0sMRAqods1g3LEj7JCe2Z0YjmU=;
        b=7EHDZg+K9NBy7fd2DZhY49i31KTR5XTPDWN6qwsbNup0xAcyjWlCbfcAfMcvZIIYHe
         gXuXoVc5rkrI2loJI+3P7m890KAiwQUv1G2gsj9CFHog831Ey7Hyzq6hYlBm99qYikwF
         6izNoHe0/t+82muq0Qzn8nVOAqZEduXCdvKH5Mx3K0rv9WBnZ/2hQDqQlgOMw7+AjDrD
         IjkyUNpM7WCxGFtr++VQWPzWtFt956YI12yubZhVUKikeMThzYaoYbJPCT8LJryx2ge0
         TP2DgEgC/hLSwSt6p0lWRnGsWaqMcPAI58UHJVKy5DL/rMziVvZOmu5mkbnCOagWuiXb
         6YyA==
X-Gm-Message-State: AOAM5323y8UfcOOvFnxkfZgWKvHcI2z56E4uww6UVQ3h0fXb6tW7mHcE
        s4uga6Z1MGvHOKAsMSzdoLaDgyJJD0QGZ5eziDvh8j46fkyUmA==
X-Google-Smtp-Source: ABdhPJyM4e+vRJTRDq8gHihjMuEl+pTr9smLqWZId8C5gCpkihFO3gCXC1XloIxN0wuPggHNaWaUN4w5aCUI
X-Received: by 2002:a9d:60d9:: with SMTP id b25mr7343609otk.378.1634860282053;
        Thu, 21 Oct 2021 16:51:22 -0700 (PDT)
Received: from netskope.com ([163.116.131.172])
        by smtp-relay.gmail.com with ESMTPS id e25sm2069654oot.15.2021.10.21.16.51.21
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 16:51:22 -0700 (PDT)
X-Relaying-Domain: riotgames.com
Received: by mail-ed1-f71.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so1972265edv.10
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 16:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+PTcSOFwWEcq9oTy0sMRAqods1g3LEj7JCe2Z0YjmU=;
        b=ojaLK0HvIJ82oNRz7+C2hMZO0pIoLO/gi4pSqB+nhc58D65M7ZN18Z3a8/xxcGFvnx
         dc8mkwwbqjMMaYpWTXy4IMyziYwQsUvHXK4EjwfL01I9r21m/lzt9e9bSBETBglXfjh5
         vnYiDGUSabTlMOP8PNRKnNYSk5Gdx/JdgB9Ls=
X-Received: by 2002:a17:906:9a07:: with SMTP id ai7mr11435103ejc.55.1634860279639;
        Thu, 21 Oct 2021 16:51:19 -0700 (PDT)
X-Received: by 2002:a17:906:9a07:: with SMTP id ai7mr11435067ejc.55.1634860279333;
 Thu, 21 Oct 2021 16:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211020104442.021802560@infradead.org> <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net> <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
 <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net>
In-Reply-To: <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Thu, 21 Oct 2021 16:51:08 -0700
Message-ID: <CAC1LvL33KYZUJTr1HZZM_owhH=Mvwo9gBEEmFgdpZFEwkUiVKw@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, x86@kernel.org,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
x-netskope-inspected: true
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
>
> > All insn emits trying to do the right thing from the start.
> > Here the logic assumes that there will be at least two passes over image.
> > I think that is correct, but we never had such assumption.
>
> That's not exactly true; I think image is NULL on every first run, so
> all insn that depend on it will be wrong to start with. Equally there's
> a number of insn that seem to depend on addrs[i], that also requires at
> least two passes.
>
> > A comment is certainly must have.
>
> I can certainly add one, although I think we'll disagree on the comment
> style :-)
>
> > The race is possible too. Not sure whether READ_ONCE/WRITE_ONCE
> > are really warranted though. Might be overkill.
>
> Is there concurrency on the jit?
>
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
>

Patchwork[0] tracks the status of patches from submission through to merge (and
beyond?).

[0]: https://patchwork.kernel.org/

> > It's pretty much the same as selftests/bpf/vmtest.sh, but with the latest
> > clang nightly and other deps like pahole.
>
> nice.
