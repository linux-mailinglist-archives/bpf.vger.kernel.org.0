Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D95D504EA4
	for <lists+bpf@lfdr.de>; Mon, 18 Apr 2022 12:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiDRKJ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 06:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiDRKJZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 06:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A015612612;
        Mon, 18 Apr 2022 03:06:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BA45611AF;
        Mon, 18 Apr 2022 10:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65657C385A7;
        Mon, 18 Apr 2022 10:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650276405;
        bh=uoe2eTNjXAnSgEGbVFQxizx4XBjSzBp1lG6cswI6xbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z4OT4i/LC2k/i92kWLfFKtTVBpAdJZEhrTM79Ipn6nV/ODqs9njDujOE7UGufhLQE
         Do/HYbG4P6USOC8UsXPXuco19gPIs7rtCCd0Q3D6LSgvEU++x3yzPanyMqL06a1Fm9
         aIIGSGvhWMb31LZbEuWeAEMUSjSc8Mly75z+om044xpunk0PUPohekuF8NmKJW9Rl1
         4DywuvNrUFLI25dNnj/mashbTnlGTNXaZkLZHCAnCDWRjavDNqH5NBuxw3m6IIaFWI
         vgV74FuUatDEOEi5SzMXSz4+aXblqTJNQjcDWglnKZ7EDbpbYmQ0eSH5YgD0p4uul1
         B5eHWHALx3iWA==
Date:   Mon, 18 Apr 2022 13:06:36 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Message-ID: <Yl04LO/PfB3GocvU@kernel.org>
References: <20220415164413.2727220-1-song@kernel.org>
 <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org>
 <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Sat, Apr 16, 2022 at 10:26:08PM +0000, Song Liu wrote:
> > On Apr 16, 2022, at 1:30 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > Maybe I am missing something, but I really don't think this is ready
> > for prime-time. We should effectively disable it all, and have people
> > think through it a lot more.
> 
> This has been discussed on lwn.net: https://lwn.net/Articles/883454/. 
> AFAICT, the biggest concern is whether reserving minimal 2MB for BPF
> programs is a good trade-off for memory usage. This is again my fault
> not to state the motivation clearly: the primary gain comes from less 
> page table fragmentation and thus better iTLB efficiency. 

Reserving 2MB pages for BPF programs will indeed reduce the fragmentation,
but OTOH it will reduce memory utilization. If for large systems this may
not be an issue, on smaller machines trading off memory for iTLB
performance may be not that obvious.
 
> Other folks (in recent thread on this topic and offline in other 
> discussions) also showed strong interests in using similar technical 
> for text of kernel modules. So I would really like to learn your 
> opinion on this. There are many details we can optimize, but I guess 
> the general mechanism has to be something like:
>  - allocate a huge page, make it safe, and set it as executable;
>  - as users (BPF, kernel module, etc.) request memory for text, give
>    a chunk of the huge page to the user. 
>  - use some mechanism to update the chunk of memory safely. 

There are use-cases that require 4K pages with non-default permissions in
the direct map and the pages not necessarily should be executable. There
were several suggestions to implement caches of 4K pages backed by 2M
pages.

I believe that "allocate huge page and split it to basic pages to hand out
to users" concept should be implemented at page allocator level and I
posted and RFC for this a while ago:

https://lore.kernel.org/all/20220127085608.306306-1-rppt@kernel.org/

-- 
Sincerely yours,
Mike.
