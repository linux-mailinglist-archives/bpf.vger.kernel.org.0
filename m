Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3F2403E4B
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 19:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349970AbhIHRWa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 13:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhIHRWa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 13:22:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C35EC061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 10:21:22 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1816914pjc.3
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FXTcKcmGY1UxxBlUVRbG2vY+y1uYMIyY37NBzfKYFuM=;
        b=esZvvYPtvBx+9dTOelRUMG7mLL3AhQSQjcCiXE23O+dEY3JmpvVozHuZI39Dq3gc6/
         Dny5Jz8PYaDGiUJtOjMIho/uw+ON2f1tN8xTEHxHgC0sBHphQhB8ulTf+NRPwnKNED1t
         6Jlgm3Lso2Ux9HB9mvYDGpxQwjtEhKRye76tB8iU1Woy4Mfd9rEKft3PIxEPwlm19xuc
         8MeVjHF95YVheixeGLSZ2dW+eYpscy0x/aB73lEnrGiRe7oJqpffNhDuELmrZWuhnIaO
         wSM/Fq7Q6khxBaZ52wCkCxZ6ph7p0C+/JeaqboPNJhk42aCS6cIYhnkCZRPWmfH5oSVp
         zNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FXTcKcmGY1UxxBlUVRbG2vY+y1uYMIyY37NBzfKYFuM=;
        b=ZSlR72cMk3HSMeaQ7jC4jpZFiklUIAKHI/Ccj9mpeQi9RXPknTFoDnsTB4RRjI8ZAc
         J3ZSdE/0c59mDQCQy/ZwKK4Pz09qIGI1ufa9uuyluGetrR8yWZ6Eq8hK5wGAT4H2w/Cm
         v6jADVm05cUw6vLQWb4wMcE391QONPM8/BsqC0KqUUGlc4H9WV8QPZNhOJlVUjIJI/Dg
         AIutQpNrBzLnnhitvg9G1MzG6ozifubo9HmduQz/BzQO2y2AWQ2LrXw3R8IKtXtQrfFR
         JgUtSkjV+eAM7fbVEV+I8sVVxOI5gTveIVIUwrw+7JwHMEHdZ1s66P5E/sc6eGmwQcrS
         9xOQ==
X-Gm-Message-State: AOAM531DmN5M+QfXRc+Eu0JRHrXbX/cdYCb1nol91nHlBYgmG3s8YMrG
        G9xvnL59JckntPnMdNIFjDw=
X-Google-Smtp-Source: ABdhPJzomA3YP+r8f1dcbn+fnO7FNZLj0bArQ/FyVeoMZo1Th0JCbVBGM6YyPh7+5pEVrXOiDpJaog==
X-Received: by 2002:a17:90b:1493:: with SMTP id js19mr1199459pjb.172.1631121681658;
        Wed, 08 Sep 2021 10:21:21 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::4:97c5])
        by smtp.gmail.com with ESMTPSA id f6sm3157595pfa.110.2021.09.08.10.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:21:21 -0700 (PDT)
Date:   Wed, 8 Sep 2021 10:21:18 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     Yonghong Song <yhs@fb.com>, Liam Howlett <liam.howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Michel Lespinasse <walken@google.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
Message-ID: <20210908172118.n2f4w7epm6hh62zf@ast-mbp.dhcp.thefacebook.com>
References: <20210908044427.3632119-1-yhs@fb.com>
 <ebcddf07-f329-05fa-8fdc-b2b9d6b0127b@iogearbox.net>
 <20210908135326.GZ1200268@ziepe.ca>
 <YTjFcek5B3ltYtG3@hirez.programming.kicks-ass.net>
 <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
 <20210908151230.m2zyslt4qrufm4bv@revolver>
 <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
 <CAMOZA0+2KLgYTXDZHGUYFnYezee=_hH6kFVM+-n2ZQuFTfh6yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMOZA0+2KLgYTXDZHGUYFnYezee=_hH6kFVM+-n2ZQuFTfh6yg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 08, 2021 at 07:09:23PM +0200, Luigi Rizzo wrote:
> On Wed, Sep 8, 2021 at 6:10 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 9/8/21 8:12 AM, Liam Howlett wrote:
> > > * Luigi Rizzo <lrizzo@google.com> [210908 10:44]:
> > >> On Wed, Sep 8, 2021 at 4:16 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >>>
> > >>> On Wed, Sep 08, 2021 at 10:53:26AM -0300, Jason Gunthorpe wrote:
> > >>>> On Wed, Sep 08, 2021 at 02:20:17PM +0200, Daniel Borkmann wrote:
> > >>>>
> > >>>>>> The warning is due to commit 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to find_vma*()")
> > >>>>>> which added mmap_assert_locked() in find_vma() function. The mmap_assert_locked() function
> > >>>>>> asserts that mm->mmap_lock needs to be held. But this is not the case for
> > >>>>>> bpf_get_stack() or bpf_get_stackid() helper (kernel/bpf/stackmap.c), which
> > >>>>>> uses mmap_read_trylock_non_owner() instead. Since mm->mmap_lock is not held
> > >>>>>> in bpf_get_stack[id]() use case, the above warning is emitted during test run.
> > >> ...
> > >>>>> Luigi / Liam / Andrew, if the below looks reasonable to you, any objections to route the
> > >>>>> fix with your ACKs via bpf tree to Linus (or strong preference via -mm fixes)?
> > >>>>
> > >>>> Michel added this remark along with the mmap_read_trylock_non_owner:
> > >>>>
> > >>>>      It's still not ideal that bpf/stackmap subverts the lock ownership in this
> > >>>>      way.  Thanks to Peter Zijlstra for suggesting this API as the least-ugly
> > >>>>      way of addressing this in the short term.
> > >>>>
> > >>>> Subverting lockdep and then adding more and more core MM APIs to
> > >>>> support this seems quite a bit more ugly than originally expected.
> > >>>>
> > >>>> Michel's original idea to split out the lockdep abuse and put it only
> > >>>> in BPF is probably better. Obtain the mmap_read_trylock normally as
> > >>>> owner and then release ownership only before triggering the work. At
> > >>>> least lockdep will continue to work properly for the find_vma.
> > >>>
> > >>> The only right solution to all of this is the below. That function
> > >>> downright subverts all the locking rules we have. Spreading the hacks
> > >>> any further than that one function is absolutely unacceptable.
> > >>
> > >> I'd be inclined to agree that we should not introduce hacks around
> > >> locking rules. I don't know enough about the constraints of
> > >> bpf/stackmap, how much of a performance penalty do we pay with Peter's
> > >> patch,
> > >> and ow often one is expected to call this function ?
> > >>
> > >> cheers
> > >> luigi
> > >
> > > The hack already exists.  The symptom of the larger issue is that
> > > lockdep now catches the hack when using find_vma().
> > >
> > > If Peter's solution is acceptable to the bpf folks, then we can go ahead
> > > and drop the option of using the non_owner variant - which would be
> > > best.  Otherwise the hack around the locking rule still exists as long
> > > as the find_vma() interface isn't used.
> >
> > Hi, Peter, Luigi, Liam, Jason,
> >
> > Peter's solution will definitely break user applications using
> > BPF_F_USER_BUILD_ID feature
> 
> Again I am ignorant on the details so if you can clarify the following
> it may help me and others to better understand the problem:
> 
> 1. Peter's patch appears to just take the same "fallback" path
>    that would be taken if the trylock failed.
>    Is this really a breakage or just loss of performance ?
>    I would expect the latter, since it is called "fallback".

As Yonghong explained it's a user space breakage.
User space tooling expects build_id to be available 99.999% of the time
and that's what users observed in practice.
They've built a bunch of tools on top of this feature.
The data from these tools goes into various datacenter tables
and humans analyze it later.
So Peter's proposal is not acceptable. We don't want to get yelled at.

> 2. Assuming it is just loss of performance, it becomes important to

It's nothing to do with performance.
