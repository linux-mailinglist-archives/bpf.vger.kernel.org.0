Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0D8673E08
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 16:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjASP5g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 10:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjASP5f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 10:57:35 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2683A9D
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 07:57:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i4so1678270wrs.9
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 07:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMlJ2NJjcLXUx3bywthULxoc68gmDcbMG7dVreoK0ms=;
        b=Fwxf5lPg5ufiIbwNNqoLqaEzgJnXZ/2W6Gb/VGmRrBmo2GLK0Rf0egVFm0m3g6yOuI
         kcIzgo2LSVP+VDKUODHUvkkGtBq0EOVk8xrE30oqcTRTtLY03pklihlGn5twLlkMDbbh
         b3zFHxyVLuSZKmYCRoSm3VTZFHCjoWjcLGMQFyO0dJDcGrcLawV1fG/5nMzDZhNvTi1v
         q36SVefZjsmIy15U6BtckVrCDK86Hnvjx9g5DzIf+/BGoUSFQKJfNlzg/rrmoAhN9vRL
         FyPtnTh2D5TbLpKipQwC1IrltRXYXpJ6W4MBvYimbG6AXHF2dRTN9NBXg7NL+HNHZeMi
         +Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMlJ2NJjcLXUx3bywthULxoc68gmDcbMG7dVreoK0ms=;
        b=bece6T4hjjP13TUhseav0ZZicebbD9PF4EmSZadWHzlmU0CEk0HIqn8lk+MBTa5gJa
         beEVk4glqvvoJhUTcIaIqdUCFne0/Ddh5wFsyDS5c+v7rYIV+YHUslIGx/vJ7NHb3Qsq
         2O2Zn7DVqVByHqiFQdtaG14YcpvkJv3PP9ox+eEXKRpxj6lxzzrpEQSkiJDyQgQMFG4g
         x9JkfZODypcFe6rFoVxwmZgMkBwqvSIiG8qv9Pl3kamBrHkD+Z1uUIKGzqtXLzLzSZCQ
         /TEo0/7lZBFwMbgy4TznhKb9gOfK0Q4gKzh/W1kIx5HV+aQUQf+V661zstHe5tvNdQ6y
         JQeQ==
X-Gm-Message-State: AFqh2kpBhS7GAJRzcSXkOMzhSt01YSPl3ugD0x9d117f0ghkFkVI1GlR
        OXlK+GzKDNVlgNjyuFVasPAOvsHcyB3hqovVFVmDyg==
X-Google-Smtp-Source: AMrXdXsFhfAfshIXAkWu2W7aD4UHcJ+Dw1fXNzCOmComCE7xAZX+qctghVV11UxkyHAYmIPIY1NM5vZa2D6c4KYgZOE=
X-Received: by 2002:a05:6000:124f:b0:2bd:df97:13f4 with SMTP id
 j15-20020a056000124f00b002bddf9713f4mr495083wrx.654.1674143851869; Thu, 19
 Jan 2023 07:57:31 -0800 (PST)
MIME-Version: 1.0
References: <20230105082609.344538-1-irogers@google.com>
In-Reply-To: <20230105082609.344538-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 Jan 2023 07:57:19 -0800
Message-ID: <CAP-5=fUCJEyrZ+bx6oMGmFm5wuF71uheM=7VD9ynjAD_TNZ78w@mail.gmail.com>
Subject: Re: [PATCH v1] perf llvm: Fix inadvertent file creation
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Ian Rogers <irogers@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 5, 2023 at 12:26 AM Ian Rogers <irogers@google.com> wrote:
>
> The LLVM template is first echo-ed into command_out and then
> command_out executed. The echo surrounds the template with double
> quotes, however, the template itself may contain quotes. This is
> generally innocuous but in tools/perf/tests/bpf-script-test-prologue.c
> we see:
> ...
> SEC("func=null_lseek file->f_mode offset orig")
> ...
> where the first double quote ends the double quote of the echo, then
> the > redirects output into a file called f_mode.
>
> To avoid this inadvertent behavior substitute redirects and similar
> characters to be ASCII control codes, then substitute the output in
> the echo back again.
>
> Fixes: 5eab5a7ee032 ("perf llvm: Display eBPF compiling command in debug output")
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. Not really a BPF/LLVM fix, it is just doing some string
manipulation to avoid shell interpretation in the context of making
BPF/LLVM.

Thanks,
Ian

> ---
>  tools/perf/util/llvm-utils.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
> index 650ffe336f3a..4e8e243a6e4b 100644
> --- a/tools/perf/util/llvm-utils.c
> +++ b/tools/perf/util/llvm-utils.c
> @@ -531,14 +531,37 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
>
>         pr_debug("llvm compiling command template: %s\n", template);
>
> +       /*
> +        * Below, substitute control characters for values that can cause the
> +        * echo to misbehave, then substitute the values back.
> +        */
>         err = -ENOMEM;
> -       if (asprintf(&command_echo, "echo -n \"%s\"", template) < 0)
> +       if (asprintf(&command_echo, "echo -n \a%s\a", template) < 0)
>                 goto errout;
>
> +#define SWAP_CHAR(a, b) do { if (*p == a) *p = b; } while (0)
> +       for (char *p = command_echo; *p; p++) {
> +               SWAP_CHAR('<', '\001');
> +               SWAP_CHAR('>', '\002');
> +               SWAP_CHAR('"', '\003');
> +               SWAP_CHAR('\'', '\004');
> +               SWAP_CHAR('|', '\005');
> +               SWAP_CHAR('&', '\006');
> +               SWAP_CHAR('\a', '"');
> +       }
>         err = read_from_pipe(command_echo, (void **) &command_out, NULL);
>         if (err)
>                 goto errout;
>
> +       for (char *p = command_out; *p; p++) {
> +               SWAP_CHAR('\001', '<');
> +               SWAP_CHAR('\002', '>');
> +               SWAP_CHAR('\003', '"');
> +               SWAP_CHAR('\004', '\'');
> +               SWAP_CHAR('\005', '|');
> +               SWAP_CHAR('\006', '&');
> +       }
> +#undef SWAP_CHAR
>         pr_debug("llvm compiling command : %s\n", command_out);
>
>         err = read_from_pipe(template, &obj_buf, &obj_buf_sz);
> --
> 2.39.0.314.g84b9a713c41-goog
>
