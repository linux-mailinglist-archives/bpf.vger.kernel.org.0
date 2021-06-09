Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F973A1B7F
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 19:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhFIRHg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 13:07:36 -0400
Received: from mail-vk1-f172.google.com ([209.85.221.172]:47103 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhFIRHf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Jun 2021 13:07:35 -0400
Received: by mail-vk1-f172.google.com with SMTP id 184so1115373vkz.13
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xON8sWR5COLWksxFGeQSqk9tRihtRpbx+5wIbcUhjfw=;
        b=Qo5LYf+OfO/XC13CCSZqKCgD0BFkdp0CMF8u6AJWf6egFpI7luEVvGD5ZjMmMb3LkV
         fJ7z5t5kGXAHykf5/TmTk3KDPCmlkimkbqjZ9J7DqolVIk9Hlr+ZQ30yAq1LlkydKvco
         eCncd4vW7Iju/TBsgZOOliJHeevNL4gm2QSQWvDcLg8J9Q8MpIkT/mZo/RQ2Wl2UmYWU
         VcgGMnQ6/RDL9EZ7gXOIWRKpjD54P+DDOUZsPYfMul5NQms3xotbXIL8pBXXfaGLqL8H
         q8Kw8bRUw6z3HeMIUe2wNyc6c3hATPu/68AN085JsBsh0EwQXbtOoRB0D/IjvG2B9aLU
         eiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xON8sWR5COLWksxFGeQSqk9tRihtRpbx+5wIbcUhjfw=;
        b=IqD23N6Nv2ypeWYOX2W141a2upcxm3AFMXUlhvBCQlYUIh7hu8bnoLDIgfI+XKUujy
         q4P4+YM+m3PLZjvMTPELTGGxujbncsDMUMi89kzdAw6LIf0vesJWpZEqLvyb2eXZFVXs
         AE+u1qICRcQVtQ7MUsxitHN65Po8tqITojvbWBwpOUlDprAsFPnITuUJ7t7IAhKIv9ys
         5UQhasfuXt+B+qEnasttgZ5oR3/mbewEBTshk62FbbvRZXV49asRqgW2d/q7ue+KR1Ep
         y5qkC00RESvRbkk18SNxV9whrg1RTbCWMAnXHWcgOljH0j9Dxwxypvu3fmmyM40XkcDW
         IFcw==
X-Gm-Message-State: AOAM532Lqzb4nCcVEZKdqhN6rwEimyaexRmozDxN2zH3stcyYemgQg40
        BS7v693oIB7NnVOQRDmJdGfGtmTtpAJoeh3VBAxgmrvLGZM=
X-Google-Smtp-Source: ABdhPJwzRuyqxvhpBZcYHzJATBDWcTimFcEuSxifgaU9kCXp8k8nlW06vYqv7YznJFTZn31JTBajdLZb/iiQaT/11os=
X-Received: by 2002:a1f:93c2:: with SMTP id v185mr1363826vkd.2.1623258264542;
 Wed, 09 Jun 2021 10:04:24 -0700 (PDT)
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
 <CAO658oXRN=JnP+e=qM2-uBu94BxoWCyHcScOgSwxpoHOw5ByLQ@mail.gmail.com> <CAEf4Bzaupx7dvv8nZAQKqo2UbdRmYgCb=54Uy0x5+96UTD6DTA@mail.gmail.com>
In-Reply-To: <CAEf4Bzaupx7dvv8nZAQKqo2UbdRmYgCb=54Uy0x5+96UTD6DTA@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Wed, 9 Jun 2021 13:04:13 -0400
Message-ID: <CAO658oW-XiuS_FLVCkj1pTtQS5MPxk=jyA+-LRkiMgt=27e21A@mail.gmail.com>
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

On Mon, Jun 7, 2021 at 6:45 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:

> So I assume you looked at the DOC: block that Jonathan suggested
> above? Can you walk us a bit on how that would look like and why you
> think it's not going to work?

If I understand correctly, the using the  DOC: comment block and
extracting it would require you to manually update a comment in code
that labels the libbpf version number and then cut a release. The
problems are:

1) Having to do that manually
2) The docs on kernel.org would not show previous libbpf releases
(just the ones that were released with different kernel versions)

> > If you check out libbpf.readthedocs.io you can see what that would
> > look like. I made a test release (v21.21.21) to show how easy this is.
> > That is being pulled from my PR at github.com/libbpf/libbpf/pull/260.
>
> It looks pretty nice. Where does v21.21.21 come from, though?

libbpf.readthedocs.org currently tracks my libbpf fork at
github.com/grantseltzer/libbpf, I cut the 21.21.21 release there.

What this demonstrates is that readthedocs pulls in any release or
branch I enable in the admin panel and builds a seperate site for each
one. You can see the release/branches by toggling them in the bottom
left.

> also weird that docs are under src/docs, not just under docs/, but I
> assume that's a quick hack to demonstrate this?

I can move that no problem. All the config files have relative paths
that point at each other.

> To be entirely honest, I'm already a bit lost on all the
> possibilities. It would be great if you can summarize what's possible
> and how it would look like.

That's my fault, I'm not making this easy to review (2 different patch
series, plus github PR). Here is a summary of the 3 different
approaches I've presented. At the bottom I have my recommendation.

1) Integrate libbpf docs into the kernel documentation system:

- Add libbpf documentation files (e.g. 'naming-convention',
'building-libbpf') under the Linux 'Documentation' directory.
- Include a file which has sphinx directives to pull in API
documentation from the code under tools/lib/bpf.
- This documentation would appear on kernel.org/doc alongside all
other kernel documentation

Pro: Make use of existing kernel documentation infrastructure
Con: In order to have the libbpf documentation be versioned based on
github releases it would require manually updating comments in code.
To get it how we really want it (i.e. select a libbpf release and see
the documentation specific for it), it would likely require
rearranging/duplicating code in libbpf under subdirectories.
Contributing simple documentation has to go through the mailing list
which is daunting for new contributors.

2) Have all libbpf documentation in the kernel repo under
tools/lib/bpf/docs, including libbpf's own sphinx configuration files

- The github mirror would pull in these documentation files and sphinx
configuration files.
- readthedocs would be configured to build off of the github libbpf mirror repo.
- The documentation would be accessible at libbpf.readthedocs.org.
- Users would be able to navigate documentation of different releases
of libbpf easily. Maintainers would not need to do any manual work to
make that happen.

Pro: Documentation all in one place, in the kernel repo, integrates
easily with the github mirror, and we easily get to version
documentation by libbpf releases.
Con: We don't make use of existing kernel documentation
infrastructure. Contributing simple documentation has to go through
the mailing list which is daunting for new contributors.

3) Host all the documentation on the libbpf github mirror

- Documents (e.g. 'naming-convention', 'building-libbpf') would be
available at libbpf.readthedocs.org
- Sphinx configuration files would live in the libbpf github mirror
- Code comment documentation would still go through the mailing list

Pro: Documentation is explorable by different versions. Some
documentation can be contributed via github which is easier than the
mailing list.
Con: Documentation would be scattered across different places.

My recommendation:

I would go with option 2, it feels like the best compromise. However,
I'd like to contribute changes to the kernel documentation such that
it can support versioning particular documentation files based on
specified git hashes. That way we can have libbpf docs on kernel.org
but still get to version docs based on libbpf releases, not kernel
ones.

I'm happy to explore other options, but if one of these sounds like
something that we can agree on for now, I can submit a fresh patch for
it.


>
> As a general guidance, I think we should try to keep all the
> documentation in one place (which means kernel sources, because that's
> where API documentation will have to leave). As for config files,
> unless they will "stick out" too much, I'd keep them close to the docs
> themselves. If not, putting them in Github mirror is fine by me as
> well.
>
> Pretty much the only important aspect, from my point of view, is that
> docs are versioned according to the libbpf version, not kernel
> version. Otherwise huge confusion will ensue for all the users of
> libbpf, most of not all of which are using Github mirror.
>
> Does this make sense and is doable?
>
> > > >
> > > > If you're wanting to replace the version code that appears at the top of
> > > > the left column in the HTML output, though, it's going to be a bit
> > > > harder.  I don't doubt we can do it, but it may require messing around
> > > > with template files and such.
> > > >
> > > > Thanks,
> > > >
> > > > jon
