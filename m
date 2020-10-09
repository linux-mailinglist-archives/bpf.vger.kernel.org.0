Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C78B28953C
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 21:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbgJITzi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 15:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390962AbgJITx6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 15:53:58 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DDBC0613D2
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 12:53:58 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id h9so8120147ybm.4
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 12:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9hrhhQq0TGvVEuCaQjlYPROV9f7jjnGTug3ix+D8ERM=;
        b=dmujTgDSqPgDZR3Y8GBYQ2rsVMkEMmYj/vJbD2snPJVopEqXey/v2DY/b4ZjzLSgVk
         /MkkhK+6o/3SHCwiPcn9N7ORNfl9DYLHoTPou6pGWBVLFGLJA8uzprSH0zZWq+nlLWZ0
         gfi+Sq4eMpDcNi6QdR5SECUstXDCJEDtvT8Gwc6rCjfXIDcdk4xwdsBhtQYEKrHlc7mh
         Ahq5LS2WleyWP5cyBvJY+vwKFUPFkxGIcOKb5wJHzigbrOooLTKPzhiKRIU4oKffR0lZ
         /8H4l92xhg6EhEE0YxIXe3w1jK8sG209SFSE7vNUJ9W6CwDWGNloBrxS+TsLC5W7UEVm
         fzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9hrhhQq0TGvVEuCaQjlYPROV9f7jjnGTug3ix+D8ERM=;
        b=mwm5l2naDEOT0kGm/Em9fF0gydpn0i4Ul1bV5vZFMa1RZtznJk2URvaagM/CTW5ccY
         KN4Axrm3eWmJmf9BbucTRF+59RBfRVtBL4KjRIK/OOkULNxCP5nNMS9haVotIee3dRHP
         re61NcErmLNGaZJcmokyJuCKX/om9ZT6Im48tDSZi3rR4Lbhjdxl4ACTaulSJE5OcgKU
         L//e3xbGIRW9FKKPzyUmb7SaKt8YES02O8HiNr5we7WDUE1kzU3+odQ4EY9hm+7RLeDC
         VXiJBrRRqVcWdCei6EtnMKE7IEd20JzxFNL/6Pu0gGjBpguI6XTdsiQDyr4ceT6Fshah
         o6sQ==
X-Gm-Message-State: AOAM532VlIztvmCWkJn+B5ZRwXf1p2BZZWNjVc/UgO4v0YS9Me8cTiC0
        dXvzkC3LYgN26zjt3jaxMJOBvPiWme8TBG3Irro=
X-Google-Smtp-Source: ABdhPJzTupNyCpotIbxl++ljdq4IKKt3HeiECiEDP0/79kDSsY0dvtczGHPOgZl6hpwv2aJHNzGf/O1cXATsb0f+lZ4=
X-Received: by 2002:a25:8541:: with SMTP id f1mr17868249ybn.230.1602273237716;
 Fri, 09 Oct 2020 12:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net> <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net> <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
 <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net> <CAMy7=ZW6B+aHN-3dAf7-=kK8WpMZ0NmEmeVh67jVPrjsryx9sQ@mail.gmail.com>
 <CAEf4BzYJQ_RZgy8YCPxfF+QEkx9W+jeu-3O3CX+vEqTFtOT2Fw@mail.gmail.com> <CAMy7=ZWhAzJP5m3QW0gHe4rVFoETT=zhCcyVeKBuTcO=ttC=MA@mail.gmail.com>
In-Reply-To: <CAMy7=ZWhAzJP5m3QW0gHe4rVFoETT=zhCcyVeKBuTcO=ttC=MA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Oct 2020 12:53:46 -0700
Message-ID: <CAEf4Bzbm7D+ygkoCCoTy8OR0krVWosS_o13Gv4Xd2jhOSC5a7Q@mail.gmail.com>
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 9, 2020 at 12:32 PM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=
=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-21:39 =D7=9E=D7=90=D7=
=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> >
> > On Fri, Oct 9, 2020 at 11:33 AM Yaniv Agman <yanivagman@gmail.com> wrot=
e:
> > >
> > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-21:21 =D7=9E=D7=90=
=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > >
> > > > On 10/9/20 8:09 PM, Yaniv Agman wrote:
> > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-20:39 =D7=9E=D7=
=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > > > <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > >>
> > > > >> On 10/9/20 6:56 PM, Yaniv Agman wrote:
> > > > >>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=
=9D =D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-19:27 =D7=9E=
=D7=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > > >>> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > >>>>
> > > > >>>> [ Cc +Yonghong ]
> > > > >>>>
> > > > >>>> On 10/9/20 6:05 PM, Yaniv Agman wrote:
> > > > >>>>> Pulling the latest changes of libbpf and compiling my applica=
tion with it,
> > > > >>>>> I see the following error:
> > > > >>>>>
> > > > >>>>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: erro=
r:
> > > > >>>>> unknown register name 'r0' in asm
> > > > >>>>>                         : "r0", "r1", "r2", "r3", "r4", "r5")=
;
> > > > >>>>>
> > > > >>>>> The commit which introduced this change is:
> > > > >>>>> 80c7838600d39891f274e2f7508b95a75e4227c1
> > > > >>>>>
> > > > >>>>> I'm not sure if I'm doing something wrong (missing include?),=
 or this
> > > > >>>>> is a genuine error
> > > > >>>>
> > > > >>>> Seems like your clang/llvm version might be too old.
> > > > >>>
> > > > >>> I'm using clang 10.0.1
> > > > >>
> > > > >> Ah, okay, I see. Would this diff do the trick for you?
> > > > >
> > > > > Yes! Now it compiles without any problems!
> > > >
> > > > Great, thx, I'll cook proper fix and check with clang6 as Yonghong =
mentioned.
> > > >
> > >
> > > Thanks!
> > > Does this happen because I'm first compiling using "emit-llvm" and
> > > then using llc?
> >
> > So this must be the reason, but I'll wait for Yonghong to confirm.
> >
> > > I wish I could use bpf target directly, but I'm then having problems
> > > with includes of asm code (like pt_regs and other stuff)
> >
> > Are you developing for a 32-bit platform? Or what exactly is the
> > problem? I've been trying to solve problems for 32-bit arches recently
> > by making libbpf smarter, that relies on CO-RE though. Is CO-RE an
> > option for you?
> >
>
> Examples for the errors I'm getting:
> /lib/modules/4.14.199-1-MANJARO/build/arch/x86/include/asm/atomic.h:177:9=
:
> error: invalid output constraint '+q' in asm
>         return xadd(&v->counter, i);
>                ^
> /lib/modules/4.14.199-1-MANJARO/build/arch/x86/include/asm/cmpxchg.h:234:=
25:
> note: expanded from macro 'xadd'
> #define xadd(ptr, inc)          __xadd((ptr), (inc), LOCK_PREFIX)
> ...
>
> From What I understood, this is a known issue for tracing programs
> (like the one I'm developing)

We do have a bunch of selftests that use pt_regs and include, say,
linux/ptrace.h header. I wonder why we are not seeing these problems.
Selftests, btw, are also built with -emit-llvm and then piping output
to llc.

So.. there must be something else going on. It's hard to guess like
this without seeing the code, but maybe -D__TARGET_ARCH_$(SRCARCH)
during compilation could help, just as an idea.

> Unfortunately, CO-RE is not (yet) an option.
> I'm currently making the move from bcc to libbpf, and our application
> needs to support kernel 4.14, and work on all environments.

Kernel version is not a big problem, it's vmlinux BTF availability
that could be a problem. vmlinux BTF can be added into any version of
kernel with pahole -J, post factum, but that assumes you have some
control over how kernels are built and distributed, of course.

>
> > [...]
