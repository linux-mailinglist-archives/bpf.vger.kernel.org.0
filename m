Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A675B3E90
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 20:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiIISIB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 14:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiIISH6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 14:07:58 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEF0F0AAD
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 11:07:55 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m1so3705044edb.7
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lbJY5NVyOlA2H/NOho5Pew08ETR7Ex1FPsDKkkNOnDQ=;
        b=mnzjaWO6s92mYDllQnA11lwzsDWWhUup0PyrPkTujcEOxOrNDrQ8dBHB+gHOtkFR8u
         s+3JrNCLugCZubv0/6rUdeOUrulKRYroy5482e+tlxShMCCm2ez1goWXi4igk3S3VHyl
         T9disC4OqGMUeyeDO50adZVkh/n0mKnt+iLuI57+oiM3lAbUBXATcSvX7+4MJ35E9a4D
         +bOon1+HvLzRhNxq+7yzNRNjVYOV3FIwL98n2lu+Qd/MCGX7R1h2E4JQ7KZUQnXySSlE
         Q2x5bbDn1pooDOdxkcmFhLn8pCj8kzrYByXcZrRd3c5cqFPVEWMPz/OyZbC0oEbtVASl
         B4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lbJY5NVyOlA2H/NOho5Pew08ETR7Ex1FPsDKkkNOnDQ=;
        b=FBs8wyIYlOdwrAHk6cc0n62rUJ9wEa5Bw5S7+NvebM1OhwL6ks+0HAQtew6ntIN/Xo
         R6prDDRyd3apwB9BpP8+SgYGJarXx+VAtgyEJVTHscqGBYQAqfQCoFLSSIbWyDrYPO+p
         LwRGjj8HRDUpFn5NonMZxsv2nBmrMTctYnzrtWVhlAXwqAg6cpZZqmBW0oyWEEaYOGVq
         NyT4e3zMZ+dRhNTBzQ/KIU22BZIJbZGhszt2mjAIEbVHiEmw277IJ/k+DOQLe5wxl4cI
         OtXXiKIDJ1oLvvXzsuDciUjDsv5ZF7XEQ9n9RyA+X72W346/Q6u0mL99krHKd3L3wUcY
         XEoA==
X-Gm-Message-State: ACgBeo0WTsTRlsZSznqen5nBQgW273fUMvnURd2oEbTWHpcK/7VjSdeB
        fv930WI9jSMTo1vO5Paf/fG2EdRqhe6Ho9upuRU=
X-Google-Smtp-Source: AA6agR5Htvf2JMQ1/HMRL1SfyOWGwvGAZng/8rIuHxaEEK7VvfimNjW0zzQ41cTqgjfbkEgtu8l4mqyZMbK/DW4KQLo=
X-Received: by 2002:a05:6402:10d2:b0:445:d9ee:fc19 with SMTP id
 p18-20020a05640210d200b00445d9eefc19mr11959340edu.81.1662746873659; Fri, 09
 Sep 2022 11:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220831152641.2077476-1-yhs@fb.com> <20220831152707.2079473-1-yhs@fb.com>
 <CAEf4BzZ9PopF-9jL4XXTXPNHRMCpKuR0Yc=HZTiRMTaRA-SqUw@mail.gmail.com> <c97c123d-9d4a-6aff-e8d3-31ccf3b3e9df@fb.com>
In-Reply-To: <c97c123d-9d4a-6aff-e8d3-31ccf3b3e9df@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Sep 2022 11:07:42 -0700
Message-ID: <CAEf4BzZznd0wXsFqAFETnE+htHMx02Ehyqnqnccw7LfjvCw-jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/8] libbpf: Add new BPF_PROG2 macro
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
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

On Fri, Sep 9, 2022 at 9:31 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/8/22 5:11 PM, Andrii Nakryiko wrote:
> > On Wed, Aug 31, 2022 at 8:27 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> To support struct arguments in trampoline based programs,
> >> existing BPF_PROG doesn't work any more since
> >> the type size is needed to find whether a parameter
> >> takes one or two registers. So this patch added a new
> >> BPF_PROG2 macro to support such trampoline programs.
> >>
> >> The idea is suggested by Andrii. For example, if the
> >> to-be-traced function has signature like
> >>    typedef struct {
> >>         void *x;
> >>         int t;
> >>    } sockptr;
> >>    int blah(sockptr x, char y);
> >>
> >> In the new BPF_PROG2 macro, the argument can be
> >> represented as
> >>    __bpf_prog_call(
> >>       ({ union {
> >>            struct { __u64 x, y; } ___z;
> >>            sockptr x;
> >>          } ___tmp = { .___z = { ctx[0], ctx[1] }};
> >>          ___tmp.x;
> >>       }),
> >>       ({ union {
> >>            struct { __u8 x; } ___z;
> >>            char y;
> >>          } ___tmp = { .___z = { ctx[2] }};
> >>          ___tmp.y;
> >>       }));
> >> In the above, the values stored on the stack are properly
> >> assigned to the actual argument type value by using 'union'
> >> magic. Note that the macro also works even if no arguments
> >> are with struct types.
> >>
> >> Note that new BPF_PROG2 works for both llvm16 and pre-llvm16
> >> compilers where llvm16 supports bpf target passing value
> >> with struct up to 16 byte size and pre-llvm16 will pass
> >> by reference by storing values on the stack. With static functions
> >> with struct argument as always inline, the compiler is able
> >> to optimize and remove additional stack saving of struct values.
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   tools/lib/bpf/bpf_tracing.h | 79 +++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 79 insertions(+)
> >>
> >> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> >> index 5fdb93da423b..8d4bdd18cb3d 100644
> >> --- a/tools/lib/bpf/bpf_tracing.h
> >> +++ b/tools/lib/bpf/bpf_tracing.h
> >> @@ -438,6 +438,85 @@ typeof(name(0)) name(unsigned long long *ctx)                                  \
> >>   static __always_inline typeof(name(0))                                     \
> >>   ____##name(unsigned long long *ctx, ##args)
> >>
> >> +#ifndef ____bpf_nth
> >> +#define ____bpf_nth(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, N, ...) N
> >> +#endif
> >
> > we already have ___bpf_nth (triple underscore) variant, wouldn't
> > extending that one to support up to 24 argument work? It's quite
> > confusing to have ___bpf_nth and ____bpf_nth. Maybe let's consolidate?
> >
> > And I'd totally wrap this long line :)
>
> I tried earlier and it doesn't work. I will try again. If it still not
> works, I will change the name to ___bpf_nth2 similar to ___bpf_narg2 below.

Yeah, that was the fallback I had in mind. ___bpf_nth2 is fine as well.

>
> >
> >
> >> +#ifndef ____bpf_narg
> >> +#define ____bpf_narg(...) ____bpf_nth(_, ##__VA_ARGS__, 12, 12, 11, 11, 10, 10, 9, 9, 8, 8, 7, 7, 6, 6, 5, 5, 4, 4, 3, 3, 2, 2, 1, 1, 0)
> >> +#endif
> >
> > similar confusiong with triple underscore bpf_narg. Given this is used
> > in BPF_PROG2, how about renaming it to bpf_narg2 to make this
> > connection? And also note that all similar macros use triple
> > underscore, while you added quad underscores everywhere. Can you
> > please follow up with a rename to use triple underscore for
> > consistency?
>
> Sounds good. Will change to ___bpf_narg2.
>
> >
> >> +
> >> +#define BPF_REG_CNT(t) \
> >
> > this looks like a "public API", but I don't think this was the
> > intention, right? Let's rename it to ___bpf_reg_cnt()?
>
> Yes, I can do it.
>
> >
> >> +       (__builtin_choose_expr(sizeof(t) == 1 || sizeof(t) == 2 || sizeof(t) == 4 || sizeof(t) == 8, 1, \
> >
> > nit: seeing ____bpf_union_arg implementation below I prefer one case
> > per line there as well. How about doing one __builtin_choose_expr per
> > each supported size?
>
> Actually, I did have each individual case per line in the beginning. But
> later on I changed to the above based on Kui-Feng's comment. I can
> change back to each case per line in the next revision to be aligned
> with other usages.
>

Didn't see that conversation, sorry. But my point stands, for
consistency with ___bpf_union_arg and to cut this very long line
shorter it makes more sense to have one case per line.

> >
> >> +        __builtin_choose_expr(sizeof(t) == 16, 2,                                                      \
> >> +                              (void)0)))
> >> +
> >> +#define ____bpf_reg_cnt0()                     (0)
> >> +#define ____bpf_reg_cnt1(t, x)                 (____bpf_reg_cnt0() + BPF_REG_CNT(t))
> >> +#define ____bpf_reg_cnt2(t, x, args...)                (____bpf_reg_cnt1(args) + BPF_REG_CNT(t))
> >> +#define ____bpf_reg_cnt3(t, x, args...)                (____bpf_reg_cnt2(args) + BPF_REG_CNT(t))
> >> +#define ____bpf_reg_cnt4(t, x, args...)                (____bpf_reg_cnt3(args) + BPF_REG_CNT(t))
> >> +#define ____bpf_reg_cnt5(t, x, args...)                (____bpf_reg_cnt4(args) + BPF_REG_CNT(t))
> >> +#define ____bpf_reg_cnt6(t, x, args...)                (____bpf_reg_cnt5(args) + BPF_REG_CNT(t))
> >> +#define ____bpf_reg_cnt7(t, x, args...)                (____bpf_reg_cnt6(args) + BPF_REG_CNT(t))
> >> +#define ____bpf_reg_cnt8(t, x, args...)                (____bpf_reg_cnt7(args) + BPF_REG_CNT(t))
> >> +#define ____bpf_reg_cnt9(t, x, args...)                (____bpf_reg_cnt8(args) + BPF_REG_CNT(t))
> >> +#define ____bpf_reg_cnt10(t, x, args...)       (____bpf_reg_cnt9(args) + BPF_REG_CNT(t))
> >> +#define ____bpf_reg_cnt11(t, x, args...)       (____bpf_reg_cnt10(args) + BPF_REG_CNT(t))
> >> +#define ____bpf_reg_cnt12(t, x, args...)       (____bpf_reg_cnt11(args) + BPF_REG_CNT(t))
> >> +#define ____bpf_reg_cnt(args...)        ___bpf_apply(____bpf_reg_cnt, ____bpf_narg(args))(args)
> >> +
> >> +#define ____bpf_union_arg(t, x, n) \
> >> +       __builtin_choose_expr(sizeof(t) == 1, ({ union { struct { __u8 x; } ___z; t x; } ___tmp = { .___z = {ctx[n]}}; ___tmp.x; }), \
> >> +       __builtin_choose_expr(sizeof(t) == 2, ({ union { struct { __u16 x; } ___z; t x; } ___tmp = { .___z = {ctx[n]} }; ___tmp.x; }), \
> >> +       __builtin_choose_expr(sizeof(t) == 4, ({ union { struct { __u32 x; } ___z; t x; } ___tmp = { .___z = {ctx[n]} }; ___tmp.x; }), \
> >> +       __builtin_choose_expr(sizeof(t) == 8, ({ union { struct { __u64 x; } ___z; t x; } ___tmp = {.___z = {ctx[n]} }; ___tmp.x; }), \
> >> +       __builtin_choose_expr(sizeof(t) == 16, ({ union { struct { __u64 x, y; } ___z; t x; } ___tmp = {.___z = {ctx[n], ctx[n + 1]} }; ___tmp.x; }), \
> >> +                             (void)0)))))
> >
> > looking at this again, we can do a bit better by using arrays, please
> > consider using that. At the very least results in shorter lines:
> >
> >   #define ____bpf_union_arg(t, x, n) \
> > -       __builtin_choose_expr(sizeof(t) == 1, ({ union { struct { __u8
> > x; } ___z; t x; } ___tmp = { .___z = {ctx[n]}}; ___tmp.x; }), \
> > -       __builtin_choose_expr(sizeof(t) == 2, ({ union { struct {
> > __u16 x; } ___z; t x; } ___tmp = { .___z = {ctx[n]} }; ___tmp.x; }), \
> > -       __builtin_choose_expr(sizeof(t) == 4, ({ union { struct {
> > __u32 x; } ___z; t x; } ___tmp = { .___z = {ctx[n]} }; ___tmp.x; }), \
> > -       __builtin_choose_expr(sizeof(t) == 8, ({ union { struct {
> > __u64 x; } ___z; t x; } ___tmp = {.___z = {ctx[n]} }; ___tmp.x; }), \
> > -       __builtin_choose_expr(sizeof(t) == 16, ({ union { struct {
> > __u64 x, y; } ___z; t x; } ___tmp = {.___z = {ctx[n], ctx[n + 1]} };
> > ___tmp.x; }), \
> > +       __builtin_choose_expr(sizeof(t) == 1, ({ union { __u8 z[1]; t
> > x; } ___tmp = { .z = {ctx[n]} }; ___tmp.x; }), \
> > +       __builtin_choose_expr(sizeof(t) == 2, ({ union { __u16 z[1]; t
> > x; } ___tmp = { .z = {ctx[n]} }; ___tmp.x; }), \
> > +       __builtin_choose_expr(sizeof(t) == 4, ({ union { __u32 z[1]; t
> > x; } ___tmp = { .z = {ctx[n]} }; ___tmp.x; }), \
> > +       __builtin_choose_expr(sizeof(t) == 8, ({ union { __u64 z[1]; t
> > x; } ___tmp = {.z = {ctx[n]} }; ___tmp.x; }), \
> > +       __builtin_choose_expr(sizeof(t) == 16, ({ union { __u64 z[2];
> > t x; } ___tmp = {.z = {ctx[n], ctx[n + 1]} }; ___tmp.x; }), \
> >                                (void)0)))))
> >
> > It is using one- or two-element arrays, and it also has uniform
> > {ctx[n]} or {ctx[n], ctx[n + 1]} initialization syntax. Seems a bit
> > nicer than union { struct { ... combo.
>
> Sounds good. Will try to do this.
>
> >
> >> +
> >> +#define ____bpf_ctx_arg0(n, args...)
> >> +#define ____bpf_ctx_arg1(n, t, x)              , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt1(t, x))
> >> +#define ____bpf_ctx_arg2(n, t, x, args...)     , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt2(t, x, args)) ____bpf_ctx_arg1(n, args)
> >> +#define ____bpf_ctx_arg3(n, t, x, args...)     , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt3(t, x, args)) ____bpf_ctx_arg2(n, args)
> >> +#define ____bpf_ctx_arg4(n, t, x, args...)     , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt4(t, x, args)) ____bpf_ctx_arg3(n, args)
> >> +#define ____bpf_ctx_arg5(n, t, x, args...)     , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt5(t, x, args)) ____bpf_ctx_arg4(n, args)
> >> +#define ____bpf_ctx_arg6(n, t, x, args...)     , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt6(t, x, args)) ____bpf_ctx_arg5(n, args)
> >> +#define ____bpf_ctx_arg7(n, t, x, args...)     , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt7(t, x, args)) ____bpf_ctx_arg6(n, args)
> >> +#define ____bpf_ctx_arg8(n, t, x, args...)     , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt8(t, x, args)) ____bpf_ctx_arg7(n, args)
> >> +#define ____bpf_ctx_arg9(n, t, x, args...)     , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt9(t, x, args)) ____bpf_ctx_arg8(n, args)
> >> +#define ____bpf_ctx_arg10(n, t, x, args...)    , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt10(t, x, args)) ____bpf_ctx_arg9(n, args)
> >> +#define ____bpf_ctx_arg11(n, t, x, args...)    , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt11(t, x, args)) ____bpf_ctx_arg10(n, args)
> >> +#define ____bpf_ctx_arg12(n, t, x, args...)    , ____bpf_union_arg(t, x, n - ____bpf_reg_cnt12(t, x, args)) ____bpf_ctx_arg11(n, args)
> >> +#define ____bpf_ctx_arg(n, args...)    ___bpf_apply(____bpf_ctx_arg, ____bpf_narg(args))(n, args)
> >> +
> >> +#define ____bpf_ctx_decl0()
> >> +#define ____bpf_ctx_decl1(t, x)                        , t x
> >> +#define ____bpf_ctx_decl2(t, x, args...)       , t x ____bpf_ctx_decl1(args)
> >> +#define ____bpf_ctx_decl3(t, x, args...)       , t x ____bpf_ctx_decl2(args)
> >> +#define ____bpf_ctx_decl4(t, x, args...)       , t x ____bpf_ctx_decl3(args)
> >> +#define ____bpf_ctx_decl5(t, x, args...)       , t x ____bpf_ctx_decl4(args)
> >> +#define ____bpf_ctx_decl6(t, x, args...)       , t x ____bpf_ctx_decl5(args)
> >> +#define ____bpf_ctx_decl7(t, x, args...)       , t x ____bpf_ctx_decl6(args)
> >> +#define ____bpf_ctx_decl8(t, x, args...)       , t x ____bpf_ctx_decl7(args)
> >> +#define ____bpf_ctx_decl9(t, x, args...)       , t x ____bpf_ctx_decl8(args)
> >> +#define ____bpf_ctx_decl10(t, x, args...)      , t x ____bpf_ctx_decl9(args)
> >> +#define ____bpf_ctx_decl11(t, x, args...)      , t x ____bpf_ctx_decl10(args)
> >> +#define ____bpf_ctx_decl12(t, x, args...)      , t x ____bpf_ctx_decl11(args)
> >> +#define ____bpf_ctx_decl(args...)      ___bpf_apply(____bpf_ctx_decl, ____bpf_narg(args))(args)
> >> +
> >> +/*
> >> + * BPF_PROG2 can handle struct arguments.
> >
> > We have to expand comment here. Let's not slack on this. Point out
> > that it's the similar use and idea as with BPF_PROG, but emphasize the
> > difference in syntax between BPF_PROG and BPF_PROG2. I'd show two
> > simple examples of the same function with BPF_PROG and BPF_PROG2 here.
> > Please follow up.
>
> Will add detailed comments to explain why BPF_PROG2 and its core usage
> and difference from BPF_PROG in the followup patch.
>

cool, thanks!

> >
> >> + */
> >> +#define BPF_PROG2(name, args...)                                               \
> >> +name(unsigned long long *ctx);                                                 \
> >> +static __always_inline typeof(name(0))                                         \
> >> +____##name(unsigned long long *ctx ____bpf_ctx_decl(args));                    \
> >> +typeof(name(0)) name(unsigned long long *ctx)                                  \
> >> +{                                                                              \
> >> +       return ____##name(ctx ____bpf_ctx_arg(____bpf_reg_cnt(args), args));    \
> >
> > nit: you could have simplified this by doing ____bpf_reg_cnt() call
> > inside ____bpf_ctx_decl(args...) definition. I think it's a bit more
> > self-contained that way.
>
> Will do this in the follow-up patch.
>
> >
> >> +}                                                                              \
> >> +static __always_inline typeof(name(0))                                         \
> >> +____##name(unsigned long long *ctx ____bpf_ctx_decl(args))
> >> +
> >>   struct pt_regs;
> >>
> >>   #define ___bpf_kprobe_args0()           ctx
> >> --
> >> 2.30.2
> >>
