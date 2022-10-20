Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30A16054AB
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 03:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJTBEf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 21:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJTBEe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 21:04:34 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABAA24979
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 18:04:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c24so18885952plo.3
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 18:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xN0kV51CWcybAistt3Ae1nkzLAwzdA+RplZD0qAc7SY=;
        b=OUj9+1s1yO7cJ2qT5Ti6RjixAGDTaTRvc/uumzzDarB2Rh8c+m/JLKz0djXBPQyJmt
         X9QDuurNNR1L8uaqt6Rr9l6zb27c6pm9hdxYVRU8+vPgNZvrCRy9Yw3Ap3IuTBi0DNQW
         X+P1c8/W7zzU105SI9urCnZoA7xKBgOcdf/wmisMGWVnNrmFV8wytq+gCw3yuaRKCL89
         HjrqLIocG+HIKblEz74qt166Na+ii4yAIxelgT2yBOGeTyVYirrvv835FoyLk/f+G1xI
         LCjhdzvD5NzqwBrk/IZ79H67g2/ar4549DB9n7csSm0+HrXMINIzlYhc9b3kDpm8VbBA
         Gxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xN0kV51CWcybAistt3Ae1nkzLAwzdA+RplZD0qAc7SY=;
        b=IQGRRyFkT4EPHzqJoTWAqSXehGlLur63E+yPuOFMB01eDOsv0fnf0IiCOvV7nzq7S4
         X7yOiQVYToL75cPVg5Hvn+oiwKtwsGZDijytKWMtNq38uU7Wc63Usn1TZ6fNX5EBIjk4
         /BTBKgmFdB4rXW86J9jr8gf+Z3DUpBY7/OGsruznOCz/wbrmlsm1t8xrxph0oPWXhOg9
         sGsGe5RmVoYUYsbUbh5+JRbUmwvPTxl6nTVQHpe/iy2TcZRWEWyUKwofYLN1MUJNU7Xw
         6jap1LGduCQoyVRUdrGEzPF1OYvDuUeLDFVIRq2FlvjATpmVvfHOLLBsBcx2Zy6RJKxY
         6SYg==
X-Gm-Message-State: ACrzQf09A402jP6CxpXdz2vDNEMMGzoN8WQpDN6j7ew+xIW7EL1qX7LZ
        tshhaO4SEfmUk0951UwVzirHr1Usz4JdKA==
X-Google-Smtp-Source: AMsMyM77a9I8DhHLuvQTlIxUfBrt/epzUgz+5i17Df7qF0qMiQ1E0X5z3Hm2YKJVnsh7v7ko3lG3fQ==
X-Received: by 2002:a17:90b:1d04:b0:20b:cb40:4b3 with SMTP id on4-20020a17090b1d0400b0020bcb4004b3mr12543716pjb.215.1666227869002;
        Wed, 19 Oct 2022 18:04:29 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id 64-20020a620543000000b005632c49693asm11840382pff.202.2022.10.19.18.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 18:04:28 -0700 (PDT)
Date:   Thu, 20 Oct 2022 06:34:17 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v1 06/13] bpf: Fix missing var_off check for
 ARG_PTR_TO_DYNPTR
Message-ID: <20221020010417.eqerzqjimnzwwhhd@apollo>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-7-memxor@gmail.com>
 <CAADnVQL_CWV7auFJFnkTy6wzo28JSN2e8-H7J6AnG79ov9Zjyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQL_CWV7auFJFnkTy6wzo28JSN2e8-H7J6AnG79ov9Zjyw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 20, 2022 at 12:22:56AM IST, Alexei Starovoitov wrote:
> On Tue, Oct 18, 2022 at 6:59 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Currently, the dynptr function is not checking the variable offset part
> > of PTR_TO_STACK that it needs to check. The fixed offset is considered
> > when computing the stack pointer index, but if the variable offset was
> > not a constant (such that it could not be accumulated in reg->off), we
> > will end up a discrepency where runtime pointer does not point to the
> > actual stack slot we mark as STACK_DYNPTR.
> >
> > It is impossible to precisely track dynptr state when variable offset is
> > not constant, hence, just like bpf_timer, kptr, bpf_spin_lock, etc.
> > simply reject the case where reg->var_off is not constant. Then,
> > consider both reg->off and reg->var_off.value when computing the stack
> > pointer index.
> >
> > A new helper dynptr_get_spi is introduced to hide over these details
> > since the dynptr needs to be located in multiple places outside the
> > process_dynptr_func checks, hence once we know it's a PTR_TO_STACK, we
> > need to enforce these checks in all places.
> >
> > Note that it is disallowed for unprivileged users to have a non-constant
> > var_off, so this problem should only be possible to trigger from
> > programs having CAP_PERFMON. However, its effects can vary.
> >
> > Without the fix, it is possible to replace the contents of the dynptr
> > arbitrarily by making verifier mark different stack slots than actual
> > location and then doing writes to the actual stack address of dynptr at
> > runtime.
> >
> > Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/verifier.c                         | 80 +++++++++++++++----
> >  .../testing/selftests/bpf/prog_tests/dynptr.c |  6 +-
> >  .../bpf/prog_tests/kfunc_dynptr_param.c       |  2 +-
> >  3 files changed, 67 insertions(+), 21 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8f667180f70f..0fd73f96c5e2 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -610,11 +610,34 @@ static void print_liveness(struct bpf_verifier_env *env,
> >                 verbose(env, "D");
> >  }
> >
> > -static int get_spi(s32 off)
> > +static int __get_spi(s32 off)
> >  {
> >         return (-off - 1) / BPF_REG_SIZE;
> >  }
> >
> > +static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > +{
> > +       int spi;
> > +
> > +       if (reg->off % BPF_REG_SIZE) {
> > +               verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
> > +               return -EINVAL;
> > +       }
>
> I think this cannot happen.
>

There are existing selftests that trigger this.
Or do you mean it cannot happen anymore? If so, why?

> > +       if (!tnum_is_const(reg->var_off)) {
> > +               verbose(env, "dynptr has to be at the constant offset\n");
> > +               return -EINVAL;
> > +       }
>
> This part can.
>
> > +       spi = __get_spi(reg->off + reg->var_off.value);
> > +       if (spi < 1) {
> > +               verbose(env, "cannot pass in dynptr at an offset=%d\n",
> > +                       (int)(reg->off + reg->var_off.value));
> > +               return -EINVAL;
> > +       }
> > +       return spi;
> > +}
>
> This one is a more conservative (read: redundant) check.
> The is_spi_bounds_valid() is doing it better.

The problem is, is_spi_bounds_valid returning an error is not always a problem.
See how in is_dynptr_reg_valid_uninit we just return true on invalid bounds,
then later simulate two 8-byte accesses for uninit_dynptr_regno and rely on it
to grow the stack depth and do MAX_BPF_STACK check.

> How about keeping get_spi(reg) as error free and use it
> directly in places where it cannot fail without
> defensive WARN_ON_ONCE.
> int get_spi(reg)
> { return (-reg->off - reg->var_off.value - 1) / BPF_REG_SIZE; }
>
> While moving tnum_is_const() check into is_spi_bounds_valid() ?
>
> Like is_spi_bounds_valid(state, reg, spi) ?
>
> We should probably remove BPF_DYNPTR_NR_SLOTS since
> there are so many other places where dynptr is assumed
> to be 16-bytes. That macro doesn't help at all.
> It only causes confusion.
>
> I guess we can replace is_spi_bounds_valid() with a differnet
> helper that checks and computes spi.
> Like get_spi_and_check(state, reg, &spi)
> and use it in places where we have get_spi + is_spi_bounds_valid
> while using unchecked get_spi where it cannot fail?
>
> If we only have get_spi_and_check() we'd have to add
> WARN_ON_ONCE in a few places and that bothers me...
> due to defensive programming...
> If code is so complex that we cannot think it through
> we have to refactor it. Sprinkling WARN_ON_ONCE (just to be sure)
> doesn't inspire confidence.
>

I will think about this and reply later today.
