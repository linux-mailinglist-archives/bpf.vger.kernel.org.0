Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D32464175D
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 15:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiLCOqg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Dec 2022 09:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLCOqf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Dec 2022 09:46:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2C7DF77
        for <bpf@vger.kernel.org>; Sat,  3 Dec 2022 06:46:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C26CDB80689
        for <bpf@vger.kernel.org>; Sat,  3 Dec 2022 14:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB38C433C1;
        Sat,  3 Dec 2022 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670078791;
        bh=JbgfFxWkZVdk779jGhAIsqHqSPt5FP1SxGAmrFuhBFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QbV4kHKpL+u1T/g+OqlY0ljvJlay8TarlFVHe095jScNDZYmha0SARLw9QLBb/ARy
         3hdKOV6+D2dB6t3Bx9Sip7ddN/Z4xpttOqrqPwekZzMb0XtiOffFAbYev83LkjBP5v
         JFD4mbbPdLkwKCbVKWhbyqPs2WXyx5sRHg4Zf4ZKmQ4tZdsWdQvNiKgi6tVWCJIqjm
         kE6AOuDnLLiYfVRbwDLIBokDR6YFUbq2LOfaG6WhlUEBjfvFuK7Rc1ZHFIt4r+e1Yd
         hT3WeAA6NS14zZf5V2X8lN54zoNR19WpdS1A2KO0b+MEUuGIZb0yrNGG5Mk9vg9N4o
         nikk/i2cqshRg==
Date:   Sat, 3 Dec 2022 16:46:14 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y4thNkNW30x8Wcx8@kernel.org>
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx>
 <Y4kNMpRgvEN2KrkD@kernel.org>
 <87mt86rbvy.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt86rbvy.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Thomas,

On Thu, Dec 01, 2022 at 11:34:57PM +0100, Thomas Gleixner wrote:
> Mike!
> 
> On Thu, Dec 01 2022 at 22:23, Mike Rapoport wrote:
> > On Thu, Dec 01, 2022 at 10:08:18AM +0100, Thomas Gleixner wrote:
> >> On Wed, Nov 30 2022 at 08:18, Song Liu wrote:
> >> The symptom is iTLB pressure. The root cause is the way how module
> >> memory is allocated, which in turn causes the fragmentation into
> >> 4k PTEs. That's the same problem for anything which uses module_alloc()
> >> to get space for text allocated, e.g. kprobes, tracing....
> >
> > There's also dTLB pressure caused by the fragmentation of the direct map.
> > The memory allocated with module_alloc() is a priori mapped with 4k PTEs,
> > but setting RO in the malloc address space also updates the direct map
> > alias and this causes splits of large pages.
> >
> > It's not clear what causes more performance improvement: avoiding splits of
> > large pages in the direct map or reducing iTLB pressure by backing text
> > memory with 2M pages.
> 
> From our experiments when doing the first version of the SKX retbleed
> mitigation, the main improvement came from reducing iTLB pressure simply
> because the iTLB cache is really small.
> 
> The kernel text placement is way beyond suboptimal. If you really do a
> hotpath analysis and (manually) place all hot code into one or two 2M
> pages, then you can achieve massive performance improvements way above
> the 10% range.
> 
> We currently have a master student investigating this, but it will take
> some time until usable results materialize.
> 
> > If the major improvement comes from keeping direct map intact, it's
> > might be possible to mix data and text in the same 2M page.
> 
> No. That can't work.
> 
>     text = RX
>     data = RW or RO
> 
> If you mix this, then you end up with RWX for the whole 2M page. Not an
> option really as you lose _all_ protections in one go.

I meant to take one 2M page from the direct map and split it to 4K in the
module address space. Then the protection could be done at PTE level after
relocations etc and it would save the dance with text poking. But if
mapping the code with 2M pages gives massive performance improvements,
it's surely better to keep 2M pages in the modules space.
 
> Thanks,
> 
>         tglx

-- 
Sincerely yours,
Mike.
