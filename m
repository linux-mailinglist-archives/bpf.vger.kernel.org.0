Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D664FC8FD
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 01:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiDKXzN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Apr 2022 19:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiDKXzM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Apr 2022 19:55:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BACC27167;
        Mon, 11 Apr 2022 16:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1E3AB819B3;
        Mon, 11 Apr 2022 23:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94439C385B0;
        Mon, 11 Apr 2022 23:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649721174;
        bh=MA2honiXWGeOzO9WdwjpEsoZG2CtJDXDu3X4YUBIiQc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jdxbEG/cJ9bBPd0gnfltrog660KLU3COJSzzRSbWXk0ogQLHldVpvIsV35eeIAPq8
         ulRhfQGXvvJPezfASRtce2+HmrpPTMIHbiSVMKVOt+QGSZ/AGS/Icda7n7BLqU3Nj8
         dg9q7uGUmHZSoIlI9WttHJ+1tZjxSWtEX0nz+w0O2+XUWmLjpNqYD2aq56s0R9hX/7
         Zqfwk9d8RFuZeLkafNhpc46EGa6nfi3rqTnc2vihzYdHGNxoqI7VO/b18TzLOsOqb9
         8vZl9lfuDwzzS0yvHFYbJMI/xXlgZccHednOvnvhb6IwHus09/2iMAdod66G1iBTFq
         QmthySP0p+TZg==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2ec42eae76bso34234617b3.10;
        Mon, 11 Apr 2022 16:52:54 -0700 (PDT)
X-Gm-Message-State: AOAM531pb5/lSEtlYb3HABuX+kYca0qHLlSa9dPRVRqySZKd4WJuwgQh
        kdlyLGp6w114o5X1w28U/SI6X5v25o8TmJTYuGs=
X-Google-Smtp-Source: ABdhPJy/zaZyKbdypj1Ir6pRoTfrzhUUja8HYbw1+PrL4w3DfKO/U2kKNazR+UqBBUv9umC/SnpgklvN3WCGaxXljB0=
X-Received: by 2002:a81:14c8:0:b0:2eb:eb91:d88f with SMTP id
 191-20020a8114c8000000b002ebeb91d88fmr14373906ywu.148.1649721173532; Mon, 11
 Apr 2022 16:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220411233549.740157-1-song@kernel.org> <20220411233549.740157-4-song@kernel.org>
In-Reply-To: <20220411233549.740157-4-song@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 11 Apr 2022 16:52:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6Z1AM=AXtxP5Hk+Xa4yF8r2f0ckOTHDML5A1iRQS8t_w@mail.gmail.com>
Message-ID: <CAPhsuW6Z1AM=AXtxP5Hk+Xa4yF8r2f0ckOTHDML5A1iRQS8t_w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 3/3] bpf: use module_alloc_huge for bpf_prog_pack
To:     bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        rick.p.edgecombe@intel.com, Christoph Hellwig <hch@infradead.org>,
        imbrenda@linux.ibm.com, Luis Chamberlain <mcgrof@kernel.org>
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

On Mon, Apr 11, 2022 at 4:41 PM Song Liu <song@kernel.org> wrote:
>
> module_alloc_huge for bpf_prog_pack so that BPF programs sit on PMD_SIZE
> pages. This benefits system performance by reducing iTLB miss rate.
>
> Signed-off-by: Song Liu <song@kernel.org>

I am really sorry for spamming the list twice. The first set
experienced long lag,
so I thought it didn't get through.

I also updated the commit log of 3/3, and this one is the latest version.

Thanks,
Song

> ---
>  kernel/bpf/core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 13e9dbeeedf3..fd45bdd80a75 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -857,7 +857,7 @@ static size_t select_bpf_prog_pack_size(void)
>         void *ptr;
>
>         size = BPF_HPAGE_SIZE * num_online_nodes();
> -       ptr = module_alloc(size);
> +       ptr = module_alloc_huge(size);
>
>         /* Test whether we can get huge pages. If not just use PAGE_SIZE
>          * packs.
> @@ -881,7 +881,7 @@ static struct bpf_prog_pack *alloc_new_pack(void)
>                        GFP_KERNEL);
>         if (!pack)
>                 return NULL;
> -       pack->ptr = module_alloc(bpf_prog_pack_size);
> +       pack->ptr = module_alloc_huge(bpf_prog_pack_size);
>         if (!pack->ptr) {
>                 kfree(pack);
>                 return NULL;
> @@ -889,7 +889,6 @@ static struct bpf_prog_pack *alloc_new_pack(void)
>         bitmap_zero(pack->bitmap, bpf_prog_pack_size / BPF_PROG_CHUNK_SIZE);
>         list_add_tail(&pack->list, &pack_list);
>
> -       set_vm_flush_reset_perms(pack->ptr);
>         set_memory_ro((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
>         set_memory_x((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
>         return pack;
> @@ -970,7 +969,9 @@ static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
>         if (bitmap_find_next_zero_area(pack->bitmap, bpf_prog_chunk_count(), 0,
>                                        bpf_prog_chunk_count(), 0) == 0) {
>                 list_del(&pack->list);
> -               module_memfree(pack->ptr);
> +               set_memory_nx((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
> +               set_memory_rw((unsigned long)pack->ptr, bpf_prog_pack_size / PAGE_SIZE);
> +               vfree(pack->ptr);
>                 kfree(pack);
>         }
>  out:
> --
> 2.30.2
>
>
