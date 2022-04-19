Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3625507BE1
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 23:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354820AbiDSV1x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 17:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357996AbiDSV1b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 17:27:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F36A41FBE;
        Tue, 19 Apr 2022 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ihkj2wHPBAUKthVXXuVPWB+NA4n/479tgHeM8Fev0u4=; b=v5/F7RKSCKliEACj3sJEJ9nr5Z
        nc9tZ3tZpxzsMQfiYsmcmpaQffVXbUBNXjJWApjuvCztMvW568/Qcw0zYd6DQwhJvIE6y2G6cjx2B
        oFbrCFYx4KesVc0Tq3583T3X6CWgjNAi0Ao/VrxTm9PWbFfogoPDoN0/OdIjRv/yXTH2xnry9Pbs4
        WCR25Ht6GlIpRtUthFNz20MCkhkO5o1ksPTao1iLv9Cq7tOFp+tcVRin88AFLzKVy06eMQCyFWJBr
        ejxkweNXvvpim20sO+jj9vEBWbL14E+VGNhyOMA284xwzMq4ehGXVzFrULCsHkkeOhIAjCw5BlY3o
        uc1mIS6Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngvKw-006QgY-N5; Tue, 19 Apr 2022 21:24:38 +0000
Date:   Tue, 19 Apr 2022 14:24:38 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "rppt@kernel.org" <rppt@kernel.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Message-ID: <Yl8olpqvZxY8KoNf@bombadil.infradead.org>
References: <20220415164413.2727220-1-song@kernel.org>
 <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org>
 <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com>
 <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
 <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
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

On Tue, Apr 19, 2022 at 01:56:03AM +0000, Edgecombe, Rick P wrote:
> Yea, that was my understanding. X86 modules have to be linked within
> 2GB of the kernel text, also eBPF x86 JIT generates code that expects
> to be within 2GB of the kernel text.

And kprobes / live patching / ftrace.

Another architectural fun fact, powerpc book3s/32 requires executability
to be set per 256 Mbytes segments. Some architectures like this one
will want to also optimize how they use the module alloc area.

Even though today the use cases might be limited, we don't exactly know
how much memory a target device has a well, and so treating memory
failures for "special memory" request as regular memory failures seems
a bit odd, and users could get confused. For instance slapping on
extra memory on a system won't resolve any issues if the limit for a
special type of memory is already hit. Very likely not a problem at all today,
given how small modules / eBPF jit programs are / etc, but conceptually it
would seem wrong to just say -ENOMEM when in fact it's a special type of
required memory which cannot be allocated and the issue cannot possibly be
fixed. I don't think we have an option but to use -ENOMEM but at least
hinting of the special failure would have seem desirable.

Do we have other type of architectural limitations for "special memory"
other than executable? Do we have *new* types of special memory we
should consider which might be similar / limited in nature? And can / could /
should these architectural limitations hopefully be disappear in newer CPUs?
I see vmalloc_pks() as you pointed out [0] . Anything else?

> I think of two types of caches we could have: caches of unmapped pages
> on the direct map and caches of virtual memory mappings. Caches of
> pages on the direct map reduce breakage of the large pages (and is
> somewhat x86 specific problem). Caches of virtual memory mappings
> reduce shootdowns, and are also required to share huge pages. I'll plug
> my old RFC, where I tried to work towards enabling both:
> 
> https://lore.kernel.org/lkml/20201120202426.18009-1-rick.p.edgecombe@intel.com/
> 
> Since then Mike has taken a lot further the direct map cache piece.
> 
> Yea, probably a lot of JIT's are way smaller than a page, but there is
> also hopefully some performance benefit of reduced ITLB pressure and
> TLB shootdowns. I think kprobes/ftrace (or at least one of them) keeps
> its own cache of a page for putting very small trampolines.

The reason I looked into *why* module_alloc() was used was particularly
because it seemed a bit odd to have such ITLB enhancements for such
a niche use case and we couldn't have desired this elsewhere before.

> > Then, since it seems since the vmalloc area was not initialized,
> > wouldn't that break the old JIT spray fixes, refer to commit
> > 314beb9bcabfd ("x86: bpf_jit_comp: secure bpf jit against spraying
> > attacks")?
> 
> Hmm, yea it might be a way to get around the ebpf jit rlimit. The
> allocator could just text_poke() invalid instructions on "free" of the
> jit.
> 
> > 
> > Is that sort of work not needed anymore? If in doubt I at least made
> > the
> > old proof of concept JIT spray stuff compile on recent kernels [0],
> > but
> > I haven't tried out your patches yet. If this is not needed anymore,
> > why not?
> 
> IIRC this got addressed in two ways, randomizing of the jit offset
> inside the vmalloc allocation, and "constant blinding", such that the
> specific attack of inserting unaligned instructions as immediate
> instruction data did not work. Neither of those mitigations seem
> unworkable with a large page caching allocator.

Got it, but was it *also* considerd in the fixes posted recently?

> > The collection of tribal knowedge around these sorts of things would
> > be
> > good to not loose and if we can share, even better.
> 
> Totally agree here. I think the abstraction I was exploring in that RFC
> could remove some of the special permission memory tribal knowledge
> that is lurking in in the cross-arch module.c. I wonder if you have any
> thoughts on something like that? The normal modules proved the hardest.

Yeah modules will be harder now with the new ARCH_WANTS_MODULES_DATA_IN_VMALLOC
which Christophe Leroy added (queued in my modules-next). At a quick
glance it seems like an API in the right direction, but you just need
more architecture folks other than the usual x86 suspects to review.

Perhaps time for a new spin?

[0] https://lore.kernel.org/lkml/20201009201410.3209180-2-ira.weiny@intel.com/

  Luis
