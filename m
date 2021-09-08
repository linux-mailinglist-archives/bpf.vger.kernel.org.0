Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141CE403FF2
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 21:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhIHTn0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 15:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbhIHTnZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 15:43:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91801C061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 12:42:15 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q3so1963032plx.4
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dni15f1tCT7s1fOHKECtIQ4c2/SZ21RvMTRgafcCVTY=;
        b=Ej3KOl9APylvSh54Mxl+3OPkbmXGQzqmo9BScSYGEhoTCCbR6c9/LSvH54g55nwHNK
         Gf59vmgJF7q2TUULOIDDHZWW0lMlXbPVgSr9E9TYoxBHHexzyNfeXp+kT3TtR8CUscIQ
         uSIf9EbBaCjObcHU7bze3KANFwSQzqLzSyD4gRFFpLKV1R/grG+gXyhRFmK8jGjJblFm
         VaCf2Qtu/Z31qXOsCeTP8/iaMdFg+pAsXVLzbCh8+r0ZotPPw83nx7d5PT0eXPkw2S00
         Y1Xn1itAwXluCOXBWYrBhKsJm9QEO/fnLAXIJmueCe4J7nZLyUUWis1QRy+kr3+uy0P0
         fOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dni15f1tCT7s1fOHKECtIQ4c2/SZ21RvMTRgafcCVTY=;
        b=VBeU2FAMVLI631xcwXQwrK7FSOycLFnVGLwA5/iNlxsfmzSzfOy79v+RcQ5QmIzp3S
         N/xcU02cF/cF3/tsUn5N2YQbe0wiNwCNUjCam7sKD5zSKo5KmJ3rrHABkUc+aOo+pRnF
         BEbK4FlsAeEPU7MobwJ9U2loTzmOaoOFakRn7LyDDmp8V7Y6s7H++Sl4st3BcLVioTdr
         v8eWK6wrd+cHUBUee4W6KvoXC3QTlegstnNaL7Sai8T17fHO3NaYfe44U6uN7cNC5AZV
         vWOqd0QQRt3syHOV/wWqbklh0BMzWrE9mDXAGMd5VMBxA/epbNyIQCF3NLwSVVEIoSKM
         +FQA==
X-Gm-Message-State: AOAM530tKudgytcjiTQZ3ze5VoKDH+VRyZyr53L+6fulmoBAjVV6gKLb
        mtBx5xS8DzAdSCEmg/vStBI=
X-Google-Smtp-Source: ABdhPJyBCgURFWv1g0LAUL0tI9eWUL4WrTtjUKKdNQpQHZcLS7n9XhD4L02ZjjKbe0Hkz9AfgJ7D/A==
X-Received: by 2002:a17:90b:4f8f:: with SMTP id qe15mr5971935pjb.37.1631130135096;
        Wed, 08 Sep 2021 12:42:15 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::4:97c5])
        by smtp.gmail.com with ESMTPSA id h8sm17894pfr.219.2021.09.08.12.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:42:14 -0700 (PDT)
Date:   Wed, 8 Sep 2021 12:42:12 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luigi Rizzo <lrizzo@google.com>, Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Michel Lespinasse <walken@google.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
Message-ID: <20210908194212.ku7ysko4e4ecca2t@ast-mbp.dhcp.thefacebook.com>
References: <20210908135326.GZ1200268@ziepe.ca>
 <YTjFcek5B3ltYtG3@hirez.programming.kicks-ass.net>
 <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
 <20210908151230.m2zyslt4qrufm4bv@revolver>
 <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
 <CAMOZA0+2KLgYTXDZHGUYFnYezee=_hH6kFVM+-n2ZQuFTfh6yg@mail.gmail.com>
 <20210908172118.n2f4w7epm6hh62zf@ast-mbp.dhcp.thefacebook.com>
 <20210908105259.c47dcc4e4371ebb5e147ee6e@linux-foundation.org>
 <20210908180258.yjh62e5oouckar5b@ast-mbp.dhcp.thefacebook.com>
 <20210908184342.r3bwp7v24a6tnslg@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908184342.r3bwp7v24a6tnslg@revolver>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 08, 2021 at 06:43:49PM +0000, Liam Howlett wrote:
> * Alexei Starovoitov <alexei.starovoitov@gmail.com> [210908 14:03]:
> > On Wed, Sep 08, 2021 at 10:52:59AM -0700, Andrew Morton wrote:
> > > On Wed, 8 Sep 2021 10:21:18 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > 
> > > > > Again I am ignorant on the details so if you can clarify the following
> > > > > it may help me and others to better understand the problem:
> > > > > 
> > > > > 1. Peter's patch appears to just take the same "fallback" path
> > > > >    that would be taken if the trylock failed.
> > > > >    Is this really a breakage or just loss of performance ?
> > > > >    I would expect the latter, since it is called "fallback".
> > > > 
> > > > As Yonghong explained it's a user space breakage.
> > > > User space tooling expects build_id to be available 99.999% of the time
> > > > and that's what users observed in practice.
> > > > They've built a bunch of tools on top of this feature.
> > > > The data from these tools goes into various datacenter tables
> > > > and humans analyze it later.
> > > > So Peter's proposal is not acceptable. We don't want to get yelled at.
> > > > 
> > > 
> > > I'm not understanding.  Peter said "this patch merely removes a
> > > performance tweak" and you and Yonghong said "it breaks userspace". 
> > > These assertions are contradictory!
> > 
> > Peter said:
> > "The only sane approach is making the vma tree lockless, but so far the
> >  bpf people have resisted doing the right thing because they've been
> >  allowed to get away with these atrocities.
> > "
> > which is partially true.
> > bpf folks didn't resist it. There is work ongoing to make it lockless.
> > It just takes an long time. I don't see how bpf folks can speed it up
> > any further.
> 
> What work are you doing on a lockless vma tree?  I've been working on
> the maple tree and would like to hear what you've come up with.

Mainly cheering Michel and Paul from sidelines.
imo any approach would be better than the current state.
