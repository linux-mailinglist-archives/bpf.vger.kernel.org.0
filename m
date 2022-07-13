Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37412573402
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 12:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiGMKUu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 06:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbiGMKUt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 06:20:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94484F8949;
        Wed, 13 Jul 2022 03:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/Nrcb7dNYzFUnnxmjdCVTUYMGO8OqXjL/KRXcg2glXY=; b=MA+NUFrq3VNDeScIS3LYDn8cFS
        bSOgVktnX26ZmRbXQxLiIGpUq4prnfK8Na3xUPVgBCQJ+Frxe81tSmKWQs1pfkUeH7F4SCI7EAxcm
        OPvf0/Rewro7fXY0g7qQcncacQZ1HWu8IBs2zwh9rUwt4aWtfBGJRRcjaxTCwNA5uJQpZ6kUyFuc7
        XPF9NB3gtelVmmZK8lZImUV/QEMQKlQs2GdlSrluXAgQPTnMLbYlBjD12v+qRctmH++UAQEvaPtBj
        TmbycN5NxOwPKKbHXngtmqerNV1i2OzxxovzHEOnFWYoqjDBWQYAoilIHjTJiC5zcCE1IKqiYnN4V
        WZIa5t+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBZTW-0083EO-UP; Wed, 13 Jul 2022 10:20:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AF12F30041D;
        Wed, 13 Jul 2022 12:20:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9888D201ECFBD; Wed, 13 Jul 2022 12:20:09 +0200 (CEST)
Date:   Wed, 13 Jul 2022 12:20:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        mcgrof@kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, mhiramat@kernel.org,
        naveen.n.rao@linux.ibm.com, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, keescook@chromium.org,
        hch@infradead.org, dave@stgolabs.net, daniel@iogearbox.net,
        kernel-team@fb.com, x86@kernel.org, dave.hansen@linux.intel.com,
        rick.p.edgecombe@intel.com, akpm@linux-foundation.org
Subject: Re: [PATCH bpf-next 1/3] mm/vmalloc: introduce vmalloc_exec which
 allocates RO+X memory
Message-ID: <Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net>
References: <20220713071846.3286727-1-song@kernel.org>
 <20220713071846.3286727-2-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713071846.3286727-2-song@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 12:18:44AM -0700, Song Liu wrote:
> Dynamically allocated kernel texts, such as module texts, bpf programs,
> and ftrace trampolines, are used in more and more scenarios. Currently,
> these users allocate meory with module_alloc, fill the memory with text,
> and then use set_memory_[ro|x] to protect the memory.
> 
> This approach has two issues:
>  1) each of these user occupies one or more RO+X page, and thus one or
>     more entry in the page table and the iTLB;
>  2) frequent allocate/free of RO+X pages causes fragmentation of kernel
>     direct map [1].
> 
> BPF prog pack [2] addresses this from the BPF side. Now, make the same
> logic available to other users of dynamic kernel text.
> 
> The new API is like:
> 
>   void *vmalloc_exec(size_t size);
>   void vfree_exec(void *addr, size_t size);
> 
> vmalloc_exec has different handling for small and big allocations
> (> PMD_SIZE * num_possible_nodes). bigger allocations have dedicated
> vmalloc allocation; while small allocations share a vmalloc_exec_pack
> with other allocations.
> 
> Once allocated, the vmalloc_exec_pack is filled with invalid instructions

*sigh*, again, INT3 is a *VALID* instruction.

> and protected with RO+X. Some text_poke feature is required to make
> changes to the vmalloc_exec_pack. Therefore, vmalloc_exec requires changes
> from the arch (to provide text_poke family APIs), and the user (to use
> text poke APIs to make any changes to the memory).

I hate the naming; this isn't just vmalloc, this is a whole different
allocator build on top of things.

I'm also not convinced this is the right way to go about doing this;
much of the design here is because of how the module range is mixing
text and data and working around that.

So how about instead we separate them? Then much of the problem goes
away, you don't need to track these 2M chunks at all.

Start by adding VM_TOPDOWN_VMAP, which instead of returning the lowest
(leftmost) vmap_area that fits, picks the higests (rightmost).

Then add module_alloc_data() that uses VM_TOPDOWN_VMAP and make
ARCH_WANTS_MODULE_DATA_IN_VMALLOC use that instead of vmalloc (with a
weak function doing the vmalloc).

This gets you bottom of module range is RO+X only, top is shattered
between different !X types.

Then track the boundary between X and !X and ensure module_alloc_data()
and module_alloc() never cross over and stay strictly separated.

Then change all module_alloc() users to expect RO+X memory, instead of
RW.

Then make sure any extention of the X range is 2M aligned.

And presto, *everybody* always uses 2M TLB for text, modules, bpf,
ftrace, the lot and nobody is tracking chunks.

Maybe migration can be eased by instead providing module_alloc_text()
and ARCH_WANTS_MODULE_ALLOC_TEXT.
