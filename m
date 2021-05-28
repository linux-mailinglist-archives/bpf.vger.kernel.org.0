Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620DA39447C
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 16:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbhE1OwK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 10:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbhE1OwK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 10:52:10 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D589CC061574
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 07:50:34 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id w5so2260295uaq.9
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ljcHdDLVbB7QQPEv+mfP7dihYEO9Ta9eF/46TRQhyMg=;
        b=Q9gnUFlewE1w8SpfF45xD8RWMwDFdtQTI/XgUwW3CSz51Yj1GPi16r/Yp+B4aCMuaa
         Tdtn9hiQZLPW4r2qM3WhzwzH+n4AkNf55iO20njLu72lrISPfqTefdUmfG1dI/sEVt8M
         1CZOpqe50dwJec+yGeETWAx2XxRQYdhlE2OMzaRTiN8s5iS6buYwj9PxXTIaFpXOXbBv
         SZU3aY+g0C/jSoozrhwd+OxGvLfWmoy4u7J91uTnt27U13pdvd+utReXO6IuiC+8d8Ub
         Vjy/JMZWNmk31rhai1/vF+vSY9fL80JJt4Lay4U+QjEwbX0FJNL2wRgqp+6nWcs2bGC2
         DQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ljcHdDLVbB7QQPEv+mfP7dihYEO9Ta9eF/46TRQhyMg=;
        b=MKy1f0Nh2lHu/B0BklyM0nZdw9vBtIX4FQFyucG7MZZtxK0nHQUYGzn4JQBg1Ipc2L
         /0WxMQyafSKSlJEzOmIvBTKKlkL7GVbjEt0Cu1KDl/9VWVMw49y4iaBBk6aVPJifgLnA
         FBH4vja4Akn59K2aV+yNwTv7VYZW0JVbbK8JmX9QWiNdtxi6s/ttvQyF9I8syWKE267l
         feAmVUdieHai0ziPyRnf9NAbHU6WdUIqH1L0oribxSjwlHtfyq2nbcR/JphaR6D934WN
         VsG+Z9wAtidt9TiCCeoUM/fgueKEEYNsYpGNwzA15c5HzcdbpyE9hX0d6jqNyGHV4mXn
         6Q+A==
X-Gm-Message-State: AOAM532U++kr/vVCfiEGE+gHocPD938FHJQflBBgRHuR1jdU4+TMICMH
        czahRl2zzPyFokyBVp5E9NxjwYDZDAvux96mLDI=
X-Google-Smtp-Source: ABdhPJyQu9KsRItE2aUIGKpJwI5fpvyPOSl+aE+QVPYEfgUAaINvX55NignPkk7scuapPG4zAmGBTmj88Bu3VHoh1H0=
X-Received: by 2002:ab0:1391:: with SMTP id m17mr3506845uae.29.1622213433976;
 Fri, 28 May 2021 07:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210429054734.53264-1-grantseltzer@gmail.com>
 <877dkkd7gp.fsf@meer.lwn.net> <CAO658oV2vJ0O=D3HWXyCUztsHD5GzDY_5p3jaAicEqqj+2-i+Q@mail.gmail.com>
 <87tunnc0oj.fsf@meer.lwn.net> <CAO658oUMkxR7VO1i3wCYHp7hMC3exP3ccHqeA-2BGnL4bPwfPA@mail.gmail.com>
 <CAEf4BzZJUtPiGn+8mkzNd2k+-3EEE85_xezab3RYy9ZW4zqANQ@mail.gmail.com>
 <CAO658oWPrEDBE8FUBuDUnrBVM91Mgu-svXfXgAXawAUp1MmWZA@mail.gmail.com>
 <CAEf4BzZJDqR7mRSKbOCWfZV-dqwin+PGYxBTTYMVVYwriD33JQ@mail.gmail.com>
 <CAO658oUAg02tN4Gr9r5PJvb93HhN_yj3BzpvC2oVc6oaSn0FUw@mail.gmail.com> <CAEf4BzY=JQiHquwoUypU2fD4Xe5rr+DuQA2Xw=n6OXvH7hXbew@mail.gmail.com>
In-Reply-To: <CAEf4BzY=JQiHquwoUypU2fD4Xe5rr+DuQA2Xw=n6OXvH7hXbew@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Fri, 28 May 2021 10:50:22 -0400
Message-ID: <CAO658oUH3u8yWV3Ft-96OCrgkzLacv_saecv4e1u4a_X0nF0eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Autogenerating API documentation
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 26, 2021 at 4:46 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, May 25, 2021 at 8:22 PM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
> >
> > On Mon, May 10, 2021 at 1:48 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, May 10, 2021 at 7:59 AM Grant Seltzer Richman
> > > <grantseltzer@gmail.com> wrote:
> > > >
> > > > On Fri, Apr 30, 2021 at 1:31 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Fri, Apr 30, 2021 at 7:27 AM Grant Seltzer Richman
> > > > > <grantseltzer@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Apr 30, 2021 at 10:22 AM Jonathan Corbet <corbet@lwn.net> wrote:
> > > > > > >
> > > > > > > Grant Seltzer Richman <grantseltzer@gmail.com> writes:
> > > > > > >
> > > > > > > > Hm, yes I do agree that it'd be nice to use existing tooling but I
> > > > > > > > just have a couple concerns for this but please point me in the right
> > > > > > > > direction because i'm sure i'm missing something. I was told to ask on
> > > > > > > > the linux-doc mailing list because you'd have valuable input anway.
> > > > > > > > This is based on reading
> > > > > > > > https://www.kernel.org/doc/html/v4.9/kernel-documentation.html#including-kernel-doc-comments
> > > > > > > >
> > > > > > > > 1. We'd want the ability to pull documentation from the code itself to
> > > > > > > > make it so documentation never falls out of date with code. Based on
> > > > > > > > the docs on kernel.org/doc it seems that we'd have to be explicit with
> > > > > > > > specifying which functions/types are included in an .rst file and
> > > > > > > > submit a patch to update the documentation everytime the libbpf api
> > > > > > > > changes. Perhaps if this isn't a thing already I can figure out how to
> > > > > > > > contribute it.
> > > > > > >
> > > > > > > No, you can tell it to pull out docs for all of the functions in a given
> > > > > > > file.  You only need to name things if you want to narrow things down.
> > > > > >
> > > > > > Alright, I will figure out how to do this and adjust the patch
> > > > > > accordingly. My biggest overall goal is making it as easy as possible
> > > > > > to contribute documentation. I think even adding just one doc string
> > > > > > above an API function is a great opportunity for new contributors to
> > > > > > familiarize themselves with the mailing list/patch process.
> > > > > >
> > > > > > >
> > > > > > > > 2. Would it be possible (or necessary) to separate libbpf
> > > > > > > > documentation from the kernel readthedocs page since libbpf isn't part
> > > > > > > > of the kernel?
> > > > > > >
> > > > > > > It could certainly be built as a separate "book", as are many of the
> > > > > > > kernel books now.  I could see it as something that gets pulled into the
> > > > > > > user-space API book, but there could also perhaps be an argument made
> > > > > > > for creating a new "libraries" book instead.
> > > > > >
> > > > > > Yea if I can figure this out for the libbpf API it'd be great to
> > > > > > replicate it for any API!
> > > > >
> > > > > It would be great if it was possible to have this libbpf
> > > > > auto-generated documentation as part of the kernel documentation, but
> > > > > also be able to generate and export it into our Github mirror to be
> > > > > pulled by readthedocs.io. If that can be done, it would be the best of
> > > > > both kernel and external worlds. We have a sync script that already
> > > > > auto-generates and checks in BPF helpers header, so we have a
> > > > > precedent of checking in auto-generated stuff into Github. So it's
> > > > > mostly about figuring out the mechanics of doc generation.
> > > >
> > > > Agreed, the mirror will have to bring in the documentation
> > > > subdirectory as well so the output could be seperate.
> > > >
> > > > Just want to update in this thread that i've been really preoccupied
> > > > with other obligations and will get back to this next week.
> > >
> > > No worries. Thanks for the update!
> >
> > Finally catching up on this, thanks for all of your patience!
> >
> > I've discovered that it's actually very easy, even trivial, to add API
> > documentation for libbpf using the existing kernel sphinx
> > documentation system. Adding a couple files with directives under
> > `Documentaiton/bpf` is enough to pull in any comment-documented
> > functions/structs in libbpf code. I'm not sure who owns the CI/CD
>
> Hopefully Jonathan will know.
>
> > infrastructure that recompiles the documentation and hosts on
> > kernel.org/doc but I've been building them locally with `make
> > htmldocs` with no problem. That would require a single patch and we
> > can start adding comment documentation to libbpf.  I can submit a
> > patch for that if you'd like to test it yourself. In this system the
> > html output is not checked into git though.
> >
> > Andrii - what do you think of having libbpf API documentation hosted
> > on the kernel.org readthedocs? It would be nice to have it seperate
> > from the rest of kernel documentation for simplicity, though it is
> > nice to use/contribute-to existing infrastructure. If you'd like to
> > have it seperate we can have the libbpf mirror run `make htmldocs`,
> > take the output, and host our own readthedocs site.
>
> Yeah, sure, let's start with libbpf docs as part of the kernel docs,
> it doesn't hurt. But libbpf versioning is separate from kernel
> versioning and most libbpf users "consume" libbpf from Github repo, so
> we might need to do `make htmldocs` trick while syncing. But let's do
> one step at a time.

The more I think about this, I don't feel it makes sense to put the
libbpf docs in the main kernel ones if it isn't what works best for
libbpf. Sure we can stitch something together so we can version and
publish output from kernel docs but that'd cause too much confusion.

I'd rather go with this patch series, having a sphinx build script in
tools/lib/bpf. This requires no changes to how we sync the libbpf
mirror and we get the ability to pin documentation for each release
for free.

Jonathan - am I missing something about how we can version libbpf
separately from the actual kernel docs?

> >
> > I'd love to have this all set up and have the full API documented by
> > the time you cut the libbpf 1.0 release!
>
> Yep, I agree.
