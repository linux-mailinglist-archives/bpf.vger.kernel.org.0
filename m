Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D93205BF2
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 21:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbgFWTkP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 15:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733248AbgFWTkO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 15:40:14 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA69C061573
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 12:40:14 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i16so16345845qtr.7
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKwYZF3eyOOsHieSXe3m0hFKi4bdp2qQcAv8yukM69I=;
        b=IaH8kZ+egRFatB20ZCa+KbAN20KRP3bddc5p+9s5Bzrpt12eJpTbjZT12msRU4ZBJU
         Kg6Wrf4vozV22YIrYWRzUhqRMF6ZQJ33PHzKPpyIMcq6fRPuBj175eDxYGiWvaq3AvxI
         7Y9NSWGeMmVu5F0NeJzT6k++EBVUWgMQWYP/2Wxpu279SgyXB4Rue7Vy/NLyuHdoBcbx
         bVMhE4A8J/ZckEyVgVogVrGmM/r5UKbCcDrEqeQsnLYco7nz2JbPMLH3Y+BjXx0toOF9
         z8rgM9jZzjjVX/zhlJRVF7JdtaqaPBC35iLAt8hcudAewc2uCd/vA0Zp3eSpxliaYLW5
         yS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKwYZF3eyOOsHieSXe3m0hFKi4bdp2qQcAv8yukM69I=;
        b=qYCf4P/+qMy3GTem5nBKBqKkEzjyu9QEZjN3Q7FLTsbKMKKjVAUoEIgTAebRtxwHv7
         wkqmVdfhVdQSKQcry7kn6xAfATTGESwPeXegvR+x9mvbKexa29Dol1lTAvZs9t7+eqVe
         1bYAzw7LXO0keUu6PEu9ElBiizXOmkuaDmR2RQHwnLWVg4J/NuBy7pZ28737Fx9VV5vH
         nDfL0XUoBtxjp27siyhfB2K/4+E14FriQ0T/qg2xg7TkBL4eJKXtsvUo+pRRWrZGJuBg
         ev+S43sQ9AJZhbHBYrHJEbQ6ePUxH0mQnVhCGvHesQM8kk+svAZWaAnJ8q/Fr0iq1UL+
         JYbA==
X-Gm-Message-State: AOAM531wPnn+0illVbRf1n1eWgFyon4LuyfGhSNSO1zJyTQB3Sn9MA8H
        gdIjaFE5EWl2kceF90d4bM2mUVb+QXes27AxWQU=
X-Google-Smtp-Source: ABdhPJzcUdrn6R21n3QL1ArQDL7nsj1/dUBDVEYprvbSN+bj86M6jyG+/LZdN5Q1vVKa+HxQFdodSP05XR7AhsvgQ/0=
X-Received: by 2002:ac8:2bba:: with SMTP id m55mr22848180qtm.171.1592941214059;
 Tue, 23 Jun 2020 12:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200621142559.GA25517@stranger.qboosh.pl> <CAEf4BzafxBFCa=sm-MoG71iwMA77Rj4OS-6w4U1OahP3+cH_wQ@mail.gmail.com>
 <20200623192917.GA6342@mail>
In-Reply-To: <20200623192917.GA6342@mail>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Jun 2020 12:40:02 -0700
Message-ID: <CAEf4BzbKo1-61emwL5nWHRVTeabvedZC6QX01u=pthgkcL3iag@mail.gmail.com>
Subject: Re: [PATCH] fix libbpf hashmap with size_t shorter than long long
To:     Jakub Bogusz <qboosh@pld-linux.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 23, 2020 at 12:29 PM Jakub Bogusz <qboosh@pld-linux.org> wrote:
>
> On Mon, Jun 22, 2020 at 10:44:56PM -0700, Andrii Nakryiko wrote:
> > On Sun, Jun 21, 2020 at 7:34 AM Jakub Bogusz <qboosh@pld-linux.org> wrote:
> > >
> > > Hello,
> > >
> > > I noticed that _bpftool crashes when building kernel tools (5.7.x) for
> > > 32-bit targets because in libbpf hashmap implementation hash_bits()
> > > function returning numbers exceeding hashmap buckets capacity.
> > >
> > > Attached patch fixes this problem.
> > >
> >
> > Thanks! But this was already fixed by Arnaldo Carvalho de Melo <acme@kernel.org>
> > in 8ca8d4a84173 ("libbpf: Define __WORDSIZE if not available").
>
> No, it's not:
> This change worked around __WORDSIZE not always being available.
>
> But the issue on (I)LP32 platforms is that 64-bit value is shifted by
> (32-bits) instead of (64-bits).
>
> (__SIZEOF_LONG__ * 8) is 32 on such architectures (i686, arm).
> I used __SIZEOF_LONG_LONG__ to get proper bit shift both on (I)LP32 and
> LP64 architectures.
>

Ah, I see. I actually mentioned __SIZEOF_ constants on the original
fix patch. But I think in this case it has to use __SIZEOF_SIZE_T,
which on 32-bit should be 4, right?


> Should I provide an updated patch to apply on top of acme change?

Yes, that would be good. But I think there is no need to penalize
32-bit arches with use of 64-bit long longs, and instead it's better
to use #ifdef for 32-bit case vs 64-bit case. The multiplication
constant will change, of course, should be 2654435769. I'd appreciate
it if you can do the patch, thanks!


>
>
> Regards,
>
> --
> Jakub Bogusz    http://qboosh.pl/
