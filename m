Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161E620C408
	for <lists+bpf@lfdr.de>; Sat, 27 Jun 2020 22:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgF0UZP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Jun 2020 16:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0UZO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Jun 2020 16:25:14 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D010FC061794
        for <bpf@vger.kernel.org>; Sat, 27 Jun 2020 13:25:13 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id k18so11999316qke.4
        for <bpf@vger.kernel.org>; Sat, 27 Jun 2020 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4uBYnlxWAKKP1kg7JgxLJxuSTUv74qaZNHuzbecYul4=;
        b=BasWyTzoexj23J7/7cT+EmAzH6y02lwTxmlNSYbK14seTCUKx+XT8/N4M0i91R7XsW
         L5cHSBmU7CN/97u3WpFWRzaHxFivrZc/Y8ko9dOFEXwsgnWd9h3FybsZkFO1WeIpSzWL
         iQhSudOo1D7/c+LJ2s+clm0A4DO0mbLCjrzZoGNWdeXdxKbfSFTnbDHuvhYV+w2E96yk
         IBiAvWauFb36Hqmf9nH3A/LEngc2wweHESkTjhhSj2/e0+49WsedI4YJAsqfjHNE/M4v
         QKHi7Apxebd8+/lgEjc5FUUAWInXydBgCXMepiWpKXmZr2d0GS6sxKSequu8YkdbEokE
         3cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4uBYnlxWAKKP1kg7JgxLJxuSTUv74qaZNHuzbecYul4=;
        b=Wz346y9RBPlmiFiqCV+PB2sKHZxNQcrHYo2787cYeN8rA7bl4773O/uTrKNJsZw5Oq
         D69HyO6XrbZaDfTNyipsQcRjGOdAWbj+rvnBVNyq3onH48yU4bGD4kAl6mlRvXWkvfIN
         u1fslJautXMlgusC6Q2t1zoi7gaZvonuROjRGqyQWAVuD4kGTL2zHwex+BoGGnDQQb9x
         IHI87/JK+Dvg7qpBdl85ReG4n7Pypb6OD5xJ56M4mtecpvpnPUjK1VUNwCg5QT77xPbc
         zK9NJbSeR9+vCGkk2rZtZCeIHEOlsVLWpt/m3GwVpBxC8KSBQMJz/nwx7MJcoJ/IpPts
         BDfw==
X-Gm-Message-State: AOAM530EowGqH4m1A1D8BJyqR6KKkxl9/pW3o92+h0STmAGp3h9Qa5fd
        qFMJ7nfZGjiZlsWNREbrh7hPmAJuR1JVUDpYwxg=
X-Google-Smtp-Source: ABdhPJxKw3DzY/j1wGWdA/LeZY9VGiYkuD7KDbQ3wFLnzv2pCTgcB8p47f5yFn36v9ITJAQ9G/kNpXJgVBlqWrFl3TI=
X-Received: by 2002:a05:620a:12d2:: with SMTP id e18mr8964055qkl.437.1593289512822;
 Sat, 27 Jun 2020 13:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200621142559.GA25517@stranger.qboosh.pl> <CAEf4BzafxBFCa=sm-MoG71iwMA77Rj4OS-6w4U1OahP3+cH_wQ@mail.gmail.com>
 <20200623192917.GA6342@mail> <CAEf4BzbKo1-61emwL5nWHRVTeabvedZC6QX01u=pthgkcL3iag@mail.gmail.com>
 <20200627090713.GA9141@mail>
In-Reply-To: <20200627090713.GA9141@mail>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 27 Jun 2020 13:25:01 -0700
Message-ID: <CAEf4BzbL0LTf9tsBAfyvLho5195a1Kwya8zw3r1_Gc3XMEr54g@mail.gmail.com>
Subject: Re: [PATCH] fix libbpf hashmap with size_t shorter than long long
To:     Jakub Bogusz <qboosh@pld-linux.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 27, 2020 at 2:07 AM Jakub Bogusz <qboosh@pld-linux.org> wrote:
>
> On Tue, Jun 23, 2020 at 12:40:02PM -0700, Andrii Nakryiko wrote:
> > On Tue, Jun 23, 2020 at 12:29 PM Jakub Bogusz <qboosh@pld-linux.org> wrote:
> > >
> > > On Mon, Jun 22, 2020 at 10:44:56PM -0700, Andrii Nakryiko wrote:
> > > > On Sun, Jun 21, 2020 at 7:34 AM Jakub Bogusz <qboosh@pld-linux.org> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > I noticed that _bpftool crashes when building kernel tools (5.7.x) for
> > > > > 32-bit targets because in libbpf hashmap implementation hash_bits()
> > > > > function returning numbers exceeding hashmap buckets capacity.
> > > > >
> > > > > Attached patch fixes this problem.
> > > > >
> > > >
> > > > Thanks! But this was already fixed by Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > in 8ca8d4a84173 ("libbpf: Define __WORDSIZE if not available").
> > >
> > > No, it's not:
> > > This change worked around __WORDSIZE not always being available.
> > >
> > > But the issue on (I)LP32 platforms is that 64-bit value is shifted by
> > > (32-bits) instead of (64-bits).
> > >
> > > (__SIZEOF_LONG__ * 8) is 32 on such architectures (i686, arm).
> > > I used __SIZEOF_LONG_LONG__ to get proper bit shift both on (I)LP32 and
> > > LP64 architectures.
> > >
> >
> > Ah, I see. I actually mentioned __SIZEOF_ constants on the original
> > fix patch. But I think in this case it has to use __SIZEOF_SIZE_T,
> > which on 32-bit should be 4, right?
>
> After changing constant to 32-bit, yes (to be precise, it should use maximum
> of __SIZEOF_SIZE_T__ and __SIZEOF_LONG__ if constant is specified with
> UL suffix; there is no constant suffix available for size_t).
>
> > > Should I provide an updated patch to apply on top of acme change?
> >
> > Yes, that would be good. But I think there is no need to penalize
> > 32-bit arches with use of 64-bit long longs, and instead it's better
> > to use #ifdef for 32-bit case vs 64-bit case. The multiplication
> > constant will change, of course, should be 2654435769. I'd appreciate
> > it if you can do the patch, thanks!
>
> OK, so now the patch provides two variants:
> - "long long" case for LP64 architectures
> - "long" case for (I)LP32 architectures
> (selected basing of __SIZEOF_ constants)
> matter)
>
>

Change looks good, thanks! But it would be more convenient for
everyone if you submitted it not as an attachment, but as a proper
patch email message.

Acked-by: Andrii Nakryiko <andriin@fb.com>

> Regards,
>
> --
> Jakub Bogusz    http://qboosh.pl/
