Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C15036A906
	for <lists+bpf@lfdr.de>; Sun, 25 Apr 2021 21:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhDYT2z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Apr 2021 15:28:55 -0400
Received: from l2mail1.panix.com ([166.84.1.75]:60003 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhDYT2z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Apr 2021 15:28:55 -0400
X-Greylist: delayed 956 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Apr 2021 15:28:55 EDT
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4FSyMS2pCCzDkw;
        Sun, 25 Apr 2021 15:12:20 -0400 (EDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4FSyMQ646mzSBL;
        Sun, 25 Apr 2021 15:12:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1619377938; bh=fc/8Z24Q3s7ry5U7i5eSbitrtiEv2nEp2QWukNso8Fk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=S0FXHKAhUNVvtIs5fxf4gQ+WNFyJSmVvDDnV8vqkSw7apP7Lkxt+ctwtH6VO7ijID
         D5XiVh4U1npXIj3QZgIggNV3nX8z1bEQlw0X3nKmsAvJxCJoeSzxq1/mpJioaEDPF9
         rM77NDYK1rChJlCtq5oSDCoTq6coC44op7TXIEtU=
Received: by mail-yb1-f172.google.com with SMTP id t94so8851314ybi.3;
        Sun, 25 Apr 2021 12:12:18 -0700 (PDT)
X-Gm-Message-State: AOAM530bdmeBTK2CYmSPwY40+/IlQgzcHwSYWJyP4PJZTrRPvycyuh50
        qG04F9mN3NiPk0gAPEcMPdJco+5ej/azkVZOew0=
X-Google-Smtp-Source: ABdhPJycnxXfPvnAKFw8qjAuPfEP8YLOtME9eW25HtgDz3bgNkXBYyEwiEg66nLD8lKmSL8IWhm9Tz9HXbpRgD+UJVk=
X-Received: by 2002:a25:4943:: with SMTP id w64mr9475524yba.256.1619377938461;
 Sun, 25 Apr 2021 12:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <CAADnVQLf4qe3Hj7cjBUCY4wXb9t2ZjUt=Z=JuygRY0LNNHWAoA@mail.gmail.com>
 <56932c68-4992-c5e4-819f-a88f60b3f63a@gmail.com> <CAADnVQJU=r0qE-4ZHsvX4YndbFgDGvzAgNgVo7kPMGF4jCrVeg@mail.gmail.com>
In-Reply-To: <CAADnVQJU=r0qE-4ZHsvX4YndbFgDGvzAgNgVo7kPMGF4jCrVeg@mail.gmail.com>
From:   Zack Weinberg <zackw@panix.com>
Date:   Sun, 25 Apr 2021 15:12:05 -0400
X-Gmail-Original-Message-ID: <CAKCAbMhaaxiR6HpFZB=bjWyCdNNaA-5ehiujW0TrNuKvQPV=2g@mail.gmail.com>
Message-ID: <CAKCAbMhaaxiR6HpFZB=bjWyCdNNaA-5ehiujW0TrNuKvQPV=2g@mail.gmail.com>
Subject: Re: [RFC] bpf.2: Use standard types and attributes
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        LKML <linux-kernel@vger.kernel.org>, gcc-patches@gcc.gnu.org,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 25, 2021 at 12:52 PM Alexei Starovoitov via Libc-alpha
<libc-alpha@sourceware.org> wrote:
> On Sat, Apr 24, 2021 at 10:56 AM Alejandro Colomar (man-pages)
> <alx.manpages@gmail.com> wrote:
> >
> > Hello Alexei,
> >
> > On 4/24/21 1:20 AM, Alexei Starovoitov wrote:
> > > Nack.
> > > The man page should describe the kernel api the way it is in .h file.
> >
> > Why?
>
> Because man page must describe the linux uapi headers the way they
> are installed in the system and not invent alternative implementations.
> The users will include those .h with __u32 and will see them in their code.
> Man page saying something else is a dangerous lie.

Why do you consider it _dangerous_ for the manpages to replace __u32
with uint32_t, when we know by construction that the two types will
always be the same?  Alejandro's preference for the types standardized
by ISO C seems perfectly reasonable to me for documentation; people
reading the documentation can be expected to already know what they
mean, unlike the  Linux-specifc __[iu]NN types.  Also, all else being
equal, documentation should avoid use of symbols in the ISO C reserved
namespace.

If anything I would argue that it is the uapi headers that should be
changed, to use the <stdint.h> types.

zw
