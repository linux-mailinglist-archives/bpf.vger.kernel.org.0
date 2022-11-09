Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58018622A25
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 12:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiKILSO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 06:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiKILSD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 06:18:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EB26344
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 03:18:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07526619FE
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 11:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA778C433D6;
        Wed,  9 Nov 2022 11:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667992681;
        bh=X0mUcunS2+WQwAFy3NAIChidBa7zo166VTsPNnz+xsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJb2r5iVIrV8Dgi2i4J11MfRwRuKuSGv/9FFWtd3xjkV0hGKzNVn2gGWyLyn/C+Gn
         X1LsrY4R7mBG65r9bpmpoJifneTDolrcJ+GqgFvjFdsrNUHNdBbX9kLon4zrp7FQlV
         4zG5idn3X0w2/A/RWRhFODKXQSRa24pTDQrUcpDv4aBqxTsGaFCufDBL+Ppp3Fo9ED
         6om0GJhQYY20+PiWiC+77xbbzzOUp6XHKiI24+fYqOZiqCSTayZ+XI5GDp+uyj4NM9
         aX2LZkld1hQ2Lz3/ZEeuPJs6E5CrbES121DJg0ujixNgcnX2KqLpRgzcRUaw4hzC/0
         hIU3iHEhnWgYg==
Date:   Wed, 9 Nov 2022 13:17:46 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "song@kernel.org" <song@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y2uMWvmiPlaNXlZz@kernel.org>
References: <20221107223921.3451913-1-song@kernel.org>
 <Y2o9Iz30A3Nruqs4@kernel.org>
 <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 08, 2022 at 04:51:12PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2022-11-08 at 13:27 +0200, Mike Rapoport wrote:
> > > Based on our experiments [5], we measured 0.5% performance
> > > improvement
> > > from bpf_prog_pack. This patchset further boosts the improvement to
> > > 0.7%.
> > > The difference is because bpf_prog_pack uses 512x 4kB pages instead
> > > of
> > > 1x 2MB page, bpf_prog_pack as-is doesn't resolve #2 above.
> > > 
> > > This patchset replaces bpf_prog_pack with a better API and makes it
> > > available for other dynamic kernel text, such as modules, ftrace,
> > > kprobe.
> > 
> >  
> > The proposed execmem_alloc() looks to me very much tailored for x86
> > to be
> > used as a replacement for module_alloc(). Some architectures have
> > module_alloc() that is quite different from the default or x86
> > version, so
> > I'd expect at least some explanation how modules etc can use execmem_
> > APIs
> > without breaking !x86 architectures.
> 
> I think this is fair, but I think we should ask ask ourselves - how
> much should we do in one step?

I think that at least we need an evidence that execmem_alloc() etc can be
actually used by modules/ftrace/kprobes. Luis said that RFC v2 didn't work
for him at all, so having a core MM API for code allocation that only works
with BPF on x86 seems not right to me.
 
> For non-text_poke() architectures, the way you can make it work is have
> the API look like:
> execmem_alloc()  <- Does the allocation, but necessarily usable yet
> execmem_write()  <- Loads the mapping, doesn't work after finish()
> execmem_finish() <- Makes the mapping live (loaded, executable, ready)
> 
> So for text_poke():
> execmem_alloc()  <- reserves the mapping
> execmem_write()  <- text_pokes() to the mapping
> execmem_finish() <- does nothing
> 
> And non-text_poke():
> execmem_alloc()  <- Allocates a regular RW vmalloc allocation
> execmem_write()  <- Writes normally to it
> execmem_finish() <- does set_memory_ro()/set_memory_x() on it
> 
> Non-text_poke() only gets the benefits of centralized logic, but the
> interface works for both. This is pretty much what the perm_alloc() RFC
> did to make it work with other arch's and modules. But to fit with the
> existing modules code (which is actually spread all over) and also
> handle RO sections, it also needed some additional bells and whistles.

I'm less concerned about non-text_poke() part, but rather about
restrictions where code and data can live on different architectures and
whether these restrictions won't lead to inability to use the centralized
logic on, say, arm64 and powerpc.

For instance, if we use execmem_alloc() for modules, it means that data
sections should be allocated separately with plain vmalloc(). Will this
work universally? Or this will require special care with additional
complexity in the modules code?
 
> So the question I'm trying to ask is, how much should we target for the
> next step? I first thought that this functionality was so intertwined,
> it would be too hard to do iteratively. So if we want to try
> iteratively, I'm ok if it doesn't solve everything.
 
With execmem_alloc() as the first step I'm failing to see the large
picture. If we want to use it for modules, how will we allocate RO data?
with similar rodata_alloc() that uses yet another tree in vmalloc? 
How the caching of large pages in vmalloc can be made useful for use cases
like secretmem and PKS?

-- 
Sincerely yours,
Mike.
