Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B63643C09
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 05:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiLFEBh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 23:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbiLFEBU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 23:01:20 -0500
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA192316B
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 20:00:29 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id d123so3542447iof.6
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 20:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFg2X0NL0ytc3uOWrJM7MNXP/g1bqJ4w37s2r3Gv0wg=;
        b=DS6B7ICUFCHu1oozWlZ0iljF0x9zMaI3E6wKXaE21IqL2vVWIky575mkqkctOxdoCz
         80Y9gBiHsNJwAfi3TeYGG3p/3pn0Ruo+rcuh0Jjv+KoZEWlXvgWa9PO19hznmSWoO2ZN
         UUQLf4/BoteG1wySo/gDIGGyFpSFyaj2dHLSVZBGeS9g9jnZhxH4+LSE82y+0/7lYT3W
         K5waJmR6ySfRsiwQHS9/c/EnxCuCX+3gMptbx8XsstaucJJPUG5fp+IFbd22aBad4HCp
         akYzRr48JWd8nAVjKf99aRFFwO88r1UStgGGJRE9LcQNosn7zmzoN4bdVvgvtuFZMbfL
         V5ug==
X-Gm-Message-State: ANoB5pk3IMYHgKOwTJuC5+BprZZGOfz645C+I7DhdcnWZwqHuN0aKGLb
        3RZcl24k9PEd8lGAOMkqOzrErPp2MYxmuXW72VI=
X-Google-Smtp-Source: AA0mqf54DiQUSPgBAvazFK1tokxRVMELZQvEbgoED73XfcuN5qbKDhr7X/axaqN+jYmPM5ZS+kBEsKq8xt0f4sec9a0=
X-Received: by 2002:a5d:97c9:0:b0:6a2:e3df:a40e with SMTP id
 k9-20020a5d97c9000000b006a2e3dfa40emr39391273ios.113.1670299228509; Mon, 05
 Dec 2022 20:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20221121213123.1373229-1-jolsa@kernel.org> <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net>
 <Y388m6wOktvZo1d4@krava> <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
 <Y4CMbTeVud0WfPtK@krava> <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
 <Y4uOSrXBxVwnxZkX@google.com> <Y43j3IGvLKgshuhR@krava>
In-Reply-To: <Y43j3IGvLKgshuhR@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 5 Dec 2022 20:00:16 -0800
Message-ID: <CAM9d7cj2QGH2x=J=7LVEEOfcDUYLU0Cmd_O7KEHZM-9FRmX3OA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Restrict attachment of bpf program to some tracepoints
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Sun <sunhao.th@gmail.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FUZZY_VPILL,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 5, 2022 at 4:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Sat, Dec 03, 2022 at 09:58:34AM -0800, Namhyung Kim wrote:
> > On Wed, Nov 30, 2022 at 03:29:39PM -0800, Andrii Nakryiko wrote:
> > > On Fri, Nov 25, 2022 at 1:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Thu, Nov 24, 2022 at 09:17:22AM -0800, Alexei Starovoitov wrote:
> > > > > On Thu, Nov 24, 2022 at 1:42 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Nov 24, 2022 at 01:41:23AM +0100, Daniel Borkmann wrote:
> > > > > > > On 11/21/22 10:31 PM, Jiri Olsa wrote:
> > > > > > > > We hit following issues [1] [2] when we attach bpf program that calls
> > > > > > > > bpf_trace_printk helper to the contention_begin tracepoint.
> > > > > > > >
> > > > > > > > As described in [3] with multiple bpf programs that call bpf_trace_printk
> > > > > > > > helper attached to the contention_begin might result in exhaustion of
> > > > > > > > printk buffer or cause a deadlock [2].
> > > > > > > >
> > > > > > > > There's also another possible deadlock when multiple bpf programs attach
> > > > > > > > to bpf_trace_printk tracepoint and call one of the printk bpf helpers.
> > > > > > > >
> > > > > > > > This change denies the attachment of bpf program to contention_begin
> > > > > > > > and bpf_trace_printk tracepoints if the bpf program calls one of the
> > > > > > > > printk bpf helpers.
> > > > > > > >
> > > > > > > > Adding also verifier check for tb_btf programs, so this can be cought
> > > > > > > > in program loading time with error message like:
> > > > > > > >
> > > > > > > >    Can't attach program with bpf_trace_printk#6 helper to contention_begin tracepoint.
> > > > > > > >
> > > > > > > > [1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
> > > > > > > > [2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/
> > > > > > > > [3] https://lore.kernel.org/bpf/Y2j6ivTwFmA0FtvY@krava/
> > > > > > > >
> > > > > > > > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > > > > > > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > > > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > > > > ---
> > > > > > > >   include/linux/bpf.h          |  1 +
> > > > > > > >   include/linux/bpf_verifier.h |  2 ++
> > > > > > > >   kernel/bpf/syscall.c         |  3 +++
> > > > > > > >   kernel/bpf/verifier.c        | 46 ++++++++++++++++++++++++++++++++++++
> > > > > > > >   4 files changed, 52 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > > > > index c9eafa67f2a2..3ccabede0f50 100644
> > > > > > > > --- a/include/linux/bpf.h
> > > > > > > > +++ b/include/linux/bpf.h
> > > > > > > > @@ -1319,6 +1319,7 @@ struct bpf_prog {
> > > > > > > >                             enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
> > > > > > > >                             call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
> > > > > > > >                             call_get_func_ip:1, /* Do we call get_func_ip() */
> > > > > > > > +                           call_printk:1, /* Do we call trace_printk/trace_vprintk  */
> > > > > > > >                             tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
> > > > > > > >     enum bpf_prog_type      type;           /* Type of BPF program */
> > > > > > > >     enum bpf_attach_type    expected_attach_type; /* For some prog types */
> > > > > > > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > > > > > > index 545152ac136c..7118c2fda59d 100644
> > > > > > > > --- a/include/linux/bpf_verifier.h
> > > > > > > > +++ b/include/linux/bpf_verifier.h
> > > > > > > > @@ -618,6 +618,8 @@ bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> > > > > > > >                          struct bpf_reg_state *reg,
> > > > > > > >                          enum bpf_arg_type arg_type);
> > > > > > > > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog);
> > > > > > > > +
> > > > > > > >   /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
> > > > > > > >   static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> > > > > > > >                                          struct btf *btf, u32 btf_id)
> > > > > > > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > > > > > > index 35972afb6850..9a69bda7d62b 100644
> > > > > > > > --- a/kernel/bpf/syscall.c
> > > > > > > > +++ b/kernel/bpf/syscall.c
> > > > > > > > @@ -3329,6 +3329,9 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
> > > > > > > >             return -EINVAL;
> > > > > > > >     }
> > > > > > > > +   if (bpf_check_tp_printk_denylist(tp_name, prog))
> > > > > > > > +           return -EACCES;
> > > > > > > > +
> > > > > > > >     btp = bpf_get_raw_tracepoint(tp_name);
> > > > > > > >     if (!btp)
> > > > > > > >             return -ENOENT;
> > > > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > > > index f07bec227fef..b662bc851e1c 100644
> > > > > > > > --- a/kernel/bpf/verifier.c
> > > > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > > > @@ -7472,6 +7472,47 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
> > > > > > > >                              state->callback_subprogno == subprogno);
> > > > > > > >   }
> > > > > > > > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog)
> > > > > > > > +{
> > > > > > > > +   static const char * const denylist[] = {
> > > > > > > > +           "contention_begin",
> > > > > > > > +           "bpf_trace_printk",
> > > > > > > > +   };
> > > > > > > > +   int i;
> > > > > > > > +
> > > > > > > > +   /* Do not allow attachment to denylist[] tracepoints,
> > > > > > > > +    * if the program calls some of the printk helpers,
> > > > > > > > +    * because there's possibility of deadlock.
> > > > > > > > +    */
> > > > > > >
> > > > > > > What if that prog doesn't but tail calls into another one which calls printk helpers?
> > > > > >
> > > > > > right, I'll deny that for all BPF_PROG_TYPE_RAW_TRACEPOINT* programs,
> > > > > > because I don't see easy way to check on that
> > > > > >
> > > > > > we can leave printk check for tracing BPF_TRACE_RAW_TP programs,
> > > > > > because verifier known the exact tracepoint already
> > > > >
> > > > > This is all fragile and merely a stop gap.
> > > > > Doesn't sound that the issue is limited to bpf_trace_printk
> > > >
> > > > hm, I don't have a better idea how to fix that.. I can't deny
> > > > contention_begin completely, because we use it in perf via
> > > > tp_btf/contention_begin (perf lock contention) and I don't
> > > > think there's another way for perf to do that
> > > >
> > > > fwiw the last version below denies BPF_PROG_TYPE_RAW_TRACEPOINT
> > > > programs completely and tracing BPF_TRACE_RAW_TP with printks
> > > >
> > >
> > > I think disabling bpf_trace_printk() tracepoint for any BPF program is
> > > totally fine. This tracepoint was never intended to be attached to.
> > >
> > > But as for the general bpf_trace_printk() deadlocking. Should we
> > > discuss how to make it not deadlock instead of starting to denylist
> > > things left and right?
> > >
> > > Do I understand that we take trace_printk_lock only to protect that
> > > static char buf[]? Can we just make this buf per-CPU and do a trylock
> > > instead? We'll only fail to bpf_trace_printk() something if we have
> > > nested BPF programs (rare) or NMI (also rare).
> > >
> > > And it's a printk(), it's never mission-critical, so if we drop some
> > > message in rare case it's totally fine.
> >
> > What about contention_begin?  I wonder if we can disallow recursions
> > for those in the deny list like using bpf_prog_active..
>
> I was testing change below which allows to check recursion just
> for contention_begin tracepoint
>
> for the reported issue we might be ok with the change that Andrii
> suggested, but we could have the change below as extra precaution

Looks ok to me.  But it seems it'd add the recursion check to every
tracepoint.  Can we just change the affected tracepoints only by
using a kind of wrapped btp->bpf_func with some macro magic? ;-)

>
> ---

[SNIP]
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3bbd3f0c810c..d27b7dc77894 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2252,9 +2252,8 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
>  }
>
>  static __always_inline
> -void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
> +void __bpf_trace_prog_run(struct bpf_prog *prog, u64 *args)
>  {
> -       cant_sleep();
>         if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
>                 bpf_prog_inc_misses_counter(prog);
>                 goto out;
> @@ -2266,6 +2265,22 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
>         this_cpu_dec(*(prog->active));
>  }
>
> +static __always_inline
> +void __bpf_trace_run(struct bpf_raw_event_data *data, u64 *args)
> +{
> +       struct bpf_prog *prog = data->prog;
> +
> +       cant_sleep();
> +       if (unlikely(!data->recursion))

likely ?

Thanks,
Namhyung


> +               return __bpf_trace_prog_run(prog, args);
> +
> +       if (unlikely(this_cpu_inc_return(*(data->recursion))))
> +               goto out;
> +       __bpf_trace_prog_run(prog, args);
> +out:
> +       this_cpu_dec(*(data->recursion));
> +}
> +
>  #define UNPACK(...)                    __VA_ARGS__
>  #define REPEAT_1(FN, DL, X, ...)       FN(X)
>  #define REPEAT_2(FN, DL, X, ...)       FN(X) UNPACK DL REPEAT_1(FN, DL, __VA_ARGS__)
> @@ -2290,12 +2305,12 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
>  #define __SEQ_0_11     0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
>
>  #define BPF_TRACE_DEFN_x(x)                                            \
> -       void bpf_trace_run##x(struct bpf_prog *prog,                    \
> +       void bpf_trace_run##x(struct bpf_raw_event_data *data,          \
>                               REPEAT(x, SARG, __DL_COM, __SEQ_0_11))    \
>         {                                                               \
>                 u64 args[x];                                            \
>                 REPEAT(x, COPY, __DL_SEM, __SEQ_0_11);                  \
> -               __bpf_trace_run(prog, args);                            \
> +               __bpf_trace_run(data, args);                            \
>         }                                                               \
>         EXPORT_SYMBOL_GPL(bpf_trace_run##x)
>  BPF_TRACE_DEFN_x(1);
> @@ -2311,8 +2326,9 @@ BPF_TRACE_DEFN_x(10);
>  BPF_TRACE_DEFN_x(11);
>  BPF_TRACE_DEFN_x(12);
>
> -static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> +static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_raw_event_data *data)
>  {
> +       struct bpf_prog *prog = data->prog;
>         struct tracepoint *tp = btp->tp;
>
>         /*
> @@ -2326,17 +2342,17 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
>                 return -EINVAL;
>
>         return tracepoint_probe_register_may_exist(tp, (void *)btp->bpf_func,
> -                                                  prog);
> +                                                  data);
>  }
>
> -int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> +int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_raw_event_data *data)
>  {
> -       return __bpf_probe_register(btp, prog);
> +       return __bpf_probe_register(btp, data);
>  }
>
> -int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
> +int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_raw_event_data *data)
>  {
> -       return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, prog);
> +       return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, data);
>  }
>
>  int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
