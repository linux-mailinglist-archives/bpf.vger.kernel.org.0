Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF925FFCCB
	for <lists+bpf@lfdr.de>; Sun, 16 Oct 2022 02:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiJPAtv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Oct 2022 20:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJPAtt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Oct 2022 20:49:49 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6EE12AA5
        for <bpf@vger.kernel.org>; Sat, 15 Oct 2022 17:49:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g8-20020a17090a128800b0020c79f987ceso11201883pja.5
        for <bpf@vger.kernel.org>; Sat, 15 Oct 2022 17:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bi9lnj/QQ2rnIIYe048QHQZ3Hl43kD2fnZCedSIQH7s=;
        b=Usx5RVCp95ITawKpjAzAlrN3/X82rOLMTkL2JKi+THNeo7RUgjczZN+nPt/Vm1g6/f
         sF04NA3aEcdMUWqCy8YEL+qlVVc7H+hmyTgGd28kP2rjmyhc+G9yE0mHyKLuMx4aL52c
         8nIa47tCoSwSeSPlYJrlEIrm88ltH6mflRLri/v3QUOIB4roR6yFmKC8Ibx5VY+vLfWI
         7ul0K1mz6fpkcCddZrRJ+KNnQnFSuN+bxiXIN9dzeTC0+zU6Uacuf5WqCMNOR+Pz+X+n
         MLxgdW78nvVrvfqZJoQlsr9/P4tttZpvbV4kIxJ2fBOPGdk0V+t4P5FdOSWmY49ERnjZ
         /zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bi9lnj/QQ2rnIIYe048QHQZ3Hl43kD2fnZCedSIQH7s=;
        b=SM7qTvWlwEUUfLd2TQA0ZJ7KnVrgFoWMdXbXakrzRi6dFSJf6ZHH4S1wWOMOyZizRJ
         KOTWFlOXbOUnd4zB/WUpczIt3pjMUImFrAR/jZECbkHNUNhM9y7IOwT35LCweq9YIAwx
         kH8z/Rlds9W5ol4gP58Ul1/sJESHwfNOXNV3gDTUCxdOFSPp5WUto/lbaR0+tsUy8fsn
         g028IKKis/GCjiH8LQQ3dEoRnhbkEfNu6BHy3Wqzskns4YRopWCQl3C1l35CjcA4PqYv
         XPFDf6uPUSy6+gL8oNbywHQpaYzRQCsmr1AFbHwmyvz4V88ZKMMA2WSHnl23fOV40Rtc
         aFxQ==
X-Gm-Message-State: ACrzQf3x3CIFIfIom5iEStfnFKJXCA/j13hWQCUAFUpiItoYooqZmc+Q
        VQPejTPkoEBkJf0OJYeGmZce/zDelwaWFt8/7FcU+opBh1w=
X-Google-Smtp-Source: AMsMyM5hMd6VgOCIvoD50GtLhjNagFuh7GmvXvedOJ9wp7Sku6R0cmaDvRnedGdpTBvOfNp0DTjV5illE2AExzaZQII=
X-Received: by 2002:a17:90b:4b41:b0:20a:fe8f:5a3 with SMTP id
 mi1-20020a17090b4b4100b0020afe8f05a3mr25324878pjb.120.1665881381168; Sat, 15
 Oct 2022 17:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAFo4XKvHU8gn9PoYwrFA0OyBDGY7=bBvwMDNuWGxR6gkLgudOg@mail.gmail.com>
 <Yz6lxZLRxAalQCHd@krava> <Y0qaeOZHsbiPNfnT@krava>
In-Reply-To: <Y0qaeOZHsbiPNfnT@krava>
From:   Akihiro HARAI <jharai0815@gmail.com>
Date:   Sun, 16 Oct 2022 09:49:24 +0900
Message-ID: <CAFo4XKugofarRQGf_uGf0oOPERhJa4J+eyZkX4tiaDGursd83Q@mail.gmail.com>
Subject: Re: Inconsistent BTF entries for `struct pt_regs *regs` parameter
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for your quick reply.

I've done patching the kernel right now and confirmed the BTF entries
have been fixed. (This is the first time I patched Linux. Wow!)

The entry "FWD 'pt_regs'" has been removed altogether.

I want this kind of fix to be applied to the Linux kernel itself. How
can I support it?


Kernel without patch:

```
$ uname -r
5.15.43-20.123.0withoutpatch.amzn2.x86_64

$ bpftool btf dump file /sys/kernel/btf/vmlinux format raw
...
[15439] FWD 'pt_regs' fwd_kind=struct
[15440] CONST '(anon)' type_id=15439
[15441] PTR '(anon)' type_id=15440
[15442] FUNC_PROTO '(anon)' ret_type_id=34 vlen=1
        '__unused' type_id=15441
...
[15694] FUNC '__x64_sys_recvmsg' type_id=15442 linkage=static
...
```

Patched kernel:

```
$ uname -r
5.15.43-20.123.1patched.amzn2.x86_64

$ bpftool btf dump file /sys/kernel/btf/vmlinux format raw
...
[172] STRUCT 'pt_regs' size=168 vlen=21
        'r15' type_id=1 bits_offset=0
        'r14' type_id=1 bits_offset=64
        'r13' type_id=1 bits_offset=128
        'r12' type_id=1 bits_offset=192
        'bp' type_id=1 bits_offset=256
        'bx' type_id=1 bits_offset=320
        'r11' type_id=1 bits_offset=384
        'r10' type_id=1 bits_offset=448
        'r9' type_id=1 bits_offset=512
        'r8' type_id=1 bits_offset=576
        'ax' type_id=1 bits_offset=640
        'cx' type_id=1 bits_offset=704
        'dx' type_id=1 bits_offset=768
        'si' type_id=1 bits_offset=832
        'di' type_id=1 bits_offset=896
        'orig_ax' type_id=1 bits_offset=960
        'ip' type_id=1 bits_offset=1024
        'cs' type_id=1 bits_offset=1088
        'flags' type_id=1 bits_offset=1152
        'sp' type_id=1 bits_offset=1216
        'ss' type_id=1 bits_offset=1280
...
[4265] CONST '(anon)' type_id=172
...
[4270] PTR '(anon)' type_id=4265
...
[4282] FUNC_PROTO '(anon)' ret_type_id=34 vlen=1
        '__unused' type_id=4270
...
[15690] FUNC '__x64_sys_recvmsg' type_id=4282 linkage=static
...
```

On Sat, Oct 15, 2022 at 8:33 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Oct 06, 2022 at 11:54:13AM +0200, Jiri Olsa wrote:
> > On Thu, Oct 06, 2022 at 04:34:46PM +0900, Akihiro HARAI wrote:
> > > Depending on distribution/kernel/syscall combination, BTF entry for
> > > `struct pt_regs *regs` parameter differs.
> > >
> > > For example, Amazon Linux 2 with kernel-5.15 package enabled has a FWD
> > > entry for `__x64_sys_recvmsg` function:
> > >
> > > ```
> > > $ uname -a
> > > Linux ip-10-1-1-66.ap-northeast-1.compute.internal
> > > 5.15.43-20.123.amzn2.x86_64 #1 SMP Fri May 27 00:28:44 UTC 2022 x86_64
> > > x86_64 x86_64 GNU/Linux
> > >
> > > $ bpftool btf dump file /sys/kernel/btf/vmlinux format raw
> > > ...
> > > [15439] FWD 'pt_regs' fwd_kind=struct
> > > [15440] CONST '(anon)' type_id=15439
> > > [15441] PTR '(anon)' type_id=15440
> > > [15442] FUNC_PROTO '(anon)' ret_type_id=34 vlen=1
> > >         '__unused' type_id=15441
> > > ...
> > > [15694] FUNC '__x64_sys_recvmsg' type_id=15442 linkage=static
> > > ...
> > > ```
> > >
> > > while Ubuntu 20.04 LTS with newer kernel has a STRUCT entry for the
> > > same function:
> > >
> > > ```
> > > $ uname -a
> > > Linux xxx-XPS-13-9300 5.13.0-51-generic #58~20.04.1-Ubuntu SMP Tue Jun
> > > 14 11:29:12 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
> > >
> > > $ bpftool btf dump file /sys/kernel/btf/vmlinux format raw
> > > [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> > > ...
> > > [226] STRUCT 'pt_regs' size=168 vlen=21
> > >         'r15' type_id=1 bits_offset=0
> > >         'r14' type_id=1 bits_offset=64
> > >         'r13' type_id=1 bits_offset=128
> > >         'r12' type_id=1 bits_offset=192
> > >         'bp' type_id=1 bits_offset=256
> > >         'bx' type_id=1 bits_offset=320
> > >         'r11' type_id=1 bits_offset=384
> > >         'r10' type_id=1 bits_offset=448
> > >         'r9' type_id=1 bits_offset=512
> > >         'r8' type_id=1 bits_offset=576
> > >         'ax' type_id=1 bits_offset=640
> > >         'cx' type_id=1 bits_offset=704
> > >         'dx' type_id=1 bits_offset=768
> > >         'si' type_id=1 bits_offset=832
> > >         'di' type_id=1 bits_offset=896
> > >         'orig_ax' type_id=1 bits_offset=960
> > >         'ip' type_id=1 bits_offset=1024
> > >         'cs' type_id=1 bits_offset=1088
> > >         'flags' type_id=1 bits_offset=1152
> > >         'sp' type_id=1 bits_offset=1216
> > >         'ss' type_id=1 bits_offset=1280
> > > ...
> > > [5183] CONST '(anon)' type_id=226
> > > ...
> > > [5189] PTR '(anon)' type_id=5183
> > > ...
> > > [5321] FUNC_PROTO '(anon)' ret_type_id=42 vlen=1
> > >         '__unused' type_id=5189
> > > ...
> > > [17648] FUNC '__x64_sys_recvmsg' type_id=5321 linkage=static
> > > ...
> > > ```
> > >
> > > Yet another distribution/kernel/syscall combination has multiple `FUNC
> > > '__x64_sys_[SYSCALL]'` entries, one for FWD and the other for STRUCT:
> > >
> > > ```
> > > $ uname -a
> > > Linux ip-10-5-0-115.ap-northeast-1.compute.internal
> > > 5.10.112-108.499.amzn2.x86_64 #1 SMP Wed Apr 27 23:39:40 UTC 2022
> > > x86_64 x86_64 x86_64 GNU/Linux
> > >
> > > ```
> > > $ bpftool btf dump file /sys/kernel/btf/vmlinux format raw | grep
> > > __x64_sys_mprotect
> > > ...
> > > [175] STRUCT 'pt_regs' size=168 vlen=21
> > >         'r15' type_id=2 bits_offset=0
> > >         'r14' type_id=2 bits_offset=64
> > >         'r13' type_id=2 bits_offset=128
> > >         'r12' type_id=2 bits_offset=192
> > >         'bp' type_id=2 bits_offset=256
> > > ...
> > > [4215] CONST '(anon)' type_id=175
> > > ...
> > > [4220] PTR '(anon)' type_id=4215
> > > ...
> > > [6062] FUNC_PROTO '(anon)' ret_type_id=36 vlen=1
> > >         'regs' type_id=4220
> > > ...
> > > [11461] FWD 'pt_regs' fwd_kind=struct
> > > [11462] CONST '(anon)' type_id=11461
> > > [11463] PTR '(anon)' type_id=11462
> > > [11464] FUNC_PROTO '(anon)' ret_type_id=36 vlen=1
> > >         '__unused' type_id=11463
> > > ...
> > > [11698] FUNC '__x64_sys_mprotect' type_id=11464 linkage=static
> > > ...
> > > [23528] FUNC '__x64_sys_mprotect' type_id=6062 linkage=static
> > > ...
> > > ```
> > >
> > > Trying to read `regs` parameter with FWD entry results in "invalid
> > > bpf_context access" error:
> > >
> > > ```
> > > SEC("fentry/__x64_sys_recvfrom")
> > > int BPF_PROG(fentry_syscall, struct pt_regs *regs) {
> > >   struct event t;
> > >
> > >   bpf_get_current_comm(t.comm, TASK_COMM_LEN);
> > >
> > >   u64 id = bpf_get_current_pid_tgid();
> > >   t.pid = id >> 32;
> > >
> > >   // This causes an error on some environments.
> > >   t.fd = PT_REGS_PARM1_CORE(regs);
> > >
> > >   bpf_printk("comm: %s, pid: %d, fd: %d", t.comm, t.pid, t.fd);
> > >
> > >   return 0;
> > > ```
> > >
> > > ```
> > > $ sudo ./output
> > > 2022/07/01 03:33:01 loading objects: field FentrySyscall: program
> > > fentry_syscall: load program: permission denied:
> > >         arg#0 type is not a struct
> > >         Unrecognized arg#0 type PTR
> > >         ; int BPF_PROG(fentry_syscall, struct pt_regs *regs) {
> > >         0: (79) r6 = *(u64 *)(r1 +0)
> > >         func '__x64_sys_recvfrom' arg0 type FWD is not a struct
> > >         invalid bpf_context access off=0 size=8
> > >         processed 1 insns (limit 1000000) max_states_per_insn 0
> > > total_states 0 peak_states 0 mark_read 0
> > > ```
> > >
> > > Is this a bug related to toolchain?
> >
> > nice, I think it's specific to each object that defines syscall
> >
> > if such object has 'struct pt_regs' header with definition included
> > it will have full struct pt_regs, if not it will be just fwd ref
> >
> > not sure this would break anything else, but change below
> > fixes it for me
>
> hi,
> did this help? I'll send it as formal patch anyway,
> since it fixes the issue for me
>
> jirka
>
> >
> > jirka
> >
> >
> > ---
> > diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
> > index 59358d1bf880..fd2669b1cb2d 100644
> > --- a/arch/x86/include/asm/syscall_wrapper.h
> > +++ b/arch/x86/include/asm/syscall_wrapper.h
> > @@ -6,7 +6,7 @@
> >  #ifndef _ASM_X86_SYSCALL_WRAPPER_H
> >  #define _ASM_X86_SYSCALL_WRAPPER_H
> >
> > -struct pt_regs;
> > +#include <asm/ptrace.h>
> >
> >  extern long __x64_sys_ni_syscall(const struct pt_regs *regs);
> >  extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
