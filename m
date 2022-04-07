Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3FA4F8ACC
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 02:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiDGX3q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 19:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiDGX3p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 19:29:45 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EAF2DFD51
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 16:27:44 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id r2so8697776iod.9
        for <bpf@vger.kernel.org>; Thu, 07 Apr 2022 16:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOuhaHaz5D45qA8ttEqVH41dqV0RqD6gP3mqCHYZALc=;
        b=Ir63QRNqDoLaaKSSr4Pmz55pilOUcW8iQTWySV45O4TMCSvgp1BRHEwNz4vTyjInS4
         0Jt8aXo3FKrg04Rkwrv55xXscUIEc94iMb5fdN+0d32uFBrNo4tOTrT9OHkkw5HxRPa1
         8w7L2Hw1+fJwO3xu797DfErl5SleZYr8rmpQOCdhS7YLTJB4zSVP7X78qVShtpAdElvD
         Um3JOuj+EC+qy+n+CYrinAu1eVd4NE6zeU4IghC7n5kCUF1NyfOUJHEsW5WYRvKwx6Mu
         ua5cusiGoGX5rH8mXHdWHO0iqIXVMP752eGNL1O0J5ohNktYH/EHZQkgRAHGl3kSi7Wt
         FDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOuhaHaz5D45qA8ttEqVH41dqV0RqD6gP3mqCHYZALc=;
        b=wBg2JBLit7RQANwpBQ9FkzGgSEBEJ5lOEwttRTENkWcWhjxJubmRc67OnZwtnELj5M
         W/AUSv8lwnqMwiKZ8fu3IJXRjxJo0sceC1RLOc23iR0EiRYppVX6l6mnHckABjCq4Ui7
         u/nM6tZD/KRNvp7BuOxZKcy7CCrZGqtE8gvSUIUkpYky+q/MDhaAPNdmnQhVUSssm+SB
         Xm3zgMWsaPv7xJqXObnjz9eD9bF3nI8p07QIEOCJbWl/erL+LKU2+kT1dCOZF4pFArw+
         vAS91xkP66TDGCRAc/nypMDtcvV7NuqK/bFQ5IDw8Y/khr58ohZMN7F0BotpFwePtjmT
         Cl9w==
X-Gm-Message-State: AOAM531ywccFB9/yTMJlOydYOq6v333nSFwknTHL36YW0mfaUR4vTCOC
        jZtQa1j8jiITTwSKgSRSLlMuYD9NGybxYI+NDJk=
X-Google-Smtp-Source: ABdhPJyXuFNbXz3cwv570sifv66Oo3GSoghE1cED6WyVC+97pT05QDCkohmiJKIeir580wL2CJEZC+5ihtx6o5qusek=
X-Received: by 2002:a05:6602:185a:b0:645:d914:35e9 with SMTP id
 d26-20020a056602185a00b00645d91435e9mr7160537ioi.154.1649374063586; Thu, 07
 Apr 2022 16:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220404234202.331384-1-andrii@kernel.org> <20220404234202.331384-2-andrii@kernel.org>
 <28c378a6eb72b66b44cfac250807a2a01ee478af.camel@linux.ibm.com>
In-Reply-To: <28c378a6eb72b66b44cfac250807a2a01ee478af.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 7 Apr 2022 16:27:32 -0700
Message-ID: <CAEf4BzZ=v7A+WEDZqLhV8movffqN1CGUsgcX0ocOfS0FMwq0qg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/7] libbpf: add BPF-side of USDT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 7, 2022 at 7:19 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Mon, 2022-04-04 at 16:41 -0700, Andrii Nakryiko wrote:
> > Add BPF-side implementation of libbpf-provided USDT support. This
> > consists of single header library, usdt.bpf.h, which is meant to be
> > used
> > from user's BPF-side source code. This header is added to the list of
> > installed libbpf header, along bpf_helpers.h and others.
> >
> > BPF-side implementation consists of two BPF maps:
> >   - spec map, which contains "a USDT spec" which encodes information
> >     necessary to be able to fetch USDT arguments and other
> > information
> >     (argument count, user-provided cookie value, etc) at runtime;
> >   - IP-to-spec-ID map, which is only used on kernels that don't
> > support
> >     BPF cookie feature. It allows to lookup spec ID based on the
> > place
> >     in user application that triggers USDT program.
> >
> > These maps have default sizes, 256 and 1024, which are chosen
> > conservatively to not waste a lot of space, but handling a lot of
> > common
> > cases. But there could be cases when user application needs to either
> > trace a lot of different USDTs, or USDTs are heavily inlined and
> > their
> > arguments are located in a lot of differing locations. For such cases
> > it
> > might be necessary to size those maps up, which libbpf allows to do
> > by
> > overriding BPF_USDT_MAX_SPEC_CNT and BPF_USDT_MAX_IP_CNT macros.
> >
> > It is an important aspect to keep in mind. Single USDT (user-space
> > equivalent of kernel tracepoint) can have multiple USDT "call sites".
> > That is, single logical USDT is triggered from multiple places in
> > user
> > application. This can happen due to function inlining. Each such
> > inlined
> > instance of USDT invocation can have its own unique USDT argument
> > specification (instructions about the location of the value of each
> > of
> > USDT arguments). So while USDT looks very similar to usual uprobe or
> > kernel tracepoint, under the hood it's actually a collection of
> > uprobes,
> > each potentially needing different spec to know how to fetch
> > arguments.
> >
> > User-visible API consists of three helper functions:
> >   - bpf_usdt_arg_cnt(), which returns number of arguments of current
> > USDT;
> >   - bpf_usdt_arg(), which reads value of specified USDT argument (by
> >     it's zero-indexed position) and returns it as 64-bit value;
> >   - bpf_usdt_cookie(), which functions like BPF cookie for USDT
> >     programs; this is necessary as libbpf doesn't allow specifying
> > actual
> >     BPF cookie and utilizes it internally for USDT support
> > implementation.
> >
> > Each bpf_usdt_xxx() APIs expect struct pt_regs * context, passed into
> > BPF program. On kernels that don't support BPF cookie it is used to
> > fetch absolute IP address of the underlying uprobe.
> >
> > usdt.bpf.h also provides BPF_USDT() macro, which functions like
> > BPF_PROG() and BPF_KPROBE() and allows much more user-friendly way to
> > get access to USDT arguments, if USDT definition is static and known
> > to
> > the user. It is expected that majority of use cases won't have to use
> > bpf_usdt_arg_cnt() and bpf_usdt_arg() directly and BPF_USDT() will
> > cover
> > all their needs.
> >
> > Last, usdt.bpf.h is utilizing BPF CO-RE for one single purpose: to
> > detect kernel support for BPF cookie. If BPF CO-RE dependency is
> > undesirable, user application can redefine BPF_USDT_HAS_BPF_COOKIE to
> > either a boolean constant (or equivalently zero and non-zero), or
> > even
> > point it to its own .rodata variable that can be specified from
> > user's
> > application user-space code. It is important that
> > BPF_USDT_HAS_BPF_COOKIE is known to BPF verifier as static value
> > (thus
> > .rodata and not just .data), as otherwise BPF code will still contain
> > bpf_get_attach_cookie() BPF helper call and will fail validation at
> > runtime, if not dead-code eliminated.
> >
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/Makefile   |   2 +-
> >  tools/lib/bpf/usdt.bpf.h | 256
> > +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 257 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/lib/bpf/usdt.bpf.h
>
> [...]
>
> > diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> > new file mode 100644
> > index 000000000000..60237acf6b02
> > --- /dev/null
> > +++ b/tools/lib/bpf/usdt.bpf.h
> > @@ -0,0 +1,256 @@
>
> [...]
>
> > +/* Fetch USDT argument #*arg_num* (zero-indexed) and put its value
> > into *res.
> > + * Returns 0 on success; negative error, otherwise.
> > + * On error *res is guaranteed to be set to zero.
> > + */
> > +static inline __noinline
> > +int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
> > +{
> > +       struct __bpf_usdt_spec *spec;
> > +       struct __bpf_usdt_arg_spec *arg_spec;
> > +       unsigned long val;
> > +       int err, spec_id;
> > +
> > +       *res = 0;
> > +
> > +       spec_id = __bpf_usdt_spec_id(ctx);
> > +       if (spec_id < 0)
> > +               return -ESRCH;
> > +
> > +       spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> > +       if (!spec)
> > +               return -ESRCH;
> > +
> > +       if (arg_num >= BPF_USDT_MAX_ARG_CNT || arg_num >= spec-
> > >arg_cnt)
> > +               return -ENOENT;
> > +
> > +       arg_spec = &spec->args[arg_num];
> > +       switch (arg_spec->arg_type) {
> > +       case BPF_USDT_ARG_CONST:
> > +               /* Arg is just a constant ("-4@$-9" in USDT arg
> > spec).
> > +                * value is recorded in arg_spec->val_off directly.
> > +                */
> > +               val = arg_spec->val_off;
> > +               break;
> > +       case BPF_USDT_ARG_REG:
> > +               /* Arg is in a register (e.g, "8@%rax" in USDT arg
> > spec),
> > +                * so we read the contents of that register directly
> > from
> > +                * struct pt_regs. To keep things simple user-space
> > parts
> > +                * record offsetof(struct pt_regs, <regname>) in
> > arg_spec->reg_off.
> > +                */
> > +               err = bpf_probe_read_kernel(&val, sizeof(val), (void
> > *)ctx + arg_spec->reg_off);
> > +               if (err)
> > +                       return err;
> > +               break;
> > +       case BPF_USDT_ARG_REG_DEREF:
> > +               /* Arg is in memory addressed by register, plus some
> > offset
> > +                * (e.g., "-4@-1204(%rbp)" in USDT arg spec).
> > Register is
> > +                * identified lik with BPF_USDT_ARG_REG case, and the
> > offset
> > +                * is in arg_spec->val_off. We first fetch register
> > contents
> > +                * from pt_regs, then do another user-space probe
> > read to
> > +                * fetch argument value itself.
> > +                */
> > +               err = bpf_probe_read_kernel(&val, sizeof(val), (void
> > *)ctx + arg_spec->reg_off);
> > +               if (err)
> > +                       return err;
> > +               err = bpf_probe_read_user(&val, sizeof(val), (void
> > *)val + arg_spec->val_off);
>
> Is there a reason we always read 8 bytes here?
> What if the user is interested in the last byte of a page?

Well, for one it was simplicity and keeping arg_spec compact (there
could be a lot of them, so keeping it at 16 bytes is useful). But it
also seems like a very unlikely event. And either way even completely
valid page might not be paged in anyways, so some read might fail
anyways.

But I think really it was due to technical limitation.
bpf_probe_read_{kernel,user}() expects statically known size of the
read, so we'd have to have an ugly switch here with branches for 1, 2,
4, and 8, which is ugly. So given highly unlikely situation you
described, I figured it should be fine.

>
> [...]
