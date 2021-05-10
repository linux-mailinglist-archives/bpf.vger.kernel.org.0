Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA88A379289
	for <lists+bpf@lfdr.de>; Mon, 10 May 2021 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhEJPZG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 11:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbhEJPX6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 11:23:58 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C112C046876
        for <bpf@vger.kernel.org>; Mon, 10 May 2021 07:59:04 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id x22so5296936uav.8
        for <bpf@vger.kernel.org>; Mon, 10 May 2021 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fW/AIVBMEGTrSxQZTpq7wHoUN95d6n8eotTFqIU9MG8=;
        b=VhG+uKYcVfF/34wlic1io5xtcK/1e/nFZUhMcpCLlzuGG9KgUlIms1LOYB8ufo4S+8
         QXa/FNMgiaUJeHpjuFiOoe3lrMSX4NFYNqvEHfbFn5kJKMKLs/IczQGz2sstBKiTHODR
         A19fva9CJzicNRstJ2i1lr5R8/nvmnaunP1lRbaXKH5yykiasoN4f1gSmgE7gxmEAimk
         K94Ne3YW9TbhA658rV7iHUUcnfPGEH484fvatxtjnOBwyLMm7HicoPGDEUqioEklZ3gE
         fMSh2hZa4qTaiSXDVEQ3TGyaTIO/60OWq6g5pE9Eu3xxNyWgA5TSWacs58c4tLlcKrhQ
         yRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fW/AIVBMEGTrSxQZTpq7wHoUN95d6n8eotTFqIU9MG8=;
        b=KSeLB0gEjHpRu0NIeMZJR0HJtdXb9ZlO41HskCPJpk5ibEKMLMHaXqz3c+VIO/qGgE
         tJYK8P6Apag5Yrc3vHvUjdxJzzB7OLaw1lRcRYrIp/nA5gugj+feCisDtiJHKS3W3O1C
         SMgpr7b5XnFYpMl1zabA9cEefm8Lw82hflSVrvQzv4BQt0KXVULXlefSRyu9N1RZUJzu
         HZWAtq1PSSPQM+Go3wUvIJ+K2nRwz2qEQ7nhwOHqC7wRMlAQMvIft96zFTM2sKuV1iam
         3AYZKWgrasoaxvLHXE/5w3PdBZlJGFmm0gA+eeYS1IMY6hNQlQZyHugGexvXBLReS7MY
         /yXA==
X-Gm-Message-State: AOAM532BZNoRE33ptJQdB3l3BPJitM49C20t977LUR26gdp4ylLtBMwk
        XSJZJigGwP/SfGP4Ee7izNex7qzIavOIy3/O1EM=
X-Google-Smtp-Source: ABdhPJymJ04Bk0fph1I/+HBjFZ8SvVLecfpWzVfkmzAMT8XO1Xy6/AEcjvbQY/AZCdTMkbKz/llcfyTM1RRHHdqmuIA=
X-Received: by 2002:ab0:5961:: with SMTP id o30mr19917850uad.127.1620658743525;
 Mon, 10 May 2021 07:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210429054734.53264-1-grantseltzer@gmail.com>
 <877dkkd7gp.fsf@meer.lwn.net> <CAO658oV2vJ0O=D3HWXyCUztsHD5GzDY_5p3jaAicEqqj+2-i+Q@mail.gmail.com>
 <87tunnc0oj.fsf@meer.lwn.net> <CAO658oUMkxR7VO1i3wCYHp7hMC3exP3ccHqeA-2BGnL4bPwfPA@mail.gmail.com>
 <CAEf4BzZJUtPiGn+8mkzNd2k+-3EEE85_xezab3RYy9ZW4zqANQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZJUtPiGn+8mkzNd2k+-3EEE85_xezab3RYy9ZW4zqANQ@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Mon, 10 May 2021 10:58:52 -0400
Message-ID: <CAO658oWPrEDBE8FUBuDUnrBVM91Mgu-svXfXgAXawAUp1MmWZA@mail.gmail.com>
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

On Fri, Apr 30, 2021 at 1:31 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 30, 2021 at 7:27 AM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
> >
> > On Fri, Apr 30, 2021 at 10:22 AM Jonathan Corbet <corbet@lwn.net> wrote:
> > >
> > > Grant Seltzer Richman <grantseltzer@gmail.com> writes:
> > >
> > > > Hm, yes I do agree that it'd be nice to use existing tooling but I
> > > > just have a couple concerns for this but please point me in the right
> > > > direction because i'm sure i'm missing something. I was told to ask on
> > > > the linux-doc mailing list because you'd have valuable input anway.
> > > > This is based on reading
> > > > https://www.kernel.org/doc/html/v4.9/kernel-documentation.html#including-kernel-doc-comments
> > > >
> > > > 1. We'd want the ability to pull documentation from the code itself to
> > > > make it so documentation never falls out of date with code. Based on
> > > > the docs on kernel.org/doc it seems that we'd have to be explicit with
> > > > specifying which functions/types are included in an .rst file and
> > > > submit a patch to update the documentation everytime the libbpf api
> > > > changes. Perhaps if this isn't a thing already I can figure out how to
> > > > contribute it.
> > >
> > > No, you can tell it to pull out docs for all of the functions in a given
> > > file.  You only need to name things if you want to narrow things down.
> >
> > Alright, I will figure out how to do this and adjust the patch
> > accordingly. My biggest overall goal is making it as easy as possible
> > to contribute documentation. I think even adding just one doc string
> > above an API function is a great opportunity for new contributors to
> > familiarize themselves with the mailing list/patch process.
> >
> > >
> > > > 2. Would it be possible (or necessary) to separate libbpf
> > > > documentation from the kernel readthedocs page since libbpf isn't part
> > > > of the kernel?
> > >
> > > It could certainly be built as a separate "book", as are many of the
> > > kernel books now.  I could see it as something that gets pulled into the
> > > user-space API book, but there could also perhaps be an argument made
> > > for creating a new "libraries" book instead.
> >
> > Yea if I can figure this out for the libbpf API it'd be great to
> > replicate it for any API!
>
> It would be great if it was possible to have this libbpf
> auto-generated documentation as part of the kernel documentation, but
> also be able to generate and export it into our Github mirror to be
> pulled by readthedocs.io. If that can be done, it would be the best of
> both kernel and external worlds. We have a sync script that already
> auto-generates and checks in BPF helpers header, so we have a
> precedent of checking in auto-generated stuff into Github. So it's
> mostly about figuring out the mechanics of doc generation.

Agreed, the mirror will have to bring in the documentation
subdirectory as well so the output could be seperate.

Just want to update in this thread that i've been really preoccupied
with other obligations and will get back to this next week.

>
> >
> > >
> > > Thanks,
> > >
> > > jon
