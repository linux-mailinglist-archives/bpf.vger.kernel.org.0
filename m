Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9709C574A64
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 12:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbiGNKQk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 06:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbiGNKQj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 06:16:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586DB120A5;
        Thu, 14 Jul 2022 03:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Gkk0NC34K+apqrYO+RTe0+nfUNqT3lfjLteCbnILho=; b=UFnSe+fhAVY6yhXjV2wPJ61iZ8
        2Zw0OYv0osZnIIxvRy4gbl9Ye5kgg+qtQKMQkvhFyAK32I4SIz8biMp+cQChL4nwYrIOG6C9ex0Ef
        f8U+9j9tY1bXIkJVNz+BPOChOnGQrY3uTbXPb+H8mB29/YqRxwsKepdNGgjXhQGGRQAiaiCXQXaCR
        fpHfR8jE+VDhlrnJsDgRZjQMdGT1qeIdRxvz6Re/H0sOAKr8FKrB+YaDbMcUjAbbDYwWHaeq77Jdg
        /X5bj3osOCoUykMSaOAx17CzfJkkDvSFWE1X4eNNlbC4Qk3E0NHW17ULmCJInK+jjxGJdV7o3rS7d
        pVljFdig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBvsy-009HkF-C2; Thu, 14 Jul 2022 10:15:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E144A980120; Thu, 14 Jul 2022 12:10:36 +0200 (CEST)
Date:   Thu, 14 Jul 2022 12:10:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next 1/3] mm/vmalloc: introduce vmalloc_exec which
 allocates RO+X memory
Message-ID: <Ys/rnFf/ewPA85Iz@worktop.programming.kicks-ass.net>
References: <20220713071846.3286727-1-song@kernel.org>
 <20220713071846.3286727-2-song@kernel.org>
 <Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net>
 <7C927986-3665-4BD6-A339-D3FE4A71E3D4@fb.com>
 <Ys8qfRwkTbUYwmKM@worktop.programming.kicks-ass.net>
 <78A18945-0841-4CCE-8A33-6C09ECBFF7E1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78A18945-0841-4CCE-8A33-6C09ECBFF7E1@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 09:20:55PM +0000, Song Liu wrote:
> 
> 
> > On Jul 13, 2022, at 1:26 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Wed, Jul 13, 2022 at 03:48:35PM +0000, Song Liu wrote:
> > 
> >>> So how about instead we separate them? Then much of the problem goes
> >>> away, you don't need to track these 2M chunks at all.
> >> 
> >> If we manage the memory in < 2MiB granularity, either 4kB or smaller, 
> >> we still need some way to track which parts are being used, no? I mean
> >> the bitmap.  
> > 
> > I was thinking the vmalloc vmap_area tree could help out there.
> 
> Interesting. vmap_area tree indeed keeps a lot of useful information. 
> 
> Currently, powerpc supports CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC, 

Only PPC32; and it's due to a constraint in their MMU vs page
protections.

> which leaves module_alloc just for module text. If this works, we get
> separation between RO+X and RW memory. What would it take to enable
> CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC for x86_64? 

The VM_TOPDOWN_VMAP flag and ensuring the data and code regions never
overlap. Once you have that you can enable it.

Specifically the problem is that data needs to be in the s32 immediate
range just like code, so we're constrained to the module range. Given
that constraint, the easiest solution is to use the different ends of
that range.
