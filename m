Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFCA606D42
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 03:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJUByP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 21:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJUByO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 21:54:14 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5AD158180
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 18:54:12 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 3so1230525pfw.4
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 18:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OaFmk9uKiWcRGJhsbfMXJYmOSEPGwWNHINoz9quSM5k=;
        b=QbnxZmvx/o1wWMFqmRsdSo7ANwskaXmCmFyvzBTmxCykeX1s6Iv9CvTMHXsnmBu0jX
         UVOkQqVQbckQ+sW6dman5oSadEPxeMTbmKoePQnTX0aiB9JTxNpvr9hJ5oHAMS4alcpU
         9oa9W2JSF/iqH4ZMQrk5fk6jL0BP/GM2omLqUeYHP1hOmOaSR75hWqEbvjusav20yBB7
         kHzg5x38Ufir2/IGsoLuhyOAw6vUiRw7MmIOoukn6WrTmyw9WsMQHoSShPgMaghiKNbh
         2HImBoREw5q5AlP/ULTPo9wZM2G7JD4oF6nyd9psyFxsrqY7xSwI0bJc4EtVQ+wfggmA
         CHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaFmk9uKiWcRGJhsbfMXJYmOSEPGwWNHINoz9quSM5k=;
        b=ZS8P61nmGwhlY/8Mcz5BOmslRpfRhos93sPtdckY3i/H6AG0v1zm1pxwM77eDGBRW6
         LvliFDQnGPuankbozzr/a/poCkjF4DozspoBSlqlO0/VQOZfqsDD8wct9gSlN3DweWJA
         L4TBmAWWj7/5ociEPdxvquseEsPVUCse2NnaHY5Tv6nAg+4I3i19inPzMVal+dAQ15FV
         lQop3oqsGNcGI7nkYZOC99PwVm4zPx86Y6ziHHo+tFe5XF1RGbDnZ9cK+6UCwSR5ulpD
         WB540w0vTvmsyq0R4S/gqbBjAnJmz7V/jMrZSgabK3K/w1BrEq0t9+wlWyB0zoAGAXar
         BlnA==
X-Gm-Message-State: ACrzQf2vTJ8TPQnZ9B/11nwZrEX1QwAdnISEj2WqgiRImiBkR7H9BpXe
        A+HHYLeqDVpOkkONdPb0NrFrelOvkyg6eA==
X-Google-Smtp-Source: AMsMyM5F8vPr6ZhylSatkF2La0PNCmJztJQfJqt6MendT37ATvo1JGX3wqhJUhj+f6jRwCd300FhUQ==
X-Received: by 2002:a63:2bd4:0:b0:451:5df1:4b15 with SMTP id r203-20020a632bd4000000b004515df14b15mr14496310pgr.518.1666317252200;
        Thu, 20 Oct 2022 18:54:12 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902d4c200b0017dd8c8009esm11281708plg.4.2022.10.20.18.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 18:54:11 -0700 (PDT)
Date:   Fri, 21 Oct 2022 07:23:57 +0530
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
Message-ID: <20221021015357.vs5zsyqwjigtbz7n@apollo>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-7-memxor@gmail.com>
 <CAADnVQL_CWV7auFJFnkTy6wzo28JSN2e8-H7J6AnG79ov9Zjyw@mail.gmail.com>
 <20221020010417.eqerzqjimnzwwhhd@apollo>
 <CAADnVQK+wRP1EwTcokN00_eJ+piTmJsTCj9L1uZCY9bC+Ftf=g@mail.gmail.com>
 <20221020024042.z5y47jfv3faupecx@apollo>
 <CAADnVQJ4maocpC_5PNJWM10_UkuZeHiXU9o_z3Xa685Q68Yw7g@mail.gmail.com>
 <20221020032345.yz6cvprlx2q37zcy@apollo>
 <20221021004627.3cvwrvlsxyqzk5yg@MacBook-Pro-4.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021004627.3cvwrvlsxyqzk5yg@MacBook-Pro-4.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 06:16:27AM IST, Alexei Starovoitov wrote:
> On Thu, Oct 20, 2022 at 08:53:45AM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Thu, Oct 20, 2022 at 08:26:44AM IST, Alexei Starovoitov wrote:
> > > On Wed, Oct 19, 2022 at 7:40 PM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Thu, Oct 20, 2022 at 07:43:16AM IST, Alexei Starovoitov wrote:
> > > > > On Wed, Oct 19, 2022 at 6:04 PM Kumar Kartikeya Dwivedi
> > > > > <memxor@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 20, 2022 at 12:22:56AM IST, Alexei Starovoitov wrote:
> > > > > > > On Tue, Oct 18, 2022 at 6:59 AM Kumar Kartikeya Dwivedi
> > > > > > > <memxor@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Currently, the dynptr function is not checking the variable offset part
> > > > > > > > of PTR_TO_STACK that it needs to check. The fixed offset is considered
> > > > > > > > when computing the stack pointer index, but if the variable offset was
> > > > > > > > not a constant (such that it could not be accumulated in reg->off), we
> > > > > > > > will end up a discrepency where runtime pointer does not point to the
> > > > > > > > actual stack slot we mark as STACK_DYNPTR.
> > > > > > > >
> > > > > > > > It is impossible to precisely track dynptr state when variable offset is
> > > > > > > > not constant, hence, just like bpf_timer, kptr, bpf_spin_lock, etc.
> > > > > > > > simply reject the case where reg->var_off is not constant. Then,
> > > > > > > > consider both reg->off and reg->var_off.value when computing the stack
> > > > > > > > pointer index.
> > > > > > > >
> > > > > > > > A new helper dynptr_get_spi is introduced to hide over these details
> > > > > > > > since the dynptr needs to be located in multiple places outside the
> > > > > > > > process_dynptr_func checks, hence once we know it's a PTR_TO_STACK, we
> > > > > > > > need to enforce these checks in all places.
> > > > > > > >
> > > > > > > > Note that it is disallowed for unprivileged users to have a non-constant
> > > > > > > > var_off, so this problem should only be possible to trigger from
> > > > > > > > programs having CAP_PERFMON. However, its effects can vary.
> > > > > > > >
> > > > > > > > Without the fix, it is possible to replace the contents of the dynptr
> > > > > > > > arbitrarily by making verifier mark different stack slots than actual
> > > > > > > > location and then doing writes to the actual stack address of dynptr at
> > > > > > > > runtime.
> > > > > > > >
> > > > > > > > Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> > > > > > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > > > > > ---
> > > > > > > >  kernel/bpf/verifier.c                         | 80 +++++++++++++++----
> > > > > > > >  .../testing/selftests/bpf/prog_tests/dynptr.c |  6 +-
> > > > > > > >  .../bpf/prog_tests/kfunc_dynptr_param.c       |  2 +-
> > > > > > > >  3 files changed, 67 insertions(+), 21 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > > > index 8f667180f70f..0fd73f96c5e2 100644
> > > > > > > > --- a/kernel/bpf/verifier.c
> > > > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > > > @@ -610,11 +610,34 @@ static void print_liveness(struct bpf_verifier_env *env,
> > > > > > > >                 verbose(env, "D");
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -static int get_spi(s32 off)
> > > > > > > > +static int __get_spi(s32 off)
> > > > > > > >  {
> > > > > > > >         return (-off - 1) / BPF_REG_SIZE;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > > > > > > > +{
> > > > > > > > +       int spi;
> > > > > > > > +
> > > > > > > > +       if (reg->off % BPF_REG_SIZE) {
> > > > > > > > +               verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
> > > > > > > > +               return -EINVAL;
> > > > > > > > +       }
> > > > > > >
> > > > > > > I think this cannot happen.
> > > > > > >
> > > > > >
> > > > > > There are existing selftests that trigger this.
> > > > >
> > > > > Really. Which one is that?
> > > > > Those that you've modified in this patch are hitting
> > > > > "cannot pass in dynptr..." message from the check below, no?
> > > > >
> > > >
> > > > Just taking one example, invalid_read2 which does:
> > > >
> > > > bpf_dynptr_read(read_data, sizeof(read_data), (void *)&ptr + 1, 0, 0);
> > > >
> > > > does hit this one, it passes fp-15, no var_off.
> > > >
> > > > Same with invalid_helper2 that was updated.
> > > > Same with invalid_offset that was updated.
> > > > invalid_write3 gained coverage from this patch, earlier it was probably just
> > > > being rejected because of arg_type_is_release checking spilled_ptr.id.
> > > > not_valid_dynptr is also hitting this one, not the one below.
> > > >
> > > > The others now started hitting this error as the order of checks was changed in
> > > > the verifier. Since arg_type_is_release checking happens before
> > > > process_dynptr_func, it uses dynptr_get_spi to check ref_obj_id of spilled_ptr.
> > > > At that point no checks have been made of the dynptr argument, so dynptr_get_spi
> > > > is required to ensure spi is in bounds.
> > > >
> > > > The reg->off % BPF_REG_SIZE was earlier in check_func_arg_reg_off but that alone
> > > > is not sufficient. This is why I wrapped everything into dynptr_get_spi.
> > >
> > > I see. That was not obvious at all that some other patch
> > > is removing that check from check_func_arg_reg_off.
> > >
> >
> > It is done in patch 4. There I move that check from the check_func_arg_reg_off
> > to process_dynptr_func.
>
> "Finally, since check_func_arg_reg_off is meant to be generic, move
> dynptr specific check into process_dynptr_func."
>
> It's a sign that patch 4 is doing too much. It should be at least two patches.
>
> >
> > > Why is the check there not sufficient?
> > >
> >
> > I wanted to keep check_func_arg_reg_off free of assumptions for helper specific
> > checks. It just ensures a few rules:
>
> Currently it's
>         case PTR_TO_STACK:
>                 if (arg_type_is_dynptr(arg_type) && reg->off % BPF_REG_SIZE) {
> it's not really helper specific.
>
> process_dynptr_func may be the right palce to check for alignment,
> but imo the patch set is doing way too much.
> Instead of fixing dynptr specific issues it goes into massive refactoring.
> Please do one or the other.
> One patch set for refactoring only with no functional changes.
> Another patch set with fixes.
> Either order is fine.

Ok, I will split it into two. First send the refactorings (and incorporate
feedback based on the discussion), and then the fixes on top of that.

Thanks.
