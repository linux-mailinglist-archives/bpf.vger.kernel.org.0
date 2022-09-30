Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CB75F15AC
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 00:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiI3WDy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 18:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiI3WDv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 18:03:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA99F1F8997
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:03:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x32-20020a17090a38a300b00209dced49cfso2834585pjb.0
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Rvqi7LuRdPHm8Uh4a/HemxkbcnMCqYBrqEFOWcQQ37k=;
        b=RU5iFgFPSlLZaCuaQH4klSwr50Wu6THGYpOOhk+jeM7nVnpCRfOEJZ32Sk5bdqQLyQ
         1DtbCIAKSZPo8gayV7B3B3rupL25SNuH/uHTb8qBaTvwi9QZEqCGh69JneRDFJGYiGDb
         yBeDrT6XV1MAY0f3/lCWWhUi7J0ZVKDHnYBk43ifi9v3ctpAtlC5SbHHoqmr8har46Oy
         otl1xh54PCHKQlwlP5dgYajl++/C9QRw1x93sdppCP2FQshUZpEp9EDK+aeimUnHqQSx
         5YqdxUsnA/gAvHRddLZW8uuDMriuZuW9EpFYbtaLgndxvYFPz1nEYXMoHgPnF5sJ9JF4
         EO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Rvqi7LuRdPHm8Uh4a/HemxkbcnMCqYBrqEFOWcQQ37k=;
        b=7nyLAv3cRnTMJWZDoaNJ4hAiWpY12EG8OA5z5kez9ePJHrt33hM8b+NgzpICUyU179
         gUrqgBpDgyIqYUl8EgaDtbWhc6/gRcYKApUVwEBpHN8QSUJd8oGTbWoQXIinCNiTCAFF
         PYHbZMF8dcYszliQcgH3wf46obR3oIrOaCwkvuojq4a5MYalFRWqvClpxwAWuhs2/hxH
         TWo+xHF8AHwYXx8S0qyT6Uz9KflWI0tsrLeiQhpZpaDdxsAHFOOMT/jdqqZ7g38Ap0dE
         YFxNZ3yd2eWpktKN2GYYm6ODnLEtmG+z2OMEA38ymm8+pk96JStQoTxm1+pNfAdRBlsX
         Mwww==
X-Gm-Message-State: ACrzQf3RmIsZMiYRpb3Sq9Hj1Ot2q5s0lir1FOhQm8gnv2ZrQC2FnD72
        o4WEhNb9AealHPuSay5hWt3lSZ1o7NgTXyDBTrPVDFvzh4s=
X-Google-Smtp-Source: AMsMyM6cvaqa0ZLWa8O05BLkLz4Y6gZ725weJLaQCkEjrMMR8uVcgLu91hsm7M0OKQ2imWrfquSRHKPZdGWeXh0oBhk=
X-Received: by 2002:a17:90b:4d8c:b0:200:7cd8:333e with SMTP id
 oj12-20020a17090b4d8c00b002007cd8333emr349246pjb.95.1664575421510; Fri, 30
 Sep 2022 15:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <CACG+mBUEHj5zFeGLtP+bvm0wERru3AGntNtWCyiZ-zPg_JS6tg@mail.gmail.com>
 <YzbzweamuZyxLuJ1@krava> <CACG+mBV7xboG9Y5LctyJuGoft42b4gHxbSBDtzPxpnzy+CaxDg@mail.gmail.com>
In-Reply-To: <CACG+mBV7xboG9Y5LctyJuGoft42b4gHxbSBDtzPxpnzy+CaxDg@mail.gmail.com>
From:   Henrique Fingler <henrique.fingler@gmail.com>
Date:   Fri, 30 Sep 2022 17:03:30 -0500
Message-ID: <CACG+mBXc2T28-sn4KMRQPRT0k7ejNg1s8qHFOp3HmM5--e4rBw@mail.gmail.com>
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

> > > Hi all,
> > >
> > > I'm trying to replicate a bpf test in the kernel that calls a function
> > > defined in the kernel itself.
> > > Source code is here:
> > > https://github.com/torvalds/linux/blob/v5.15/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> > >
> > > I think I have all dependencies:
> > >  Running within a qemu VM (Ubuntu 18.04)
> > >  Kernel v 5.15 compiled from scratch with configs from
> > > tools/bpf/bpftool/feature.c
> > >  pahole v1.22 (1.24 has a reported bug that doesn't allow me to use it)
> > >  libbpf v1.0
> > >  Installed bpf tool from 5.15 kernel directory at `tools/bpf`
> > >  clang and llvm 15
> > >
> > > The goal is to call `bpf_kfunc_call_test1`, which is defined in
> > > net/bpf/test_run.c.
> > > I have two BPF programs and neither works. The first one is as is from
> > > the kernel:
> > >
> > > #include "vmlinux.h"
> > > #include <bpf/bpf_helpers.h>
> > >
> > > extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
> > >                   __u32 c, __u64 d) __ksym;
> > >
> > > SEC("classifier")
> > > int kfunc_call_test1(struct __sk_buff *skb)
> > > {
> > >     struct sock *sk = 0;
> > >     __u64 a;
> > >     a = bpf_kfunc_call_test1(sk, 1, 2, 3, 4);
> >
> > hi,
> > IIUC you are passing 'sk' pointer defined on the stack, while
> > bpf_kfunc_call_test1 expects kernel pointer
> >
> > the kernel selftest test takes it from the skb with:
> >
> >         struct bpf_sock *sk = skb->sk;
>
> I see. So even if the kernel function (bpf_kfunc_call_test1) does not
> use the argument, bpf is checking if it's a kernel pointer? Is the bpf
> compiler doing this check?
> I assumed that passing a constant 0 pointer would work since the other
> parameters are just constants, even in the kernel test.
> After changing the first program to the original code, the error
> changed, so that's progress. Now it says, even when running with root
> permissions:
> "libbpf: prog 'kfunc_call_test1': BPF program load failed: Permission denied"
> Would be interesting to know why, but not necessary since I won't use
> it this way.

Following up on this, I have moved to kernel 5.19.12 and I'm trying to
make any kfunc work.
I changed net/bpf/test_run.c to allow for more prog types, like master
branch does, since originally it only had the first line for
BPF_PROG_TYPE_SCHED_CLS.

ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
&bpf_prog_test_kfunc_set);
ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
&bpf_prog_test_kfunc_set);
ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE,
&bpf_prog_test_kfunc_set);
ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACEPOINT,
&bpf_prog_test_kfunc_set);
return ret ?: register_btf_id_dtor_kfuncs(bpf_prog_test_dtor_kfunc,
                          ARRAY_SIZE(bpf_prog_test_dtor_kfunc),
                          THIS_MODULE);

I also added my own function to test it out and added it to the SET

u64 noinline bpf_kfunc_call_test4(u32 a, u64 b, u32 c, u64 d)
{
    return a + b + c + d;
}
//this is inside  BTF_SET_START(test_sk_check_kfunc_ids)
BTF_ID(func, bpf_kfunc_call_test4)

Now I'm spraying every BPF program I can find to call either function:

extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
__u32 c, __u64 d) __ksym;
extern __u64 bpf_kfunc_call_test4(__u32 a, __u64 b, __u32 c, __u64 d) __ksym;

Compiling works, and when I run it I get no errors, *except* Permission denied.
gist here: https://gist.github.com/hfingler/5c2c0b713299daa6b0ba07fa92ff29de

libbpf: prog 'kfunc_call_test1': BPF program load failed: Permission denied
...
calling kernel function bpf_kfunc_call_test1 is not allowed
-- END PROG LOAD LOG --
libbpf: prog 'kfunc_call_test1': failed to load: -13
libbpf: failed to load object 'hello_bpf'
libbpf: failed to load BPF skeleton 'hello_bpf': -13

I've tried a few programs and it would be too much to paste here, so
here's a gist with all of them, which I tried each separately, not all
at once:
https://gist.github.com/hfingler/eb544b23cc36d57b8e9723cd36fbf243
Basically, I've tried SEC("tc"),
SEC("tracepoint/syscalls/sys_enter_open"),
SEC("kprobe/__x64_sys_write")

What permission is being denied? I've tried running as root and I get
the same thing, is there bpf permission checking somewhere else in the
kernel? Do I have to have some sort of capability? Am I missing some
kernel config?
These are the configs I'm enabling in the kernel:
https://gist.github.com/hfingler/ed780bd52b751625f52bbb08eb853641
