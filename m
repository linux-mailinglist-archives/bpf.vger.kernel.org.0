Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEB9643E32
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 09:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiLFIOR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 03:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiLFIOQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 03:14:16 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0E415FD7
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 00:14:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r7-20020a1c4407000000b003d1e906ca23so120111wma.3
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 00:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa85Q0WaQWHiSDsi8ePXPLUczhw+tg1kaQkvudFWGUA=;
        b=CBBDsWyHjg3epKuD6pJ0YI3HspbjUGRazMAoOkttGbLpMShmjs53PXLkDynOoKxxlA
         ha4j4W+R9U/DbCIakO42XEzKV9aAd4A6/WfijMzueYQvTUqUkewZwgavJ9JXoyBkA9/2
         oTU2+s2qXHy9xqVPKuD0Br9r6kTS4YS1P3Mmy5ULzg3LLX68IlnKdEvwT6fDu+8OIkku
         qaZ8fR9BM6Ozv1zI1Z2dM5q/7bxdwfRVajc2vSDvdgtcnOxZ6Xq1Vdyns5xP5Bms7Hwm
         2ND+//ClTidZ3BmKk4CsExJk0XzkZncHus6Q7qaSGB8ybq82dULmvcsQA3Z0qMlXWHSn
         UJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fa85Q0WaQWHiSDsi8ePXPLUczhw+tg1kaQkvudFWGUA=;
        b=MUO+Z/t/EFuFzEl7/jW3AZgxBKJ8wHTESHuuLNveWbxR/fLy/6IeNR46DPBdHWadBP
         jChRa1mIT6bbmPZOJFq3hfU38VdrXHJBhunxxVCXXulEP/mTujDW1OEqUF8sqpXMNGhX
         FoHjd9SCDCXfa8G4oDi97eBc9FdxyvwRnIZiCi2CxKrz0nxCN0d44EDDgOk8IhqtAdvy
         cUkRJ4BI6RMf+68TZTqiA1PW7T9txEHEYTE5kGM43+nY7EedmCTAbQ8SRGeaYv4zyaLa
         DZImboOfLlSPuGUdq+UJtTMSFQmZp8hqGMiSnvDQmxfdOXE6pfGu/zsFS+hlJ1BkICXo
         /9tg==
X-Gm-Message-State: ANoB5pk/GxldODecGKNErMofGZChMi2UpV9+1vgeme3Y2ONzIraQrICw
        p16r5p37oPykQKQ1UTgDmzY=
X-Google-Smtp-Source: AA0mqf57xjks149jfYIA2OPwhm5ylMPkLJEdzZUh5dgJkz6c3XVcMbEPthWWAjVrv/hjkcpc8am6rg==
X-Received: by 2002:a05:600c:34d1:b0:3d0:878b:d003 with SMTP id d17-20020a05600c34d100b003d0878bd003mr11864813wmq.132.1670314453021;
        Tue, 06 Dec 2022 00:14:13 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id v5-20020adfebc5000000b00241c6729c2bsm15934636wrn.26.2022.12.06.00.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 00:14:12 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 6 Dec 2022 09:14:10 +0100
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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
Message-ID: <Y4750mbd7XEzue0r@krava>
References: <20221121213123.1373229-1-jolsa@kernel.org>
 <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net>
 <Y388m6wOktvZo1d4@krava>
 <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
 <Y4CMbTeVud0WfPtK@krava>
 <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
 <Y4uOSrXBxVwnxZkX@google.com>
 <Y43j3IGvLKgshuhR@krava>
 <CAM9d7cj2QGH2x=J=7LVEEOfcDUYLU0Cmd_O7KEHZM-9FRmX3OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj2QGH2x=J=7LVEEOfcDUYLU0Cmd_O7KEHZM-9FRmX3OA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 05, 2022 at 08:00:16PM -0800, Namhyung Kim wrote:
> On Mon, Dec 5, 2022 at 4:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Sat, Dec 03, 2022 at 09:58:34AM -0800, Namhyung Kim wrote:
> > > On Wed, Nov 30, 2022 at 03:29:39PM -0800, Andrii Nakryiko wrote:
> > > > On Fri, Nov 25, 2022 at 1:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > >
> > > > > On Thu, Nov 24, 2022 at 09:17:22AM -0800, Alexei Starovoitov wrote:
> > > > > > On Thu, Nov 24, 2022 at 1:42 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, Nov 24, 2022 at 01:41:23AM +0100, Daniel Borkmann wrote:
> > > > > > > > On 11/21/22 10:31 PM, Jiri Olsa wrote:
> > > > > > > > > We hit following issues [1] [2] when we attach bpf program that calls
> > > > > > > > > bpf_trace_printk helper to the contention_begin tracepoint.
> > > > > > > > >
> > > > > > > > > As described in [3] with multiple bpf programs that call bpf_trace_printk
> > > > > > > > > helper attached to the contention_begin might result in exhaustion of
> > > > > > > > > printk buffer or cause a deadlock [2].
> > > > > > > > >
> > > > > > > > > There's also another possible deadlock when multiple bpf programs attach
> > > > > > > > > to bpf_trace_printk tracepoint and call one of the printk bpf helpers.
> > > > > > > > >
> > > > > > > > > This change denies the attachment of bpf program to contention_begin
> > > > > > > > > and bpf_trace_printk tracepoints if the bpf program calls one of the
> > > > > > > > > printk bpf helpers.
> > > > > > > > >
> > > > > > > > > Adding also verifier check for tb_btf programs, so this can be cought
> > > > > > > > > in program loading time with error message like:
> > > > > > > > >
> > > > > > > > >    Can't attach program with bpf_trace_printk#6 helper to contention_begin tracepoint.
> > > > > > > > >
> > > > > > > > > [1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
> > > > > > > > > [2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/
> > > > > > > > > [3] https://lore.kernel.org/bpf/Y2j6ivTwFmA0FtvY@krava/
> > > > > > > > >
> > > > > > > > > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > > > > > > > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > > > > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > > > > > ---
> > > > > > > > >   include/linux/bpf.h          |  1 +
> > > > > > > > >   include/linux/bpf_verifier.h |  2 ++
> > > > > > > > >   kernel/bpf/syscall.c         |  3 +++
> > > > > > > > >   kernel/bpf/verifier.c        | 46 ++++++++++++++++++++++++++++++++++++
> > > > > > > > >   4 files changed, 52 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > > > > > index c9eafa67f2a2..3ccabede0f50 100644
> > > > > > > > > --- a/include/linux/bpf.h
> > > > > > > > > +++ b/include/linux/bpf.h
> > > > > > > > > @@ -1319,6 +1319,7 @@ struct bpf_prog {
> > > > > > > > >                             enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
> > > > > > > > >                             call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
> > > > > > > > >                             call_get_func_ip:1, /* Do we call get_func_ip() */
> > > > > > > > > +                           call_printk:1, /* Do we call trace_printk/trace_vprintk  */
> > > > > > > > >                             tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
> > > > > > > > >     enum bpf_prog_type      type;           /* Type of BPF program */
> > > > > > > > >     enum bpf_attach_type    expected_attach_type; /* For some prog types */
> > > > > > > > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > > > > > > > index 545152ac136c..7118c2fda59d 100644
> > > > > > > > > --- a/include/linux/bpf_verifier.h
> > > > > > > > > +++ b/include/linux/bpf_verifier.h
> > > > > > > > > @@ -618,6 +618,8 @@ bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> > > > > > > > >                          struct bpf_reg_state *reg,
> > > > > > > > >                          enum bpf_arg_type arg_type);
> > > > > > > > > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog);
> > > > > > > > > +
> > > > > > > > >   /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
> > > > > > > > >   static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> > > > > > > > >                                          struct btf *btf, u32 btf_id)
> > > > > > > > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > > > > > > > index 35972afb6850..9a69bda7d62b 100644
> > > > > > > > > --- a/kernel/bpf/syscall.c
> > > > > > > > > +++ b/kernel/bpf/syscall.c
> > > > > > > > > @@ -3329,6 +3329,9 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
> > > > > > > > >             return -EINVAL;
> > > > > > > > >     }
> > > > > > > > > +   if (bpf_check_tp_printk_denylist(tp_name, prog))
> > > > > > > > > +           return -EACCES;
> > > > > > > > > +
> > > > > > > > >     btp = bpf_get_raw_tracepoint(tp_name);
> > > > > > > > >     if (!btp)
> > > > > > > > >             return -ENOENT;
> > > > > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > > > > index f07bec227fef..b662bc851e1c 100644
> > > > > > > > > --- a/kernel/bpf/verifier.c
> > > > > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > > > > @@ -7472,6 +7472,47 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
> > > > > > > > >                              state->callback_subprogno == subprogno);
> > > > > > > > >   }
> > > > > > > > > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog)
> > > > > > > > > +{
> > > > > > > > > +   static const char * const denylist[] = {
> > > > > > > > > +           "contention_begin",
> > > > > > > > > +           "bpf_trace_printk",
> > > > > > > > > +   };
> > > > > > > > > +   int i;
> > > > > > > > > +
> > > > > > > > > +   /* Do not allow attachment to denylist[] tracepoints,
> > > > > > > > > +    * if the program calls some of the printk helpers,
> > > > > > > > > +    * because there's possibility of deadlock.
> > > > > > > > > +    */
> > > > > > > >
> > > > > > > > What if that prog doesn't but tail calls into another one which calls printk helpers?
> > > > > > >
> > > > > > > right, I'll deny that for all BPF_PROG_TYPE_RAW_TRACEPOINT* programs,
> > > > > > > because I don't see easy way to check on that
> > > > > > >
> > > > > > > we can leave printk check for tracing BPF_TRACE_RAW_TP programs,
> > > > > > > because verifier known the exact tracepoint already
> > > > > >
> > > > > > This is all fragile and merely a stop gap.
> > > > > > Doesn't sound that the issue is limited to bpf_trace_printk
> > > > >
> > > > > hm, I don't have a better idea how to fix that.. I can't deny
> > > > > contention_begin completely, because we use it in perf via
> > > > > tp_btf/contention_begin (perf lock contention) and I don't
> > > > > think there's another way for perf to do that
> > > > >
> > > > > fwiw the last version below denies BPF_PROG_TYPE_RAW_TRACEPOINT
> > > > > programs completely and tracing BPF_TRACE_RAW_TP with printks
> > > > >
> > > >
> > > > I think disabling bpf_trace_printk() tracepoint for any BPF program is
> > > > totally fine. This tracepoint was never intended to be attached to.
> > > >
> > > > But as for the general bpf_trace_printk() deadlocking. Should we
> > > > discuss how to make it not deadlock instead of starting to denylist
> > > > things left and right?
> > > >
> > > > Do I understand that we take trace_printk_lock only to protect that
> > > > static char buf[]? Can we just make this buf per-CPU and do a trylock
> > > > instead? We'll only fail to bpf_trace_printk() something if we have
> > > > nested BPF programs (rare) or NMI (also rare).
> > > >
> > > > And it's a printk(), it's never mission-critical, so if we drop some
> > > > message in rare case it's totally fine.
> > >
> > > What about contention_begin?  I wonder if we can disallow recursions
> > > for those in the deny list like using bpf_prog_active..
> >
> > I was testing change below which allows to check recursion just
> > for contention_begin tracepoint
> >
> > for the reported issue we might be ok with the change that Andrii
> > suggested, but we could have the change below as extra precaution
> 
> Looks ok to me.  But it seems it'd add the recursion check to every

hm, it should allocate recursion variable just for the contention_begin
tracepoint, rest should see NULL pointer

> tracepoint.  Can we just change the affected tracepoints only by
> using a kind of wrapped btp->bpf_func with some macro magic? ;-)

I tried that and the only other ways I found are:

  - add something like TRACE_EVENT_FLAGS macro and have __init call
    for specific tracepoint that sets the flag

  - add extra new 'bpf_func' that checks the re-entry, but that'd mean
    around 1000 extra mostly unused small functions

> 
> >
> > ---
> 
> [SNIP]
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 3bbd3f0c810c..d27b7dc77894 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2252,9 +2252,8 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
> >  }
> >
> >  static __always_inline
> > -void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
> > +void __bpf_trace_prog_run(struct bpf_prog *prog, u64 *args)
> >  {
> > -       cant_sleep();
> >         if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
> >                 bpf_prog_inc_misses_counter(prog);
> >                 goto out;
> > @@ -2266,6 +2265,22 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
> >         this_cpu_dec(*(prog->active));
> >  }
> >
> > +static __always_inline
> > +void __bpf_trace_run(struct bpf_raw_event_data *data, u64 *args)
> > +{
> > +       struct bpf_prog *prog = data->prog;
> > +
> > +       cant_sleep();
> > +       if (unlikely(!data->recursion))
> 
> likely ?

right, thanks

jirka
