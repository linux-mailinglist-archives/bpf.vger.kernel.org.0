Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBC827B5E4
	for <lists+bpf@lfdr.de>; Mon, 28 Sep 2020 22:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgI1UEx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Sep 2020 16:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1UEx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 16:04:53 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4644C0613CE
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 13:04:52 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d13so1838254pgl.6
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 13:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DrORwxFSTGYgq7rDpyN+PgrRRMbvRryObis6SlzlegQ=;
        b=E4DiKgHZ8+3lgXItSKuRg/Zp0KCE480TlXTghysXO3BoLDWSNo77w7adL5ZNKFzaJt
         JrIB8dlPqKMbNAPQuhOffpeY5lxUoDQaCkYU7Gb2rde/d/IV3kPzLjUCB6bh4IovYwuN
         dW8ea1YKN4Z7HbEGJI1W39qM7Swg4rgPmsp04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DrORwxFSTGYgq7rDpyN+PgrRRMbvRryObis6SlzlegQ=;
        b=sESXOnDE+qJM4UA0vcn5fpHUgi7WwpvzQqj1Lj1Bwou9Sl7JxfUAKm3c+JjN1SEM5r
         HY+fwmSn7HgR0i4DtARre1a1XOjCF6dpZ0aOuv9/1PU8U4P1manwtoak3VBjyO7vIyuP
         5KiOkuJKGHILsOZ2b6qRIzuFh0S1p4u1wTXTVe3D8SwXN9/O2sT5fh2kNWglRNiXWsil
         wbZD6SZ8aZxNJ18o+GYYYNJxiRjCjgYnp8POEpGvtCRTDLzXukqA04GwuA8QxfJAk4vt
         DrKvqL+vdH5EP812U+Ykgp6GiOdnBaJcs4gkISJXFomwoqKKhIzaj2N0us838eMkMnYD
         YzXg==
X-Gm-Message-State: AOAM533sQm9jVmLtnNo5eu7Lg2qVmVnnmXJn3qSUsB4QR2t/yrMswpN9
        DdRr59f3szcX8nfE/A9GpkZszg==
X-Google-Smtp-Source: ABdhPJxeNwqKkdDur1frnecEaZEFzGE9kbnLnamH2R59vj03CRfItMAxTnbIVtTMyXXwLb+Jai9NWg==
X-Received: by 2002:aa7:99c2:0:b029:142:440b:fa28 with SMTP id v2-20020aa799c20000b0290142440bfa28mr961093pfi.30.1601323492379;
        Mon, 28 Sep 2020 13:04:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w203sm2928796pff.0.2020.09.28.13.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 13:04:51 -0700 (PDT)
Date:   Mon, 28 Sep 2020 13:04:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Valentin Rothberg <vrothber@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/6] seccomp: Implement constant action bitmaps
Message-ID: <202009281259.D7D18AE95@keescook>
References: <20200923232923.3142503-1-keescook@chromium.org>
 <43039bb6-9d9f-b347-fa92-ea34ccc21d3d@rasmusvillemoes.dk>
 <CABqSeAQKksqM1SdsQMoR52AJ5CY0VE2tk8-TJaMuOrkCprQ0MQ@mail.gmail.com>
 <27b4ef86-fee5-fc35-993b-3352ce504c73@rasmusvillemoes.dk>
 <CABqSeATHtvA7qm7j_kxBsbxRCd5B=MHtxGdsYsXEJ-TRRYKTgA@mail.gmail.com>
 <CABqSeASMObs7HtwfM=ua9Tbx1mfHZaxCMWD6AP6-6hR4-Xcn=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeASMObs7HtwfM=ua9Tbx1mfHZaxCMWD6AP6-6hR4-Xcn=Q@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Sep 26, 2020 at 01:11:50PM -0500, YiFei Zhu wrote:
> On Fri, Sep 25, 2020 at 2:07 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > I'll try to profile the latter later on my qemu-kvm, with a recent
> > libsecomp with binary tree and docker's profile, probably both direct
> > filter attaches and filter attaches with fork(). I'm guessing if I
> > have fork() the cost of fork() will overshadow seccomp() though.
> 
> I'm surprised. That is not the case as far as I can tell.
> 
> I wrote a benchmark [1] that would fork() and in the child attach a
> seccomp filter, look at the CLOCK_MONOTONIC difference, then add it to
> a struct timespec shared with the parent. It checks the difference
> with the timespec before prctl and before fork. CLOCK_MONOTONIC
> instead of CLOCK_PROCESS_CPUTIME_ID because of fork.
> 
> I ran `./seccomp_emu_bench 100000` in my qemu-kvm and here are the results:
> without emulator:
> Benchmarking 100000 syscalls...
> 19799663603 (19.8s)
> seecomp attach without fork: 197996 ns
> 33911173847 (33.9s)
> seecomp attach with fork: 339111 ns
> 
> with emulator:
> Benchmarking 100000 syscalls...
> 54428289147 (54.4s)
> seecomp attach without fork: 544282 ns
> 69494235408 (69.5s)
> seecomp attach with fork: 694942 ns
> 
> fork seems to take around 150us, seccomp attach takes around 200us,
> and the filter emulation overhead is around 350us. I had no idea that
> fork was this fast. If I wrote my benchmark badly please criticise.

You're calling clock_gettime() inside your loop. That might change the
numbers. Why not just measure outside the loop, or better yet, use
"perf" to measure the time in prctl().

> Given that we are doubling the time to fork() + seccomp attach filter,
> I think yeah running the emulator on the first instance of a syscall,
> holding a lock, is a much better idea. If I naively divide 350us by
> the number of syscall + arch pairs emulated the overhead is less than
> 1 us and that should be okay since it only happens for the first
> invocation of the particular syscall.
> 
> [1] https://gist.github.com/zhuyifei1999/d7bee62bea14187e150fef59db8e30b1

Regardless, let's take things one step at a time. First, let's do
the simplest version of the feature, and then let's look at further
optimizations.

Can you send a v3 and we can continue from there?

-- 
Kees Cook
