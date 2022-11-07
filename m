Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7261C61FDA6
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 19:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiKGSfd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 13:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiKGSfc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 13:35:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED8120F5D
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 10:35:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E05F86121A
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 18:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EB7C43144
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 18:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667846129;
        bh=fENHnhkhqiC80pvSoAM8W6kCQuZClzcUZr2IPdz27dk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EsFHbIeiixDS8zVIarcY8ICr1jNd9Ksm/304Tp8gtClKvC8uw/vslp2W+dEvBvpTU
         W2//bi8Anr53suBdnD6cYpLIljztqMLPXVrxXfa5MwEn0ZdiAZnwK3zTnWhbq6HRUu
         r4uhkg668tKk6vIuuQYEUCrpU4I30oTRxdPyqeZYWzoh6Jtu5YP51548GndGediyhJ
         cFQ+FdgPd1SHNV/6NLgiGnQSMzxsyycVAZDTLDhoMpA5oo++z07tNGulSrsUfga5oK
         qJfTnT54xNx3s7uf5awDYMqW44ChdUExub9HIiVoomHNfWqWt5MaURuwVGi3urKcV4
         QLg9JLgzsm9dg==
Received: by mail-ej1-f44.google.com with SMTP id ud5so32573259ejc.4
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 10:35:29 -0800 (PST)
X-Gm-Message-State: ACrzQf1cRYhdKONwnIL1aGNHalpVpEXvIhA9urcwYQQSoVybyZbz0c1+
        hvNp4EZSTJlpmSQp22pknt+LNXz5k6Kbx3wDLlo=
X-Google-Smtp-Source: AMsMyM44YTREuh/FSMIUcNOOl8bwLtjn2YpJLhrQ1cQjx8k5h60aCb5U74U1hxTGHGX57uh/mBkLWuQ6+301UkyYs9I=
X-Received: by 2002:a17:907:b602:b0:7ad:e82c:3355 with SMTP id
 vl2-20020a170907b60200b007ade82c3355mr36112192ejc.3.1667846127423; Mon, 07
 Nov 2022 10:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20221031222541.1773452-1-song@kernel.org> <20221031222541.1773452-2-song@kernel.org>
 <Y2MAR0aj+jcq+15H@bombadil.infradead.org> <Y2ioTodn+mBXdIqp@ziqianlu-desk2> <Y2lCt7kWG+tsePDL@bombadil.infradead.org>
In-Reply-To: <Y2lCt7kWG+tsePDL@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 7 Nov 2022 10:35:15 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5jUu0Nkgk=8Vif8AKb05WtidbxKeqHAbA0LMYW4YRfsw@mail.gmail.com>
Message-ID: <CAPhsuW5jUu0Nkgk=8Vif8AKb05WtidbxKeqHAbA0LMYW4YRfsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 RESEND 1/5] vmalloc: introduce vmalloc_exec,
 vfree_exec, and vcopy_exec
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Aaron Lu <aaron.lu@intel.com>, bpf@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        peterz@infradead.org, hch@lst.de, rick.p.edgecombe@intel.com,
        dave.hansen@intel.com, rppt@kernel.org,
        zhengjun.xing@linux.intel.com, kbusch@kernel.org,
        p.raghav@samsung.com, dave@stgolabs.net, vbabka@suse.cz,
        mgorman@suse.de, willy@infradead.org,
        torvalds@linux-foundation.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 7, 2022 at 9:39 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
>
> > Some imperfect things I can think of are(not related to this patchset):
> > 1 Once a split happened, it remains happened. This may not be a big deal
> > now with bpf_prog_pack and this patchset because the need to allocate a
> > new order-9 page and thus cause a potential split should happen much much
> > less;
>
> Not sure I follow, are you suggesting a order-9 (512 bytes) allocation would
> trigger a split of the reserved say 2 MiB huge page?

I think by order-9 allocation, Aaron meant 2MiB huge pages. The issue is that
direct map split is one-way operation. If we set_memory_x() on one 4kB page
out of a 1GB direct map, we will split it into 511x 2MiB pages and 512x 4kB
pages. There is currently no way to regroup the 1GB page after
set_memory_nx() on the page.

Thanks,
Song

>
> > 2 When a new order-9 page has to be allocated, there is no way to tell
> > the allocator to allocate this order-9 page from an already splitted PUD
> > range to avoid another PUD mapping split;
> > 3 As Mike and others have mentioned, there are other users that can also
> > cause direct map split.
>
> Hence the effort to generalize.
>
>   Luis
