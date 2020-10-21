Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29BC295300
	for <lists+bpf@lfdr.de>; Wed, 21 Oct 2020 21:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505001AbgJUTeK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Oct 2020 15:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505000AbgJUTeK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Oct 2020 15:34:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AF4C0613CE
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2020 12:34:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v19so3719795edx.9
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2020 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2NJtQ9GZugLDbw/a1HPP6/pljp0ferlo6GBdWNCHNso=;
        b=u67JYbATMDunUQR1j/j1v8hztYPucEd530dbVmDShpgRmGDWMFl/HoXR3whsQOAmUf
         M9i901/nshuq9qWdi2OmCJKF5Um1xAv7u0Zat2sYJYv2xRjq36fO5Bg/he9KSEvm3z8Q
         bXEK6df5gVOg/uPBDsBi67sgo2m50Gt7W2Uw+Lk9dXU3I6oRub2LIAhdOkZJ/DszmHh4
         AfU8Km33LGmA+TgNnbhsC2JORf8RG4zL/qSSQxuZv34Y2F0fLSMQdgfviwE1Ux42UwZg
         7LuAhUtZ5nQjVh7i697wrXl0NFYbiANlmnkPfHKWHr/JXHXdgX8L8suQZjrTWW0XzMRd
         +aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2NJtQ9GZugLDbw/a1HPP6/pljp0ferlo6GBdWNCHNso=;
        b=C/Faz9sCYlu722V+Omh0jxM16Q8tw2GO1QprY26XnrekwTC6deeK4tP3YZKblx4wqR
         UI9tbph9WHoYlkE3HuOyKVTO/AAIdg5Mwt33DZpXiXfeq1HaXag/o9ZBIAaiCf5yRxkP
         yKsfDco1JcR5snmYTrDLWag3YWevHgC8GCL+JKKVREwuGDF0NHdOd82F5Kr6FOAoq6xy
         TJDcBkFOXWKp/fXRF6gPy6IrtaIjhrxlzEg85m8wkpHBBhShvKMSZD9VWzbEhB67i8Sw
         issUO88DbK89i0nRVpZTdVRcLBTruDRgrWj917H9x3PxZqrmvi8waNQG0tQkweM6/Dle
         jEMg==
X-Gm-Message-State: AOAM530zoTwxWwWWB9nMYgSKlSaNMUi4ELkDp4njPEGd6vmp+l9VVHnC
        KyMtXOqqT4gIMRDY+f5LvLsWVj84XJuH4LbfbV0=
X-Google-Smtp-Source: ABdhPJwDtJBAW+UbQZQRfYjCZdklGNBTvYoO6VlTIHb/9iuufe/CnRBHeO9zpYqzyHkxogxiW24yQ86UnFIJEHbSsBc=
X-Received: by 2002:a50:d642:: with SMTP id c2mr4791908edj.342.1603308848655;
 Wed, 21 Oct 2020 12:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net> <CAMy7=ZXjna6q53h0uuar58fmAMi026w7u=ciVjTQXK2OHiOPJg@mail.gmail.com>
 <fadd5bd2-ed87-7e6b-d4bd-a802eb9ef6f8@iogearbox.net> <CAMy7=ZV5pZzzs_vuqn1eqEe9tBjgmQHT=hv0CXhgxYrjO_8wZg@mail.gmail.com>
 <e385d737-1a4b-a1b6-9a2e-23a71d2ca1b7@iogearbox.net> <CAEf4Bza4KFJ_j7vmg-x_Zinp0PUM-zmWYHMq_y+2zWmX485sBQ@mail.gmail.com>
 <ece9975d-717c-a868-be51-c97aeae8e011@iogearbox.net> <CAEf4BzawvpsYybaOXf=GvJguiavC16BmdDeJfO4kEAR5naOKug@mail.gmail.com>
 <231e3e6b-0118-f600-05c5-f4e2f2c76129@fb.com> <CAMy7=ZWYn9MnmQJU7S_FUz5PArkGtVUcS1czn3oVCqa1aEniXw@mail.gmail.com>
 <322077f3-efea-8bd0-0b67-b4636428fc5a@iogearbox.net> <CAMy7=ZVjYvMz2aFJxcPK5nK4L3AXZJPuVpQvPVk98ph8scpYEA@mail.gmail.com>
 <b18125f2-ae98-9ca1-a9c9-099262b8a388@iogearbox.net>
In-Reply-To: <b18125f2-ae98-9ca1-a9c9-099262b8a388@iogearbox.net>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Wed, 21 Oct 2020 22:33:57 +0300
Message-ID: <CAMy7=ZWkZ-pYBvPgqEsch7SHpuX68BqWLkG7QWARUBF3BBCE=w@mail.gmail.com>
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

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=93=D7=
=B3, 21 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-20:18 =D7=9E=D7=90=D7=AA=
 =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
<=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On 10/21/20 11:43 AM, Yaniv Agman wrote:
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=
=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-22:58 =D7=9E=D7=90=D7=
=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> > <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> >> On 10/9/20 9:33 PM, Yaniv Agman wrote:
> >>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-22:08 =D7=9E=D7=90=
=D7=AA =E2=80=AAYonghong Song=E2=80=AC=E2=80=8F <=E2=80=AAyhs@fb.com=E2=80=
=AC=E2=80=8F>:=E2=80=AC
> >>>> On 10/9/20 11:59 AM, Andrii Nakryiko wrote:
> >>>>> On Fri, Oct 9, 2020 at 11:41 AM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
> >>>>>> On 10/9/20 8:35 PM, Andrii Nakryiko wrote:
> >>>>>>> On Fri, Oct 9, 2020 at 11:21 AM Daniel Borkmann <daniel@iogearbox=
.net> wrote:
> >>>>>>>> On 10/9/20 8:09 PM, Yaniv Agman wrote:
> >>>>>>>>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=
=9D =D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-20:39 =D7=9E=
=D7=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> >>>>>>>>> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> >>>>>>>>>>
> >>>>>>>>>> On 10/9/20 6:56 PM, Yaniv Agman wrote:
> >>>>>>>>>>> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=
=9D =D7=95=D7=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-19:27 =D7=9E=
=D7=90=D7=AA =E2=80=AADaniel Borkmann=E2=80=AC=E2=80=8F
> >>>>>>>>>>> <=E2=80=AAdaniel@iogearbox.net=E2=80=AC=E2=80=8F>:=E2=80=AC
> >>>>>>>>>>>>
> >>>>>>>>>>>> [ Cc +Yonghong ]
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 10/9/20 6:05 PM, Yaniv Agman wrote:
> >>>>>>>>>>>>> Pulling the latest changes of libbpf and compiling my appli=
cation with it,
> >>>>>>>>>>>>> I see the following error:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: er=
ror:
> >>>>>>>>>>>>> unknown register name 'r0' in asm
> >>>>>>>>>>>>>                             : "r0", "r1", "r2", "r3", "r4",=
 "r5");
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The commit which introduced this change is:
> >>>>>>>>>>>>> 80c7838600d39891f274e2f7508b95a75e4227c1
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I'm not sure if I'm doing something wrong (missing include?=
), or this
> >>>>>>>>>>>>> is a genuine error
> >>>>>>>>>>>>
> >>>>>>>>>>>> Seems like your clang/llvm version might be too old.
> >>>>>>>>>>>
> >>>>>>>>>>> I'm using clang 10.0.1
> >>>>>>>>>>
> >>>>>>>>>> Ah, okay, I see. Would this diff do the trick for you?
> >>>>>>>>>
> >>>>>>>>> Yes! Now it compiles without any problems!
> >>>>>>>>
> >>>>>>>> Great, thx, I'll cook proper fix and check with clang6 as Yongho=
ng mentioned.
> >>>>>>>
> >>>>>>> Am I the only one confused here?... Yonghong said it should be
> >>>>>>> supported as early as clang 6, Yaniv is using Clang 10 and is sti=
ll
> >>>>>>> getting this error. Let's figure out what's the problem before ad=
ding
> >>>>>>> unnecessary checks.
> >>>>>>>
> >>>>>>> I think it's not the clang_major check that helped, rather __bpf_=
_
> >>>>>>> check. So please hold off on the fix, let's get to the bottom of =
this
> >>>>>>> first.
> >>>>>>
> >>>>>> I don't see confusion here (maybe other than which minimal clang/l=
lvm version
> >>>>>> libbpf should support). If we do `#if __clang_major__ >=3D 6 && de=
fined(__bpf__)`
> >>>>>> for the final patch, then this means that user passed clang -targe=
t bpf and
> >>>>>> the min supported version for inline assembly was there, otherwise=
 we fall back
> >>>>>> to bpf_tail_call. In Yaniv's case, he probably had native target w=
ith -emit-llvm
> >>>>>> and then used llc invocation.
> >>>>>
> >>>>> The "-emit-llvm" was the part that we were missing and had to figur=
e
> >>>>> it out, before we could discuss the fix.
> >>>>
> >>>> Maybe Yaniv can confirm. I think the following properly happens.
> >>>>       - clang10 -O2 -g -S -emit-llvm t.c  // This is native compilat=
ion
> >>>> becasue some header files. Maybe some thing is guarded with x86 spec=
ific
> >>>> config's which is not available to -target bpf. This is mostly for
> >>>> tracing programs and Yanic mentions pt_regs which should be related
> >>>> to tracing.
> >>>>       - llc -march=3Dbpf t.ll
> >>>
> >>> Yes, like I said,  I do use --emit-llvm, and indeed have a tracing pr=
ogram
> >>>
> >>>> So guarding the function with __bpf__ should be the one fixing this =
issue.
> >>>>
> >>>> guard with clang version >=3D6 should not hurt and may prevent
> >>>> compilation failures if people use < 6 llvm with clang -target bpf.
> >>>> I think most people should already use newer llvm, but who knows.
> >>
> >> Yeah that was my thinking for those stuck for whatever reason on old L=
LVM.
> >>
> >>>>>>>>>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_h=
elpers.h
> >>>>>>>>>> index 2bdb7d6dbad2..31e356831fcf 100644
> >>>>>>>>>> --- a/tools/lib/bpf/bpf_helpers.h
> >>>>>>>>>> +++ b/tools/lib/bpf/bpf_helpers.h
> >>>>>>>>>> @@ -72,6 +72,7 @@
> >>>>>>>>>>        /*
> >>>>>>>>>>         * Helper function to perform a tail call with a consta=
nt/immediate map slot.
> >>>>>>>>>>         */
> >>>>>>>>>> +#if __clang_major__ >=3D 10 && defined(__bpf__)
> >>>>>>>>>>        static __always_inline void
> >>>>>>>>>>        bpf_tail_call_static(void *ctx, const void *map, const =
__u32 slot)
> >>>>>>>>>>        {
> >>>>>>>>>> @@ -98,6 +99,9 @@ bpf_tail_call_static(void *ctx, const void *=
map, const __u32 slot)
> >>>>>>>>>>                           :: [ctx]"r"(ctx), [map]"r"(map), [sl=
ot]"i"(slot)
> >>>>>>>>>>                           : "r0", "r1", "r2", "r3", "r4", "r5"=
);
> >>>>>>>>>>        }
> >>>>>>>>>> +#else
> >>>>>>>>>> +# define bpf_tail_call_static  bpf_tail_call
> >>>>>
> >>>>> bpf_tail_call_static has very specific guarantees, so in cases wher=
e
> >>>>> we can't use inline assembly to satisfy those guarantees, I think w=
e
> >>>>> should not just silently redefine bpf_tail_call_static as
> >>>>> bpf_tail_call, rather make compilation fail if someone is attemptin=
g
> >>>>> to use bpf_tail_call_static. _Static_assert could be used to provid=
e a
> >>>>> better error message here, probably.
> >>
> >> Makes sense as well, I was mainly thinking if people include header fi=
les in
> >> their project which are shared between tracing & non-tracing, so they =
compile
> >> just fine, but I can see the point that wrt very specific guarantees, =
fully
> >> agree. In that sense we should just have it defined with the clang + _=
_bpf__
> >> constraints mentioned earlier.
> >
> > Is this change going to happen?
> > I'm still having a compilation error when using master branch
>
> Yeah, I'll submit something tonight.
>
> Thanks,
> Daniel

Great, Thanks!

Yaniv
