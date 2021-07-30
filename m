Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338103DB211
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 06:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbhG3EFY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 00:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhG3EFW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Jul 2021 00:05:22 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3E8C061765
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 21:05:17 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id w17so13690495ybl.11
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 21:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VO2gvZ/2XxR8Q5nVE989ZeHni6iWN5rkYi1EgQqELo=;
        b=LoWARcPt9LeZOnYSRfHG/APBDClJQPbmKJY9G2VSuRm96hSFZp6hJ4ClgFj81k5ek9
         +q16vMbE/eSNBX+FUsWbB8Kkr1ZLOrF49fPJX6UoriXbEqcij2OJ5xUJ7rGCiMqNFQQS
         qXoZhT/Tv4CObm21LA6Mt1vVkvcudTbEc706F7787YOSTmEH9UY3UliOeBorKL9UVx41
         Ikru99GOP8fmnpjdCtQeO0LYl8xzBZlt5aMLALqfLxtxbOX6JjrBHlPtU6AvGHoRZcb/
         c3dGxvQU5wJiat/8DYHukKrtPoh3k+7+SjbkZRm69Feot/Nk093KxSxcsoOYHxWF4dGB
         z+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VO2gvZ/2XxR8Q5nVE989ZeHni6iWN5rkYi1EgQqELo=;
        b=PA6PXlaXIYFgpllFQFwjFn4YdbihbFukJEoP9xHb5HdzjkSSs6fUJsVHkmSIDZImv8
         TfMf6t66J1dV4Ez94xLEEPevJhtj3YeoSY66wiQwAUPNcAx5vB+9JhRfLliB2qudfhib
         QEwaP5b5tLZWW1gFkUQuHwFKWQVSiJg4qqvT2p6U31n0F8OJ5EWeFA7tUMLRuGdO0V5n
         +qtyeHgCGLdirEwz1uhsEJsGOuQUKpa/pp1UqU6eNWymqYr2OLR1qqav3N39bJEYNJdO
         dxXAncxm7Kio0sTz2zreWT/R4J7XtDGLDDcPa1Gtdt2CyoI9h0gSAxEOF/BuiGJSHzKr
         /CKA==
X-Gm-Message-State: AOAM5311HgT14ewCmr9y6vrk+JOL9t2N4PPKUlmmaKZqzJRtbPHooAbi
        OtVjAT2OCAfF52Am3XEfhCYY/twP2lFJGC/wCjs=
X-Google-Smtp-Source: ABdhPJzx/eulyTU5Y/5VAoaObraqF5yO35A4grGJ5xVfT9rorZt0S4Nyo3FcDUcx+3xfGfI85oHVgoYKixkQc1KgNFE=
X-Received: by 2002:a25:cdc7:: with SMTP id d190mr562035ybf.425.1627617916360;
 Thu, 29 Jul 2021 21:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210726161211.925206-1-andrii@kernel.org> <20210726161211.925206-2-andrii@kernel.org>
 <92ed2fb3-6a69-415e-ca5e-fc516e38c60d@fb.com>
In-Reply-To: <92ed2fb3-6a69-415e-ca5e-fc516e38c60d@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Jul 2021 21:05:05 -0700
Message-ID: <CAEf4Bzb12YosnTiKoTBt=cUCDzM5pSZpsg=bjC7XYyH9GOr2Qg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/14] bpf: refactor BPF_PROG_RUN into a function
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 29, 2021 at 9:50 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/26/21 9:11 AM, Andrii Nakryiko wrote:
> > Turn BPF_PROG_RUN into a proper always inlined function. No functional and
> > performance changes are intended, but it makes it much easier to understand
> > what's going on with how BPF programs are actually get executed. It's more
> > obvious what types and callbacks are expected. Also extra () around input
> > parameters can be dropped, as well as `__` variable prefixes intended to avoid
> > naming collisions, which makes the code simpler to read and write.
> >
> > This refactoring also highlighted one possible issue. BPF_PROG_RUN is both
> > a macro and an enum value (BPF_PROG_RUN == BPF_PROG_TEST_RUN). Turning
> > BPF_PROG_RUN into a function causes naming conflict compilation error. So
> > rename BPF_PROG_RUN into lower-case bpf_prog_run(), similar to
> > bpf_prog_run_xdp(), bpf_prog_run_pin_on_cpu(), etc. To avoid unnecessary code
> > churn across many networking calls to BPF_PROG_RUN, #define BPF_PROG_RUN as an
> > alias to bpf_prog_run.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   include/linux/filter.h | 58 +++++++++++++++++++++++++++---------------
> >   1 file changed, 37 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index ba36989f711a..e59c97c72233 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -585,25 +585,41 @@ struct sk_filter {
> >
> >   DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
> >
> > -#define __BPF_PROG_RUN(prog, ctx, dfunc)     ({                      \
> > -     u32 __ret;                                                      \
> > -     cant_migrate();                                                 \
> > -     if (static_branch_unlikely(&bpf_stats_enabled_key)) {           \
> > -             struct bpf_prog_stats *__stats;                         \
> > -             u64 __start = sched_clock();                            \
> > -             __ret = dfunc(ctx, (prog)->insnsi, (prog)->bpf_func);   \
> > -             __stats = this_cpu_ptr(prog->stats);                    \
> > -             u64_stats_update_begin(&__stats->syncp);                \
> > -             __stats->cnt++;                                         \
> > -             __stats->nsecs += sched_clock() - __start;              \
> > -             u64_stats_update_end(&__stats->syncp);                  \
> > -     } else {                                                        \
> > -             __ret = dfunc(ctx, (prog)->insnsi, (prog)->bpf_func);   \
> > -     }                                                               \
> > -     __ret; })
> > -
> > -#define BPF_PROG_RUN(prog, ctx)                                              \
> > -     __BPF_PROG_RUN(prog, ctx, bpf_dispatcher_nop_func)
> > +typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
> > +                                       const struct bpf_insn *insnsi,
> > +                                       unsigned int (*bpf_func)(const void *,
> > +                                                                const struct bpf_insn *));
> > +
> > +static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
> > +                                       const void *ctx,
> > +                                       bpf_dispatcher_fn dfunc)
> > +{
> > +     u32 ret;
> > +
> > +     cant_migrate();
> > +     if (static_branch_unlikely(&bpf_stats_enabled_key)) {
> > +             struct bpf_prog_stats *stats;
> > +             u64 start = sched_clock();
> > +
> > +             ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
> > +             stats = this_cpu_ptr(prog->stats);
> > +             u64_stats_update_begin(&stats->syncp);
> > +             stats->cnt++;
> > +             stats->nsecs += sched_clock() - start;
> > +             u64_stats_update_end(&stats->syncp);
> > +     } else {
> > +             ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
> > +     }
> > +     return ret;
> > +}
> > +
> > +static __always_inline u32 bpf_prog_run(const struct bpf_prog *prog, const void *ctx)
> > +{
> > +     return __bpf_prog_run(prog, ctx, bpf_dispatcher_nop_func);
> > +}
> > +
> > +/* avoids name conflict with BPF_PROG_RUN enum definedi uapi/linux/bpf.h */
> > +#define BPF_PROG_RUN bpf_prog_run
> >
> >   /*
> >    * Use in preemptible and therefore migratable context to make sure that
> > @@ -622,7 +638,7 @@ static inline u32 bpf_prog_run_pin_on_cpu(const struct bpf_prog *prog,
> >       u32 ret;
> >
> >       migrate_disable();
> > -     ret = __BPF_PROG_RUN(prog, ctx, bpf_dispatcher_nop_func);
> > +     ret = __bpf_prog_run(prog, ctx, bpf_dispatcher_nop_func);
>
> This can be replaced with bpf_prog_run(prog, ctx).
>

ok, sure

> >       migrate_enable();
> >       return ret;
> >   }
> > @@ -768,7 +784,7 @@ static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
> >        * under local_bh_disable(), which provides the needed RCU protection
> >        * for accessing map entries.
> >        */
> > -     return __BPF_PROG_RUN(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
> > +     return __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
> >   }
> >
> >   void bpf_prog_change_xdp(struct bpf_prog *prev_prog, struct bpf_prog *prog);
> >
