Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF1862A36A
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 21:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbiKOUw0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 15:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238697AbiKOUwK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 15:52:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2AE31DF3
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 12:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IGXK6UF96sychRMLbJMgNydPQFj7X1SPiOuM3exktqA=; b=mfV6HpJVdJ5wtjNpfJFVtyTK/F
        hy+0DRIfaJB2hbfOLnf5GMlSG4RN8A61BAk+iJ17mNvnvDg7sPI6uRyWOPuZnKWOV16CguVZuky0z
        cp+3WkmU9KOQLc2zOcxvy7Foc7eRESjGwkednq6DIPp2QvIhZh8aYd3BXyGrykcY5L3gV/Nimz39U
        onhQvJ1F8d88EshbWVht/WB1/U6cyqgArduVYmf2wVfQ19up0oU5FFtv9WtS4ARMfPzsqthcvVlOJ
        mBsEaG5KrSm+5ALGKfDc1Ilt4HgSMjbSDxAeBjQEQuJBFbCInhBHfd62zOUNBBC4nmHdDYoI56jXG
        mUP/qqog==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov2tt-00Ek74-F5; Tue, 15 Nov 2022 20:51:21 +0000
Date:   Tue, 15 Nov 2022 12:51:21 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y3P7yS4xt7qAMsEQ@bombadil.infradead.org>
References: <20221107223921.3451913-1-song@kernel.org>
 <Y2o9Iz30A3Nruqs4@kernel.org>
 <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
 <Y2uMWvmiPlaNXlZz@kernel.org>
 <CAPhsuW5e8rBnu73DYkyc1L6gC-WBxjTZVwdFC_L12GVyzROR1w@mail.gmail.com>
 <Y3DKKivOwk+5rhNb@kernel.org>
 <CAPhsuW48AJiY2OuZb9ZeLS9Bq4aUN2iceD5iUt8=uCpSe95_xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW48AJiY2OuZb9ZeLS9Bq4aUN2iceD5iUt8=uCpSe95_xw@mail.gmail.com>
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

On Mon, Nov 14, 2022 at 12:45:16PM -0800, Song Liu wrote:
> On Sun, Nov 13, 2022 at 2:43 AM Mike Rapoport <rppt@kernel.org> wrote:
> > Actually, it would be interesting to quantify memory savings/waste as the
> > result of using execmem_alloc()
> 
> From a random system in our fleet, execmem_alloc() saves:
> 
> 139 iTLB entries (1x 2MB entry vs, 140x 4kB entries), which is more than
> 100% of L1 iTLB and about 10% of L2 TLB.

That should be easily reflected then using perf using a real benchmark,
however we don't have such data yet. I have hinted I suspect the reason
might be that the actual loading of eBPF JIT / whatever may need to be
done in parallel a la lib/test_kmod.c, or having the existing ebpf
selftests run JIT tests in parallel, something along those lines,
but I see no effort to showcase that. That's a missed opportunity.

  Luis
