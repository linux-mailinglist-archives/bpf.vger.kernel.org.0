Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE9B390ECE
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 05:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhEZDYJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 May 2021 23:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhEZDYI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 May 2021 23:24:08 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153BDC061574
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 20:22:37 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id f15so15864254vsq.12
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 20:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6/846YAMk9RRWN/aZR9dpDogHYuOD2U8U0bltNEf84=;
        b=Vi+sqrnQLnd4Z32zO3lpld3g9FqVMl1ixE6+gVF5MoC45bHRHYvmZHC8+Pjmhm1bRr
         AuUCUfIdhSvq7BE4fdjjtrR1xciQdYcnhTHiV7n/gjLevZc2odRRq2ZfZ95Vw9g0tGjZ
         Jla7E+WxCdb6YgmbINVZ+w9P1QTtJ6c/zVjDZHBsbz4p0IIPJ21X/xP5YyY8iERkh0cC
         /ZkvjASnc8HMGc9k6IvMb5YuNeek6ceMoo5g+P75Q+B7GwPg6V9nS7muynhPj8UTkxZH
         pRmzYJal3RA6C37RInWhsmQQuzQqOFbU6zdyUt6uFHtuHLG1uOEOFtKk1Vjh7iZhgCze
         7LdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6/846YAMk9RRWN/aZR9dpDogHYuOD2U8U0bltNEf84=;
        b=NZMfoYm556J8b9j0QB0BA7+j2kIMo4s2+RsZ4nAof2yAlD1+87lgPidzWSVzlo/dQc
         i5AKBYCorZfWqgmzxfdhfeKpnEaSsYIajhNV7gMqmLxT6zXvl/pTO8D/xplWA+DN85up
         5W1Wcu4VpsmL0wPZMG1Fvao1R0fijsVAHjo+W5Rq2R8E/1+UMd2+xaKIV2fB3AL1MSCL
         Gv9zhQLPhX+9GA1V9ShfJMn7EEjfokMzjfmhecUVG3hBpdEHHin5Sspv/bl9CD8DHkjL
         QgAg5iMAjarpGs5DDMfqcxC3NtlL9xFoOkTPc1wCC1T3qeESNh6F9ugOBDJdWUvEHd6q
         BLrg==
X-Gm-Message-State: AOAM533YwqIQ33c+F8KSv/wGjUXLR69GwNoF6D/53/VaIB1ZdLHFU8yB
        CK5huz+hooVUL7aAaL6sFm20Lokn/8uJlvQnB1RoG7fgqkIT4n8P
X-Google-Smtp-Source: ABdhPJw5n+upawgyjZc6Mq6Lma/51EhPpXi/h5FTV79QoA+7XJqp2fWxboWxJk//SUbsyEHKEe5pamCGbgYr0u2aaas=
X-Received: by 2002:a05:6102:c46:: with SMTP id y6mr29813692vss.22.1621999356196;
 Tue, 25 May 2021 20:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210429054734.53264-1-grantseltzer@gmail.com>
 <877dkkd7gp.fsf@meer.lwn.net> <CAO658oV2vJ0O=D3HWXyCUztsHD5GzDY_5p3jaAicEqqj+2-i+Q@mail.gmail.com>
 <87tunnc0oj.fsf@meer.lwn.net> <CAO658oUMkxR7VO1i3wCYHp7hMC3exP3ccHqeA-2BGnL4bPwfPA@mail.gmail.com>
 <CAEf4BzZJUtPiGn+8mkzNd2k+-3EEE85_xezab3RYy9ZW4zqANQ@mail.gmail.com>
 <CAO658oWPrEDBE8FUBuDUnrBVM91Mgu-svXfXgAXawAUp1MmWZA@mail.gmail.com> <CAEf4BzZJDqR7mRSKbOCWfZV-dqwin+PGYxBTTYMVVYwriD33JQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZJDqR7mRSKbOCWfZV-dqwin+PGYxBTTYMVVYwriD33JQ@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Tue, 25 May 2021 23:22:24 -0400
Message-ID: <CAO658oUAg02tN4Gr9r5PJvb93HhN_yj3BzpvC2oVc6oaSn0FUw@mail.gmail.com>
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

On Mon, May 10, 2021 at 1:48 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 10, 2021 at 7:59 AM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
> >
> > On Fri, Apr 30, 2021 at 1:31 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Apr 30, 2021 at 7:27 AM Grant Seltzer Richman
> > > <grantseltzer@gmail.com> wrote:
> > > >
> > > > On Fri, Apr 30, 2021 at 10:22 AM Jonathan Corbet <corbet@lwn.net> wrote:
> > > > >
> > > > > Grant Seltzer Richman <grantseltzer@gmail.com> writes:
> > > > >
> > > > > > Hm, yes I do agree that it'd be nice to use existing tooling but I
> > > > > > just have a couple concerns for this but please point me in the right
> > > > > > direction because i'm sure i'm missing something. I was told to ask on
> > > > > > the linux-doc mailing list because you'd have valuable input anway.
> > > > > > This is based on reading
> > > > > > https://www.kernel.org/doc/html/v4.9/kernel-documentation.html#including-kernel-doc-comments
> > > > > >
> > > > > > 1. We'd want the ability to pull documentation from the code itself to
> > > > > > make it so documentation never falls out of date with code. Based on
> > > > > > the docs on kernel.org/doc it seems that we'd have to be explicit with
> > > > > > specifying which functions/types are included in an .rst file and
> > > > > > submit a patch to update the documentation everytime the libbpf api
> > > > > > changes. Perhaps if this isn't a thing already I can figure out how to
> > > > > > contribute it.
> > > > >
> > > > > No, you can tell it to pull out docs for all of the functions in a given
> > > > > file.  You only need to name things if you want to narrow things down.
> > > >
> > > > Alright, I will figure out how to do this and adjust the patch
> > > > accordingly. My biggest overall goal is making it as easy as possible
> > > > to contribute documentation. I think even adding just one doc string
> > > > above an API function is a great opportunity for new contributors to
> > > > familiarize themselves with the mailing list/patch process.
> > > >
> > > > >
> > > > > > 2. Would it be possible (or necessary) to separate libbpf
> > > > > > documentation from the kernel readthedocs page since libbpf isn't part
> > > > > > of the kernel?
> > > > >
> > > > > It could certainly be built as a separate "book", as are many of the
> > > > > kernel books now.  I could see it as something that gets pulled into the
> > > > > user-space API book, but there could also perhaps be an argument made
> > > > > for creating a new "libraries" book instead.
> > > >
> > > > Yea if I can figure this out for the libbpf API it'd be great to
> > > > replicate it for any API!
> > >
> > > It would be great if it was possible to have this libbpf
> > > auto-generated documentation as part of the kernel documentation, but
> > > also be able to generate and export it into our Github mirror to be
> > > pulled by readthedocs.io. If that can be done, it would be the best of
> > > both kernel and external worlds. We have a sync script that already
> > > auto-generates and checks in BPF helpers header, so we have a
> > > precedent of checking in auto-generated stuff into Github. So it's
> > > mostly about figuring out the mechanics of doc generation.
> >
> > Agreed, the mirror will have to bring in the documentation
> > subdirectory as well so the output could be seperate.
> >
> > Just want to update in this thread that i've been really preoccupied
> > with other obligations and will get back to this next week.
>
> No worries. Thanks for the update!

Finally catching up on this, thanks for all of your patience!

I've discovered that it's actually very easy, even trivial, to add API
documentation for libbpf using the existing kernel sphinx
documentation system. Adding a couple files with directives under
`Documentaiton/bpf` is enough to pull in any comment-documented
functions/structs in libbpf code. I'm not sure who owns the CI/CD
infrastructure that recompiles the documentation and hosts on
kernel.org/doc but I've been building them locally with `make
htmldocs` with no problem. That would require a single patch and we
can start adding comment documentation to libbpf.  I can submit a
patch for that if you'd like to test it yourself. In this system the
html output is not checked into git though.

Andrii - what do you think of having libbpf API documentation hosted
on the kernel.org readthedocs? It would be nice to have it seperate
from the rest of kernel documentation for simplicity, though it is
nice to use/contribute-to existing infrastructure. If you'd like to
have it seperate we can have the libbpf mirror run `make htmldocs`,
take the output, and host our own readthedocs site.

I'd love to have this all set up and have the full API documented by
the time you cut the libbpf 1.0 release!
