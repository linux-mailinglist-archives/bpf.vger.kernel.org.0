Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2ABC4B4189
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 07:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiBNGC6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 01:02:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiBNGC5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 01:02:57 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9222D50463;
        Sun, 13 Feb 2022 22:02:50 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id w7so18688891ioj.5;
        Sun, 13 Feb 2022 22:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=papruFJfe9IvaMWn+6Mq6BLzhVMmTFRdEs0zpXgov0Q=;
        b=QLQHLEK37s6RgOEHcA+CGoOmomqnwmMcETyCuToH+ulaaIMOWaCJvWkpIrXdUjc8uu
         HJ6P4uu7juyJ8Ni+nP9UCSHxJXJKIdjHdSFtSiQC92SLTEL7syxPqHs/vhAhjEuPC9ln
         ulXZcYAbQndWYeVqCS/x4k0pziUwEXwfenyWFzq0iQW7WrZLuktSabBzjykB84GxK8nq
         GMnjMJpgRysBNeKF0QcjezOA8M347HFguaO+JPY5npWC+bz/QfkziIRlCC2NCYgCr++F
         gh1bkMAMf16u3/pxkDgjNexnfv9zQ2PVn0/f0B6ZoZqWQBR2cjQXVRmmq23VhoCDCVkR
         YtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=papruFJfe9IvaMWn+6Mq6BLzhVMmTFRdEs0zpXgov0Q=;
        b=DtBQ9x+TjiugxOLYmfTUjnjfUjZhcQ/GXBO2irw3bbMRiqCcywEj1CU0em7e9Ec587
         csTFu+7HlEhvjOlNWhL/1ou7Y7JS4egpTK55rwFhBzMqJeMwd4G1RybVqykERLFyt9EL
         3dEGhhm7ydCWbuCaEcMlxI9iHUf210peV+uF7E5IWPA7rY6fr8xPIM0ZCpBKiMFqfl08
         5plh0Ys5hACSZ1WqCFZb7o4hNHOM96tWQJcxAdsNmcOp/+4ignWD4mHnqlu9g6wLZ0d6
         kRPSDp4HDIGEIOrI5AqRj2S08dVNqJaUHob8jzQcySpU6FDSb3IR4c6fEqBMhTifjrHc
         3tNw==
X-Gm-Message-State: AOAM530jzBlpxIoXGx9uYRbSOgjAGedPtG7VetZ0XEqg7dL7sgjr3VY+
        4SR2OrZBnvhx3liZQtGup+QmKtYLSQDjgNS+80IFqH6i
X-Google-Smtp-Source: ABdhPJxMSAs1t5ystT5yQ4zs+gG+HX/YbQal4u31dhX9oTnbjo/8Fw41QoiXgwcJElHO/hd7zCmTyHE+kROzP7tsl/g=
X-Received: by 2002:a05:6638:d88:: with SMTP id l8mr7605398jaj.234.1644818569903;
 Sun, 13 Feb 2022 22:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20220123221932.537060-1-jolsa@kernel.org> <YgVk8t6COJhDJyzj@kernel.org>
 <YgWEEHFV4U0jhrX8@krava>
In-Reply-To: <YgWEEHFV4U0jhrX8@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 13 Feb 2022 22:02:38 -0800
Message-ID: <CAEf4BzYbtUZ_1nu0vjKYBGDWM_-EJB_C7xA_WheBjS6hPzNn0Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf/bpf: Remove prologue generation
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
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

On Thu, Feb 10, 2022 at 1:31 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Feb 10, 2022 at 04:18:10PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sun, Jan 23, 2022 at 11:19:30PM +0100, Jiri Olsa escreveu:
> > > Removing code for ebpf program prologue generation.
> > >
> > > The prologue code was used to get data for extra arguments specified
> > > in program section name, like:
> > >
> > >   SEC("lock_page=__lock_page page->flags")
> > >   int lock_page(struct pt_regs *ctx, int err, unsigned long flags)
> > >   {
> > >          return 1;
> > >   }
> > >
> > > This code is using deprecated libbpf API and blocks its removal.
> > >
> > > This feature was not documented and broken for some time without
> > > anyone complaining, also original authors are not responding,
> > > so I'm removing it.
> >
> > So, the example below breaks, how hard would be to move the deprecated
> > APIs to perf like was done in some other cases?
> >
> > - Arnaldo
> >
> > Before:
> >
> > [root@quaco perf]# cat tools/perf/examples/bpf/5sec.c
> > // SPDX-License-Identifier: GPL-2.0
> > /*
> >     Description:
> >
> >     . Disable strace like syscall tracing (--no-syscalls), or try tracing
> >       just some (-e *sleep).
> >
> >     . Attach a filter function to a kernel function, returning when it should
> >       be considered, i.e. appear on the output.
> >
> >     . Run it system wide, so that any sleep of >= 5 seconds and < than 6
> >       seconds gets caught.
> >
> >     . Ask for callgraphs using DWARF info, so that userspace can be unwound
> >
> >     . While this is running, run something like "sleep 5s".
> >
> >     . If we decide to add tv_nsec as well, then it becomes:
> >
> >       int probe(hrtimer_nanosleep, rqtp->tv_sec rqtp->tv_nsec)(void *ctx, int err, long sec, long nsec)
> >
> >       I.e. add where it comes from (rqtp->tv_nsec) and where it will be
> >       accessible in the function body (nsec)
> >
> >     # perf trace --no-syscalls -e tools/perf/examples/bpf/5sec.c/call-graph=dwarf/
> >          0.000 perf_bpf_probe:func:(ffffffff9811b5f0) tv_sec=5
> >                                            hrtimer_nanosleep ([kernel.kallsyms])
> >                                            __x64_sys_nanosleep ([kernel.kallsyms])
> >                                            do_syscall_64 ([kernel.kallsyms])
> >                                            entry_SYSCALL_64 ([kernel.kallsyms])
> >                                            __GI___nanosleep (/usr/lib64/libc-2.26.so)
> >                                            rpl_nanosleep (/usr/bin/sleep)
> >                                            xnanosleep (/usr/bin/sleep)
> >                                            main (/usr/bin/sleep)
> >                                            __libc_start_main (/usr/lib64/libc-2.26.so)
> >                                            _start (/usr/bin/sleep)
> >     ^C#
> >
> >    Copyright (C) 2018 Red Hat, Inc., Arnaldo Carvalho de Melo <acme@redhat.com>
> > */
> >
> > #include <bpf.h>
> >
> > #define NSEC_PER_SEC  1000000000L
> >
> > int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
> > {
> >       return sec / NSEC_PER_SEC == 5ULL;
> > }
>
> that sucks ;-) I'll check if we can re-implement as we discussed earlier,
> however below is workaround how to do it without the prologue support
>

I'm a bit confused. I thought that we discussed dropping custom SEC()
definitions from perf as no one knew if anyone is even using this
feature and when Jiri tried it didn't even work ([0]). Is this broken
sample some other important use case that we are sure is used by
people and thus must be preserved?

Or dropping this custom SEC() business and prologue generation still
on the table?

> jirka
>
>
> ---
> diff --git a/tools/perf/examples/bpf/5sec.c b/tools/perf/examples/bpf/5sec.c
> index e6b6181c6dc6..734d39debdb8 100644
> --- a/tools/perf/examples/bpf/5sec.c
> +++ b/tools/perf/examples/bpf/5sec.c
> @@ -43,9 +43,17 @@
>
>  #define NSEC_PER_SEC   1000000000L
>
> -int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
> +struct pt_regs {
> +        long di;
> +};
> +
> +SEC("function=hrtimer_nanosleep")
> +int krava(struct pt_regs *ctx)
>  {
> -       return sec / NSEC_PER_SEC == 5ULL;
> +       unsigned long arg;
> +
> +       probe_read_kernel(&arg, sizeof(arg), __builtin_preserve_access_index(&ctx->di));
> +       return arg / NSEC_PER_SEC == 5ULL;
>  }
>
>  license(GPL);
> diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
> index b422aeef5339..b7d6d2fc8342 100644
> --- a/tools/perf/include/bpf/bpf.h
> +++ b/tools/perf/include/bpf/bpf.h
> @@ -64,6 +64,7 @@ int _version SEC("version") = LINUX_VERSION_CODE;
>
>  static int (*probe_read)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read;
>  static int (*probe_read_str)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read_str;
> +static long (*probe_read_kernel)(void *dst, __u32 size, const void *unsafe_ptr) = (void *) BPF_FUNC_probe_read_kernel;
>
>  static int (*perf_event_output)(void *, struct bpf_map *, int, void *, unsigned long) = (void *)BPF_FUNC_perf_event_output;
>
> diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
> index 96c8ef60f4f8..9274a3373847 100644
> --- a/tools/perf/util/llvm-utils.c
> +++ b/tools/perf/util/llvm-utils.c
> @@ -25,7 +25,7 @@
>                 "$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
>                 "-Wno-unused-value -Wno-pointer-sign "          \
>                 "-working-directory $WORKING_DIR "              \
> -               "-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
> +               "-g -c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
>
>  struct llvm_param llvm_param = {
>         .clang_path = "clang",
