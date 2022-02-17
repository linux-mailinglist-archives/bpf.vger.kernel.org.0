Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188264BAC14
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 22:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245609AbiBQVxo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 16:53:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiBQVxn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 16:53:43 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B43515C67C;
        Thu, 17 Feb 2022 13:53:28 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id y20so5400661iod.1;
        Thu, 17 Feb 2022 13:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tr4a8HS2Qs7b0BilGyhe9qjBcn8N3AAsPrFbgBEmCOM=;
        b=D9muwQWBxXbzOQ6POT++4UgqXD1nMiK0RaG1CryCZRk0bXQLHXam8P8wIy68rKs98Z
         C9py630g2WjB+tZk+DqhYA9M45GR5+4BnuE9rPbl0KFbpd3OjredOh3KLtaaIsbEmk9P
         lt6QwmlZ95w6N6zlYPter1QxwhiMyEWRKsOMaZKONUTCj+pJ7YSZHv5kxvtbIAT/zYpz
         DoQeSNXZzGsuZ5YlKPlkqGTcnQ6ERXsyK/wRwI3xcTP3y/0qnQq0Qo/haDRDTchMgdqz
         4CvaD+SHlckL+x0Y5arCCooMwfJelNot/2T4UMwq+kyTVKJm9wqMamL5q0XOyQg2rdJ4
         p8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tr4a8HS2Qs7b0BilGyhe9qjBcn8N3AAsPrFbgBEmCOM=;
        b=BEvaaycswj3bExfErJphdspgMqECB7nnTFTjy8kztlFVrGyaUD7vQX2gaN5FSzsg71
         nXTxS/rLUscZfYeSpTa+jkSnmVBji7smGdhxYv+vtjXHf24vj2Nk841o6fNQV7Ox5drl
         0yKkqWSs64VKefEJ9swji6L2XpgHbUCotiFxFhkFZeENO9xO0oqlSIepB06nh1Yphujs
         QB7OS1JyUW1mQxFuk3veCK/rRbpGMylyf05yjAEIHHnKQowa6ofvHoXg+EWGa9ME7rTx
         SGvLoO64W7aWhQXBHyETkjGtKlmOwvzH3bV/aeI4qWssBKjhS2h02Z1vqKwkDp8piO76
         hSJQ==
X-Gm-Message-State: AOAM533TjsonYK7Ht0nzpsnYBpV7EM/5zCUtdY6E27s2qPMDBaPBqNny
        2IoPAkhIjED+CEXYcXUwfKKMDaDN4OGanBfXsTA=
X-Google-Smtp-Source: ABdhPJzvesI81LJFxJgJnv6x0U4lt7+EWP9SGnsgEnTsOWGdsO9dmpi3n+zEKGxdNSm1z7EZvRuekSWodMxf2O3HfIA=
X-Received: by 2002:a5d:859a:0:b0:632:7412:eb49 with SMTP id
 f26-20020a5d859a000000b006327412eb49mr3302966ioj.63.1645134807784; Thu, 17
 Feb 2022 13:53:27 -0800 (PST)
MIME-Version: 1.0
References: <20220217131916.50615-1-jolsa@kernel.org> <20220217131916.50615-4-jolsa@kernel.org>
In-Reply-To: <20220217131916.50615-4-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Feb 2022 13:53:16 -0800
Message-ID: <CAEf4BzYP7=JuyuY=xZe71urpxat4ba-JnqeSTcHF=CYmsQbofQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf tools: Rework prologue generation code
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
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

On Thu, Feb 17, 2022 at 5:19 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Some functions we use now for bpf prologue generation are
> going to be deprecated, so reworking the current code not
> to use them.
>
> We need to replace following functions/struct:
>    bpf_program__set_prep
>    bpf_program__nth_fd
>    struct bpf_prog_prep_result
>
> Current code uses bpf_program__set_prep to hook perf callback
> before the program is loaded and provide new instructions with
> the prologue.
>
> We workaround this by using objects's 'unloaded' programs instructions
> for that specific program and load new ebpf programs with prologue
> using separate bpf_prog_load calls.
>
> We keep new ebpf program instances descriptors in bpf programs
> private struct.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/bpf-loader.c | 122 +++++++++++++++++++++++++++++------
>  1 file changed, 104 insertions(+), 18 deletions(-)
>

[...]

>  errout:
> @@ -696,7 +718,7 @@ static int hook_load_preprocessor(struct bpf_program *prog)
>         struct bpf_prog_priv *priv = program_priv(prog);
>         struct perf_probe_event *pev;
>         bool need_prologue = false;
> -       int err, i;
> +       int i;
>
>         if (IS_ERR_OR_NULL(priv)) {
>                 pr_debug("Internal error when hook preprocessor\n");
> @@ -727,6 +749,12 @@ static int hook_load_preprocessor(struct bpf_program *prog)
>                 return 0;
>         }
>
> +       /*
> +        * Do not load programs that need prologue, because we need
> +        * to add prologue first, check bpf_object__load_prologue.
> +        */
> +       bpf_program__set_autoload(prog, false);

if you set autoload to false, program instructions might be invalid in
the end. Libbpf doesn't apply some (all?) relocations to such
programs, doesn't resolve CO-RE, etc, etc. You have to let
"prototypal" BPF program to be loaded before you can grab final
instructions. It's not great, but in your case it should work, right?

> +
>         priv->need_prologue = true;
>         priv->insns_buf = malloc(sizeof(struct bpf_insn) * BPF_MAXINSNS);
>         if (!priv->insns_buf) {
> @@ -734,6 +762,13 @@ static int hook_load_preprocessor(struct bpf_program *prog)
>                 return -ENOMEM;
>         }
>

[...]

> +               /*
> +                * For each program that needs prologue we do following:
> +                *
> +                * - take its current instructions and use them
> +                *   to generate the new code with prologue
> +                *
> +                * - load new instructions with bpf_prog_load
> +                *   and keep the fd in proglogue_fds
> +                *
> +                * - new fd will be used bpf__foreach_event
> +                *   to connect this program with perf evsel
> +                */
> +               orig_insns = bpf_program__insns(prog);
> +               orig_insns_cnt = bpf_program__insn_cnt(prog);
> +
> +               pev = &priv->pev;
> +               for (i = 0; i < pev->ntevs; i++) {
> +                       err = preproc_gen_prologue(prog, i, orig_insns,
> +                                                  orig_insns_cnt, &res);
> +                       if (err)
> +                               return err;
> +
> +                       fd = bpf_prog_load(bpf_program__get_type(prog),

nit: bpf_program__type() is preferred (we are deprecating/discouraging
"get_" prefixed getters in libbpf 1.0)

> +                                          bpf_program__name(prog), "GPL",

would it make sense to give each clone a distinct name?

> +                                          res.new_insn_ptr,
> +                                          res.new_insn_cnt, NULL);
> +                       if (fd < 0) {
> +                               char bf[128];
> +

[...]
