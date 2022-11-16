Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889B462CF22
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 00:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiKPXx7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 18:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiKPXx5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 18:53:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAFD60372
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 15:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jXsTQ6UgBt/n03y8z/yQU/gmTXj684z17e8Hwln5Ysc=; b=Phd0VpGqvG8wUAIlVn6fL650de
        QC1iMSQcjGMBgvA1CS/TNEhuGge33jnn9B7xA8sUnlDsQhFIt3ubkwmJflsTMPG4Qu4Wvm1VW2f5L
        5iNVrqrzkhtvYyHDsKsNxR1YmXgdC2boX1zPw13BAqiZsgaTiaNtQN9HsmVQYApH5WwKRjbDVx7UO
        a50PfDO5KWfO2PmI9r525caVcBYwPvRnH0NIKY4GdHH14XOt8Yz1A7tPI+q9h5OD8X6HnLPJO2b+w
        1YOD0uL+RcAQokioVBV8dj8OF3I6mESmV0hvVKBynnCyQMNeDJ6gkXiOcVJiNTIBCy9wqQOW2ydCd
        tYYe4c8A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovSE0-008lxa-Md; Wed, 16 Nov 2022 23:53:48 +0000
Date:   Wed, 16 Nov 2022 15:53:48 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "song@kernel.org" <song@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y3V4DEUeICDBYt62@bombadil.infradead.org>
References: <20221107223921.3451913-1-song@kernel.org>
 <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
 <Y3P/9DXAjKhmoIvm@bombadil.infradead.org>
 <CAPhsuW4_aYvPJUfCBkMygKPpHx7Y3xPCV7ewLGGAhyztJq3dhA@mail.gmail.com>
 <Y3VlQcsiEi273S+n@bombadil.infradead.org>
 <cea2f9f81db0a5db9cdc1ed9089454ddbd28541b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cea2f9f81db0a5db9cdc1ed9089454ddbd28541b.camel@intel.com>
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

On Wed, Nov 16, 2022 at 10:47:04PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2022-11-16 at 14:33 -0800, Luis Chamberlain wrote:
> > More in lines with what I was hoping for. Can something just do
> > the parallelization for you in one shot? Can bench alone do it for
> > you?
> > Is there no interest to have soemthing which generically showcases
> > multithreading / hammering a system with tons of eBPF JITs? It may
> > prove useful.
> > 
> > And also, it begs the question, what if you had another iTLB generic
> > benchmark or genearl memory pressure workload running *as* you run
> > the
> > above? I as, as it was my understanding that one of the issues was
> > the
> > long term slowdown caused by the directmap fragmentation without
> > bpf_prog_pack, and so such an application should crawl to its knees
> > over time, and there should be numbers you could show to prove that
> > too, before and after.
> 
> We did have some benchmarks that showed if your direct map was totally
> fragmented (started from boot at 4k page size) what the regression was:
> 
> 
> https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/

Oh yes that is a good example of effort, but I'm suggesting taking for
instance will-it-scale and run it in tandem with bpg prog pack
and measure on *both* iTLB differences, before / after, *and* doing
this again after a period of expected deterioation of the direct
map fragmentation (say after non-bpf-prog-pack shows high direct
map fragmetnation).

This is the sort of thing which easily go into a commit log.

  Luis
