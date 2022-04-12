Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF754FCF39
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 08:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348550AbiDLGD1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 02:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243946AbiDLGD0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 02:03:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91A728E21;
        Mon, 11 Apr 2022 23:01:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88434B81B37;
        Tue, 12 Apr 2022 06:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B19C385A1;
        Tue, 12 Apr 2022 06:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649743265;
        bh=TQ9nlWWmfc9iRUY4qhKmJUR81ULKujQpg9YoNQ0C930=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dZQZ/Rgqrf1bN4S34dnalooW8COMViJgAPdTH0LR6dn8V1wcpL3izcflq3cQxVi9Z
         85aOx+SNp5xn5VMmPjl4H8qysD6qUz8qkW+oabmFvnV1o8K56+AfAFJ1K2RFXT051s
         anNs6HLmcoX2iMQoOhRg28klZFDGlkeWLGRBfi4+nhJv7/Dlodd4SXHCBYKZfMeV9c
         Zk6r+NTGzsyBkItV0HmDug+jB/sX35bIUrmU0Hy4lw0TEoMX37bna9+a35RrloAllo
         +eEvNCci6Xvg26akcjqxz0tlDLCM1T/wHZ1Regr+KJhgm/Nt4z2LfZGK4SVNR4zUCx
         WC7buhKOYAV9w==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2ec42eae76bso40055687b3.10;
        Mon, 11 Apr 2022 23:01:05 -0700 (PDT)
X-Gm-Message-State: AOAM5304jYz8KSzVuXkgp7PxnFWlfbMwFH4H3PyuCgzedr+31+p9YFM5
        o+YUWq3BfNu0knlY7ej/i6iD0jIT1E3OeFmdrBo=
X-Google-Smtp-Source: ABdhPJwzGCRuLMNTaqDIAYXmBETryWKD44RD4bPhNkE9g2fCam2blArU9EULFeLTjwkpkVuYiqf0ELUay2OlPfmLabI=
X-Received: by 2002:a0d:f6c6:0:b0:2e5:bf17:4dce with SMTP id
 g189-20020a0df6c6000000b002e5bf174dcemr29970697ywf.130.1649743264274; Mon, 11
 Apr 2022 23:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220411233549.740157-1-song@kernel.org> <20220411233549.740157-2-song@kernel.org>
 <YlT9i9DFvwDx9+AD@infradead.org>
In-Reply-To: <YlT9i9DFvwDx9+AD@infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 11 Apr 2022 23:00:53 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7XJHa3OaTT-4=33c70gUjCaWFrVe8h8J-hZetjxXeeog@mail.gmail.com>
Message-ID: <CAPhsuW7XJHa3OaTT-4=33c70gUjCaWFrVe8h8J-hZetjxXeeog@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 1/3] vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLOW_HUGE_VMAP
To:     Christoph Hellwig <hch@infradead.org>
Cc:     bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        rick.p.edgecombe@intel.com, imbrenda@linux.ibm.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
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

On Mon, Apr 11, 2022 at 9:18 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Apr 11, 2022 at 04:35:46PM -0700, Song Liu wrote:
> > Huge page backed vmalloc memory could benefit performance in many cases.
> > Since some users of vmalloc may not be ready to handle huge pages,
> > VM_NO_HUGE_VMAP was introduced to allow vmalloc users to opt-out huge
> > pages. However, it is not easy to add VM_NO_HUGE_VMAP to all the users
> > that may try to allocate >= PMD_SIZE pages, but are not ready to handle
> > huge pages properly.
>
> This is a good place to document what the problems are, and how they are
> hard to track down (e.g. because the allocations are passed down I/O
> stacks)

Will add it in v3.

>
> >
> > Replace VM_NO_HUGE_VMAP with an opt-in flag, VM_ALLOW_HUGE_VMAP, so that
> > users that benefit from huge pages could ask specificially.
> >
> > Also, replace vmalloc_no_huge() with opt-in helper vmalloc_huge().
>
> We still need to find out what the primary users of the large vmalloc
> hashes was and convert them.

@ Claudio and Nicholas,

Could you please help identify users of large vmalloc? So far, I found
alloc_large_system_hash(), and something like the following seems to
work:

diff --git i/mm/page_alloc.c w/mm/page_alloc.c
index 6e5b4488a0c5..20d38b8482c4 100644
--- i/mm/page_alloc.c
+++ w/mm/page_alloc.c
@@ -8919,7 +8919,7 @@ void *__init alloc_large_system_hash(const char
*tablename,
                                table = memblock_alloc_raw(size,
                                                           SMP_CACHE_BYTES);
                } else if (get_order(size) >= MAX_ORDER || hashdist) {
-                       table = __vmalloc(size, gfp_flags);
+                       table = __vmalloc_huge(size, gfp_flags);
                        virt = true;
                        if (table)
                                huge = is_vm_area_hugepages(table);
diff --git i/mm/vmalloc.c w/mm/vmalloc.c
index 7cc2be6a7554..cbadbe83e6a6 100644
--- i/mm/vmalloc.c
+++ w/mm/vmalloc.c
@@ -3253,6 +3253,14 @@ void *__vmalloc(unsigned long size, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(__vmalloc);

+void *__vmalloc_huge(unsigned long size, gfp_t gfp_mask)
+{
+       return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
+                                   gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
+                                   NUMA_NO_NODE, __builtin_return_address(0));
+}
+EXPORT_SYMBOL_GPL(__vmalloc_huge);
+
 /**
  * vmalloc - allocate virtually contiguous memory
  * @size:    allocation size


>
> > +extern void *vmalloc_huge(unsigned long size) __alloc_size(1);
>
> No need for the extern.
>
> > +EXPORT_SYMBOL(vmalloc_huge);
>
> EXPORT_SYMBOL_GPL for all advanced vmalloc functionality, please.

Will fix these in v3.

Thanks,
Song
