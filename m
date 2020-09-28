Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E4D27B623
	for <lists+bpf@lfdr.de>; Mon, 28 Sep 2020 22:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgI1UTG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Sep 2020 16:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgI1UTG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 16:19:06 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BC9C0613CE;
        Mon, 28 Sep 2020 13:19:04 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id x8so1848027ybe.12;
        Mon, 28 Sep 2020 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XRvxn3Edd7TEvLawcsqTJPfhbhDEJqLPmAdFEeeYtyA=;
        b=hii3QcKM9PhwrnO6Eiu1ZSCczteIhmFz56LLPijToPbFC7i3jfidofT3wx5HcvGGyV
         PurbCPO9GMEoEuSPwdP1EI2DTVsdPkyTBabEc1YMRYmhxp5nEq/gmc4cJ2hiaATH+0hl
         mhVMJCjxGr7PvdGMMJg8a4bpZdnUqCVQQSLZAEgX8uz/VzJUzdqOCh05lTS9NgeAc5I+
         iQTjjqafatNtLCuaR6BZsk8lfcfTrqJgf6bjnv9HyfHB1V6abMDvblf4LKcHGp8430hn
         xJiyUBZGGOssLkOfxqGoXkxOAep7HrDj6eH3x2izjPlNgrISV3UujJHYmglPws09klB0
         mGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRvxn3Edd7TEvLawcsqTJPfhbhDEJqLPmAdFEeeYtyA=;
        b=AbLugCeiPhQ2WnwbY+mfUoU28MFE3lsSS70qIeUfOc4hFnAV4Al99Y5uhkEB9MGa+n
         0outt1C6+RTas5MbrJMQHaYVHWMOcN8qu5YpphCf2B+xdsCvUKa1ruwRWzSdLzewNMVd
         HAe8UKsIi/fRJEtBqAFepQvz7UQygaWaq+0ZSSlTaPzn7sAJNuRzn1V2047nFTekO7CH
         N5/KWQxX8kUrxjR0lxX8idndCwq97BKJln8Lq0ZmBh/Jabc4D/sYFaZEZFqvFnVO9F40
         oGil1dJ1DTtFmiFg3nc8iR+cXaS8pksuh4XuW/86sztzEyVA3iafn9oD+ltPncTXfk7h
         ZX2g==
X-Gm-Message-State: AOAM532ZAZiJ+81MuMZ/be6yfkeaoN2rIh+JF0uNs+/dqkig2zziPwRX
        7ISGcnOYM5nhmJdn9pKo7djb+r156f4EkXDMIrA=
X-Google-Smtp-Source: ABdhPJxl9jKgXWsMYDnmy/zj0/oFsNH3q4iqbmSX/FFs+XcGHep/03cZ4LDYUwFQJsfhl3+WGYRO5Mn8U3xD9e+Iyqw=
X-Received: by 2002:a25:2687:: with SMTP id m129mr1691502ybm.425.1601324343700;
 Mon, 28 Sep 2020 13:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGftE8ipAacAnm9xMHFabXCL-XrCXGmOsX-Nsjvz9wnh3Zx-w@mail.gmail.com>
 <9e99c5301fbbb4f5f601b69816ee1dc9ab0df948.camel@linux.ibm.com>
 <CAEf4Bza9tZ-Jj0dj9Ne0fmxa95t=9XxxJR+Ce=6hDmw_d8uVFA@mail.gmail.com>
 <8cf42e2752e442bb54e988261d8bf3cd22ad00f2.camel@linux.ibm.com>
 <20200909142750.GC3788224@kernel.org> <CAPGftE8jNys9aVfUZW2iE5vB=QWKEmmwwWuWq9ek0ZXp-Aobkg@mail.gmail.com>
 <CAEf4BzYDm3QOOgND9p+LR21bn98QMjE+VYspQSvi4ebG9EdW0g@mail.gmail.com>
In-Reply-To: <CAEf4BzYDm3QOOgND9p+LR21bn98QMjE+VYspQSvi4ebG9EdW0g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 28 Sep 2020 13:18:52 -0700
Message-ID: <CAEf4Bzb7LZX8Y=qKpO5j3eUYU=tJzvNRYd1CdXXxq8Y-V4=+Vw@mail.gmail.com>
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

On Mon, Sep 21, 2020 at 11:19 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Sep 19, 2020 at 12:58 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > On Wed, 9 Sep 2020 at 07:27, Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Wed, Sep 09, 2020 at 11:02:24AM +0200, Ilya Leoshkevich escreveu:
> > > > On Tue, 2020-09-08 at 13:18 -0700, Andrii Nakryiko wrote:
> > > > > On Mon, Sep 7, 2020 at 9:02 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> > > > > > On Sat, 2020-09-05 at 21:16 -0700, Tony Ambardar wrote:
> > >
> > [...]
> > > > > > > Is this expected? Is DEBUG_INFO_BTF supported in general when
> > > > > > > cross-compiling? How does one generate BTF encoded for the
> > > > > > > target endianness with pahole?
> > >
> > > The BTF loader has support for endianness, its just the encoder that
> > > doesn't :-\
> > >
> > > I.e. pahole can grok a big endian BTF payload on a little endian machine
> > > and vice-versa, just can't cross-build BTF payloads ATM.
> > >
> > > > > Yes, it's expected, unfortunately. Right now cross-compiling to a
> > > > > different endianness isn't supported. You can cross-compile only if
> > > > > target endianness matches host endianness.
> > >
> > > I agree that having this in libbpf is better, it should be done as part
> > > of producing the result of the deduplication phase.
> > >
> > Thanks for confirming this wasn't a case of operator error. My platforms for
> > learning/experimenting with BPF have been small embedded ones, including
> > cross-compiling to different archs, word-size and endianness, which have
> > "helped" me run into multiple problems till now. This one is the first I
> > couldn't work around however...
> >
> > [...]
> > > > > I'm working on extending BTF APIs in libbpf at the moment. Switching
> > > > > endianness would be rather easy once all that is done. With these new
> > > > > APIs it will be possible to switch pahole to use libbpf APIs to
> > > > > produce BTF output and support arbitrary endianness as well. Right
> > > > > now, I'd rather avoid implementing this in pahole, libbpf is a much
> > > > > better place for this (and will require ongoing updates if/when we
> > > > > introduce new types and fields to BTF).
> > >
> > > Right, we could do it right after btf_dedup() and before
> > > btf_elf__write(), doing the same process as in btf_loader.c, i.e.
> > > checking if the ELF target arch is different in endianness and doing the
> > > reverse of the loader.
> > >
> > > > > Hope this plan works for you guys.
> > > >
> > > > That sounds really good to me, thanks!
> > >
> > Andrii and Arnaldo, I really appreciate your working on a proper endianness fix.
> > If you have a WIP or staging branch and could use some help please let me know.
> >
>
> I have a bunch of code changes locally. I'll clean that up, partition
> libbpf and pahole patches, and post them for review this week. To
> address endianness support, those are the prerequisites. Once those
> changes land, I'll be able to solve endianness issues you are having.
> So just a bit longer till all that is done, sorry for the wait!
>

Question to folks that are working with 32-bit and/or big-endian
architectures. Do you guys have an VM image that you'd be able to
share with me, such that I can use it with qemu to test patches like
this. My normal setup is all 64-bit/little-endian, so testing changes
like this (and a few more I'm planning to do to address mixed 32-bit
on the host vs 64-bit in BPF cases) is a bit problematic. And it's
hard to get superpumped about spending lots of time setting up a new
Linux image (never goes easy or fast for me).

So, if you do have something like this, please share. Thank you!

> > Best regards,
> > Tony
