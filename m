Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114C34F9E52
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 22:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiDHUsz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 16:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiDHUsy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 16:48:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD02D3C15A3
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 13:46:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EE08B82D7E
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 20:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA21C385A5
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 20:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649450807;
        bh=hE7LBwpR3hq6d/hqmgBFtVaQU+lEePXsATtXTjNxImY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mD7eWP/FIif/6azxG9QAjGivWa+hjQBIukxPpCH2aIXV6p4zJtFi/hzu5ReOo7Cv+
         5iTUAWhlI9qOk1UYOmZ5UaVM9+W4E8kSR3jfw6eT63U5EDImTgf+ajLBKUpLBXIoMP
         fuqf0SaIIP6yi53EeVs8bIEga+eAH2x5zH9Jg6/Iz9tRxzi8mR084wOdUNsJnz2WhF
         VDDBsfwRjUFrIofsxQuhV8L2JqyhsXMPC+RQmjDqOrwwxMi71pYPYFzpdelSKDif4p
         kNEQKbaPN3vp653E4rdctYUHKBjue0uMsjVoTYypHD9CAG8xOEUDUeP/fvmMEecIAR
         03lLQCHrOMGyQ==
Received: by mail-yb1-f169.google.com with SMTP id d138so17073945ybc.13
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 13:46:47 -0700 (PDT)
X-Gm-Message-State: AOAM532Uf6ZXtxZj18yOZF59zLIuC9wmbHiawqtHuTGwEV5nXCeBaHRh
        NE7B7xMXVl74KSJW+GqzJnI1AkZOiXvkpYt5kRg=
X-Google-Smtp-Source: ABdhPJzJc74LyjClinOdvq0zsqrJFJ/bBU/VxpUa+OdjcZ+0QEaKXc84is0ryAZEblB7VXNiBf9ok5uNdeGmXAZ89zc=
X-Received: by 2002:a25:d40e:0:b0:641:1842:ed4b with SMTP id
 m14-20020a25d40e000000b006411842ed4bmr1922487ybf.257.1649450806150; Fri, 08
 Apr 2022 13:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220408203433.2988727-1-andrii@kernel.org> <20220408203433.2988727-2-andrii@kernel.org>
In-Reply-To: <20220408203433.2988727-2-andrii@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Apr 2022 13:46:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5N9qBX0kkQSLK_Sy36cPa==SVSFi+38ZNqNez05zGD6w@mail.gmail.com>
Message-ID: <CAPhsuW5N9qBX0kkQSLK_Sy36cPa==SVSFi+38ZNqNez05zGD6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] libbpf: allow "incomplete" basic tracing
 SEC() definitions
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 8, 2022 at 1:34 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> In a lot of cases the target of kprobe/kretprobe, tracepoint, raw
> tracepoint, etc BPF program might not be known at the compilation time
> and will be discovered at runtime. This was always a supported case by
> libbpf, with APIs like bpf_program__attach_{kprobe,tracepoint,etc}()
> accepting full target definition, regardless of what was defined in
> SEC() definition in BPF source code.
>
> Unfortunately, up till now libbpf still enforced users to specify at
> least something for the fake target, e.g., SEC("kprobe/whatever"), which
> is cumbersome and somewhat misleading.
>
> This patch allows target-less SEC() definitions for basic tracing BPF
> program types:
>   - kprobe/kretprobe;
>   - multi-kprobe/multi-kretprobe;
>   - tracepoints;
>   - raw tracepoints.
>
> Such target-less SEC() definitions are meant to specify declaratively
> proper BPF program type only. Attachment of them will have to be handled
> programmatically using correct APIs. As such, skeleton's auto-attachment
> of such BPF programs is skipped and generic bpf_program__attach() will
> fail, if attempted, due to the lack of enough target information.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 69 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 51 insertions(+), 18 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 9deb1fc67f19..81911a1e1f3e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8668,22 +8668,22 @@ static const struct bpf_sec_def section_defs[] = {
>         SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_NONE | SEC_SLOPPY_PFX),
>         SEC_DEF("sk_reuseport/migrate", SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
>         SEC_DEF("sk_reuseport",         SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> -       SEC_DEF("kprobe/",              KPROBE, 0, SEC_NONE, attach_kprobe),
> +       SEC_DEF("kprobe+",              KPROBE, 0, SEC_NONE, attach_kprobe),
>         SEC_DEF("uprobe+",              KPROBE, 0, SEC_NONE, attach_uprobe),
> -       SEC_DEF("kretprobe/",           KPROBE, 0, SEC_NONE, attach_kprobe),
> +       SEC_DEF("kretprobe+",           KPROBE, 0, SEC_NONE, attach_kprobe),
>         SEC_DEF("uretprobe+",           KPROBE, 0, SEC_NONE, attach_uprobe),
> -       SEC_DEF("kprobe.multi/",        KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
> -       SEC_DEF("kretprobe.multi/",     KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
> +       SEC_DEF("kprobe.multi+",        KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
> +       SEC_DEF("kretprobe.multi+",     KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
>         SEC_DEF("usdt+",                KPROBE, 0, SEC_NONE, attach_usdt),
>         SEC_DEF("tc",                   SCHED_CLS, 0, SEC_NONE),
>         SEC_DEF("classifier",           SCHED_CLS, 0, SEC_NONE | SEC_SLOPPY_PFX | SEC_DEPRECATED),
>         SEC_DEF("action",               SCHED_ACT, 0, SEC_NONE | SEC_SLOPPY_PFX),
> -       SEC_DEF("tracepoint/",          TRACEPOINT, 0, SEC_NONE, attach_tp),
> -       SEC_DEF("tp/",                  TRACEPOINT, 0, SEC_NONE, attach_tp),
> -       SEC_DEF("raw_tracepoint/",      RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
> -       SEC_DEF("raw_tp/",              RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
> -       SEC_DEF("raw_tracepoint.w/",    RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
> -       SEC_DEF("raw_tp.w/",            RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
> +       SEC_DEF("tracepoint+",          TRACEPOINT, 0, SEC_NONE, attach_tp),
> +       SEC_DEF("tp+",                  TRACEPOINT, 0, SEC_NONE, attach_tp),
> +       SEC_DEF("raw_tracepoint+",      RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
> +       SEC_DEF("raw_tp+",              RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
> +       SEC_DEF("raw_tracepoint.w+",    RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
> +       SEC_DEF("raw_tp.w+",            RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
>         SEC_DEF("tp_btf/",              TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_trace),
>         SEC_DEF("fentry/",              TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF, attach_trace),
>         SEC_DEF("fmod_ret/",            TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF, attach_trace),
> @@ -10411,6 +10411,12 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
>         char *func;
>         int n;
>
> +       *link = NULL;
> +
> +       /* no auto-attach for SEC("kprobe") and SEC("kretprobe") */
> +       if (strcmp(prog->sec_name, "kprobe") == 0 || strcmp(prog->sec_name, "kretprobe") == 0)
> +               return 0;
> +
>         opts.retprobe = str_has_pfx(prog->sec_name, "kretprobe/");
>         if (opts.retprobe)
>                 func_name = prog->sec_name + sizeof("kretprobe/") - 1;
> @@ -10441,6 +10447,13 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
>         char *pattern;
>         int n;
>
> +       *link = NULL;
> +
> +       /* no auto-attach for SEC("kprobe.multi") and SEC("kretprobe.multi") */
> +       if (strcmp(prog->sec_name, "kprobe.multi") == 0 ||
> +           strcmp(prog->sec_name, "kretprobe.multi") == 0)
> +               return 0;
> +
>         opts.retprobe = str_has_pfx(prog->sec_name, "kretprobe.multi/");
>         if (opts.retprobe)
>                 spec = prog->sec_name + sizeof("kretprobe.multi/") - 1;
> @@ -11145,6 +11158,12 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
>         if (!sec_name)
>                 return -ENOMEM;
>
> +       *link = NULL;
> +
> +       /* no auto-attach for SEC("tp") or SEC("tracepoint") */
> +       if (strcmp(prog->sec_name, "tp") == 0 || strcmp(prog->sec_name, "tracepoint") == 0)
> +               return 0;
> +
>         /* extract "tp/<category>/<name>" or "tracepoint/<category>/<name>" */
>         if (str_has_pfx(prog->sec_name, "tp/"))
>                 tp_cat = sec_name + sizeof("tp/") - 1;
> @@ -11196,20 +11215,34 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *pr
>  static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link)
>  {
>         static const char *const prefixes[] = {
> -               "raw_tp/",
> -               "raw_tracepoint/",
> -               "raw_tp.w/",
> -               "raw_tracepoint.w/",
> +               "raw_tp",
> +               "raw_tracepoint",
> +               "raw_tp.w",
> +               "raw_tracepoint.w",
>         };
>         size_t i;
>         const char *tp_name = NULL;
>
> +       *link = NULL;
> +
>         for (i = 0; i < ARRAY_SIZE(prefixes); i++) {
> -               if (str_has_pfx(prog->sec_name, prefixes[i])) {
> -                       tp_name = prog->sec_name + strlen(prefixes[i]);
> -                       break;
> -               }
> +               size_t pfx_len;
> +
> +               if (!str_has_pfx(prog->sec_name, prefixes[i]))
> +                       continue;
> +
> +               pfx_len = strlen(prefixes[i]);
> +               /* no auto-attach case of, e.g., SEC("raw_tp") */
> +               if (prog->sec_name[pfx_len] == '\0')
> +                       return 0;
> +
> +               if (prog->sec_name[pfx_len] != '/')
> +                       continue;

Maybe introduce a sec_has_pfx() function with tri-state return value:
1 for match with tp_name, 0, for match without tp_name, -1 for no match.

> +
> +               tp_name = prog->sec_name + pfx_len + 1;
> +               break;
>         }
> +
>         if (!tp_name) {
>                 pr_warn("prog '%s': invalid section name '%s'\n",
>                         prog->name, prog->sec_name);
> --
> 2.30.2
>
