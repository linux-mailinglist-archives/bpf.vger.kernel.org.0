Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC613A7215
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 00:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhFNWiL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Jun 2021 18:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhFNWiK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Jun 2021 18:38:10 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23111C061574
        for <bpf@vger.kernel.org>; Mon, 14 Jun 2021 15:35:51 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id h15so17607973ybm.13
        for <bpf@vger.kernel.org>; Mon, 14 Jun 2021 15:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QSaoIEvD5LDIv7lZY3XT/e/MFW4rjx9ifiebDaEsNpc=;
        b=VMQSDjznZtFVJ5xgSMaQd1Q4PMqPM4Ab0FgOxQf6qNkf8jACSY7JSTErANhr/p0/cp
         MlyIOb4LsoLOg/zQkSxzTc+KpmfA8YcTpiAHDZxAs0MEOjCi25yEGl3e7scKb1WobkXo
         ewf3lY2kSh5Ye9aeGrKvuts5bVxqsp5SdzehZTVsXa6VavvCRaHhCH4uwcUTdGXs0eib
         jPIaEOTkQ9uhEIhuKrDmpIF4SrC25/wxgXVTIJgsN/yroQIwA/t2UOnQpd3yvIbQqI2W
         sUgvhUyaRBQMy0Ol0NDk7iCqqKjjQyaOjYmK2tkqADq62mceT+mleZMK0A4V0o+ugeyT
         IpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSaoIEvD5LDIv7lZY3XT/e/MFW4rjx9ifiebDaEsNpc=;
        b=nH+41ZEBDixkrHzlbHmArGgt8Ny8sjNKY+yu3s94tmoZULbJTWvXgHoW4Tx323TYe/
         Nt+L2J7Djb9FMjlMT/1mxM7I8XqnErE84ezYyC9bLr1CrXfKRepqkB9jGdD9G8niyioE
         hPORoefTPg0OhZWBJOJD7OC8cwtpbKMZAS171u4FA29n9HmNedggFaeHVzhHvosmlDkc
         oYNpBlDGgysrBHX0ZeyMLEdozHftg1KqytIEDpvCfRVVgUbjlCe8WhPlyqPaJbxX1VRc
         srggMRn3M7MfAXgZjjn84DPBtHbv0hAUIyxJ8PHRkhAu5z0q6lXlHTLyK6OM7/7GWjb5
         TWfQ==
X-Gm-Message-State: AOAM533rpx6FE09gXpWNNTWV/Y/LJraVTRylejIcyvmXY2wBzRu5jII9
        tQN47sVbfTn9t5gD9NVHSY/QtuMBennc2GVfJC7IZSKvGkc=
X-Google-Smtp-Source: ABdhPJw/0oHt/gKtncrc5j/fBJ+7MpP29PsmJzy9tSBcdmIjXjWifQjqI5sMSQ6LHViQvpbUJx+a2VBoDsBSohMbCsM=
X-Received: by 2002:a25:aa66:: with SMTP id s93mr28589902ybi.260.1623710150275;
 Mon, 14 Jun 2021 15:35:50 -0700 (PDT)
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
 <CAEf4Bzaupx7dvv8nZAQKqo2UbdRmYgCb=54Uy0x5+96UTD6DTA@mail.gmail.com>
 <CAO658oW-XiuS_FLVCkj1pTtQS5MPxk=jyA+-LRkiMgt=27e21A@mail.gmail.com>
 <CAEf4BzbUQ07qzfRDOZWjfz-7P_dZG33xcJaC3TM5PbRpxJC5tw@mail.gmail.com> <CAO658oX6kUvqQvJQ7Yd1Vh5FYymLgxNGTDV-fjjrsQTBNxjo1g@mail.gmail.com>
In-Reply-To: <CAO658oX6kUvqQvJQ7Yd1Vh5FYymLgxNGTDV-fjjrsQTBNxjo1g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 14 Jun 2021 15:35:39 -0700
Message-ID: <CAEf4BzZFz-gO4yVmgYpvM4AVA4ORr-Hi=h+FDgJri3jj8AR0_A@mail.gmail.com>
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

On Fri, Jun 11, 2021 at 1:01 PM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> On Thu, Jun 10, 2021 at 1:14 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Jun 9, 2021 at 10:04 AM Grant Seltzer Richman
> > <grantseltzer@gmail.com> wrote:
> > >
> > > On Mon, Jun 7, 2021 at 6:45 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > So I assume you looked at the DOC: block that Jonathan suggested
> > > > above? Can you walk us a bit on how that would look like and why you
> > > > think it's not going to work?
> > >
> > > If I understand correctly, the using the  DOC: comment block and
> > > extracting it would require you to manually update a comment in code
> > > that labels the libbpf version number and then cut a release. The
> > > problems are:
> > >
> > > 1) Having to do that manually
> > > 2) The docs on kernel.org would not show previous libbpf releases
> > > (just the ones that were released with different kernel versions)
> > >
> > > > > If you check out libbpf.readthedocs.io you can see what that would
> > > > > look like. I made a test release (v21.21.21) to show how easy this is.
> > > > > That is being pulled from my PR at github.com/libbpf/libbpf/pull/260.
> > > >
> > > > It looks pretty nice. Where does v21.21.21 come from, though?
> > >
> > > libbpf.readthedocs.org currently tracks my libbpf fork at
> > > github.com/grantseltzer/libbpf, I cut the 21.21.21 release there.
> > >
> > > What this demonstrates is that readthedocs pulls in any release or
> > > branch I enable in the admin panel and builds a seperate site for each
> > > one. You can see the release/branches by toggling them in the bottom
> > > left.
> > >
> > > > also weird that docs are under src/docs, not just under docs/, but I
> > > > assume that's a quick hack to demonstrate this?
> > >
> > > I can move that no problem. All the config files have relative paths
> > > that point at each other.
> > >
> > > > To be entirely honest, I'm already a bit lost on all the
> > > > possibilities. It would be great if you can summarize what's possible
> > > > and how it would look like.
> > >
> > > That's my fault, I'm not making this easy to review (2 different patch
> > > series, plus github PR). Here is a summary of the 3 different
> > > approaches I've presented. At the bottom I have my recommendation.
> > >
> > > 1) Integrate libbpf docs into the kernel documentation system:
> > >
> > > - Add libbpf documentation files (e.g. 'naming-convention',
> > > 'building-libbpf') under the Linux 'Documentation' directory.
> > > - Include a file which has sphinx directives to pull in API
> > > documentation from the code under tools/lib/bpf.
> > > - This documentation would appear on kernel.org/doc alongside all
> > > other kernel documentation
> > >
> > > Pro: Make use of existing kernel documentation infrastructure
> > > Con: In order to have the libbpf documentation be versioned based on
> > > github releases it would require manually updating comments in code.
> > > To get it how we really want it (i.e. select a libbpf release and see
> > > the documentation specific for it), it would likely require
> > > rearranging/duplicating code in libbpf under subdirectories.
> > > Contributing simple documentation has to go through the mailing list
> > > which is daunting for new contributors.
> > >
> > > 2) Have all libbpf documentation in the kernel repo under
> > > tools/lib/bpf/docs, including libbpf's own sphinx configuration files
> > >
> > > - The github mirror would pull in these documentation files and sphinx
> > > configuration files.
> > > - readthedocs would be configured to build off of the github libbpf mirror repo.
> > > - The documentation would be accessible at libbpf.readthedocs.org.
> > > - Users would be able to navigate documentation of different releases
> > > of libbpf easily. Maintainers would not need to do any manual work to
> > > make that happen.
> > >
> > > Pro: Documentation all in one place, in the kernel repo, integrates
> > > easily with the github mirror, and we easily get to version
> > > documentation by libbpf releases.
> > > Con: We don't make use of existing kernel documentation
> > > infrastructure. Contributing simple documentation has to go through
> > > the mailing list which is daunting for new contributors.
> > >
> > > 3) Host all the documentation on the libbpf github mirror
> > >
> > > - Documents (e.g. 'naming-convention', 'building-libbpf') would be
> > > available at libbpf.readthedocs.org
> > > - Sphinx configuration files would live in the libbpf github mirror
> > > - Code comment documentation would still go through the mailing list
> > >
> > > Pro: Documentation is explorable by different versions. Some
> > > documentation can be contributed via github which is easier than the
> > > mailing list.
> > > Con: Documentation would be scattered across different places.
> > >
> > > My recommendation:
> > >
> > > I would go with option 2, it feels like the best compromise. However,
> > > I'd like to contribute changes to the kernel documentation such that
> > > it can support versioning particular documentation files based on
> > > specified git hashes. That way we can have libbpf docs on kernel.org
> > > but still get to version docs based on libbpf releases, not kernel
> > > ones.
> > >
> > > I'm happy to explore other options, but if one of these sounds like
> > > something that we can agree on for now, I can submit a fresh patch for
> > > it.
> >
> > Honestly, I think option #3 would be best for actually getting more
> > docs contributions, because it will reduce the friction of getting
> > started. Figuring out the kernel mailing list submission process is
> > not a trivial problem.
>
> I can agree to that. This is also the easiest option to change,
> completely undo, or migrate off of. Since it's on github only we don't
> have to worry about all the different mailing lists. I think that
> makes it a really good starting point regardless.

Let's just go with option #1, let's put the docs in kernel repo under
Documentation/bpf/libbpf and copy/sync them in the sync script. That
will keep most libbpf stuff (except Github-specific Travis CI configs)
in one repo (kernel), reviewed by the bigger set of folks (not just me
on Github). Let's see how confusing having two libbpf documentation
sites will be (we can always add a sentence to README.md on Github to
point to the "canonical" source of documentation at
libbpf.readthedocs.io).

>
> My PR on the github repo is up to date and ready for review. Once
> merged I can seamlessly move libbpf.readthedocs.org to pull from that
> repo instead of my fork.
>
> Also I'd like to add you and whoever else as an admin, if you can sign
> up for readthedocs just let me know your username and i'll add you.
> And feel free to add any other libbpf maintainers that you think it'd
> be appropriate.

I signed up, my user is anakryiko, thanks.

>
> >
> > But I'm sure some people will have strong feelings about keeping docs
> > in the kernel source tree. Assuming we'd get a lot of push back for
> > option #3, I think the next best thing would be a hybrid of #1 and #2.
> > Host docs in kernel docs under Documentation/bpf/libbpf, so it will
> > get into kernel sources automatically. But also copy those docs into
> > Github mirror during sync under /docs and have readthedocs pull and
> > version it properly. That has a chance of creating a bit of confusion
> > for where exactly libbpf docs are (it would be libbpf.readthedocs.org,
> > versioned properly), but given docs will have the same source of truth
> > (modulo minor versioning differences, potentially), I think this might
> > be ok. WDYT? Are there any problems with that?
>
> The only issue I foresee is having the 'latest' docs on kernel.org/doc
> and having versioned docs on libbpf.readthedocs.org. That'd confuse
> me.

Yep, I share the feeling, but let's start with being good citizens in
the kernel. If that turns out to be too confusing and painful, we'll
reassess.

>
> >
> > Hosting docs under tools/libbpf/docs in kernel repo is the worst of
> > both worlds, IMO. Hard to contribute, but also not integrated with the
> > rest of kernel docs.
>
> Yea, that's also a good point!
> >
> > >
> > >
> > > >
> > > > As a general guidance, I think we should try to keep all the
> > > > documentation in one place (which means kernel sources, because that's
> > > > where API documentation will have to leave). As for config files,
> > > > unless they will "stick out" too much, I'd keep them close to the docs
> > > > themselves. If not, putting them in Github mirror is fine by me as
> > > > well.
> > > >
> > > > Pretty much the only important aspect, from my point of view, is that
> > > > docs are versioned according to the libbpf version, not kernel
> > > > version. Otherwise huge confusion will ensue for all the users of
> > > > libbpf, most of not all of which are using Github mirror.
> > > >
> > > > Does this make sense and is doable?
> > > >
> > > > > > >
> > > > > > > If you're wanting to replace the version code that appears at the top of
> > > > > > > the left column in the HTML output, though, it's going to be a bit
> > > > > > > harder.  I don't doubt we can do it, but it may require messing around
> > > > > > > with template files and such.
> > > > > > >
> > > > > > > Thanks,
> > > > > > >
> > > > > > > jon
