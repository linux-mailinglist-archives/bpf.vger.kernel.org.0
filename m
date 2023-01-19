Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2309674656
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 23:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjASWpr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 17:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjASWpR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 17:45:17 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119F8C9247
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:25:47 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 69so4521645ybn.2
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UajGIJH/mKGtCzLC1jHbLlI9IR4w0Icl1NpUwkXw77A=;
        b=NwjAF33L0QAmci0sV7s8OlrKAEDJdtKLAZp0RU52R1m8ov5uWHBuPos8iL2Jr0Pjm3
         xEc2QtI8/8v1TbcBlRsAQwAjCTUqJKnfooPS7eXfw/i28IZDLOES5Z/Wd6FW3a58cH5f
         gnR7DwUDnK4HrAgJ8SSUw0H1StHPhFqIVKR0BaEl2nxj3MgcWQ0v3fCOJL3fj5Bn2wQ/
         1kq7IuGexK0h3opbARvqpDZaioTUQnyQj9i+HCiDJpF6zClNlbvkZkc+YBqIKoH587IG
         QfRaKkrDmn4XxStna9aqxQot9nflB6DeVlUgLDiLpXGeba0fcvUin+X5byVhkWwtIqon
         dNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UajGIJH/mKGtCzLC1jHbLlI9IR4w0Icl1NpUwkXw77A=;
        b=rBnGKdYpwzpscftKXkf2NZonbJV2C7vSyvZHe7waXLgRxqPuhWNV1nNRJF+H+/jtqV
         kC1CzN5r1/jWlTRnilw9XfZE6bhAX+8kyHfMIDa80VrxNyF6AzeC266IIGonRebdAvdD
         udx2l+oqD4GjrscT/oXq/I6fUCtx/KRCEV6W7N6svp8OoCiMQfUdL3pp8gadyyATMvRV
         2S9Crduwnr01vU7SkNjPWldpnrRqbG2jcgXrVYbfi5rYRUj0cs0jcZUxlR0YQBnabl8M
         QOWx1uwYEiPCwEcFIySjPzQbxtFiJBJXWBl6uuFPibtAH8PpjSM9t4PIwzkT7MvbUfAo
         n5IQ==
X-Gm-Message-State: AFqh2krUH/uPExpfcLDr9IRumu67yiOpOY1GNdAgHT7VvZnOUJQ6KKgL
        Ya7ITITY+H4oMAnxU8A8KDuZNvD19JlC29idV60=
X-Google-Smtp-Source: AMrXdXvDTBNMQSeiKx79Kw5Niv8lVRw8yBa6pI5n37X6nGeH3iyDHXGn+Oh6vxJpn0/jJS8yWAZV3XPnjQ+IQ5LmDoI=
X-Received: by 2002:a25:7e81:0:b0:7e5:ecf1:ebde with SMTP id
 z123-20020a257e81000000b007e5ecf1ebdemr1129231ybc.375.1674167146178; Thu, 19
 Jan 2023 14:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20230119021442.1465269-1-memxor@gmail.com> <20230119021442.1465269-3-memxor@gmail.com>
 <CAJnrk1a4j1zeztQ0nRdC7T85rxZhuf+hdpeh_7FWMioCHOjLNw@mail.gmail.com> <CAP01T75P2Vebc5r0+ymF23tQVDWUdtOQNVh9ksp9fVJwQ8hnKw@mail.gmail.com>
In-Reply-To: <CAP01T75P2Vebc5r0+ymF23tQVDWUdtOQNVh9ksp9fVJwQ8hnKw@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 19 Jan 2023 14:25:35 -0800
Message-ID: <CAJnrk1ZgLAdzskcfJD77gxpYqVbR8U5x+ibrEBaTr2tsf2kFwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/11] bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Thu, Jan 19, 2023 at 2:14 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 20 Jan 2023 at 03:30, Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Wed, Jan 18, 2023 at 6:14 PM Kumar Kartikeya Dwivedi
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

Acked-by: Joanne Koong <joannelkoong@gmail.com>

> > > ---
> > >  kernel/bpf/verifier.c                         | 83 +++++++++++++++----
> > >  .../bpf/prog_tests/kfunc_dynptr_param.c       |  2 +-
> > >  .../testing/selftests/bpf/progs/dynptr_fail.c |  4 +-
> > >  3 files changed, 68 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 89de5bc46f27..eeb6f1b2bd60 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -638,11 +638,34 @@ static void print_liveness(struct bpf_verifier_env *env,
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
> > > +       int off, spi;
> > > +
> > > +       if (!tnum_is_const(reg->var_off)) {
> > > +               verbose(env, "dynptr has to be at the constant offset\n");
> >
> > nit: "at a constant offset" instead of "at the constant offset"?
> >
>
> Will fix.
>
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       off = reg->off + reg->var_off.value;
> > > +       if (off % BPF_REG_SIZE) {
> > > +               verbose(env, "cannot pass in dynptr at an offset=%d\n", off);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       spi = __get_spi(off);
> > > +       if (spi < 1) {
> > > +               verbose(env, "cannot pass in dynptr at an offset=%d\n", off);
> > > +               return -EINVAL;
> > > +       }
> >
> > I still think this if (spi < 1) check should have the same logic
> > is_spi_bounds_valid() does (eg checking against total allocated slots
> > as well). I think we can combine is_spi_bounds_valid() with this
> > function and then remove every place we call is_spi_bounds_valid().
> > WDYT?
> >
>
> I believe I addressed this in patch 5, but kept the name of the
> combined check as dynptr_get_spi instead (it looks better to me in the
> context of the code compared to is_spi_bounds_valid). Please take a
> look.

Ok, I see, these changes are in a separate patch.
