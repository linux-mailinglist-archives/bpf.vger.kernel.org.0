Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81731379660
	for <lists+bpf@lfdr.de>; Mon, 10 May 2021 19:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhEJRtm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 13:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbhEJRti (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 13:49:38 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE470C061574
        for <bpf@vger.kernel.org>; Mon, 10 May 2021 10:48:30 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id h202so22742187ybg.11
        for <bpf@vger.kernel.org>; Mon, 10 May 2021 10:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WiGSMsXj1hjU/2+Bo4Flrub4xwVdwa96wG4VvwBDVPE=;
        b=fuGno6K1JFpOOj4rYGTOXb7q8QaU7wyXn6x2se2XzRBQRGJ/yHzrBByXi+HHtf+igO
         BEL5HpqoCh4lYkJDzYGT0pIChQWcA+QRPEoOGMn7yQ/xhdtsWHYzYy9YBS6XZeBodGkv
         TntZQazOTA0tRWXZsxvcgYMOdkk8TlH+c1vn+0EEKmoVrqM3MO3IInCxlD8o5F/CDYyH
         eMpc7X9q905VNQ1+fvRg0yng+y3CnNY72pwb4fdK3BhwWGJQfWRDz6AXJmu7aD2dlJtP
         ZxEScIL0kcHFPo+gtGqn4nErdo1QPjco+LzSvS/YVG+SqwJ4dL+Ut8pGF/QGZvNrrTyJ
         meEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WiGSMsXj1hjU/2+Bo4Flrub4xwVdwa96wG4VvwBDVPE=;
        b=jpGTbM5vXzuuZkMw37vN3CIqbLWKm7mqLxd+m6T+c4FEwL0tQUaUz9+AFCoRCqrGLC
         vzEbQAKk4u5t7Uo+rqQP9rlMAvK0H/puMEDs90XBUB4ueqmoYzKrt9aGbUGFjyeQtUj6
         kIAVIMTAM0nlAKStierig65pA8ogauT3ffaWTfKo93aAhDnNAAdYbPxFSl61QesMh3nV
         J4HlPehRiefnOwYVqSeEoQpLPbXIDNbZ/T0ViwRBhvd7+Qk09942yBncF6KR86TnL3a8
         SfrnnGCRUtLsEAYG2hQ46er0j/LScoIc+HcvPqW6sY4eTLtKKjPcp1Iv7U+6a7vIgPeY
         1dpg==
X-Gm-Message-State: AOAM530nulCBPHGVOJnMT2Ar5I6S9VB9ktK4huXC+M9UQJcUQk1wuwko
        gxAa4J5gtQsvKYQBWAgDfkFfqPRTLztsgnnaPz+kbWmy
X-Google-Smtp-Source: ABdhPJzMGI0HgZ+zZwoj51QzloeIaCGF14OO/m7mCQLRhBxNs7e7GafSKs18Z4wDhwWLbZgFVGtyHCOmH3hevaytxBY=
X-Received: by 2002:a25:c4c5:: with SMTP id u188mr34112576ybf.425.1620668910045;
 Mon, 10 May 2021 10:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210429054734.53264-1-grantseltzer@gmail.com>
 <877dkkd7gp.fsf@meer.lwn.net> <CAO658oV2vJ0O=D3HWXyCUztsHD5GzDY_5p3jaAicEqqj+2-i+Q@mail.gmail.com>
 <87tunnc0oj.fsf@meer.lwn.net> <CAO658oUMkxR7VO1i3wCYHp7hMC3exP3ccHqeA-2BGnL4bPwfPA@mail.gmail.com>
 <CAEf4BzZJUtPiGn+8mkzNd2k+-3EEE85_xezab3RYy9ZW4zqANQ@mail.gmail.com> <CAO658oWPrEDBE8FUBuDUnrBVM91Mgu-svXfXgAXawAUp1MmWZA@mail.gmail.com>
In-Reply-To: <CAO658oWPrEDBE8FUBuDUnrBVM91Mgu-svXfXgAXawAUp1MmWZA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 10 May 2021 10:48:18 -0700
Message-ID: <CAEf4BzZJDqR7mRSKbOCWfZV-dqwin+PGYxBTTYMVVYwriD33JQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Autogenerating API documentation
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 10, 2021 at 7:59 AM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> On Fri, Apr 30, 2021 at 1:31 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Apr 30, 2021 at 7:27 AM Grant Seltzer Richman
> > <grantseltzer@gmail.com> wrote:
> > >
> > > On Fri, Apr 30, 2021 at 10:22 AM Jonathan Corbet <corbet@lwn.net> wrote:
> > > >
> > > > Grant Seltzer Richman <grantseltzer@gmail.com> writes:
> > > >
> > > > > Hm, yes I do agree that it'd be nice to use existing tooling but I
> > > > > just have a couple concerns for this but please point me in the right
> > > > > direction because i'm sure i'm missing something. I was told to ask on
> > > > > the linux-doc mailing list because you'd have valuable input anway.
> > > > > This is based on reading
> > > > > https://www.kernel.org/doc/html/v4.9/kernel-documentation.html#including-kernel-doc-comments
> > > > >
> > > > > 1. We'd want the ability to pull documentation from the code itself to
> > > > > make it so documentation never falls out of date with code. Based on
> > > > > the docs on kernel.org/doc it seems that we'd have to be explicit with
> > > > > specifying which functions/types are included in an .rst file and
> > > > > submit a patch to update the documentation everytime the libbpf api
> > > > > changes. Perhaps if this isn't a thing already I can figure out how to
> > > > > contribute it.
> > > >
> > > > No, you can tell it to pull out docs for all of the functions in a given
> > > > file.  You only need to name things if you want to narrow things down.
> > >
> > > Alright, I will figure out how to do this and adjust the patch
> > > accordingly. My biggest overall goal is making it as easy as possible
> > > to contribute documentation. I think even adding just one doc string
> > > above an API function is a great opportunity for new contributors to
> > > familiarize themselves with the mailing list/patch process.
> > >
> > > >
> > > > > 2. Would it be possible (or necessary) to separate libbpf
> > > > > documentation from the kernel readthedocs page since libbpf isn't part
> > > > > of the kernel?
> > > >
> > > > It could certainly be built as a separate "book", as are many of the
> > > > kernel books now.  I could see it as something that gets pulled into the
> > > > user-space API book, but there could also perhaps be an argument made
> > > > for creating a new "libraries" book instead.
> > >
> > > Yea if I can figure this out for the libbpf API it'd be great to
> > > replicate it for any API!
> >
> > It would be great if it was possible to have this libbpf
> > auto-generated documentation as part of the kernel documentation, but
> > also be able to generate and export it into our Github mirror to be
> > pulled by readthedocs.io. If that can be done, it would be the best of
> > both kernel and external worlds. We have a sync script that already
> > auto-generates and checks in BPF helpers header, so we have a
> > precedent of checking in auto-generated stuff into Github. So it's
> > mostly about figuring out the mechanics of doc generation.
>
> Agreed, the mirror will have to bring in the documentation
> subdirectory as well so the output could be seperate.
>
> Just want to update in this thread that i've been really preoccupied
> with other obligations and will get back to this next week.

No worries. Thanks for the update!

>
> >
> > >
> > > >
> > > > Thanks,
> > > >
> > > > jon
