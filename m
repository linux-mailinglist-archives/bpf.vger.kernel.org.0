Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE80641854
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 18:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLCR6k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Dec 2022 12:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLCR6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Dec 2022 12:58:39 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB2F19016
        for <bpf@vger.kernel.org>; Sat,  3 Dec 2022 09:58:38 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 124so7749151pfy.0
        for <bpf@vger.kernel.org>; Sat, 03 Dec 2022 09:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpY7S6c9qmPOOnjkEF1PAG5uD5fw82Ae5ZHSOK7oMtI=;
        b=g4wLImvO91sOCS88H8++p+WMhk1ssUU1MQL/Zdl+5OGg1G6ziBMfkUYJ9ZWWoM2L38
         aREJdQaCcNQYm8Qg2zJE2oxSpIpGRqxnoYBcAw0jLT1+F7+8LmO+ip4O/TecXkWPlmYK
         YXBOaH7qka+2OQC6yRfn44EFqKJlBf5y0/R/7enVgPoRfgxUAn5qMWjrQh0m9T6MTB+E
         CGkuDmHMtf0A1AENn0YwduUQGFBJkbN0tYAVuW/0mkeUI6w0W+gQs7zKQSplEr928otv
         YONTkmfD78r+eHc7K2u9V4QPsRGxIiSO/4AlZBtfHFTTSdV3LI6RUv+VgFN7r9G+HAbT
         67Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpY7S6c9qmPOOnjkEF1PAG5uD5fw82Ae5ZHSOK7oMtI=;
        b=km6x91OH1X6tbkZGTHFpt2CpMUjMEZ6wTaNy9McUNgcK6+PvKYMVmdz6WuHUOcUjFZ
         TIqZvyJjtSiTiOsSjw6c6rF/L6p8PSjGAAYYIfmKxTEhfTRcLhWw/uWdiLlFwqHg/HHW
         zTrYX9fM4T3Npzih7eTgRwwjl2tzTh9rXfAM53NuXHzwkNccgN5egHC3i5cLg6WZhthD
         McbUeqe8YloO5z7SwwvGnIu8VED82A+XTmdMStpY6qxYoeAUa7F+lJzVnEsP+rCZ8M4U
         aAffWviIz1WxzK7k89dW9hWZ8jj5MDbc8vvIdyukAINt7cNGscrInvMOpUisVn9Tg3mC
         uxtw==
X-Gm-Message-State: ANoB5pnXRXuY7KYN9XH97WUOqZX2YUfL41S7o8mgblCS4B6PPJWLvIaE
        M6uhVe4sO+KSo77iJJ0ZwGg=
X-Google-Smtp-Source: AA0mqf7EQ36AW79NzeGFdSlBc1DKrEhxj3wXKDim4ktaoPLLBKVjbFBN5MM0kfT7IrQsmDy4sHJTbA==
X-Received: by 2002:aa7:8b4d:0:b0:56c:411f:b699 with SMTP id i13-20020aa78b4d000000b0056c411fb699mr56708697pfd.48.1670090317668;
        Sat, 03 Dec 2022 09:58:37 -0800 (PST)
Received: from google.com ([2601:647:6780:ff0:504b:f0e1:1691:1383])
        by smtp.gmail.com with ESMTPSA id mv15-20020a17090b198f00b0021937b2118bsm8443395pjb.54.2022.12.03.09.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 09:58:37 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Sat, 3 Dec 2022 09:58:34 -0800
From:   Namhyung Kim <namhyung@kernel.org>
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
Message-ID: <Y4uOSrXBxVwnxZkX@google.com>
References: <20221121213123.1373229-1-jolsa@kernel.org>
 <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net>
 <Y388m6wOktvZo1d4@krava>
 <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
 <Y4CMbTeVud0WfPtK@krava>
 <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FUZZY_VPILL,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
> 
> And it's a printk(), it's never mission-critical, so if we drop some
> message in rare case it's totally fine.

What about contention_begin?  I wonder if we can disallow recursions
for those in the deny list like using bpf_prog_active..

Thanks,
Namhyung

