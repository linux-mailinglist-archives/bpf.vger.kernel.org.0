Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6D7403E25
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 19:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhIHRKq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 13:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhIHRKp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 13:10:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02362C061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 10:09:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n27so5604501eja.5
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 10:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHtgMWyzDNnZhRHsFAyIiwKY5ZE/+saSyjV0LIIBwfU=;
        b=eIvwXEJ39rNOrLUIF/hRy/ntwr16AcVpFXMYuNAdtXwRRWf3sUpD+swY3FxNZhrs9Q
         8INR7pBFdEgzIMAd+EC1dP5QhrZt6zp6MHGbgpNV3mJ71swD8kzoA5+iKR7zGwaetxGi
         wt4pOOHfX9sXOXPwAN6vRYu4PaSLGc7d6bq5E/x51gdE7pWgMNhi6+Yj3+E22roxynL8
         fSeUg7MeAwUCEshyYT5czbBpIpo3sLMPNMXj300GiUM0yos2rEjBeAmt/hZYOkTyxh2y
         GP3rCTt6OrGXbE0O83R7x5WfJY50HRPP7cKFHi/yaE9xrDVY9IXA7Qd/dOOi2pDcJ5bo
         +ywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHtgMWyzDNnZhRHsFAyIiwKY5ZE/+saSyjV0LIIBwfU=;
        b=YMetxqIw1WStPIFwBTJOQAGr5UAQQ3Js9kIL10jv+6YzKwZHeom1zc4GffUGpT3pWF
         GIPUgu2Q20IzKKnUrhm2vO487r95OSN8MlMXgq+mSYq1WwzsM+/zPe9aafp6eTeRx2qh
         h4Fjix229ZH+Flx7NdD/R4BWuW+wN/OYDdgKsgmmr3VEUaZNgArit8xlZfJfIXVsPlEv
         jKfOG9p5npaJ+PhnqgzlJMZ0tkRyH+mX+Lr890jdeEzTRokvyrEMZCg5BeeE6qOUfcCJ
         G/tmbr0uFtELmUzpOH765Tdb9x5i7YwKo2HsOc/ZEu5vW4OHiFkPlTL3zRJhti7hx/Ko
         Fxsw==
X-Gm-Message-State: AOAM531U1FSlPePSgMMtxccXSrkKRHLDUEifBCm5ux91zy9OhUHDTz5f
        8VNYk2PHBDifHJTrCTqHB+MXjkqcAGqwCwfo4Xk8VA==
X-Google-Smtp-Source: ABdhPJx27s5VEnYXZCusQFMWhYQE0tirmNpwOb0SmDjaXnGCRGisp+oqqHw4eZjRuvnTq3XKlPLP2bHvXYOOtyVml6w=
X-Received: by 2002:a17:907:76ee:: with SMTP id kg14mr956915ejc.90.1631120975299;
 Wed, 08 Sep 2021 10:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210908044427.3632119-1-yhs@fb.com> <ebcddf07-f329-05fa-8fdc-b2b9d6b0127b@iogearbox.net>
 <20210908135326.GZ1200268@ziepe.ca> <YTjFcek5B3ltYtG3@hirez.programming.kicks-ass.net>
 <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
 <20210908151230.m2zyslt4qrufm4bv@revolver> <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
In-Reply-To: <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Wed, 8 Sep 2021 19:09:23 +0200
Message-ID: <CAMOZA0+2KLgYTXDZHGUYFnYezee=_hH6kFVM+-n2ZQuFTfh6yg@mail.gmail.com>
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
To:     Yonghong Song <yhs@fb.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 8, 2021 at 6:10 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/8/21 8:12 AM, Liam Howlett wrote:
> > * Luigi Rizzo <lrizzo@google.com> [210908 10:44]:
> >> On Wed, Sep 8, 2021 at 4:16 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >>>
> >>> On Wed, Sep 08, 2021 at 10:53:26AM -0300, Jason Gunthorpe wrote:
> >>>> On Wed, Sep 08, 2021 at 02:20:17PM +0200, Daniel Borkmann wrote:
> >>>>
> >>>>>> The warning is due to commit 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to find_vma*()")
> >>>>>> which added mmap_assert_locked() in find_vma() function. The mmap_assert_locked() function
> >>>>>> asserts that mm->mmap_lock needs to be held. But this is not the case for
> >>>>>> bpf_get_stack() or bpf_get_stackid() helper (kernel/bpf/stackmap.c), which
> >>>>>> uses mmap_read_trylock_non_owner() instead. Since mm->mmap_lock is not held
> >>>>>> in bpf_get_stack[id]() use case, the above warning is emitted during test run.
> >> ...
> >>>>> Luigi / Liam / Andrew, if the below looks reasonable to you, any objections to route the
> >>>>> fix with your ACKs via bpf tree to Linus (or strong preference via -mm fixes)?
> >>>>
> >>>> Michel added this remark along with the mmap_read_trylock_non_owner:
> >>>>
> >>>>      It's still not ideal that bpf/stackmap subverts the lock ownership in this
> >>>>      way.  Thanks to Peter Zijlstra for suggesting this API as the least-ugly
> >>>>      way of addressing this in the short term.
> >>>>
> >>>> Subverting lockdep and then adding more and more core MM APIs to
> >>>> support this seems quite a bit more ugly than originally expected.
> >>>>
> >>>> Michel's original idea to split out the lockdep abuse and put it only
> >>>> in BPF is probably better. Obtain the mmap_read_trylock normally as
> >>>> owner and then release ownership only before triggering the work. At
> >>>> least lockdep will continue to work properly for the find_vma.
> >>>
> >>> The only right solution to all of this is the below. That function
> >>> downright subverts all the locking rules we have. Spreading the hacks
> >>> any further than that one function is absolutely unacceptable.
> >>
> >> I'd be inclined to agree that we should not introduce hacks around
> >> locking rules. I don't know enough about the constraints of
> >> bpf/stackmap, how much of a performance penalty do we pay with Peter's
> >> patch,
> >> and ow often one is expected to call this function ?
> >>
> >> cheers
> >> luigi
> >
> > The hack already exists.  The symptom of the larger issue is that
> > lockdep now catches the hack when using find_vma().
> >
> > If Peter's solution is acceptable to the bpf folks, then we can go ahead
> > and drop the option of using the non_owner variant - which would be
> > best.  Otherwise the hack around the locking rule still exists as long
> > as the find_vma() interface isn't used.
>
> Hi, Peter, Luigi, Liam, Jason,
>
> Peter's solution will definitely break user applications using
> BPF_F_USER_BUILD_ID feature

Again I am ignorant on the details so if you can clarify the following
it may help me and others to better understand the problem:

1. Peter's patch appears to just take the same "fallback" path
   that would be taken if the trylock failed.
   Is this really a breakage or just loss of performance ?
   I would expect the latter, since it is called "fallback".

2. Assuming it is just loss of performance, it becomes important to
   clarify how much we are losing, and whether this is something to
   worry about, or it is only some rarely used function. Things like:
   - total CPU cost + latency difference (including deferred work, if any)
     in the "trylock ok" and "trylock failed" cases.
     I have no idea but since there is a trylock involved, I suppose
     we are in O(500ns) territory (when cold or contended)

   - how often we'd expect calls to the bpf helpers involved
     (BPF_F_USER_BUILD_ID in bpf_get_stack() or bpf_get_stack_pe()) ?



thanks
luigi
