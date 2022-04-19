Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8CC5078D9
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 20:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347654AbiDSS3I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 14:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357451AbiDSS2I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 14:28:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41B43CA63;
        Tue, 19 Apr 2022 11:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BFF2B81846;
        Tue, 19 Apr 2022 18:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5ABDC385A7;
        Tue, 19 Apr 2022 18:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650392460;
        bh=8AeBQCwCgx6CBpKhjtWJeO2vlioukw/vzb3Wc0XyEJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBiPFR2Cp9zcXQ5jKHDOCxzVXcuw2w+gtyx5lfsC8dzJL29YWieLmaKgOVFZLzH30
         Z3egiTZcCgC/BFdcP9Hy7wOkD3gvIH+Th925MxsKl3nsT2Bt9yFKEGiqGGY6ezRe9u
         Gtz9LIZnRahmwTsNUZQObRjw4tke+VK9PKXBzVSteHqOTarOrOyo2Z7Y5V5x0+6Mq4
         V/hgr5hRgrK/vvLMli0UbDpOpR0CI7sZA9EYe1kZbxltmdM8rPbq0DcVKF0tvM7dzK
         kWSky2nU2wQWA6PbwU4kq8i9CJXFbjKT0omwD2t6mB2NdtBNRjwECmjyB79h9X+jl9
         XUhtQtehx8HBA==
Date:   Tue, 19 Apr 2022 21:20:48 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>, Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Message-ID: <Yl79gEzTWYotX7dR@kernel.org>
References: <20220415164413.2727220-1-song@kernel.org>
 <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org>
 <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com>
 <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 18, 2022 at 05:44:19PM -0700, Luis Chamberlain wrote:
> On Mon, Apr 18, 2022 at 01:06:36PM +0300, Mike Rapoport wrote:
> > Hi,
> > 
> > On Sat, Apr 16, 2022 at 10:26:08PM +0000, Song Liu wrote:
> > > > On Apr 16, 2022, at 1:30 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > > 
> > > > Maybe I am missing something, but I really don't think this is ready
> > > > for prime-time. We should effectively disable it all, and have people
> > > > think through it a lot more.
> > > 
> > > This has been discussed on lwn.net: https://lwn.net/Articles/883454/. 
> > > AFAICT, the biggest concern is whether reserving minimal 2MB for BPF
> > > programs is a good trade-off for memory usage. This is again my fault
> > > not to state the motivation clearly: the primary gain comes from less 
> > > page table fragmentation and thus better iTLB efficiency. 
> > 
> > Reserving 2MB pages for BPF programs will indeed reduce the fragmentation,
> > but OTOH it will reduce memory utilization. If for large systems this may
> > not be an issue, on smaller machines trading off memory for iTLB
> > performance may be not that obvious.
> 
> So the current optimization at best should be a kconfig option?

Maybe not and it'll be fine on smaller systems, but from what I see the
bpf_prog_pack implementation didn't consider them.

And if we move the caches from BPF to vmalloc or page allocator that
would be much less of an issue.
 
> > I believe that "allocate huge page and split it to basic pages to hand out
> > to users" concept should be implemented at page allocator level and I
> > posted and RFC for this a while ago:
> > 
> > https://lore.kernel.org/all/20220127085608.306306-1-rppt@kernel.org/
> 
> Neat, so although eBPF is a big user, are there some use cases outside
> that immediately benefit?

Anything that uses set_memory APIs could benefit from this. Except eBPF and
other module_alloc() users, there is secretmem that also fractures the
direct map and actually that was my initial use case for these patches.

Another possible use-case can be protection of page tables with PKS:

https://lore.kernel.org/lkml/20210505003032.489164-1-rick.p.edgecombe@intel.com/

Vlastimil also mentioned that SEV-SNP could use such caching mechanism, but
I don't know the details.

>   LUis

-- 
Sincerely yours,
Mike.
