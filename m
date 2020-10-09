Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37DC289182
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 20:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbgJIS7r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 14:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732834AbgJIS7q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 14:59:46 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA876C0613D2
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 11:59:46 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id j76so8018381ybg.3
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 11:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vmSPfEnVh8pI8BRP1LL/pSZMJD9BEBlGlqJYoJKwzMU=;
        b=F3zAf2gWw0p5hZdLUPIrN4T56m6xOMZ/Oq2hiXmS1HsXe6Ah4pA0X1oe/v3IsGjhjB
         nmuC9K6oSmX/JoVTEZyGYmhHyPChFhi2PcHuJw6RnzgJIYKUF0+qe9u3A+U9ZupeSqXg
         8j1Pq1U+IN4bEpYyLO9V5iKWY+dxniPnJFR2dB1Njo8F7gWlVhVByb9PvwVT8ZFA7n/6
         Zg6J+1e8qhMEqT46kV1jfYJg+YwHSd/We238rvPi/TI6cyFdumGRf6ZnSafTMKLvWCDT
         XAKz6wQFvEkqSVKjcAYUi93LRaH7ADK2duweDJe8i7bq80TYZCMPNXKG51NpuokUQMME
         /Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vmSPfEnVh8pI8BRP1LL/pSZMJD9BEBlGlqJYoJKwzMU=;
        b=d54DJGNw7ER+UUI6AZWUFl4Xv/mD3NHrq2QhdaaWyj427/8Bekx/hD+Adg9e7DbG1L
         E1KXfh/PIW5STRrWllbe52+9CGjO0gH3ugPIW8XkQBTGgXvW+seG2JZVvZAn8Ei62CIx
         uo9fk79+GqFG5N08vhZJoHiKNdXEZa33sI8KYURSu1gQRL5XC+Ho1l/B1dEDEFwdbvKF
         gu0tiBhzZV4LtZchFtnpWg5m3wPR7YqCwPzIPlUUrWY1vQXXF7NLLbR+Wk3gsugkBsyY
         mezNvDG8MY7fMV19ZoKaXpJAo/kZMC95WO3k0ZVtEwaO+ZcnvI9FYoidu2AQ5U0uFGkO
         9IvA==
X-Gm-Message-State: AOAM533DY/yqMxxFxexDqVcZVgkM7HbO1KxoX2qTGt2SMT5ncLbWDr0S
        IdM/3rcik/xqLuAwippjP+i1goTvdgh5pXqyGJE=
X-Google-Smtp-Source: ABdhPJyF9qGxuuAK3be/Eg4B28ZnZO81IUD2i4/J/FboamPYQRNHixiCV7az7hRE/KZtwhKD6FS19qr84DbF/KPc304=
X-Received: by 2002:a25:b0d:: with SMTP id 13mr10806267ybl.347.1602269985767;
 Fri, 09 Oct 2020 11:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net> <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net> <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
 <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net> <CAEf4Bza4KFJ_j7vmg-x_Zinp0PUM-zmWYHMq_y+2zWmX485sBQ@mail.gmail.com>
 <ece9975d-717c-a868-be51-c97aeae8e011@iogearbox.net>
In-Reply-To: <ece9975d-717c-a868-be51-c97aeae8e011@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Oct 2020 11:59:34 -0700
Message-ID: <CAEf4BzawvpsYybaOXf=GvJguiavC16BmdDeJfO4kEAR5naOKug@mail.gmail.com>
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Yaniv Agman <yanivagman@gmail.com>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 9, 2020 at 11:41 AM Daniel Borkmann <daniel@iogearbox.net> wrot=
e:
>
> On 10/9/20 8:35 PM, Andrii Nakryiko wrote:
> > On Fri, Oct 9, 2020 at 11:21 AM Daniel Borkmann <daniel@iogearbox.net> =
wrote:
> >> On 10/9/20 8:09 PM, Yaniv Agman wrote:
> >>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-20:39 =D7=9E=D7=90=
=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> >>> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> >>>>
> >>>> On 10/9/20 6:56 PM, Yaniv Agman wrote:
> >>>>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-19:27 =D7=9E=D7=
=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> >>>>> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> >>>>>>
> >>>>>> [ Cc +Yonghong ]
> >>>>>>
> >>>>>> On 10/9/20 6:05 PM, Yaniv Agman wrote:
> >>>>>>> Pulling the latest changes of libbpf and compiling my application=
 with it,
> >>>>>>> I see the following error:
> >>>>>>>
> >>>>>>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: error:
> >>>>>>> unknown register name 'r0' in asm
> >>>>>>>                          : "r0", "r1", "r2", "r3", "r4", "r5");
> >>>>>>>
> >>>>>>> The commit which introduced this change is:
> >>>>>>> 80c7838600d39891f274e2f7508b95a75e4227c1
> >>>>>>>
> >>>>>>> I'm not sure if I'm doing something wrong (missing include?), or =
this
> >>>>>>> is a genuine error
> >>>>>>
> >>>>>> Seems like your clang/llvm version might be too old.
> >>>>>
> >>>>> I'm using clang 10.0.1
> >>>>
> >>>> Ah, okay, I see. Would this diff do the trick for you?
> >>>
> >>> Yes! Now it compiles without any problems!
> >>
> >> Great, thx, I'll cook proper fix and check with clang6 as Yonghong men=
tioned.
> >
> > Am I the only one confused here?... Yonghong said it should be
> > supported as early as clang 6, Yaniv is using Clang 10 and is still
> > getting this error. Let's figure out what's the problem before adding
> > unnecessary checks.
> >
> > I think it's not the clang_major check that helped, rather __bpf__
> > check. So please hold off on the fix, let's get to the bottom of this
> > first.
>
> I don't see confusion here (maybe other than which minimal clang/llvm ver=
sion
> libbpf should support). If we do `#if __clang_major__ >=3D 6 && defined(_=
_bpf__)`
> for the final patch, then this means that user passed clang -target bpf a=
nd
> the min supported version for inline assembly was there, otherwise we fal=
l back
> to bpf_tail_call. In Yaniv's case, he probably had native target with -em=
it-llvm
> and then used llc invocation.

The "-emit-llvm" was the part that we were missing and had to figure
it out, before we could discuss the fix.

>
> >>>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers=
.h
> >>>> index 2bdb7d6dbad2..31e356831fcf 100644
> >>>> --- a/tools/lib/bpf/bpf_helpers.h
> >>>> +++ b/tools/lib/bpf/bpf_helpers.h
> >>>> @@ -72,6 +72,7 @@
> >>>>     /*
> >>>>      * Helper function to perform a tail call with a constant/immedi=
ate map slot.
> >>>>      */
> >>>> +#if __clang_major__ >=3D 10 && defined(__bpf__)
> >>>>     static __always_inline void
> >>>>     bpf_tail_call_static(void *ctx, const void *map, const __u32 slo=
t)
> >>>>     {
> >>>> @@ -98,6 +99,9 @@ bpf_tail_call_static(void *ctx, const void *map, c=
onst __u32 slot)
> >>>>                        :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(sl=
ot)
> >>>>                        : "r0", "r1", "r2", "r3", "r4", "r5");
> >>>>     }
> >>>> +#else
> >>>> +# define bpf_tail_call_static  bpf_tail_call

bpf_tail_call_static has very specific guarantees, so in cases where
we can't use inline assembly to satisfy those guarantees, I think we
should not just silently redefine bpf_tail_call_static as
bpf_tail_call, rather make compilation fail if someone is attempting
to use bpf_tail_call_static. _Static_assert could be used to provide a
better error message here, probably.

> >>>> +#endif /* __clang_major__ >=3D 10 && __bpf__ */
> >>>>
> >>>>     /*
> >>>>      * Helper structure used by eBPF C program
> >>
>
