Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336595FAD30
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 09:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiJKHGD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 03:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJKHGD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 03:06:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949347A52C
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 00:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B5BC6112E
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC39C433D6
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665471961;
        bh=V4w6LqV4AnyBadVOtnq60+x0tyZ4Y8hLr+1J34ft6Us=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=npDD0FrpWSnMb6GVW6c6CHaY9rwS0edO79H3vtZN756RwQ/fox+/bZDPtEPvyvdeA
         Gce0VlCGeYSwQEkTRGoeZtVSYT/kWrbmid/+9UXuvNO7oLDLs2gMHlRhHx9xtIcZPy
         2WwJ5a6iP0iXWSWOqyHf6exeYe+EAOnVXrOx9Ow4bR11S7V9hwmQJRxf8v5rP3y7E2
         bpFWaVp0BfSYfV0Zg8Svxfw/tbDNw8usNQrayktKazHlBYaxWo6F1ko/IM0q+/Tz6j
         SJ2OGIr0hl2eHiGRQm8odvtWff4X7uabIty9SNAEJlQFsrjs5+La9LeGePOYGGXtc8
         usU64qICkIaJA==
Received: by mail-ej1-f44.google.com with SMTP id nb11so29389518ejc.5
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 00:06:01 -0700 (PDT)
X-Gm-Message-State: ACrzQf3Ua6L31dym0x2Kb9ABfILckjBQr1BT+uOqf6wBsJ+S6EK1rXN9
        Wka5PL06oOegxy4xrU0rs9krdTLvrV9kaFRWFIM=
X-Google-Smtp-Source: AMsMyM6e4O2Fk8bUGp7Nw0Y2nqtf61RljIx9sUS1cwBwDxLlvd3W9yE+fuZUZK+3yJg5kPUwaIHcQlgj5Y0toZUzmlE=
X-Received: by 2002:a17:907:970b:b0:78d:8d70:e4e8 with SMTP id
 jg11-20020a170907970b00b0078d8d70e4e8mr13684906ejc.614.1665471959850; Tue, 11
 Oct 2022 00:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221009215926.970164-1-jolsa@kernel.org> <20221009215926.970164-3-jolsa@kernel.org>
In-Reply-To: <20221009215926.970164-3-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 11 Oct 2022 00:05:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5nBf2gL_ohyfkEbX3aWH2ETEGuamq2D6JaHvaCznw_2w@mail.gmail.com>
Message-ID: <CAPhsuW5nBf2gL_ohyfkEbX3aWH2ETEGuamq2D6JaHvaCznw_2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/8] ftrace: Add support to resolve module
 symbols in ftrace_lookup_symbols
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 9, 2022 at 3:00 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Currently ftrace_lookup_symbols iterates only over core symbols,
> adding module_kallsyms_on_each_symbol call to check on modules
> symbols as well.
>
> Also removing 'args.found == args.cnt' condition, because it's
> already checked in kallsyms_callback function.
>
> Also removing 'err < 0' check, because both *kallsyms_on_each_symbol
> functions do not return error.
>
> Reported-by: Martynas Pumputis <m@lambda.lt>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

> ---
>  kernel/trace/ftrace.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 447d2e2a8549..6efdba4666f4 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -8292,17 +8292,18 @@ static int kallsyms_callback(void *data, const char *name,
>  int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs)
>  {
>         struct kallsyms_data args;
> -       int err;
> +       int found_all;
>
>         memset(addrs, 0, sizeof(*addrs) * cnt);
>         args.addrs = addrs;
>         args.syms = sorted_syms;
>         args.cnt = cnt;
>         args.found = 0;
> -       err = kallsyms_on_each_symbol(kallsyms_callback, &args);
> -       if (err < 0)
> -               return err;
> -       return args.found == args.cnt ? 0 : -ESRCH;
> +       found_all = kallsyms_on_each_symbol(kallsyms_callback, &args);
> +       if (found_all)
> +               return 0;
> +       found_all = module_kallsyms_on_each_symbol(kallsyms_callback, &args);
> +       return found_all ? 0 : -ESRCH;

We probably need some comments about kallsym_callback and
ftrace_lookup_symbols. It took me a while to confirm the logic for
found_all.

>  }
>
>  #ifdef CONFIG_SYSCTL
> --
> 2.37.3
>
