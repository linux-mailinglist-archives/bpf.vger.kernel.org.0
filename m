Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DEF5F0CB9
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 15:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiI3Ns6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 09:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiI3Ns4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 09:48:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA34F83F06
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 06:48:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a26so9168843ejc.4
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 06:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=5xWX0wiH2OP5z+lR/bPxsJNICijIVg9vzUxaCmsIXJQ=;
        b=dS0q/y92xfehlW7+hvFG03c/arqfVClej3GxswwgsfBAGch2L7A9xj6bUE6orlqqDF
         i7Gun0EYYiiFsPUsVQxkmSt1UetuSzAtlawuQJcf+APrNjkzcnH16RsYXaZc3CAWAz/+
         g+iY2XYJecZDM4kS/C5tPKazQrvjjMeFId2YI8xX7VJg/iJMLn5+Dw94kkttw7vtCtGS
         D01pn4PFvHF5B+yYrf5tkZCuTvrhT4M9Uu4fHOj9zmF9V0y4Vd4FjZ87WoA7rSutwQxS
         qjN9405AMK0u4+i98qlJdghmVe7PzW9L1x0n2DFaIFTQv0l30eNMQh6l5MAmj4SUoZXt
         /91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=5xWX0wiH2OP5z+lR/bPxsJNICijIVg9vzUxaCmsIXJQ=;
        b=pOZI7RJl9Uy+EJrKtnm0PTZmRhb9hffuVgYEhIvpqw7wO3e+7esfxd7EIsbwu6iojU
         HM+n5Q6dyNYP/xSZM7rvmoDD7CAhY64qj1iMEKMsdRfBB6JnNUEGo7fx0DPhetxavzBF
         +/r0nNQq3l7xS2USK4pxfjMUVkAvEupVBq2KsLFoOHFm4Zc5jB95l/9gdKXDd6fck4IF
         qlEsa8zpP5WODAiCqXkat7/DbqYcL2QWe/49C3nVUHTxgMgF/r0V6tR2Y/e6symqzC+y
         7l0MmpohT1oEXGhm83RcihgTEze25Ee7j+VaLe02qm6f7O0ZyiuS8keH474ufQQUoDNn
         fr/Q==
X-Gm-Message-State: ACrzQf17ZOfVP/wQonHyw++dtkU90p78iOXZMGmIwHsuQQD1c8g03dq1
        3NWTjkFKxnKPCiYPeLq1AJI=
X-Google-Smtp-Source: AMsMyM433y7UCwf+RYFg9ajmggHXrJm1UxXdRZTnQe4hH6yyGgmKUShs/Zpnxu2xJFi0Wf4LBVD/+Q==
X-Received: by 2002:a17:907:1b22:b0:741:8809:b4e6 with SMTP id mp34-20020a1709071b2200b007418809b4e6mr6573292ejc.84.1664545732016;
        Fri, 30 Sep 2022 06:48:52 -0700 (PDT)
Received: from krava ([83.240.62.159])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0073d7bef38e3sm1214567eja.45.2022.09.30.06.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 06:48:51 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 30 Sep 2022 15:48:49 +0200
To:     Henrique Fingler <henrique.fingler@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Re: Replicating kfunc_call_test kernel test on standalone bpf
 program (calling kernel function is not allowed)
Message-ID: <YzbzweamuZyxLuJ1@krava>
References: <CACG+mBUEHj5zFeGLtP+bvm0wERru3AGntNtWCyiZ-zPg_JS6tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACG+mBUEHj5zFeGLtP+bvm0wERru3AGntNtWCyiZ-zPg_JS6tg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 28, 2022 at 08:33:24PM -0500, Henrique Fingler wrote:
> Hi all,
> 
> I'm trying to replicate a bpf test in the kernel that calls a function
> defined in the kernel itself.
> Source code is here:
> https://github.com/torvalds/linux/blob/v5.15/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> 
> I think I have all dependencies:
>  Running within a qemu VM (Ubuntu 18.04)
>  Kernel v 5.15 compiled from scratch with configs from
> tools/bpf/bpftool/feature.c
>  pahole v1.22 (1.24 has a reported bug that doesn't allow me to use it)
>  libbpf v1.0
>  Installed bpf tool from 5.15 kernel directory at `tools/bpf`
>  clang and llvm 15
> 
> The goal is to call `bpf_kfunc_call_test1`, which is defined in
> net/bpf/test_run.c.
> I have two BPF programs and neither works. The first one is as is from
> the kernel:
> 
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> 
> extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
>                   __u32 c, __u64 d) __ksym;
> 
> SEC("classifier")
> int kfunc_call_test1(struct __sk_buff *skb)
> {
>     struct sock *sk = 0;
>     __u64 a;
>     a = bpf_kfunc_call_test1(sk, 1, 2, 3, 4);

hi,
IIUC you are passing 'sk' pointer defined on the stack, while
bpf_kfunc_call_test1 expects kernel pointer

the kernel selftest test takes it from the skb with:

        struct bpf_sock *sk = skb->sk;

>     bpf_printk("bpf_kfunc_call_test1:  %d.\n", a);
>     return a;
> }
> 
> 
> It is compiled with these commands:
> 
> bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
> clang -g -O2 -target bpf -D__TARGET_ARCH_x86 -I. -idirafter
> /usr/lib/llvm-15/lib/clang/15.0.2/include -idirafter
> /usr/local/include -idirafter /usr/include/x86_64-linux-gnu -idirafter
> /usr/include -c hello.bpf.c -o hello.bpf.o
> llvm-strip -g hello.bpf.o
> bpftool gen skeleton hello.bpf.o > hello.skel.h
> cc -g -Wall hello.skel.h hello.c /usr/lib64/libbpf.a   -lelf -lz -o hello
> 
> 
> The output is quite large, here is a gist:
> https://gist.github.com/hfingler/dc96af45d87004d0dc412e35be31709c.
> Mainly:
> 
> libbpf: extern (func ksym) 'bpf_kfunc_call_test1': resolved to kernel [104983]
> libbpf: prog 'kfunc_call_test1': BPF program load failed: Invalid argument
> ...
> kernel function bpf_kfunc_call_test1 args#0 expected pointer to STRUCT
> sock but R1 is not a pointer to btf_id
> processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'kfunc_call_test1': failed to load: -22
> libbpf: failed to load object 'hello_bpf'
> libbpf: failed to load BPF skeleton 'hello_bpf': -22
> Failed to load and verify BPF skeleton
> 
> 
> The other program is based off of minimal.c from libbpf-bootstrap.
> 
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> 
> extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
>                   __u32 c, __u64 d) __ksym;
> 
> SEC("tp/raw_syscalls/sys_enter")
> int handle_tp(void *ctx)
> {
>     __u64 a;
>     a = bpf_kfunc_call_test1(0, 1, 2, 3, 4);

you can't call bpf_kfunc_call_test1 from tracepoint, it's registered for:

        ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_prog_test_kfunc_set);
        ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_prog_test_kfunc_set);
        ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_prog_test_kfunc_set);

check net/bpf/test_run.c

also you're passing wrong arguments

>     bpf_printk("bpf_kfunc_call_test1:  %d.\n", a);
>     return 0;
> }
> 
> 
> The output is a little different, gist:
> https://gist.github.com/hfingler/ac69e286f9e527dfd678ef2d768e757c
> mainly:
> 
> libbpf: extern (func ksym) 'bpf_kfunc_call_test1': resolved to kernel [104983]
> ...
> calling kernel function bpf_kfunc_call_test1 is not allowed
> libbpf: prog 'handle_tp': failed to load: -13
> libbpf: failed to load object 'hello_bpf'
> libbpf: failed to load BPF skeleton 'hello_bpf': -13
> Failed to load and verify BPF skeleton
> 
> 
> What could be the problem here? I'm mostly interested in the second
> program, so that I can use it on my own tracepoints and other places.
> 
> I'm aware of filtering in net/core/filter.c, but I can't find any
> reference to `bpf_kfunc` functions. In fact, I added this to filter.c,
> where both functions just return true (I'm not concerned about
> security, this is just research):
> 
> const struct bpf_verifier_ops my_verifier_ops = {
>     .check_kfunc_call   = export_the_world,
>     .is_valid_access    = accept_the_world,
> };
> 
> 
> I'm assuming something is not allowing this program to call it, maybe
> it's the section it's put in. The kernel test's SEC is `classifier`,
> which is
> defined at tools/lib/bpf/libbpf.c as  `BPF_PROG_SEC("classifier",
> BPF_PROG_TYPE_SCHED_CLS),`, while `tp/` is BPF_PROG_TYPE_TRACEPOINT.
> Is there a filter somewhere that allows one but not the other? For
> example, in kernel/bpf/syscall.c I see:
> 
> static bool is_net_admin_prog_type(enum bpf_prog_type prog_type)
> {
>     switch (prog_type) {
>     case BPF_PROG_TYPE_SCHED_CLS:
>         .. others
> 
> but BPF_PROG_TYPE_TRACEPOINT is not here.
> 
> There are so many references to these things that I'm totally lost,
> I'd appreciate some help.

Artem recently added simple kfunc call for kexec:
  133790596406 bpf: export crash_kexec() as destructive kfunc

might be easier way into kfuncs

jirka
