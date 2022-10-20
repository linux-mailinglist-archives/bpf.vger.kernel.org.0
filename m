Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38191605557
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 04:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiJTCNg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 22:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJTCNf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 22:13:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDAD165CA1
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 19:13:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a26so43740632ejc.4
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 19:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=krp2DgiXV7oTaPodHOaJ27Wv204pDqhQacd6WHIvjGQ=;
        b=lwR4WgPlsQtPi8dSPd6hNHCe1fX6EtYVzcza/tAOl1d/XjZExjN8mSaYJP94lqGVlc
         nDxKawjLcfWOvwED028CaCCWKztEF0FT608nqmlJ8ul4XZkK+Ob1/L/wkJ+6XMfCqYRq
         4zMANYf0d8L59EfGWRmmKxc3oaOucONjurZluCUIMSeBK76lO1mdaRQKsWsFfr4D5JLB
         1FkSfMvGW7Wl4XiK0zF+XiQOw5v7pp6B436jlbZ6nGjEiYp0Nqe62FZjQ6G0YBeYQMn+
         4Fj2zqct3JjSmWuc8LXF88uLyGsS+Cajp5iEvYGPpeGQSDD2VINsP1AAZ30K3OaFEZ3o
         VgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krp2DgiXV7oTaPodHOaJ27Wv204pDqhQacd6WHIvjGQ=;
        b=U52M8Cu+DFsdzQ0gfVhuWI+baIx3OV2g1jNlSGLpMxoo+dqBjaO+pplXdg6wCFFUvv
         6yVu1hUVhy1J+4JcA604Ap0XOxMbR3J8g0gxmddTF8SNdZe+JzEdp2MU1Yt4VOLPe3wZ
         0DFvmure1Ca9aSW4S5jb5IE5GxJ5Stck3buEncU4B88u3wX2/sXbVVfhbuLUYTXVRSZj
         2TKn+47HB7VR4vQc8aKsfRv/mto8ClYOA1jjsILJp9vz0YNru/zGyKgei73yo78GwC+f
         pdA0+aaB3//ucFBqLm9s1aFTkjqdko2jbZh7r1bZ5Z1LUNrXNXFLRYbj7G01Q+oA99p4
         AZcw==
X-Gm-Message-State: ACrzQf1VvXWcTE+gYDojVtD7jIo4FAL7ZZVocLFOzAIEs3RfNMf7MtEm
        PfuLcxJgJXzI6MBQF++oKz2o+c52plEUHyxfe3SkHIX8
X-Google-Smtp-Source: AMsMyM5CabZgPgYGq+AoQyW8hylit0j+6O8+lIZ3iYx99x7UoZ1GKLc4ETe2kO9Abr/6XqIgHj+RKNeqy2b/pfVkZUE=
X-Received: by 2002:a17:906:fe45:b0:788:15a5:7495 with SMTP id
 wz5-20020a170906fe4500b0078815a57495mr9218442ejb.633.1666232007987; Wed, 19
 Oct 2022 19:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221018135920.726360-1-memxor@gmail.com> <20221018135920.726360-7-memxor@gmail.com>
 <CAADnVQL_CWV7auFJFnkTy6wzo28JSN2e8-H7J6AnG79ov9Zjyw@mail.gmail.com> <20221020010417.eqerzqjimnzwwhhd@apollo>
In-Reply-To: <20221020010417.eqerzqjimnzwwhhd@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Oct 2022 19:13:16 -0700
Message-ID: <CAADnVQK+wRP1EwTcokN00_eJ+piTmJsTCj9L1uZCY9bC+Ftf=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 06/13] bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
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

On Wed, Oct 19, 2022 at 6:04 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, Oct 20, 2022 at 12:22:56AM IST, Alexei Starovoitov wrote:
> > On Tue, Oct 18, 2022 at 6:59 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > Currently, the dynptr function is not checking the variable offset part
> > > of PTR_TO_STACK that it needs to check. The fixed offset is considered
> > > when computing the stack pointer index, but if the variable offset was
> > > not a constant (such that it could not be accumulated in reg->off), we
> > > will end up a discrepency where runtime pointer does not point to the
> > > actual stack slot we mark as STACK_DYNPTR.
> > >
> > > It is impossible to precisely track dynptr state when variable offset is
> > > not constant, hence, just like bpf_timer, kptr, bpf_spin_lock, etc.
> > > simply reject the case where reg->var_off is not constant. Then,
> > > consider both reg->off and reg->var_off.value when computing the stack
> > > pointer index.
> > >
> > > A new helper dynptr_get_spi is introduced to hide over these details
> > > since the dynptr needs to be located in multiple places outside the
> > > process_dynptr_func checks, hence once we know it's a PTR_TO_STACK, we
> > > need to enforce these checks in all places.
> > >
> > > Note that it is disallowed for unprivileged users to have a non-constant
> > > var_off, so this problem should only be possible to trigger from
> > > programs having CAP_PERFMON. However, its effects can vary.
> > >
> > > Without the fix, it is possible to replace the contents of the dynptr
> > > arbitrarily by making verifier mark different stack slots than actual
> > > location and then doing writes to the actual stack address of dynptr at
> > > runtime.
> > >
> > > Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c                         | 80 +++++++++++++++----
> > >  .../testing/selftests/bpf/prog_tests/dynptr.c |  6 +-
> > >  .../bpf/prog_tests/kfunc_dynptr_param.c       |  2 +-
> > >  3 files changed, 67 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 8f667180f70f..0fd73f96c5e2 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -610,11 +610,34 @@ static void print_liveness(struct bpf_verifier_env *env,
> > >                 verbose(env, "D");
> > >  }
> > >
> > > -static int get_spi(s32 off)
> > > +static int __get_spi(s32 off)
> > >  {
> > >         return (-off - 1) / BPF_REG_SIZE;
> > >  }
> > >
> > > +static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > > +{
> > > +       int spi;
> > > +
> > > +       if (reg->off % BPF_REG_SIZE) {
> > > +               verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
> > > +               return -EINVAL;
> > > +       }
> >
> > I think this cannot happen.
> >
>
> There are existing selftests that trigger this.

Really. Which one is that?
Those that you've modified in this patch are hitting
"cannot pass in dynptr..." message from the check below, no?

> Or do you mean it cannot happen anymore? If so, why?

Why would it? There is an alignment check earlier.

> > > +       if (!tnum_is_const(reg->var_off)) {
> > > +               verbose(env, "dynptr has to be at the constant offset\n");
> > > +               return -EINVAL;
> > > +       }
> >
> > This part can.
> >
> > > +       spi = __get_spi(reg->off + reg->var_off.value);
> > > +       if (spi < 1) {
> > > +               verbose(env, "cannot pass in dynptr at an offset=%d\n",
> > > +                       (int)(reg->off + reg->var_off.value));
> > > +               return -EINVAL;
> > > +       }
> > > +       return spi;
> > > +}
> >
> > This one is a more conservative (read: redundant) check.
> > The is_spi_bounds_valid() is doing it better.
>
> The problem is, is_spi_bounds_valid returning an error is not always a problem.
> See how in is_dynptr_reg_valid_uninit we just return true on invalid bounds,
> then later simulate two 8-byte accesses for uninit_dynptr_regno and rely on it
> to grow the stack depth and do MAX_BPF_STACK check.

It's a weird one. I'm not sure it's actually correct to do it this way.

> > How about keeping get_spi(reg) as error free and use it
> > directly in places where it cannot fail without
> > defensive WARN_ON_ONCE.
> > int get_spi(reg)
> > { return (-reg->off - reg->var_off.value - 1) / BPF_REG_SIZE; }
> >
> > While moving tnum_is_const() check into is_spi_bounds_valid() ?
> >
> > Like is_spi_bounds_valid(state, reg, spi) ?
> >
> > We should probably remove BPF_DYNPTR_NR_SLOTS since
> > there are so many other places where dynptr is assumed
> > to be 16-bytes. That macro doesn't help at all.
> > It only causes confusion.
> >
> > I guess we can replace is_spi_bounds_valid() with a differnet
> > helper that checks and computes spi.
> > Like get_spi_and_check(state, reg, &spi)
> > and use it in places where we have get_spi + is_spi_bounds_valid
> > while using unchecked get_spi where it cannot fail?
> >
> > If we only have get_spi_and_check() we'd have to add
> > WARN_ON_ONCE in a few places and that bothers me...
> > due to defensive programming...
> > If code is so complex that we cannot think it through
> > we have to refactor it. Sprinkling WARN_ON_ONCE (just to be sure)
> > doesn't inspire confidence.
> >
>
> I will think about this and reply later today.
