Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFBC62D397
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 07:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiKQGtM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 01:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiKQGtM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 01:49:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8726E5D688
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 22:49:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2187D620AE
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 06:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8064BC43145
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 06:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668667750;
        bh=08u/sTGELHIpjr9mtQ8XZ3j+lFZpqrOGj8F/MH2k9t8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VH6+KsLrRg74wODo7HspmCSAhgOJKUrOFzk3zQ/sEOTWOCTqBdH/650PNa/iPH5FV
         nP/asPvDuFVLMHoTRpFDj/c8hWCtsoEZCIi63PLkdGxOmXJ98fJRjsRE6VUdnLLl76
         miCX0+5MX+R1u/ILGtvY9JaNuFuV7YCTrD4rZmCcADlhriZDiGbfOcDt5PNiiPXU+M
         qIWtnTieYxdWZ60OBilKRfC5bWleW/XcpnnK3SR911pfV+3xi53LbG8idZuS4jT+zu
         MiLO5wU5aQbs2ONnBaSAT9gOy+T27X0TzNjjWlGoeIR5mtjbbrep1S2VosAuD1KHNR
         t/G/K7fBwVHLA==
Received: by mail-ed1-f49.google.com with SMTP id x2so1206200edd.2
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 22:49:10 -0800 (PST)
X-Gm-Message-State: ANoB5pm84rAWEcQnvbe4RQy42stGiozIolfEyjusyFsmEddG77Lwzaht
        SpYUyc3DtLbr+Msw1cZrM70DoanL5F55aHfxrxM=
X-Google-Smtp-Source: AA0mqf4MXzYIzmYW4qHTtMPMheKCJmsww+V+IW07ffCicoXtzzcn9lfzoNLP+AQWXATW1mFbdWw1sJuXcGqwYFR4U50=
X-Received: by 2002:a50:fa83:0:b0:461:565e:8779 with SMTP id
 w3-20020a50fa83000000b00461565e8779mr956341edr.387.1668667748735; Wed, 16 Nov
 2022 22:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20221117010621.1891711-1-song@kernel.org> <20221117010621.1891711-2-song@kernel.org>
 <Y3WQEPB6FaHRXidp@bombadil.infradead.org>
In-Reply-To: <Y3WQEPB6FaHRXidp@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 16 Nov 2022 22:48:56 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4TcQ1bAtZcYME_c4hCr8u3E7ObpxWbdsiGCVdYnfdNgQ@mail.gmail.com>
Message-ID: <CAPhsuW4TcQ1bAtZcYME_c4hCr8u3E7ObpxWbdsiGCVdYnfdNgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] vmalloc: introduce execmem_alloc,
 execmem_free, and execmem_fill
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 5:36 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 16, 2022 at 05:06:16PM -0800, Song Liu wrote:
> > +static void move_vmap_to_free_text_tree(void *addr)
> > +{
> > +     struct vmap_area *va;
> > +
> > +     /* remove from vmap_area_root */
> > +     spin_lock(&vmap_area_lock);
> > +     va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
> > +     if (WARN_ON_ONCE(!va)) {
> > +             spin_unlock(&vmap_area_lock);
> > +             return;
> > +     }
> > +     unlink_va(va, &vmap_area_root);
> > +     spin_unlock(&vmap_area_lock);
> > +
> > +     /* make the memory RO+X */
> > +     memset(addr, 0, va->va_end - va->va_start);
> > +     set_memory_ro(va->va_start, (va->va_end - va->va_start) >> PAGE_SHIFT);
> > +     set_memory_x(va->va_start, (va->va_end - va->va_start) >> PAGE_SHIFT);
> > +
> > +     /* add to all_text_vm */
> > +     va->vm->next = all_text_vm;
> > +     all_text_vm = va->vm;
> > +
> > +     /* add to free_text_area_root */
> > +     spin_lock(&free_text_area_lock);
> > +     merge_or_add_vmap_area_augment(va, &free_text_area_root, &free_text_area_list);
> > +     spin_unlock(&free_text_area_lock);
> > +}
>
> <-- snip -->
>
> > +void *execmem_alloc(unsigned long size, unsigned long align)
> > +{
> > +     struct vmap_area *va, *tmp;
> > +     unsigned long addr;
> > +     enum fit_type type;
> > +     int ret;
> > +
> > +     va = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, NUMA_NO_NODE);
> > +     if (unlikely(!va))
> > +             return NULL;
> > +
> > +again:
> > +     preload_this_cpu_lock(&free_text_area_lock, GFP_KERNEL, NUMA_NO_NODE);
> > +     tmp = find_vmap_lowest_match(&free_text_area_root, size, align, 1, false);
> > +
> > +     if (!tmp) {
> > +             unsigned long alloc_size;
> > +             void *ptr;
> > +
> > +             spin_unlock(&free_text_area_lock);
> > +
> > +             /*
> > +              * Not enough continuous space in free_text_area_root, try
> > +              * allocate more memory. The memory is first added to
> > +              * vmap_area_root, and then moved to free_text_area_root.
> > +              */
> > +             alloc_size = roundup(size, PMD_SIZE * num_online_nodes());
> > +             ptr = __vmalloc_node_range(alloc_size, PMD_SIZE, EXEC_MEM_START,
> > +                                        EXEC_MEM_END, GFP_KERNEL, PAGE_KERNEL,
> > +                                        VM_ALLOW_HUGE_VMAP | VM_NO_GUARD,
> > +                                        NUMA_NO_NODE, __builtin_return_address(0));
> > +             if (unlikely(!ptr))
> > +                     goto err_out;
> > +
> > +             move_vmap_to_free_text_tree(ptr);
>
> It's not perfectly clear to me how we know for sure nothing can take
> this underneath our noses.

This is because ptr points to vmap_area in vmap_area_* tree. It is only
used by the user (this thread). It is like we know vmalloc memory will
not go away until we call vfree on it.

Does this make sense?

Song
