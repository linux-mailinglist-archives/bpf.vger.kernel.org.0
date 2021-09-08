Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AECA403ED6
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 20:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348081AbhIHSEL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 14:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbhIHSEK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 14:04:10 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC2FC061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 11:03:02 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w8so3458029pgf.5
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 11:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UGQvEXdrBVg53IK4NUbZnfU4dD2CNp4+2PmbwFjGdEc=;
        b=mocR2yuTelYjFHtGeDoBzetYTqgZHuinb4y5VmRpAM4dJCvhdag2Hy7i3f3nvnc6rO
         WYu6M0NnxnviSYR4sopLGv+yF/t9MZFKnfhMlBU1DKVEtwGlsNaDhId9w2UFeoXUOUK1
         fsPraorqEVJ0g7RR6AMgv1AAi1fw/YkewYhfRzCJlHk3pL8i/ebUnEC4UD6sW/SBvf7P
         2WU8Z4sl+2vTEHIknNSaB8SdMk+FwLqn6VgXPJ9FdhgtXgOSmQF8ZwCgUag318rzrgO0
         rjbA7wFqfZk+ulO+Ez0lz9CkmR4zcTGgTdlfFew0EfayCCPuxXE3F/OdeEtxXzemgcVJ
         7SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UGQvEXdrBVg53IK4NUbZnfU4dD2CNp4+2PmbwFjGdEc=;
        b=MVuzLIdac1JgPEHH0vhy1njSt7fr3lHlA6EDVWm1LKVzpgXSC4WRcIZuz8emeqnb9r
         iCtPKPgFWG9imOi/RnJlMLCwItDottFwf3u/ZliJXGPWBavRGfCiXNod3+Da56d5klId
         fY9NxcYBQrtK/D6OheqRBHbu2LuQl3cLGwoj2E66C1EiIm4f/RiHIRgEjUci4tmtTuzH
         8coniDb3PBJeBjRCS6xkqRzSvBUrUVyEKmN3fLWU8PlMqntRD5EmVmKQ3XxhVts3TZJR
         VTSWAzrnCiLGF9umtcabLU5SlyxXO9ln9nltBs/Zc7Jst5t040hqHZxuN6wfJAxzd1qj
         DOCw==
X-Gm-Message-State: AOAM531/zlR204VTiSXlAnaMvger8E2viSXAev4PQDAIhQW6WjdxZqnf
        YkJwGr4ND9Bc1KeYZE3+XH4=
X-Google-Smtp-Source: ABdhPJzXQjQ0dLjy6o6xsIJhDMAqz2MvpxwnR6dDf4HHR6pWM/6IbxiKjFIawAvtJYvbH5F7Xb10Mg==
X-Received: by 2002:a63:2343:: with SMTP id u3mr4942722pgm.100.1631124181392;
        Wed, 08 Sep 2021 11:03:01 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::4:97c5])
        by smtp.gmail.com with ESMTPSA id n3sm2896375pfo.101.2021.09.08.11.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 11:03:00 -0700 (PDT)
Date:   Wed, 8 Sep 2021 11:02:58 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
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
Message-ID: <20210908180258.yjh62e5oouckar5b@ast-mbp.dhcp.thefacebook.com>
References: <20210908044427.3632119-1-yhs@fb.com>
 <ebcddf07-f329-05fa-8fdc-b2b9d6b0127b@iogearbox.net>
 <20210908135326.GZ1200268@ziepe.ca>
 <YTjFcek5B3ltYtG3@hirez.programming.kicks-ass.net>
 <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
 <20210908151230.m2zyslt4qrufm4bv@revolver>
 <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
 <CAMOZA0+2KLgYTXDZHGUYFnYezee=_hH6kFVM+-n2ZQuFTfh6yg@mail.gmail.com>
 <20210908172118.n2f4w7epm6hh62zf@ast-mbp.dhcp.thefacebook.com>
 <20210908105259.c47dcc4e4371ebb5e147ee6e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908105259.c47dcc4e4371ebb5e147ee6e@linux-foundation.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 08, 2021 at 10:52:59AM -0700, Andrew Morton wrote:
> On Wed, 8 Sep 2021 10:21:18 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > > Again I am ignorant on the details so if you can clarify the following
> > > it may help me and others to better understand the problem:
> > > 
> > > 1. Peter's patch appears to just take the same "fallback" path
> > >    that would be taken if the trylock failed.
> > >    Is this really a breakage or just loss of performance ?
> > >    I would expect the latter, since it is called "fallback".
> > 
> > As Yonghong explained it's a user space breakage.
> > User space tooling expects build_id to be available 99.999% of the time
> > and that's what users observed in practice.
> > They've built a bunch of tools on top of this feature.
> > The data from these tools goes into various datacenter tables
> > and humans analyze it later.
> > So Peter's proposal is not acceptable. We don't want to get yelled at.
> > 
> 
> I'm not understanding.  Peter said "this patch merely removes a
> performance tweak" and you and Yonghong said "it breaks userspace". 
> These assertions are contradictory!

Peter said:
"The only sane approach is making the vma tree lockless, but so far the
 bpf people have resisted doing the right thing because they've been
 allowed to get away with these atrocities.
"
which is partially true.
bpf folks didn't resist it. There is work ongoing to make it lockless.
It just takes an long time. I don't see how bpf folks can speed it up
any further.

> Please describe the expected userspace-visible change from Peter's
> patch in full detail?

User space expects build_id to be available. Peter patch simply removes
that feature.

> And yes, it is far preferable that we resolve this by changing BPF to
> be a better interface citizen, please.  Let's put those thinking caps on?

Just silence a lockdep as Yonghong proposed or some other way,
since it's only a lockdep issue. There is no actual breakage.
The feature was working and still works as intended.
