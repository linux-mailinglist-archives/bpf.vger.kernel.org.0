Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDEF3A31DA
	for <lists+bpf@lfdr.de>; Thu, 10 Jun 2021 19:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhFJRSF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Jun 2021 13:18:05 -0400
Received: from mail-yb1-f181.google.com ([209.85.219.181]:43976 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJRSE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Jun 2021 13:18:04 -0400
Received: by mail-yb1-f181.google.com with SMTP id b9so326897ybg.10
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stfbqOIV89FUH0XCyxeAlJ82MP2mOSsHysgBzljvNgU=;
        b=tn6tRLdkmYbcPawpw7gZIfSaKaTVNblN69wznBM6tuWb7UwibEJKyAgYfA6TsIuz9X
         P5q6FWDYPWf2ZGsfX90VYtAxsc353w0CuCbPmjL173Lfs59Um8CSc49sbDQKTDIq5JHL
         /ZaH7E/4NcKtoLChK8c59EQcxqmHOXe/PPXkz0CRrM5Oh2GmklgADHWpAaKQoOCiv6Vj
         nosaIT+rtp9+jGGlil5lxFp3J9yf9GtaZZWKKfWmWck9+1eEP1Z2/FxizLJsdo+J7RuN
         wv3FRtOd4iFwvM0x4e3Ri7lxxpSrfrcmrWfTu4tHhQIoh/egG4SPbJjPcqU9Fu2+PWgV
         cdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stfbqOIV89FUH0XCyxeAlJ82MP2mOSsHysgBzljvNgU=;
        b=dmMIPbxuCY/dtsAx12Dq8xsQ3mPiSz9aOopLj5VpAwfOkBHzh9chO7IySjK/e0TJnM
         pv3UlzpNBcZJ5X72iW7u93c5CtIbLWESYZ+ZsIPdsI44dUvXeVnbfCvumbbp1uNmA6C9
         Cebkj0wLMwa4Hetz8AhRFC6valkLvvKRk9Cdg9Zvh8xbqlsOiDeWm635fskcAHJ+8LO5
         VlNMJKiiP8HjlfSCo9aJR3WNtvvLUlYzj3CGgUksZ16sDcApQ8zklBLXuTyhqGe9I2W3
         UpEhV79BhKZ5SAKHI6nG6rWBJyq1+9AZhX5uI8sQQi1WXJV3EdYMxpn8y6HzEo2YsJ7K
         uJfA==
X-Gm-Message-State: AOAM531ZD6sH9TCzt70ezhUJ5hl/61h+E7DeizgpWXEi8DwCS8vdQe/J
        BGIDVGvMuzI22E1Zv4rIVJ5hWCOO0nVUDpLmp+8=
X-Google-Smtp-Source: ABdhPJy3+9ExJ8UKsAph6fqu3mmMjTDug07oMCZ/xBg4PestylEsr50U5Tt42BpgwXmbPeLBmvQ0sqeeGq0G3PJLxfI=
X-Received: by 2002:a25:7246:: with SMTP id n67mr9293816ybc.510.1623345296596;
 Thu, 10 Jun 2021 10:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210429054734.53264-1-grantseltzer@gmail.com>
 <877dkkd7gp.fsf@meer.lwn.net> <CAO658oV2vJ0O=D3HWXyCUztsHD5GzDY_5p3jaAicEqqj+2-i+Q@mail.gmail.com>
 <87tunnc0oj.fsf@meer.lwn.net> <CAO658oUMkxR7VO1i3wCYHp7hMC3exP3ccHqeA-2BGnL4bPwfPA@mail.gmail.com>
 <CAEf4BzZJUtPiGn+8mkzNd2k+-3EEE85_xezab3RYy9ZW4zqANQ@mail.gmail.com>
 <CAO658oWPrEDBE8FUBuDUnrBVM91Mgu-svXfXgAXawAUp1MmWZA@mail.gmail.com>
 <CAEf4BzZJDqR7mRSKbOCWfZV-dqwin+PGYxBTTYMVVYwriD33JQ@mail.gmail.com>
 <CAO658oUAg02tN4Gr9r5PJvb93HhN_yj3BzpvC2oVc6oaSn0FUw@mail.gmail.com>
 <CAEf4BzY=JQiHquwoUypU2fD4Xe5rr+DuQA2Xw=n6OXvH7hXbew@mail.gmail.com>
 <CAO658oUH3u8yWV3Ft-96OCrgkzLacv_saecv4e1u4a_X0nF0eg@mail.gmail.com>
 <87wnrd9zp8.fsf@meer.lwn.net> <CAO658oW-_-bOX=xZNjzR=S89rY99gzuwh8Ln9MNtgA4zkwEh+g@mail.gmail.com>
 <875yyx895z.fsf@meer.lwn.net> <CAO658oWwqtZFnhVg3hC8dO=2obOKn5Mp2uqrOYa-3xsNwiRU8Q@mail.gmail.com>
 <CAO658oXRN=JnP+e=qM2-uBu94BxoWCyHcScOgSwxpoHOw5ByLQ@mail.gmail.com>
 <CAEf4Bzaupx7dvv8nZAQKqo2UbdRmYgCb=54Uy0x5+96UTD6DTA@mail.gmail.com> <CAO658oW-XiuS_FLVCkj1pTtQS5MPxk=jyA+-LRkiMgt=27e21A@mail.gmail.com>
In-Reply-To: <CAO658oW-XiuS_FLVCkj1pTtQS5MPxk=jyA+-LRkiMgt=27e21A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Jun 2021 10:14:43 -0700
Message-ID: <CAEf4BzbUQ07qzfRDOZWjfz-7P_dZG33xcJaC3TM5PbRpxJC5tw@mail.gmail.com>
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

On Wed, Jun 9, 2021 at 10:04 AM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> On Mon, Jun 7, 2021 at 6:45 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>
> > So I assume you looked at the DOC: block that Jonathan suggested
> > above? Can you walk us a bit on how that would look like and why you
> > think it's not going to work?
>
> If I understand correctly, the using the  DOC: comment block and
> extracting it would require you to manually update a comment in code
> that labels the libbpf version number and then cut a release. The
> problems are:
>
> 1) Having to do that manually
> 2) The docs on kernel.org would not show previous libbpf releases
> (just the ones that were released with different kernel versions)
>
> > > If you check out libbpf.readthedocs.io you can see what that would
> > > look like. I made a test release (v21.21.21) to show how easy this is.
> > > That is being pulled from my PR at github.com/libbpf/libbpf/pull/260.
> >
> > It looks pretty nice. Where does v21.21.21 come from, though?
>
> libbpf.readthedocs.org currently tracks my libbpf fork at
> github.com/grantseltzer/libbpf, I cut the 21.21.21 release there.
>
> What this demonstrates is that readthedocs pulls in any release or
> branch I enable in the admin panel and builds a seperate site for each
> one. You can see the release/branches by toggling them in the bottom
> left.
>
> > also weird that docs are under src/docs, not just under docs/, but I
> > assume that's a quick hack to demonstrate this?
>
> I can move that no problem. All the config files have relative paths
> that point at each other.
>
> > To be entirely honest, I'm already a bit lost on all the
> > possibilities. It would be great if you can summarize what's possible
> > and how it would look like.
>
> That's my fault, I'm not making this easy to review (2 different patch
> series, plus github PR). Here is a summary of the 3 different
> approaches I've presented. At the bottom I have my recommendation.
>
> 1) Integrate libbpf docs into the kernel documentation system:
>
> - Add libbpf documentation files (e.g. 'naming-convention',
> 'building-libbpf') under the Linux 'Documentation' directory.
> - Include a file which has sphinx directives to pull in API
> documentation from the code under tools/lib/bpf.
> - This documentation would appear on kernel.org/doc alongside all
> other kernel documentation
>
> Pro: Make use of existing kernel documentation infrastructure
> Con: In order to have the libbpf documentation be versioned based on
> github releases it would require manually updating comments in code.
> To get it how we really want it (i.e. select a libbpf release and see
> the documentation specific for it), it would likely require
> rearranging/duplicating code in libbpf under subdirectories.
> Contributing simple documentation has to go through the mailing list
> which is daunting for new contributors.
>
> 2) Have all libbpf documentation in the kernel repo under
> tools/lib/bpf/docs, including libbpf's own sphinx configuration files
>
> - The github mirror would pull in these documentation files and sphinx
> configuration files.
> - readthedocs would be configured to build off of the github libbpf mirror repo.
> - The documentation would be accessible at libbpf.readthedocs.org.
> - Users would be able to navigate documentation of different releases
> of libbpf easily. Maintainers would not need to do any manual work to
> make that happen.
>
> Pro: Documentation all in one place, in the kernel repo, integrates
> easily with the github mirror, and we easily get to version
> documentation by libbpf releases.
> Con: We don't make use of existing kernel documentation
> infrastructure. Contributing simple documentation has to go through
> the mailing list which is daunting for new contributors.
>
> 3) Host all the documentation on the libbpf github mirror
>
> - Documents (e.g. 'naming-convention', 'building-libbpf') would be
> available at libbpf.readthedocs.org
> - Sphinx configuration files would live in the libbpf github mirror
> - Code comment documentation would still go through the mailing list
>
> Pro: Documentation is explorable by different versions. Some
> documentation can be contributed via github which is easier than the
> mailing list.
> Con: Documentation would be scattered across different places.
>
> My recommendation:
>
> I would go with option 2, it feels like the best compromise. However,
> I'd like to contribute changes to the kernel documentation such that
> it can support versioning particular documentation files based on
> specified git hashes. That way we can have libbpf docs on kernel.org
> but still get to version docs based on libbpf releases, not kernel
> ones.
>
> I'm happy to explore other options, but if one of these sounds like
> something that we can agree on for now, I can submit a fresh patch for
> it.

Honestly, I think option #3 would be best for actually getting more
docs contributions, because it will reduce the friction of getting
started. Figuring out the kernel mailing list submission process is
not a trivial problem.

But I'm sure some people will have strong feelings about keeping docs
in the kernel source tree. Assuming we'd get a lot of push back for
option #3, I think the next best thing would be a hybrid of #1 and #2.
Host docs in kernel docs under Documentation/bpf/libbpf, so it will
get into kernel sources automatically. But also copy those docs into
Github mirror during sync under /docs and have readthedocs pull and
version it properly. That has a chance of creating a bit of confusion
for where exactly libbpf docs are (it would be libbpf.readthedocs.org,
versioned properly), but given docs will have the same source of truth
(modulo minor versioning differences, potentially), I think this might
be ok. WDYT? Are there any problems with that?

Hosting docs under tools/libbpf/docs in kernel repo is the worst of
both worlds, IMO. Hard to contribute, but also not integrated with the
rest of kernel docs.

>
>
> >
> > As a general guidance, I think we should try to keep all the
> > documentation in one place (which means kernel sources, because that's
> > where API documentation will have to leave). As for config files,
> > unless they will "stick out" too much, I'd keep them close to the docs
> > themselves. If not, putting them in Github mirror is fine by me as
> > well.
> >
> > Pretty much the only important aspect, from my point of view, is that
> > docs are versioned according to the libbpf version, not kernel
> > version. Otherwise huge confusion will ensue for all the users of
> > libbpf, most of not all of which are using Github mirror.
> >
> > Does this make sense and is doable?
> >
> > > > >
> > > > > If you're wanting to replace the version code that appears at the top of
> > > > > the left column in the HTML output, though, it's going to be a bit
> > > > > harder.  I don't doubt we can do it, but it may require messing around
> > > > > with template files and such.
> > > > >
> > > > > Thanks,
> > > > >
> > > > > jon
