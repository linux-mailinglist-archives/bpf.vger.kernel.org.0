Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B65646139
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 19:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiLGSkK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 13:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGSkJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 13:40:09 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B2E47328
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 10:40:08 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id x22so16049157ejs.11
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 10:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bKmd2QtSd2f/v7TU2vbNli8N3WDvRTVA09u/XHJG+A0=;
        b=hcFZr32FVbzreyNDsW1ILudfw1mZ8IPfXC2GTyo/gHpvtVTkUIbeFPhDcGkckE0irZ
         1XwyVT4fBYW/dYnJpdttNtTkwEJXujehe4t8FlmzwBGfIVyDSVYG3pWy4nSfnP31cZAl
         X5kSji8/+gUwFqq3XlP8ZkpM6ZRRLKT6FINeItIySnmavBr5ZB13GYUWHT51geUvwX1K
         INBZAbfAPRktlkG56PzgvupmW+W07U8l0lERRmKiEBvbwBA3FUikBkCRYKk9yF4W5k3s
         RnIhH8EhE+fRJw+2T6cojJTBlefzDnnbvCv77aPiMbu+2/ZR/nfp02ETWSKWOmYR+QLp
         fJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKmd2QtSd2f/v7TU2vbNli8N3WDvRTVA09u/XHJG+A0=;
        b=em3kpUn6eyls9MnuG3F5HbY99CHYJXLRBegVVI1zewZqxcaBItO9ktD0amJ9HXTy1i
         I2bEyNGrKCQDFf/clcpvTifLyuzxyyLxCyXw0vh2wJivY9P94GCgRtZPcnZwK3N/GPF3
         dPNsYY0Sk+5bF46alVytI2ezQkVw5JD5VYVyknQ+y2ysE7o+x5hxOztZ8HVSagTl6uKL
         gYSw5CyFSdJZsS2cN06QhswnE8CGUpwLVXU1Fso23yyaPMYJaWxKnhOI7Cc0lUhApRji
         BJbN4AngaaUsch/0eHoBGO10mlbFbvwaiI7EqjbgcENeBGjqvBQd5Jn4F6dVauCrdAqv
         Jnvg==
X-Gm-Message-State: ANoB5plvyDEO8mHL+/ZwCgAI2926i5l7Yp2M6QZZlMhRow5731lp/kgM
        RTzfNh3O2Y2t/pdRvlENivtoYpUn6fdgYh5FCyg=
X-Google-Smtp-Source: AA0mqf4R1B8u0CG7ciiVa0miQvDz03Vd+NhRK//t0k/WqGUmbZbRz2FRcjwceplqx9RVltNEHW+/yEeEhlxNOxokwrY=
X-Received: by 2002:a17:906:4b08:b0:7c0:f2cf:3515 with SMTP id
 y8-20020a1709064b0800b007c0f2cf3515mr12310622eju.327.1670438407291; Wed, 07
 Dec 2022 10:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20221206233345.438540-1-andrii@kernel.org> <20221206233345.438540-4-andrii@kernel.org>
 <20221207031739.nvxsahedtr2ogv6j@macbook-pro-6.dhcp.thefacebook.com> <CAEf4BzY0rKAPgj7skj5fvOAjN-R1=255L3J=OeiNBz1mzvBSeQ@mail.gmail.com>
In-Reply-To: <CAEf4BzY0rKAPgj7skj5fvOAjN-R1=255L3J=OeiNBz1mzvBSeQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 7 Dec 2022 10:39:56 -0800
Message-ID: <CAADnVQ+239F8Yaom+d1b60fUNjPdq2ARJJDHaktkXsBNk8_q7w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/3] bpf: remove unnecessary prune and jump points
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 7, 2022 at 10:36 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Dec 6, 2022 at 7:17 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Dec 06, 2022 at 03:33:45PM -0800, Andrii Nakryiko wrote:
> > > Don't mark some instructions as jump points when there are actually no
> > > jumps and instructions are just processed sequentially. Such case is
> > > handled naturally by precision backtracking logic without the need to
> > > update jump history. See get_prev_insn_idx(). It goes back linearly by
> > > one instruction, unless current top of jmp_history is pointing to
> > > current instruction. In such case we use `st->jmp_history[cnt - 1].prev_idx`
> > > to find instruction from which we jumped to the current instruction
> > > non-linearly.
> > >
> > > Also remove both jump and prune point marking for instruction right
> > > after unconditional jumps, as program flow can get to the instruction
> > > right after unconditional jump instruction only if there is a jump to
> > > that instruction from somewhere else in the program. In such case we'll
> > > mark such instruction as prune/jump point because it's a destination of
> > > a jump.
> > >
> > > This change has no changes in terms of number of instructions or states
> > > processes across Cilium and selftests programs.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/bpf/verifier.c | 34 ++++++++++------------------------
> > >  1 file changed, 10 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index b1feb8d3c42e..4f163a28ab59 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -12228,13 +12228,12 @@ static int visit_func_call_insn(int t, int insn_cnt,
> > >       if (ret)
> > >               return ret;
> > >
> > > -     if (t + 1 < insn_cnt) {
> > > -             mark_prune_point(env, t + 1);
> > > -             mark_jmp_point(env, t + 1);
> > > -     }
> > > +     mark_prune_point(env, t + 1);
> > > +     /* when we exit from subprog, we need to record non-linear history */
> > > +     mark_jmp_point(env, t + 1);
> > > +
> >
> > With this we probably should remove 'insn_cnt' from visit_func_call_insn().
> > and in-turn from visit_insn() as well.
> > Pls consider as a follow up.
>
> Yep, will do, didn't notice it's not needed anymore.

Thanks

> BTW, no one asked why it was ok to drop the `if (t + 1 < insns_cnt)`
> check, I was a bit surprised. But this is because push_insns() already
> validates that t+1 is correct and doesn't go beyond the insns array,
> so this was not needed in the first place.

Correct. I read the code the same way.
I was a bit concerned whether insn_cnt is always equal to env->prog->len.
I thought we're tightening insn_cnt to be the subprog insn_cnt only.
But that doesn't look to be the case.
So looks safe to remove that 'if' and hence insn_cnt is useless too,
since it's the same as env->prog->len.
