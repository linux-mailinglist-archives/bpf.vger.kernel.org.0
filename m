Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44444A6339
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 19:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241793AbiBASIA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 13:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241791AbiBASIA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 13:08:00 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8822C061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 10:07:59 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l5so35960376edv.3
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 10:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kj2AWNrmMybXToRIPNwaahVyriZN8lqGUxAg0dzkXCQ=;
        b=ZdvRBsgNDdmig3qfMFHBdunqjPFOtqgkzIXZV8mQfIyPufdYxixJ/HNYuM9O9OV//m
         d63O1Wxn0wgMAon+CmeuMflBqkSUZamng2WxUwHCT4+3XjwtZSVPGTTy+8qAxmDxyHaU
         MAkP3KONPhvrdPapVr62D69/WyYYPjaBVRIkXZqfH/SfMhk9rFtplIJrvbYamNHnzLNT
         nDXWfdi0gFH+FFjFktFgl7AB6J7XcpW5FuzBDYcvYmGaMcoAlSa0MXPTJ/IZ53dt3zia
         Gzt6BLviGzhoIroov9cwmAFhfHBP0z+lwdB6ZjtQi+1YM3eRclGSQrw+hT2pHOo73CCF
         l3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kj2AWNrmMybXToRIPNwaahVyriZN8lqGUxAg0dzkXCQ=;
        b=NCWGgWCRJPQOOsbJsG0+/MVTL7YmGmBpkh+hoS0xe6DslELXQn0U54ikPMEDBqA2ji
         rzViEC4KickLCC6r25/aeA3I77LTeB7NUGqwQWXneHTAdgg7aVUeM0fUaBGCY8/2SN5q
         YJmJEGK+I+DbIopDqQfYsa4Y58mKyKtrbzcXLXxQR9e/RhCNoca7yKqMq8c5yB25WqxF
         cmaTZwmks8T7c0QVmjnyvnTufyuC065YhIZBj5qMVrrJ1GItER4qk4Bqpa94AcXHYYzm
         sNZi2gKEUI/E7GZnB2I5h4SxvEQFNjFtRGkxosGKyXixhLA5uOIEmDuDtiVmlYHIlKnz
         ZmXQ==
X-Gm-Message-State: AOAM5321y/+an9aNEPRlVjXfZhMmMlGAFx8AE6LdRg6LuoUZHmTWchJI
        rmrpJgE/EajKPOFhdMaSXAhtdn7xjGiTNJ9jM9YQHEBaO1E=
X-Google-Smtp-Source: ABdhPJx6wS812wNRCdpg4BuzRxQ/KLjRHaGkK1u+qzDKLx4ljmq/jjNu8/y7tbodleOtOSRW5VeTURze2owB2BkWgpg=
X-Received: by 2002:aa7:c659:: with SMTP id z25mr26784648edr.148.1643738878210;
 Tue, 01 Feb 2022 10:07:58 -0800 (PST)
MIME-Version: 1.0
References: <CAK3+h2wcDceeGyFVDU3n7kPm=zgp7r1q4WK0=abxBsj9pyFN-g@mail.gmail.com>
 <CAK3+h2ybqBVKoaL-2p8eu==4LxPY2kfLyMsyOuWEVbRf+S-GbA@mail.gmail.com>
 <CAK3+h2zLv6BcfOO7HZmRdXZcHf_zvY91iUH08OgpcetOJkM=EQ@mail.gmail.com>
 <41e809b6-62ac-355a-082f-559fa4b1ffea@fb.com> <CAK3+h2xD5h9oKqvkCTsexKprCjL0UEaqzBJ3xR65q-k0y_Rg1A@mail.gmail.com>
In-Reply-To: <CAK3+h2xD5h9oKqvkCTsexKprCjL0UEaqzBJ3xR65q-k0y_Rg1A@mail.gmail.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Tue, 1 Feb 2022 10:07:46 -0800
Message-ID: <CAK3+h2x5pHC+8qJtY7qrJRhrJCeyvgPEY1G+utdvbzLiZLzB3A@mail.gmail.com>
Subject: Re: can't get BTF: type .rodata.cst32: not found
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 28, 2022 at 10:27 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>
> On Thu, Jan 27, 2022 at 5:50 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 1/25/22 12:32 PM, Vincent Li wrote:
> > > On Tue, Jan 25, 2022 at 9:52 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
> > >>
> > >> this is macro I suspected in my implementation that could cause issue with BTF
> > >>
> > >> #define ENABLE_VTEP 1
> > >> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
> > >> 0x2048a90a, }
> > >> #define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
> > >> 0x5eaaed93fdf2, 0x5faaed93fdf2, }
> > >> #define VTEP_NUMS 4
> > >>
> > >> On Tue, Jan 25, 2022 at 9:38 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
> > >>>
> > >>> Hi
> > >>>
> > >>> While developing Cilium VTEP integration feature
> > >>> https://github.com/cilium/cilium/pull/17370, I found a strange issue
> > >>> that seems related to BTF and probably caused by my specific
> > >>> implementation, the issue is described in
> > >>> https://github.com/cilium/cilium/issues/18616, I don't know much about
> > >>> BTF and not sure if my implementation is seriously flawed or just some
> > >>> implementation bug or maybe not compatible with BTF. Strangely, the
> > >>> issue appears related to number of VTEPs I use, no problem with 1 or 2
> > >>> VTEP, 3, 4 VTEPs will have problem with BTF, any guidance from BTF
> > >>> experts  are appreciated :-).
> > >>>
> > >>> Thanks
> > >>>
> > >>> Vincent
> > >
> > > Sorry for previous top post
> > >
> > > it looks the compiler compiles the cilium bpf_lxc.c to bpf_lxc.o
> > > differently and added " [21] .rodata.cst32     PROGBITS
> > > 0000000000000000  00011e68" when  following macro exceeded 2 members
> > >
> > > #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
> > > 0x2048a90a, }
> > >
> > > no ".rodata.cst32" compiled in bpf_lxc.o  when above VTEP_ENDPOINT
> > > member <=2. any reason why compiler would do that?
> >
> > Regarding to why compiler generates .rodata.cst32, the reason is
> > you have some 32-byte constants which needs to be saved somewhere.
> > For example,
> >
> > $ cat t.c
> > struct t {
> >    long c[2];
> >    int d[4];
> > };
> > struct t g;
> > int test()
> > {
> >     struct t tmp  = {.c = {1, 2}, .d = {3, 4}};
> >     g = tmp;
> >     return 0;
> > }
> >
> > $ clang -target bpf -O2 -c t.c
> > $ llvm-readelf -S t.o
> > ...
> >    [ 4] .rodata.cst32     PROGBITS        0000000000000000 0000a8 000020
> > 20  AM  0   0  8
> > ...
> >
> > In the above code, if you change the struct size, say from 32 bytes to
> > 40 bytes, the rodata.cst32 will go away.
>
> Thanks Yonghong! I guess it is cilium/ebpf needs to recognize rodata.cst32 then

Hi Yonghong,

Here is a follow-up question, it looks cilium/ebpf parse vmlinux and
stores BTF type info in btf.Spec.namedTypes, but the elf object file
provided by user may have section like rodata.cst32 generated by
compiler that does not have accompanying BTF type info stored in
btf.Spec.NamedTypes for the rodata.cst32, how vmlinux can be
guaranteed to  have every BTF type info from application/user provided
elf object file ? I guess there is no guarantee.

Vincent
