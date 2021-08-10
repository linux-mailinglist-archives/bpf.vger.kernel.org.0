Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A22A3E5055
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 02:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhHJA2h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 20:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhHJA2g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 20:28:36 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87322C0613D3
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 17:28:15 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id m193so32963945ybf.9
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 17:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGXREVMCA1JCPJ6TQNkB/a/xgtfVSv8or6wTBzZNdnE=;
        b=ZmeIMnlndOgdDRhXmgFoenIlPrHyg/SVUHUd/lzQJyvUxe4Mi+/VqzqXyV3Qp8kypb
         i635mC2q4wodHBQCTMhZPOrK0HtMKZwUDd4r3Fuz6FffSdN3yqJ0bMEvcIpF/uH+k0B/
         7ncuO7SVRAgqCeK+W1jciPSqjRc4UU/ktCX5ahDfBlfdQnfADXu8Q/OvJ2jVPtI4rb8K
         NCqTMT6BIcSgHj8ZqAcCsnIYNxRc9lqkmvGJP0TAglgyidj5WQNiTPk5jDj9CY3sNOoq
         0ZwXHfG/DbluBc/Gp+ot9lUZ886Q+ZkzvE0N4veTTGYM+tHgzvv2XnVw9s+OTYGLMzHv
         y23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGXREVMCA1JCPJ6TQNkB/a/xgtfVSv8or6wTBzZNdnE=;
        b=UY2LMHj31NOp+fG2keUKs65QPbG1bdZG5Mg9yffxN2ca4DWrOyJgSV54TmF5t//aST
         xB2Edxea6Z++QrcBJM4TwXmBEj7jnRS2HNRNyqDXGme7Yj4Th3g7gX004wU6CVoZWeIR
         im67Mb14gwT7/Xn1Bjro5Y7DOydwJ8ZO8wRjHBB8+vAxqOZGm3MzZTP4Mfd49rCkSTKq
         1KtaI/ksHulgmSyCJDKPlBEknkUYE2C9Mvdj5MDq3DEbcLunlhqnvNpf3Rrwakg6FT5m
         BB+AQ2Kt9OTPDtv39c6kyJwmGfEowR4FFB8Z9LbY0Q3l2vZ1v5xXt6s+UHlzMOKUb33j
         xqsQ==
X-Gm-Message-State: AOAM533bvBob6qV3UrlAc4LIyQrRBpMikaN9MPsb5T1Kr8WVii6/0xXI
        wfC4XHLBdyCDP7+kpdQWwHv2GYfQbi4MqRGmxX4=
X-Google-Smtp-Source: ABdhPJwKnhTvJsW9joIFpoCwbwDINTdvDyhPRJqHDblRQwdi3UEZeJQUFR8s3R1hY/qZZt+aRMMLrHGkZcDpD0Xyj5M=
X-Received: by 2002:a25:4091:: with SMTP id n139mr9759848yba.425.1628555294765;
 Mon, 09 Aug 2021 17:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210730053413.1090371-1-andrii@kernel.org> <20210730053413.1090371-2-andrii@kernel.org>
 <21246244-fa7e-700f-e767-3f9edf9e4c19@iogearbox.net>
In-Reply-To: <21246244-fa7e-700f-e767-3f9edf9e4c19@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 Aug 2021 17:28:03 -0700
Message-ID: <CAEf4BzYGqb6HdAuBciauv-NZLBoVF4X8WdFXNKmKQ9hcZfSC3w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/14] bpf: refactor BPF_PROG_RUN into a function
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 9, 2021 at 3:43 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 7/30/21 7:34 AM, Andrii Nakryiko wrote:
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
>
> Change itself looks good, small nit below:
>
> > ---
> >   include/linux/filter.h | 58 +++++++++++++++++++++++++++---------------
> >   1 file changed, 37 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index ba36989f711a..18518e321ce4 100644
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
>
> (definedi)
>

oops, will fix

> > +#define BPF_PROG_RUN bpf_prog_run
>
> Given the unfortunate conflict in BPF_PROG_RUN, can't we just toss the BPF_PROG_RUN to
> bpf_prog_run altogether and bite the bullet once to remove it from the tree? (Same as the
> other macro names in next patch.) There are a number of instances, but still to the extend
> that it should be doable.

Yeah, absolutely. I wasn't sure if you'd hate the renaming noise. I'll
get rid of BPF_PROG_RUN macro in the next revision.

>
> >   /*
> >    * Use in preemptible and therefore migratable context to make sure that
> > @@ -622,7 +638,7 @@ static inline u32 bpf_prog_run_pin_on_cpu(const struct bpf_prog *prog,
> >       u32 ret;
> >
> >       migrate_disable();
> > -     ret = __BPF_PROG_RUN(prog, ctx, bpf_dispatcher_nop_func);
> > +     ret = bpf_prog_run(prog, ctx);
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
>
