Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA8A4F9F8F
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 00:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiDHWYL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 18:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiDHWYK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 18:24:10 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E27659E
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 15:22:05 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 125so12231870iov.10
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 15:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AymeT0ITMJjk1rU904QGD0+hucNA5HCoouVG3EhtqXg=;
        b=hCOEQ1hwbXB4SKRobVtDTZPo2SRqpae8qEFYifKuOPvHVzZcaUMLV00VKBVZ8kAB6F
         HnDcH8oAfcQz9651j9od0CR/szbO9FVLbYQKN/2iXoo2zGZlLqJgETqPuqFw4xHwP/Y2
         CwODPwoRly4xfAJIAxj194j+s69NWIytUvFb++qnAoj62yE2yAWLoNShLjw0Y8DzV0zV
         DdolZWxuHIDe6AhjajeB+yGaS+lROA1EgQWLo2BIUAzUgn2HkdO0hvaLWmmu9gR/uXcT
         7HsVVNrGNo3nVOTyOTPV9S75OQOSRPOzs5smoQ2ZA3ra5Hc4yL7obacvU8gtuzFZMd+9
         4PSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AymeT0ITMJjk1rU904QGD0+hucNA5HCoouVG3EhtqXg=;
        b=GleH8s3tjVWoynxuYX/s1fENpw47DNNzr+YITIpcWKRHTMHECC9AWwHu1fuCR+J4zh
         i08Y6tcAIgliY+5s8QfEpbLCZmpSkZ7OPtUgrzRIk1JwRSlIzXi3J0Xf1FwKJVkfzUqL
         s+a6kBTYwtEH8nH2gQNDmN/EI11qdcKFkOOIk9KFn+3uMnxgPEsN+lEDd9u6aaW2jS2W
         XSVdAlrNqkgGP4TWFgBYSv8bI5xXUDawu59Szp8+SjIe69ojO84MeLWnd6Tm7olvpkgF
         f7OZs3SJBp20VHSq2nle8Fn5MlIpfMQ/T1/fIL4YlRjHpiWRZqlpS3PkbcdqArFqYU+p
         37/g==
X-Gm-Message-State: AOAM531ofZ/HUSkL9XG6OvHG4nvNBgRcqfie6jnBa5fe2pKg26eT3oiB
        KUzZWExk7761Pzdcl5qaRSPL1xrXDats5Mx9wV4=
X-Google-Smtp-Source: ABdhPJwZZXBXfIazpD6x9QR4cAvxeKgWG28ErW6sCBnaQStooD78avH+CLXZq+Vj9jdR3AfMhf+5OXesYJzZgOoagzU=
X-Received: by 2002:a05:6638:772:b0:319:e4eb:adb with SMTP id
 y18-20020a056638077200b00319e4eb0adbmr10737980jad.237.1649456524432; Fri, 08
 Apr 2022 15:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220408203433.2988727-1-andrii@kernel.org> <20220408203433.2988727-2-andrii@kernel.org>
 <CAPhsuW5N9qBX0kkQSLK_Sy36cPa==SVSFi+38ZNqNez05zGD6w@mail.gmail.com>
In-Reply-To: <CAPhsuW5N9qBX0kkQSLK_Sy36cPa==SVSFi+38ZNqNez05zGD6w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Apr 2022 15:21:53 -0700
Message-ID: <CAEf4BzaZai7QZnBEcAV72D=0irABs9BjbH++rmRQkqKiKpLYvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] libbpf: allow "incomplete" basic tracing
 SEC() definitions
To:     Song Liu <song@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, Apr 8, 2022 at 1:46 PM Song Liu <song@kernel.org> wrote:
>
> On Fri, Apr 8, 2022 at 1:34 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > In a lot of cases the target of kprobe/kretprobe, tracepoint, raw
> > tracepoint, etc BPF program might not be known at the compilation time
> > and will be discovered at runtime. This was always a supported case by
> > libbpf, with APIs like bpf_program__attach_{kprobe,tracepoint,etc}()
> > accepting full target definition, regardless of what was defined in
> > SEC() definition in BPF source code.
> >
> > Unfortunately, up till now libbpf still enforced users to specify at
> > least something for the fake target, e.g., SEC("kprobe/whatever"), which
> > is cumbersome and somewhat misleading.
> >
> > This patch allows target-less SEC() definitions for basic tracing BPF
> > program types:
> >   - kprobe/kretprobe;
> >   - multi-kprobe/multi-kretprobe;
> >   - tracepoints;
> >   - raw tracepoints.
> >
> > Such target-less SEC() definitions are meant to specify declaratively
> > proper BPF program type only. Attachment of them will have to be handled
> > programmatically using correct APIs. As such, skeleton's auto-attachment
> > of such BPF programs is skipped and generic bpf_program__attach() will
> > fail, if attempted, due to the lack of enough target information.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 69 +++++++++++++++++++++++++++++++-----------
> >  1 file changed, 51 insertions(+), 18 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 9deb1fc67f19..81911a1e1f3e 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -8668,22 +8668,22 @@ static const struct bpf_sec_def section_defs[] = {
> >         SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_NONE | SEC_SLOPPY_PFX),
> >         SEC_DEF("sk_reuseport/migrate", SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> >         SEC_DEF("sk_reuseport",         SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > -       SEC_DEF("kprobe/",              KPROBE, 0, SEC_NONE, attach_kprobe),
> > +       SEC_DEF("kprobe+",              KPROBE, 0, SEC_NONE, attach_kprobe),
> >         SEC_DEF("uprobe+",              KPROBE, 0, SEC_NONE, attach_uprobe),
> > -       SEC_DEF("kretprobe/",           KPROBE, 0, SEC_NONE, attach_kprobe),
> > +       SEC_DEF("kretprobe+",           KPROBE, 0, SEC_NONE, attach_kprobe),
> >         SEC_DEF("uretprobe+",           KPROBE, 0, SEC_NONE, attach_uprobe),
> > -       SEC_DEF("kprobe.multi/",        KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
> > -       SEC_DEF("kretprobe.multi/",     KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
> > +       SEC_DEF("kprobe.multi+",        KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
> > +       SEC_DEF("kretprobe.multi+",     KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
> >         SEC_DEF("usdt+",                KPROBE, 0, SEC_NONE, attach_usdt),
> >         SEC_DEF("tc",                   SCHED_CLS, 0, SEC_NONE),
> >         SEC_DEF("classifier",           SCHED_CLS, 0, SEC_NONE | SEC_SLOPPY_PFX | SEC_DEPRECATED),
> >         SEC_DEF("action",               SCHED_ACT, 0, SEC_NONE | SEC_SLOPPY_PFX),
> > -       SEC_DEF("tracepoint/",          TRACEPOINT, 0, SEC_NONE, attach_tp),
> > -       SEC_DEF("tp/",                  TRACEPOINT, 0, SEC_NONE, attach_tp),
> > -       SEC_DEF("raw_tracepoint/",      RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
> > -       SEC_DEF("raw_tp/",              RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
> > -       SEC_DEF("raw_tracepoint.w/",    RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
> > -       SEC_DEF("raw_tp.w/",            RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
> > +       SEC_DEF("tracepoint+",          TRACEPOINT, 0, SEC_NONE, attach_tp),
> > +       SEC_DEF("tp+",                  TRACEPOINT, 0, SEC_NONE, attach_tp),
> > +       SEC_DEF("raw_tracepoint+",      RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
> > +       SEC_DEF("raw_tp+",              RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
> > +       SEC_DEF("raw_tracepoint.w+",    RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
> > +       SEC_DEF("raw_tp.w+",            RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
> >         SEC_DEF("tp_btf/",              TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_trace),
> >         SEC_DEF("fentry/",              TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF, attach_trace),
> >         SEC_DEF("fmod_ret/",            TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF, attach_trace),
> > @@ -10411,6 +10411,12 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
> >         char *func;
> >         int n;
> >
> > +       *link = NULL;
> > +
> > +       /* no auto-attach for SEC("kprobe") and SEC("kretprobe") */
> > +       if (strcmp(prog->sec_name, "kprobe") == 0 || strcmp(prog->sec_name, "kretprobe") == 0)
> > +               return 0;
> > +
> >         opts.retprobe = str_has_pfx(prog->sec_name, "kretprobe/");
> >         if (opts.retprobe)
> >                 func_name = prog->sec_name + sizeof("kretprobe/") - 1;
> > @@ -10441,6 +10447,13 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
> >         char *pattern;
> >         int n;
> >
> > +       *link = NULL;
> > +
> > +       /* no auto-attach for SEC("kprobe.multi") and SEC("kretprobe.multi") */
> > +       if (strcmp(prog->sec_name, "kprobe.multi") == 0 ||
> > +           strcmp(prog->sec_name, "kretprobe.multi") == 0)
> > +               return 0;
> > +
> >         opts.retprobe = str_has_pfx(prog->sec_name, "kretprobe.multi/");
> >         if (opts.retprobe)
> >                 spec = prog->sec_name + sizeof("kretprobe.multi/") - 1;
> > @@ -11145,6 +11158,12 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
> >         if (!sec_name)
> >                 return -ENOMEM;
> >
> > +       *link = NULL;
> > +
> > +       /* no auto-attach for SEC("tp") or SEC("tracepoint") */
> > +       if (strcmp(prog->sec_name, "tp") == 0 || strcmp(prog->sec_name, "tracepoint") == 0)
> > +               return 0;
> > +
> >         /* extract "tp/<category>/<name>" or "tracepoint/<category>/<name>" */
> >         if (str_has_pfx(prog->sec_name, "tp/"))
> >                 tp_cat = sec_name + sizeof("tp/") - 1;
> > @@ -11196,20 +11215,34 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *pr
> >  static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> >  {
> >         static const char *const prefixes[] = {
> > -               "raw_tp/",
> > -               "raw_tracepoint/",
> > -               "raw_tp.w/",
> > -               "raw_tracepoint.w/",
> > +               "raw_tp",
> > +               "raw_tracepoint",
> > +               "raw_tp.w",
> > +               "raw_tracepoint.w",
> >         };
> >         size_t i;
> >         const char *tp_name = NULL;
> >
> > +       *link = NULL;
> > +
> >         for (i = 0; i < ARRAY_SIZE(prefixes); i++) {
> > -               if (str_has_pfx(prog->sec_name, prefixes[i])) {
> > -                       tp_name = prog->sec_name + strlen(prefixes[i]);
> > -                       break;
> > -               }
> > +               size_t pfx_len;
> > +
> > +               if (!str_has_pfx(prog->sec_name, prefixes[i]))
> > +                       continue;
> > +
> > +               pfx_len = strlen(prefixes[i]);
> > +               /* no auto-attach case of, e.g., SEC("raw_tp") */
> > +               if (prog->sec_name[pfx_len] == '\0')
> > +                       return 0;
> > +
> > +               if (prog->sec_name[pfx_len] != '/')
> > +                       continue;
>
> Maybe introduce a sec_has_pfx() function with tri-state return value:
> 1 for match with tp_name, 0, for match without tp_name, -1 for no match.
>

Hm.. tri-state might be quite confusing, but there might be some clean
ups to be done around this prefix handling for SEC_DEF()s. I'm
planning to do some more work on SEC() handling, I'll do this clean up
as a follow up, if you don't mind. Need to see how to best consolidate
this across all the places where we do this prefix matching.

> > +
> > +               tp_name = prog->sec_name + pfx_len + 1;
> > +               break;
> >         }
> > +
> >         if (!tp_name) {
> >                 pr_warn("prog '%s': invalid section name '%s'\n",
> >                         prog->name, prog->sec_name);
> > --
> > 2.30.2
> >
