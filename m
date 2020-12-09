Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29342D489A
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 19:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbgLISGp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 13:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732757AbgLISGh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 13:06:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5013CC0613D6;
        Wed,  9 Dec 2020 10:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=12hoQABG9FckSJ5OF/hyVqUM6/uXu85LiNPYtk8cpMI=; b=KOFYpz3RqQPlHcHKG+ldL7fwiD
        EBZrIoPnC6678N22HWrStGRcaNFqMuAKDX+c7AXHDobF4zvNKem7Nc6+7tRp0ns0QxsbXkRt9gqni
        ZMcfHsgE0J2S3DqFYPzx86o4GWRpq2WCz8qXwTfEUgSC/aZ3deUsXyp5JBz34nLjRputdUuOcbkgz
        KrtZsou0i1VpJhhWcxDSqjpvii23UJ7pLGahIeV3dlvry3RtMN6q/72lpUhQoiC7iOt1cRHb961QP
        MrIvoK0eTuAF31bqurJWyQK7bNyBhuW9D9stCIYSytyX6YdJyw6KD2Trpo49InOPcQbCSH5BPTrRO
        ROt5xuIA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kn3qa-0007ZP-5Q; Wed, 09 Dec 2020 18:05:52 +0000
Date:   Wed, 9 Dec 2020 18:05:52 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Justin Forbes <jmforbes@linuxtx.org>,
        bpf <bpf@vger.kernel.org>, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] mm/filemap: add static for function
 __add_to_page_cache_locked
Message-ID: <20201209180552.GA28692@infradead.org>
References: <ddca2a9e-ed89-5dec-b1af-4f2fd2c99b57@linux.alibaba.com>
 <20201207081556.pwxmhgdxayzbofpi@lion.mk-sys.cz>
 <CAFxkdApgQ4RCt-J43cK4_128pXr=Xn5jw+q0kOaP-TYufk_tPA@mail.gmail.com>
 <CAADnVQK-EsdBohcVSaK+zaP9XuPZTBkGbQpkeYcrC9BzoPQUuw@mail.gmail.com>
 <20201207225351.2liywqaxxtuezzw3@lion.mk-sys.cz>
 <CAADnVQJARx6sKF-30YsabCd1W+MFDMmfxY+2u0Pm40RHHHQZ6Q@mail.gmail.com>
 <CAADnVQJ6tmzBXvtroBuEH6QA0H+q7yaSKxrVvVxhqr3KBZdEXg@mail.gmail.com>
 <20201209144628.GA3474@wp.pl>
 <20201209150826.GP7338@casper.infradead.org>
 <20201209155148.GA5552@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209155148.GA5552@wp.pl>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 09, 2020 at 04:51:48PM +0100, Stanislaw Gruszka wrote:
> On Wed, Dec 09, 2020 at 03:08:26PM +0000, Matthew Wilcox wrote:
> > On Wed, Dec 09, 2020 at 03:46:28PM +0100, Stanislaw Gruszka wrote:
> > > At this point of release cycle we should probably go with revert,
> > > but I think the main problem is that BPF and ERROR_INJECTION use
> > > function that is not intended to be used externally. For external users
> > > add_to_page_cache_lru() and add_to_page_cache_locked() are exported
> > > and I think those should be used (see the patch below).
> > 
> > FWIW, I intend to do some consolidation/renaming in this area.  I
> > trust that will not be a problem?
> 
> If it does not break anything, it will be not a problem ;-)
> 
> It's possible that __add_to_page_cache_locked() can be a global symbol
> with add_to_page_cache_lru() + add_to_page_cache_locked() being just
> static/inline wrappers around it.

So what happens to BTF if we change this area entirely?  Your IDs
sound like some kind of ABI to me, which is extremely scary.
