Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF28503301
	for <lists+bpf@lfdr.de>; Sat, 16 Apr 2022 07:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiDPCIP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 22:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiDPCGY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 22:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE22966632;
        Fri, 15 Apr 2022 18:57:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54CFB622DA;
        Sat, 16 Apr 2022 01:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D10C385AB;
        Sat, 16 Apr 2022 01:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650072870;
        bh=G2r0hwQVplCHQ7ULSTnFo0Naiy/A7faEgp5IvkPlONE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pq3SzjbhQTusy5kohaS/V6DGX7cLkZ2tDW7LFljSG6yIehpOqQcJxHBB5R/2ZCRgt
         /biILVADCenQL3RyHWBcsunQiVh1BKsFzdBhqI7ZOV7NZC/OwU2UM84qtKUFnQHEl2
         2SA01AeyL4/21GXs0IcIwHCkl5O6ISh/eiFDRMwcgJ4hhP97KHwK+s/MeU9/UV0bLy
         WasqSynTsTSfGVKx9sj6BBpAxpBZTwHTD9R678qDMMq4wuP/vAPAKWIXs8SdbWbZVX
         Jug5v/gcYurNurwI21M/9qWJAItbWhk2vYzSN6OSfrty2S8HCmFt3FR6ogSR8A/g5J
         0ij0JO47VE1qQ==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ef4a241cc5so89939167b3.2;
        Fri, 15 Apr 2022 18:34:30 -0700 (PDT)
X-Gm-Message-State: AOAM531BNK5y8s9TXUZ35SyncpjtxX60sbaFQLjBm0yo6v94/ObDFz5m
        3D3v2ffw+HRHwO5nczIoscBgJNjHFJqw9M4NZXM=
X-Google-Smtp-Source: ABdhPJy5ZiuwR/MEz1NUAABLIKN4yUPCqmIOYhws4Ld2Q8fuVdw0YNd1v43E0sRlgvspqLO2yY6OXD6IevZ1wTBQv7Y=
X-Received: by 2002:a81:5087:0:b0:2ef:33c1:fccd with SMTP id
 e129-20020a815087000000b002ef33c1fccdmr1455985ywb.73.1650072869799; Fri, 15
 Apr 2022 18:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
In-Reply-To: <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 15 Apr 2022 18:34:16 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6LY8g6SZpW0CBOe22FUd2e3oSq4RW1GDxZoPmHYBqwvw@mail.gmail.com>
Message-ID: <CAPhsuW6LY8g6SZpW0CBOe22FUd2e3oSq4RW1GDxZoPmHYBqwvw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>, imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 15, 2022 at 12:05 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Apr 15, 2022 at 09:44:09AM -0700, Song Liu wrote:
> > Changes v3 => v4:
> > 1. Fix __weak module_alloc_huge; remove unused vmalloc_huge; rename
> >    __vmalloc_huge => vmalloc_huge. (Christoph Hellwig)
> > 2. Use vzalloc (as it was before vmalloc_no_huge) and clean up comments in
> >    kvm_s390_pv_alloc_vm.
> >
> > Changes v2 => v3:
> > 1. Use __vmalloc_huge in alloc_large_system_hash.
> > 2. Use EXPORT_SYMBOL_GPL for new functions. (Christoph Hellwig)
> > 3. Add more description about the issues and changes.(Christoph Hellwig,
> >    Rick Edgecombe).
> >
> > Changes v1 => v2:
> > 1. Add vmalloc_huge(). (Christoph Hellwig)
> > 2. Add module_alloc_huge(). (Christoph Hellwig)
> > 3. Add Fixes tag and Link tag. (Thorsten Leemhuis)
> >
> > Enabling HAVE_ARCH_HUGE_VMALLOC on x86_64 and use it for bpf_prog_pack has
> > caused some issues [1], as many users of vmalloc are not yet ready to
> > handle huge pages. To enable a more smooth transition to use huge page
> > backed vmalloc memory, this set replaces VM_NO_HUGE_VMAP flag with an new
> > opt-in flag, VM_ALLOW_HUGE_VMAP. More discussions about this topic can be
> > found at [2].
> >
> > Patch 1 removes VM_NO_HUGE_VMAP and adds VM_ALLOW_HUGE_VMAP.
> > Patch 2 uses VM_ALLOW_HUGE_VMAP in bpf_prog_pack.
> >
> > [1] https://lore.kernel.org/lkml/20220204185742.271030-1-song@kernel.org/
> > [2] https://lore.kernel.org/linux-mm/20220330225642.1163897-1-song@kernel.org/
>
> Looks good except for that I think this should just wait for v5.19. The
> fixes are so large I can't see why this needs to be rushed in other than
> the first assumptions of the optimizations had some flaws addressed here.

We need these changes to fix issues like [3]. Note that there might
still be some
undiscovered issues with huge page backed vmalloc memory on powerpc, which
had HAVE_ARCH_HUGE_VMALLOC enabled since the 5.15 kernel. As we
agreed, the new opt-in flag is a safer approach here. We probably should have
1/4 and 2/4 back ported to stable. Therefore, I think shipping this
set now would
give us a more reliable 5.18 release.

Does this make sense?

Thanks,
Song

[3] https://lore.kernel.org/lkml/14444103-d51b-0fb3-ee63-c3f182f0b546@molgen.mpg.de/
