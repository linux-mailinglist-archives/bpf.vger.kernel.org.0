Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0670663B0C8
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 19:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiK1SKh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 13:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiK1SKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 13:10:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347A85CD04
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 09:53:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7C6CB80EB2
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 17:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FD7C43141
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 17:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669658009;
        bh=t61NGrll20ZfEk0aomCv7BuVFq9bHe1t8/O5CRMxQiI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fVT+YB2sC/OjEV+WsvQbwefI08u+6ZTbz5Hqx3lGpm4OJ4BK6M3wVDd/o3NlUpL7h
         3H6Qjmyh0tcZcu/Tj9/x+0k2Tqn4O7j54F0tIwueY4nk2KoxB2lgJ8NGUlZ1tNtyAX
         WWM2V25MhzkLP0i/5sFF3Ks4vt99jOMUh78nf5te9y9eprIcPY2TkknO7IUN6GSibd
         W1pWNsiTtcjl4YxGiR/jhK/JzTlmaYDHXOeFI5ts7c0SP1pYcEa0rgtHNlq3WqvlRG
         dhAdpaySHFzIrKFpcV3fdYGi59Dbk+D6qFIpz7NYdkNh7luu7rBG3WDxt1DNNhIYxg
         N8NYPGJMcj2qg==
Received: by mail-ej1-f51.google.com with SMTP id b2so11528253eja.7
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 09:53:29 -0800 (PST)
X-Gm-Message-State: ANoB5plaquOgNAAYHmAJkOloRC5VuknvoJXG+6M596/SXSmyUf3xzKZA
        57X/6znquCKK/YT+a26CXtzSfJIXJkT/BC/LWh4=
X-Google-Smtp-Source: AA0mqf7XtuTg3KLS3sY40XiL2GSv9CfedfXxEDdjQTdYRPritRfgODBfdeYxPMaep9dkdEdd+45XTEcIiUEU+17hjug=
X-Received: by 2002:a17:906:a198:b0:7b4:bc42:3b44 with SMTP id
 s24-20020a170906a19800b007b4bc423b44mr37044763ejy.101.1669658007650; Mon, 28
 Nov 2022 09:53:27 -0800 (PST)
MIME-Version: 1.0
References: <20221117202322.944661-1-song@kernel.org> <20221117202322.944661-2-song@kernel.org>
 <882e2964-932e-0113-d3cd-344281add3a1@iogearbox.net>
In-Reply-To: <882e2964-932e-0113-d3cd-344281add3a1@iogearbox.net>
From:   Song Liu <song@kernel.org>
Date:   Mon, 28 Nov 2022 09:53:15 -0800
X-Gmail-Original-Message-ID: <CAPhsuW71F6MzmU8hhd1NmZQ=-hAAxZh4ZEr5A6zPOpOgM925Nw@mail.gmail.com>
Message-ID: <CAPhsuW71F6MzmU8hhd1NmZQ=-hAAxZh4ZEr5A6zPOpOgM925Nw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/6] vmalloc: introduce execmem_alloc,
 execmem_free, and execmem_fill
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, rppt@kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 7:52 AM Daniel Borkmann <daniel@iogearbox.net> wrote:

[...]

> > + */
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
> > +             goto again;
> > +     }
> > +
> > +     addr = roundup(tmp->va_start, align);
> > +     type = classify_va_fit_type(tmp, addr, size);
> > +     if (WARN_ON_ONCE(type == NOTHING_FIT))
> > +             goto err_out_unlock;
>
> Isn't this already covered in adjust_va_to_fit_type()?

That's right! Now we can get rid of err_out_unlock. Thanks!

Also fixed other nits.

Song

[...]
