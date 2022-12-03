Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5628D641826
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 18:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiLCRm0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Dec 2022 12:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiLCRm0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Dec 2022 12:42:26 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B56C1F9DB
        for <bpf@vger.kernel.org>; Sat,  3 Dec 2022 09:42:25 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so7798207pjj.4
        for <bpf@vger.kernel.org>; Sat, 03 Dec 2022 09:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcOLULCR7XJ8cLjzQecK40KAQihF9AumLSE32FsmesQ=;
        b=ipg5pUT2NtZ3i++KmiCYQiMb2EetYvdOEIn2LqqgXyHW14GsfC7hOCq+QqMPC4z7PG
         YhFCPS80C32o0jp5OLFNjQ0I7ZpOiQopqvVOA/dnpD9eUJ91ivoDe1rT8gTBXH0xjKPi
         nIV9dGYQoVlSzKHkVHicE1xZNhKr3KzzCahnZNlMBz8dJttTs8oSg3Lqr10Uv9dwShSZ
         Z8Km1AAMttHsSLCoKcdj4g8QASN3vdwq2oentFNGVXwSsrWGlYKaL95kYJMBi+jPFdSg
         UrXKkb9evBDm5Ih0uTRqLTAoWPJdspkwEEXE8kqiRbx/p4XvN9PxY7v6PTozGwHVKzXm
         G01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcOLULCR7XJ8cLjzQecK40KAQihF9AumLSE32FsmesQ=;
        b=6kCaCl7c9xyGTh/pIJx9Wzb+fHMKIFgR02e4I23ofbb6g+n2NJ3hxDUibtwAD6p/yX
         DS7gW2Mp7h0Nevimmpn41dA5hQM+kfIfNTb1s7n0BxkO1z+iEySduwkNLCg6VDH+Y/vC
         eAx+EC61zY6bQGq+ySGuDHDnBFFeYR0yRWEaC1D9lfbxWE9iwRc1XTrsetFVVwR05P6g
         Q9mh6nxAjK9ajxxu9d5GjgTYLF6Wz8TYvkIKi4cUoubnsgCkNRTh2Xo2oognbLT4B4FA
         gBDAldrtCA8a/Vqt8LNqHPrRhkWvVnIM9qcQ6E7DdmYDKZZkrekPqf7p3OXhwTmEaAdm
         B5mw==
X-Gm-Message-State: ANoB5pmcMsa64FufCjcbByZf2Bkj8mE9bPBFyBczuzGBY2CTs4nCIR0H
        E7vtEDAqx31r9+gw5QnqgM/9vZpx66k=
X-Google-Smtp-Source: AA0mqf5OBiVVHA+oehSa1NppzmENP6cPnWE02FTRDEs58vM9MkekL6kpxoIt0AZ8qsPmxR6Z44L98w==
X-Received: by 2002:a17:903:1245:b0:187:3921:2b2d with SMTP id u5-20020a170903124500b0018739212b2dmr59418547plh.13.1670089344566;
        Sat, 03 Dec 2022 09:42:24 -0800 (PST)
Received: from google.com ([2601:647:6780:ff0:504b:f0e1:1691:1383])
        by smtp.gmail.com with ESMTPSA id g11-20020aa79dcb000000b00576779b4782sm2665701pfq.9.2022.12.03.09.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 09:42:23 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Sat, 3 Dec 2022 09:42:21 -0800
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
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
Message-ID: <Y4uKfc7g3t1RW3wh@google.com>
References: <20221121213123.1373229-1-jolsa@kernel.org>
 <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net>
 <Y388m6wOktvZo1d4@krava>
 <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FUZZY_VPILL,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 24, 2022 at 09:17:22AM -0800, Alexei Starovoitov wrote:
> On Thu, Nov 24, 2022 at 1:42 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Nov 24, 2022 at 01:41:23AM +0100, Daniel Borkmann wrote:
> > > On 11/21/22 10:31 PM, Jiri Olsa wrote:
> > > > We hit following issues [1] [2] when we attach bpf program that calls
> > > > bpf_trace_printk helper to the contention_begin tracepoint.
> > > >
> > > > As described in [3] with multiple bpf programs that call bpf_trace_printk
> > > > helper attached to the contention_begin might result in exhaustion of
> > > > printk buffer or cause a deadlock [2].
> > > >
> > > > There's also another possible deadlock when multiple bpf programs attach
> > > > to bpf_trace_printk tracepoint and call one of the printk bpf helpers.
> > > >
> > > > This change denies the attachment of bpf program to contention_begin
> > > > and bpf_trace_printk tracepoints if the bpf program calls one of the
> > > > printk bpf helpers.
> > > >
> > > > Adding also verifier check for tb_btf programs, so this can be cought
> > > > in program loading time with error message like:
> > > >
> > > >    Can't attach program with bpf_trace_printk#6 helper to contention_begin tracepoint.
> > > >
> > > > [1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
> > > > [2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/
> > > > [3] https://lore.kernel.org/bpf/Y2j6ivTwFmA0FtvY@krava/
> > > >
> > > > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >   include/linux/bpf.h          |  1 +
> > > >   include/linux/bpf_verifier.h |  2 ++
> > > >   kernel/bpf/syscall.c         |  3 +++
> > > >   kernel/bpf/verifier.c        | 46 ++++++++++++++++++++++++++++++++++++
> > > >   4 files changed, 52 insertions(+)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index c9eafa67f2a2..3ccabede0f50 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -1319,6 +1319,7 @@ struct bpf_prog {
> > > >                             enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
> > > >                             call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
> > > >                             call_get_func_ip:1, /* Do we call get_func_ip() */
> > > > +                           call_printk:1, /* Do we call trace_printk/trace_vprintk  */
> > > >                             tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
> > > >     enum bpf_prog_type      type;           /* Type of BPF program */
> > > >     enum bpf_attach_type    expected_attach_type; /* For some prog types */
> > > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > > index 545152ac136c..7118c2fda59d 100644
> > > > --- a/include/linux/bpf_verifier.h
> > > > +++ b/include/linux/bpf_verifier.h
> > > > @@ -618,6 +618,8 @@ bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> > > >                          struct bpf_reg_state *reg,
> > > >                          enum bpf_arg_type arg_type);
> > > > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog);
> > > > +
> > > >   /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
> > > >   static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> > > >                                          struct btf *btf, u32 btf_id)
> > > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > > index 35972afb6850..9a69bda7d62b 100644
> > > > --- a/kernel/bpf/syscall.c
> > > > +++ b/kernel/bpf/syscall.c
> > > > @@ -3329,6 +3329,9 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
> > > >             return -EINVAL;
> > > >     }
> > > > +   if (bpf_check_tp_printk_denylist(tp_name, prog))
> > > > +           return -EACCES;
> > > > +
> > > >     btp = bpf_get_raw_tracepoint(tp_name);
> > > >     if (!btp)
> > > >             return -ENOENT;
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index f07bec227fef..b662bc851e1c 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -7472,6 +7472,47 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
> > > >                              state->callback_subprogno == subprogno);
> > > >   }
> > > > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog)
> > > > +{
> > > > +   static const char * const denylist[] = {
> > > > +           "contention_begin",
> > > > +           "bpf_trace_printk",
> > > > +   };
> > > > +   int i;
> > > > +
> > > > +   /* Do not allow attachment to denylist[] tracepoints,
> > > > +    * if the program calls some of the printk helpers,
> > > > +    * because there's possibility of deadlock.
> > > > +    */
> > >
> > > What if that prog doesn't but tail calls into another one which calls printk helpers?
> >
> > right, I'll deny that for all BPF_PROG_TYPE_RAW_TRACEPOINT* programs,
> > because I don't see easy way to check on that
> >
> > we can leave printk check for tracing BPF_TRACE_RAW_TP programs,
> > because verifier known the exact tracepoint already
> 
> This is all fragile and merely a stop gap.
> Doesn't sound that the issue is limited to bpf_trace_printk

Right, contention_begin has had problems with memory allocators too
(via task_local_storage) and potentially any code that grabs a lock.

Thanks,
Namhyung
