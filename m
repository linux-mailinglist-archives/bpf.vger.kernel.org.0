Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D183637E24
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 18:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKXRRm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 12:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiKXRRh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 12:17:37 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA82F13F03
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 09:17:35 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s12so3332885edd.5
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 09:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e0gyI5cU7Jz/K1fcAZMa/PDmnwdK9PDQZu1e0ovFmFk=;
        b=bLHkNf+5PnXy8DY2iH+j4QDUfgofXJ7CUcmB1lXWa6V5u63YcMl+tfQ2UZOse2A5lG
         OW2lI76TtXTp3u0dIExjESeOJVnz9JcO79BMn+yB5MAXnJvR2WXA8hOAz0S3UZvco2J4
         3clSDK7pTJnHIC4UDNc1I6vjLaK6GMI+HtAI4jJjgHmBWfLlju7/oQzTFWlkVSXNwd/q
         UiXoXgCU4wCFL2gBO7xQIlML6BMIAjQ3Do6QOUBm1pNVWgx+HylEqmoFLavXfHHZ+N5H
         enqRPCNNdIPvFwG/oR/p8OLaWSdB77ZQqAZr7WPZ+ZrXEPggNAKXQQEqhBVpuYQMoO6s
         1d1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0gyI5cU7Jz/K1fcAZMa/PDmnwdK9PDQZu1e0ovFmFk=;
        b=2coCzCMq9shXpscyHzGCqXHbkiVQ1jyWCQuB1iuqguevjCnNrclnN8JA4EmtOFOgbd
         PqXMd6ovJj70U+WuaDg91/J/nJRb+BDVgQli/FadAkIcoai8Yg7+gQF9+orfpcaWNLTK
         H6enq9Wtfa/5VO0ncnMoJuky6qbxFFCyiYQV26ESNOhmMHU5sWm8QwtPDZPr5PWgFq2T
         M9EOBEa0ugwKSuONxHXeb9CynuRIyf/y+9PJGXxP0flCBoNT71xpt3QP/MXxuTfzDmLS
         zmXkci1EtUyY1nhNHD5x8Z9COIMD4F5mMBjBTQgWi7QUkn0NkH0QcNoy3A+C/lNMCdFB
         fsrQ==
X-Gm-Message-State: ANoB5plak94awZwzInI7VvWFUCRqvt1Ek92Anwgh/Eir2/1jRikVhKou
        z2imlIFRGRXHcPLuWkqhixmrUyJTFAiZ/mBDxWk=
X-Google-Smtp-Source: AA0mqf6XbyLysYqltKIdv9UCltGB5fWbukxXuldn5aN0cXXni88NK67cI36Na51Dv8a7cXYIeq4nG2Z9Q9tXf3bYek0=
X-Received: by 2002:aa7:cb4d:0:b0:469:e00a:a297 with SMTP id
 w13-20020aa7cb4d000000b00469e00aa297mr13529514edt.333.1669310253833; Thu, 24
 Nov 2022 09:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20221121213123.1373229-1-jolsa@kernel.org> <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net>
 <Y388m6wOktvZo1d4@krava>
In-Reply-To: <Y388m6wOktvZo1d4@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 24 Nov 2022 09:17:22 -0800
Message-ID: <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Restrict attachment of bpf program to some tracepoints
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
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

On Thu, Nov 24, 2022 at 1:42 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Nov 24, 2022 at 01:41:23AM +0100, Daniel Borkmann wrote:
> > On 11/21/22 10:31 PM, Jiri Olsa wrote:
> > > We hit following issues [1] [2] when we attach bpf program that calls
> > > bpf_trace_printk helper to the contention_begin tracepoint.
> > >
> > > As described in [3] with multiple bpf programs that call bpf_trace_printk
> > > helper attached to the contention_begin might result in exhaustion of
> > > printk buffer or cause a deadlock [2].
> > >
> > > There's also another possible deadlock when multiple bpf programs attach
> > > to bpf_trace_printk tracepoint and call one of the printk bpf helpers.
> > >
> > > This change denies the attachment of bpf program to contention_begin
> > > and bpf_trace_printk tracepoints if the bpf program calls one of the
> > > printk bpf helpers.
> > >
> > > Adding also verifier check for tb_btf programs, so this can be cought
> > > in program loading time with error message like:
> > >
> > >    Can't attach program with bpf_trace_printk#6 helper to contention_begin tracepoint.
> > >
> > > [1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
> > > [2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/
> > > [3] https://lore.kernel.org/bpf/Y2j6ivTwFmA0FtvY@krava/
> > >
> > > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >   include/linux/bpf.h          |  1 +
> > >   include/linux/bpf_verifier.h |  2 ++
> > >   kernel/bpf/syscall.c         |  3 +++
> > >   kernel/bpf/verifier.c        | 46 ++++++++++++++++++++++++++++++++++++
> > >   4 files changed, 52 insertions(+)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index c9eafa67f2a2..3ccabede0f50 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1319,6 +1319,7 @@ struct bpf_prog {
> > >                             enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
> > >                             call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
> > >                             call_get_func_ip:1, /* Do we call get_func_ip() */
> > > +                           call_printk:1, /* Do we call trace_printk/trace_vprintk  */
> > >                             tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
> > >     enum bpf_prog_type      type;           /* Type of BPF program */
> > >     enum bpf_attach_type    expected_attach_type; /* For some prog types */
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > index 545152ac136c..7118c2fda59d 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -618,6 +618,8 @@ bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> > >                          struct bpf_reg_state *reg,
> > >                          enum bpf_arg_type arg_type);
> > > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog);
> > > +
> > >   /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
> > >   static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> > >                                          struct btf *btf, u32 btf_id)
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index 35972afb6850..9a69bda7d62b 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -3329,6 +3329,9 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
> > >             return -EINVAL;
> > >     }
> > > +   if (bpf_check_tp_printk_denylist(tp_name, prog))
> > > +           return -EACCES;
> > > +
> > >     btp = bpf_get_raw_tracepoint(tp_name);
> > >     if (!btp)
> > >             return -ENOENT;
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index f07bec227fef..b662bc851e1c 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -7472,6 +7472,47 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
> > >                              state->callback_subprogno == subprogno);
> > >   }
> > > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog)
> > > +{
> > > +   static const char * const denylist[] = {
> > > +           "contention_begin",
> > > +           "bpf_trace_printk",
> > > +   };
> > > +   int i;
> > > +
> > > +   /* Do not allow attachment to denylist[] tracepoints,
> > > +    * if the program calls some of the printk helpers,
> > > +    * because there's possibility of deadlock.
> > > +    */
> >
> > What if that prog doesn't but tail calls into another one which calls printk helpers?
>
> right, I'll deny that for all BPF_PROG_TYPE_RAW_TRACEPOINT* programs,
> because I don't see easy way to check on that
>
> we can leave printk check for tracing BPF_TRACE_RAW_TP programs,
> because verifier known the exact tracepoint already

This is all fragile and merely a stop gap.
Doesn't sound that the issue is limited to bpf_trace_printk
