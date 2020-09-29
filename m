Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D107927BBD5
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 06:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgI2EPT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 00:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgI2EPT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 00:15:19 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049EBC061755;
        Mon, 28 Sep 2020 21:15:18 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id a2so2624480ybj.2;
        Mon, 28 Sep 2020 21:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NCU0i7xGYeEOdR/ZfoUPuO4j7qe+nAQSgX4ECewg6gs=;
        b=RF56+TEdl3VhsKkf0aAHTbdmk0whqYboVYpwAbFa8NBeEW6JMY2wJW1ybOC638YKoW
         ZWbQ8wZbVnd1Wtj4yzTYVLf1CmPSQ8FCeinnapte2EstmqCXqKz9xbTWMZLbinawA1hf
         AIwizresxuVCyR6MbIsJq1XLrgqD1em78odQ4MZMVxuuMWLwF4cgfP43Xc4+WYp6bQwH
         LtJPurA166FEe+v354/cKYzP6EMxMh27VuWBetNIWY9iqn0W0H+F4/ne6wGvCOwuamTu
         Atdi+AUKiVzzLXeWRXYnktHqZRYCBZWyUkLJu+VlZJc3e8rhignlZvgISUm20m8wveQZ
         WxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCU0i7xGYeEOdR/ZfoUPuO4j7qe+nAQSgX4ECewg6gs=;
        b=Zb4/StGxPW+2FXb+PyWtGDh3mwOqxoaKng5dgXjKgmVbJzW7c5X3QWhKA2Mmm5xr47
         dXSt9rdzooO81j0lyudQStP7FGi5l7PODRfXKbjqKxVSepQYqEDBzjwwlw5EPop0bTeE
         yQzJ05S4DN2dbnvJ+spBOxJCsVU5qLgFqoX3blZDFY+M9HFB3vQHSgsGTWrQhAY8OQ9c
         sK+pU7lqX2z9/eXLZCnaMyrQn4QonKMJYM5dzTbAlv5SMTQ8Jef+yI8RpVPsQHTK0p6s
         KA2pkKJX5ctmimcMZYIvSnCDnFKR63JZNgKuoxow4xtUuM/PdWi2dFHfvY3IukFNRM+r
         znuA==
X-Gm-Message-State: AOAM532iVIXf3bnIKMxe1pSQk7aM8nuTw8oS8QuAeAwidvYYOkPr2imo
        evl0BgGsnK7z3WGw/v5qGMvJvo+jBuKj2iYkFT0=
X-Google-Smtp-Source: ABdhPJxA49lX4po2veHsCuljLaJ6h2dsP76B7/VjiBTetvSo3smPTSEuXeJegyQjrBa6YKGf+f29k5PZd8B0/XPNzsI=
X-Received: by 2002:a25:2d41:: with SMTP id s1mr3599161ybe.459.1601352918079;
 Mon, 28 Sep 2020 21:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGftE8ipAacAnm9xMHFabXCL-XrCXGmOsX-Nsjvz9wnh3Zx-w@mail.gmail.com>
 <9e99c5301fbbb4f5f601b69816ee1dc9ab0df948.camel@linux.ibm.com>
 <CAEf4Bza9tZ-Jj0dj9Ne0fmxa95t=9XxxJR+Ce=6hDmw_d8uVFA@mail.gmail.com>
 <8cf42e2752e442bb54e988261d8bf3cd22ad00f2.camel@linux.ibm.com>
 <20200909142750.GC3788224@kernel.org> <CAPGftE8jNys9aVfUZW2iE5vB=QWKEmmwwWuWq9ek0ZXp-Aobkg@mail.gmail.com>
 <CAEf4BzYDm3QOOgND9p+LR21bn98QMjE+VYspQSvi4ebG9EdW0g@mail.gmail.com>
 <CAEf4Bzb7LZX8Y=qKpO5j3eUYU=tJzvNRYd1CdXXxq8Y-V4=+Vw@mail.gmail.com> <CAPGftE9iVH=eG_FRxSFJC0B3FX8LVdKStfvLbs0gRt8kvMoqJw@mail.gmail.com>
In-Reply-To: <CAPGftE9iVH=eG_FRxSFJC0B3FX8LVdKStfvLbs0gRt8kvMoqJw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 28 Sep 2020 21:15:07 -0700
Message-ID: <CAEf4Bza2D2MQ_F7+vNg7x05JachvJ5bLM3Uyjv+oEx=xna_u4g@mail.gmail.com>
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

On Mon, Sep 28, 2020 at 8:41 PM Tony Ambardar <tony.ambardar@gmail.com> wrote:
>
> Hello Andrii!
>
> On Mon, 28 Sep 2020 at 13:19, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Sep 21, 2020 at 11:19 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > I have a bunch of code changes locally. I'll clean that up, partition
> > > libbpf and pahole patches, and post them for review this week. To
> > > address endianness support, those are the prerequisites. Once those
> > > changes land, I'll be able to solve endianness issues you are having.
> > > So just a bit longer till all that is done, sorry for the wait!
> > >
> >
> > Question to folks that are working with 32-bit and/or big-endian
> > architectures. Do you guys have an VM image that you'd be able to
> > share with me, such that I can use it with qemu to test patches like
> > this. My normal setup is all 64-bit/little-endian, so testing changes
> > like this (and a few more I'm planning to do to address mixed 32-bit
> > on the host vs 64-bit in BPF cases) is a bit problematic. And it's
> > hard to get superpumped about spending lots of time setting up a new
> > Linux image (never goes easy or fast for me).
> >
> > So, if you do have something like this, please share. Thank you!
> >
>
> I can provide 32-bit and 64-bit big-endian system images for running
> on QEMU's malta target. These are built using OpenWRT's build system
> and include a recent stable bpftool (v5.8.x) and v5.4.x kernel. Is
> that sufficient? It would work if manually creating raw or elf-based
> BTF files on a build host, then copying into the QEMU target to test
> parsing with bpftool (linked with the standard libbpf).

That would be great! I intend to run them under qemu-system-arm and
supply latest kernel through -kernel option, so kernel itself is not
that critical. Same for bpftool, pahole, etc, I'll just supply them
from my host environment. So please let me know how I can get ahold of
those. Sample qemu invocation command line would be highly appreciated
as well. Thank you!

>
> For changes to the Linux build system itself (e.g. pahole endian
> options and target endian awareness), you would need to set up a

I think that shouldn't be a problem and should be handled
transparently, even in a cross-compilation case, but let's see.

> standard OpenWRT build environment. I can help with that, or simply
> integrate your patches myself for testing. As you say, nothing to be
> super pumped about...
>
> Let me know what's easiest and how best to get images to you.

Any way you like and can. Dropbox, Google drive, what have you.

>
> Many thanks,
> Tony
