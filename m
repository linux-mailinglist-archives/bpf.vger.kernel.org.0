Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63116231AF
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 18:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiKIRoI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 12:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKIRoH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 12:44:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892A2BA8
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 09:44:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A110B81F4D
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 17:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD467C43470
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 17:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668015843;
        bh=YMzmrAedbSqr4FpBqUaZNR2kutN3dEnWCq4xXQKIWcs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DXkVLG5lCcOzwsT8TR2XOTE1F/w3qKTogZJyA4q0jy4ND3HfeI8WAnHx0EId/kKjA
         5CaaQYPbYPSAKN2m8N3dkqG0yq5kRmpQRErD/Da3KC3M6ZaarDXUYILYkglj1jaTwn
         AzGfnG5hQHOdr8YrRVjOF97y8RnSP3VsLik1u4cs4/CoXRsZxH8Ji3UNXQY5Ls7gO8
         IXJ4Ni7ESgnSsrYeODJZ9dPVr+S+DWhSnYpodTFIQteRojBpenZkjKZjHGCwpXfRHv
         ZRYieUUJEm10uAVaG5itsRkPUZSP0PruMu7CPN/Rx8wuhE/tvmRy++7mZI/R6/bo1n
         868tspyOyVhKg==
Received: by mail-ed1-f52.google.com with SMTP id 21so28282938edv.3
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 09:44:03 -0800 (PST)
X-Gm-Message-State: ACrzQf11H4RJN3ApdqudVWqwSAvQZBcLsWDefkq5Q7QBdV6rAHBZscG9
        eVv25budT3tqiDrCrWq8HzMzndjIkqKDQW+SdHI=
X-Google-Smtp-Source: AMsMyM78ijxOhQbiLUny5ISRpGvb9wiT05BlGR2qEdvUFRz6YZ7Abe6OxRYAycARUL8aLeX1NPW3NOy7cYa3cpjGOzg=
X-Received: by 2002:aa7:d710:0:b0:463:bd7b:2b44 with SMTP id
 t16-20020aa7d710000000b00463bd7b2b44mr44868053edq.385.1668015842120; Wed, 09
 Nov 2022 09:44:02 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <Y2o9Iz30A3Nruqs4@kernel.org>
 <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com> <Y2uMWvmiPlaNXlZz@kernel.org>
In-Reply-To: <Y2uMWvmiPlaNXlZz@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 9 Nov 2022 09:43:50 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5e8rBnu73DYkyc1L6gC-WBxjTZVwdFC_L12GVyzROR1w@mail.gmail.com>
Message-ID: <CAPhsuW5e8rBnu73DYkyc1L6gC-WBxjTZVwdFC_L12GVyzROR1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 9, 2022 at 3:18 AM Mike Rapoport <rppt@kernel.org> wrote:
>
[...]

> > >
> > > The proposed execmem_alloc() looks to me very much tailored for x86
> > > to be
> > > used as a replacement for module_alloc(). Some architectures have
> > > module_alloc() that is quite different from the default or x86
> > > version, so
> > > I'd expect at least some explanation how modules etc can use execmem_
> > > APIs
> > > without breaking !x86 architectures.
> >
> > I think this is fair, but I think we should ask ask ourselves - how
> > much should we do in one step?
>
> I think that at least we need an evidence that execmem_alloc() etc can be
> actually used by modules/ftrace/kprobes. Luis said that RFC v2 didn't work
> for him at all, so having a core MM API for code allocation that only works
> with BPF on x86 seems not right to me.

While using execmem_alloc() et. al. in module support is difficult, folks are
making progress with it. For example, the prototype would be more difficult
before CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
(introduced by Christophe).

We also have other users that we can onboard soon: BPF trampoline on
x86_64, BPF jit and trampoline on arm64, and maybe also on powerpc and
s390.

>
> > For non-text_poke() architectures, the way you can make it work is have
> > the API look like:
> > execmem_alloc()  <- Does the allocation, but necessarily usable yet
> > execmem_write()  <- Loads the mapping, doesn't work after finish()
> > execmem_finish() <- Makes the mapping live (loaded, executable, ready)
> >
> > So for text_poke():
> > execmem_alloc()  <- reserves the mapping
> > execmem_write()  <- text_pokes() to the mapping
> > execmem_finish() <- does nothing
> >
> > And non-text_poke():
> > execmem_alloc()  <- Allocates a regular RW vmalloc allocation
> > execmem_write()  <- Writes normally to it
> > execmem_finish() <- does set_memory_ro()/set_memory_x() on it
> >
> > Non-text_poke() only gets the benefits of centralized logic, but the
> > interface works for both. This is pretty much what the perm_alloc() RFC
> > did to make it work with other arch's and modules. But to fit with the
> > existing modules code (which is actually spread all over) and also
> > handle RO sections, it also needed some additional bells and whistles.
>
> I'm less concerned about non-text_poke() part, but rather about
> restrictions where code and data can live on different architectures and
> whether these restrictions won't lead to inability to use the centralized
> logic on, say, arm64 and powerpc.
>
> For instance, if we use execmem_alloc() for modules, it means that data
> sections should be allocated separately with plain vmalloc(). Will this
> work universally? Or this will require special care with additional
> complexity in the modules code?
>
> > So the question I'm trying to ask is, how much should we target for the
> > next step? I first thought that this functionality was so intertwined,
> > it would be too hard to do iteratively. So if we want to try
> > iteratively, I'm ok if it doesn't solve everything.
>
> With execmem_alloc() as the first step I'm failing to see the large
> picture. If we want to use it for modules, how will we allocate RO data?
> with similar rodata_alloc() that uses yet another tree in vmalloc?
> How the caching of large pages in vmalloc can be made useful for use cases
> like secretmem and PKS?

If RO data causes problems with direct map fragmentation, we can use
similar logic. I think we will need another tree in vmalloc for this case.
Since the logic will be mostly identical, I personally don't think adding
another tree is a big overhead.

Thanks,
Song
