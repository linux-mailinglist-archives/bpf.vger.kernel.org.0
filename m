Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78EF210335
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 07:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgGAFFf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 01:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGAFFf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 01:05:35 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B78AC061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 22:05:35 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id a17so1705904vsq.6
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 22:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SfEpcD0ci43lqk/bikBGAhMpWm2ltcTszOa53Jb0+4M=;
        b=VexLZv+iaJrp+VTOSUZvfpOm9eYhBxJZP7RnoipOtWo7mmo4p5wUdrOybwKIMsAq5l
         0O2+iS9STZJFfB/T5ShuBa8TJIgJjOVMRmyyBX1e/YaiHZgG7GDvUwArkEXLkbh+MvQ/
         R7v96OXwF9KkDxXy0c6xH0PHeCMXDCFLsVuAHa63kFjjHxvqei/4Zxir+3ofnoyQOPih
         zUfy0hs4lY8CflfwezDwoyQYYOxu7AOfnw30iTrZT93TfVoITtgYb0npxK+Cmz7lcUiA
         Jx+/SjYQ92kNN9CkVcFsUijZe9Os65DnyKTXT6+ko2o/e3TD3KmIdSWUyVxlV7jWP11A
         NcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SfEpcD0ci43lqk/bikBGAhMpWm2ltcTszOa53Jb0+4M=;
        b=paBCk4aFfJOaB09bSLwFtw6FMLSBzUwooI9bs8qB2cAh/2B+yndMe67OWQXLdYP0FR
         gCPSNzaWbeWlsqjDOr5zS/eIDnayr6Gy/nX2jNJSOZPq2+KyJnEp0pQYveq0vcY9Mc8r
         9SQO//+S9YlSGwuzRUvgQiB3AFUj3An2W50+lcA4Wq9XH6sz7wh4rR9WtjLu/3Fmv2HK
         1Z6u454aE6NowExIRXyaeq6DlS9jCBgUEG2Ds0+ZGSoUnQ206PWTU5JnRePnZvfOKD+G
         eNI0hU8aydpcPVr/RoF05uoa1IsSuFKGDiJsjLfmIi7+j5qoSog2hdxf7STEHr16DTft
         Wu/g==
X-Gm-Message-State: AOAM530sYDwpgM92wa0+2rNz2GINKuoZHt9BJ/Rq/cx4kM3WNRRQCOMh
        48kzLBRX/DHGdvJgAlbopQB7sNXPnOIqhH6hikE=
X-Google-Smtp-Source: ABdhPJxZ8a5SR+b8FF0D0wbPSazvv2BvjSXosYN+kUYF5DW4BkpQ+SCCtMeVzsL2GZBu2a2+6bPIvQzdXYJ9w1WnHO4=
X-Received: by 2002:a05:6102:10d0:: with SMTP id t16mr10971545vsr.47.1593579934009;
 Tue, 30 Jun 2020 22:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <CABtjQmYObfTxZ_mZdhDBw_mmShJMofR3VeCH+GgATLrWD1x9+g@mail.gmail.com>
 <79dbb7c0-449d-83eb-5f4f-7af0cc269168@fb.com>
In-Reply-To: <79dbb7c0-449d-83eb-5f4f-7af0cc269168@fb.com>
From:   Wenbo Zhang <ethercflow@gmail.com>
Date:   Wed, 1 Jul 2020 13:05:23 +0800
Message-ID: <CABtjQmZPFsqVTZ=ofOHq6JNXBjcYdBSnGwXi4xqjwr-tK0bP+g@mail.gmail.com>
Subject: Re: tp_btf: if (!struct->pointer_member) always actually false
 although pointer_member == NULL
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Thanks for reporting.
> The assembly code looks correct. So this mostly related to kernel.
> Will take a further look.

You are welcome, I've noticed your [PATCH bpf 1/2] bpf: fix an
incorrect branch elimination by verifier.
I'll try it with latest bpf tree later. Thank you all.

> For the llvm crash below, it should have been fixed in last llvm trunk.
> Please give a try. Thanks!

Get it, thanks. I'll try later.

Yonghong Song <yhs@fb.com> =E4=BA=8E2020=E5=B9=B46=E6=9C=8830=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=884:47=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 6/28/20 10:25 PM, Wenbo Zhang wrote:
> > I found in tp_btf program, direct access struct's pointer member's
> > behaviour isn't consistent with
> > BPF_CORE_READ. for example:
> >
> > SEC("tp_btf/block_rq_issue")
> > int BPF_PROG(tp_btf__block_rq_issue, struct request_queue *q,
> >      struct request *rq)
> > {
> >          /* After echo none > /sys/block/$dev/queue/scheduler,
> >           * the $dev's q->elevator will be set to NULL.
> >           */
> >          if (!q->elevator)
> >                  bpf_printk("direct access: noop\n");
> >          if (!BPF_CORE_READ(q, elevator))
> >                  bpf_printk("FROM CORE READ: noop\n");
> >          return 0;
> > }
> >
> > Although its value is NULL, from trace_pipe I can only see
> >
> >> FROM CORE READ: noop
> >
> > So it seems  `if (!q->elevator)` always return false.
>
> Thanks for reporting.
> The assembly code looks correct. So this mostly related to kernel.
> Will take a further look.
>
> For the llvm crash below, it should have been fixed in last llvm trunk.
> Please give a try. Thanks!
>
> >
> > I tested it with kernel 5.7.0-rc7+ and 5.8.0-rc1+, both have this probl=
em.
> > clang version: clang version 10.0.0-4ubuntu1~18.04.1
> >
> > Reproduce step:
> > 1. Run this bpf prog;
> > 2. Run `cat /sys/kernel/debug/tracing/trace_pipe` in other window;
> > 3. Run `echo none > /sys/block/sdc/queue/scheduler`;  # please replace
> > sdc to your device;
> > 4. Run `dd if=3D/dev/zero of=3D/dev/sdc  bs=3D1MiB count=3D200 oflag=3D=
direct`;
> >
> >
> > The output of  `llvm-objdump-10 -D bio.bpf.o` is:
> >
> >
> > bio.bpf.o:      file format ELF64-BPF
> >
> >
> > Disassembly of section tp_btf/block_rq_issue:
> >
> > 0000000000000000 tp_btf__block_rq_issue:
> >         0:       b7 02 00 00 08 00 00 00 r2 =3D 8
> >         1:       79 11 00 00 00 00 00 00 r1 =3D *(u64 *)(r1 + 0)
> >         2:       bf 16 00 00 00 00 00 00 r6 =3D r1
> >         3:       0f 26 00 00 00 00 00 00 r6 +=3D r2
> >         4:       79 11 08 00 00 00 00 00 r1 =3D *(u64 *)(r1 + 8)
> >         5:       55 01 0e 00 00 00 00 00 if r1 !=3D 0 goto +14 <LBB0_2>
> >         6:       b7 01 00 00 00 00 00 00 r1 =3D 0
> >         7:       73 1a fc ff 00 00 00 00 *(u8 *)(r10 - 4) =3D r1
> >         8:       b7 01 00 00 6f 6f 70 0a r1 =3D 175140719
> >         9:       63 1a f8 ff 00 00 00 00 *(u32 *)(r10 - 8) =3D r1
> >        10:       18 01 00 00 63 63 65 73 00 00 00 00 73 3a 20 6e r1 =3D
> > 7935406810958488419 ll
> >        12:       7b 1a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) =3D r1
> >        13:       18 01 00 00 64 69 72 65 00 00 00 00 63 74 20 61 r1 =3D
> > 6998721791186332004 ll
> >        15:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 24) =3D r1
> >        16:       bf a1 00 00 00 00 00 00 r1 =3D r10
> >        17:       07 01 00 00 e8 ff ff ff r1 +=3D -24
> >        18:       b7 02 00 00 15 00 00 00 r2 =3D 21
> >        19:       85 00 00 00 06 00 00 00 call 6
> >
> > 00000000000000a0 LBB0_2:
> >        20:       bf a1 00 00 00 00 00 00 r1 =3D r10
> >        21:       07 01 00 00 e8 ff ff ff r1 +=3D -24
> >        22:       b7 02 00 00 08 00 00 00 r2 =3D 8
> >        23:       bf 63 00 00 00 00 00 00 r3 =3D r6
> >        24:       85 00 00 00 04 00 00 00 call 4
> >        25:       79 a1 e8 ff 00 00 00 00 r1 =3D *(u64 *)(r10 - 24)
> >        26:       55 01 0e 00 00 00 00 00 if r1 !=3D 0 goto +14 <LBB0_4>
> >        27:       b7 01 00 00 0a 00 00 00 r1 =3D 10
> >        28:       6b 1a fc ff 00 00 00 00 *(u16 *)(r10 - 4) =3D r1
> >        29:       b7 01 00 00 6e 6f 6f 70 r1 =3D 1886351214
> >        30:       63 1a f8 ff 00 00 00 00 *(u32 *)(r10 - 8) =3D r1
> >        31:       18 01 00 00 45 20 52 45 00 00 00 00 41 44 3a 20 r1 =3D
> > 2322243604989485125 ll
> >        33:       7b 1a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) =3D r1
> >        34:       18 01 00 00 46 52 4f 4d 00 00 00 00 20 43 4f 52 r1 =3D
> > 5931033040285291078 ll
> >        36:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 24) =3D r1
> >        37:       bf a1 00 00 00 00 00 00 r1 =3D r10
> >        38:       07 01 00 00 e8 ff ff ff r1 +=3D -24
> >        39:       b7 02 00 00 16 00 00 00 r2 =3D 22
> >        40:       85 00 00 00 06 00 00 00 call 6
> >
> > 0000000000000148 LBB0_4:
> >        41:       b7 00 00 00 00 00 00 00 r0 =3D 0
> >        42:       95 00 00 00 00 00 00 00 exit
> >
> > Disassembly of section license:
> >
> > 0000000000000000 LICENSE:
> >         0:       47      <unknown>
> >         0:       50      <unknown>
> >         0:       4c      <unknown>
> >         0:       00      <unknown>
> >
> > Disassembly of section .rodata.str1.1:
> >
> > 0000000000000000 .rodata.str1.1:
> >         0:       64 69 72 65 63 74 20 61 w9 <<=3D 1629516899
> >         1:       63 63 65 73 73 3a 20 6e *(u32 *)(r3 + 29541) =3D r6
> >         2:       6f 6f 70 0a 00 46 52 4f <unknown>
> >         3:       4d 20 43 4f 52 45 20 52 <unknown>
> >         4:       45 41 44 3a 20 6e 6f 6f <unknown>
> >         5:       70      <unknown>
> >         5:       0a      <unknown>
> >         5:       00      <unknown>
> >
> [...]
> >       709:       69 5f 72 65 6d 61 69 6e <unknown>
> >       710:       69 6e 67 00 62 69 5f 69 <unknown>
> >       711:       74 65 72 00 62 69 5f 65 w5 >>=3D 1700751714
> >       712:       6e 64 5f 69 6f 00 62 69 if
> >
> >
> > BTW, the llvm-objdump will core dump after output the above info:
> >
> > Stack dump:
> > 0. Program arguments: llvm-objdump-10 -D bio.bpf.o
> > /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(_ZN4llvm3sys15PrintStackTrace=
ERNS_11raw_ostreamE+0x1f)[0x7f7636d5dc3f]
> > /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(_ZN4llvm3sys17RunSignalHandle=
rsEv+0x50)[0x7f7636d5bf00]
> > /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(+0x978205)[0x7f7636d5e205]
> > /lib/x86_64-linux-gnu/libpthread.so.0(+0x12890)[0x7f76361d9890]
> > /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(+0x21bbed3)[0x7f76385a1ed3]
> > /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(+0x21baefb)[0x7f76385a0efb]
> > /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(+0x21bc0ce)[0x7f76385a20ce]
> > llvm-objdump-10[0x41b78c]
> > llvm-objdump-10[0x425278]
> > llvm-objdump-10[0x41f502]
> > llvm-objdump-10[0x41a473]
> > /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)[0x7f763546db97]
> > llvm-objdump-10[0x41542a]
> > [1]    21636 segmentation fault (core dumped)
> >
> > llvm-objdump-10 --version
> > LLVM (https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__llvm.org_&d=
=3DDwIBaQ&c=3D5VD0RTtNlTh3ycd41b3MUw&r=3DDA8e1B5r073vIqRrFz7MRA&m=3Dzs4_mz-=
CGExwverPej7QEcaeDzsjcZfkD_GiyMQDJbE&s=3D1inYTci4noQ6dJN-mUYTlvU7OrTX3C7h-0=
Kn39reX-Y&e=3D ):
> >    LLVM version 10.0.0
> >
> >    Optimized build.
> >    Default target: x86_64-pc-linux-gnu
> >    Host CPU: broadwell
> >
> >    Registered Targets:
> >      aarch64    - AArch64 (little endian)
> >      aarch64_32 - AArch64 (little endian ILP32)
> [...]
