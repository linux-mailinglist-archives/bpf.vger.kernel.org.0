Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800B0506129
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 02:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243127AbiDSAs0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 20:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243271AbiDSAsR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 20:48:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A231133A1A;
        Mon, 18 Apr 2022 17:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F6kyX/KE6uI93AUNHdOTXTCcOPf0qyiNPQDSWpMU/TM=; b=b/bYxKGFNiV6xLz4PGlyGIoYHS
        63aXslrz0QFZ4xmrI51U5vg4KVFT92tUKixltibZDPwatSplMZ8nOhGPZ6dCawdXLyaf3M1hHSWYH
        b4c88WaO2DMTFRIE6Qc2uWN82agDaSzosxdofYDGLYv3evPVEaJdxSaJxi2ps6qkPEluujhkF8WtJ
        LWKGHMfwsqrt2yg4OFjz7msONW5apIdH71KGo++oeiCU9lwo4Cf9Y+s+xiIKPvMg/Eb2lIGPAyNfE
        4R6I67g/gARRMJQe7pDv41rMP4tfZiJgt61rGdKi/t66ax6DNbW/+Bl0TksuFS66K+jfJptrHHQJz
        bYtuvahg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngbyd-000xTZ-WE; Tue, 19 Apr 2022 00:44:20 +0000
Date:   Mon, 18 Apr 2022 17:44:19 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
References: <20220415164413.2727220-1-song@kernel.org>
 <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org>
 <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com>
 <Yl04LO/PfB3GocvU@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl04LO/PfB3GocvU@kernel.org>
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

On Mon, Apr 18, 2022 at 01:06:36PM +0300, Mike Rapoport wrote:
> Hi,
> 
> On Sat, Apr 16, 2022 at 10:26:08PM +0000, Song Liu wrote:
> > > On Apr 16, 2022, at 1:30 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > 
> > > Maybe I am missing something, but I really don't think this is ready
> > > for prime-time. We should effectively disable it all, and have people
> > > think through it a lot more.
> > 
> > This has been discussed on lwn.net: https://lwn.net/Articles/883454/. 
> > AFAICT, the biggest concern is whether reserving minimal 2MB for BPF
> > programs is a good trade-off for memory usage. This is again my fault
> > not to state the motivation clearly: the primary gain comes from less 
> > page table fragmentation and thus better iTLB efficiency. 
> 
> Reserving 2MB pages for BPF programs will indeed reduce the fragmentation,
> but OTOH it will reduce memory utilization. If for large systems this may
> not be an issue, on smaller machines trading off memory for iTLB
> performance may be not that obvious.

So the current optimization at best should be a kconfig option?

> > Other folks (in recent thread on this topic and offline in other 
> > discussions) also showed strong interests in using similar technical 
> > for text of kernel modules. So I would really like to learn your 
> > opinion on this. There are many details we can optimize, but I guess 
> > the general mechanism has to be something like:
> >  - allocate a huge page, make it safe, and set it as executable;
> >  - as users (BPF, kernel module, etc.) request memory for text, give
> >    a chunk of the huge page to the user. 
> >  - use some mechanism to update the chunk of memory safely. 
> 
> There are use-cases that require 4K pages with non-default permissions in
> the direct map and the pages not necessarily should be executable. There
> were several suggestions to implement caches of 4K pages backed by 2M
> pages.

Even if we just focus on the executable side of the story... there may
be users who can share this too.

I've gone down memory lane now at least down to year 2005 in kprobes
to see why the heck module_alloc() was used. At first glance there are
some old comments about being within the 2 GiB text kernel range... But
some old tribal knowledge is still lost. The real hints come from kprobe work
since commit 9ec4b1f356b3 ("[PATCH] kprobes: fix single-step out of line
- take2"), so that the "For the %rip-relative displacement fixups to be
doable"... but this got me wondering, would other users who *do* want
similar funcionality benefit from a cache. If the space is limited then
using a cache makes sense. Specially if architectures tend to require
hacks for some of this to all work.

Then, since it seems since the vmalloc area was not initialized,
wouldn't that break the old JIT spray fixes, refer to commit
314beb9bcabfd ("x86: bpf_jit_comp: secure bpf jit against spraying
attacks")?

Is that sort of work not needed anymore? If in doubt I at least made the
old proof of concept JIT spray stuff compile on recent kernels [0], but
I haven't tried out your patches yet. If this is not needed anymore,
why not?

The collection of tribal knowedge around these sorts of things would be
good to not loose and if we can share, even better.

> I believe that "allocate huge page and split it to basic pages to hand out
> to users" concept should be implemented at page allocator level and I
> posted and RFC for this a while ago:
> 
> https://lore.kernel.org/all/20220127085608.306306-1-rppt@kernel.org/

Neat, so although eBPF is a big user, are there some use cases outside
that immediately benefit?

[0] https://github.com/mcgrof/jit-spray-poc-for-ksp

  LUis
