Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781B95F1074
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 19:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiI3RDS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 13:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiI3RDR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 13:03:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A43E1D8F16
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 10:03:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 8-20020a17090a0b8800b00205d8564b11so4763855pjr.5
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0GZZ8kfQJLO8P5EZFHJDy4oMupuDtrw6dFV+P/FDfRE=;
        b=UfxRXhZMx6JhVguH5TDYRj/9Tqy/I2MDeUy6I7GkukGZeK49zMQEVf+vAjZL5JyNHl
         GEih92MBFR12KtgJ+TMRp90BmEJOC3GXSTLoUcjteq1oXuSbXASmX0JD4b780jiYbTHj
         MOML05zTKl6ObSEPka7YcPKsTysiLR5RR7ZhB6zSHFEFqEMTJ6Hh85+4ghegtib6V9q0
         WbUkpJLe+nGd6s77e+acKFXFzipCxgVJtwPvGsmzlra5+6lLk4SrN2a7V20fh0AsPlZ8
         7psD9/FjlN4/ZBGyL2TSrrXnG6jK1acWNBYDekWHTCDL3pzq4EzFUAJwCs2k5G3YVdMB
         P/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0GZZ8kfQJLO8P5EZFHJDy4oMupuDtrw6dFV+P/FDfRE=;
        b=KniGPOnxCkzN+3rbEsQXzmfbgBHIEWdO1quyiIKIvGQys3B0yv33rCkXLrMdOuG/29
         Y9yQNLkGBs53Y8pCbEHJ+ObJjUVDnEbmIcRJO38guzzIjWzFD0zjwg8WNjXSlAvZqQck
         7PzfbHqZJhIuZkDaVfgYWut/RWwEUBM7JdeZsAuDSMd17m517z43eg+kywuzupdZ45Yw
         +hRydmIKyk8NV1su0ScPh8Ieik7Ic5s6x93OW7VSdNC7QNG4DF6GHgGrtRmoVrNZVyXf
         9SiGxwTVzCcdUpeQz5qHxJiQ3k8yZGckdlecXAfhx29XUuSedUbWQvz3OW4uC9Bj8JA0
         MYxQ==
X-Gm-Message-State: ACrzQf0B6X4cwcjzaVe2hzhZ9q6wNT0/YKuYH/23oB8qzst8rBdaolNz
        mJXCw61YzXZgarb8+6LMnsJbqXLaQNPWxtPAqQLhfaKfP24=
X-Google-Smtp-Source: AMsMyM7ATcfyAgtvtbP87TZBQCUg71GGA1qIfMFC/Co2bevG/M888hCkIk83M2Sd1+9/1YXFy1CctIl4taCNQwuU12E=
X-Received: by 2002:a17:903:41c9:b0:176:b9df:c743 with SMTP id
 u9-20020a17090341c900b00176b9dfc743mr9876190ple.162.1664557395517; Fri, 30
 Sep 2022 10:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <CACG+mBUEHj5zFeGLtP+bvm0wERru3AGntNtWCyiZ-zPg_JS6tg@mail.gmail.com>
 <YzbzweamuZyxLuJ1@krava>
In-Reply-To: <YzbzweamuZyxLuJ1@krava>
From:   Henrique Fingler <henrique.fingler@gmail.com>
Date:   Fri, 30 Sep 2022 12:03:05 -0500
Message-ID: <CACG+mBV7xboG9Y5LctyJuGoft42b4gHxbSBDtzPxpnzy+CaxDg@mail.gmail.com>
Subject: Re: Replicating kfunc_call_test kernel test on standalone bpf program
 (calling kernel function is not allowed)
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org
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

> > Hi all,
> >
> > I'm trying to replicate a bpf test in the kernel that calls a function
> > defined in the kernel itself.
> > Source code is here:
> > https://github.com/torvalds/linux/blob/v5.15/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> >
> > I think I have all dependencies:
> >  Running within a qemu VM (Ubuntu 18.04)
> >  Kernel v 5.15 compiled from scratch with configs from
> > tools/bpf/bpftool/feature.c
> >  pahole v1.22 (1.24 has a reported bug that doesn't allow me to use it)
> >  libbpf v1.0
> >  Installed bpf tool from 5.15 kernel directory at `tools/bpf`
> >  clang and llvm 15
> >
> > The goal is to call `bpf_kfunc_call_test1`, which is defined in
> > net/bpf/test_run.c.
> > I have two BPF programs and neither works. The first one is as is from
> > the kernel:
> >
> > #include "vmlinux.h"
> > #include <bpf/bpf_helpers.h>
> >
> > extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
> >                   __u32 c, __u64 d) __ksym;
> >
> > SEC("classifier")
> > int kfunc_call_test1(struct __sk_buff *skb)
> > {
> >     struct sock *sk = 0;
> >     __u64 a;
> >     a = bpf_kfunc_call_test1(sk, 1, 2, 3, 4);
>
> hi,
> IIUC you are passing 'sk' pointer defined on the stack, while
> bpf_kfunc_call_test1 expects kernel pointer
>
> the kernel selftest test takes it from the skb with:
>
>         struct bpf_sock *sk = skb->sk;

I see. So even if the kernel function (bpf_kfunc_call_test1) does not
use the argument, bpf is checking if it's a kernel pointer? Is the bpf
compiler doing this check?
I assumed that passing a constant 0 pointer would work since the other
parameters are just constants, even in the kernel test.
After changing the first program to the original code, the error
changed, so that's progress. Now it says, even when running with root
permissions:
"libbpf: prog 'kfunc_call_test1': BPF program load failed: Permission denied"
Would be interesting to know why, but not necessary since I won't use
it this way.

> >     bpf_printk("bpf_kfunc_call_test1:  %d.\n", a);
> >     return a;
> > }
> >
> >
> > It is compiled with these commands:
> >
> > bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
> > clang -g -O2 -target bpf -D__TARGET_ARCH_x86 -I. -idirafter
> > /usr/lib/llvm-15/lib/clang/15.0.2/include -idirafter
> > /usr/local/include -idirafter /usr/include/x86_64-linux-gnu -idirafter
> > /usr/include -c hello.bpf.c -o hello.bpf.o
> > llvm-strip -g hello.bpf.o
> > bpftool gen skeleton hello.bpf.o > hello.skel.h
> > cc -g -Wall hello.skel.h hello.c /usr/lib64/libbpf.a   -lelf -lz -o hello
> >
> >
> > The output is quite large, here is a gist:
> > https://gist.github.com/hfingler/dc96af45d87004d0dc412e35be31709c.
> > Mainly:
> >
> > libbpf: extern (func ksym) 'bpf_kfunc_call_test1': resolved to kernel [104983]
> > libbpf: prog 'kfunc_call_test1': BPF program load failed: Invalid argument
> > ...
> > kernel function bpf_kfunc_call_test1 args#0 expected pointer to STRUCT
> > sock but R1 is not a pointer to btf_id
> > processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > peak_states 0 mark_read 0
> > -- END PROG LOAD LOG --
> > libbpf: prog 'kfunc_call_test1': failed to load: -22
> > libbpf: failed to load object 'hello_bpf'
> > libbpf: failed to load BPF skeleton 'hello_bpf': -22
> > Failed to load and verify BPF skeleton
> >
> >
> > The other program is based off of minimal.c from libbpf-bootstrap.
> >
> > #include "vmlinux.h"
> > #include <bpf/bpf_helpers.h>
> >
> > extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
> >                   __u32 c, __u64 d) __ksym;
> >
> > SEC("tp/raw_syscalls/sys_enter")
> > int handle_tp(void *ctx)
> > {
> >     __u64 a;
> >     a = bpf_kfunc_call_test1(0, 1, 2, 3, 4);
>
> you can't call bpf_kfunc_call_test1 from tracepoint, it's registered for:
>
>         ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_prog_test_kfunc_set);
>         ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_prog_test_kfunc_set);
>         ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_prog_test_kfunc_set);
>
> check net/bpf/test_run.c
>
> also you're passing wrong arguments

So there is some filtering happening. I'm on version 5.15 so I don't
see that code, but I do see it on master.
I'll try to figure out what is the matching code in 5.15 (or most
likely just go to 5.19) and perhaps add BPF_PROG_TYPE_TRACEPOINT or
whatever other PROG_TYPE I end up using.

I'm assuming the wrong argument here is the same as above, that the
argument must be a pointer in kernel space.
I'll create a new bpf_kfunc_call_test1 that doesn't have a sock*
argument, just ints and see if it works.

> >     bpf_printk("bpf_kfunc_call_test1:  %d.\n", a);
> >     return 0;
> > }
> >
> >
> > The output is a little different, gist:
> > https://gist.github.com/hfingler/ac69e286f9e527dfd678ef2d768e757c
> > mainly:
> >
> > libbpf: extern (func ksym) 'bpf_kfunc_call_test1': resolved to kernel [104983]
> > ...
> > calling kernel function bpf_kfunc_call_test1 is not allowed
> > libbpf: prog 'handle_tp': failed to load: -13
> > libbpf: failed to load object 'hello_bpf'
> > libbpf: failed to load BPF skeleton 'hello_bpf': -13
> > Failed to load and verify BPF skeleton
> >
> >
> > What could be the problem here? I'm mostly interested in the second
> > program, so that I can use it on my own tracepoints and other places.
> >
> > I'm aware of filtering in net/core/filter.c, but I can't find any
> > reference to `bpf_kfunc` functions. In fact, I added this to filter.c,
> > where both functions just return true (I'm not concerned about
> > security, this is just research):
> >
> > const struct bpf_verifier_ops my_verifier_ops = {
> >     .check_kfunc_call   = export_the_world,
> >     .is_valid_access    = accept_the_world,
> > };
> >
> >
> > I'm assuming something is not allowing this program to call it, maybe
> > it's the section it's put in. The kernel test's SEC is `classifier`,
> > which is
> > defined at tools/lib/bpf/libbpf.c as  `BPF_PROG_SEC("classifier",
> > BPF_PROG_TYPE_SCHED_CLS),`, while `tp/` is BPF_PROG_TYPE_TRACEPOINT.
> > Is there a filter somewhere that allows one but not the other? For
> > example, in kernel/bpf/syscall.c I see:
> >
> > static bool is_net_admin_prog_type(enum bpf_prog_type prog_type)
> > {
> >     switch (prog_type) {
> >     case BPF_PROG_TYPE_SCHED_CLS:
> >         .. others
> >
> > but BPF_PROG_TYPE_TRACEPOINT is not here.
> >
> > There are so many references to these things that I'm totally lost,
> > I'd appreciate some help.
>
> Artem recently added simple kfunc call for kexec:
>   133790596406 bpf: export crash_kexec() as destructive kfunc
>
> might be easier way into kfuncs
>
> jirka

Is creating a `struct bpf_verifier_ops` necessary? That patch you
mentioned does not do it, but perhaps it's somewhere else or it's
completely handled already.
I currently have one that just returns true for both
`check_kfunc_call` and `is_valid_access` but I'm not sure if it is
necessary or how the "macro magic" for these work.
The current kfunc documentation mentions we need to use
`register_btf_kfunc_id_set` explicitly, something that isn't in 5.15.
Is just registering the kfunc_id_set enough that I don't have to worry
about the verifier_ops? I think I will use just kprobes and kfuncs.

Thanks for the help!
