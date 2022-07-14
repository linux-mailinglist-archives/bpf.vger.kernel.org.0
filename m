Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4435745D8
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 09:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiGNH1D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 03:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiGNH1D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 03:27:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8543A1A828;
        Thu, 14 Jul 2022 00:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MxjTs9nuJ3FmUOtUGZD4K0rKKYlzahKqtMX7rQs+RMQ=; b=P+HF2qeaBGfEDHrWZkyaJPn3IB
        QiNrtA//HWV+0ORiO+86u7mo74SlcDdcVqFoIgZCWMGIoxYPaVQGU+72wQPOBiQ0vqF2fr+XRsVbn
        nG4Lm56rEpjCfhHtpiCFZf03XpUsAJZgKdFlccUm7lCAO3u1M/WuvVAV2x9aOziByeZBhRqtX/9ft
        5DZmULcqm2l89KTXWlaN47QZXt8XCD3bthIsytQv8r1CKT3O3kx6tAfz7rw9SYprDq1RXGJq2pCc/
        jB9UMMQ/l8jzUSCKC6r6Bmgb5It5ci3rvZPoHr5b7OlcWI/3C+MzPHmlXP8EX53pPhhfRJrmH2Fyh
        PzeRPolA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBtEs-003mx0-U9; Thu, 14 Jul 2022 07:26:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0146980083; Thu, 14 Jul 2022 09:26:22 +0200 (CEST)
Date:   Thu, 14 Jul 2022 09:26:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, mcgrof@kernel.org,
        rostedt@goodmis.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, mhiramat@kernel.org, naveen.n.rao@linux.ibm.com,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        keescook@chromium.org, dave@stgolabs.net, daniel@iogearbox.net,
        kernel-team@fb.com, x86@kernel.org, dave.hansen@linux.intel.com,
        rick.p.edgecombe@intel.com, akpm@linux-foundation.org
Subject: Re: [PATCH bpf-next 1/3] mm/vmalloc: introduce vmalloc_exec which
 allocates RO+X memory
Message-ID: <Ys/FHgonNLo29Bp2@worktop.programming.kicks-ass.net>
References: <20220713071846.3286727-1-song@kernel.org>
 <20220713071846.3286727-2-song@kernel.org>
 <Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net>
 <Ys+mtMUb7lXZ/GaS@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys+mtMUb7lXZ/GaS@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 10:16:36PM -0700, Christoph Hellwig wrote:
> On Wed, Jul 13, 2022 at 12:20:09PM +0200, Peter Zijlstra wrote:
> > Start by adding VM_TOPDOWN_VMAP, which instead of returning the lowest
> > (leftmost) vmap_area that fits, picks the higests (rightmost).
> > 
> > Then add module_alloc_data() that uses VM_TOPDOWN_VMAP and make
> > ARCH_WANTS_MODULE_DATA_IN_VMALLOC use that instead of vmalloc (with a
> > weak function doing the vmalloc).
> > 
> > This gets you bottom of module range is RO+X only, top is shattered
> > between different !X types.
> > 
> > Then track the boundary between X and !X and ensure module_alloc_data()
> > and module_alloc() never cross over and stay strictly separated.
> > 
> > Then change all module_alloc() users to expect RO+X memory, instead of
> > RW.
> > 
> > Then make sure any extention of the X range is 2M aligned.
> > 
> > And presto, *everybody* always uses 2M TLB for text, modules, bpf,
> > ftrace, the lot and nobody is tracking chunks.
> > 
> > Maybe migration can be eased by instead providing module_alloc_text()
> > and ARCH_WANTS_MODULE_ALLOC_TEXT.
> 
> This all looks pretty sensible.  How are we going to do the initial
> write to the executable memory, though?

With something like text_poke_memcpy(). I suppose that the proposed
ARCH_WANTS_MODULE_ALLOC_TEXT needs to imply availability of that too.

If the 4K copy thing ends up being a bottleneck we can easily extend
that to have a 2M option as well.
