Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E1D6055AB
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 04:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJTC47 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 22:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJTC46 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 22:56:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656A79AC0F
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 19:56:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id d26so44251023ejc.8
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 19:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nJhpfyZ6nZCtPbc3HXlNb+ppGaL+AisGXeMTCvs3nPE=;
        b=hQH+24sASgcY+hl6rPfmBJiWDpBJ3yzIZg4Eak7j0x+nyvvBg6up/Ioi0vnYUqbaxU
         cgt6Uc5eN8EBvl9gUJfcr0VVkbVUKGytV50QIGE8hsWeDYfiqNM8qyvUoy5RQzBOYIh8
         9kzqhpXg7EyeVTfFcUoEPmZo05gc5GmLQYmHepueFXU/Nl4zZe/OSvnwUh1BYFFzCwNB
         kz14FNr3p7frApGbpJA/MYwPY9GUrcqokrGbD2kHRU/yVhRuDYQ3EDypaZ0QE/BLSZPb
         lXc+GcoUNejj23YQyrzYNahDqX7tPw2PQJXhXutauus2w5DaenpeuXkx8q+BdI5VXZkG
         fd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJhpfyZ6nZCtPbc3HXlNb+ppGaL+AisGXeMTCvs3nPE=;
        b=JBvjfHUQcHkeTvkNhA7JFUFIfy+p+eN7FdIGiGG9jrrCakfx6k4x4G+Ib0uikaQ00y
         cxWlQZhe83Pr46Tc2WGXwckLB5N+osKD2I7ACd9L/5SlF+JSfZXTBuRUxVvRqDuogGEB
         zgvV6TIQhO3DxgkEMQlcy0Qq1ZaloNpTH4+dFnloY+6l6SWybr4OIE7MiYUvbZq/Qxi2
         wANivvk5we51btna41KklBc95NX9ReGc6WISnJPkRh3Mx+QvHpsxwaPCvE524t0AzTP2
         dETKGbDakOyxL53do2K5wA6brwL5R/JATSB7Ud15J9Rqp66qull5BrpjH1trRrYDm3S6
         LHFg==
X-Gm-Message-State: ACrzQf0TwnWbJbEU3BBf5KjcK0BfWkIOCR43w2AHrhBOXOKtZD8DG9y4
        oHiYCNx4dtn7+q3GizJUo1TiKbwiCu899ZhXVvQ=
X-Google-Smtp-Source: AMsMyM4Swyuk7f0a1RwfNwENGMZlZKEArE6Xwy+ypFuqSvEhatiALlvSiaINYGBnj79N3khNWuSbviksu2/kuxdGq2Q=
X-Received: by 2002:a17:907:1c98:b0:78d:3b06:dc8f with SMTP id
 nb24-20020a1709071c9800b0078d3b06dc8fmr8927080ejc.58.1666234615793; Wed, 19
 Oct 2022 19:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221018135920.726360-1-memxor@gmail.com> <20221018135920.726360-7-memxor@gmail.com>
 <CAADnVQL_CWV7auFJFnkTy6wzo28JSN2e8-H7J6AnG79ov9Zjyw@mail.gmail.com>
 <20221020010417.eqerzqjimnzwwhhd@apollo> <CAADnVQK+wRP1EwTcokN00_eJ+piTmJsTCj9L1uZCY9bC+Ftf=g@mail.gmail.com>
 <20221020024042.z5y47jfv3faupecx@apollo>
In-Reply-To: <20221020024042.z5y47jfv3faupecx@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Oct 2022 19:56:44 -0700
Message-ID: <CAADnVQJ4maocpC_5PNJWM10_UkuZeHiXU9o_z3Xa685Q68Yw7g@mail.gmail.com>
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

On Wed, Oct 19, 2022 at 7:40 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, Oct 20, 2022 at 07:43:16AM IST, Alexei Starovoitov wrote:
> > On Wed, Oct 19, 2022 at 6:04 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Thu, Oct 20, 2022 at 12:22:56AM IST, Alexei Starovoitov wrote:
> > > > On Tue, Oct 18, 2022 at 6:59 AM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > > >
> > > > > Currently, the dynptr function is not checking the variable offset part
> > > > > of PTR_TO_STACK that it needs to check. The fixed offset is considered
> > > > > when computing the stack pointer index, but if the variable offset was
> > > > > not a constant (such that it could not be accumulated in reg->off), we
> > > > > will end up a discrepency where runtime pointer does not point to the
> > > > > actual stack slot we mark as STACK_DYNPTR.
> > > > >
> > > > > It is impossible to precisely track dynptr state when variable offset is
> > > > > not constant, hence, just like bpf_timer, kptr, bpf_spin_lock, etc.
> > > > > simply reject the case where reg->var_off is not constant. Then,
> > > > > consider both reg->off and reg->var_off.value when computing the stack
> > > > > pointer index.
> > > > >
> > > > > A new helper dynptr_get_spi is introduced to hide over these details
> > > > > since the dynptr needs to be located in multiple places outside the
> > > > > process_dynptr_func checks, hence once we know it's a PTR_TO_STACK, we
> > > > > need to enforce these checks in all places.
> > > > >
> > > > > Note that it is disallowed for unprivileged users to have a non-constant
> > > > > var_off, so this problem should only be possible to trigger from
> > > > > programs having CAP_PERFMON. However, its effects can vary.
> > > > >
> > > > > Without the fix, it is possible to replace the contents of the dynptr
> > > > > arbitrarily by making verifier mark different stack slots than actual
> > > > > location and then doing writes to the actual stack address of dynptr at
> > > > > runtime.
> > > > >
> > > > > Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> > > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > > ---
> > > > >  kernel/bpf/verifier.c                         | 80 +++++++++++++++----
> > > > >  .../testing/selftests/bpf/prog_tests/dynptr.c |  6 +-
> > > > >  .../bpf/prog_tests/kfunc_dynptr_param.c       |  2 +-
> > > > >  3 files changed, 67 insertions(+), 21 deletions(-)
> > > > >
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index 8f667180f70f..0fd73f96c5e2 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -610,11 +610,34 @@ static void print_liveness(struct bpf_verifier_env *env,
> > > > >                 verbose(env, "D");
> > > > >  }
> > > > >
> > > > > -static int get_spi(s32 off)
> > > > > +static int __get_spi(s32 off)
> > > > >  {
> > > > >         return (-off - 1) / BPF_REG_SIZE;
> > > > >  }
> > > > >
> > > > > +static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > > > > +{
> > > > > +       int spi;
> > > > > +
> > > > > +       if (reg->off % BPF_REG_SIZE) {
> > > > > +               verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
> > > > > +               return -EINVAL;
> > > > > +       }
> > > >
> > > > I think this cannot happen.
> > > >
> > >
> > > There are existing selftests that trigger this.
> >
> > Really. Which one is that?
> > Those that you've modified in this patch are hitting
> > "cannot pass in dynptr..." message from the check below, no?
> >
>
> Just taking one example, invalid_read2 which does:
>
> bpf_dynptr_read(read_data, sizeof(read_data), (void *)&ptr + 1, 0, 0);
>
> does hit this one, it passes fp-15, no var_off.
>
> Same with invalid_helper2 that was updated.
> Same with invalid_offset that was updated.
> invalid_write3 gained coverage from this patch, earlier it was probably just
> being rejected because of arg_type_is_release checking spilled_ptr.id.
> not_valid_dynptr is also hitting this one, not the one below.
>
> The others now started hitting this error as the order of checks was changed in
> the verifier. Since arg_type_is_release checking happens before
> process_dynptr_func, it uses dynptr_get_spi to check ref_obj_id of spilled_ptr.
> At that point no checks have been made of the dynptr argument, so dynptr_get_spi
> is required to ensure spi is in bounds.
>
> The reg->off % BPF_REG_SIZE was earlier in check_func_arg_reg_off but that alone
> is not sufficient. This is why I wrapped everything into dynptr_get_spi.

I see. That was not obvious at all that some other patch
is removing that check from check_func_arg_reg_off.

Why is the check there not sufficient?

> > > Or do you mean it cannot happen anymore? If so, why?
> >
> > Why would it? There is an alignment check earlier.
> >
>
> I removed the one in check_func_arg_reg_off. So this is the only place now where
> this alignment check happens.
>
> > > > > +       if (!tnum_is_const(reg->var_off)) {
> > > > > +               verbose(env, "dynptr has to be at the constant offset\n");
> > > > > +               return -EINVAL;
> > > > > +       }
> > > >
> > > > This part can.
> > > >
> > > > > +       spi = __get_spi(reg->off + reg->var_off.value);
> > > > > +       if (spi < 1) {
> > > > > +               verbose(env, "cannot pass in dynptr at an offset=%d\n",
> > > > > +                       (int)(reg->off + reg->var_off.value));
> > > > > +               return -EINVAL;
> > > > > +       }
> > > > > +       return spi;
> > > > > +}
> > > >
> > > > This one is a more conservative (read: redundant) check.
> > > > The is_spi_bounds_valid() is doing it better.
> > >
> > > The problem is, is_spi_bounds_valid returning an error is not always a problem.
> > > See how in is_dynptr_reg_valid_uninit we just return true on invalid bounds,
> > > then later simulate two 8-byte accesses for uninit_dynptr_regno and rely on it
> > > to grow the stack depth and do MAX_BPF_STACK check.
> >
> > It's a weird one. I'm not sure it's actually correct to do it this way.
> >
>
> Yeah, when looking at this I was actually surprised by that return true,
> thinking that was by accident and the stack depth was not being updated, but it
> later happens using check_mem_access in that if block.
>
> I'm open to other ideas, like separating out code in
> check_stack_write_fixed_off, but the only issue is code divergence and we miss
> checks we need to in both places due to duplication. Let me know what you think.

Not following. Why check_stack_write_fixed_off has to do with any of that?

The bug you're fixing is missing tnum_is_const(reg->var_off), right?
All other changes make it hard to understand what is going on.

> But however you do it, it has to be done after check_func_arg. The stack depth
> should not be updated until all other arguments have been checked. If you
> consider meta.access_size handling, that happens in a similar way.

Not following.
