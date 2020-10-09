Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450262899AF
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 22:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733223AbgJIUYO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 16:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733021AbgJIUYO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 16:24:14 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C383C0613D2
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 13:24:13 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id t20so4403325edr.11
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 13:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+GE9zScZSZLF5D2QqwyjG1FVZG5slZ4dGGqFtfRYJow=;
        b=dIls7zFa5F++1M3s0/lHGbZVPXM5OLhy0IOiOgdZWHdpZdT16aax9eGfUfT65j7jNW
         LQK+NfaP7CjDbH1JTd1R9SiPJftoUafBgJWWX1rAxwxUb2LoCzqGa7ojLZbEjv5ro07L
         +ng7B5tjV1zscliUngSWBKwisjfHNQz38Oc2r+KFH+XwrudiDAZJh3r6fTpiZuv4Uegm
         9teeyageSIVWrC+kVZMuJU6XsWvBYd1966ay7ZZ0SUR2jmnkJNyOvFpWnRSqInS2PspD
         HOves9qhj3HN+dGy1/Fve3Pf9Bb6GCNdXlerywbwtlffqRZ2rzGv1sWt9RuHXJX+3ws5
         GKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+GE9zScZSZLF5D2QqwyjG1FVZG5slZ4dGGqFtfRYJow=;
        b=Mrv63F/JbNFB+uFTzvdu31tb+v2IAxsk1L5OLqvinBzIYOr3Ks4k1LK6Xsrlwi/lGh
         hK19HbQgodR1c97fv2Ly4MMx0QZIQov2Sjrl95WVemwswv+PgLJzZS2RKY0UTDATsTA+
         GVf/Ru+9c51v3UhLrMcm+eS6TLuzm5coXKp1pMEGxxU4LfY+zA3Rb6ClphE7jt3JQrlh
         ME0H39d1/+pj9zIFOMVWRXPHOqtlHp0aiClvmOgEpqS48Yk6ETV1BkRbj8FO4LtT0McY
         ERdpPz4264IxWAoBEvid2IEKpl9+zpmOrdxGWDezskyWbeL8TbWA/q2KvOU7Q7Fnu2x6
         HDpQ==
X-Gm-Message-State: AOAM532Jptc3ahsjtPKODKOz9UiBJhhoVYQ43cIPKJawzB8cttYeiA01
        SsJLeU+exmRG2HshoUqa9VykRt4dEMYQbm9z5Fg=
X-Google-Smtp-Source: ABdhPJz8GUIYAqIWW8uCDr6QzfJeXyQLGmS9kg2wDyxcma6aiYAAyo2dqv1YVkTMl2sOLkEgf43KO5LZ535/6dcARIo=
X-Received: by 2002:a05:6402:3c1:: with SMTP id t1mr984626edw.231.1602275052533;
 Fri, 09 Oct 2020 13:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net> <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net> <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
 <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net> <CAMy7=ZW6B+aHN-3dAf7-=kK8WpMZ0NmEmeVh67jVPrjsryx9sQ@mail.gmail.com>
 <CAEf4BzYJQ_RZgy8YCPxfF+QEkx9W+jeu-3O3CX+vEqTFtOT2Fw@mail.gmail.com>
 <CAMy7=ZWhAzJP5m3QW0gHe4rVFoETT=zhCcyVeKBuTcO=ttC=MA@mail.gmail.com> <CAEf4Bzbm7D+ygkoCCoTy8OR0krVWosS_o13Gv4Xd2jhOSC5a7Q@mail.gmail.com>
In-Reply-To: <CAEf4Bzbm7D+ygkoCCoTy8OR0krVWosS_o13Gv4Xd2jhOSC5a7Q@mail.gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Fri, 9 Oct 2020 23:24:01 +0300
Message-ID: <CAMy7=ZWoaYkMCfAN4YLzO52Gms3haZn8=k9YBXPz9FxqHxuCFA@mail.gmail.com>
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=D7=
=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-22:53 =D7=9E=D7=90=D7=AA =
=E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
<=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Fri, Oct 9, 2020 at 12:32 PM Yaniv Agman <yanivagman@gmail.com> wrote:
> >
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=
=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-21:39 =D7=9E=D7=90=D7=
=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> > <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > >
> > > On Fri, Oct 9, 2020 at 11:33 AM Yaniv Agman <yanivagman@gmail.com> wr=
ote:
> > > >
> > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-21:21 =D7=9E=D7=
=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > > <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > >
> > > > > On 10/9/20 8:09 PM, Yaniv Agman wrote:
> > > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=
=9D =D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-20:39 =D7=9E=
=D7=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > > > > <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > > >>
> > > > > >> On 10/9/20 6:56 PM, Yaniv Agman wrote:
> > > > > >>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=
=9D =D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-19:27 =D7=9E=
=D7=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > > > >>> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > > >>>>
> > > > > >>>> [ Cc +Yonghong ]
> > > > > >>>>
> > > > > >>>> On 10/9/20 6:05 PM, Yaniv Agman wrote:
> > > > > >>>>> Pulling the latest changes of libbpf and compiling my appli=
cation with it,
> > > > > >>>>> I see the following error:
> > > > > >>>>>
> > > > > >>>>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: er=
ror:
> > > > > >>>>> unknown register name 'r0' in asm
> > > > > >>>>>                         : "r0", "r1", "r2", "r3", "r4", "r5=
");
> > > > > >>>>>
> > > > > >>>>> The commit which introduced this change is:
> > > > > >>>>> 80c7838600d39891f274e2f7508b95a75e4227c1
> > > > > >>>>>
> > > > > >>>>> I'm not sure if I'm doing something wrong (missing include?=
), or this
> > > > > >>>>> is a genuine error
> > > > > >>>>
> > > > > >>>> Seems like your clang/llvm version might be too old.
> > > > > >>>
> > > > > >>> I'm using clang 10.0.1
> > > > > >>
> > > > > >> Ah, okay, I see. Would this diff do the trick for you?
> > > > > >
> > > > > > Yes! Now it compiles without any problems!
> > > > >
> > > > > Great, thx, I'll cook proper fix and check with clang6 as Yonghon=
g mentioned.
> > > > >
> > > >
> > > > Thanks!
> > > > Does this happen because I'm first compiling using "emit-llvm" and
> > > > then using llc?
> > >
> > > So this must be the reason, but I'll wait for Yonghong to confirm.
> > >
> > > > I wish I could use bpf target directly, but I'm then having problem=
s
> > > > with includes of asm code (like pt_regs and other stuff)
> > >
> > > Are you developing for a 32-bit platform? Or what exactly is the
> > > problem? I've been trying to solve problems for 32-bit arches recentl=
y
> > > by making libbpf smarter, that relies on CO-RE though. Is CO-RE an
> > > option for you?
> > >
> >
> > Examples for the errors I'm getting:
> > /lib/modules/4.14.199-1-MANJARO/build/arch/x86/include/asm/atomic.h:177=
:9:
> > error: invalid output constraint '+q' in asm
> >         return xadd(&v->counter, i);
> >                ^
> > /lib/modules/4.14.199-1-MANJARO/build/arch/x86/include/asm/cmpxchg.h:23=
4:25:
> > note: expanded from macro 'xadd'
> > #define xadd(ptr, inc)          __xadd((ptr), (inc), LOCK_PREFIX)
> > ...
> >
> > From What I understood, this is a known issue for tracing programs
> > (like the one I'm developing)
>
> We do have a bunch of selftests that use pt_regs and include, say,
> linux/ptrace.h header. I wonder why we are not seeing these problems.
> Selftests, btw, are also built with -emit-llvm and then piping output
> to llc.
>
> So.. there must be something else going on. It's hard to guess like
> this without seeing the code, but maybe -D__TARGET_ARCH_$(SRCARCH)
> during compilation could help, just as an idea.
>

Adding -D__TARGET_ARCH_$(SRCARCH) doesn't seem to help.
If you are interested in having a look at the code,
The code (event_monitor_ebpf.c) including the makefile is here:
https://github.com/yanivagman/tracee/tree/move_to_libbpf/tracee

This is still WIP (the move to libbpf), and libbpf should be added as
a submodule to the project root

> > Unfortunately, CO-RE is not (yet) an option.
> > I'm currently making the move from bcc to libbpf, and our application
> > needs to support kernel 4.14, and work on all environments.
>
> Kernel version is not a big problem, it's vmlinux BTF availability
> that could be a problem. vmlinux BTF can be added into any version of
> kernel with pahole -J, post factum, but that assumes you have some
> control over how kernels are built and distributed, of course.
>
> >
> > > [...]
