Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5E961FBA2
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 18:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKGRjK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 12:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiKGRjJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 12:39:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5791A383
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 09:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aHuggXqSZgXb21UbEzsKOKhxQygaz7VUuywqzT42yGc=; b=OCuu9bB9n/ZKIVsn5QDuWO5roj
        lmo3bv9sY7nJeKPbM2xiQFrS7NMiwFZKAlPuyaviXp8XLFkgbhDuiRPozaihJ512T3mqIz8MW2zDK
        3MHOH12/pGhO2pmPyeZPkiieGdnxhkpfBDPpQCR2xwJ3HnIx4syndgtNtyuYXK2Q9dYY0neKQ6IDN
        tWZloHy/7Ty9bWyN4h8mL0dIGl1S3y/D8dbfhqIRiup7fOiiz10khDxhB1LDdZQghuFBHmSR2DPdR
        Sr4ocKOUSoZAbiTv/7Jqc0ZURHqYUcx6s+vYg7QLzKq/jcs3NNC1DTeglO3mNh3GZuu5puOz58K/S
        B8UK4pJQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1os65P-00GkOZ-A8; Mon, 07 Nov 2022 17:39:03 +0000
Date:   Mon, 7 Nov 2022 09:39:03 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        peterz@infradead.org, hch@lst.de, rick.p.edgecombe@intel.com,
        dave.hansen@intel.com, rppt@kernel.org,
        zhengjun.xing@linux.intel.com, kbusch@kernel.org,
        p.raghav@samsung.com, dave@stgolabs.net, vbabka@suse.cz,
        mgorman@suse.de, willy@infradead.org,
        torvalds@linux-foundation.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH bpf-next v1 RESEND 1/5] vmalloc: introduce vmalloc_exec,
 vfree_exec, and vcopy_exec
Message-ID: <Y2lCt7kWG+tsePDL@bombadil.infradead.org>
References: <20221031222541.1773452-1-song@kernel.org>
 <20221031222541.1773452-2-song@kernel.org>
 <Y2MAR0aj+jcq+15H@bombadil.infradead.org>
 <Y2ioTodn+mBXdIqp@ziqianlu-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2ioTodn+mBXdIqp@ziqianlu-desk2>
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

On Mon, Nov 07, 2022 at 02:40:14PM +0800, Aaron Lu wrote:
> Hello,
> 
> On Wed, Nov 02, 2022 at 04:41:59PM -0700, Luis Chamberlain wrote:
> 
> ... ...
> 
> > I'm under the impression that the real missed, undocumented, major value-add
> > here is that the old "BPF prog pack" strategy helps to reduce the direct map
> > fragmentation caused by heavy use of the eBPF JIT programs and this in
> > turn helps your overall random system performance (regardless of what
> > it is you do). As I see it then the eBPF prog pack is just one strategy to
> > try to mitigate memory fragmentation on the direct map caused by the the eBPF
> > JIT programs, so the "slow down" your team has obvserved should be due to the
> > eventual fragmentation caused on the direct map *while* eBPF programs
> > get heavily used.
> > 
> > Mike Rapoport had presented about the Direct map fragmentation problem
> > at Plumbers 2021 [0], and clearly mentioned modules / BPF / ftrace /
> > kprobes as possible sources for this. Then Xing Zhengjun's 2021 performance
> > evaluation on whether using 2M/1G pages aggressively for the kernel direct map
> > help performance [1] ends up generally recommending huge pages. The work by Xing
> > though was about using huge pages *alone*, not using a strategy such as in the
> > "bpf prog pack" to share one 2 MiB huge page for *all* small eBPF programs,
> > and that I think is the real golden nugget here.
> 
> I'm interested in how this patchset (further) improves direct map
> fragmentation so would like to evaluate it to see if my previous work to
> merge small mappings back in architecture layer[1] is still necessary.

You gotta apply it to 6.0.5 which had a large change go in for eBPF
which was not present on 6.0.

> Conclusion: I think bpf_prog_pack is very good at reducing direct map
> fragmentation and this patchset can further improve this situation on
> large machines(with huge amount of memory) or with more large bpf progs
> loaded etc.

Fantastic. Thanks for the analysis, so yet another set of metrics which
I'd hope can be applied to this patch set as this effort is generalized.

Now imagine the effort in cosnideration also of modules / ftrace / kprobes.

> Some imperfect things I can think of are(not related to this patchset):
> 1 Once a split happened, it remains happened. This may not be a big deal
> now with bpf_prog_pack and this patchset because the need to allocate a
> new order-9 page and thus cause a potential split should happen much much
> less;

Not sure I follow, are you suggesting a order-9 (512 bytes) allocation would
trigger a split of the reserved say 2 MiB huge page?

> 2 When a new order-9 page has to be allocated, there is no way to tell
> the allocator to allocate this order-9 page from an already splitted PUD
> range to avoid another PUD mapping split;
> 3 As Mike and others have mentioned, there are other users that can also
> cause direct map split.

Hence the effort to generalize.

  Luis
