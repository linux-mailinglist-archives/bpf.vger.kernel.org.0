Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F129B618F17
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 04:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiKDDc3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 23:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiKDDbv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 23:31:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A088DFFB
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 20:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bcSYSNvDHZdAJ46wXRu1CIpoQa17xIwvlEBsfNRpqtI=; b=xKgDuZO7/QGr1PXuSZbxoDjeKm
        JkZeptvQzbKI4Cni3sPxrOq0F8MglBd3bqb5Pb1V83fIHeL4agiMg7ZbMdPhfyiZscL7mx+d21+IN
        hyKIbEj9u/bKJPcDwIAT1/C5t8I0kDay23yJL/4XwdkOGpI109g4Fjtzp+6KWKQW/80yhUeo+4JCM
        H0HEhR5+NP2cBfQR273vw2iZ+cFvyPrVRpDc9NDwij9Bermy+Fva4hh8YM4Qc6ti+T2CifPf7cW2z
        eWifPTMguRvS/4k/zuUGsDBljVJwCXw6Zd/zgkbNQL8vxHw1WY5jLU6N6d4OALzwP+7S5uEOoblM2
        M1nHs/+w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqnOT-002Ixy-Rt; Fri, 04 Nov 2022 03:29:21 +0000
Date:   Thu, 3 Nov 2022 20:29:21 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "rppt@kernel.org" <rppt@kernel.org>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [PATCH bpf-next v1 RESEND 1/5] vmalloc: introduce vmalloc_exec,
 vfree_exec, and vcopy_exec
Message-ID: <Y2SHEb/Y6GtKQXFu@bombadil.infradead.org>
References: <20221031222541.1773452-1-song@kernel.org>
 <20221031222541.1773452-2-song@kernel.org>
 <Y2MAR0aj+jcq+15H@bombadil.infradead.org>
 <Y2Pjnd3mxA9fTlox@kernel.org>
 <Y2QPpODzdP+2YSMN@bombadil.infradead.org>
 <eac58f163bd8b6829dff176e67b44c79570025f5.camel@intel.com>
 <Y2Raa2wSQnXwd7j8@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Raa2wSQnXwd7j8@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 03, 2022 at 05:18:51PM -0700, Luis Chamberlain wrote:
> On Thu, Nov 03, 2022 at 09:19:25PM +0000, Edgecombe, Rick P wrote:
> > On Thu, 2022-11-03 at 11:59 -0700, Luis Chamberlain wrote:
> > > > > Mike Rapoport had presented about the Direct map fragmentation
> > > > > problem
> > > > > at Plumbers 2021 [0], and clearly mentioned modules / BPF /
> > > > > ftrace /
> > > > > kprobes as possible sources for this. Then Xing Zhengjun's 2021
> > > > > performance
> > > > > evaluation on whether using 2M/1G pages aggressively for the
> > > > > kernel direct map
> > > > > help performance [1] ends up generally recommending huge pages.
> > > > > The work by Xing
> > > > > though was about using huge pages *alone*, not using a strategy
> > > > > such as in the
> > > > > "bpf prog pack" to share one 2 MiB huge page for *all* small eBPF
> > > > > programs,
> > > > > and that I think is the real golden nugget here.
> > > > > 
> > > > > I contend therefore that the theoretical reduction of iTLB misses
> > > > > by using
> > > > > huge pages for "bpf prog pack" is not what gets your systems to
> > > > > perform
> > > > > somehow better. It should be simply that it reduces fragmentation
> > > > > and
> > > > > *this* generally can help with performance long term. If this is
> > > > > accurate
> > > > > then let's please separate the two aspects to this.
> > > > 
> > > > The direct map fragmentation is the reason for higher TLB miss
> > > > rate, both
> > > > for iTLB and dTLB.
> > > 
> > > OK so then whatever benchmark is running in tandem as eBPF JIT is
> > > hammered
> > > should *also* be measured with perf for iTLB and dTLB. ie, the patch
> > > can
> > > provide such results as a justifications.
> > 
> > Song had done some tests on the old prog pack version that to me seemed
> > to indicate most (or possibly all) of the benefit was direct map
> > fragmentation reduction.
> 
> Matches my observations but I also provided quite a bit of hints as to
> *why* I think that is. I suggested lib/test_kmod.c as an example beefy
> multithreaded selftests which really kicks the hell out of the kernel
> with whatever crap you want to run. That is precicely how I uncovered
> some odd kmod bug lingering for years.

*and*, *perhaps*... it may be that you need another memory intensive benchmark
to run in tandem, one which mimics the behaviour of the internal "shadow
production benchmark", whatever that is.

  Luis
