Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122D928C201
	for <lists+bpf@lfdr.de>; Mon, 12 Oct 2020 22:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgJLUDj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Oct 2020 16:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgJLUDj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Oct 2020 16:03:39 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DFDC0613D0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 13:03:39 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id a4so4952162ybq.13
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 13:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VjndCiWSKlYI0zqF6tf4aFLnqL6fn+yk6q8liLO/qTg=;
        b=DpN2yfLl68VvaBARVzQ4VBJnlAPhlXITAiETFv1oJCp5HPtCppGkpTQesyrndQWjM8
         ydvsf2CNMq4Eqry/D+P8MVXG2H1tC6mNTJOOMKbIC+DwixdS8kThoPyQpWscS4Tp3+iQ
         3zhjLMHnmerIn5m/x20WZX/GC064JHRbzU8WHdMY/EJy785vRd6EeF9KlfP6ATC4cRMi
         zuAI5jEg7UmPxToUw0iF75nwbAYUqSm7jVXI3n0xwQ7ashRWUizyW0jKXIpBXQoxUAxs
         U97EmqcYf+hnuqbgDJQVWfp4XiSEbxPRKaoZACsBHKoVYJfEu8mCKFPBKmes9em4nzo8
         8RCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VjndCiWSKlYI0zqF6tf4aFLnqL6fn+yk6q8liLO/qTg=;
        b=Rb04MwVYlUTbzJ8bD+eCtTDsop8d6T4l9Hg36k9WHNmOp0oHxsNMhM2B+Ywv/kWb4F
         E03Tm0foosFdZ/kQofcUnKzByYrHFmK7K+za9ze5ZYKHpWlgGB9Vd6uL0WhPC5N3p3aB
         g88ur2zgTIi1DzUs4JrHoNrJimAzdwWE98eBp4X0tGhCuaDHYqO90yn29JtRw3oodDV2
         cYMH5nry+By5sq9rPYeVIGpX7k+52EprK2ABEZI6lI0j5FZZjQzuc86zbcWeOEqHKEw2
         sFVckaoRj1DjQqt+0kKEj5t3+Hut3qGvsJyII2mBGFkn5fUlRkyXUkD0FIrlgQwtWONo
         Elcg==
X-Gm-Message-State: AOAM532gjKF8tIOChmwS7kLAVZ5dYmWdS4NoieQksnmvCY39NFp8fNQp
        a5+L3unLLJnC0ZCysySAxBWFxJXIaFdE8cuKV4E=
X-Google-Smtp-Source: ABdhPJwPsXzDYpLxMEVP04zHCnak+OzW3nWIeH8wDowdf7n+ABPrWHRSwd4dJX4QlEDUDgH2n3PV0LyUgkzmZ8pKjE4=
X-Received: by 2002:a25:8541:: with SMTP id f1mr31020871ybn.230.1602533018633;
 Mon, 12 Oct 2020 13:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net> <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net> <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
 <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net> <CAMy7=ZW6B+aHN-3dAf7-=kK8WpMZ0NmEmeVh67jVPrjsryx9sQ@mail.gmail.com>
 <CAEf4BzYJQ_RZgy8YCPxfF+QEkx9W+jeu-3O3CX+vEqTFtOT2Fw@mail.gmail.com>
 <CAMy7=ZWhAzJP5m3QW0gHe4rVFoETT=zhCcyVeKBuTcO=ttC=MA@mail.gmail.com>
 <CAEf4Bzbm7D+ygkoCCoTy8OR0krVWosS_o13Gv4Xd2jhOSC5a7Q@mail.gmail.com> <CAMy7=ZWoaYkMCfAN4YLzO52Gms3haZn8=k9YBXPz9FxqHxuCFA@mail.gmail.com>
In-Reply-To: <CAMy7=ZWoaYkMCfAN4YLzO52Gms3haZn8=k9YBXPz9FxqHxuCFA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Oct 2020 13:03:27 -0700
Message-ID: <CAEf4BzbTs1T8AW8xiYU1KxtwxWhh6ieD7OLBm3k489-HErXDZw@mail.gmail.com>
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 9, 2020 at 1:24 PM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=
=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-22:53 =D7=9E=D7=90=D7=
=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> >
> > On Fri, Oct 9, 2020 at 12:32 PM Yaniv Agman <yanivagman@gmail.com> wrot=
e:
> > >
> > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-21:39 =D7=9E=D7=90=
=D7=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> > > <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > >
> > > > On Fri, Oct 9, 2020 at 11:33 AM Yaniv Agman <yanivagman@gmail.com> =
wrote:
> > > > >
> > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-21:21 =D7=9E=D7=
=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > > > <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > > >
> > > > > > On 10/9/20 8:09 PM, Yaniv Agman wrote:
> > > > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=
=9D =D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-20:39 =D7=9E=
=D7=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > > > > > <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > > > >>
> > > > > > >> On 10/9/20 6:56 PM, Yaniv Agman wrote:
> > > > > > >>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=
=D7=9D =D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-19:27 =D7=
=9E=D7=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > > > > >>> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > > > >>>>
> > > > > > >>>> [ Cc +Yonghong ]
> > > > > > >>>>
> > > > > > >>>> On 10/9/20 6:05 PM, Yaniv Agman wrote:
> > > > > > >>>>> Pulling the latest changes of libbpf and compiling my app=
lication with it,
> > > > > > >>>>> I see the following error:
> > > > > > >>>>>
> > > > > > >>>>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: =
error:
> > > > > > >>>>> unknown register name 'r0' in asm
> > > > > > >>>>>                         : "r0", "r1", "r2", "r3", "r4", "=
r5");
> > > > > > >>>>>
> > > > > > >>>>> The commit which introduced this change is:
> > > > > > >>>>> 80c7838600d39891f274e2f7508b95a75e4227c1
> > > > > > >>>>>
> > > > > > >>>>> I'm not sure if I'm doing something wrong (missing includ=
e?), or this
> > > > > > >>>>> is a genuine error
> > > > > > >>>>
> > > > > > >>>> Seems like your clang/llvm version might be too old.
> > > > > > >>>
> > > > > > >>> I'm using clang 10.0.1
> > > > > > >>
> > > > > > >> Ah, okay, I see. Would this diff do the trick for you?
> > > > > > >
> > > > > > > Yes! Now it compiles without any problems!
> > > > > >
> > > > > > Great, thx, I'll cook proper fix and check with clang6 as Yongh=
ong mentioned.
> > > > > >
> > > > >
> > > > > Thanks!
> > > > > Does this happen because I'm first compiling using "emit-llvm" an=
d
> > > > > then using llc?
> > > >
> > > > So this must be the reason, but I'll wait for Yonghong to confirm.
> > > >
> > > > > I wish I could use bpf target directly, but I'm then having probl=
ems
> > > > > with includes of asm code (like pt_regs and other stuff)
> > > >
> > > > Are you developing for a 32-bit platform? Or what exactly is the
> > > > problem? I've been trying to solve problems for 32-bit arches recen=
tly
> > > > by making libbpf smarter, that relies on CO-RE though. Is CO-RE an
> > > > option for you?
> > > >
> > >
> > > Examples for the errors I'm getting:
> > > /lib/modules/4.14.199-1-MANJARO/build/arch/x86/include/asm/atomic.h:1=
77:9:
> > > error: invalid output constraint '+q' in asm
> > >         return xadd(&v->counter, i);
> > >                ^
> > > /lib/modules/4.14.199-1-MANJARO/build/arch/x86/include/asm/cmpxchg.h:=
234:25:
> > > note: expanded from macro 'xadd'
> > > #define xadd(ptr, inc)          __xadd((ptr), (inc), LOCK_PREFIX)
> > > ...
> > >
> > > From What I understood, this is a known issue for tracing programs
> > > (like the one I'm developing)
> >
> > We do have a bunch of selftests that use pt_regs and include, say,
> > linux/ptrace.h header. I wonder why we are not seeing these problems.
> > Selftests, btw, are also built with -emit-llvm and then piping output
> > to llc.
> >
> > So.. there must be something else going on. It's hard to guess like
> > this without seeing the code, but maybe -D__TARGET_ARCH_$(SRCARCH)
> > during compilation could help, just as an idea.
> >
>
> Adding -D__TARGET_ARCH_$(SRCARCH) doesn't seem to help.
> If you are interested in having a look at the code,
> The code (event_monitor_ebpf.c) including the makefile is here:
> https://github.com/yanivagman/tracee/tree/move_to_libbpf/tracee

You are including a lot of kernel headers in that code. If any of them
pulls in some x86-specific stuff, you would get this problem. Try to
minimize the amount of includes you have there, maybe the issue will
go away.

If not, one other way would be to generate vmlinux.h for your specific
kernel build. It will have memory layout of all the structs identical
to what you get from kernel headers. Then you can replace all those
includes with a single #include "vmlinux.h". You can disable CO-RE
part with #define BPF_NO_PRESERVE_ACCESS_INDEX before vmlinux.h is
included.

But I'm a bit puzzled how your approach is going to work without CO-RE
if you ever intend to run your program on more than one build of the
kernel. Different kernel builds/versions might have different memory
layouts of the structs you are relying on, so you'd need to compile
them for each kernel build separately. So it's either CO-RE or
on-the-host compilation (what BCC is doing). And if you are moving
away from BCC, but not adopting CO-RE, I'm not sure how you are going
to deal with that issue.


>
> This is still WIP (the move to libbpf), and libbpf should be added as
> a submodule to the project root
>
> > > Unfortunately, CO-RE is not (yet) an option.
> > > I'm currently making the move from bcc to libbpf, and our application
> > > needs to support kernel 4.14, and work on all environments.
> >
> > Kernel version is not a big problem, it's vmlinux BTF availability
> > that could be a problem. vmlinux BTF can be added into any version of
> > kernel with pahole -J, post factum, but that assumes you have some
> > control over how kernels are built and distributed, of course.
> >
> > >
> > > > [...]
