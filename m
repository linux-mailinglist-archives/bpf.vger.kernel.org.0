Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7ED2F599F
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 04:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbhANDxG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jan 2021 22:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbhANDxE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jan 2021 22:53:04 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B98C061575
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 19:52:18 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id e18so6179939ejt.12
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 19:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=araalinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5V9fSXpgt/ilvMDvrB8z52LJ1O1IHUSmpPum4oGbhsA=;
        b=VSf6N27wbK0IJXT1fYtXj5/GhgyNYSJMRW5EmUo1BUvovst9eF+SO3G59Rb2beSLzE
         R+tc+1cn49/Qsoo6qiltJdHvxLthb6YPOOiDnOblqpsTzVxmz//72MPPKpgKjsz4dXRT
         06JcdBAWcfchHGmjzVHPmJeY5JGSuiuDP1sLhSy7O5niSUvDXJjKRqnLebd2562eiQNa
         rZl/xejHnmDzHoNWcLoi2VSj6uKPQrlVl9cp5vSiD96aVBHwo9wbPzPbXlSpzoc8EvOI
         I48Z6VTU+VynuLURWniwBkF7S4azzK8K9c18BYtfb3nftUH4o8EMmzRu//IL2is64n9p
         w6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5V9fSXpgt/ilvMDvrB8z52LJ1O1IHUSmpPum4oGbhsA=;
        b=aEoKrSEAwd9lpXTsH1XvhFWoY/XtGS2Jgw/fxtqsdfE3sz7ZIeFPeKUdpMAF8HfYil
         dkyzmPUSP0d27PhJkzAr4ZPjBWzA/x5qCYg7MyTncOcFgNBFYrCAw4JFNO/5RdmkWRTW
         pC1DV2jyT0VOFZXrosNJp+kUFYk79ftWJP+nBVwu47JAj3RXDWPDqodKkJUvaF8ZXG+l
         Izo30gbjVmZS/9TfVTiyu+NvdQfFDyNcqslKH/1KVPgjPaR+ajj/qEQ0ymjegls3YyD8
         a0/qe2pJ7rD/ynw/sJ1jNSIzEHEjJSTFsyItPyHwTvIWJwMpwbfcNxgijDtSFixnwz+r
         niBQ==
X-Gm-Message-State: AOAM530Fx9+ey1yO0pOlMVUzX2MCUhhonI2/n8pFdojd+XPz+bI61Q0f
        DQYCdWBkkB5fE7hofAM/yFZL5jrdd7vlttbXXnyQOVjgYjeK7Q==
X-Google-Smtp-Source: ABdhPJySkkRyCicU3I0pUcr27InJL/gYdqTgO3YPD+leTGfwcNXb+RD5ZmhIiYVf4Pqp5MZ35S/4FP/AT4tpRlOb8Jo=
X-Received: by 2002:a17:906:af75:: with SMTP id os21mr3943961ejb.330.1610596337104;
 Wed, 13 Jan 2021 19:52:17 -0800 (PST)
MIME-Version: 1.0
References: <B8801F77-37E8-4EF8-8994-D366D48169A3@araalinetworks.com>
 <CAEf4Bzbgw49w2PtowsrzKQNcxD4fZRE6AKByX-5-dMo-+oWHHA@mail.gmail.com>
 <CADmGQ+3_h22VmJPddhf4Vy2J4PwwkhJAj+N3qSV7vERb+PZw8Q@mail.gmail.com>
 <CADmGQ+0JMBm8QANoEg5V7pDF6SadSN=u0y1w8BTrYOg5OOWa0g@mail.gmail.com> <CAEf4BzY9VsZi4mJWy3iKRbJw4d_kOJVivPWPstWiG6xcOh6Efg@mail.gmail.com>
In-Reply-To: <CAEf4BzY9VsZi4mJWy3iKRbJw4d_kOJVivPWPstWiG6xcOh6Efg@mail.gmail.com>
From:   Vamsi Kodavanty <vamsi@araalinetworks.com>
Date:   Wed, 13 Jan 2021 19:52:06 -0800
Message-ID: <CADmGQ+3DQ2NVwDZJX-oS75MBhFaCNW2rgzGKFWPHugBVc=EMTw@mail.gmail.com>
Subject: Re: [PATCH bpf v1] Add `core_btf_path` to `bpf_object_open_opts` to
 pass BTF path from skeleton program
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 13, 2021 at 7:21 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jan 13, 2021 at 2:17 PM Vamsi Kodavanty
> <vamsi@araalinetworks.com> wrote:
> >
> > On Mon, Jan 11, 2021 at 7:33 PM Vamsi Kodavanty
> > <vamsi@araalinetworks.com> wrote:
> > >
> > > Andrii,
> > >    Thank you for the detailed review. I will address them as well as
> > > the self tests. And will send out a new patch addressing them and
> > > conforming to style/expectations.
> > >
> > > Cheers
> > > Vamsi.
> > >
> > Andrii,
> >       I understand the `bpf` repository being a mirror of the
> > `bpf-next` tools/lib/bpf. Do the patches
> > to `bpf` go back into `bpf-next`. I see there is a script for
> > `bpf-next` to `bpf`syncs.
> >       I ask because the `btf_vmlinux_override` changes only exist in
> > the `bpf` repo. So, I make my
> > changes in `bpf`?. In that case what happens to the `selftests` which
> > are in `bpf-next`. And they
> > won't have any idea of the new open option 'core_btf_path` that is
> > being introduced.
> >
>
> There are two Linux upstream repositories to which BPF and libbpf
> patches are applied: bpf ([0]) and bpf-next ([1]). Fixes usually go
> into bpf, while all the new features go into bpf-next. They are
> periodically merged and thus converge.
>
> Then, specifically for libbpf, there is a Github mirror ([2]), which
> is synced by me periodically from bpf-next and bpf trees. This Github
> repo is what is considered to be "canonical" libbpf repo for the
> purposes of building libbpf packages and consuming libbpf in user
> applications. You shouldn't concern yourself with this one when
> submitting patches, because it's a derivative of upstream
> repositories.
>
> What is confusing to me, though, is that all three of them have code
> with btf_vmlinux_override, so I'm curious which "bpf" repository did
> you find that doesn't yet have btf_vmlinux_override?
>
>   [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
>   [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
>   [2] https://github.com/libbpf/libbpf
>

Thank you again. I was looking at [1]. I cloned the repo today morning and
noticed the absence. I just did a 'git pull' and it seems to have the
`btf_vmlinux_override` now. So, I will use `bpf-next`. Thank you for the
repo links. Also, my earlier diffs were incorrectly using the `libbpf` repo.

Regards
Vamsi.

> > Thanks again. Hopefully this is my last question before I come back to
> > you with a proper patch.
> >
> > Cheers
> > Vamsi.
> >
> > > On Mon, Jan 11, 2021 at 2:02 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Fri, Jan 8, 2021 at 6:36 PM Vamsi Kodavanty <vamsi@araalinetworks.com> wrote:
> > > > >
> > > > > Andrii,
> > > > >      I have made the following changes as discussed to add an option to the `open_opts`
> > > > > to take in the BTF.
> > > > >      Please do take a look. Also, I am not sure what the procedure is for submitting patches/reviews.
> > > > > If anyone has any pointers to a webpage where this is described I can go through it. But, below are
> > > > > the proposed changes.
> > > > >
> > > >
> > > > Daniel already gave you pointers. Also make sure you add [PATCH
> > > > bpf-next] prefix to email subject to identify the patch is for
> > > > bpf-next kernel tree.
> > > > And with all changes like this we should also add selftests,
> > > > exercising new features. Please take a look at
> > > > tools/testing/selftests/bpf. I think updating
> > > > test_progs/test_core_reloc.c in there to use this instead of
> > > > bpf_object__load_xattr() might be enough of the testing.
> > > >
> > > > > Best Regards,
> > > > > Vamsi.
> > > > >
> > > > > ---
> > > > >  src/libbpf.c | 56 +++++++++++++++++++++++++++++++++++++---------------
> > > > >  src/libbpf.h |  4 +++-
> > > > >  2 files changed, 43 insertions(+), 17 deletions(-)
> > > > >
>
> [...]
