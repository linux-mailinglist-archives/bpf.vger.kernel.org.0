Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD9D67460F
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 23:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjASWcd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 17:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjASWb7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 17:31:59 -0500
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B445AA839C
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:14:48 -0800 (PST)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-15f97c478a8so4174493fac.13
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sO18qtVu9ykXOQ6JXw+8FBPjUGZuTFUREnOoWTwoEv4=;
        b=aNQhk/Lwfn7O64bvuNjClEGMP/sK1r/hesFl8Ojum+LvzrpE0zJeIZTcv9EU6OTMGT
         7HS9Eg1dyyshjUbGkZq4uZNAHgMpYmeXXAy0vLlA5GUSbCM/u2st697SBL7PwO6Vck4E
         5nArg5RhGB1Ymi38ECU/b8EItGnsxLiz3Rhs87iBj0cBwYZx+3XGS81gygK50knQI8kA
         Zpdo5QPmjHG9IjOESmXNGUH2N5JIdSmYKPx5dd7tZ8dwaicil8KB2EuIaD+nsciQYZtm
         uUgwqnRrqy2AcHvCuyu0DDgg6pObzp3jD1+SK52OPsm04kxHi+++eWlQlxJq6gzMx4Ip
         mGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sO18qtVu9ykXOQ6JXw+8FBPjUGZuTFUREnOoWTwoEv4=;
        b=KerQ4j0MSqhrMrH8ZH2pgvW+v6VJi8TWHVSLOIioJBDrJQgJWtfmcMAETencH6LHEF
         oZ++g0B9PiI3dzc9DLpsFOJIa1+CGaAEyPNNaUBsmFj0lXBP98IG82zVysCTptlwTY6y
         zKDy8ncAEal0Tmm8FIGiZdQUiKJj4wPrNOjhZfJZCeYB7a3cyvCF9DJKNMFTs/xJ6yzM
         C9tOy45smK4wlo5kPnQeqK0MZQproYrm8Cz/c8RiFP2ZcoV3zmSJVgjfGuXjuvGk6yAZ
         qKO+oH5WGmsj+p4H1kx+4hAyCbcTmynBmLmlNhv9ulUTQJdikcAHvgDBM+123q2KpgD/
         SNAQ==
X-Gm-Message-State: AFqh2kocrfn+mQE9UTlwz5rkiet+WYQBtFVvwXdVIxWf0cgQNp8aLDRi
        AD28xiOTCt5ES7akT9kwLI37eWjN0RxHRhtj1upNVG2R
X-Google-Smtp-Source: AMrXdXtZsGQqfXBUw1BfEzGvZ1EMWNZz8kaxBggh/twDj/jwFY5lrxCyNGS9usl53YozZ0LY/kUoWJDYUe5OOeC8U4k=
X-Received: by 2002:a05:6870:6c14:b0:15f:4:7aa0 with SMTP id
 na20-20020a0568706c1400b0015f00047aa0mr958412oab.58.1674166487617; Thu, 19
 Jan 2023 14:14:47 -0800 (PST)
MIME-Version: 1.0
References: <20230119021442.1465269-1-memxor@gmail.com> <20230119021442.1465269-3-memxor@gmail.com>
 <CAJnrk1a4j1zeztQ0nRdC7T85rxZhuf+hdpeh_7FWMioCHOjLNw@mail.gmail.com>
In-Reply-To: <CAJnrk1a4j1zeztQ0nRdC7T85rxZhuf+hdpeh_7FWMioCHOjLNw@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 20 Jan 2023 03:44:11 +0530
Message-ID: <CAP01T75P2Vebc5r0+ymF23tQVDWUdtOQNVh9ksp9fVJwQ8hnKw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/11] bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
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

On Fri, 20 Jan 2023 at 03:30, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Wed, Jan 18, 2023 at 6:14 PM Kumar Kartikeya Dwivedi
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
> >  kernel/bpf/verifier.c                         | 83 +++++++++++++++----
> >  .../bpf/prog_tests/kfunc_dynptr_param.c       |  2 +-
> >  .../testing/selftests/bpf/progs/dynptr_fail.c |  4 +-
> >  3 files changed, 68 insertions(+), 21 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 89de5bc46f27..eeb6f1b2bd60 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -638,11 +638,34 @@ static void print_liveness(struct bpf_verifier_env *env,
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
> > +       int off, spi;
> > +
> > +       if (!tnum_is_const(reg->var_off)) {
> > +               verbose(env, "dynptr has to be at the constant offset\n");
>
> nit: "at a constant offset" instead of "at the constant offset"?
>

Will fix.

> > +               return -EINVAL;
> > +       }
> > +
> > +       off = reg->off + reg->var_off.value;
> > +       if (off % BPF_REG_SIZE) {
> > +               verbose(env, "cannot pass in dynptr at an offset=%d\n", off);
> > +               return -EINVAL;
> > +       }
> > +
> > +       spi = __get_spi(off);
> > +       if (spi < 1) {
> > +               verbose(env, "cannot pass in dynptr at an offset=%d\n", off);
> > +               return -EINVAL;
> > +       }
>
> I still think this if (spi < 1) check should have the same logic
> is_spi_bounds_valid() does (eg checking against total allocated slots
> as well). I think we can combine is_spi_bounds_valid() with this
> function and then remove every place we call is_spi_bounds_valid().
> WDYT?
>

I believe I addressed this in patch 5, but kept the name of the
combined check as dynptr_get_spi instead (it looks better to me in the
context of the code compared to is_spi_bounds_valid). Please take a
look.
