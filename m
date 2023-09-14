Return-Path: <bpf+bounces-10008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 975227A0389
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 14:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4661F23510
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540DB21A04;
	Thu, 14 Sep 2023 12:13:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D520B2B
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 12:13:43 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A1A1FC9
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 05:13:43 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-9adb9fa7200so131140566b.0
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 05:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694693621; x=1695298421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RTXlV2LvqMCVJ/I2tg55mmX5FwjBNIrWdoJP8/3/mBM=;
        b=FLPrSktjhG9V0td20rJQ9hRHptcv3cxadQbhNhRAUHKsm0ow4hQttvrYmVoQVq6QBS
         x0VP79QMYtN+gmeJVXiNvhoihrZSqatCtvkV5Xchgb4f8+lagtW3pdq5GvqbbIulGdYg
         cB/P244xAMwQACtwNX/c8G2qejEGanOE59T5d8D4nBf8a5LC9hKSQxl1OmuyGb4K1AOP
         sAAaRiPDGJzJPbXj/IslI0GkhTJLlg0zG6pPfyhmRy2FG+ZV9+1Wz2pnr+lLqi70tQxZ
         7M0mIRCHLlea/bpB4NMnksUDWOtiF3DqVBpPKWZET7TPqz2ubt2/IjBuDyTmX1zRYbwT
         wcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694693621; x=1695298421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTXlV2LvqMCVJ/I2tg55mmX5FwjBNIrWdoJP8/3/mBM=;
        b=advlykge+Af6F3+rg+KXe7ZAjknLRWF+c5TCScE2ZtnR/8IJW8Eo1LfCa1JbyCxQ/a
         Axl0u4kadyKMc3snfm03WyOpHUO6pKbkBXemtwZyyue5aJLnDIkYYYjCeRcrCq2jyTzU
         W8ZAHQoktN0PlsDKJui307h46xbGJ3cnt8YV2N2keajza5AzidhE01OeEs+bgINP+JSI
         H961AOOgX3Uz6EUM8j4MCLFy/s9juCdRHvV1DKh9sB1Jav67ZC4Uc/XCSGBaC33nZdR6
         CumU0R7JN8hQglUFB5/3dtugPyNzLmvpk9yCn8AUz1Q/vlvQGZzB6SyXiL+945i1a4HO
         UTdw==
X-Gm-Message-State: AOJu0YysuWsQTD8J2ohfcjmTcI7Mz/XXr99M3eeuBao5r/ulttIufS4D
	MhqYa6MayKwrGJEkI0T9ziVm5DmZUu9Vo5Ut7/A=
X-Google-Smtp-Source: AGHT+IE6ld5Q8C7HJHZrvfzgIt41swFKh3mx12aVzHq0+v4lPON2P3v9G1IixrSV6sEPOXHii6gHKC4gMG2qNDWE6UU=
X-Received: by 2002:a17:907:6091:b0:9aa:1794:945b with SMTP id
 ht17-20020a170907609100b009aa1794945bmr2457519ejc.22.1694693621334; Thu, 14
 Sep 2023 05:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912233214.1518551-1-memxor@gmail.com> <20230912233214.1518551-13-memxor@gmail.com>
 <mb61pmsxq14h4.fsf@amazon.com>
In-Reply-To: <mb61pmsxq14h4.fsf@amazon.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 14 Sep 2023 14:13:05 +0200
Message-ID: <CAP01T7691P9m4ZrDQk63waC9wGu3ToK-cznsHha-r6Lteh0fWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 12/17] bpf: Disallow fentry/fexit/freplace for
 exception callbacks
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Sept 2023 at 17:24, Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> On Wed, Sep 13 2023, Kumar Kartikeya Dwivedi wrote:
>
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
> > Similar issues will exist for fentry and fexit cases, where trampoline
> > saves data on the stack when invoking exception callback, which however
> > will then end up resetting the stack frame, and on return, the fexit
> > program will never will invoked as the return address points to the main
> > program's caller in the kernel. Instead of additional complexity and
> > back and forth between the two stacks to enable such a use case, simply
> > forbid it.
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
> > As a precaution, we disable fentry and fexit for exception callbacks as
> > well.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/helpers.c  |  1 +
> >  kernel/bpf/verifier.c | 11 +++++++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 2c8e1ee97b71..7ff2a42f1996 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2490,6 +2490,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
> >        */
> >       kasan_unpoison_task_stack_below((void *)ctx.sp);
> >       ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
> > +     WARN(1, "A call to BPF exception callback should never return\n");
> >  }
> >
> >  __diag_pop();
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0ba32b626320..21e37e46d792 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -19750,6 +19750,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >                       bpf_log(log, "Subprog %s doesn't exist\n", tname);
> >                       return -EINVAL;
> >               }
> > +             if (aux->func && aux->func[subprog]->aux->exception_cb) {
> > +                     bpf_log(log,
> > +                             "%s programs cannot attach to exception callback\n",
> > +                             prog_extension ? "Extension" : "FENTRY/FEXIT");
> > +                     return -EINVAL;
> > +             }
> >               conservative = aux->func_info_aux[subprog].unreliable;
> >               if (prog_extension) {
> >                       if (conservative) {
> > @@ -19762,6 +19768,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >                                       "Extension programs should be JITed\n");
> >                               return -EINVAL;
> >                       }
> > +                     if (aux->func && aux->func[subprog]->aux->exception_cb) {
> > +                             bpf_log(log,
> > +                                     "Extension programs cannot replace exception callback\n");
> > +                             return -EINVAL;
> > +                     }
>
> This check is redundant because you already did this check above if (prog_extension branch)
> Remove this as it will never be reached.
>

Good catch, will fix it in v4.

>
> >               }
> >               if (!tgt_prog->jited) {
> >                       bpf_log(log, "Can attach to only JITed progs\n");
>
>
> Thanks,
> Puranjay

