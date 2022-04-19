Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6CA507954
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344635AbiDSSpR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 14:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiDSSpP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 14:45:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E1E37A03;
        Tue, 19 Apr 2022 11:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88A66B81A0A;
        Tue, 19 Apr 2022 18:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B93C385A5;
        Tue, 19 Apr 2022 18:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650393749;
        bh=aNoitcKVY+3runARZOKXlbXNRTPUSLUckf8FikGfbmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7mqUboZvJQO3DEpHzHUrQS1XU/Xq0/4kVpXYnuX/EY5TEq79O7i3JpbTNV1ank/D
         3rovYl/JOrQRyL69n00/5WqcUh3N139NbOjfw9Vws7EtwFZbDgwrTGvU7g12xQdW9p
         LxvxYyiDo1i7sTAkI1G+Hi3Og+ZHF3qXCBODPFufpxUraX0F2M3ibEylB05sF3c3pT
         IXLgMLDp22fz/AeZ6W3BVY3YB4X5riLJN3ir8YrgRXD6yRtDtFvwS+QvfTKkG+K6K/
         PF0XoUq4nMBSZz9alDletCJq+qESl0CTcWNQEq9IWjq1c57cap7A7bR/lvO+m4qv/s
         ASgkvryZLfG/w==
Date:   Tue, 19 Apr 2022 21:42:17 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Message-ID: <Yl8CicJGHpTrOK8m@kernel.org>
References: <20220415164413.2727220-1-song@kernel.org>
 <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org>
 <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com>
 <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
 <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com>
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

On Tue, Apr 19, 2022 at 05:36:45AM +0000, Song Liu wrote:
> Hi Mike, Luis, and Rick,
> 
> Thanks for sharing your work and findings in the space. I didn't 
> realize we were looking at the same set of problems. 
> 
> > On Apr 18, 2022, at 6:56 PM, Edgecombe, Rick P <rick.p.edgecombe@intel.com> wrote:
> > 
> > On Mon, 2022-04-18 at 17:44 -0700, Luis Chamberlain wrote:
> >>> There are use-cases that require 4K pages with non-default
> >>> permissions in
> >>> the direct map and the pages not necessarily should be executable.
> >>> There
> >>> were several suggestions to implement caches of 4K pages backed by
> >>> 2M
> >>> pages.
> >> 
> >> Even if we just focus on the executable side of the story... there
> >> may
> >> be users who can share this too.
> >> 
> >> I've gone down memory lane now at least down to year 2005 in kprobes
> >> to see why the heck module_alloc() was used. At first glance there
> >> are
> >> some old comments about being within the 2 GiB text kernel range...
> >> But
> >> some old tribal knowledge is still lost. The real hints come from
> >> kprobe work
> >> since commit 9ec4b1f356b3 ("[PATCH] kprobes: fix single-step out of
> >> line
> >> - take2"), so that the "For the %rip-relative displacement fixups to
> >> be
> >> doable"... but this got me wondering, would other users who *do* want
> >> similar funcionality benefit from a cache. If the space is limited
> >> then
> >> using a cache makes sense. Specially if architectures tend to require
> >> hacks for some of this to all work.
> > 
> > Yea, that was my understanding. X86 modules have to be linked within
> > 2GB of the kernel text, also eBPF x86 JIT generates code that expects
> > to be within 2GB of the kernel text.
> > 
> > 
> > I think of two types of caches we could have: caches of unmapped pages
> > on the direct map and caches of virtual memory mappings. Caches of
> > pages on the direct map reduce breakage of the large pages (and is
> > somewhat x86 specific problem). Caches of virtual memory mappings
> > reduce shootdowns, and are also required to share huge pages. I'll plug
> > my old RFC, where I tried to work towards enabling both:
> > 
> > https://lore.kernel.org/lkml/20201120202426.18009-1-rick.p.edgecombe@intel.com/
> > 
> > Since then Mike has taken a lot further the direct map cache piece.
> 
> These are really interesting work. With this landed, we won't need 
> the bpf_prog_pack work at all (I think). OTOH, this looks like a 
> long term project, as some of the work in bpf_prog_pack took quite 
> some time to discuss/debate, and that was just a subset of the 
> whole thing. 

I'd say that bpf_prog_pack was a cure for symptoms and this project tries
to address more general problem.
But you are right, it'll take some time and won't land in 5.19.
 
> I really like the two types of cache concept. But there are some 
> details I cannot figure out about them:

After some discussions we decided to try moving the caching of large pages
to the page allocator and see if the second cache will be needed at all.
But I've got distracted after posting the RFC and that work didn't have
real progress since then.
 
> 1. Is "caches of unmapped pages on direct map" (cache #1) 
>    sufficient to fix all direct map fragmentation? IIUC, pages in
>    the cache may still be used by other allocation (with some 
>    memory pressure). If the system runs for long enough, there 
>    may be a lot of direct map fragmentation. Is this right?

If the system runs long enough, it may run out of high-order free pages
regardless of the way the caches are implemented. Then we either fail the
allocation because it is impossible to refill the cache with large pages or
fall back to 4k pages and fragment direct map.

I don't see how can we avoid direct map fragmentation entirely and still be
able to allocate memory for users of set_memory APIs.

> 2. If we have "cache of virtual memory mappings" (cache #2), do we
>    still need cache #1? I know cache #2 alone may waste some 
>    memory, but I still think 2MB within noise for modern systems. 

I presume that by cache #1 you mean the cache in the page allocator. In
that case cache #2 is probably not needed at all, because the cache at page
allocator level will be used by vmalloc() and friends to provide what Rick
called "permissioned allocations".

> Thanks,
> Song

-- 
Sincerely yours,
Mike.
