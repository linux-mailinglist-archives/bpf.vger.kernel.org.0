Return-Path: <bpf+bounces-8237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 812C2784140
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 14:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231C4280FEE
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 12:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDD91C2B1;
	Tue, 22 Aug 2023 12:53:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12FB7F
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 12:53:55 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3A8CC6
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 05:53:54 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-5256d74dab9so5407317a12.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692708833; x=1693313633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rMVUQxt7fQpbMyZe4tEoN/J8qN5BMJXRKE2pZnyQLYU=;
        b=k+ea0kfh4MFXnnhpf6Y8G3qfPPiuhVB5IJ1F0gQiQkAG3r/RgEEQqt/WIfBEVZfsep
         x6RFRuNerHlLrKds5jwu+yOqLUTyuhDM4Tmvax0NgQ08CAaWVID7+VhkGYTsWef008fO
         k1sgfZTDu0NaOsU2Dua44l7yMfJv1kmpmQ/tPzFvG7RsO+FmCJcDZhwb1sHplvoirx7f
         Z5fZKDa0XWIeh0M/Nf3wTfQl6w7hKSGgsGwukrwZhjJGzn0ftZwBFbuKyJD/ygDkY2IQ
         QXXYD2CJLtaMGryVNWgjwwAq20/hoQMVAIxZgx0c/n/SZteH2APzgPP7hetGV8TXIN7T
         QIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692708833; x=1693313633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMVUQxt7fQpbMyZe4tEoN/J8qN5BMJXRKE2pZnyQLYU=;
        b=jvR38Ekg9jC2IA2q7N5jZWRSRbXOG8bi1xJTprabOPEHj+FoqgpJMo9JgiF5zcDI1G
         FG6wBCO5RHAzoBob5Of5MUDD1+ow4iUV0qFVUzLpZb/nmaoAQ0ci6a1qkK/ibtx41d9i
         wV7BVE0RW5cTUK+9N83oUI8FkzHh9zg0jOXd0+q0NXvyMu446+1XAqeJZrkxJ+T+Tc1M
         sC+WP1C8p3mLpmoZV5KHrfG+tFz/oFdsqYgdoWZKMjwDp7sMRMjV3jOPuPHgYsMtvmMr
         uV96kD2rFDhedInFDfXRqnD+Lcoxxjj65MaCjjG4WQwx89VW6Wh5ztkXZ1ORpPjaMGO7
         dj+g==
X-Gm-Message-State: AOJu0YxOEeumj2pStdKtkjMwqaIwPDsFdDkVt02QX1hM8h96xFiFduNt
	9pgorQqnoZIkyMfvCp4TM0hroru07OpXV2Y6Y/k=
X-Google-Smtp-Source: AGHT+IEgkwsfszIRKBNz+XPNvM/iy3Y5OZ4QAvNecIkFR7MhBVPwtEi2VPxbfiOTLy/ufNB3GjPhrJwyKOSKmmaiNS8=
X-Received: by 2002:aa7:d397:0:b0:526:d6d2:aeaf with SMTP id
 x23-20020aa7d397000000b00526d6d2aeafmr5787913edq.6.1692708832393; Tue, 22 Aug
 2023 05:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809114116.3216687-1-memxor@gmail.com> <20230809114116.3216687-11-memxor@gmail.com>
 <20230822050955.lnxdmgtchhhewyax@macbook-pro-8.dhcp.thefacebook.com>
In-Reply-To: <20230822050955.lnxdmgtchhhewyax@macbook-pro-8.dhcp.thefacebook.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Aug 2023 18:23:16 +0530
Message-ID: <CAP01T7732yxTkXNtBtsLffHwmgeMcbgsmiftB+7wuM2fQWysSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 10/14] bpf: Disallow extensions to exception callbacks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 22 Aug 2023 at 10:40, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 09, 2023 at 05:11:12PM +0530, Kumar Kartikeya Dwivedi wrote:
> > During testing, it was discovered that extensions to exception callbacks
> > had no checks, upon running a testcase, the kernel ended up running off
> > the end of a program having final call as bpf_throw, and hitting int3
> > instructions.
> >
> > The reason is that while the default exception callback would have reset
> > the stack frame to return back to the main program's caller, the
> > replacing extension program will simply return back to bpf_throw, which
> > will instead return back to the program and the program will continue
> > execution, now in an undefined state where anything could happen.
> >
> > The way to support extensions to an exception callback would be to mark
> > the BPF_PROG_TYPE_EXT main subprog as an exception_cb, and prevent it
> > from calling bpf_throw. This would make the JIT produce a prologue that
> > restores saved registers and reset the stack frame. But let's not do
> > that until there is a concrete use case for this, and simply disallow
> > this for now.
> >
> > One key point here to note is that currently X86_TAIL_CALL_OFFSET didn't
> > require any modifications, even though we emit instructions before the
> > corresponding endbr64 instruction. This is because we ensure that a main
> > subprog never serves as an exception callback, and therefore the
> > exception callback (which will be a global subprog) can never serve as
> > the tail call target, eliminating any discrepancies. However, once we
> > support a BPF_PROG_TYPE_EXT to also act as an exception callback, it
> > will end up requiring change to the tail call offset to account for the
> > extra instructions. For simplicitly, tail calls could be disabled for
> > such targets.
> >
> > Noting the above, it appears better to wait for a concrete use case
> > before choosing to permit extension programs to replace exception
> > callbacks.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/helpers.c  | 1 +
> >  kernel/bpf/verifier.c | 5 +++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 64a07232c58f..a04eff53354c 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2470,6 +2470,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
> >        */
> >       kasan_unpoison_task_stack_below((void *)ctx.sp);
> >       ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
> > +     WARN(1, "A call to BPF exception callback should never return\n");
> >  }
> >
> >  __diag_pop();
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a0e1a1d1f5d3..13db1fa4163c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -19622,6 +19622,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >                                       "Extension programs should be JITed\n");
> >                               return -EINVAL;
> >                       }
> > +                     if (aux->func && aux->func[subprog]->aux->exception_cb) {
> > +                             bpf_log(log,
> > +                                     "Extension programs cannot replace exception callback\n");
> > +                             return -EINVAL;
>
> Should we disallow fentry/fexit to exception cb as well?
> Probably things will go wrong for similar reasons as freplace.
>

Yes, great catch. I think you are right. I will disable both of them as well.
Trampoline does not expect the stack frame to be reset as it pushes
data to it and will need to restore it after the call to exception cb.

> And also disallow fentry/fexit for main prog that is exception_boundary ?
> since bpf trampoline doesn't know that it needs to save r12.

Hmm, I think I should probably enable that instead of blocking it. I
think it's a common enough use case. Compared to exception cb it also
seems a valid one. We can enable pushing of r12 for such generate
trampolines, IIUC it's not a lot of complexity and we will know if we
are attaching to exception boundary prog.

In any case, I will add more selftests to ensure these cases are
handled/rejected properly in v3, thanks!

