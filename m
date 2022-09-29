Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B554E5EEAF6
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 03:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiI2Bdk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 21:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiI2Bdg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 21:33:36 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832F9118DEC
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 18:33:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a80so134851pfa.4
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 18:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=RNSCSdpbesTqWDIKcMZZHXFSWWdfRvHLxmZ5WhWGkD4=;
        b=IjqZnJmtmWIi2vS9pke/MZwlL0c/FnpxfOCqBO02+j4RGgW849VM/U3gp8ef5gIu8t
         ou/zt8X2dCdOb9yLoMbS/c45IlEyRJImUalEDDMtgwKLlxeOSav5qg5whmUkYDp4kjz+
         sveY3dugt+8au5sPkZioKF8WWET0hzaAykx6HMmH9ZM+FvDy2NqwOK4QXP/+YusCXsL6
         q7pEL9JYsXtoJHkJuLla3hCjOVEqiQ0I1S6rKlW8tBD8xuoP+d0XqD9jMHzTF9xRhaU0
         Bjj8Wvi8av085iGAfogsdFClZhu9aH/6dU0z0/m493BxvmjYwS8uSK08xWUNb9qGfF2H
         koIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=RNSCSdpbesTqWDIKcMZZHXFSWWdfRvHLxmZ5WhWGkD4=;
        b=w1tlEwgn/9SFIXOWYxjfMI9ymgLLUWfJHgsWDQy+89l8aUHgi5/9D58h181SzZYyVA
         r/ZXHM2udp7Qyb69obC/gf7kgBS/AMyhe4OaFjKKhXcG4pzFKfH+fUmJTZGEUaZE7Q7E
         7QmoHgwmYW4T9IodYJF5Tk8nLm5D6wanXTqgYe+CzeURTJZ8EGcUTZrgIcy4zErqmDP+
         T9PIdDNWsrOnpZIC0G3E5m+TmMwfZajxgsa9sxmhzkuQnTbaXKzl3PNUkILzh8A6ynj5
         PABOnXKibqfg0stlRlj5Cp7Iv24Yv6QtNVjmmy3sgmEP/pAJBc4c4VGCqx8iYDvj6Z6e
         eBOQ==
X-Gm-Message-State: ACrzQf18TbErMFMaSzdviWI4YxqsKbayG/J96uoPcsymohSrqDsC7qFa
        LbPMjCw+I4JLUjRuzi1r3ApkFDkC+TCNVI5mQSrgpvGvvEZcxQ==
X-Google-Smtp-Source: AMsMyM4fENQPrwSrV3GpFMlWAJ9IsshgrZwCus5ObEkVeJpNYCpdlW95QT/Zf0k1Y1cttI7Bhl1EIiioVHlL/6W/Yp0=
X-Received: by 2002:a63:f806:0:b0:439:d86e:1f6e with SMTP id
 n6-20020a63f806000000b00439d86e1f6emr672656pgh.46.1664415214532; Wed, 28 Sep
 2022 18:33:34 -0700 (PDT)
MIME-Version: 1.0
From:   Henrique Fingler <henrique.fingler@gmail.com>
Date:   Wed, 28 Sep 2022 20:33:24 -0500
Message-ID: <CACG+mBUEHj5zFeGLtP+bvm0wERru3AGntNtWCyiZ-zPg_JS6tg@mail.gmail.com>
Subject: Replicating kfunc_call_test kernel test on standalone bpf program
 (calling kernel function is not allowed)
To:     bpf@vger.kernel.org
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

Hi all,

I'm trying to replicate a bpf test in the kernel that calls a function
defined in the kernel itself.
Source code is here:
https://github.com/torvalds/linux/blob/v5.15/tools/testing/selftests/bpf/progs/kfunc_call_test.c

I think I have all dependencies:
 Running within a qemu VM (Ubuntu 18.04)
 Kernel v 5.15 compiled from scratch with configs from
tools/bpf/bpftool/feature.c
 pahole v1.22 (1.24 has a reported bug that doesn't allow me to use it)
 libbpf v1.0
 Installed bpf tool from 5.15 kernel directory at `tools/bpf`
 clang and llvm 15

The goal is to call `bpf_kfunc_call_test1`, which is defined in
net/bpf/test_run.c.
I have two BPF programs and neither works. The first one is as is from
the kernel:

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>

extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
                  __u32 c, __u64 d) __ksym;

SEC("classifier")
int kfunc_call_test1(struct __sk_buff *skb)
{
    struct sock *sk = 0;
    __u64 a;
    a = bpf_kfunc_call_test1(sk, 1, 2, 3, 4);
    bpf_printk("bpf_kfunc_call_test1:  %d.\n", a);
    return a;
}


It is compiled with these commands:

bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
clang -g -O2 -target bpf -D__TARGET_ARCH_x86 -I. -idirafter
/usr/lib/llvm-15/lib/clang/15.0.2/include -idirafter
/usr/local/include -idirafter /usr/include/x86_64-linux-gnu -idirafter
/usr/include -c hello.bpf.c -o hello.bpf.o
llvm-strip -g hello.bpf.o
bpftool gen skeleton hello.bpf.o > hello.skel.h
cc -g -Wall hello.skel.h hello.c /usr/lib64/libbpf.a   -lelf -lz -o hello


The output is quite large, here is a gist:
https://gist.github.com/hfingler/dc96af45d87004d0dc412e35be31709c.
Mainly:

libbpf: extern (func ksym) 'bpf_kfunc_call_test1': resolved to kernel [104983]
libbpf: prog 'kfunc_call_test1': BPF program load failed: Invalid argument
...
kernel function bpf_kfunc_call_test1 args#0 expected pointer to STRUCT
sock but R1 is not a pointer to btf_id
processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'kfunc_call_test1': failed to load: -22
libbpf: failed to load object 'hello_bpf'
libbpf: failed to load BPF skeleton 'hello_bpf': -22
Failed to load and verify BPF skeleton


The other program is based off of minimal.c from libbpf-bootstrap.

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>

extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
                  __u32 c, __u64 d) __ksym;

SEC("tp/raw_syscalls/sys_enter")
int handle_tp(void *ctx)
{
    __u64 a;
    a = bpf_kfunc_call_test1(0, 1, 2, 3, 4);
    bpf_printk("bpf_kfunc_call_test1:  %d.\n", a);
    return 0;
}


The output is a little different, gist:
https://gist.github.com/hfingler/ac69e286f9e527dfd678ef2d768e757c
mainly:

libbpf: extern (func ksym) 'bpf_kfunc_call_test1': resolved to kernel [104983]
...
calling kernel function bpf_kfunc_call_test1 is not allowed
libbpf: prog 'handle_tp': failed to load: -13
libbpf: failed to load object 'hello_bpf'
libbpf: failed to load BPF skeleton 'hello_bpf': -13
Failed to load and verify BPF skeleton


What could be the problem here? I'm mostly interested in the second
program, so that I can use it on my own tracepoints and other places.

I'm aware of filtering in net/core/filter.c, but I can't find any
reference to `bpf_kfunc` functions. In fact, I added this to filter.c,
where both functions just return true (I'm not concerned about
security, this is just research):

const struct bpf_verifier_ops my_verifier_ops = {
    .check_kfunc_call   = export_the_world,
    .is_valid_access    = accept_the_world,
};


I'm assuming something is not allowing this program to call it, maybe
it's the section it's put in. The kernel test's SEC is `classifier`,
which is
defined at tools/lib/bpf/libbpf.c as  `BPF_PROG_SEC("classifier",
BPF_PROG_TYPE_SCHED_CLS),`, while `tp/` is BPF_PROG_TYPE_TRACEPOINT.
Is there a filter somewhere that allows one but not the other? For
example, in kernel/bpf/syscall.c I see:

static bool is_net_admin_prog_type(enum bpf_prog_type prog_type)
{
    switch (prog_type) {
    case BPF_PROG_TYPE_SCHED_CLS:
        .. others

but BPF_PROG_TYPE_TRACEPOINT is not here.

There are so many references to these things that I'm totally lost,
I'd appreciate some help.
Thanks!
