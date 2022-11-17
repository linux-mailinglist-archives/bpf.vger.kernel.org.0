Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C553462E592
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 21:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiKQUDX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 15:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiKQUDW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 15:03:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA387EC9A
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 12:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FcAYr4gBbStA90UAkNjkCDlD87od9wSj6+Q/aTuxWb8=; b=Oq/wAY4PiNM520klJuko4vIl5I
        JiDrLe9XzlvJyuqHLPglApi7mJtWAl0GhRgouD40ShOUIANy5Nz9468ptgcmjwyDCWTxMvWaYkttY
        Gr0KECavj8nqJvzetoCfUhhkE8QDzMEJm79aOuIdaMV/je45XnslBJCe3KBO/KLF/s8z5iXAcghEE
        mDIizyRF1GxFJIeyvy/8ws870BRFQEnkidUyZyxt15sPpGvMBgRw+M9S4wOwlAAMnWwX/W00XNXU1
        zYkOy5O6F5AWRXPAkXHBQEr0wZqKA1aXCj2ZPBmVNBo+FSGo8tbOMfUNPMSk9bxY2oY928IK/HLeG
        T+KCshxQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovl6V-00H4tA-HT; Thu, 17 Nov 2022 20:03:19 +0000
Date:   Thu, 17 Nov 2022 12:03:19 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        aaron.lu@intel.com, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH bpf-next v3 4/6] bpf: use execmem_alloc for bpf program
 and bpf dispatcher
Message-ID: <Y3aTh7SFU+TW4fBp@bombadil.infradead.org>
References: <20221117010621.1891711-1-song@kernel.org>
 <20221117010621.1891711-5-song@kernel.org>
 <Y3WT6rwrM78sqkR5@bombadil.infradead.org>
 <CAADnVQL6AiQLaURNbchVtUNK2nGFUYCSPZk5dZbScW=iKp1bYw@mail.gmail.com>
 <Y3aTGs9rtWiHpoea@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3aTGs9rtWiHpoea@bombadil.infradead.org>
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

On Thu, Nov 17, 2022 at 12:01:30PM -0800, Luis Chamberlain wrote:
> On Wed, Nov 16, 2022 at 06:10:23PM -0800, Alexei Starovoitov wrote:
> > On Wed, Nov 16, 2022 at 6:04 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Wed, Nov 16, 2022 at 05:06:19PM -0800, Song Liu wrote:
> > > > Use execmem_alloc, execmem_free, and execmem_fill instead of
> > > > bpf_prog_pack_alloc, bpf_prog_pack_free, and bpf_arch_text_copy.
> > > >
> > > > execmem_free doesn't require extra size information. Therefore, the free
> > > > and error handling path can be simplified.
> > > >
> > > > There are some tests that show the benefit of execmem_alloc.
> > > >
> > > > Run 100 instances of the following benchmark from bpf selftests:
> > > >   tools/testing/selftests/bpf/bench -w2 -d100 -a trig-kprobe
> > > > which loads 7 BPF programs, and triggers one of them.
> > > >
> > > > Then use perf to monitor TLB related counters:
> > > >    perf stat -e iTLB-load-misses,itlb_misses.walk_completed_4k, \
> > > >            itlb_misses.walk_completed_2m_4m -a
> > > >
> > > > The following results are from a qemu VM with 32 cores.
> > > >
> > > > Before bpf_prog_pack:
> > > >   iTLB-load-misses: 350k/s
> > > >   itlb_misses.walk_completed_4k: 90k/s
> > > >   itlb_misses.walk_completed_2m_4m: 0.1/s
> > > >
> > > > With bpf_prog_pack (current upstream):
> > > >   iTLB-load-misses: 220k/s
> > > >   itlb_misses.walk_completed_4k: 68k/s
> > > >   itlb_misses.walk_completed_2m_4m: 0.2/s
> > > >
> > > > With execmem_alloc (with this set):
> > > >   iTLB-load-misses: 185k/s
> > > >   itlb_misses.walk_completed_4k: 58k/s
> > > >   itlb_misses.walk_completed_2m_4m: 1/s
> > >
> > > Wonderful.
> > >
> > > It would be nice to have this integrated into the bpf selftest,
> > 
> > 
> > No. Luis please stop suggesting things that don't make sense.
> > selftest/bpf are not doing performance benchmarking.
> > We have the 'bench' tool for that.
> > That's what Song used and it's only running standalone
> > and not part of any CI.
> 
> I'm not suggesting to instantiate the VM or crap like that, I'm just
> asking for the simple script to run 100 instances. This allows folks
> to reproduce results in an easy way.
> 
> Whether or not you don't want that for selftests/bpf -- fine, a simple
> in commit script can easily represent a loop in bash if that's all
> that was done.

There's also the issue of assuming virtual iTLB stats are reliable
representations of what we see on bare metal, so it'd be nice to get
bare metal stats too.

  Luis
