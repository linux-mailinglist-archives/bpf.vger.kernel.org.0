Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D751550331B
	for <lists+bpf@lfdr.de>; Sat, 16 Apr 2022 07:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiDPCWk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 22:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiDPCWT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 22:22:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1439C58E75;
        Fri, 15 Apr 2022 19:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZM3lfs/b3lAESP5zz9nLnOwj5qAuBZLAI/rah4e2ykc=; b=H4gURL8nIMUmE4/AHGNEwndQpZ
        NhOsASQcw8Lf8fWI3xWKAh8K2mecRE3TlV41+ua+9MCy+wgYxN0tBPBaP5mFbUl+UGiUZ3hTYz6xK
        4gmxUjA11Pv2NOoPAsxowiJPNXRwP9nxJKbOXAkMTazILTit3v9CrWfn/AV7oPdsoEWijZJcm9++0
        BG56SlV78tDkfVdhZXD84QVKIcljHBv25fYECsMMmuKd6vL0/y0T+lZ/UWkTtf4PmDiWRAPZK1Cv5
        F4rUu6rEHY8ctjs6b4JGjDj7IT5+nGd9R8UwgdPbhBGXRAJyCtMB29Cp4kVRV5SVvauy6NNLBGlGc
        ll1zE/Gg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfXSu-00BuX1-Sd; Sat, 16 Apr 2022 01:43:09 +0000
Date:   Fri, 15 Apr 2022 18:43:08 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>, imbrenda@linux.ibm.com
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Message-ID: <YlofLKtItUgYfRpX@bombadil.infradead.org>
References: <20220415164413.2727220-1-song@kernel.org>
 <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <CAPhsuW6LY8g6SZpW0CBOe22FUd2e3oSq4RW1GDxZoPmHYBqwvw@mail.gmail.com>
 <YlofA8u760BE8e0B@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlofA8u760BE8e0B@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 15, 2022 at 06:42:27PM -0700, Luis Chamberlain wrote:
> On Fri, Apr 15, 2022 at 06:34:16PM -0700, Song Liu wrote:
> > On Fri, Apr 15, 2022 at 12:05 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Fri, Apr 15, 2022 at 09:44:09AM -0700, Song Liu wrote:
> > > > Changes v3 => v4:
> > > > 1. Fix __weak module_alloc_huge; remove unused vmalloc_huge; rename
> > > >    __vmalloc_huge => vmalloc_huge. (Christoph Hellwig)
> > > > 2. Use vzalloc (as it was before vmalloc_no_huge) and clean up comments in
> > > >    kvm_s390_pv_alloc_vm.
> > > >
> > > > Changes v2 => v3:
> > > > 1. Use __vmalloc_huge in alloc_large_system_hash.
> > > > 2. Use EXPORT_SYMBOL_GPL for new functions. (Christoph Hellwig)
> > > > 3. Add more description about the issues and changes.(Christoph Hellwig,
> > > >    Rick Edgecombe).
> > > >
> > > > Changes v1 => v2:
> > > > 1. Add vmalloc_huge(). (Christoph Hellwig)
> > > > 2. Add module_alloc_huge(). (Christoph Hellwig)
> > > > 3. Add Fixes tag and Link tag. (Thorsten Leemhuis)
> > > >
> > > > Enabling HAVE_ARCH_HUGE_VMALLOC on x86_64 and use it for bpf_prog_pack has
> > > > caused some issues [1], as many users of vmalloc are not yet ready to
> > > > handle huge pages. To enable a more smooth transition to use huge page
> > > > backed vmalloc memory, this set replaces VM_NO_HUGE_VMAP flag with an new
> > > > opt-in flag, VM_ALLOW_HUGE_VMAP. More discussions about this topic can be
> > > > found at [2].
> > > >
> > > > Patch 1 removes VM_NO_HUGE_VMAP and adds VM_ALLOW_HUGE_VMAP.
> > > > Patch 2 uses VM_ALLOW_HUGE_VMAP in bpf_prog_pack.
> > > >
> > > > [1] https://lore.kernel.org/lkml/20220204185742.271030-1-song@kernel.org/
> > > > [2] https://lore.kernel.org/linux-mm/20220330225642.1163897-1-song@kernel.org/
> > >
> > > Looks good except for that I think this should just wait for v5.19. The
> > > fixes are so large I can't see why this needs to be rushed in other than
> > > the first assumptions of the optimizations had some flaws addressed here.
> > 
> > We need these changes to fix issues like [3]. Note that there might
> > still be some
> > undiscovered issues with huge page backed vmalloc memory on powerpc, which
> > had HAVE_ARCH_HUGE_VMALLOC enabled since the 5.15 kernel. As we
> > agreed, the new opt-in flag is a safer approach here. We probably should have
> > 1/4 and 2/4 back ported to stable. Therefore, I think shipping this
> > set now would
> > give us a more reliable 5.18 release.
> > 
> > Does this make sense?
> 
> Yes absolutely, but that sounds like that optimization should just be
> reverted completely from v5.18 isntead then no? Or if one can skip the
> optimizations for v5.18 with a small patch, and then enable for v5.19.

In any case it is up to Linus, I already chimed in with my opinion.

  Luis
