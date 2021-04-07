Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D57B356DB9
	for <lists+bpf@lfdr.de>; Wed,  7 Apr 2021 15:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243133AbhDGNrA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Apr 2021 09:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245306AbhDGNq7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Apr 2021 09:46:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 852FF61382;
        Wed,  7 Apr 2021 13:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617803209;
        bh=fY8O2/1gVYg0u4oNDjrQG8Vqno4tPQZ8l6Gtxj85mCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HA571evbtYN676q3iZ1xeaF2Xbb0renzazRSaARDuHYtqrBMg6R8BVfD/UU6gk/W9
         YwskdAWf4baNWLPt2fdLMpzutYGtf6vE3T5vm52eBZBFBvHGAAVUK9QuT9l7eIvvpV
         jH0fFicERiSDOH6kYCR4EUaTV37qDnZVYQoRba2u1DXtuKfX0UlmubQjJUBFL2ZPSl
         GC4cg3s7RkodS5X7TAyj/QxbcA0xHo27bOym9aGJ52O4DExxZhDwYlpzkGCEcu2yVB
         cExGEL4psaw0f0/ZHiuNlbk2gq6l1cay5TSPyOfJPzQ/3dETHcknOy8xoZNPgXZyRj
         +9UN4WRJoKlmA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A02C040647; Wed,  7 Apr 2021 10:46:46 -0300 (-03)
Date:   Wed, 7 Apr 2021 10:46:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     sedat.dilek@gmail.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, kernel-team@fb.com,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH kbuild v4] kbuild: add an elfnote for whether vmlinux is
 built with lto
Message-ID: <YG23xiRqJLYRtZgQ@kernel.org>
References: <20210401232723.3571287-1-yhs@fb.com>
 <CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN=UBNdQiO3g@mail.gmail.com>
 <CA+icZUVKCY4UJfSG_sXjZHwfOQZfBZQu0pj1VZ9cXX4e7w0n6g@mail.gmail.com>
 <c6daf068-ead0-810b-2afa-c4d1c8305893@fb.com>
 <CA+icZUWYQ8wjOYHYrTX52AbEa3nbXco6ZKdqeMwJaZfHuJ5BhA@mail.gmail.com>
 <128db515-14dc-4ff1-eacb-8e48fc1f6ff6@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <128db515-14dc-4ff1-eacb-8e48fc1f6ff6@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Apr 06, 2021 at 11:23:27PM -0700, Yonghong Song escreveu:
> On 4/6/21 8:01 PM, Sedat Dilek wrote:
> > On Tue, Apr 6, 2021 at 6:13 PM Yonghong Song <yhs@fb.com> wrote:
> > > Masahiro and Michal,

> > > Friendly ping. Any comments on this patch?

> > > The addition LTO .notes information emitted by kernel is used by pahole
> > > in the following patch:
> > >      https://lore.kernel.org/bpf/20210401025825.2254746-1-yhs@fb.com/
> > >      (dwarf_loader: check .notes section for lto build info)

> > the above pahole patch has this define and comment:

> > -static bool cus__merging_cu(Dwarf *dw)
> > +/* Match the define in linux:include/linux/elfnote.h */
> > +#define LINUX_ELFNOTE_BUILD_LTO 0x101

> > ...and does not fit with the define and comment in this kernel patch:

> > +#include <linux/elfnote.h>
> > +
> > +#define LINUX_ELFNOTE_LTO_INFO 0x101

> Thanks, Sedat. I am aware of this. I think we can wait in pahole
> to make a change until the kernel patch is finalized and merged.
> The kernel patch may still change as we haven't get
> maintainer's comment. This will avoid unnecessary churn's
> in pahole side.

So, I tested with clang 12 on fedora rawhide as well on fedora 33, and
I'm satisfied with the current state to release v1.21, Masahiro, have
you had the time to look at this?

Yonghong, as we have a fallback in case the ELF note isn't available, I
think we're safe even if the notes patch merge gets delayed, right?

- Arnaldo
