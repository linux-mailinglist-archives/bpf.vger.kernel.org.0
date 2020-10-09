Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728A02891C0
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 21:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390623AbgJITcc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 15:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388639AbgJITcb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 15:32:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDB4C0613D2
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 12:32:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p15so14700624ejm.7
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 12:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z8tzmW3tEEl4LWjCU0NlhQ1/o6AqbQ7QB2eHzwb4ewI=;
        b=mXoZsVlEbAwitEGSly25LeLBYDk3t1WiBY/jPNrK+Xxm9YfSL+an0CmjwxyOVjJ8HV
         9bsV0gJ40GEa7HNQESSPXfo8lu/FTQeQF/rmHHdYQ4VhCQKmInSx653/dV+ypH5yjj/y
         Ax2fhRv6tzBBYUxdF9Y+qkcHzr716B6OlOPPvIoBUrLrdqKKyWHDJYmJ792yVy0psK5v
         ISvMiqkyVW4vc9+xNX1inTr7OtE4PJZZ672OOWtMUPrH6wwSbu+nSvKnN4uFBDlRzpWA
         d7V/vAzLwj0LWa9yNRTeo64arKqW40fNf6zc6Q7C/VAkPHuBGNZhpOS0jB++fhMkSOQX
         aiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z8tzmW3tEEl4LWjCU0NlhQ1/o6AqbQ7QB2eHzwb4ewI=;
        b=S/hulRLIbqZniO0uSACXRLOPpkBNgWt2xLHB9YvOhdxj/ZA/z+OS6qz5uL+Aq2snnb
         oGaonaH1itDTriSqKoIk3QVl+8btv+6Ef/8XvDC36+THvFzKQieoNzyR16AEo0G2+s8e
         4JVvAD5QzMSFjUT8B1mPikkOdQH0hlF0xpSoJ4eB4KKnAcXnWbIipy0aCP4sGHuUKW6K
         hO7DHCi5tFjlCs0SRz5x73/uqyW3vJUm6BmfWHj1FllSukssme+JM3f9RABaWr/DqAvO
         H65SggGdkjvgbXFMS4Jfw/Q0esMuVqamnTfCrUtUbC8ZbDs5r3t5p6ckP9GIq2kmInaA
         kayg==
X-Gm-Message-State: AOAM530DklXDkvFNWCkfeAqsHOyM+MCXLQIkuYVBXKg8JWvUlV24+azn
        FRm6SV9NJeCPOAficRczrd58X2dl3tDLrV2yca8=
X-Google-Smtp-Source: ABdhPJwG7kN0Sf4uWTSRNGomshyNmcRfxtBNBEHb1ZZ53DRiheqlw22ZoPeXfm5gQpRWhfzoq8fQxYl8lxmA1w2/ksI=
X-Received: by 2002:a17:906:6d89:: with SMTP id h9mr15378987ejt.152.1602271947764;
 Fri, 09 Oct 2020 12:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net> <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net> <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
 <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net> <CAMy7=ZW6B+aHN-3dAf7-=kK8WpMZ0NmEmeVh67jVPrjsryx9sQ@mail.gmail.com>
 <CAEf4BzYJQ_RZgy8YCPxfF+QEkx9W+jeu-3O3CX+vEqTFtOT2Fw@mail.gmail.com>
In-Reply-To: <CAEf4BzYJQ_RZgy8YCPxfF+QEkx9W+jeu-3O3CX+vEqTFtOT2Fw@mail.gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Fri, 9 Oct 2020 22:32:16 +0300
Message-ID: <CAMy7=ZWhAzJP5m3QW0gHe4rVFoETT=zhCcyVeKBuTcO=ttC=MA@mail.gmail.com>
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
=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-21:39 =D7=9E=D7=90=D7=AA =
=E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
<=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Fri, Oct 9, 2020 at 11:33 AM Yaniv Agman <yanivagman@gmail.com> wrote:
> >
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=
=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-21:21 =D7=9E=D7=90=D7=
=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > >
> > > On 10/9/20 8:09 PM, Yaniv Agman wrote:
> > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-20:39 =D7=9E=D7=
=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > > <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > >>
> > > >> On 10/9/20 6:56 PM, Yaniv Agman wrote:
> > > >>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-19:27 =D7=9E=D7=
=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > > >>> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > >>>>
> > > >>>> [ Cc +Yonghong ]
> > > >>>>
> > > >>>> On 10/9/20 6:05 PM, Yaniv Agman wrote:
> > > >>>>> Pulling the latest changes of libbpf and compiling my applicati=
on with it,
> > > >>>>> I see the following error:
> > > >>>>>
> > > >>>>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: error:
> > > >>>>> unknown register name 'r0' in asm
> > > >>>>>                         : "r0", "r1", "r2", "r3", "r4", "r5");
> > > >>>>>
> > > >>>>> The commit which introduced this change is:
> > > >>>>> 80c7838600d39891f274e2f7508b95a75e4227c1
> > > >>>>>
> > > >>>>> I'm not sure if I'm doing something wrong (missing include?), o=
r this
> > > >>>>> is a genuine error
> > > >>>>
> > > >>>> Seems like your clang/llvm version might be too old.
> > > >>>
> > > >>> I'm using clang 10.0.1
> > > >>
> > > >> Ah, okay, I see. Would this diff do the trick for you?
> > > >
> > > > Yes! Now it compiles without any problems!
> > >
> > > Great, thx, I'll cook proper fix and check with clang6 as Yonghong me=
ntioned.
> > >
> >
> > Thanks!
> > Does this happen because I'm first compiling using "emit-llvm" and
> > then using llc?
>
> So this must be the reason, but I'll wait for Yonghong to confirm.
>
> > I wish I could use bpf target directly, but I'm then having problems
> > with includes of asm code (like pt_regs and other stuff)
>
> Are you developing for a 32-bit platform? Or what exactly is the
> problem? I've been trying to solve problems for 32-bit arches recently
> by making libbpf smarter, that relies on CO-RE though. Is CO-RE an
> option for you?
>

Examples for the errors I'm getting:
/lib/modules/4.14.199-1-MANJARO/build/arch/x86/include/asm/atomic.h:177:9:
error: invalid output constraint '+q' in asm
        return xadd(&v->counter, i);
               ^
/lib/modules/4.14.199-1-MANJARO/build/arch/x86/include/asm/cmpxchg.h:234:25=
:
note: expanded from macro 'xadd'
#define xadd(ptr, inc)          __xadd((ptr), (inc), LOCK_PREFIX)
...

From What I understood, this is a known issue for tracing programs
(like the one I'm developing)
Unfortunately, CO-RE is not (yet) an option.
I'm currently making the move from bcc to libbpf, and our application
needs to support kernel 4.14, and work on all environments.

> [...]
