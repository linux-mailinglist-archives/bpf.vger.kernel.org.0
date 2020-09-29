Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F3327D542
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 19:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgI2R5b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 13:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgI2R5a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 13:57:30 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57227C061755;
        Tue, 29 Sep 2020 10:57:30 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id v60so4265135ybi.10;
        Tue, 29 Sep 2020 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1JLeR7hs2t3LNL/VevNbKZmDuYgdRy4GrJ22m1nprA=;
        b=ktfVEoCrQTNv2jBrN62ca/gFlOgTCwu4OGjndNuVG2G9WpwPixWMWA4QL/s0O089Hv
         C5xq6wPHMxCmnyPVbeNze5EA7Z/c8LlagPeT6HzWtAagXceFlKu8iu4BebtvsqJDPJNT
         NpnhbRsNHjB604yDpf/rRXbYntiiJ2RA0IE0ujt7mjvCtvrjmejkV1oeoHgNHwwGef+q
         +JADaKzv9UVwmRO69KWMCJG8NUN3XbSRFjANOyM05+bYfyI254EdmZcZiHDIm+5CYGD5
         wEJWwEdHPC7cK7Y9++ylKawAUBb69ha2NpoSmxHVlOrLJqp4takBs3VSVSeDOaO7tPUb
         kmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1JLeR7hs2t3LNL/VevNbKZmDuYgdRy4GrJ22m1nprA=;
        b=PBlh/rU+hMZG+s9B/7REc+LcqYgZpsHJJkSSkQrnt8Gbp87+vMs249R68QeuxeKYds
         tVLisLKBw+jDMMiUBOFsZo2CTw/9tQN8doPd29AGhM42yBr0t5m1TUCgifqTBbqxB6mQ
         fyOrmjeAlJegemXcVTkQLHLkZeg0m3F2fDMNVqCw7T4XwDyLHNFubmbgIeSY/QpfOHzi
         RUhimd/sozTOMOdryTKpa3cOiOVYpIXEa+NbUFQK7bYhh0jsZUByO0/NYSrfeXlb//t7
         SGq0FEwvZIeI68kFKnWbAb/0qd39MNiRlUmE6VGtdkhAQFUI7248bCG0/V5P9kNjYt29
         iVPg==
X-Gm-Message-State: AOAM531dP02uAd1iUN9WBvege/5plDQyfVHWZH/w5CD6vuqhl2WSDCUY
        hqGkXx75r5qdV4s9CvSxFm0xphCZ/J66sx9GYV1BQoAymIAY2Q==
X-Google-Smtp-Source: ABdhPJwUROdk9A8Qwd2tuw08CZKr0R3MuuP8qDXjgB8mVmyxJSCJn4YkSFdFD8d7NoBEab/1tROH0o1RQJpQwHeitmE=
X-Received: by 2002:a25:33c4:: with SMTP id z187mr7498681ybz.27.1601402248480;
 Tue, 29 Sep 2020 10:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGftE8ipAacAnm9xMHFabXCL-XrCXGmOsX-Nsjvz9wnh3Zx-w@mail.gmail.com>
 <9e99c5301fbbb4f5f601b69816ee1dc9ab0df948.camel@linux.ibm.com>
 <CAEf4Bza9tZ-Jj0dj9Ne0fmxa95t=9XxxJR+Ce=6hDmw_d8uVFA@mail.gmail.com>
 <8cf42e2752e442bb54e988261d8bf3cd22ad00f2.camel@linux.ibm.com>
 <20200909142750.GC3788224@kernel.org> <CAPGftE8jNys9aVfUZW2iE5vB=QWKEmmwwWuWq9ek0ZXp-Aobkg@mail.gmail.com>
 <CAEf4BzYDm3QOOgND9p+LR21bn98QMjE+VYspQSvi4ebG9EdW0g@mail.gmail.com>
 <CAEf4Bzb7LZX8Y=qKpO5j3eUYU=tJzvNRYd1CdXXxq8Y-V4=+Vw@mail.gmail.com>
 <CAPGftE9iVH=eG_FRxSFJC0B3FX8LVdKStfvLbs0gRt8kvMoqJw@mail.gmail.com>
 <CAEf4Bza2D2MQ_F7+vNg7x05JachvJ5bLM3Uyjv+oEx=xna_u4g@mail.gmail.com> <CAPGftE_aD6raGXnjhAM6CCMjB2_9C77Z=Xg-=wMwaduTHCp3Pw@mail.gmail.com>
In-Reply-To: <CAPGftE_aD6raGXnjhAM6CCMjB2_9C77Z=Xg-=wMwaduTHCp3Pw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 29 Sep 2020 10:57:17 -0700
Message-ID: <CAEf4BzZHF+KOxSCVeDoKnoLS_U9Qc6rT+tOMy0vA_C8FaFO5yQ@mail.gmail.com>
Subject: Re: Problem with endianess of pahole BTF output for vmlinux
To:     Tony Ambardar <tony.ambardar@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        David Marcinkovic <david.marcinkovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Borna Cafuk <borna.cafuk@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 28, 2020 at 11:48 PM Tony Ambardar <tony.ambardar@gmail.com> wrote:
>
> On Mon, 28 Sep 2020 at 21:15, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Sep 28, 2020 at 8:41 PM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> > >
> [...]
> > > I can provide 32-bit and 64-bit big-endian system images for running
> > > on QEMU's malta target. These are built using OpenWRT's build system
> > > and include a recent stable bpftool (v5.8.x) and v5.4.x kernel. Is
> > > that sufficient? It would work if manually creating raw or elf-based
> > > BTF files on a build host, then copying into the QEMU target to test
> > > parsing with bpftool (linked with the standard libbpf).
> >
> > That would be great! I intend to run them under qemu-system-arm and
> > supply latest kernel through -kernel option, so kernel itself is not
> > that critical. Same for bpftool, pahole, etc, I'll just supply them
> > from my host environment. So please let me know how I can get ahold of
> > those. Sample qemu invocation command line would be highly appreciated
> > as well. Thank you!
> >
> Sounds good. However, malta is actually a MIPS platform. I've been using it

I don't care about ARM vs MIPS specifically. Needed 32-bit and
big-endian, just to test different variations. MIPS works just fine, I
think.

> a long time because it makes things particularly easy to switch configuration
> between different word-sizes and endianness.
>
> I had some malta mips images ready to go, but if you need ARM I'll need
> to look into building images for big-endian ARM. Big-endian isn't so common
> in the wild, and I'll need to see if OpenWRT supports these, and how to
> configure with QEMU's 'armvirt' target if possible...
>
> > >
> > > For changes to the Linux build system itself (e.g. pahole endian
> > > options and target endian awareness), you would need to set up a
> >
> > I think that shouldn't be a problem and should be handled
> > transparently, even in a cross-compilation case, but let's see.
> >
> > > standard OpenWRT build environment. I can help with that, or simply
> > > integrate your patches myself for testing. As you say, nothing to be
> > > super pumped about...
> > >
> > > Let me know what's easiest and how best to get images to you.
> >
> > Any way you like and can. Dropbox, Google drive, what have you.
> >
> Meantime, I can package up what I have and send you the details. That
> would include images for mips32/64 big-endian and arm32/64 little-endian,
> plus usage examples. Is that still helpful for you?

Yeah, tremendously! After fighting my local qemu setup I managed to
run malta-be image successfully. Thanks a lot, that saves me lots of
gray hair. I'll get to testing this hopefully today-tomorrow, will let
you know if I had any more problems.

>
> Thanks,
> Tony
