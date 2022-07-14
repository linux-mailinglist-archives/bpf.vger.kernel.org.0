Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D277457446C
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 07:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiGNFQq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 01:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGNFQo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 01:16:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEAB19C17;
        Wed, 13 Jul 2022 22:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kfxG0GflTYK2rVDQ1Eftf+2+9iqqtquaqgZinGYsuok=; b=I/L/E3pi70OErlf0Jgz2lxTbMU
        eKylmmT8hh7AfPHIvrWAIlYnG4rMvx+s/LGYVujwy+smLPeO/GqDrzp1t2ZNv/mGaUVLxHj6J8RWc
        iCwq/UAS/wdzlaW0XcvzlhPSKMh6i5Z4dQ9bQFR0rvV3AyXHyX2vfuoiLfu+oUVyipSVfsrRMuMfW
        IIyolFHrH6bytSUI2SgfaaVBtPpgd1lZitsLNF0qaStPZJfQaFQ4FbFO532OicmE8bdnSC0BB+a8Y
        AWEGtxQz7qx8ONl1OSiZXBKvfoxyOeUvj86zrp7Bbwa0Sp4KyOk+VJBVPZxiUfqCgaJmRWG7NBz46
        ki4SqDTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBrDI-00Azuv-OK; Thu, 14 Jul 2022 05:16:36 +0000
Date:   Wed, 13 Jul 2022 22:16:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, mcgrof@kernel.org,
        rostedt@goodmis.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, mhiramat@kernel.org, naveen.n.rao@linux.ibm.com,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        keescook@chromium.org, hch@infradead.org, dave@stgolabs.net,
        daniel@iogearbox.net, kernel-team@fb.com, x86@kernel.org,
        dave.hansen@linux.intel.com, rick.p.edgecombe@intel.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH bpf-next 1/3] mm/vmalloc: introduce vmalloc_exec which
 allocates RO+X memory
Message-ID: <Ys+mtMUb7lXZ/GaS@infradead.org>
References: <20220713071846.3286727-1-song@kernel.org>
 <20220713071846.3286727-2-song@kernel.org>
 <Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 12:20:09PM +0200, Peter Zijlstra wrote:
> Start by adding VM_TOPDOWN_VMAP, which instead of returning the lowest
> (leftmost) vmap_area that fits, picks the higests (rightmost).
> 
> Then add module_alloc_data() that uses VM_TOPDOWN_VMAP and make
> ARCH_WANTS_MODULE_DATA_IN_VMALLOC use that instead of vmalloc (with a
> weak function doing the vmalloc).
> 
> This gets you bottom of module range is RO+X only, top is shattered
> between different !X types.
> 
> Then track the boundary between X and !X and ensure module_alloc_data()
> and module_alloc() never cross over and stay strictly separated.
> 
> Then change all module_alloc() users to expect RO+X memory, instead of
> RW.
> 
> Then make sure any extention of the X range is 2M aligned.
> 
> And presto, *everybody* always uses 2M TLB for text, modules, bpf,
> ftrace, the lot and nobody is tracking chunks.
> 
> Maybe migration can be eased by instead providing module_alloc_text()
> and ARCH_WANTS_MODULE_ALLOC_TEXT.

This all looks pretty sensible.  How are we going to do the initial
write to the executable memory, though?
