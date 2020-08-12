Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FD724243C
	for <lists+bpf@lfdr.de>; Wed, 12 Aug 2020 05:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgHLDTC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Aug 2020 23:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgHLDTB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Aug 2020 23:19:01 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69E7C06174A
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2020 20:19:01 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id q3so594473ybp.7
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2020 20:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xzgon0BTaPF3w6wHhfMI0rl39gN2oP3lEShQWBFBINA=;
        b=ePc+TTDRg0p9f0Kca0A3rCx0crH/UpAZvSZ/HtN4zKbnK1ejxWor39tIzn6RQ9oT6H
         naGc4mD8WvD1XOIarZuGB99BjayTTXkbt6XEAWtt9tUUyVIWkDQxUUwha336+FeorDEl
         BVMhByzvxP1P1XWvaxz+el8CAEV0HWaSkTMco9Cwm3Sjpcxr1q170EeuAjXj8Npcd46y
         nCJN+NiYYHDDcFIItHtGx4Ey0l61cbMxWZBFWyuRSEJHhxkwIkQ4EYcG33Si4Htl0wUb
         6UPCM7IQAD0DH8rBlv7mg97eGxoyX+Ss+dXqJ0TXU17jNhwhwtRae2AWDVXZhm4L63hW
         zHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xzgon0BTaPF3w6wHhfMI0rl39gN2oP3lEShQWBFBINA=;
        b=a+K5/8XqgR9+5I3p1IePSIB6c/Ghbp1GgsWINaUz+1dOLSbljnQPlTwYf/p32ODZef
         DSBnOXOU9jfSxKDH8hhxzJYAa6EI9/s/XoVElmrqw/QqU1tvZjJGVHbEcPyFWhN3nvxR
         6n0JjnCGz2xfGRDGmghuH63AEMPTRamjiQpX+HJCx4LpJgAcFMw885XFjFUltBk8l+WJ
         uq+rSJ8iyI2XZexNxjMlB0Z+L3j5dhFVPS8hn5ZyumjixQ/XBbrxc5R2GYVAU9aNny2A
         sCiiF/7BO9/1eo6duw0QA12crcji2TqAXUFpHiWIUsiXskYOgV8oUHSpM30P0+leRjqm
         o/HA==
X-Gm-Message-State: AOAM530h/5gkKgWY2DI/S7JKWafu8wr3OEpr8llbdczBDHH7lveXuVe1
        0aHivqYPxCfUTwNCgNX7zlQrqlWsdzW8Pfkk6XFwZw==
X-Google-Smtp-Source: ABdhPJwNc8GNP4WZOcFY3FUuA1VPBLxihc19QGnZWhBRb5aWSSI78TEpT5Un+b+AhiXyJWCHgZ9M5Vl8slgoEHgwSuc=
X-Received: by 2002:a25:ad5a:: with SMTP id l26mr49241170ybe.510.1597202340912;
 Tue, 11 Aug 2020 20:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <f1b8e140-bc41-4e56-e73f-db11062dddbd@sartura.hr>
 <20200807172353.GA624812@myrica> <CAEf4BzbC-abnqD4802=uT+u3+gwMK3q+yXjWAriuDTj2hMJ9Yw@mail.gmail.com>
 <CAADnVQ+fQG38XKR+V33qTR-G-7wm398CMCafbuQrTQ9CHfE2mA@mail.gmail.com>
 <20200810125753.GA1643799@myrica> <CAEf4BzaQcxAArJyLqxxw8sV507DyWzU44HJ3oaUAjX4UEu_KaA@mail.gmail.com>
 <20200811095410.GA2786584@myrica>
In-Reply-To: <20200811095410.GA2786584@myrica>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 Aug 2020 20:18:49 -0700
Message-ID: <CAEf4BzbabGWckm2NSb-eL+-j5BZWTM_h==qqJn9PwDk2gd0gsA@mail.gmail.com>
Subject: Re: eBPF CO-RE cross-compilation for 32-bit ARM platforms
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jakov Petrina <jakov.petrina@sartura.hr>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Smolic <jakov.smolic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 11, 2020 at 2:54 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Mon, Aug 10, 2020 at 11:54:54PM -0700, Andrii Nakryiko wrote:
> > On Mon, Aug 10, 2020 at 5:58 AM Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > >
> > > On Fri, Aug 07, 2020 at 01:54:02PM -0700, Alexei Starovoitov wrote:
> > > [...]
> > > > > > > ```
> > > > > > > typedef __Poly8_t poly8x16_t[16];
> > > > > > > ```
> > > > > > >
> > > > > > > AFAICT these are ARM NEON intrinsic definitions which are GCC-specific. We
> > > > > > > have opted to comment out this line as there was no additional `poly8x16_t`
> > > > > > > usage in the header file.
> > > > > >
> > > > > > It looks like this "__Poly8_t" type is internal to GCC (provided in
> > > > > > arm_neon.h) and clang has its own internals. I managed to reproduce this
> > > > > > with an arm64 allyesconfig kernel (+BTF), but don't know how to fix it at
> > > > > > the moment. Maybe libbpf should generate defines to translate these
> > > > > > intrinsics between clang and gcc? Not very elegant. I'll take another
> > > > > > look next week.
> > > > >
> > > > > libbpf is already blacklisting __builtin_va_list for GCC, so we can
> > > > > just add __Poly8_t to the list. See [0].
> > > > > Are there any other types like that? If you guys can provide me this,
> > > > > I'll gladly update libbpf to take those compiler-provided
> > > > > types/built-ins into account.
> > > >
> > > > Shouldn't __Int8x16_t and friends cause the same trouble?
> > >
> > > I think these do get properly defined, for example in my vmlinux.h:
> > >
> > >         typedef signed char int8x16_t[16];
> > >
> > > From a cursory reading of the "ARM C Language Extension" doc (IHI0053D) it
> > > looks like only the poly8/16/64/128_t types are unspecified. It's safe to
> > > drop them as long as they're not used in structs or function parameters,
> > > but I sent a more generic fix [1] that copies the clang defintions. When
> > > building the kernel with clang, the polyX_t types do get typedefs.
> > >
> > > Thanks,
> > > Jean
> > >
> >
> > Hi Jean,
> >
> > Would you be so kind to build some simple C repro code that uses those
> > polyX_t types? Ideally built by both GCC and Clang. And then run
> > `pahole -J` on them to get .BTF into them as well. If you can share
> > those two with me, I'd love to look at how DWARF and BTF look like.
> >
> > I'm, unfortunately, having trouble making something like that to
> > cross-compile on my x86-64 machine, I've spent a bunch of time already
> > on this unsuccessfully and it's really frustrating at this point. If
> > you have an ARM system (or cross-compilation set up properly), it
> > shouldn't take much time for you, hopefully. Just make sure that those
> > polyX_t types do make it into DWARF, so, e.g., use them with static
> > variable or something, e.g.,:
> >
> > int main() {
> >     static poly8_t a = 12;
> >     return a + 10;
> > }
> >
> > Or something along those lines. Thanks!
>
> No problem, I put the source and clang+gcc binaries in a tarball here:
> https://jpbrucker.net/tmp/test-poly-neon.tar.bz2
>
> These contain all the base types defined by arm_neon.h (minus the new
> bfloat16, which I don't think matters at the moment)
>

Thanks a lot! It was very helpful. I wonder why there was never
poly32_t defined?

> Thanks,
> Jean
>
> >
> > > [1] https://lore.kernel.org/bpf/20200810122835.2309026-1-jean-philippe@linaro.org/
> > >
> > > > There is a bunch more in gcc/config/arm/arm-simd-builtin-types.def.
> > > > May be there is a way to detect compiler builtin types by pattern matching
> > > > their dwarf/btf shape and skip them automatically?
> > > > The simplest, of course, is to only add a few that caused this known
> > > > trouble to blocklist.
