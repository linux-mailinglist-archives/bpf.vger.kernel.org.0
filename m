Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6633553BFD7
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 22:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbiFBU3Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jun 2022 16:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiFBU3X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 16:29:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC4D19FB1
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 13:29:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id be31so9551518lfb.10
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 13:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgIwryEYl9R87FoliWfIWDUH0oSQjlkLyRF0chemF48=;
        b=NpV5ZzbeDCMQ/ZxHTujhAg4Q5vhkc0AbEclmoBn/d2Cs5b+U0+GJD5vl1LGXL+A9HO
         /Kzpg6xk7jb0Colmv/3UZ4mABjbWBtTRR087HOmRLfWFUtzcq0Pw6ox3Sm32NHoywpT5
         JFwJ7Ldxd8J6OAa4hRJZiPX1qlw49LBeTguEhJJ/nbYZsYyTuo9Y3ImPUv/R+WymTmYK
         UGKFbzcYeTSSiQ7bpO8Rs33XIs/gEGp1rMVCTiBTlNlOzOMh/i82K/0QUrMM8H/yYdIR
         tBgitLhHV56N55SePb9bQ/OCHdzGf6PzbpSTKOgaoH+QGcwnVWAMt2qKmOKZfU9tzYXU
         sRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgIwryEYl9R87FoliWfIWDUH0oSQjlkLyRF0chemF48=;
        b=V2VpAshTcjHkFLIfEfsjv2Ev1F4A8GY3dZ5/jX8T1SEyXl+2nx2/FhW1ZKKgx9JIgr
         yN7bdTIrddXriyRylmbfp24ePVytRZOXb0nRI3JPNqk3bzWbypsTXEiJ6ITjXDLz44nN
         liXVmHuN18ANto9dRybQ/np65FUO6urBx0mDzTnWcotOvO0Zrp663H12XFx9mN5rRIZE
         H0d86kYc5OpdXGLOylh7ufYOf/3MmHJssknP6ob8rYp4LAVeXNRK/5xJ1lZu7907jIHH
         KTW6fp8HL+OzPPoK8rMmb6l0JWUJxGgs6l3qixP1GL3WmzrUQoPluO/1N3r2lBOcmUHZ
         oIxA==
X-Gm-Message-State: AOAM533C2/cSiY+xakTxpTnxucZyCE7JC9sbFnfmIMBARmazXmqID44O
        CYj8yYYrOcbS7yNUoQ+mgeQ2z8iXVRdQnn0vQPfROrG9
X-Google-Smtp-Source: ABdhPJzHMDjVaSZhukwWstJvHtR91LJQze3Gk/tE6GFMBGT/3ni2WPx7Y+U7YKc35QvQRaXFk4gdOUowOWVh7lNQgDM=
X-Received: by 2002:ac2:4e88:0:b0:477:c186:6e83 with SMTP id
 o8-20020ac24e88000000b00477c1866e83mr50413788lfr.663.1654201760570; Thu, 02
 Jun 2022 13:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <CALo96CRkg4eH=Ee0qvx3YigyP9mPyzz6vhTtpqNN1n4mvUQUPA@mail.gmail.com>
In-Reply-To: <CALo96CRkg4eH=Ee0qvx3YigyP9mPyzz6vhTtpqNN1n4mvUQUPA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 2 Jun 2022 13:29:09 -0700
Message-ID: <CAEf4BzbuiB2qRotoNVrgtmV7E+f1ouBLhJjy6Az4nhM+o9ttLw@mail.gmail.com>
Subject: Re: Relocation error on 32 bit systems of longs from vmlinux.h
To:     Matteo Nardi <matteo@exein.io>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>
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

On Wed, May 25, 2022 at 9:13 AM Matteo Nardi <matteo@exein.io> wrote:
>
> This program will compile and run fine on my 64 bit system, but it
> will fail with a relocation error on 32 bit systems:
>
> SEC("tp/raw_syscalls/sys_enter")
> int sys_enter(struct trace_event_raw_sys_enter *ctx) {
>         long int n = ctx->id;
>         bpf_printk("hello world %d", n);
>         return 0;
> }
>
> ```
> libbpf: prog 'sys_enter': relo #0: insn #0 (LDX/ST/STX) accesses field
> incorrectly. Make sure you are accessing pointers, unsigned integers,
> or fields of matching type and size.
> libbpf: prog 'sys_enter': BPF program load failed: Invalid argument
> libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
> R1 type=ctx expected=fp
> ; long int n = ctx->id;
> 0: (85) call unknown#195896080
> invalid func unknown#195896080
> processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: failed to load program 'sys_enter'
> libbpf: failed to load object 'bootstrap_bpf'
> libbpf: failed to load BPF skeleton 'bootstrap_bpf': -22
> Failed to load and verify BPF skeleton
> ```
>
> I'm cross-compiling using a Yocto build. I've reproduced this both
> with arm and x86.
>
> From my understanding, the issue comes from the `long int` in
> `trace_event_raw_sys_enter`, which is 64 bit in the compiled eBPF
> program, but 32 bit in the target kernel.
>
> struct trace_event_raw_sys_enter {
>         struct trace_entry ent;
>         long int id;
>         long unsigned int args[6];
>         char __data[0];
> } __attribute__((preserve_access_index));
>
> Indeed, manually changing the `id` definition  in `vmlinux.h` will fix
> the relocation error:
>
> struct trace_event_raw_sys_enter {
>         u32 id;
> } __attribute__((preserve_access_index));
>
>
> "Q: clang flag for target bpf?"[0] hints that using a native target
> could help, but I guess that would completely break CORE relocations
> since `preserve_access_index` is a `-target bpf`-specific attribute,
> right?
>
> Am I missing something? If I had to fix the issue right now I would
> replace all long definitions in `vmlinux.h` to u32 when targeting 32
> bit systems. Could `bpftool btf dump` handle this?
> We're using eBPF on embedded systems, where 32 bit is still fairly common.
>

This could work for long, but there is nothing that can be done for
pointers. Good knews is that libbpf can auto-matically adjust such 64
vs 32 bit accesses for pointers and *unsigned* integers, but you ran
into an issue with signed integer, which isn't as easy to handle due
to the need to do sign-extension.

Libbpf could handle this transparently pretty easily if BPF had
sign-extending load, though, so maybe the best long-term solution is
to have one? It actually would make some other cases better and allow
Clang to not generate a sequence of <<32, >>32 shift just for sign
extensions. Alexei, Yonghong, WDYT?

> Thanks.
>
> Best regards,
> Matteo Nardi
>
> [0] https://www.kernel.org/doc/html/latest/bpf/bpf_devel_QA.html#q-clang-flag-for-target-bpf
