Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE54B3BEF
	for <lists+bpf@lfdr.de>; Sun, 13 Feb 2022 16:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbiBMPDC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Feb 2022 10:03:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbiBMPDB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Feb 2022 10:03:01 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB135F24D;
        Sun, 13 Feb 2022 07:02:54 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z13so5276741edc.12;
        Sun, 13 Feb 2022 07:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NqoOI2RpRmVPfeurRgPWgxzMiFY9KtsaSetm4pJJNKE=;
        b=asdDWnDbVqSBXArZ6lgEp0f0ZytTgmWtMZbiQkdOituuX3stjKjumv632wNQEWwq35
         wOnlAXoJ6STW5/UgW6dl7YRGsuRSiKnPAaz9n1kDHgSD8tx3MwkCLvakI3IuKs3l7AVo
         hPVOEwgyIjNxENWNyRXSUS9Xu/VVvSkeZX7S0nmBFx8hPncPK2lo+xbdoX3KIYHP8682
         fcTi9Kiw+BVpmjAMvNV8XtYtCpA0Lhqoz182LSTywOhCJzUKm0BeT/jKFiYLbWAZ/YSB
         VUc3ZegYK6/u3gOA6v+XG6M6vwwsIsWPJyu9296cXJ7l3z9hR/a44gsnsA6ZyMEn02AX
         FtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NqoOI2RpRmVPfeurRgPWgxzMiFY9KtsaSetm4pJJNKE=;
        b=1CYsqxM75K6V7Ffn7qvEarKpd/onumzaC4wN/ccMmq7/uaat2t0Acxlne+/P/fxuN3
         u/ZMgwynKl8+rltPH0wnpfAa75gjLvkRkm6GA4zuAbX0w1Yc3fXaiAcSQEPhaAvzJa1q
         H/gdFQlHT8dQFppFH4Y3/1Dvja1t7tA7EHsrjVFz7rjIeM0wswlGAtakxAWNnZDsHxqt
         xuv6wjcALQSMDsXOBIFJCVZ/YyPWOPCZMgqxj3Ztk9zVaDJtqh5ha0q6N/9/68WJjCn+
         zfpmms6XBpyYct/yVJCOjzbNzgu0UkU3O70Q9sJiJpqyj0tCnCBRd6fJocYMMJZamL4t
         7j0A==
X-Gm-Message-State: AOAM531EsP/7N8BEK2uEoO+dBp/KgKs9M1tRG70Qolcah/Ou7b7v1nec
        ON+ucmPjJZAMvcBnNR6r1I8=
X-Google-Smtp-Source: ABdhPJxoTTnwr7ClyQsdfDl9dF/KRbDW0boRq7rGXYizUBSfPiueoS4OYRBL6rXcHdubmlJKNv6nbg==
X-Received: by 2002:aa7:cdc5:: with SMTP id h5mr11465558edw.398.1644764573153;
        Sun, 13 Feb 2022 07:02:53 -0800 (PST)
Received: from krava ([2a00:102a:4001:3559:c354:84f7:f049:20dc])
        by smtp.gmail.com with ESMTPSA id r6sm9072318ejd.100.2022.02.13.07.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 07:02:52 -0800 (PST)
Date:   Sun, 13 Feb 2022 16:02:49 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: [PATCH 1/3] perf/bpf: Remove prologue generation
Message-ID: <YgkdmQVN1XSuFDWM@krava>
References: <20220123221932.537060-1-jolsa@kernel.org>
 <YgVk8t6COJhDJyzj@kernel.org>
 <YgWEEHFV4U0jhrX8@krava>
 <CAEf4Bza9a5_U2U9ZK_su4VGSA91EMNouipk=PFudGqkN_iGsPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza9a5_U2U9ZK_su4VGSA91EMNouipk=PFudGqkN_iGsPg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 10, 2022 at 09:28:51PM -0800, Andrii Nakryiko wrote:
> On Thu, Feb 10, 2022 at 1:31 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Feb 10, 2022 at 04:18:10PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Sun, Jan 23, 2022 at 11:19:30PM +0100, Jiri Olsa escreveu:
> > > > Removing code for ebpf program prologue generation.
> > > >
> > > > The prologue code was used to get data for extra arguments specified
> > > > in program section name, like:
> > > >
> > > >   SEC("lock_page=__lock_page page->flags")
> > > >   int lock_page(struct pt_regs *ctx, int err, unsigned long flags)
> > > >   {
> > > >          return 1;
> > > >   }
> > > >
> > > > This code is using deprecated libbpf API and blocks its removal.
> > > >
> > > > This feature was not documented and broken for some time without
> > > > anyone complaining, also original authors are not responding,
> > > > so I'm removing it.
> > >
> > > So, the example below breaks, how hard would be to move the deprecated
> > > APIs to perf like was done in some other cases?
> > >
> 
> Just copy/pasting libbpf code won't work. But there are three parts:
> 
> 1. bpf_(program|map|object)__set_priv(). There is no equivalent API,
> but perf can maintain this private data by building hashmap where the
> key is bpf_object/bpf_map/bpf_program pointer itself. Annoying but
> very straightforward to replace.
> 
> 2. For prologue generation, bpf_program__set_prep() doesn't have a
> direct equivalent. But program cloning and adjustment of the code can
> be achieved through bpf_program__insns()/bpf_program__insn_cnt() API
> to load one "prototype" program, gets its underlying insns and clone
> programs as necessary. After that, bpf_prog_load() would be used to
> load those cloned programs into kernel.

hm, I can't see how to clone a program.. so we need to end up with
several copies of the single program defined in the object.. I can
get its intructions with bpf_program__insns, but how do I add more
programs with these instructions customized/prefixed?

thanks,
jirka

> 
> 3. Those *very* custom SEC() definitions will be possible for perf to
> handle once [0] lands (I'll send new revision tomorrow, probably).
> You'll be able to register your own "fallback" handler with
> libbpf_register_prog_handler(NULL, ...).
> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=611491&state=*
> 
> Sorry, it's not a straightforward copy/paste, but I hope this helps a bit.
> 
> > > - Arnaldo
> > >
> > > Before:
> > >
> > > [root@quaco perf]# cat tools/perf/examples/bpf/5sec.c
> > > // SPDX-License-Identifier: GPL-2.0
> > > /*
> > >     Description:
> > >
> > >     . Disable strace like syscall tracing (--no-syscalls), or try tracing
> > >       just some (-e *sleep).
> > >
> > >     . Attach a filter function to a kernel function, returning when it should
> > >       be considered, i.e. appear on the output.
> > >
> > >     . Run it system wide, so that any sleep of >= 5 seconds and < than 6
> > >       seconds gets caught.
> > >
> > >     . Ask for callgraphs using DWARF info, so that userspace can be unwound
> > >
> > >     . While this is running, run something like "sleep 5s".
> > >
> > >     . If we decide to add tv_nsec as well, then it becomes:
> > >
> > >       int probe(hrtimer_nanosleep, rqtp->tv_sec rqtp->tv_nsec)(void *ctx, int err, long sec, long nsec)
> > >
> > >       I.e. add where it comes from (rqtp->tv_nsec) and where it will be
> > >       accessible in the function body (nsec)
> > >
> > >     # perf trace --no-syscalls -e tools/perf/examples/bpf/5sec.c/call-graph=dwarf/
> > >          0.000 perf_bpf_probe:func:(ffffffff9811b5f0) tv_sec=5
> > >                                            hrtimer_nanosleep ([kernel.kallsyms])
> > >                                            __x64_sys_nanosleep ([kernel.kallsyms])
> > >                                            do_syscall_64 ([kernel.kallsyms])
> > >                                            entry_SYSCALL_64 ([kernel.kallsyms])
> > >                                            __GI___nanosleep (/usr/lib64/libc-2.26.so)
> > >                                            rpl_nanosleep (/usr/bin/sleep)
> > >                                            xnanosleep (/usr/bin/sleep)
> > >                                            main (/usr/bin/sleep)
> > >                                            __libc_start_main (/usr/lib64/libc-2.26.so)
> > >                                            _start (/usr/bin/sleep)
> > >     ^C#
> > >
> > >    Copyright (C) 2018 Red Hat, Inc., Arnaldo Carvalho de Melo <acme@redhat.com>
> > > */
> > >
> > > #include <bpf.h>
> > >
> > > #define NSEC_PER_SEC  1000000000L
> > >
> > > int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
> > > {
> > >       return sec / NSEC_PER_SEC == 5ULL;
> > > }
> >
> > that sucks ;-) I'll check if we can re-implement as we discussed earlier,
> > however below is workaround how to do it without the prologue support
> >
> > jirka
> >
> >
> > ---
> > diff --git a/tools/perf/examples/bpf/5sec.c b/tools/perf/examples/bpf/5sec.c
> > index e6b6181c6dc6..734d39debdb8 100644
> > --- a/tools/perf/examples/bpf/5sec.c
> > +++ b/tools/perf/examples/bpf/5sec.c
> > @@ -43,9 +43,17 @@
> >
> >  #define NSEC_PER_SEC   1000000000L
> >
> > -int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
> > +struct pt_regs {
> > +        long di;
> > +};
> > +
> > +SEC("function=hrtimer_nanosleep")
> > +int krava(struct pt_regs *ctx)
> >  {
> > -       return sec / NSEC_PER_SEC == 5ULL;
> > +       unsigned long arg;
> > +
> > +       probe_read_kernel(&arg, sizeof(arg), __builtin_preserve_access_index(&ctx->di));
> > +       return arg / NSEC_PER_SEC == 5ULL;
> >  }
> >
> >  license(GPL);
> > diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
> > index b422aeef5339..b7d6d2fc8342 100644
> > --- a/tools/perf/include/bpf/bpf.h
> > +++ b/tools/perf/include/bpf/bpf.h
> > @@ -64,6 +64,7 @@ int _version SEC("version") = LINUX_VERSION_CODE;
> >
> >  static int (*probe_read)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read;
> >  static int (*probe_read_str)(void *dst, int size, const void *unsafe_addr) = (void *)BPF_FUNC_probe_read_str;
> > +static long (*probe_read_kernel)(void *dst, __u32 size, const void *unsafe_ptr) = (void *) BPF_FUNC_probe_read_kernel;
> >
> >  static int (*perf_event_output)(void *, struct bpf_map *, int, void *, unsigned long) = (void *)BPF_FUNC_perf_event_output;
> >
> > diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
> > index 96c8ef60f4f8..9274a3373847 100644
> > --- a/tools/perf/util/llvm-utils.c
> > +++ b/tools/perf/util/llvm-utils.c
> > @@ -25,7 +25,7 @@
> >                 "$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
> >                 "-Wno-unused-value -Wno-pointer-sign "          \
> >                 "-working-directory $WORKING_DIR "              \
> > -               "-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
> > +               "-g -c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
> >
> >  struct llvm_param llvm_param = {
> >         .clang_path = "clang",
