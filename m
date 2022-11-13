Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4C7626F08
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 11:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiKMKnN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 05:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiKMKnM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 05:43:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FD212772
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 02:43:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C665C609EB
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 10:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0E8C433C1;
        Sun, 13 Nov 2022 10:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668336190;
        bh=LnBdTu+myjuNJTl8wC7tpMlkw+WhyVCc7Ez0nbT55RM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxqDrgAV9svfTnb1OVlHhBAB7+gIEdieuv1jtgp5R0dBESWgPfoCabgyVDWldaFnd
         ILd0SLcJKYtkfvUkyod0GL3+Z3OrRdRT/2Bobgap2EnFCLtq6ETYJAMNTgWPn9C73B
         wmwfgpz11SQEy9mJWK802Aay/IWvzmvbwKhw76qCSRYrtN6SE+R0+v0RyvdjibEYJo
         f2E+0UABPVCwb01eKPgrEN+8Gm8FOrnW4mGYbDrVEYQm1/RXlCvWxAoStX2GvG4haI
         xJ/T4OefAom4b14Jm0xJvny2TjpEKK104aboh5OQK82kdH7XGL6NlEDzw6p/qLm/G1
         7iRWy6XEHGkyA==
Date:   Sun, 13 Nov 2022 12:42:50 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y3DKKivOwk+5rhNb@kernel.org>
References: <20221107223921.3451913-1-song@kernel.org>
 <Y2o9Iz30A3Nruqs4@kernel.org>
 <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
 <Y2uMWvmiPlaNXlZz@kernel.org>
 <CAPhsuW5e8rBnu73DYkyc1L6gC-WBxjTZVwdFC_L12GVyzROR1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW5e8rBnu73DYkyc1L6gC-WBxjTZVwdFC_L12GVyzROR1w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 09, 2022 at 09:43:50AM -0800, Song Liu wrote:
> On Wed, Nov 9, 2022 at 3:18 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> [...]
> 
> > > >
> > > > The proposed execmem_alloc() looks to me very much tailored for x86
> > > > to be
> > > > used as a replacement for module_alloc(). Some architectures have
> > > > module_alloc() that is quite different from the default or x86
> > > > version, so
> > > > I'd expect at least some explanation how modules etc can use execmem_
> > > > APIs
> > > > without breaking !x86 architectures.
> > >
> > > I think this is fair, but I think we should ask ask ourselves - how
> > > much should we do in one step?
> >
> > I think that at least we need an evidence that execmem_alloc() etc can be
> > actually used by modules/ftrace/kprobes. Luis said that RFC v2 didn't work
> > for him at all, so having a core MM API for code allocation that only works
> > with BPF on x86 seems not right to me.
> 
> While using execmem_alloc() et. al. in module support is difficult, folks are
> making progress with it. For example, the prototype would be more difficult
> before CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> (introduced by Christophe).
> 
> We also have other users that we can onboard soon: BPF trampoline on
> x86_64, BPF jit and trampoline on arm64, and maybe also on powerpc and
> s390.

Caching of large pages won't make any difference on arm64 and powerpc
because they do not support splitting of the direct map, so the only
potential benefit there is a centralized handling of text loading and I'm
not convinced execmem_alloc() will get us there.

> > With execmem_alloc() as the first step I'm failing to see the large
> > picture. If we want to use it for modules, how will we allocate RO data?
> > with similar rodata_alloc() that uses yet another tree in vmalloc?
> > How the caching of large pages in vmalloc can be made useful for use cases
> > like secretmem and PKS?
> 
> If RO data causes problems with direct map fragmentation, we can use
> similar logic. I think we will need another tree in vmalloc for this case.
> Since the logic will be mostly identical, I personally don't think adding
> another tree is a big overhead.

Actually, it would be interesting to quantify memory savings/waste as the
result of using execmem_alloc()
 
> Thanks,
> Song

-- 
Sincerely yours,
Mike.
