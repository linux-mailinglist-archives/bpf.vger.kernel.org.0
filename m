Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3887352FF27
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 22:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbiEUUGy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 May 2022 16:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiEUUGx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 May 2022 16:06:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C145DA43;
        Sat, 21 May 2022 13:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6RJZZ9GKXF2oPgJqUmsSl8BxgwimEU+9Op6eCE+aZ18=; b=HAO8AdoDEjqRdjVRW84r8k7CfD
        hvduhI426Sg+CUGZgzcKbmhoOQ3EcKVe+MWMqxLTInePwz9wiRtHQnyq3VjEXafbwqgh2UnmXTphj
        cgIk6jUy+5bczT2ay9suMTuPG3+ho7h8hRw70mB27gxjsa7Vt3T0+RODEoazhzzc9MoWpRrX4KhQS
        KA7sUaUtXhhb5HVMvtnSjdc1HaHFMJRiQBkWNdfiMmMRRD9ruUpO2SeOQBOit6cwGclQEzRqw2gPA
        1ieksBLcX+qf53Ou51s1Uzmch6QIwGfFvHOH1Hx1f3R+QAKJ1kEs/p/Xo1nMGZFJx4IJrOTRZm5IX
        eHG86slA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsVN5-00HON3-Ba; Sat, 21 May 2022 20:06:43 +0000
Date:   Sat, 21 May 2022 13:06:43 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     "song@kernel.org" <song@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 bpf-next 5/8] bpf: use module_alloc_huge for
 bpf_prog_pack
Message-ID: <YolGU5JGE9NVrrrc@bombadil.infradead.org>
References: <20220520031548.338934-1-song@kernel.org>
 <20220520031548.338934-6-song@kernel.org>
 <Yog5yXqAQZAmpgCD@bombadil.infradead.org>
 <17c6110273d59e3fdeea3338abefac03951ff404.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17c6110273d59e3fdeea3338abefac03951ff404.camel@intel.com>
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

On Sat, May 21, 2022 at 03:20:28AM +0000, Edgecombe, Rick P wrote:
> On Fri, 2022-05-20 at 18:00 -0700, Luis Chamberlain wrote:
> > although VM_FLUSH_RESET_PERMS is rather new my concern here is we're
> > essentially enabling sloppy users to grow without also addressing
> > what if we have to take the leash back to support
> > VM_FLUSH_RESET_PERMS
> > properly? If the hack to support this on other architectures other
> > than
> > x86 is as simple as the one you in vm_remove_mappings() today:
> > 
> >         if (flush_reset &&
> > !IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
> >                 set_memory_nx(addr, area->nr_pages);
> >                 set_memory_rw(addr, area->nr_pages);
> >         }
> > 
> > then I suppose this isn't a big deal. I'm just concerned here this
> > being
> > a slippery slope of sloppiness leading to something which we will
> > regret later.
> > 
> > My intution tells me this shouldn't be a big issue, but I just want
> > to
> > confirm.
> 
> Yea, I commented the same concern on the last thread:
> 
> https://lore.kernel.org/lkml/83a69976cb93e69c5ad7a9511b5e57c402eee19d.camel@intel.com/
> 
> Song said he plans to make kprobes and ftrace work with this new
> allocator. If that happens VM_FLUSH_RESET_PERMS would only have one
> user - modules. Care to chime in with your plans for modules?

My plans are to not break things and to slowly tidy things up. If
you see linux-next, things are at least starting to be split in
nice pieces. With time, clean that further so to not break things.
You were the one who added VM_FLUSH_RESET_PERMS, wasn't that to deal
with secmem stuff? So wouldn't you know better what you recommend for it?

Seeing all this, given module_alloc() users are growing and seeing
the tiny bit of growth of use in this space, I'd think we should
rename module_alloc() to vmalloc_exec(), and likewise the same for
module_memfree() to vmalloc_exec_free(). But it would be our first
__weak vmalloc, and not sure if that's looked down upon.

> If there
> are actual near term plans to keep working on this,
> VM_FLUSH_RESET_PERMS might be changed again or turn into something
> else. Like if we are about to re-think everything, then it doesn't
> matter as much to fix what would then be old.

I think it's up to you as you added it and I'm not looking to add
any bells or wistles, just tidy things up *slowly*.

> Besides not fixing VM_FLUSH_RESET_PERMS/hibernate though, I think this
> allocator still feels a little rough. For example I don't think we
> actually know how much the huge mappings are helping.

Right, 100% agreed. The performance numbers provided are nice but
they are not anything folks can reproduce at all. I hinted towards
perf stuff which could be used and enable other users later to also
use similar stats to showcase its value if they want to move to
huge pages.

It is a side note, and perhaps a stupid question, as I don't grok mm,
but I'm perplexed about the fact that if the value is seen so high towards
huge pages for exec stuff in kernel, wouldn't there be a few folks who
might want to try this for regular exec stuff? Wouldn't there be much
more gains there?

> It is also
> allocating memory in a big chunk from a single node and reusing it,
> where before we were allocating based on numa node for each jit. Would
> some user's suffer from that? Maybe it's obvious to others, but I would
> have expected to see more discussion of MM things like that.

Curious, why was it moved to use a single node?

> But I like general direction of caching and using text_poke() to write
> the jits a lot. However it works, it seems to make a big impact in at
> least some workloads.
> 
> So yea, seems sloppy, but probably (...I guess?) more good for users
> then sloppy for us.

The impact of sloppiness lies in possible odd bugs later and trying to
decipher what was being done. So I do have concerns with the immediate
tribal knowlege incurred by the current implementation. What is your
own roadmap for VM_FLUSH_RESET_PERMS? Sounds like a future possibly
maybe re-do?

  Luis
