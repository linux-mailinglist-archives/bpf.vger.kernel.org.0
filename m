Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFC12528A4
	for <lists+bpf@lfdr.de>; Wed, 26 Aug 2020 09:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHZHuk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Aug 2020 03:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHZHuk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Aug 2020 03:50:40 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D96C061574
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 00:50:40 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id z22so770480oid.1
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 00:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u/LWzNjYebAgkV5btA27GyQwpiuLqO4m8FQFnzAQZXA=;
        b=BN6nYJwRl+zIeg+fg6HkVnKnMBPv2/8y5hGwQ96NJ3Omdg48na25BOF0+pMVtZ98ZS
         wkLmGsV5WbiaJi1EqHsgn2JaJIUpQpl4ImcW7vupOI4wJpMkWLIGaI9Llfma5NZfN6ct
         9Bq1FOQQtqZgpgTWNqXaUaI7fSqTy28iZ/jBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u/LWzNjYebAgkV5btA27GyQwpiuLqO4m8FQFnzAQZXA=;
        b=Q4OhQoZgb8K0opgTmiCV4PxiTpbnwovjck+TOjF78DrLYMB+mX3ZOIC/NNB5KmKFno
         2BNBwmUvmWu1aG1dZN2kdqELw6FWz9jwBSuItOCNhW7lxDs9EPL8Z244CCS/k9b2gOQM
         NUK5MfqVxWxEo4g9pZStSOxWYcWsP9CiQ27rNSy5rhtq3pGFL+ePgD3oDecTSrkI+s/1
         FpwNVdyDHLXsz+Z8sb1h0bs3Q3yHKjzqoJgov525auGxMrFafjuPZVRSwkEDBQTwkyc2
         9WQAijVtem/R8MGwJVea2EhhnRK6OAv5Fox9490G9CSSLM39vhTV+9+vpXykvDOtmd4Y
         W8Ow==
X-Gm-Message-State: AOAM532Pzue+bVWht/2aDSnm6U9Y+QELDaINEx2e36t4oGeW5M4XoyNu
        FEDVaCda2kZ3Xfx471klWskIGnGGJRWxaNlycA7Mwsw5mTE=
X-Google-Smtp-Source: ABdhPJyX1ZDP8Ow/pVUvPqpTkXpOx3eCsc14OCah9yeVVRq1Jv6DrvGXK/AXV6rlhmJybVjlwoTcze9FjuQpS49OJbM=
X-Received: by 2002:aca:3e8b:: with SMTP id l133mr293974oia.110.1598428239829;
 Wed, 26 Aug 2020 00:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw98fJe3qanRVe5LcoP49METHhzjZKPcSGnKQ-o=_F3=Hfw@mail.gmail.com>
 <CAADnVQLji8CMCVoefHPqc457Fz1xZ+yEnogHXpghhx6=GPYTbg@mail.gmail.com>
In-Reply-To: <CAADnVQLji8CMCVoefHPqc457Fz1xZ+yEnogHXpghhx6=GPYTbg@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 26 Aug 2020 08:50:28 +0100
Message-ID: <CACAyw988=DLoXJ6dC4qkTCWgQu2M19fVTAhjnF5Hg2Oe=mkmOw@mail.gmail.com>
Subject: Re: Advisory file locking behaviour of bpf_link (and others?)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 25 Aug 2020 at 19:06, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 25, 2020 at 6:39 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > Hi,
> >
> > I was playing around a bit, and noticed that trying to acquire an
> > exclusive POSIX record lock on a bpf_link fd fails. I've traced this
> > to the call to anon_inode_getfile from bpf_link_prime which
> > effectively specifies O_RDONLY on the bpf_link struct file. This makes
> > check_fmode_for_setlk return EBADF.
> >
> > This means the following:
> > * flock(link, LOCK_EX): works
> > * fcntl(link, SETLK, F_RDLCK): works
> > * fcntl(link, SETLK, F_WRLCK): doesn't work
> >
> > Especially the discrepancy between flock(EX) and fcntl(WRLCK) has me
> > puzzled. Should fcntl(WRLCK) work on a link?
> >
> > program fds are always O_RDWR as far as I can tell (so all locks
> > work), while maps depend on map_flags.
>
> Because for links fd/file flags are reserved for the future use.
> progs are rdwr for historical reasons while maps can have three combinations:
> /* Flags for accessing BPF object from syscall side. */
>         BPF_F_RDONLY            = (1U << 3),
>         BPF_F_WRONLY            = (1U << 4),
> by default they are rdwr.
> What is your use case to use flock on bpf_link fd?

The idea is to prevent concurrent access / modification of pinned maps
+ pinned link from a command line tool. I could just as well lock one
of the maps for this, but conceptually the link is the thing that
actually controls what maps are used via the attached BPF program.
FWIW I'm using flock(EX) on the link for now, which is fine for my use
case. I just thought I'd raise this in case it was an oversight :)

Best
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
