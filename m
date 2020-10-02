Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2362810F3
	for <lists+bpf@lfdr.de>; Fri,  2 Oct 2020 13:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgJBLIU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Oct 2020 07:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgJBLIU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 07:08:20 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A14DC0613D0;
        Fri,  2 Oct 2020 04:08:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t7so600344pjd.3;
        Fri, 02 Oct 2020 04:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TN/noH5vH9CkLLRAplsfECRDqMRnriPBEN1mLBkYoFM=;
        b=ScLOAE5wHKEY7mteqyA6ZIBlmVDJetG7nJWSSSPBAU2hYneqKoMVmzDM7Y6C2FOJFC
         bVXwCvizsRXxVjJ3o9QeFLOXgQb9xBRbNhIBTOIlHjM11ZTits1nOl71bepZgW2l7/nB
         onGNyYsHyu1koUAYJaJgdyFzE/w8mBeCBRfqqQxzSZr47RXQ1PZEE2O6OklclfaUOyuv
         lsowFxvMomqeCCYpQL1LMgZDZsKWbetDQOG6qaGXSkIEFYuGVvy6B/9VU7tzkh9aO0yY
         BWFwV4yKavUOGH0R24IS5/Lovne7FPCWleQLZ3iQ7IivB3S4p4ZMFRkida2di5K2/HCl
         PB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TN/noH5vH9CkLLRAplsfECRDqMRnriPBEN1mLBkYoFM=;
        b=EGB4ZQ+/Zv8wO72xdFx36buxSKB7oXp4Y471daVCqkDbMLD8HEl/7E9BMd1VdpmzoT
         /lIbKv7JESP9t2E+w4Zulb09VdWjjtc40yxQ3/cbSziYfNs/K8nW96h2hK3yX1+JflPD
         Zd2/EVT9Kf24+mfI81KkITh1v5uUaNutP0MTSzeOPYkrSmElEFxq9Su8adK4tttNWrcK
         PQpxzoyNP2CsxkNfw1Rfo20fDZlBrBiGToNPiuuA3qm9h/w6ArG0Hcla7CvN76DuiZFp
         1BMHtXOwL1sSydOVTDe94KKMXpblJEuEj6fIDprFaO+J2p41/AjLyS57vLJSZp8+X4QQ
         aXvg==
X-Gm-Message-State: AOAM532Kk/VeR+0qbxRPUU8D2WcOAhHFmg78JVAxpaAk1335yE4T8ZkL
        6XUdtSEfZqtfqITokMQ1Dr0rKJkB+CJjqhTwJbk=
X-Google-Smtp-Source: ABdhPJwp9DY3a5VFCCxDN4ubn5YX34qjNqjm6nq5KsA56YZfWWkqfLoWTESqEVHF6+xId3COLUqvBoz7OzmOiK8Orvg=
X-Received: by 2002:a17:90a:f184:: with SMTP id bv4mr2131882pjb.1.1601636900031;
 Fri, 02 Oct 2020 04:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601478774.git.yifeifz2@illinois.edu> <b16456e8dbc378c41b73c00c56854a3c30580833.1601478774.git.yifeifz2@illinois.edu>
 <202009301432.C862BBC4B@keescook> <CABqSeATqYuEAb=i1nxufbVQUWRw6FDbb9x0DYJz87U0RbQj14A@mail.gmail.com>
 <202010011314.503D67209@keescook>
In-Reply-To: <202010011314.503D67209@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Fri, 2 Oct 2020 06:08:08 -0500
Message-ID: <CABqSeASuuJcY_tAA5hskRaZ-3y8cA-zCpVJvOue8Uv+3jM9NDw@mail.gmail.com>
Subject: Re: [PATCH v3 seccomp 2/5] seccomp/cache: Add "emulator" to check if
 filter is constant allow
To:     Kees Cook <keescook@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 1, 2020 at 4:05 PM Kees Cook <keescook@chromium.org> wrote:
> Right, but we depend on that test always doing the correct thing (and
> continuing to do so into the future). I'm looking at this from the
> perspective of future changes, maintenance, etc. I want the actions to
> match the design principles as closely as possible so that future
> evolutions of the code have lower risk to bugs causing security
> failures. Right now, the code is simple. I want to design this so that
> when it is complex, it will still fail toward safety in the face of
> bugs.
>
> I'd prefer this way because for the loop, the tests, and the results only
> make the bitmap more restrictive. The worst thing a bug in here can do is
> leave the bitmap unchanged (which is certainly bad), but it can't _undo_
> an earlier restriction.
>
> The proposed loop's leading test_bit() becomes only an optimization,
> rather than being required for policy enforcement.
>
> In other words, I prefer:
>
>         inherit all prior prior bitmap restrictions
>         for all syscalls
>                 if this filter not restricted
>                         continue
>                 set bitmap restricted
>
>         within this loop (where the bulk of future logic may get added),
>         the worse-case future bug-induced failure mode for the syscall
>         bitmap is "skip *this* filter".
>
>
> Instead of:
>
>         set bitmap all restricted
>         for all syscalls
>                 if previous bitmap not restricted and
>                    filter not restricted
>                         set bitmap unrestricted
>
>         within this loop the worst-case future bug-induced failure mode
>         for the syscall bitmap is "skip *all* filters".
>
>
>
>
> Or, to reword again, this:
>
>         retain restrictions from previous caching decisions
>         for all syscalls
>                 [evaluate this filter, maybe continue]
>                 set restricted
>
> instead of:
>
>         set new cache to all restricted
>         for all syscalls
>                 [evaluate prior cache and this filter, maybe continue]
>                 set unrestricted
>
> I expect the future code changes for caching to be in the "evaluate"
> step, so I'd like the code designed to make things MORE restrictive not
> less from the start, and remove any prior cache state tests from the
> loop.
>
> At the end of the day I believe changing the design like this now lays
> the groundwork to the caching mechanism being more robust against having
> future bugs introduce security flaws.
>

I see. Makes sense. Thanks. Will do that in the v4

YiFei Zhu
