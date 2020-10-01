Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15587280914
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 23:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbgJAVFo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 17:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgJAVFQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 17:05:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3959DC0613D0
        for <bpf@vger.kernel.org>; Thu,  1 Oct 2020 14:05:15 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 144so937578pfb.4
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sM/IKUxG7XXA4g0Q8PYm8FVn3Q1jvofvHy96zqP1SLI=;
        b=P/3XD2CcnLPmFvxK4ImVaO3KbIoepUZ+wnlZ+BJrjfWejmWXo3+ahVkBVF20sY057F
         Fd1Kw/TeSXQS1959lE8zRVGSGWl3cP2+jx0rn8Llzgc8rkxibWB/lNL4iSya5ndBfmVF
         zeb4jKfYxb7rziVYZ0e2NmWo678nIlOdBX9pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sM/IKUxG7XXA4g0Q8PYm8FVn3Q1jvofvHy96zqP1SLI=;
        b=YBBnokpx/8qjp9G6QdUyhn/eAC/aM87qSKUEwwX2O6Q5HvOtOygqlWUdLlQInP+xWa
         NRgFF1go+TQDQRFbWl9MpkGs3us0njYWo3vk5k1vem0JXV48sM/nkBR2oQcvzSsIFYYF
         3D2kdO7lXmHQc3lSf2CHFU/B5c3PUTd3fK4yURpPdzGBBAMp1XEn6wdbKSRJEQNe+aWP
         JWgCMaSCWYPl3gLXZjIRcj8XfGw2GHlTywuCysddAr+5XodxCJHJ9PNkf7pFIn79JxdF
         PBGS2REDsppusWPj4AGNTO7slcmD+DBdB80yDLePNZWGpsg3hZBJf4ulaC9H6FiCHvGi
         Y8rw==
X-Gm-Message-State: AOAM531lFv1C69cRx8xaJY6cxh/GEpR5vNDsWDzSnMOhwevPdfpwZJgF
        KQ4LMIxeF0ArEdlK2/VhcLDEKg==
X-Google-Smtp-Source: ABdhPJwZmuICO3eBgdFhAAtcI8VblpCzInUbkz0BCWOnju3Q9j3Bj5uX/6qFoIfg5eFpaOsfoEkjUQ==
X-Received: by 2002:aa7:9ac7:0:b029:152:ebb:cb42 with SMTP id x7-20020aa79ac70000b02901520ebbcb42mr4323742pfp.30.1601586314632;
        Thu, 01 Oct 2020 14:05:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h31sm6125512pgh.71.2020.10.01.14.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 14:05:13 -0700 (PDT)
Date:   Thu, 1 Oct 2020 14:05:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Jann Horn <jannh@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v3 seccomp 2/5] seccomp/cache: Add "emulator" to check if
 filter is constant allow
Message-ID: <202010011314.503D67209@keescook>
References: <cover.1601478774.git.yifeifz2@illinois.edu>
 <b16456e8dbc378c41b73c00c56854a3c30580833.1601478774.git.yifeifz2@illinois.edu>
 <202009301432.C862BBC4B@keescook>
 <CABqSeATqYuEAb=i1nxufbVQUWRw6FDbb9x0DYJz87U0RbQj14A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeATqYuEAb=i1nxufbVQUWRw6FDbb9x0DYJz87U0RbQj14A@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 01, 2020 at 06:52:50AM -0500, YiFei Zhu wrote:
> On Wed, Sep 30, 2020 at 5:40 PM Kees Cook <keescook@chromium.org> wrote:
> > The guiding principle with seccomp's designs is to always make things
> > _more_ restrictive, never less. While we can never escape the
> > consequences of having seccomp_is_const_allow() report the wrong
> > answer, we can at least follow the basic principles, hopefully
> > minimizing the impact.
> >
> > When the bitmap starts with "always allowed" and we only flip it towards
> > "run full filters", we're only ever making things more restrictive. If
> > we instead go from "run full filters" towards "always allowed", we run
> > the risk of making things less restrictive. For example: a process that
> > maliciously adds a filter that the emulator mistakenly evaluates to
> > "always allow" doesn't suddenly cause all the prior filters to stop running.
> > (i.e. this isolates the flaw outcome, and doesn't depend on the early
> > "do not emulate if we already know we have to run filters" case before
> > the emulation call: there is no code path that allows the cache to
> > weaken: it can only maintain it being wrong).
> >
> > Without any seccomp filter installed, all syscalls are "always allowed"
> > (from the perspective of the seccomp boundary), so the default of the
> > cache needs to be "always allowed".
> 
> I cannot follow this. If a 'process that maliciously adds a filter
> that the emulator mistakenly evaluates to "always allow" doesn't
> suddenly cause all the prior filters to stop running', hence, you
> want, by default, the cache to be as transparent as possible. You
> would lift the restriction if and only if you are absolutely sure it
> does not cause an impact.

Yes, right now, the v3 code pattern is entirely safe.

> 
> In this patch, if there are prior filters, it goes through this logic:
> 
>         if (bitmap_prev && !test_bit(nr, bitmap_prev))
>             continue;
> 
> Hence, if the malicious filter were to happen, and prior filters were
> supposed to run, then seccomp_is_const_allow is simply not invoked --
> what it returns cannot be used maliciously by an adversary.

Right, but we depend on that test always doing the correct thing (and
continuing to do so into the future). I'm looking at this from the
perspective of future changes, maintenance, etc. I want the actions to
match the design principles as closely as possible so that future
evolutions of the code have lower risk to bugs causing security
failures. Right now, the code is simple. I want to design this so that
when it is complex, it will still fail toward safety in the face of
bugs.

> >         if (bitmap_prev) {
> >                 /* The new filter must be as restrictive as the last. */
> >                 bitmap_copy(bitmap, bitmap_prev, bitmap_size);
> >         } else {
> >                 /* Before any filters, all syscalls are always allowed. */
> >                 bitmap_fill(bitmap, bitmap_size);
> >         }
> >
> >         for (nr = 0; nr < bitmap_size; nr++) {
> >                 /* No bitmap change: not a cacheable action. */
> >                 if (!test_bit(nr, bitmap_prev) ||
> >                         continue;
> >
> >                 /* No bitmap change: continue to always allow. */
> >                 if (seccomp_is_const_allow(fprog, &sd))
> >                         continue;
> >
> >                 /* Not a cacheable action: always run filters. */
> >                 clear_bit(nr, bitmap);
> 
> I'm not strongly against this logic. I just feel unconvinced that this
> is any different with a slightly increased complexity.

I'd prefer this way because for the loop, the tests, and the results only
make the bitmap more restrictive. The worst thing a bug in here can do is
leave the bitmap unchanged (which is certainly bad), but it can't _undo_
an earlier restriction.

The proposed loop's leading test_bit() becomes only an optimization,
rather than being required for policy enforcement.

In other words, I prefer:

	inherit all prior prior bitmap restrictions
	for all syscalls
		if this filter not restricted
			continue
		set bitmap restricted

	within this loop (where the bulk of future logic may get added),
	the worse-case future bug-induced failure mode for the syscall
	bitmap is "skip *this* filter".


Instead of:

	set bitmap all restricted
	for all syscalls
		if previous bitmap not restricted and
		   filter not restricted
			set bitmap unrestricted

	within this loop the worst-case future bug-induced failure mode
	for the syscall bitmap is "skip *all* filters".




Or, to reword again, this:

	retain restrictions from previous caching decisions
	for all syscalls
		[evaluate this filter, maybe continue]
		set restricted

instead of:

	set new cache to all restricted
	for all syscalls
		[evaluate prior cache and this filter, maybe continue]
		set unrestricted

I expect the future code changes for caching to be in the "evaluate"
step, so I'd like the code designed to make things MORE restrictive not
less from the start, and remove any prior cache state tests from the
loop.

At the end of the day I believe changing the design like this now lays
the groundwork to the caching mechanism being more robust against having
future bugs introduce security flaws.

-- 
Kees Cook
