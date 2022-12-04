Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E6A641FEC
	for <lists+bpf@lfdr.de>; Sun,  4 Dec 2022 22:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiLDVo7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Dec 2022 16:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLDVo6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Dec 2022 16:44:58 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07F7FD1A
        for <bpf@vger.kernel.org>; Sun,  4 Dec 2022 13:44:56 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id td2so23565928ejc.5
        for <bpf@vger.kernel.org>; Sun, 04 Dec 2022 13:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qZZ1Ufl+yNOvBBPaPvC2AWuPWocKTKojFjHDpB700C0=;
        b=M6d5IS4MtuGE4bE2o7ex0v+QTNaDlRsCBN0/0WYA+S6dGnJYLuVxQL757JMuR4V1T/
         qGJwDOWheaaVujagtCE0lSX5s+hzUY2B7wLJn7uMJ9x7A7hDhdfCULdPmsyHOlu6RLux
         DHKv7cfRfN74qQeflznmciN15qtFVv2Z61PLSgthib1zHng6YwSHu0+U9+usFIEdQ5Tv
         fgNtvFZN0/HKP00jBOFtmfhktNdbO0fkVKAxBEjriPCjflFsXxGPzR1l70dFMI5atsDb
         8qt8J0mTWGTBKNkLhVaakdgxO7t8I7pvihs6HloR2WoRWBMzKln4eHbrj4A8SOY18069
         zeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZZ1Ufl+yNOvBBPaPvC2AWuPWocKTKojFjHDpB700C0=;
        b=w078OELn/hJJryFaIuGmlB8XNZ/J822jcUMQJu/bR7gFKV1yQHR1lwSiPmMksZ28EB
         76eVnrm5l0CoWl/+1mxo2evLRtkJUyphUIpDPKSdT+YF0fnht/jouvMJSXorlLYl7FMt
         MUCkiexEl1NTPd5VZO1Q+aF+ml9cuELjGxWR1aUF7WVZVhdVlRBWHVxM4CirRC0KMJeI
         73sY/PrsqLgPZtUtb/i8rfeFuHe81RdCh8Ki1Cz84Y1a+kcp8sA2FWnVpjeA+umDHWK7
         xIZlJDahPnjC/7TAW3+ZH/geLjyz9xXLI+ruutrC3yoEUDzC+A+g04p2XlYdceTlNRF8
         Ul5Q==
X-Gm-Message-State: ANoB5pklwjd9STS4nGjZwuBCykPm5HtHkFHYmDtzZvlXsCEvU/FeeIw7
        e6LngEmDfekDCnpVTWEA5Ec=
X-Google-Smtp-Source: AA0mqf6YadhI/3erv/BQj50K4mEZB7htYYLwJ4xU2DlmpRcWX1g6RRCghJ/GeXojHdP75j2aY7ViMQ==
X-Received: by 2002:a17:906:2a85:b0:7ad:cc9f:4ae0 with SMTP id l5-20020a1709062a8500b007adcc9f4ae0mr64611961eje.504.1670190295112;
        Sun, 04 Dec 2022 13:44:55 -0800 (PST)
Received: from krava ([83.240.62.248])
        by smtp.gmail.com with ESMTPSA id sb25-20020a1709076d9900b007ba46867e6asm5590116ejc.16.2022.12.04.13.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 13:44:54 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 4 Dec 2022 22:44:52 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
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
Subject: Re: [PATCH bpf-next] bpf: Restrict attachment of bpf program to some
 tracepoints
Message-ID: <Y40U1D2bV+hlS/oi@krava>
References: <20221121213123.1373229-1-jolsa@kernel.org>
 <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net>
 <Y388m6wOktvZo1d4@krava>
 <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
 <Y4CMbTeVud0WfPtK@krava>
 <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 30, 2022 at 03:29:39PM -0800, Andrii Nakryiko wrote:
> On Fri, Nov 25, 2022 at 1:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Nov 24, 2022 at 09:17:22AM -0800, Alexei Starovoitov wrote:
> > > On Thu, Nov 24, 2022 at 1:42 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Thu, Nov 24, 2022 at 01:41:23AM +0100, Daniel Borkmann wrote:
> > > > > On 11/21/22 10:31 PM, Jiri Olsa wrote:
> > > > > > We hit following issues [1] [2] when we attach bpf program that calls
> > > > > > bpf_trace_printk helper to the contention_begin tracepoint.
> > > > > >
> > > > > > As described in [3] with multiple bpf programs that call bpf_trace_printk
> > > > > > helper attached to the contention_begin might result in exhaustion of
> > > > > > printk buffer or cause a deadlock [2].
> > > > > >
> > > > > > There's also another possible deadlock when multiple bpf programs attach
> > > > > > to bpf_trace_printk tracepoint and call one of the printk bpf helpers.
> > > > > >
> > > > > > This change denies the attachment of bpf program to contention_begin
> > > > > > and bpf_trace_printk tracepoints if the bpf program calls one of the
> > > > > > printk bpf helpers.
> > > > > >
> > > > > > Adding also verifier check for tb_btf programs, so this can be cought
> > > > > > in program loading time with error message like:
> > > > > >
> > > > > >    Can't attach program with bpf_trace_printk#6 helper to contention_begin tracepoint.
> > > > > >
> > > > > > [1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
> > > > > > [2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/
> > > > > > [3] https://lore.kernel.org/bpf/Y2j6ivTwFmA0FtvY@krava/
> > > > > >
> > > > > > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > > > > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > > ---
> > > > > >   include/linux/bpf.h          |  1 +
> > > > > >   include/linux/bpf_verifier.h |  2 ++
> > > > > >   kernel/bpf/syscall.c         |  3 +++
> > > > > >   kernel/bpf/verifier.c        | 46 ++++++++++++++++++++++++++++++++++++
> > > > > >   4 files changed, 52 insertions(+)
> > > > > >
> > > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > > index c9eafa67f2a2..3ccabede0f50 100644
> > > > > > --- a/include/linux/bpf.h
> > > > > > +++ b/include/linux/bpf.h
> > > > > > @@ -1319,6 +1319,7 @@ struct bpf_prog {
> > > > > >                             enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
> > > > > >                             call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
> > > > > >                             call_get_func_ip:1, /* Do we call get_func_ip() */
> > > > > > +                           call_printk:1, /* Do we call trace_printk/trace_vprintk  */
> > > > > >                             tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
> > > > > >     enum bpf_prog_type      type;           /* Type of BPF program */
> > > > > >     enum bpf_attach_type    expected_attach_type; /* For some prog types */
> > > > > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > > > > index 545152ac136c..7118c2fda59d 100644
> > > > > > --- a/include/linux/bpf_verifier.h
> > > > > > +++ b/include/linux/bpf_verifier.h
> > > > > > @@ -618,6 +618,8 @@ bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> > > > > >                          struct bpf_reg_state *reg,
> > > > > >                          enum bpf_arg_type arg_type);
> > > > > > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog);
> > > > > > +
> > > > > >   /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
> > > > > >   static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> > > > > >                                          struct btf *btf, u32 btf_id)
> > > > > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > > > > index 35972afb6850..9a69bda7d62b 100644
> > > > > > --- a/kernel/bpf/syscall.c
> > > > > > +++ b/kernel/bpf/syscall.c
> > > > > > @@ -3329,6 +3329,9 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
> > > > > >             return -EINVAL;
> > > > > >     }
> > > > > > +   if (bpf_check_tp_printk_denylist(tp_name, prog))
> > > > > > +           return -EACCES;
> > > > > > +
> > > > > >     btp = bpf_get_raw_tracepoint(tp_name);
> > > > > >     if (!btp)
> > > > > >             return -ENOENT;
> > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > index f07bec227fef..b662bc851e1c 100644
> > > > > > --- a/kernel/bpf/verifier.c
> > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > @@ -7472,6 +7472,47 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
> > > > > >                              state->callback_subprogno == subprogno);
> > > > > >   }
> > > > > > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog)
> > > > > > +{
> > > > > > +   static const char * const denylist[] = {
> > > > > > +           "contention_begin",
> > > > > > +           "bpf_trace_printk",
> > > > > > +   };
> > > > > > +   int i;
> > > > > > +
> > > > > > +   /* Do not allow attachment to denylist[] tracepoints,
> > > > > > +    * if the program calls some of the printk helpers,
> > > > > > +    * because there's possibility of deadlock.
> > > > > > +    */
> > > > >
> > > > > What if that prog doesn't but tail calls into another one which calls printk helpers?
> > > >
> > > > right, I'll deny that for all BPF_PROG_TYPE_RAW_TRACEPOINT* programs,
> > > > because I don't see easy way to check on that
> > > >
> > > > we can leave printk check for tracing BPF_TRACE_RAW_TP programs,
> > > > because verifier known the exact tracepoint already
> > >
> > > This is all fragile and merely a stop gap.
> > > Doesn't sound that the issue is limited to bpf_trace_printk
> >
> > hm, I don't have a better idea how to fix that.. I can't deny
> > contention_begin completely, because we use it in perf via
> > tp_btf/contention_begin (perf lock contention) and I don't
> > think there's another way for perf to do that
> >
> > fwiw the last version below denies BPF_PROG_TYPE_RAW_TRACEPOINT
> > programs completely and tracing BPF_TRACE_RAW_TP with printks
> >
> 
> I think disabling bpf_trace_printk() tracepoint for any BPF program is
> totally fine. This tracepoint was never intended to be attached to.
> 
> But as for the general bpf_trace_printk() deadlocking. Should we
> discuss how to make it not deadlock instead of starting to denylist
> things left and right?
> 
> Do I understand that we take trace_printk_lock only to protect that
> static char buf[]? Can we just make this buf per-CPU and do a trylock
> instead? We'll only fail to bpf_trace_printk() something if we have
> nested BPF programs (rare) or NMI (also rare).

ugh, sorry I overlooked your reply :-\

sounds good.. if it'd be acceptable to use trylock, we'd get rid of the
contention_begin tracepoint being triggered, which was the case for deadlock

jirka

> 
> And it's a printk(), it's never mission-critical, so if we drop some
> message in rare case it's totally fine.
> 
> 
> > with selftest:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=bpf/tp_deny_list&id=9a44d23187a699e6cd088d397f6801a1078361bc
> >
> > we can add global tracepoint deny list if we see other issues in future
> >
> > jirka
> >
> >
> > ---
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 545152ac136c..7118c2fda59d 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -618,6 +618,8 @@ bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> >                              struct bpf_reg_state *reg,
> >                              enum bpf_arg_type arg_type);
> >
> > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog);
> > +
> >  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
> >  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> >                                              struct btf *btf, u32 btf_id)
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 35972afb6850..0ef1aaaf7a45 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3324,6 +3324,9 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
> >                         return -EFAULT;
> >                 buf[sizeof(buf) - 1] = 0;
> >                 tp_name = buf;
> > +
> > +               if (bpf_check_tp_printk_denylist(tp_name, prog))
> > +                       return -EACCES;
> >                 break;
> >         default:
> >                 return -EINVAL;
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9528a066cfa5..847fdaa8a67b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7476,6 +7476,40 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
> >                                  state->callback_subprogno == subprogno);
> >  }
> >
> > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog)
> > +{
> > +       static const char * const denylist[] = {
> > +               "contention_begin",
> > +               "bpf_trace_printk",
> > +       };
> > +       int i;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(denylist); i++) {
> > +               if (!strcmp(denylist[i], name))
> > +                       return 1;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static int check_tp_printk_denylist(struct bpf_verifier_env *env, int func_id)
> > +{
> > +       struct bpf_prog *prog = env->prog;
> > +
> > +       if (prog->type != BPF_PROG_TYPE_TRACING ||
> > +           prog->expected_attach_type != BPF_TRACE_RAW_TP)
> > +               return 0;
> > +
> > +       if (WARN_ON_ONCE(!prog->aux->attach_func_name))
> > +               return -EINVAL;
> > +
> > +       if (!bpf_check_tp_printk_denylist(prog->aux->attach_func_name, prog))
> > +               return 0;
> > +
> > +       verbose(env, "Can't attach program with %s#%d helper to %s tracepoint.\n",
> > +               func_id_name(func_id), func_id, prog->aux->attach_func_name);
> > +       return -EACCES;
> > +}
> > +
> >  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >                              int *insn_idx_p)
> >  {
> > @@ -7679,6 +7713,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >                 err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
> >                                         set_user_ringbuf_callback_state);
> >                 break;
> > +       case BPF_FUNC_trace_printk:
> > +       case BPF_FUNC_trace_vprintk:
> > +               err = check_tp_printk_denylist(env, func_id);
> > +               break;
> >         }
> >
> >         if (err)
