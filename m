Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8800063E586
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 00:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiK3Xda (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 18:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiK3Xc5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 18:32:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0910C9793E
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 15:29:53 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v8so219043edi.3
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 15:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6fPNtgXgfvpQ3nIQvQ1noj+boU7tKTwUbm2Kq0QNOu8=;
        b=gCC5fnThmR+U9IX+Op/pa1ssUP2QYsjNDcyQyyu1RVHdlj+GtL2KGwQfOfct6Ne/i3
         Jt4kCE5PJF34MDQQKYMYlR25UPYW539TlUu3WN2w9ApJX01ibLsq5TOFQYTnO0fHkhaa
         wwaJ4nS65svHvV8Bglfh+Y91/uzWjD3Q+6fBIl7L97MNBrAiKMbvAeYTyxto7CsqcXrZ
         RBhmpDtVzfI3YsSmrbll5gBB0zqoP8fD77SC+vfLav2HfztzIQjWJ4DPgXAkjoxbnkt5
         7S5XXjO94nFtgD6IIinIOjYLlq5QCvvj/PmSGCkogIkfPo20utmri1GoaInNfNlVa0DP
         5khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fPNtgXgfvpQ3nIQvQ1noj+boU7tKTwUbm2Kq0QNOu8=;
        b=oFF2R8lHVtHFxdM+r6B2nN4Ob5TEbed5sLRJun1CebPBt5dQ9zz+RVAjksEi6rNhnN
         RTJINWCDMeYbXQlZSatwsDSkv42UbW93O5uZ0Lo7CqyoujJgD/d7oH3XqDF++a0PG9L8
         vIjH8vKdJEpeIlcx+Ere52IQdYJrL5cn8MONN515xF6KuQStcimmr+VO/EcZf+MrYdsM
         m/WXcBV6JtyLv4zFIMln1essdLZ8zuk8L/aWliRtqD44ayhXgfFXxjzOnAFhKlG4mF3t
         emL/74rrP82VB3AxGw+13ais+WBSV+CiDTBdXRM+W/6pEXm6cbrlIz6WmQY+dKcZGKFY
         rq5g==
X-Gm-Message-State: ANoB5pmBPcqUbg7kphFHwLxCE07NWyqPpwEHOHW9HWyqZV1MVTg1n4zC
        tlG/li+8zKjIhkLNPxdYCemuyU49ZWScNmn0YWc=
X-Google-Smtp-Source: AA0mqf7Bc9gE0z2YdDDMr7A78glgTHuTvXrBwuJ2qq4t10gJPBCV3VUrlFPP2xQYQJIITkzgo8gz5EqiQ8tHnr8iFWw=
X-Received: by 2002:a05:6402:4008:b0:458:dd63:e339 with SMTP id
 d8-20020a056402400800b00458dd63e339mr38953246eda.81.1669850991514; Wed, 30
 Nov 2022 15:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20221121213123.1373229-1-jolsa@kernel.org> <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net>
 <Y388m6wOktvZo1d4@krava> <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
 <Y4CMbTeVud0WfPtK@krava>
In-Reply-To: <Y4CMbTeVud0WfPtK@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Nov 2022 15:29:39 -0800
Message-ID: <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Restrict attachment of bpf program to some tracepoints
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 25, 2022 at 1:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Nov 24, 2022 at 09:17:22AM -0800, Alexei Starovoitov wrote:
> > On Thu, Nov 24, 2022 at 1:42 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Thu, Nov 24, 2022 at 01:41:23AM +0100, Daniel Borkmann wrote:
> > > > On 11/21/22 10:31 PM, Jiri Olsa wrote:
> > > > > We hit following issues [1] [2] when we attach bpf program that calls
> > > > > bpf_trace_printk helper to the contention_begin tracepoint.
> > > > >
> > > > > As described in [3] with multiple bpf programs that call bpf_trace_printk
> > > > > helper attached to the contention_begin might result in exhaustion of
> > > > > printk buffer or cause a deadlock [2].
> > > > >
> > > > > There's also another possible deadlock when multiple bpf programs attach
> > > > > to bpf_trace_printk tracepoint and call one of the printk bpf helpers.
> > > > >
> > > > > This change denies the attachment of bpf program to contention_begin
> > > > > and bpf_trace_printk tracepoints if the bpf program calls one of the
> > > > > printk bpf helpers.
> > > > >
> > > > > Adding also verifier check for tb_btf programs, so this can be cought
> > > > > in program loading time with error message like:
> > > > >
> > > > >    Can't attach program with bpf_trace_printk#6 helper to contention_begin tracepoint.
> > > > >
> > > > > [1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
> > > > > [2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/
> > > > > [3] https://lore.kernel.org/bpf/Y2j6ivTwFmA0FtvY@krava/
> > > > >
> > > > > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > > > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >   include/linux/bpf.h          |  1 +
> > > > >   include/linux/bpf_verifier.h |  2 ++
> > > > >   kernel/bpf/syscall.c         |  3 +++
> > > > >   kernel/bpf/verifier.c        | 46 ++++++++++++++++++++++++++++++++++++
> > > > >   4 files changed, 52 insertions(+)
> > > > >
> > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > index c9eafa67f2a2..3ccabede0f50 100644
> > > > > --- a/include/linux/bpf.h
> > > > > +++ b/include/linux/bpf.h
> > > > > @@ -1319,6 +1319,7 @@ struct bpf_prog {
> > > > >                             enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
> > > > >                             call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
> > > > >                             call_get_func_ip:1, /* Do we call get_func_ip() */
> > > > > +                           call_printk:1, /* Do we call trace_printk/trace_vprintk  */
> > > > >                             tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
> > > > >     enum bpf_prog_type      type;           /* Type of BPF program */
> > > > >     enum bpf_attach_type    expected_attach_type; /* For some prog types */
> > > > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > > > index 545152ac136c..7118c2fda59d 100644
> > > > > --- a/include/linux/bpf_verifier.h
> > > > > +++ b/include/linux/bpf_verifier.h
> > > > > @@ -618,6 +618,8 @@ bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> > > > >                          struct bpf_reg_state *reg,
> > > > >                          enum bpf_arg_type arg_type);
> > > > > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog);
> > > > > +
> > > > >   /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
> > > > >   static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> > > > >                                          struct btf *btf, u32 btf_id)
> > > > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > > > index 35972afb6850..9a69bda7d62b 100644
> > > > > --- a/kernel/bpf/syscall.c
> > > > > +++ b/kernel/bpf/syscall.c
> > > > > @@ -3329,6 +3329,9 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
> > > > >             return -EINVAL;
> > > > >     }
> > > > > +   if (bpf_check_tp_printk_denylist(tp_name, prog))
> > > > > +           return -EACCES;
> > > > > +
> > > > >     btp = bpf_get_raw_tracepoint(tp_name);
> > > > >     if (!btp)
> > > > >             return -ENOENT;
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index f07bec227fef..b662bc851e1c 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -7472,6 +7472,47 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
> > > > >                              state->callback_subprogno == subprogno);
> > > > >   }
> > > > > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog)
> > > > > +{
> > > > > +   static const char * const denylist[] = {
> > > > > +           "contention_begin",
> > > > > +           "bpf_trace_printk",
> > > > > +   };
> > > > > +   int i;
> > > > > +
> > > > > +   /* Do not allow attachment to denylist[] tracepoints,
> > > > > +    * if the program calls some of the printk helpers,
> > > > > +    * because there's possibility of deadlock.
> > > > > +    */
> > > >
> > > > What if that prog doesn't but tail calls into another one which calls printk helpers?
> > >
> > > right, I'll deny that for all BPF_PROG_TYPE_RAW_TRACEPOINT* programs,
> > > because I don't see easy way to check on that
> > >
> > > we can leave printk check for tracing BPF_TRACE_RAW_TP programs,
> > > because verifier known the exact tracepoint already
> >
> > This is all fragile and merely a stop gap.
> > Doesn't sound that the issue is limited to bpf_trace_printk
>
> hm, I don't have a better idea how to fix that.. I can't deny
> contention_begin completely, because we use it in perf via
> tp_btf/contention_begin (perf lock contention) and I don't
> think there's another way for perf to do that
>
> fwiw the last version below denies BPF_PROG_TYPE_RAW_TRACEPOINT
> programs completely and tracing BPF_TRACE_RAW_TP with printks
>

I think disabling bpf_trace_printk() tracepoint for any BPF program is
totally fine. This tracepoint was never intended to be attached to.

But as for the general bpf_trace_printk() deadlocking. Should we
discuss how to make it not deadlock instead of starting to denylist
things left and right?

Do I understand that we take trace_printk_lock only to protect that
static char buf[]? Can we just make this buf per-CPU and do a trylock
instead? We'll only fail to bpf_trace_printk() something if we have
nested BPF programs (rare) or NMI (also rare).

And it's a printk(), it's never mission-critical, so if we drop some
message in rare case it's totally fine.


> with selftest:
>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=bpf/tp_deny_list&id=9a44d23187a699e6cd088d397f6801a1078361bc
>
> we can add global tracepoint deny list if we see other issues in future
>
> jirka
>
>
> ---
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 545152ac136c..7118c2fda59d 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -618,6 +618,8 @@ bool is_dynptr_type_expected(struct bpf_verifier_env *env,
>                              struct bpf_reg_state *reg,
>                              enum bpf_arg_type arg_type);
>
> +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog);
> +
>  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
>  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
>                                              struct btf *btf, u32 btf_id)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 35972afb6850..0ef1aaaf7a45 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3324,6 +3324,9 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
>                         return -EFAULT;
>                 buf[sizeof(buf) - 1] = 0;
>                 tp_name = buf;
> +
> +               if (bpf_check_tp_printk_denylist(tp_name, prog))
> +                       return -EACCES;
>                 break;
>         default:
>                 return -EINVAL;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9528a066cfa5..847fdaa8a67b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7476,6 +7476,40 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
>                                  state->callback_subprogno == subprogno);
>  }
>
> +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog)
> +{
> +       static const char * const denylist[] = {
> +               "contention_begin",
> +               "bpf_trace_printk",
> +       };
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(denylist); i++) {
> +               if (!strcmp(denylist[i], name))
> +                       return 1;
> +       }
> +       return 0;
> +}
> +
> +static int check_tp_printk_denylist(struct bpf_verifier_env *env, int func_id)
> +{
> +       struct bpf_prog *prog = env->prog;
> +
> +       if (prog->type != BPF_PROG_TYPE_TRACING ||
> +           prog->expected_attach_type != BPF_TRACE_RAW_TP)
> +               return 0;
> +
> +       if (WARN_ON_ONCE(!prog->aux->attach_func_name))
> +               return -EINVAL;
> +
> +       if (!bpf_check_tp_printk_denylist(prog->aux->attach_func_name, prog))
> +               return 0;
> +
> +       verbose(env, "Can't attach program with %s#%d helper to %s tracepoint.\n",
> +               func_id_name(func_id), func_id, prog->aux->attach_func_name);
> +       return -EACCES;
> +}
> +
>  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>                              int *insn_idx_p)
>  {
> @@ -7679,6 +7713,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
>                                         set_user_ringbuf_callback_state);
>                 break;
> +       case BPF_FUNC_trace_printk:
> +       case BPF_FUNC_trace_vprintk:
> +               err = check_tp_printk_denylist(env, func_id);
> +               break;
>         }
>
>         if (err)
