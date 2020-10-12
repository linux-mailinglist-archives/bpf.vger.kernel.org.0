Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2F128C495
	for <lists+bpf@lfdr.de>; Tue, 13 Oct 2020 00:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbgJLWQ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Oct 2020 18:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388626AbgJLWQV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Oct 2020 18:16:21 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AEAC0613D0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 15:16:20 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id a2so14557635ybj.2
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 15:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eqYLMaaTKTrXYGz/JHseOwyJk+OyKs1w1UOQrfdLuJI=;
        b=eR0SH3gMEPCa7mGkZrscOKJNgdZkcbckT89/TpLOzBVRhPfXTBTOGD0jV+uCRYmiwW
         jfswnI5uYiZy+XdBsTVpWFdgmrVfWHyTtRqPaugorRsc1RP/r8vU8yTtcp7zThYLVrNo
         2RYW8eMPrgeoJjAVWEemzJzo7iMOQThIDAuJJDifiyOUasQd0R5xmLqj2wyOwqIXkM/o
         LgRgttjIO3s/V0im6hPuUblW6jkrDsRr2XGAXLV8tqslRMdWAqJT0vpM1TzUbsW5m1wh
         pWAdk4RK39o+50pcwY9NwYMzB2SCrEI35RwbtIIjprNnjLPVTp603HpFbceIg1fUkG7l
         zUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eqYLMaaTKTrXYGz/JHseOwyJk+OyKs1w1UOQrfdLuJI=;
        b=azi+dnbXL7+lpXn9ntujetY9jT+ox9xNclsmaQ415KrtG7Cc1BstTLyKgR41dwgwEo
         gRYg0xvfWT5+jLAt8abSSbCqwlz8B5zJs2uvGAcSmg04GoSTJLlYoeVp8t0mZlymC6X+
         Wa5p9iUPoU5QgKVzfMSgm7KXfFuPviX4Shee50kCPDPYm1lQmcP/swmHGcR4ba+m5Qda
         IFrZDOJiE+IhjELXIXH+9XewYXhV8FvJ8IhD3EGTXvK/bboP2dffaZVocawUjRsTpHAL
         jsAfOFKtlOUgLf+xo2VoSkB1clCBjx5Wgog+ayykahr6VZc/ZnZSB6ecx/cu9odRutqi
         jNRA==
X-Gm-Message-State: AOAM532I7Nf8S11RQWrd1rXCBaSwe26p6nldxa5wYBch0uintZyM/dZM
        1xBqwwPZAHzxrZGgbfF5aVLxDElR/1MXLPwX98U=
X-Google-Smtp-Source: ABdhPJwrTbtuSLVAoUNsZN8GwftL/rFJMIJ9CR+HowLNad+emZ2DwNXNA+0tzxrA/I/vNdUTNdkvsfF6Gzq2eq/0xKo=
X-Received: by 2002:a25:2687:: with SMTP id m129mr34574707ybm.425.1602540980029;
 Mon, 12 Oct 2020 15:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net> <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net> <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
 <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net> <CAMy7=ZW6B+aHN-3dAf7-=kK8WpMZ0NmEmeVh67jVPrjsryx9sQ@mail.gmail.com>
 <CAEf4BzYJQ_RZgy8YCPxfF+QEkx9W+jeu-3O3CX+vEqTFtOT2Fw@mail.gmail.com>
 <CAMy7=ZWhAzJP5m3QW0gHe4rVFoETT=zhCcyVeKBuTcO=ttC=MA@mail.gmail.com>
 <CAEf4Bzbm7D+ygkoCCoTy8OR0krVWosS_o13Gv4Xd2jhOSC5a7Q@mail.gmail.com>
 <CAMy7=ZWoaYkMCfAN4YLzO52Gms3haZn8=k9YBXPz9FxqHxuCFA@mail.gmail.com>
 <CAEf4BzbTs1T8AW8xiYU1KxtwxWhh6ieD7OLBm3k489-HErXDZw@mail.gmail.com> <CAMy7=ZV_URq=svstzN-BhOLeSzkQaTuzfJ2mT3UsERzSbgsqHQ@mail.gmail.com>
In-Reply-To: <CAMy7=ZV_URq=svstzN-BhOLeSzkQaTuzfJ2mT3UsERzSbgsqHQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Oct 2020 15:16:09 -0700
Message-ID: <CAEf4BzbshRMCX1T1ooAtYGYuUGefbbo2=ProkMg5iOtUKh3YtQ@mail.gmail.com>
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 12, 2020 at 2:49 PM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=
=D7=B3, 12 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-23:03 =D7=9E=D7=90=D7=
=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> >
> > On Fri, Oct 9, 2020 at 1:24 PM Yaniv Agman <yanivagman@gmail.com> wrote=
:
> > >
> > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-22:53 =D7=9E=D7=90=
=D7=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> > > <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > >
> > > > On Fri, Oct 9, 2020 at 12:32 PM Yaniv Agman <yanivagman@gmail.com> =
wrote:
> > > > >
> > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-21:39 =D7=9E=D7=
=90=D7=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> > > > > <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > > >
> > > > > > On Fri, Oct 9, 2020 at 11:33 AM Yaniv Agman <yanivagman@gmail.c=
om> wrote:
> > > > > > >
> > > > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=
=9D =D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-21:21 =D7=9E=
=D7=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > > > > > <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > > > > >
> > > > > > > > On 10/9/20 8:09 PM, Yaniv Agman wrote:
> > > > > > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=
=95=D7=9D =D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-20:39 =
=D7=9E=D7=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > > > > > > > <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=
=AC
> > > > > > > > >>
> > > > > > > > >> On 10/9/20 6:56 PM, Yaniv Agman wrote:
> > > > > > > > >>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=
=95=D7=9D =D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-19:27 =
=D7=9E=D7=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > > > > > > >>> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=
=80=AC
> > > > > > > > >>>>
> > > > > > > > >>>> [ Cc +Yonghong ]
> > > > > > > > >>>>
> > > > > > > > >>>> On 10/9/20 6:05 PM, Yaniv Agman wrote:
> > > > > > > > >>>>> Pulling the latest changes of libbpf and compiling my=
 application with it,
> > > > > > > > >>>>> I see the following error:
> > > > > > > > >>>>>
> > > > > > > > >>>>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:=
10: error:
> > > > > > > > >>>>> unknown register name 'r0' in asm
> > > > > > > > >>>>>                         : "r0", "r1", "r2", "r3", "r4=
", "r5");
> > > > > > > > >>>>>
> > > > > > > > >>>>> The commit which introduced this change is:
> > > > > > > > >>>>> 80c7838600d39891f274e2f7508b95a75e4227c1
> > > > > > > > >>>>>
> > > > > > > > >>>>> I'm not sure if I'm doing something wrong (missing in=
clude?), or this
> > > > > > > > >>>>> is a genuine error
> > > > > > > > >>>>
> > > > > > > > >>>> Seems like your clang/llvm version might be too old.
> > > > > > > > >>>
> > > > > > > > >>> I'm using clang 10.0.1
> > > > > > > > >>
> > > > > > > > >> Ah, okay, I see. Would this diff do the trick for you?
> > > > > > > > >
> > > > > > > > > Yes! Now it compiles without any problems!
> > > > > > > >
> > > > > > > > Great, thx, I'll cook proper fix and check with clang6 as Y=
onghong mentioned.
> > > > > > > >
> > > > > > >
> > > > > > > Thanks!
> > > > > > > Does this happen because I'm first compiling using "emit-llvm=
" and
> > > > > > > then using llc?
> > > > > >
> > > > > > So this must be the reason, but I'll wait for Yonghong to confi=
rm.
> > > > > >
> > > > > > > I wish I could use bpf target directly, but I'm then having p=
roblems
> > > > > > > with includes of asm code (like pt_regs and other stuff)
> > > > > >
> > > > > > Are you developing for a 32-bit platform? Or what exactly is th=
e
> > > > > > problem? I've been trying to solve problems for 32-bit arches r=
ecently
> > > > > > by making libbpf smarter, that relies on CO-RE though. Is CO-RE=
 an
> > > > > > option for you?
> > > > > >
> > > > >
> > > > > Examples for the errors I'm getting:
> > > > > /lib/modules/4.14.199-1-MANJARO/build/arch/x86/include/asm/atomic=
.h:177:9:
> > > > > error: invalid output constraint '+q' in asm
> > > > >         return xadd(&v->counter, i);
> > > > >                ^
> > > > > /lib/modules/4.14.199-1-MANJARO/build/arch/x86/include/asm/cmpxch=
g.h:234:25:
> > > > > note: expanded from macro 'xadd'
> > > > > #define xadd(ptr, inc)          __xadd((ptr), (inc), LOCK_PREFIX)
> > > > > ...
> > > > >
> > > > > From What I understood, this is a known issue for tracing program=
s
> > > > > (like the one I'm developing)
> > > >
> > > > We do have a bunch of selftests that use pt_regs and include, say,
> > > > linux/ptrace.h header. I wonder why we are not seeing these problem=
s.
> > > > Selftests, btw, are also built with -emit-llvm and then piping outp=
ut
> > > > to llc.
> > > >
> > > > So.. there must be something else going on. It's hard to guess like
> > > > this without seeing the code, but maybe -D__TARGET_ARCH_$(SRCARCH)
> > > > during compilation could help, just as an idea.
> > > >
> > >
> > > Adding -D__TARGET_ARCH_$(SRCARCH) doesn't seem to help.
> > > If you are interested in having a look at the code,
> > > The code (event_monitor_ebpf.c) including the makefile is here:
> > > https://github.com/yanivagman/tracee/tree/move_to_libbpf/tracee
> >
> > You are including a lot of kernel headers in that code. If any of them
> > pulls in some x86-specific stuff, you would get this problem. Try to
> > minimize the amount of includes you have there, maybe the issue will
> > go away.
> >
>
> I only added an include when I needed it, so I'm not sure I can remove
> any of them...
>
> > If not, one other way would be to generate vmlinux.h for your specific
> > kernel build. It will have memory layout of all the structs identical
> > to what you get from kernel headers. Then you can replace all those
> > includes with a single #include "vmlinux.h". You can disable CO-RE
> > part with #define BPF_NO_PRESERVE_ACCESS_INDEX before vmlinux.h is
> > included.
> >
>
> My application is supposed to run on every linux environment with kernel =
> 4.14.
> The only requirement from the user is having clang and kernel headers.
> Is there a way to generate vmlinux.h from the given kernel headers?

nope

> From my understanding, vmlinux.h can only be generated from vmlinux
> using bpftool,
> but I don't want to require the users to supply vmlinux as well.

you need either a vmlinux image or just .BTF binary section contents,
which you can extract with objdump. But either way, binary BTF data is
needed, bpftool won't parse/compile C headers to generate vmlinux.h.

>
> > But I'm a bit puzzled how your approach is going to work without CO-RE
> > if you ever intend to run your program on more than one build of the
> > kernel. Different kernel builds/versions might have different memory
> > layouts of the structs you are relying on, so you'd need to compile
> > them for each kernel build separately. So it's either CO-RE or
> > on-the-host compilation (what BCC is doing). And if you are moving
> > away from BCC, but not adopting CO-RE, I'm not sure how you are going
> > to deal with that issue.
> >
>
> The idea is to compile the code once on the target node, then use the
> created object file in subsequent runs.
> Unlike bcc, which compiles the bpf code on every run,
> with this approach, we "install" the application once, then the
> program should run immediately without any further required
> compilation

I see, so there is on-the-box compilation involved. If you can make
sure you have vmlinux with DWARF on each target box, you can generate
BTF on your own with pahole, I suppose. But vmlinux with DWARF becomes
another requirement that you might not be able to satisfy.

> The end goal is to support CO-RE, after most distros will support it
> out of the box, and the user won't have to supply vmlinux for the
> program to work
>
> >
> > >
> > > This is still WIP (the move to libbpf), and libbpf should be added as
> > > a submodule to the project root
> > >
> > > > > Unfortunately, CO-RE is not (yet) an option.
> > > > > I'm currently making the move from bcc to libbpf, and our applica=
tion
> > > > > needs to support kernel 4.14, and work on all environments.
> > > >
> > > > Kernel version is not a big problem, it's vmlinux BTF availability
> > > > that could be a problem. vmlinux BTF can be added into any version =
of
> > > > kernel with pahole -J, post factum, but that assumes you have some
> > > > control over how kernels are built and distributed, of course.
> > > >
> > > > >
> > > > > > [...]
