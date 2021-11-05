Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CAD445F11
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 05:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhKEEQl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 00:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhKEEQk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 00:16:40 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09861C061714
        for <bpf@vger.kernel.org>; Thu,  4 Nov 2021 21:14:02 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id gh1so6684581qvb.8
        for <bpf@vger.kernel.org>; Thu, 04 Nov 2021 21:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3M3QCeS4mDVaZbFZVmiYltyQSCr5+JmL57wgUpkLXzc=;
        b=md78SNnjftmzk9x0OP18x3OKM1/zcRfllCvoiYkXwVPQxWqsQFGv7KyMKOZltNXt12
         tWST/FUQ4vLhvOxrPNupUTBYEAsg0c1M+pBOHHxlKz1GOU+xdYbak1rt42IAKO2cFnfP
         baVzyFh0U1u9q4GsAWFSjmTmZb7LreqHRN0/UkCXffzm9WleUtgxzBsNnC/zwt0t4iPT
         ngsoZarnsjJEAVEfBlGLhakgO+kQQxOuIyRr4ihD3hh0TXsQLcq6LmxIHHnPUtCYQIjb
         67+fsU0m76xWj4npj66rBAr+3Lb0I1JP2/Gy4/1yyJkn1g8LXyFCQDauC7+EwTTkBnkO
         tsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3M3QCeS4mDVaZbFZVmiYltyQSCr5+JmL57wgUpkLXzc=;
        b=H66KSkuCuCuolNWfQQQzALBoq1RwzGjX8NQ5C8JoYwooe3p/fXaaUVN7TiPIR5cMsP
         z1fZbvDIklBg+5dPDkxHXoW2OeMkcU81nIQ49xvOqT0FBfmvJ4s9jU2MQ+h5fCmnLgRr
         scOWJNHYEtcusg0O1bZGErtzsv7v0310bjMZlAp/dSBm9mOKru8omyXvgrtcPd/fc+Z3
         6XSV5uQlUp2c/eRrOz1Nck/u5KzmJ4p3I03os3rTCtkMX6kirSEw9MLXINVvDJ7dV/Yc
         BAg7Yv6AZx1YxjPqBrWsT3wUyO0hWHy+egNin9pAWv9ad1i7uOShOJhY4DadErzVlRqs
         rg2A==
X-Gm-Message-State: AOAM531Iqbzaye4KHIUG5l/8/NZG+mAPaPCwjtsfUtECPUtCOTrISLOm
        Luot6cHeOPTbNoN6EwqoeYaPLpbmof8z9NhlfPqgDw==
X-Google-Smtp-Source: ABdhPJwyGLgLfawjP8mPQhzHhmlLccn9z4+gou+vIr5wopKBjsNtsKAVudRS164QrP3cmG2cs0krmKoq562JK21jfOM=
X-Received: by 2002:ad4:53a1:: with SMTP id j1mr53150339qvv.25.1636085641031;
 Thu, 04 Nov 2021 21:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw99hVEJFoiBH_ZGyy=+oO-jyydoz6v1DeKPKs2HVsUH28w@mail.gmail.com>
 <CAADnVQKsK_2HHfOLs4XK7h_LC4+b7tfFw9261Psy5St8P+GWFA@mail.gmail.com>
 <YYRtFp7GOEAi7vQH@google.com> <CAADnVQ+ox52jub6naAoN7dfB4UC+D01r28ubt2Qrf+Q+g26Mmg@mail.gmail.com>
In-Reply-To: <CAADnVQ+ox52jub6naAoN7dfB4UC+D01r28ubt2Qrf+Q+g26Mmg@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 4 Nov 2021 21:13:50 -0700
Message-ID: <CAKH8qBskFaK9NE7XBuLLHqhh7RMHgWJL0_C+v+xKV74WCpCXxA@mail.gmail.com>
Subject: Re: Verifier rejects previously accepted program
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, regressions@lists.linux.dev,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 4, 2021 at 6:20 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 4, 2021 at 4:30 PM <sdf@google.com> wrote:
> >
> > On 11/04, Alexei Starovoitov wrote:
> > > On Wed, Nov 3, 2021 at 4:55 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > > > #pragma clang loop unroll(full)
> > > >     for (int b = 1 << 10; b >= 4; b >>= 1) {
> > > >         if (start + b > end) {
> > > >             continue;
> > > >         }
> > > >
> > > >         // If we do 8 byte reads, we have to handle overflows which is
> > > > slower than 4 byte reads.
> > > >         for (int i = 0; i < b; i += 4) {
> > > >             csum += *(uint32_t *)(start + i);
> > > >         }
> > > >
> > > >         start += b;
> > > >     }
> > > >     if (start + 2 <= end) {
> > > >         csum += *(uint16_t *)(start);
> > > >         start += 2;
> > > >     }
> > > >     if (start + 1 <= end) {
> > > >         csum += *(start);
> > > >     }
> >
> > > Thanks for flagging!
> > > Could you craft a test case that we can use a repro and future
> > > test case?
> >
> > > > fp-88=map_value fp-96=mmmmmmmm fp-104=map_value fp-112=inv fp-120=fp
> > > ...
> > > > I've bisected the problem to commit 3e8ce29850f1 ("bpf: Prevent
> > > > pointer mismatch in bpf_timer_init.") The commit seems unrelated to
> > > > loop processing though (it does touch the verifier however). Either I
> > > > got the bisection wrong or there is something subtle going on.
> >
> > > I stared at that commit and the example asm.
> > > I suspect the bisect went wrong.
> >
> > > Could you try reverting a single
> > > commit 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")
> > > ?
> > > The above fp-112=inv means that the verifier is tracking scalar spill.
> > > That could be the reason for bounded loop logic seeing different
> > > stack state on every iteration.
> > > But the asm snippet doesn't have the store to stack at [fp-112]
> > > location, so it could be a red herring.
> >
> > > Are you using the same llvm during bisect?
> > > The commit 354e8f1970f8 should be harmless
> > > (when commit f30d4968e9ae ("bpf: Do not reject when the stack read
> > > size is different from the tracked scalar size"))
> > > is also applied. That fix is in bpf tree only, so far.
> > > The tracking of 8-byte spill is the most useful with the latest llvm
> > > that was taught to use 8-byte aligned stack for such spills.
> >
> > > Without being able to repro it's hard to investigate much further.
> >
> > Not to derail the conversation, but we do actually see a problem
> > with commit 354e8f1970f8 ("bpf: Support <8-byte scalar spill and
> > refill"). Program that passed without it now gets:
> >
> >   R0=inv(id=0) R1_w=invP0 R2_w=invP0 R5_w=inv0 R6=ctx(id=0,off=0,imm=0)
> > R7=map_value(id=0,off=0,ks=4,vs=9616,imm=0) R8=inv(id=0)
> > R9_w=map_value(id=0,off=0,ks=4,vs=9616,imm=0) R10=fp0 fp-8=mmmm????
> > fp-16=mmmmmmmm fp-24=00000000 fp-32=inv fp-40=00000000 fp-48=inv
> > fp-56=mmmmmmmm fp-64=mmmmmmmm
> > 479: (79) r1 = *(u64 *)(r10 -32)
> > corrupted spill memory
> > processed 970 insns (limit 1000000) max_states_per_insn 2 total_states 73
> > peak_states 73 mark_read 24
>
> Stan,
> please read the 2nd part of my sentence above and try again with that patch.

Ah, sorry, I've missed that part. It does indeed fix it for me, thank you!
