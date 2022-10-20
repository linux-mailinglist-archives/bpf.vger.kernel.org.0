Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AE6605591
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 04:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJTClA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 22:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiJTCk5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 22:40:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCD416D88F
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 19:40:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h185so17971465pgc.10
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 19:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aob3cvLXgjG/VfP+QiWpBFkKraAhGNXNoj/fKiXouQk=;
        b=PkS+dID0NctJtf/cc6JXGsyZRcs7tyPyByVHL9roFOgPVXfvtOee2nSkEIF1Vot5mH
         FaKAmIYkGXfi68ylvuXGkSu6dXvYjn4nF2vALtHx773SpsOU8q4qmLJaLiuLEvibZVUK
         VRXLHfFo6+qv8GZEm5MdQOc3oaEeT7jMxRrd0bMZg/bQKeZ7iWqaDo5mxsAuqwGumVXG
         GQj3VEgVZaN/syLlfOl+46zycDquMUm4AfdeZv92UY3/pgRYy82bFIx0nakJBFJ6H24x
         zJC2XBCip3ue57YhGSKIiFnl3MryiHkmxBq+aN+I7i+wHgPfuRrxzRufAL1Lb++RwRm9
         B6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aob3cvLXgjG/VfP+QiWpBFkKraAhGNXNoj/fKiXouQk=;
        b=rJUNmpgYl7GzlaNvlfxuiYx5KP0ABqM8uCATEU+UgQyvrLFrQoY3fWZRU84/JAOz+7
         WKsAZuL7XMJyHtGLazByVaTHgkL8aLXKFOONYOnoTuSnAxSdc05seH2G0FZvUDan1kNb
         2MW8UDipZoS6kQSwCJw5FK9FoVS+HQkV88/3HO2ZfsjAZLTiZwy4kYthId/wiPwKDK2J
         nPv7wwZXHjsF/qh0nOZcrrw6vuFvi3KMBpgaRp2t88k37LCYvH3QGavFQxWpFOMiTjTI
         V4RtwoDJl58Yf2hsdCC27plgnb2pymQSHbf8afzNajrZP/7x6UzAw5bbmcKQeHv3eIq5
         0CcQ==
X-Gm-Message-State: ACrzQf2DM6oIEd0YHYVc0m9F66BueRNYOWD+1W+XqImIAzobyvfvwfAX
        CSW89d6T9KJbCldSKSXBjk6oUTjdn1u4lg==
X-Google-Smtp-Source: AMsMyM7UFyPz/McgnjkClzHdlLwr8nP3oyhy2j/8kegcUXiSNsyCWCIuECZkhU/OdDCAFUrQhUIZ8Q==
X-Received: by 2002:a05:6a00:10cf:b0:563:34ce:412f with SMTP id d15-20020a056a0010cf00b0056334ce412fmr11905704pfu.67.1666233654302;
        Wed, 19 Oct 2022 19:40:54 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id u15-20020a1709026e0f00b00176683cde9bsm11408278plk.294.2022.10.19.19.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 19:40:53 -0700 (PDT)
Date:   Thu, 20 Oct 2022 08:10:42 +0530
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
Message-ID: <20221020024042.z5y47jfv3faupecx@apollo>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-7-memxor@gmail.com>
 <CAADnVQL_CWV7auFJFnkTy6wzo28JSN2e8-H7J6AnG79ov9Zjyw@mail.gmail.com>
 <20221020010417.eqerzqjimnzwwhhd@apollo>
 <CAADnVQK+wRP1EwTcokN00_eJ+piTmJsTCj9L1uZCY9bC+Ftf=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQK+wRP1EwTcokN00_eJ+piTmJsTCj9L1uZCY9bC+Ftf=g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 20, 2022 at 07:43:16AM IST, Alexei Starovoitov wrote:
> On Wed, Oct 19, 2022 at 6:04 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Thu, Oct 20, 2022 at 12:22:56AM IST, Alexei Starovoitov wrote:
> > > On Tue, Oct 18, 2022 at 6:59 AM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > Currently, the dynptr function is not checking the variable offset part
> > > > of PTR_TO_STACK that it needs to check. The fixed offset is considered
> > > > when computing the stack pointer index, but if the variable offset was
> > > > not a constant (such that it could not be accumulated in reg->off), we
> > > > will end up a discrepency where runtime pointer does not point to the
> > > > actual stack slot we mark as STACK_DYNPTR.
> > > >
> > > > It is impossible to precisely track dynptr state when variable offset is
> > > > not constant, hence, just like bpf_timer, kptr, bpf_spin_lock, etc.
> > > > simply reject the case where reg->var_off is not constant. Then,
> > > > consider both reg->off and reg->var_off.value when computing the stack
> > > > pointer index.
> > > >
> > > > A new helper dynptr_get_spi is introduced to hide over these details
> > > > since the dynptr needs to be located in multiple places outside the
> > > > process_dynptr_func checks, hence once we know it's a PTR_TO_STACK, we
> > > > need to enforce these checks in all places.
> > > >
> > > > Note that it is disallowed for unprivileged users to have a non-constant
> > > > var_off, so this problem should only be possible to trigger from
> > > > programs having CAP_PERFMON. However, its effects can vary.
> > > >
> > > > Without the fix, it is possible to replace the contents of the dynptr
> > > > arbitrarily by making verifier mark different stack slots than actual
> > > > location and then doing writes to the actual stack address of dynptr at
> > > > runtime.
> > > >
> > > > Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  kernel/bpf/verifier.c                         | 80 +++++++++++++++----
> > > >  .../testing/selftests/bpf/prog_tests/dynptr.c |  6 +-
> > > >  .../bpf/prog_tests/kfunc_dynptr_param.c       |  2 +-
> > > >  3 files changed, 67 insertions(+), 21 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 8f667180f70f..0fd73f96c5e2 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -610,11 +610,34 @@ static void print_liveness(struct bpf_verifier_env *env,
> > > >                 verbose(env, "D");
> > > >  }
> > > >
> > > > -static int get_spi(s32 off)
> > > > +static int __get_spi(s32 off)
> > > >  {
> > > >         return (-off - 1) / BPF_REG_SIZE;
> > > >  }
> > > >
> > > > +static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > > > +{
> > > > +       int spi;
> > > > +
> > > > +       if (reg->off % BPF_REG_SIZE) {
> > > > +               verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
> > > > +               return -EINVAL;
> > > > +       }
> > >
> > > I think this cannot happen.
> > >
> >
> > There are existing selftests that trigger this.
>
> Really. Which one is that?
> Those that you've modified in this patch are hitting
> "cannot pass in dynptr..." message from the check below, no?
>

Just taking one example, invalid_read2 which does:

bpf_dynptr_read(read_data, sizeof(read_data), (void *)&ptr + 1, 0, 0);

does hit this one, it passes fp-15, no var_off.

Same with invalid_helper2 that was updated.
Same with invalid_offset that was updated.
invalid_write3 gained coverage from this patch, earlier it was probably just
being rejected because of arg_type_is_release checking spilled_ptr.id.
not_valid_dynptr is also hitting this one, not the one below.

The others now started hitting this error as the order of checks was changed in
the verifier. Since arg_type_is_release checking happens before
process_dynptr_func, it uses dynptr_get_spi to check ref_obj_id of spilled_ptr.
At that point no checks have been made of the dynptr argument, so dynptr_get_spi
is required to ensure spi is in bounds.

The reg->off % BPF_REG_SIZE was earlier in check_func_arg_reg_off but that alone
is not sufficient. This is why I wrapped everything into dynptr_get_spi.

> > Or do you mean it cannot happen anymore? If so, why?
>
> Why would it? There is an alignment check earlier.
>

I removed the one in check_func_arg_reg_off. So this is the only place now where
this alignment check happens.

> > > > +       if (!tnum_is_const(reg->var_off)) {
> > > > +               verbose(env, "dynptr has to be at the constant offset\n");
> > > > +               return -EINVAL;
> > > > +       }
> > >
> > > This part can.
> > >
> > > > +       spi = __get_spi(reg->off + reg->var_off.value);
> > > > +       if (spi < 1) {
> > > > +               verbose(env, "cannot pass in dynptr at an offset=%d\n",
> > > > +                       (int)(reg->off + reg->var_off.value));
> > > > +               return -EINVAL;
> > > > +       }
> > > > +       return spi;
> > > > +}
> > >
> > > This one is a more conservative (read: redundant) check.
> > > The is_spi_bounds_valid() is doing it better.
> >
> > The problem is, is_spi_bounds_valid returning an error is not always a problem.
> > See how in is_dynptr_reg_valid_uninit we just return true on invalid bounds,
> > then later simulate two 8-byte accesses for uninit_dynptr_regno and rely on it
> > to grow the stack depth and do MAX_BPF_STACK check.
>
> It's a weird one. I'm not sure it's actually correct to do it this way.
>

Yeah, when looking at this I was actually surprised by that return true,
thinking that was by accident and the stack depth was not being updated, but it
later happens using check_mem_access in that if block.

I'm open to other ideas, like separating out code in
check_stack_write_fixed_off, but the only issue is code divergence and we miss
checks we need to in both places due to duplication. Let me know what you think.

But however you do it, it has to be done after check_func_arg. The stack depth
should not be updated until all other arguments have been checked. If you
consider meta.access_size handling, that happens in a similar way.
