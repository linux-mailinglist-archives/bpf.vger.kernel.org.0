Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4E14B4187
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 06:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiBNF5f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 00:57:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiBNF5e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 00:57:34 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0799A4F9D4;
        Sun, 13 Feb 2022 21:57:27 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id q204so18642221iod.8;
        Sun, 13 Feb 2022 21:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oaPj1HnvTz04RlZLsRu3ecq83bB8Cs748PluDWP6SGE=;
        b=E5dhq18PQ8SgvgndD0zTKTBpxar2PMw6syx5oBPY1B8S6VRsEX/L3rMiAoqYxYX3s/
         KI+jrSVA/R07+xIIst0hg8Atln35/LqQxQst5G56MSGkOaLxG10/JENtBS3O+dciK8RY
         FszhhrTek6JoDKszIElB3Kt0EvXaiq+axgqLc2tTEexRM4Gorz7ouXSXIj7GprIl8fTf
         KPJzAM1IwiwJAFSF+OENOIKMHdTxGnmRMM0K0M/3yq3LFJNTPdP/pKmRN11Bfnv8B5X7
         Rj/2IhVa5Lf8W4YZtP0KyPpmqEgPNqT9lK1poeDUgTb9boBmNC4GhSEaX5rMm1feogAZ
         xtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oaPj1HnvTz04RlZLsRu3ecq83bB8Cs748PluDWP6SGE=;
        b=yp9LyzmXRNtJK68n0gSWsIP8mTEE28aYXmtkWC0b4tn+ORDkEuSwH/W/6FwxeXWFmt
         NYKqMv+b8Rp9ODa6f48gisPoGN/7EaacZmNNLV2OaQYQiAiYT9PaielTGVVoZiPc1rxJ
         HbTmU/r98vxDSGPV+tbNdFzsoGIMnajhMizK2k2G6jfaxWY+ucu6Dm4An1t/mcJHpEo0
         HMinetOYSiKQx5gGVrZ1N+ndfzRt9Vuo7FEr5Qw+VdDDfyF6MV5gS8/i8UUBTd/3elgH
         CwAFQQXkg59TDTX6FyOa0ZtWqlIfMxGsyai4rSu1RL9DLyg1n8hsnCNhYhNuSzTw0Xm6
         iaUQ==
X-Gm-Message-State: AOAM532I7pYpHELhTwJVU+DZ8sJt0BfYQW6Qu6DzlsO299yEHhWQQgcD
        x5IlqYXSlxDig+FoyocwDH5aIP09m+T+02wGzJQ=
X-Google-Smtp-Source: ABdhPJziElEWD8tvwwL/nNi07mvhOgLmEi4z4/Xqs8eYwjcNhrsQnarPvfFKIvOLlmozoDnymQHSlKy/uf/VzVZhZCM=
X-Received: by 2002:a5d:88c1:: with SMTP id i1mr6457473iol.154.1644818246062;
 Sun, 13 Feb 2022 21:57:26 -0800 (PST)
MIME-Version: 1.0
References: <20220123221932.537060-1-jolsa@kernel.org> <YgVk8t6COJhDJyzj@kernel.org>
 <YgWEEHFV4U0jhrX8@krava> <CAEf4Bza9a5_U2U9ZK_su4VGSA91EMNouipk=PFudGqkN_iGsPg@mail.gmail.com>
 <YgkdmQVN1XSuFDWM@krava>
In-Reply-To: <YgkdmQVN1XSuFDWM@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 13 Feb 2022 21:57:15 -0800
Message-ID: <CAEf4BzZO7ZZZv5bdUYY2Fzp0m05gWE9o62Y8=uAuJmUmWsD_hw@mail.gmail.com>
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

On Sun, Feb 13, 2022 at 7:02 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Feb 10, 2022 at 09:28:51PM -0800, Andrii Nakryiko wrote:
> > On Thu, Feb 10, 2022 at 1:31 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Thu, Feb 10, 2022 at 04:18:10PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Sun, Jan 23, 2022 at 11:19:30PM +0100, Jiri Olsa escreveu:
> > > > > Removing code for ebpf program prologue generation.
> > > > >
> > > > > The prologue code was used to get data for extra arguments specified
> > > > > in program section name, like:
> > > > >
> > > > >   SEC("lock_page=__lock_page page->flags")
> > > > >   int lock_page(struct pt_regs *ctx, int err, unsigned long flags)
> > > > >   {
> > > > >          return 1;
> > > > >   }
> > > > >
> > > > > This code is using deprecated libbpf API and blocks its removal.
> > > > >
> > > > > This feature was not documented and broken for some time without
> > > > > anyone complaining, also original authors are not responding,
> > > > > so I'm removing it.
> > > >
> > > > So, the example below breaks, how hard would be to move the deprecated
> > > > APIs to perf like was done in some other cases?
> > > >
> >
> > Just copy/pasting libbpf code won't work. But there are three parts:
> >
> > 1. bpf_(program|map|object)__set_priv(). There is no equivalent API,
> > but perf can maintain this private data by building hashmap where the
> > key is bpf_object/bpf_map/bpf_program pointer itself. Annoying but
> > very straightforward to replace.
> >
> > 2. For prologue generation, bpf_program__set_prep() doesn't have a
> > direct equivalent. But program cloning and adjustment of the code can
> > be achieved through bpf_program__insns()/bpf_program__insn_cnt() API
> > to load one "prototype" program, gets its underlying insns and clone
> > programs as necessary. After that, bpf_prog_load() would be used to
> > load those cloned programs into kernel.
>
> hm, I can't see how to clone a program.. so we need to end up with
> several copies of the single program defined in the object.. I can
> get its intructions with bpf_program__insns, but how do I add more
> programs with these instructions customized/prefixed?

You can't add those clones back to bpf_object, of course. But after
grabbing (and modifying) instructions, you can use bpf_prog_load()
low-level API to create BPF programs and get their FDs back. You'll
have to keep track of those prog FDs separately from libbpf' struct
bpf_object.

>
> thanks,
> jirka
>
> >
> > 3. Those *very* custom SEC() definitions will be possible for perf to
> > handle once [0] lands (I'll send new revision tomorrow, probably).
> > You'll be able to register your own "fallback" handler with
> > libbpf_register_prog_handler(NULL, ...).
> >
> >   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=611491&state=*
> >
> > Sorry, it's not a straightforward copy/paste, but I hope this helps a bit.
> >
> > > > - Arnaldo
> > > >
> > > > Before:
> > > >
> > > > [root@quaco perf]# cat tools/perf/examples/bpf/5sec.c
> > > > // SPDX-License-Identifier: GPL-2.0
> > > > /*
> > > >     Description:
> > > >
> > > >     . Disable strace like syscall tracing (--no-syscalls), or try tracing
> > > >       just some (-e *sleep).
> > > >
> > > >     . Attach a filter function to a kernel function, returning when it should
> > > >       be considered, i.e. appear on the output.
> > > >
> > > >     . Run it system wide, so that any sleep of >= 5 seconds and < than 6
> > > >       seconds gets caught.
> > > >
> > > >     . Ask for callgraphs using DWARF info, so that userspace can be unwound
> > > >
> > > >     . While this is running, run something like "sleep 5s".
> > > >
> > > >     . If we decide to add tv_nsec as well, then it becomes:
> > > >
> > > >       int probe(hrtimer_nanosleep, rqtp->tv_sec rqtp->tv_nsec)(void *ctx, int err, long sec, long nsec)
> > > >
> > > >       I.e. add where it comes from (rqtp->tv_nsec) and where it will be
> > > >       accessible in the function body (nsec)
> > > >
> > > >     # perf trace --no-syscalls -e tools/perf/examples/bpf/5sec.c/call-graph=dwarf/
> > > >          0.000 perf_bpf_probe:func:(ffffffff9811b5f0) tv_sec=5
> > > >                                            hrtimer_nanosleep ([kernel.kallsyms])
> > > >                                            __x64_sys_nanosleep ([kernel.kallsyms])
> > > >                                            do_syscall_64 ([kernel.kallsyms])
> > > >                                            entry_SYSCALL_64 ([kernel.kallsyms])
> > > >                                            __GI___nanosleep (/usr/lib64/libc-2.26.so)
> > > >                                            rpl_nanosleep (/usr/bin/sleep)
> > > >                                            xnanosleep (/usr/bin/sleep)
> > > >                                            main (/usr/bin/sleep)
> > > >                                            __libc_start_main (/usr/lib64/libc-2.26.so)
> > > >                                            _start (/usr/bin/sleep)
> > > >     ^C#
> > > >
> > > >    Copyright (C) 2018 Red Hat, Inc., Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > */
> > > >
> > > > #include <bpf.h>
> > > >
> > > > #define NSEC_PER_SEC  1000000000L
> > > >
> > > > int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
> > > > {
> > > >       return sec / NSEC_PER_SEC == 5ULL;
> > > > }
> > >
> > > that sucks ;-) I'll check if we can re-implement as we discussed earlier,
> > > however below is workaround how to do it without the prologue support
> > >
> > > jirka
> > >
> > >
> > > ---
> > > diff --git a/tools/perf/examples/bpf/5sec.c b/tools/perf/examples/bpf/5sec.c
> > > index e6b6181c6dc6..734d39debdb8 100644
> > > --- a/tools/perf/examples/bpf/5sec.c
> > > +++ b/tools/perf/examples/bpf/5sec.c
> > > @@ -43,9 +43,17 @@
> > >
> > >  #define NSEC_PER_SEC   1000000000L
> > >
> > > -int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
> > > +struct pt_regs {
> > > +        long di;
> > > +};
> > > +
> > > +SEC("function=hrtimer_nanosleep")
> > > +int krava(struct pt_regs *ctx)
> > >  {
> > > -       return sec / NSEC_PER_SEC == 5ULL;
> > > +       unsigned long arg;
> > > +
> > > +       probe_read_kernel(&arg, sizeof(arg), __builtin_preserve_access_index(&ctx->di));
> > > +       return arg / NSEC_PER_SEC == 5ULL;
> > >  }
> > >
> > >  license(GPL);
> > > diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
> > > index b422aeef5339..b7d6d2fc8342 100644
> > > --- a/tools/perf/include/bpf/bpf.h
> > > +++ b/tools/perf/include/bpf/bpf.h
> > > @@ -64,6 +64,7 @@ int _version SEC("version") = LINUX_VERSION_CODE;
> > >
> > >  static int (*probe_read)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read;
> > >  static int (*probe_read_str)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read_str;
> > > +static long (*probe_read_kernel)(void *dst, __u32 size, const void *unsafe_ptr) = (void *) BPF_FUNC_probe_read_kernel;
> > >
> > >  static int (*perf_event_output)(void *, struct bpf_map *, int, void *, unsigned long) = (void *)BPF_FUNC_perf_event_output;
> > >
> > > diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
> > > index 96c8ef60f4f8..9274a3373847 100644
> > > --- a/tools/perf/util/llvm-utils.c
> > > +++ b/tools/perf/util/llvm-utils.c
> > > @@ -25,7 +25,7 @@
> > >                 "$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
> > >                 "-Wno-unused-value -Wno-pointer-sign "          \
> > >                 "-working-directory $WORKING_DIR "              \
> > > -               "-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
> > > +               "-g -c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
> > >
> > >  struct llvm_param llvm_param = {
> > >         .clang_path = "clang",
