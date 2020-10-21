Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2D0294AB5
	for <lists+bpf@lfdr.de>; Wed, 21 Oct 2020 11:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436518AbgJUJns (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Oct 2020 05:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409043AbgJUJnr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Oct 2020 05:43:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE8EC0613CE
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2020 02:43:46 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id h24so2233947ejg.9
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2020 02:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KLiNIgX251FgXrsbtrlNaZzuGlrVpBn41hZfRaEd3vM=;
        b=br9WuAvbkCdYTFusGjApUYiBoRnFVrtLeAAlmKvayRcjBWwQjF1RF45IjivbTH6PqL
         HvOO+2pNk03lz0AaElyxErgd2/7BdVv6cZimcJApeUB7O/oi57c3tSrowjGlFclmOdmE
         O8qVsDxXE6ouMxItk/HUS7HqNWsIC0CxjHL4cpy+hmpRXZH/vkfoUo6EerpJDnwEez/A
         q5/I902kFYZvzmucpI00VGzCc/O2VSnFiTzi6v8OXWNE0nzR9GDbE55+DjAVncYsdsn+
         u9zOYT88Pm0w2aiPQoy596oiZfk9EvKp0MQFLobNNLLZ78HPWuU2VSYTkabWGt5rCB+I
         yCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KLiNIgX251FgXrsbtrlNaZzuGlrVpBn41hZfRaEd3vM=;
        b=GARerBaU+zsKE1lrFPSaPK89fhCGQX29WyWcFwoKBqx/Owed/jUj5u3tHv9f6TT+Wv
         iU/QKSY10rehcQeokYGHpayWDZ4CBuElk7TCXNIgJ7Ad6+HRDKztTZ3TdckZgiy+lQ5R
         LfjziSKiH75iwjZJry7WqrqQzTOxClfME1TaoMWNcpnoJdNykDI6laME2AKjcdu85L2K
         +hs8YIS3LDIWg9rZbvPhSDmEWZFHG8qAB7Qvs1zTimhys9YsXSWrf7wAnW2mZ5FCkKug
         Cu7nVNGzTSxoqS6hIec9Rp3IbQEANDaVjr+O20yJXyNFuUpmTMsWGBr+MgY7iA9pmm59
         0qBw==
X-Gm-Message-State: AOAM532wIklERBYvrt/pVv9Zes7e0K7vtz7EdU5sSRH46P1SUbpvBdrE
        49V7++WCX6+O3R2lea4j4+3SgOD+gBGQeX1RjSs=
X-Google-Smtp-Source: ABdhPJxWXw46yYrH8h3xKc33q+RbZnTkEdntxk9T1UQCgvYyHsUnpPh0ga8XWQDmgS2E3nIzbtLsr/KxsbaPkSjXJZ8=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr2711268ejq.315.1603273424637;
 Wed, 21 Oct 2020 02:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net> <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net> <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
 <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net> <CAEf4Bza4KFJ_j7vmg-x_Zinp0PUM-zmWYHMq_y+2zWmX485sBQ@mail.gmail.com>
 <ece9975d-717c-a868-be51-c97aeae8e011@iogearbox.net> <CAEf4BzawvpsYybaOXf=GvJguiavC16BmdDeJfO4kEAR5naOKug@mail.gmail.com>
 <231e3e6b-0118-f600-05c5-f4e2f2c76129@fb.com> <CAMy7=ZWYn9MnmQJU7S_FUz5PArkGtVUcS1czn3oVCqa1aEniXw@mail.gmail.com>
 <322077f3-efea-8bd0-0b67-b4636428fc5a@iogearbox.net>
In-Reply-To: <322077f3-efea-8bd0-0b67-b4636428fc5a@iogearbox.net>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Wed, 21 Oct 2020 12:43:33 +0300
Message-ID: <CAMy7=ZVjYvMz2aFJxcPK5nK4L3AXZJPuVpQvPVk98ph8scpYEA@mail.gmail.com>
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=D7=
=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-22:58 =D7=9E=D7=90=D7=AA =
=E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
<=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On 10/9/20 9:33 PM, Yaniv Agman wrote:
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=
=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-22:08 =D7=9E=D7=90=D7=
=AA =E2=80=AAYonghong Song=E2=80=AC=E2=80=8F <=E2=80=AAyhs@fb.com=E2=80=AC=
=E2=80=8F>:=E2=80=AC
> >> On 10/9/20 11:59 AM, Andrii Nakryiko wrote:
> >>> On Fri, Oct 9, 2020 at 11:41 AM Daniel Borkmann <daniel@iogearbox.net=
> wrote:
> >>>> On 10/9/20 8:35 PM, Andrii Nakryiko wrote:
> >>>>> On Fri, Oct 9, 2020 at 11:21 AM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
> >>>>>> On 10/9/20 8:09 PM, Yaniv Agman wrote:
> >>>>>>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-20:39 =D7=9E=D7=
=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> >>>>>>> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> >>>>>>>>
> >>>>>>>> On 10/9/20 6:56 PM, Yaniv Agman wrote:
> >>>>>>>>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=
=9D =D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-19:27 =D7=9E=
=D7=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> >>>>>>>>> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> >>>>>>>>>>
> >>>>>>>>>> [ Cc +Yonghong ]
> >>>>>>>>>>
> >>>>>>>>>> On 10/9/20 6:05 PM, Yaniv Agman wrote:
> >>>>>>>>>>> Pulling the latest changes of libbpf and compiling my applica=
tion with it,
> >>>>>>>>>>> I see the following error:
> >>>>>>>>>>>
> >>>>>>>>>>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: erro=
r:
> >>>>>>>>>>> unknown register name 'r0' in asm
> >>>>>>>>>>>                            : "r0", "r1", "r2", "r3", "r4", "r=
5");
> >>>>>>>>>>>
> >>>>>>>>>>> The commit which introduced this change is:
> >>>>>>>>>>> 80c7838600d39891f274e2f7508b95a75e4227c1
> >>>>>>>>>>>
> >>>>>>>>>>> I'm not sure if I'm doing something wrong (missing include?),=
 or this
> >>>>>>>>>>> is a genuine error
> >>>>>>>>>>
> >>>>>>>>>> Seems like your clang/llvm version might be too old.
> >>>>>>>>>
> >>>>>>>>> I'm using clang 10.0.1
> >>>>>>>>
> >>>>>>>> Ah, okay, I see. Would this diff do the trick for you?
> >>>>>>>
> >>>>>>> Yes! Now it compiles without any problems!
> >>>>>>
> >>>>>> Great, thx, I'll cook proper fix and check with clang6 as Yonghong=
 mentioned.
> >>>>>
> >>>>> Am I the only one confused here?... Yonghong said it should be
> >>>>> supported as early as clang 6, Yaniv is using Clang 10 and is still
> >>>>> getting this error. Let's figure out what's the problem before addi=
ng
> >>>>> unnecessary checks.
> >>>>>
> >>>>> I think it's not the clang_major check that helped, rather __bpf__
> >>>>> check. So please hold off on the fix, let's get to the bottom of th=
is
> >>>>> first.
> >>>>
> >>>> I don't see confusion here (maybe other than which minimal clang/llv=
m version
> >>>> libbpf should support). If we do `#if __clang_major__ >=3D 6 && defi=
ned(__bpf__)`
> >>>> for the final patch, then this means that user passed clang -target =
bpf and
> >>>> the min supported version for inline assembly was there, otherwise w=
e fall back
> >>>> to bpf_tail_call. In Yaniv's case, he probably had native target wit=
h -emit-llvm
> >>>> and then used llc invocation.
> >>>
> >>> The "-emit-llvm" was the part that we were missing and had to figure
> >>> it out, before we could discuss the fix.
> >>
> >> Maybe Yaniv can confirm. I think the following properly happens.
> >>      - clang10 -O2 -g -S -emit-llvm t.c  // This is native compilation
> >> becasue some header files. Maybe some thing is guarded with x86 specif=
ic
> >> config's which is not available to -target bpf. This is mostly for
> >> tracing programs and Yanic mentions pt_regs which should be related
> >> to tracing.
> >>      - llc -march=3Dbpf t.ll
> >
> > Yes, like I said,  I do use --emit-llvm, and indeed have a tracing prog=
ram
> >
> >> So guarding the function with __bpf__ should be the one fixing this is=
sue.
> >>
> >> guard with clang version >=3D6 should not hurt and may prevent
> >> compilation failures if people use < 6 llvm with clang -target bpf.
> >> I think most people should already use newer llvm, but who knows.
>
> Yeah that was my thinking for those stuck for whatever reason on old LLVM=
.
>
> >>>>>>>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_hel=
pers.h
> >>>>>>>> index 2bdb7d6dbad2..31e356831fcf 100644
> >>>>>>>> --- a/tools/lib/bpf/bpf_helpers.h
> >>>>>>>> +++ b/tools/lib/bpf/bpf_helpers.h
> >>>>>>>> @@ -72,6 +72,7 @@
> >>>>>>>>       /*
> >>>>>>>>        * Helper function to perform a tail call with a constant/=
immediate map slot.
> >>>>>>>>        */
> >>>>>>>> +#if __clang_major__ >=3D 10 && defined(__bpf__)
> >>>>>>>>       static __always_inline void
> >>>>>>>>       bpf_tail_call_static(void *ctx, const void *map, const __u=
32 slot)
> >>>>>>>>       {
> >>>>>>>> @@ -98,6 +99,9 @@ bpf_tail_call_static(void *ctx, const void *ma=
p, const __u32 slot)
> >>>>>>>>                          :: [ctx]"r"(ctx), [map]"r"(map), [slot]=
"i"(slot)
> >>>>>>>>                          : "r0", "r1", "r2", "r3", "r4", "r5");
> >>>>>>>>       }
> >>>>>>>> +#else
> >>>>>>>> +# define bpf_tail_call_static  bpf_tail_call
> >>>
> >>> bpf_tail_call_static has very specific guarantees, so in cases where
> >>> we can't use inline assembly to satisfy those guarantees, I think we
> >>> should not just silently redefine bpf_tail_call_static as
> >>> bpf_tail_call, rather make compilation fail if someone is attempting
> >>> to use bpf_tail_call_static. _Static_assert could be used to provide =
a
> >>> better error message here, probably.
>
> Makes sense as well, I was mainly thinking if people include header files=
 in
> their project which are shared between tracing & non-tracing, so they com=
pile
> just fine, but I can see the point that wrt very specific guarantees, ful=
ly
> agree. In that sense we should just have it defined with the clang + __bp=
f__
> constraints mentioned earlier.
>
> Thanks,
> Daniel

Hi Daniel,

Is this change going to happen?
I'm still having a compilation error when using master branch

Thanks,
Yaniv
