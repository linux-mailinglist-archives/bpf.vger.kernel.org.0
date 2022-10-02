Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C865F23B6
	for <lists+bpf@lfdr.de>; Sun,  2 Oct 2022 16:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJBO6A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Oct 2022 10:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJBO57 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Oct 2022 10:57:59 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF432A974
        for <bpf@vger.kernel.org>; Sun,  2 Oct 2022 07:57:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so4579484wmq.1
        for <bpf@vger.kernel.org>; Sun, 02 Oct 2022 07:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=m0LzpbKdhTzuBRVIM987C3bllyxW5Gnj0OE82qgDNXk=;
        b=AD64zJjjriKRFm4ebEW9IhOoQTopctAUK6paqkn9wWe0A98QHbXU2pXUb5Tgz9awIN
         tjtAbWCm6sHL3thEVf5sdF0KUac5ONqZm537Wc4F7vzUvsg/UXucdINEiZGDc8jnWlqa
         cSqNbwD5DYqdqw29T3KatYzA1llibl6Fwn8CmiyxqODaJYM8zzCRblvNLwa3d4ATwJeV
         t9FxYqAC6Z4hehqIEYpjQ2y0rZieCMsiFxfxR9+MdLnEerqF8UORPH38PAPZi4Ww30lN
         yrbJuhVPGJGg+RmBR2WxsHgHrCUuxqJb2YXuBq+lED15dn00cUGB/eE40kwQ0iYEBVxX
         Hs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=m0LzpbKdhTzuBRVIM987C3bllyxW5Gnj0OE82qgDNXk=;
        b=H/fkdk1OvVJUv35FDshp04rfhk+23khtbAjkdoGcu/G50itmTpJggx/KXlC1PjX1gb
         v9JF+T3yt8vZf0xdljtz21/7U9xtg+SRzeg5DPj64gj0lKzVkYXX6v7lWwleVixK8tCy
         ucyd857LIZw6+HoOr74BnD5yhE8nwA+Ap5Aw/u/emKNhkvqBNVwORuGx2PKgRI0uh2c5
         GCgzdghKDh2MUIRDfzagsepu9mz5LNxGguF0UkWUulvbSUC1ufTEo1ck5yzdWmgEC60v
         +ndp6nk+Sw9mHoFlZ65ZPhXkkqttZu4X+w16h/LNtlWhAK9k9KdgedlQnkKEC+L+P6dp
         ceig==
X-Gm-Message-State: ACrzQf10V8gl/FB/fV6eLDIJOO+s7zDTQXSghfeK7w8wlzGLNfwuA8ws
        K3RzoD4tcqGptxWcQW3cFErn8tPoqdE=
X-Google-Smtp-Source: AMsMyM5RHXI+9/Y6rWUktma13iDbQ46K+re8H4EQ5bZtQ4RCFf/8WUrH81wmRsFGRIFdhR7E9A+LRQ==
X-Received: by 2002:a7b:c01a:0:b0:3b4:a61c:52d1 with SMTP id c26-20020a7bc01a000000b003b4a61c52d1mr4529769wmb.146.1664722676815;
        Sun, 02 Oct 2022 07:57:56 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003b4924493bfsm17436666wmq.9.2022.10.02.07.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 07:57:56 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 2 Oct 2022 16:57:54 +0200
To:     Henrique Fingler <henrique.fingler@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org
Subject: Re: Replicating kfunc_call_test kernel test on standalone bpf
 program (calling kernel function is not allowed)
Message-ID: <Yzmm8pukHcFk5tko@krava>
References: <CACG+mBUEHj5zFeGLtP+bvm0wERru3AGntNtWCyiZ-zPg_JS6tg@mail.gmail.com>
 <YzbzweamuZyxLuJ1@krava>
 <CACG+mBV7xboG9Y5LctyJuGoft42b4gHxbSBDtzPxpnzy+CaxDg@mail.gmail.com>
 <CACG+mBXc2T28-sn4KMRQPRT0k7ejNg1s8qHFOp3HmM5--e4rBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACG+mBXc2T28-sn4KMRQPRT0k7ejNg1s8qHFOp3HmM5--e4rBw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 30, 2022 at 05:03:30PM -0500, Henrique Fingler wrote:
> > > > Hi all,
> > > >
> > > > I'm trying to replicate a bpf test in the kernel that calls a function
> > > > defined in the kernel itself.
> > > > Source code is here:
> > > > https://github.com/torvalds/linux/blob/v5.15/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> > > >
> > > > I think I have all dependencies:
> > > >  Running within a qemu VM (Ubuntu 18.04)
> > > >  Kernel v 5.15 compiled from scratch with configs from
> > > > tools/bpf/bpftool/feature.c
> > > >  pahole v1.22 (1.24 has a reported bug that doesn't allow me to use it)
> > > >  libbpf v1.0
> > > >  Installed bpf tool from 5.15 kernel directory at `tools/bpf`
> > > >  clang and llvm 15
> > > >
> > > > The goal is to call `bpf_kfunc_call_test1`, which is defined in
> > > > net/bpf/test_run.c.
> > > > I have two BPF programs and neither works. The first one is as is from
> > > > the kernel:
> > > >
> > > > #include "vmlinux.h"
> > > > #include <bpf/bpf_helpers.h>
> > > >
> > > > extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
> > > >                   __u32 c, __u64 d) __ksym;
> > > >
> > > > SEC("classifier")
> > > > int kfunc_call_test1(struct __sk_buff *skb)
> > > > {
> > > >     struct sock *sk = 0;
> > > >     __u64 a;
> > > >     a = bpf_kfunc_call_test1(sk, 1, 2, 3, 4);
> > >
> > > hi,
> > > IIUC you are passing 'sk' pointer defined on the stack, while
> > > bpf_kfunc_call_test1 expects kernel pointer
> > >
> > > the kernel selftest test takes it from the skb with:
> > >
> > >         struct bpf_sock *sk = skb->sk;
> >
> > I see. So even if the kernel function (bpf_kfunc_call_test1) does not
> > use the argument, bpf is checking if it's a kernel pointer? Is the bpf
> > compiler doing this check?

it's the verifier check.. that the function is called with proper
argument types/pointers

> > I assumed that passing a constant 0 pointer would work since the other
> > parameters are just constants, even in the kernel test.
> > After changing the first program to the original code, the error
> > changed, so that's progress. Now it says, even when running with root
> > permissions:
> > "libbpf: prog 'kfunc_call_test1': BPF program load failed: Permission denied"
> > Would be interesting to know why, but not necessary since I won't use
> > it this way.

some of the verifier's failure can return -EACCES and has nothing
to do with root permissions

> 
> Following up on this, I have moved to kernel 5.19.12 and I'm trying to
> make any kfunc work.
> I changed net/bpf/test_run.c to allow for more prog types, like master
> branch does, since originally it only had the first line for
> BPF_PROG_TYPE_SCHED_CLS.
> 
> ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
> &bpf_prog_test_kfunc_set);
> ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> &bpf_prog_test_kfunc_set);
> ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE,
> &bpf_prog_test_kfunc_set);
> ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACEPOINT,
> &bpf_prog_test_kfunc_set);
> return ret ?: register_btf_id_dtor_kfuncs(bpf_prog_test_dtor_kfunc,
>                           ARRAY_SIZE(bpf_prog_test_dtor_kfunc),
>                           THIS_MODULE);
> 
> I also added my own function to test it out and added it to the SET
> 
> u64 noinline bpf_kfunc_call_test4(u32 a, u64 b, u32 c, u64 d)
> {
>     return a + b + c + d;
> }
> //this is inside  BTF_SET_START(test_sk_check_kfunc_ids)
> BTF_ID(func, bpf_kfunc_call_test4)
> 
> Now I'm spraying every BPF program I can find to call either function:
> 
> extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
> __u32 c, __u64 d) __ksym;
> extern __u64 bpf_kfunc_call_test4(__u32 a, __u64 b, __u32 c, __u64 d) __ksym;
> 
> Compiling works, and when I run it I get no errors, *except* Permission denied.
> gist here: https://gist.github.com/hfingler/5c2c0b713299daa6b0ba07fa92ff29de
> 
> libbpf: prog 'kfunc_call_test1': BPF program load failed: Permission denied

seems like the kfunc is not found on the set for the program type, I guess
your change above did not go as expected

not sure what is your goal exactly, but perhaps better than starting from
scratch would be to take prog_tests/kfunc_call.c and progs/kfunc_call_test.c
and change them accordingly?

jirka

> ...
> calling kernel function bpf_kfunc_call_test1 is not allowed
> -- END PROG LOAD LOG --
> libbpf: prog 'kfunc_call_test1': failed to load: -13
> libbpf: failed to load object 'hello_bpf'
> libbpf: failed to load BPF skeleton 'hello_bpf': -13
> 
> I've tried a few programs and it would be too much to paste here, so
> here's a gist with all of them, which I tried each separately, not all
> at once:
> https://gist.github.com/hfingler/eb544b23cc36d57b8e9723cd36fbf243
> Basically, I've tried SEC("tc"),
> SEC("tracepoint/syscalls/sys_enter_open"),
> SEC("kprobe/__x64_sys_write")
> 
> What permission is being denied? I've tried running as root and I get
> the same thing, is there bpf permission checking somewhere else in the
> kernel? Do I have to have some sort of capability? Am I missing some
> kernel config?
> These are the configs I'm enabling in the kernel:
> https://gist.github.com/hfingler/ed780bd52b751625f52bbb08eb853641
