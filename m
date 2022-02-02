Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94CF4A790E
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 20:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiBBT4F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 14:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiBBT4F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 14:56:05 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E454CC061714
        for <bpf@vger.kernel.org>; Wed,  2 Feb 2022 11:56:04 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id s18so411914ioa.12
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 11:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ws/IBe1pSeBOpUlS8sYdNFetIp6iw16BZq6iIGWUEQ=;
        b=LhRTuFfAH5OpcdZu2xbRX66sQBAib/RKZ+w9ia8ReemSFIyxMnd7W4QpS5dqtU7g0g
         izBtuO6ZY1DoZgYjEphOlhhOsTHaihG51A/2Lyf5XfPPBdYsfkTwOXHIsGwG957wx+mx
         bt9HecGJNv99dUIwbqQFAKQ7hNxs9N0GeNFVwvCi74lSRKYou0iDM0PuiHhSRumHSsKw
         TU6YNHyM70JHwlvnr8qudkPcU1JcSL5Gpt/Wa0eoSDeyxGHp+6ocI5mChKfCt8Gkk0YA
         WCw++yGxzP/weFyHIETcqGOMUP+DAW4MMSzt3TgRo7i0hTEo7LGPFvb32vSSb3kbgeLb
         a+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ws/IBe1pSeBOpUlS8sYdNFetIp6iw16BZq6iIGWUEQ=;
        b=J5wop/yIbdw34UuvEIotyPSGujr82PZ1WbuNoZjKrgPr2A226k73NJnCACBfJ70Dtj
         JxU0VoEfkATlAbhBNx18TGS33jhYmTfoFfMk4hdOOhn6S5pT5//RhXq7HYizUj/Mu9+n
         kLcw2HYGJ8F5FSRgK5Z/4haNRpolyHBNCIqSAn4ftL4AIEDurO6oRNGLl5B2v1tabj+b
         IM5sAL9mp+CSR3QW/wfDKPph+KJCWhKYnrJ1l867DDEwHUFUmKaJwkolMAoU28trMenP
         dpQvQQExB/PVklnc2VPKIMBgLA2Vt3FA4GovDMOP7VcWub7d1Bjiu1IoLdNW0XS9QQuC
         f0fw==
X-Gm-Message-State: AOAM531t0QRGr/5mOfpCLH5TNMvjKbyLloGfDjhkRRm0tQGTV1M1l10j
        k2JiTcjGvo+FfZBXQELTcctw+4o1HFADlA1yjSNq3gTO
X-Google-Smtp-Source: ABdhPJyGEhrKHV7XiL4FCH3uhyY3WOFubxFHo1XPafbEIjRu0uJ6aducMbMDck+XndH44DDMuXJfbnXmaJvr22yKhUI=
X-Received: by 2002:a02:2422:: with SMTP id f34mr16242868jaa.237.1643831764257;
 Wed, 02 Feb 2022 11:56:04 -0800 (PST)
MIME-Version: 1.0
References: <CAK3+h2wcDceeGyFVDU3n7kPm=zgp7r1q4WK0=abxBsj9pyFN-g@mail.gmail.com>
 <CAK3+h2ybqBVKoaL-2p8eu==4LxPY2kfLyMsyOuWEVbRf+S-GbA@mail.gmail.com>
 <CAK3+h2zLv6BcfOO7HZmRdXZcHf_zvY91iUH08OgpcetOJkM=EQ@mail.gmail.com>
 <41e809b6-62ac-355a-082f-559fa4b1ffea@fb.com> <CAK3+h2xD5h9oKqvkCTsexKprCjL0UEaqzBJ3xR65q-k0y_Rg1A@mail.gmail.com>
 <CAK3+h2x5pHC+8qJtY7qrJRhrJCeyvgPEY1G+utdvbzLiZLzB3A@mail.gmail.com>
 <81a30d50-b5c5-987a-33f2-ab12cbd6e709@fb.com> <4ff8334f-fc51-0738-b8c6-a45403eed9e1@incline.eu>
In-Reply-To: <4ff8334f-fc51-0738-b8c6-a45403eed9e1@incline.eu>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Feb 2022 11:55:53 -0800
Message-ID: <CAEf4Bzbs57f8=JM_X11WRpQpGnh2Z-cGvuazh1UXkeCUQ8xU6g@mail.gmail.com>
Subject: Re: can't get BTF: type .rodata.cst32: not found
To:     Timo Beckers <timo@incline.eu>
Cc:     Yonghong Song <yhs@fb.com>, Vincent Li <vincent.mc.li@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 2, 2022 at 9:59 AM Timo Beckers <timo@incline.eu> wrote:
>
> On 2/2/22 08:17, Yonghong Song wrote:
> >
> >
> > On 2/1/22 10:07 AM, Vincent Li wrote:
> >> On Fri, Jan 28, 2022 at 10:27 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
> >>>
> >>> On Thu, Jan 27, 2022 at 5:50 PM Yonghong Song <yhs@fb.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 1/25/22 12:32 PM, Vincent Li wrote:
> >>>>> On Tue, Jan 25, 2022 at 9:52 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
> >>>>>>
> >>>>>> this is macro I suspected in my implementation that could cause issue with BTF
> >>>>>>
> >>>>>> #define ENABLE_VTEP 1
> >>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
> >>>>>> 0x2048a90a, }
> >>>>>> #define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
> >>>>>> 0x5eaaed93fdf2, 0x5faaed93fdf2, }
> >>>>>> #define VTEP_NUMS 4
> >>>>>>
> >>>>>> On Tue, Jan 25, 2022 at 9:38 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
> >>>>>>>
> >>>>>>> Hi
> >>>>>>>
> >>>>>>> While developing Cilium VTEP integration feature
> >>>>>>> https://github.com/cilium/cilium/pull/17370, I found a strange issue
> >>>>>>> that seems related to BTF and probably caused by my specific
> >>>>>>> implementation, the issue is described in
> >>>>>>> https://github.com/cilium/cilium/issues/18616, I don't know much about
> >>>>>>> BTF and not sure if my implementation is seriously flawed or just some
> >>>>>>> implementation bug or maybe not compatible with BTF. Strangely, the
> >>>>>>> issue appears related to number of VTEPs I use, no problem with 1 or 2
> >>>>>>> VTEP, 3, 4 VTEPs will have problem with BTF, any guidance from BTF
> >>>>>>> experts  are appreciated :-).
> >>>>>>>
> >>>>>>> Thanks
> >>>>>>>
> >>>>>>> Vincent
> >>>>>
> >>>>> Sorry for previous top post
> >>>>>
> >>>>> it looks the compiler compiles the cilium bpf_lxc.c to bpf_lxc.o
> >>>>> differently and added " [21] .rodata.cst32     PROGBITS
> >>>>> 0000000000000000  00011e68" when  following macro exceeded 2 members
> >>>>>
> >>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
> >>>>> 0x2048a90a, }
> >>>>>
> >>>>> no ".rodata.cst32" compiled in bpf_lxc.o  when above VTEP_ENDPOINT
> >>>>> member <=2. any reason why compiler would do that?
> >>>>
> >>>> Regarding to why compiler generates .rodata.cst32, the reason is
> >>>> you have some 32-byte constants which needs to be saved somewhere.
> >>>> For example,
> >>>>
> >>>> $ cat t.c
> >>>> struct t {
> >>>>     long c[2];
> >>>>     int d[4];
> >>>> };
> >>>> struct t g;
> >>>> int test()
> >>>> {
> >>>>      struct t tmp  = {.c = {1, 2}, .d = {3, 4}};
> >>>>      g = tmp;
> >>>>      return 0;
> >>>> }
> >>>>
> >>>> $ clang -target bpf -O2 -c t.c
> >>>> $ llvm-readelf -S t.o
> >>>> ...
> >>>>     [ 4] .rodata.cst32     PROGBITS        0000000000000000 0000a8 000020
> >>>> 20  AM  0   0  8
> >>>> ...
> >>>>
> >>>> In the above code, if you change the struct size, say from 32 bytes to
> >>>> 40 bytes, the rodata.cst32 will go away.
> >>>
> >>> Thanks Yonghong! I guess it is cilium/ebpf needs to recognize rodata.cst32 then
> >>
> >> Hi Yonghong,
> >>
> >> Here is a follow-up question, it looks cilium/ebpf parse vmlinux and
> >> stores BTF type info in btf.Spec.namedTypes, but the elf object file
> >> provided by user may have section like rodata.cst32 generated by
> >> compiler that does not have accompanying BTF type info stored in
> >> btf.Spec.NamedTypes for the rodata.cst32, how vmlinux can be
> >> guaranteed to  have every BTF type info from application/user provided
> >> elf object file ? I guess there is no guarantee.
> >
> > vmlinux holds kernel types. rodata.cst32 holds data. If the type of
> > rodata.cst32 needs to be emitted, the type will be encoded in bpf
> > program BTF.
> >
> > Did you actually find an issue with .rodata.cst32 section? Such a
> > section is typically generated by the compiler for initial data
> > inside the function and llvm bpf backend tries to inline the
> > values through a bunch of load instructions. So even you see
> > .rodata.cst32, typically you can safely ignore it.
> >
> >>
> >> Vincent
> >
>
> Hi Yonghong,
>
> Thanks for the reproducer. Couldn't figure out what to do with .rodata.cst32,
> since there are no symbols and no BTF info for that section.
>
> The values found in .rodata.cst32 are indeed inlined in the bytecode as you
> mentioned, so it seems like we can ignore it.
>
> Why does the compiler emit these sections? cilium/ebpf assumed up until now
> that all sections starting with '.rodata' are datasecs and must be loaded into
> the kernel, which of course needs accompanying BTF.

It doesn't need an accompanying BTF. libbpf loads all .rodata.*
sections (unless BPF program code doesn't reference it at all, which
is mostly for backwards compatibility with old kernels that don't
support global variables) and it all works good.

>
> What other .rodata.* should we expect?
>

I'd suggest instead of whitelisting all possible .rodata.* section
names just allow any such data section. So that users can have their
own custom .rodata (and .data) sections as well.

> Thanks,
>
> Timo
