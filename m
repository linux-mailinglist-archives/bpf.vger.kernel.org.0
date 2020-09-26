Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EDD279BCC
	for <lists+bpf@lfdr.de>; Sat, 26 Sep 2020 20:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgIZSMD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 26 Sep 2020 14:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIZSMC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Sep 2020 14:12:02 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC5CC0613CE;
        Sat, 26 Sep 2020 11:12:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 197so4971108pge.8;
        Sat, 26 Sep 2020 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KowdFI99SvwAHlmnquISweYZPA2kNBZ4Vy+1Sm1Ru5Y=;
        b=syrFF3GZ4vwOCTVvGBzGuHJ4tcSsvCEY7VnZU5FZQtDjapU5yYWoTukg/YbFCvyOJg
         1R7CkOr3meO9mL0s1bMniClEFzIlmODRBjafTC6oXho0L9KbcuKtKcSgsuuIbEOvHeXl
         O5h/Xqfj+cLXNLXaF79JK62/N9SjeS8W5mQw2r0Tuu+rfkfifKplqReHttHgGNDSlsic
         HAOssh01hbBRJI4TX+cbsO+bYKpU9wQblx3JlaoIkkKSgaDYgfIbe5UQJOxNuBcdTYAn
         dtMhzMWv6i+0HWW2pwD3bGOM/+eqS8iF1KLeTKLkYLQyqsK3w9bCIDV4aeG+10gzxV84
         s38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KowdFI99SvwAHlmnquISweYZPA2kNBZ4Vy+1Sm1Ru5Y=;
        b=YdQ04BB5yVRZdG1kp3wGYCzghHQMDWVlYrbEqZlez53cr6FNFKaIxB9qLDMy6Uv4kN
         zzHRqLikdx4DQ9Dci5pTvkONzehUMTdp9sjT663Ubp9Fu5DVcp3PaZty/f6nmJtQ25ma
         /cBU7YgM92/Lma4xmcwjhYjZHFZW4ym5n11bWSYCN4rqvxdK0ixdW0vdpCC9ESFzZTpS
         TxhiX6mHHoFoPGt5h6vjBMMvISb7K9WegR5dyywKRiO152vffDXNUeex5nuuV8UTo3QW
         gMHrnuLQYgrcXM5zn6XA6bOyo9ucFYsg6shVr5zPBsFKIZFy6w8BUPHbqPWtgPUNoT4u
         o8FQ==
X-Gm-Message-State: AOAM531fBz6oGJd84Fb2s92XxaartqmYQ+1Cc3np8duGytA83IUOekV6
        5WOYv4mm7sgdJtPgDCTkln2NWYZfPrXhh/TBazA=
X-Google-Smtp-Source: ABdhPJwoJr06rCvVUGsbVXGhb2eVCyD32tCStdaxN1THyxWAQGjxGs5gnWApkmotT1o0fcXz0+iU3rf5dfrHjHc2aOU=
X-Received: by 2002:a63:906:: with SMTP id 6mr3490414pgj.66.1601143922050;
 Sat, 26 Sep 2020 11:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org>
 <43039bb6-9d9f-b347-fa92-ea34ccc21d3d@rasmusvillemoes.dk> <CABqSeAQKksqM1SdsQMoR52AJ5CY0VE2tk8-TJaMuOrkCprQ0MQ@mail.gmail.com>
 <27b4ef86-fee5-fc35-993b-3352ce504c73@rasmusvillemoes.dk> <CABqSeATHtvA7qm7j_kxBsbxRCd5B=MHtxGdsYsXEJ-TRRYKTgA@mail.gmail.com>
In-Reply-To: <CABqSeATHtvA7qm7j_kxBsbxRCd5B=MHtxGdsYsXEJ-TRRYKTgA@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Sat, 26 Sep 2020 13:11:50 -0500
Message-ID: <CABqSeASMObs7HtwfM=ua9Tbx1mfHZaxCMWD6AP6-6hR4-Xcn=Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] seccomp: Implement constant action bitmaps
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 25, 2020 at 2:07 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> I'll try to profile the latter later on my qemu-kvm, with a recent
> libsecomp with binary tree and docker's profile, probably both direct
> filter attaches and filter attaches with fork(). I'm guessing if I
> have fork() the cost of fork() will overshadow seccomp() though.

I'm surprised. That is not the case as far as I can tell.

I wrote a benchmark [1] that would fork() and in the child attach a
seccomp filter, look at the CLOCK_MONOTONIC difference, then add it to
a struct timespec shared with the parent. It checks the difference
with the timespec before prctl and before fork. CLOCK_MONOTONIC
instead of CLOCK_PROCESS_CPUTIME_ID because of fork.

I ran `./seccomp_emu_bench 100000` in my qemu-kvm and here are the results:
without emulator:
Benchmarking 100000 syscalls...
19799663603 (19.8s)
seecomp attach without fork: 197996 ns
33911173847 (33.9s)
seecomp attach with fork: 339111 ns

with emulator:
Benchmarking 100000 syscalls...
54428289147 (54.4s)
seecomp attach without fork: 544282 ns
69494235408 (69.5s)
seecomp attach with fork: 694942 ns

fork seems to take around 150us, seccomp attach takes around 200us,
and the filter emulation overhead is around 350us. I had no idea that
fork was this fast. If I wrote my benchmark badly please criticise.

Given that we are doubling the time to fork() + seccomp attach filter,
I think yeah running the emulator on the first instance of a syscall,
holding a lock, is a much better idea. If I naively divide 350us by
the number of syscall + arch pairs emulated the overhead is less than
1 us and that should be okay since it only happens for the first
invocation of the particular syscall.

[1] https://gist.github.com/zhuyifei1999/d7bee62bea14187e150fef59db8e30b1

YiFei Zhu
