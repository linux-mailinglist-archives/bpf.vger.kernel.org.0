Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D0732C286
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhCCW2X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352707AbhCCEME (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 23:12:04 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E7CC06178B
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 20:11:11 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id p193so23119519yba.4
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 20:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5TyZwqBmmQrvHmUZ9mAlqhQd5Agy5p5+XYLxSoyb1oc=;
        b=fIf/7AiOgL7kP4xrg97N/9EaF3m9t4CC4VLvlCzvtzpPrDboZ1oPhXTXlSwDYVN1B9
         stsnM1rvnFMVH9lKeqVD3YJ6kDggsQOS7r1p1JTNw3hFGJM45b7q8qigOB+WTLWZ3AKy
         uWGAZyenWIpsl73ciRJOq7oiiTF48Dp7+b4YXzZyrTOXMYwRg5JSOgyOOgbtY7wEARaj
         lJistrKQ7K43/21dljUMICdgtsq/RnqBb20NYQWjlhEfrcaypuid+Op8lMeBxoIJzUtI
         RWLi0SkSZa67celX3GZcYqkGYOBV8YPz39vaKxT6raj1zlN2XoBMvAoviAo9ixbLITBl
         DlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TyZwqBmmQrvHmUZ9mAlqhQd5Agy5p5+XYLxSoyb1oc=;
        b=o/j79OrZ8f/KJe2BSA+e8ule1tTycFkex4hxn7ZQd0BTv+QV1yO+Xc+/UOL3L5Vufz
         7kJQOUxTQEnc/NkfwXaN0hmvFzCXf6kvA/WGQfpiuNMFLpQyciA9CsvBMk8dCQ6vGwR+
         Up0h7zn4uWcE2QVT9SKSDlniz3DkZ7CLTb7hfb7Dm2PgtYc1YT7pYLhwU+rMeDOMdu9k
         CGf3sA7gRZhbvwZVVgdOKIrZRc4wSn7ZjmZoHLAsqdkntuX6kQDswVaUxKY4fyy+xu9K
         Jv9O6Y5LWunIhCVuL2Ukera3mRllbjjKRKNQGlrIYGB+LHkYGWltNEoBp5C4m5cW9y8f
         APAg==
X-Gm-Message-State: AOAM531aUWJQHzDGWZCy0l2a3B5Gkldf17F66qt67QYman56PuOAk4o3
        xNaUsVrsWfqMDxFogB6u0V6ALonxta5cwNTCThY=
X-Google-Smtp-Source: ABdhPJyOd9ypJSuT6YpDNhdpr+/6Gx67vZWceHYE6BocuG8YFjkJpSz0wqwGg8DeyzC4K5wpAdJiY2y6xZ91tUe8PDs=
X-Received: by 2002:a25:cc13:: with SMTP id l19mr35796325ybf.260.1614744671247;
 Tue, 02 Mar 2021 20:11:11 -0800 (PST)
MIME-Version: 1.0
References: <B8801F77-37E8-4EF8-8994-D366D48169A3@araalinetworks.com>
 <CAEf4Bzbgw49w2PtowsrzKQNcxD4fZRE6AKByX-5-dMo-+oWHHA@mail.gmail.com>
 <CADmGQ+3_h22VmJPddhf4Vy2J4PwwkhJAj+N3qSV7vERb+PZw8Q@mail.gmail.com>
 <CADmGQ+0JMBm8QANoEg5V7pDF6SadSN=u0y1w8BTrYOg5OOWa0g@mail.gmail.com>
 <CAEf4BzY9VsZi4mJWy3iKRbJw4d_kOJVivPWPstWiG6xcOh6Efg@mail.gmail.com> <CADmGQ+3DQ2NVwDZJX-oS75MBhFaCNW2rgzGKFWPHugBVc=EMTw@mail.gmail.com>
In-Reply-To: <CADmGQ+3DQ2NVwDZJX-oS75MBhFaCNW2rgzGKFWPHugBVc=EMTw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 2 Mar 2021 20:11:00 -0800
Message-ID: <CAEf4Bza3ETtToi8CMk13FyySVu=Qa0u35mH8RPeyfyw8aZFqgw@mail.gmail.com>
Subject: Re: [PATCH bpf v1] Add `core_btf_path` to `bpf_object_open_opts` to
 pass BTF path from skeleton program
To:     Vamsi Kodavanty <vamsi@araalinetworks.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 13, 2021 at 7:52 PM Vamsi Kodavanty
<vamsi@araalinetworks.com> wrote:
>
> On Wed, Jan 13, 2021 at 7:21 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Jan 13, 2021 at 2:17 PM Vamsi Kodavanty
> > <vamsi@araalinetworks.com> wrote:
> > >
> > > On Mon, Jan 11, 2021 at 7:33 PM Vamsi Kodavanty
> > > <vamsi@araalinetworks.com> wrote:
> > > >
> > > > Andrii,
> > > >    Thank you for the detailed review. I will address them as well as
> > > > the self tests. And will send out a new patch addressing them and
> > > > conforming to style/expectations.
> > > >
> > > > Cheers
> > > > Vamsi.
> > > >
> > > Andrii,
> > >       I understand the `bpf` repository being a mirror of the
> > > `bpf-next` tools/lib/bpf. Do the patches
> > > to `bpf` go back into `bpf-next`. I see there is a script for
> > > `bpf-next` to `bpf`syncs.
> > >       I ask because the `btf_vmlinux_override` changes only exist in
> > > the `bpf` repo. So, I make my
> > > changes in `bpf`?. In that case what happens to the `selftests` which
> > > are in `bpf-next`. And they
> > > won't have any idea of the new open option 'core_btf_path` that is
> > > being introduced.
> > >
> >
> > There are two Linux upstream repositories to which BPF and libbpf
> > patches are applied: bpf ([0]) and bpf-next ([1]). Fixes usually go
> > into bpf, while all the new features go into bpf-next. They are
> > periodically merged and thus converge.
> >
> > Then, specifically for libbpf, there is a Github mirror ([2]), which
> > is synced by me periodically from bpf-next and bpf trees. This Github
> > repo is what is considered to be "canonical" libbpf repo for the
> > purposes of building libbpf packages and consuming libbpf in user
> > applications. You shouldn't concern yourself with this one when
> > submitting patches, because it's a derivative of upstream
> > repositories.
> >
> > What is confusing to me, though, is that all three of them have code
> > with btf_vmlinux_override, so I'm curious which "bpf" repository did
> > you find that doesn't yet have btf_vmlinux_override?
> >
> >   [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
> >   [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> >   [2] https://github.com/libbpf/libbpf
> >
>
> Thank you again. I was looking at [1]. I cloned the repo today morning and
> noticed the absence. I just did a 'git pull' and it seems to have the
> `btf_vmlinux_override` now. So, I will use `bpf-next`. Thank you for the
> repo links. Also, my earlier diffs were incorrectly using the `libbpf` repo.
>

Hi Vamsi,

Did you get a chance to finish this patch by any chance? It seems like
the request to support the ability to provide a custom vmlinux BTF
(usually to get a chance to use BPF CO-RE on older kernels) comes up
quite often recently, so it would be good to have this landed. Please
let me know if you can finish this up. It's ok if not, but please let
us know. Thanks!

> Regards
> Vamsi.
>
> > > Thanks again. Hopefully this is my last question before I come back to
> > > you with a proper patch.
> > >
> > > Cheers
> > > Vamsi.
> > >
> > > > On Mon, Jan 11, 2021 at 2:02 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jan 8, 2021 at 6:36 PM Vamsi Kodavanty <vamsi@araalinetworks.com> wrote:
> > > > > >
> > > > > > Andrii,
> > > > > >      I have made the following changes as discussed to add an option to the `open_opts`
> > > > > > to take in the BTF.
> > > > > >      Please do take a look. Also, I am not sure what the procedure is for submitting patches/reviews.
> > > > > > If anyone has any pointers to a webpage where this is described I can go through it. But, below are
> > > > > > the proposed changes.
> > > > > >
> > > > >
> > > > > Daniel already gave you pointers. Also make sure you add [PATCH
> > > > > bpf-next] prefix to email subject to identify the patch is for
> > > > > bpf-next kernel tree.
> > > > > And with all changes like this we should also add selftests,
> > > > > exercising new features. Please take a look at
> > > > > tools/testing/selftests/bpf. I think updating
> > > > > test_progs/test_core_reloc.c in there to use this instead of
> > > > > bpf_object__load_xattr() might be enough of the testing.
> > > > >
> > > > > > Best Regards,
> > > > > > Vamsi.
> > > > > >
> > > > > > ---
> > > > > >  src/libbpf.c | 56 +++++++++++++++++++++++++++++++++++++---------------
> > > > > >  src/libbpf.h |  4 +++-
> > > > > >  2 files changed, 43 insertions(+), 17 deletions(-)
> > > > > >
> >
> > [...]
