Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71FA4276D9
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 05:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbhJIDPQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 23:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhJIDPQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 23:15:16 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC55FC061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 20:13:19 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id a7so25102317yba.6
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 20:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ttJxCFg6wk8EiELDlbBImbRqqTfObeD0o7LlOWtvcMY=;
        b=UtysZodSK1EDYOeiOLHCh1JchDDeeAiYwBX30/Q1iOSyUakXnjeXKb4QqLr4YWs2Ry
         9j0aSDI0jaYpgqa9e9Bnter4C/KFmLjYbn4jzuiu1IdU1KjrG1cKO+I43XMtNNkHtoph
         /k8KVeSRyCCIbbNMmeima2wOENSnGkPSe/IP59OiMcCGFPJBfpR4xDWobhS4T0/wrgDa
         X+L9UpeHwMRMFtW9ew1sfuXADgqcDW24CkDJOmTSI102FTIzh5Ze49YammNVHaYq9D+w
         tbGxDS3Uz5m9DKfzziRl+0+0F0TZj6DyPxdZwiQtd3sG2aXn2uPquWtaYhT/6+uZNOKw
         FBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttJxCFg6wk8EiELDlbBImbRqqTfObeD0o7LlOWtvcMY=;
        b=bRJPgOybbwU0gDzQ1PuTxG8xgvfwdOHQZGhND8tJ3EC1pOACim+wvoYJOspD2x3wbN
         vOROtG3wEfX3yWJTWdE6BcFl3oz+mepGYqS/aKDrWXNa/l/LW81vnh7ID62pXzn9l33p
         J1wqo8l1bbwPvtp1j4wNf/LYrYdyVuTVeOL/DkpM+P93ARMs+969GNSm3UaufHFxC9J9
         OM2ct5WQzdTYicmllmBMQlxjv6w002NMouZT25vyViBwKc+hsVGpsqZ/OGKvPC0G+sti
         DUclVOQmMLJG1dS9rI1DF+2AQAObS3KptrPju821TE/f8I/v+xEo0Am59CXCWG3gei28
         g0LQ==
X-Gm-Message-State: AOAM53081OypiIdZBr0oV4dwLe8Wid1A5CQXsHeHatu0cNU+RPPfR+1S
        FEmSVdb7sbO4RTUPPUkSLzkQyJxRNG2Sf8SoUg44z8t3NkE=
X-Google-Smtp-Source: ABdhPJzYcZSdYqsghbvq1deSUd52HB0ZVQDrY/5nKEXI7QYcIOKk+5FvLFTtzI+s8x6g0RMyQQNghFPsUzvaULB+K9A=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr6647397ybj.433.1633749199140;
 Fri, 08 Oct 2021 20:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-10-fallentree@fb.com>
 <CAEf4BzYO+XD9Aa0o1BWfk8q4vE3Aon12bRWJjvz6RtWrT0o=WA@mail.gmail.com> <CAJygYd39oi4UB=orVSBb_V5c6nBw6TMymq=JsbhHMsfoDOAyEQ@mail.gmail.com>
In-Reply-To: <CAJygYd39oi4UB=orVSBb_V5c6nBw6TMymq=JsbhHMsfoDOAyEQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 20:13:06 -0700
Message-ID: <CAEf4BzYeSkj4NQyHooKWt4DJNEyh_KfPGpDYhww7zhBRTdkskA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 09/14] selftests/bpf: Make uprobe tests use
 different attach functions.
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>, Song Liu <songliubraving@fb.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 3:47 PM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
>
> On Fri, Oct 8, 2021 at 3:27 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
> > >
> > > From: Yucong Sun <sunyucong@gmail.com>
> > >
> > > Using same address on different processes of the same binary often fail
> > > with EINVAL, this patch make these tests use distinct methods, so they
> > > can run in parallel.
> > >
> > > Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> > > ---
> > >  tools/testing/selftests/bpf/prog_tests/attach_probe.c | 8 ++++++--
> > >  tools/testing/selftests/bpf/prog_tests/bpf_cookie.c   | 8 ++++++--
> > >  tools/testing/selftests/bpf/prog_tests/task_pt_regs.c | 8 ++++++--
> > >  3 files changed, 18 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > > index 6c511dcd1465..eff36ba9c148 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > > @@ -5,6 +5,10 @@
> > >  /* this is how USDT semaphore is actually defined, except volatile modifier */
> > >  volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribute((section(".probes")));
> > >
> > > +static int method() {
> >
> > wrong style: { should be on separate line
> >
> > > +       return get_base_addr();
> >
> > there is nothing special about get_base_addr(), except that it's a
> > global function in a different file and won't be inlined, while this
> > method() approach has no such guarantee
> >
> > I've dropped this patch for now.
> >
> > But I'm surprised that attaching to the same uprobe few times doesn't
> > work. Song, is there anything in kernel that could cause this?
>
>
> libbpf: uprobe perf_event_open() failed: Invalid argument
> libbpf: prog 'handle_uprobe': failed to create uprobe
> '/proc/self/exe:0x144d59' perf event: Invalid argument
> uprobe_subtest:FAIL:link1 unexpected error: -22
>
> The problem only happens when several different processes of the same
> binary are trying to attach uprobe on the same function. I am guessing
> it is due to address space randomization ?

nope, we don't use address space randomization, it's the
ref_ctr_offset (normally used for USDT semaphore)

>
> I traced through the code and the EINVAL is returned right after this warning
>
> [    1.375901] ref_ctr_offset mismatch. inode: 0x55a0 offset: 0x144d59
> ref_ctr_offset(old): 0x554a00 ref_ctr_offset(new): 0x0

ah, ref_ctr_offset is probably enforced by the kernel to be the same
across all uprobes. attach_probe is the only one that's testing
ref_ctr_offset, so it should be enough to modify only that one, just
make sure you are using a non-inlined function for this.

>
>
> This could be easily be reproduced by    ./test_progs -t
> attach_probe,bpf_cookie,test_pt_regs -j
>
> >
> >
> > > +}
> > > +

[...]
