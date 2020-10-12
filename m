Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486CF28C452
	for <lists+bpf@lfdr.de>; Mon, 12 Oct 2020 23:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbgJLVtI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Oct 2020 17:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbgJLVtI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Oct 2020 17:49:08 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018E5C0613D0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 14:49:08 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dn5so18632375edb.10
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 14:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7UWh4DQu7ja267zDrDLcN+l9Hvk9wllzQZyBxtFmEnw=;
        b=M+uU9EFyCki86mTMmnGqb/QSqeIwFpkxa7kAWBHWLaeIzQKTuHcSF/S1VCpCugt+pY
         ctdQ57iHvSejt/syBDTgud6JFU76HYMPGYHzIiepD6WDNw2a4wdKKI+xMXnx+yebiWa/
         mDIMjZ5gOZDyHyR8DDYC1L2XD8DXxFJNADOe5I0/D/1LcpRF+pdwPY+QVzLtgzNat3n8
         L05RovIdgawdZZgk/49pxwATh4AkIdfDkrIZ3RKe5hurwY6tbGe+P0DubRkLE6jQyjOc
         MsG8FI3i4Xjc0W4qUQiouxKVEvmW+G/gOM3m70oz85H51zFxc+AKRWlGFY+WXd0zyV5T
         l7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7UWh4DQu7ja267zDrDLcN+l9Hvk9wllzQZyBxtFmEnw=;
        b=rKz25sjD2tvkiR2rd69q6wUD6VQz4uCtyiBa6tttaSAyW4jvgbxoGvuZHuq9AA3uh+
         RVDO1MhJk8sCiq7H4k4xYnV0y2vNs6orVNhxVYGG/KQXT/zMKFtp5TLli42813QiqvsQ
         GXr8THXP7pGaY//HUBnSfTKDJrUNEFP84vQmGzPXOkpCjIfeVV/av03W0q0fMUSK6FWY
         mMiG+OnAqLX8pMA/jTccvQrQL36fCgEr7xTSWH9scQwBcxzX4OochYnouTXadJvWLQ5l
         8+DFKs+auGuTdZ08xeCiCexdtqKofshII3cKptXg45dl8KI4LYJyut9cN/wlQQ7StU0N
         dNYQ==
X-Gm-Message-State: AOAM53181//E1ULuir8WvsMyPZsxBiXdw82x8N0oF02P5DHfeQaO2Tbh
        xnbp3Evnk+VUIiNXmR4JWXAQFVcjU2ZJ8EzDRCUvwK3l6d81L0fB
X-Google-Smtp-Source: ABdhPJz84LNBL4RZhZ5fvgEKQF9w8MTgJpcnEV1YaCdSLqd6F/tY7xpHIGi2rXFdPSjssAP2GIBrvtf4z8I/en+Nd/E=
X-Received: by 2002:aa7:cd90:: with SMTP id x16mr16350152edv.302.1602539346491;
 Mon, 12 Oct 2020 14:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net> <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net> <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
 <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net> <CAMy7=ZW6B+aHN-3dAf7-=kK8WpMZ0NmEmeVh67jVPrjsryx9sQ@mail.gmail.com>
 <CAEf4BzYJQ_RZgy8YCPxfF+QEkx9W+jeu-3O3CX+vEqTFtOT2Fw@mail.gmail.com>
 <CAMy7=ZWhAzJP5m3QW0gHe4rVFoETT=zhCcyVeKBuTcO=ttC=MA@mail.gmail.com>
 <CAEf4Bzbm7D+ygkoCCoTy8OR0krVWosS_o13Gv4Xd2jhOSC5a7Q@mail.gmail.com>
 <CAMy7=ZWoaYkMCfAN4YLzO52Gms3haZn8=k9YBXPz9FxqHxuCFA@mail.gmail.com> <CAEf4BzbTs1T8AW8xiYU1KxtwxWhh6ieD7OLBm3k489-HErXDZw@mail.gmail.com>
In-Reply-To: <CAEf4BzbTs1T8AW8xiYU1KxtwxWhh6ieD7OLBm3k489-HErXDZw@mail.gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Tue, 13 Oct 2020 00:48:55 +0300
Message-ID: <CAMy7=ZV_URq=svstzN-BhOLeSzkQaTuzfJ2mT3UsERzSbgsqHQ@mail.gmail.com>
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=
=B3, 12 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-23:03 =D7=9E=D7=90=D7=AA=
 =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
<=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Fri, Oct 9, 2020 at 1:24 PM Yaniv Agman <yanivagman@gmail.com> wrote:
> >
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=
=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-22:53 =D7=9E=D7=90=D7=
=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> > <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > >
> > > On Fri, Oct 9, 2020 at 12:32 PM Yaniv Agman <yanivagman@gmail.com> wr=
ote:
> > > >
> > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-21:39 =D7=9E=D7=
=90=D7=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> > > > <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > >
> > > > > On Fri, Oct 9, 2020 at 11:33 AM Yaniv Agman <yanivagman@gmail.com=
> wrote:
> > > > > >
> > > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=
=9D =D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-21:21 =D7=9E=
=D7=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > > > > <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > > > >
> > > > > > > On 10/9/20 8:09 PM, Yaniv Agman wrote:
> > > > > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=
=D7=9D =D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-20:39 =D7=
=9E=D7=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > > > > > > <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > > > > >>
> > > > > > > >> On 10/9/20 6:56 PM, Yaniv Agman wrote:
> > > > > > > >>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=
=95=D7=9D =D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-19:27 =
=D7=9E=D7=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > > > > > >>> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=
=AC
> > > > > > > >>>>
> > > > > > > >>>> [ Cc +Yonghong ]
> > > > > > > >>>>
> > > > > > > >>>> On 10/9/20 6:05 PM, Yaniv Agman wrote:
> > > > > > > >>>>> Pulling the latest changes of libbpf and compiling my a=
pplication with it,
> > > > > > > >>>>> I see the following error:
> > > > > > > >>>>>
> > > > > > > >>>>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10=
: error:
> > > > > > > >>>>> unknown register name 'r0' in asm
> > > > > > > >>>>>                         : "r0", "r1", "r2", "r3", "r4",=
 "r5");
> > > > > > > >>>>>
> > > > > > > >>>>> The commit which introduced this change is:
> > > > > > > >>>>> 80c7838600d39891f274e2f7508b95a75e4227c1
> > > > > > > >>>>>
> > > > > > > >>>>> I'm not sure if I'm doing something wrong (missing incl=
ude?), or this
> > > > > > > >>>>> is a genuine error
> > > > > > > >>>>
> > > > > > > >>>> Seems like your clang/llvm version might be too old.
> > > > > > > >>>
> > > > > > > >>> I'm using clang 10.0.1
> > > > > > > >>
> > > > > > > >> Ah, okay, I see. Would this diff do the trick for you?
> > > > > > > >
> > > > > > > > Yes! Now it compiles without any problems!
> > > > > > >
> > > > > > > Great, thx, I'll cook proper fix and check with clang6 as Yon=
ghong mentioned.
> > > > > > >
> > > > > >
> > > > > > Thanks!
> > > > > > Does this happen because I'm first compiling using "emit-llvm" =
and
> > > > > > then using llc?
> > > > >
> > > > > So this must be the reason, but I'll wait for Yonghong to confirm=
.
> > > > >
> > > > > > I wish I could use bpf target directly, but I'm then having pro=
blems
> > > > > > with includes of asm code (like pt_regs and other stuff)
> > > > >
> > > > > Are you developing for a 32-bit platform? Or what exactly is the
> > > > > problem? I've been trying to solve problems for 32-bit arches rec=
ently
> > > > > by making libbpf smarter, that relies on CO-RE though. Is CO-RE a=
n
> > > > > option for you?
> > > > >
> > > >
> > > > Examples for the errors I'm getting:
> > > > /lib/modules/4.14.199-1-MANJARO/build/arch/x86/include/asm/atomic.h=
:177:9:
> > > > error: invalid output constraint '+q' in asm
> > > >         return xadd(&v->counter, i);
> > > >                ^
> > > > /lib/modules/4.14.199-1-MANJARO/build/arch/x86/include/asm/cmpxchg.=
h:234:25:
> > > > note: expanded from macro 'xadd'
> > > > #define xadd(ptr, inc)          __xadd((ptr), (inc), LOCK_PREFIX)
> > > > ...
> > > >
> > > > From What I understood, this is a known issue for tracing programs
> > > > (like the one I'm developing)
> > >
> > > We do have a bunch of selftests that use pt_regs and include, say,
> > > linux/ptrace.h header. I wonder why we are not seeing these problems.
> > > Selftests, btw, are also built with -emit-llvm and then piping output
> > > to llc.
> > >
> > > So.. there must be something else going on. It's hard to guess like
> > > this without seeing the code, but maybe -D__TARGET_ARCH_$(SRCARCH)
> > > during compilation could help, just as an idea.
> > >
> >
> > Adding -D__TARGET_ARCH_$(SRCARCH) doesn't seem to help.
> > If you are interested in having a look at the code,
> > The code (event_monitor_ebpf.c) including the makefile is here:
> > https://github.com/yanivagman/tracee/tree/move_to_libbpf/tracee
>
> You are including a lot of kernel headers in that code. If any of them
> pulls in some x86-specific stuff, you would get this problem. Try to
> minimize the amount of includes you have there, maybe the issue will
> go away.
>

I only added an include when I needed it, so I'm not sure I can remove
any of them...

> If not, one other way would be to generate vmlinux.h for your specific
> kernel build. It will have memory layout of all the structs identical
> to what you get from kernel headers. Then you can replace all those
> includes with a single #include "vmlinux.h". You can disable CO-RE
> part with #define BPF_NO_PRESERVE_ACCESS_INDEX before vmlinux.h is
> included.
>

My application is supposed to run on every linux environment with kernel > =
4.14.
The only requirement from the user is having clang and kernel headers.
Is there a way to generate vmlinux.h from the given kernel headers?
From my understanding, vmlinux.h can only be generated from vmlinux
using bpftool,
but I don't want to require the users to supply vmlinux as well.

> But I'm a bit puzzled how your approach is going to work without CO-RE
> if you ever intend to run your program on more than one build of the
> kernel. Different kernel builds/versions might have different memory
> layouts of the structs you are relying on, so you'd need to compile
> them for each kernel build separately. So it's either CO-RE or
> on-the-host compilation (what BCC is doing). And if you are moving
> away from BCC, but not adopting CO-RE, I'm not sure how you are going
> to deal with that issue.
>

The idea is to compile the code once on the target node, then use the
created object file in subsequent runs.
Unlike bcc, which compiles the bpf code on every run,
with this approach, we "install" the application once, then the
program should run immediately without any further required
compilation
The end goal is to support CO-RE, after most distros will support it
out of the box, and the user won't have to supply vmlinux for the
program to work

>
> >
> > This is still WIP (the move to libbpf), and libbpf should be added as
> > a submodule to the project root
> >
> > > > Unfortunately, CO-RE is not (yet) an option.
> > > > I'm currently making the move from bcc to libbpf, and our applicati=
on
> > > > needs to support kernel 4.14, and work on all environments.
> > >
> > > Kernel version is not a big problem, it's vmlinux BTF availability
> > > that could be a problem. vmlinux BTF can be added into any version of
> > > kernel with pahole -J, post factum, but that assumes you have some
> > > control over how kernels are built and distributed, of course.
> > >
> > > >
> > > > > [...]
