Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA7B62A3DE
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 22:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiKOVTq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 16:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKOVTp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 16:19:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19501F9CD
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 13:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PTyeKdb3/txpXvphlUoCQiFR4/5ocBSBLSRXjYf6Ong=; b=z7OdM20wk+Np7ESx4LDk4+pOzg
        DaF8BA16/aqpCjYAMCsVcOf0evn61rjvG2U9y7uWeTCAVqye9sHUkpJ3GU9aLrRCS9fyN++18/FTe
        ljpQZdA6N+44Z1eIzwMbUf3FvhizlK0sQU5M6FN9qRBh0INSZKnEdJ41/GaqR0OS5lIoqQ/0qNjPl
        LfYzGxwKejdu48NjIPzS3nE7hvd0cX6/3lgypT0Ft6qxLS9Tdvd87ZjW3/cxd6vLsIHPX8YEhhPZc
        uLYiaPTCftdAwhdONpLcPn2bryU6wZmz0wkmslQ1uWk2yGSsC0Xt8m1gFF8VpITk+1jFJ6kQDKFO7
        EG1pV9ZQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov3KO-00F1vH-TE; Tue, 15 Nov 2022 21:18:44 +0000
Date:   Tue, 15 Nov 2022 13:18:44 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y3QCNCNW31lB37El@bombadil.infradead.org>
References: <20221107223921.3451913-1-song@kernel.org>
 <Y2o9Iz30A3Nruqs4@kernel.org>
 <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
 <Y2uMWvmiPlaNXlZz@kernel.org>
 <bcdc5a31570f87267183496f06963ac58b41bfe1.camel@intel.com>
 <Y3DITs3J8koEw3Hz@kernel.org>
 <CAPhsuW4zKABHC_Stwnkac05Lvww4C_tz-T4JfALDcQusRmsCEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4zKABHC_Stwnkac05Lvww4C_tz-T4JfALDcQusRmsCEw@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 14, 2022 at 12:30:49PM -0800, Song Liu wrote:
> On Sun, Nov 13, 2022 at 2:35 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Wed, Nov 09, 2022 at 05:04:25PM +0000, Edgecombe, Rick P wrote:
> > > On Wed, 2022-11-09 at 13:17 +0200, Mike Rapoport wrote:
> > > > On Tue, Nov 08, 2022 at 04:51:12PM +0000, Edgecombe, Rick P wrote:
> > >
> > > > How the caching of large pages in vmalloc can be made useful for use
> > > > cases like secretmem and PKS?
> > >
> > > This part is easy I think. If we had an unmapped page allocator it
> > > could just feed this.
> >
> > The unmapped page allocator could be used by anything that needs
> > non-default permissions in the direct map and knows how to map the pages
> > elsewhere. E.g it would have been a oneliner to switch x86::module_alloc()
> > to use unmapped allocations. But ...
> >
> > > Do you have any idea when you might pick up that stuff again?
> >
> > ... unfortunately I don't see it happening anytime soon.
> >
> > > To answer my own question, I think a good first step would be to make
> > > the interface also work for non-text_poke() so it could really be cross
> > > arch, then use it for everything except modules. The benefit to the
> > > other arch's at that point is centralized handling of loading text.
> >
> > My concern is that the proposed execmem_alloc() cannot be used for
> > centralized handling of loading text. I'm not familiar enough with
> > modules/ftrace/kprobes/BPF to clearly identify the potential caveats, but
> > my gut feeling is that the proposed execmem_alloc() won't be an improvement
> > but rather a hindrance for moving to centralized handling of loading text.
> 
> I don't follow why this could ever be a hindrance. Luis is very excited about
> this, and I am very sure it works for ftrace, kprobe, and BPF.

The main hurdles for modules are:

  * x86 needs support for CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
    to use this properly
  * in light of lack of support for CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
    we need a fallback
  * today module_alloc() follows special hanky panky open coded semantics for
    special page permissions, a unified way to handle this would be
    ideal instead of expecting everyone to get it right.

Other than this there are probably odd corner cases which would likely
only come up during testing. I see Song's efforts striving towards these
objectives, and because of the new ARCH_WANTS_MODULES_DATA_IN_VMALLOC, it
should be possible to get us there.

  Luis

