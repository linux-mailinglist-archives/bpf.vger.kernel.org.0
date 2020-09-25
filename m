Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F0F279240
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 22:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgIYUdP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 16:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgIYUUy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 16:20:54 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5740FC0613B1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 12:42:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id v14so51765pjd.4
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1VTbmlxP/NBx4Wl43Zwmsnljn3SCRy51x1r81CV0BZM=;
        b=dtRToJmyHTTr67lrP3SrUIoLxJrrKsByqQJ1DZqoALfG2zQF4UhGdYQvTnp8NK+c8D
         WvYzv4Xi3KqVHy8qs+yI4HHZLz2S644qeifFYle7DzsHYiTpCwSAc5aDg9+Kc2qNouQm
         4lO83kqhdbxY461s8apYSrnvsCnFPC2jx1V7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1VTbmlxP/NBx4Wl43Zwmsnljn3SCRy51x1r81CV0BZM=;
        b=RopbX/oeCO71XWs6Bs2BlJL6CG4KCOZdSgYbksbcsDDVTJhR7TTI0I4t4TIS9cRFVw
         cT/W+B3koYtG28u7WPdi/wM7zhZn8GyxWo4fqqa3VoYQv9+wC5m453vjIEHBJz8F5jP+
         /MpF9jYNjBjVgwEzLq8fi/91OzjY4Wg6cKcrcC6JZtMalhxJhMahOv7kXzSA0CTBXnkm
         WGpaCfbUcvJoZoFkt3BvcnYvhg1MRL2R62GJ+GMbAqgI+Jg8Hi3EWSmQ9wFKTRLXmAeD
         JZblkwjHNFCRLZDbfYn9Ac+ky2kWVnK1MyZkwdAs/EYf9UA/JOJPcAwe0ITGfJOyuT8I
         6Jbg==
X-Gm-Message-State: AOAM5316h3HfY6tW62VgoUsPemw2fM2Bfbt7RkXfsY/gfsoaumWXg66j
        CxatJoMuy65esyfciLsA0Prrbg==
X-Google-Smtp-Source: ABdhPJzf8ii6Mz6aePsI1Nr3EqtgEdasIytrUnQQEYjVuc6D6GJRGQUbTLrAOQNeoMvoaFUsDiVHrg==
X-Received: by 2002:a17:90b:a0a:: with SMTP id gg10mr170348pjb.20.1601062959821;
        Fri, 25 Sep 2020 12:42:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id kk17sm26681pjb.31.2020.09.25.12.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 12:42:38 -0700 (PDT)
Date:   Fri, 25 Sep 2020 12:42:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v2 seccomp 3/6] seccomp/cache: Add "emulator" to check if
 filter is arg-dependent
Message-ID: <202009251223.8E46C831E2@keescook>
References: <cover.1600951211.git.yifeifz2@illinois.edu>
 <c14518ba563d4c6bb75b9fac63b69cd4c82f9dcc.1600951211.git.yifeifz2@illinois.edu>
 <202009241601.FFC0CF68@keescook>
 <CABqSeARb7GNU9+sVgGzgqqOmpQNpxq1JsMrZJvS2EC05AyfAVw@mail.gmail.com>
 <CABqSeASM9B77QrWRbqRF19N9-m-bm779-7a3qEDa8NumjBsorw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeASM9B77QrWRbqRF19N9-m-bm779-7a3qEDa8NumjBsorw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 25, 2020 at 11:45:05AM -0500, YiFei Zhu wrote:
> On Thu, Sep 24, 2020 at 10:04 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > > Why do the prepare here instead of during attach? (And note that it
> > > should not be written to fail.)
> >
> > Right.
> 
> During attach a spinlock (current->sighand->siglock) is held. Do we
> really want to put the emulator in the "atomic section"?

It's a good point, but I had some other ideas around it that lead to me
a different conclusion. Here's what I've got in my head:

I don't view filter attach (nor the siglock) as fastpath: the lock is
rarely contested and the "long time" will only be during filter attach.

When performing filter emulation, all the syscalls that are already
marked as "must run filter" on the previous filter can be skipped for
the new filter, since it cannot change the outcome, which makes the
emulation step faster.

The previous filter's bitmap isn't "stable" until siglock is held.

If we do the emulation step before siglock, we have to always do full
evaluation of all syscalls, and then merge the bitmap during attach.
That means all filters ever attached will take maximal time to perform
emulation.

I prefer the idea of the emulation step taking advantage of the bitmap
optimization, since the kernel spends less time doing work over the life
of the process tree. It's certainly marginal, but it also lets all the
bitmap manipulation stay in one place (as opposed to being split between
"prepare" and "attach").

What do you think?

-- 
Kees Cook
