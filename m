Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F87403EA7
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 19:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhIHRyp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 13:54:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhIHRyI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 13:54:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C457061051;
        Wed,  8 Sep 2021 17:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1631123580;
        bh=nXi0yLf9rlDTWkxbPehUsFIjHiAj8b4Mhco6ObvEQQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SwXdm8kZaKD1urXqfdWpupnvojRaYRYjV8ng4kZVRSVAujp3J0MUwY9w75u6t1U+A
         2zefi/f9lmiHRf+GffrxwcTKNAzHr2OuxQlxHM8cNC24uFmmMxqoIYUQQ0EwJs05Ix
         rOMrYZ7n1E8F/JI5b5UYccyyueGR+epgkindDFVQ=
Date:   Wed, 8 Sep 2021 10:52:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Luigi Rizzo <lrizzo@google.com>, Yonghong Song <yhs@fb.com>,
        Liam Howlett <liam.howlett@oracle.com>,
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
Message-Id: <20210908105259.c47dcc4e4371ebb5e147ee6e@linux-foundation.org>
In-Reply-To: <20210908172118.n2f4w7epm6hh62zf@ast-mbp.dhcp.thefacebook.com>
References: <20210908044427.3632119-1-yhs@fb.com>
        <ebcddf07-f329-05fa-8fdc-b2b9d6b0127b@iogearbox.net>
        <20210908135326.GZ1200268@ziepe.ca>
        <YTjFcek5B3ltYtG3@hirez.programming.kicks-ass.net>
        <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
        <20210908151230.m2zyslt4qrufm4bv@revolver>
        <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
        <CAMOZA0+2KLgYTXDZHGUYFnYezee=_hH6kFVM+-n2ZQuFTfh6yg@mail.gmail.com>
        <20210908172118.n2f4w7epm6hh62zf@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 8 Sep 2021 10:21:18 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > Again I am ignorant on the details so if you can clarify the following
> > it may help me and others to better understand the problem:
> > 
> > 1. Peter's patch appears to just take the same "fallback" path
> >    that would be taken if the trylock failed.
> >    Is this really a breakage or just loss of performance ?
> >    I would expect the latter, since it is called "fallback".
> 
> As Yonghong explained it's a user space breakage.
> User space tooling expects build_id to be available 99.999% of the time
> and that's what users observed in practice.
> They've built a bunch of tools on top of this feature.
> The data from these tools goes into various datacenter tables
> and humans analyze it later.
> So Peter's proposal is not acceptable. We don't want to get yelled at.
> 

I'm not understanding.  Peter said "this patch merely removes a
performance tweak" and you and Yonghong said "it breaks userspace". 
These assertions are contradictory!

Please describe the expected userspace-visible change from Peter's
patch in full detail?

And yes, it is far preferable that we resolve this by changing BPF to
be a better interface citizen, please.  Let's put those thinking caps on?
