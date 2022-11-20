Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4009E631368
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 11:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiKTKo2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 05:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKTKo1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 05:44:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0877F12D1D
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 02:44:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED35FB80AB4
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 10:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673E6C433D6;
        Sun, 20 Nov 2022 10:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668941063;
        bh=hwn608o35Wlp83SI1gYbYqT6jafaZV4j1oqaO/ZVvuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JcRsujEEGs4xt8Ptq0Fh22mgLN4+98ZHNvy9RokonM4MuLvLbp8iXEDnQbZzEVuWX
         zKoWspQZxseAcXTQy5i1FdOfr1d8S5BkMbW/6UqDgrb7Q3++2BwTMQLiv9n5PmjKHS
         x+d0iITw8HkY11ekwF4eJHYVJ/kB98cc9cZberJypS86y1YmEGHwvD4S8YhaV+lhid
         mErR+FhX/stOfsOiu5bvgu/ev56h/2CXFZKhBA/jUkxv0be234EdOesKE39EXz2/eV
         Oq3enNnr3K6ZZGC+G3QkvQNzNm9ZKqKstu3/yKfeXmYpfyLdlFxi8fqp2c5+ha+mLD
         HENg+kJasYufw==
Date:   Sun, 20 Nov 2022 12:44:09 +0200
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
Message-ID: <Y3oE+fPskAW7kO7M@kernel.org>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 14, 2022 at 12:45:16PM -0800, Song Liu wrote:
> On Sun, Nov 13, 2022 at 2:43 AM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > If RO data causes problems with direct map fragmentation, we can use
> > > similar logic. I think we will need another tree in vmalloc for this case.
> > > Since the logic will be mostly identical, I personally don't think adding
> > > another tree is a big overhead.
> >
> > Actually, it would be interesting to quantify memory savings/waste as the
> > result of using execmem_alloc()
> 
> From a random system in our fleet, execmem_alloc() saves:
> 
> 139 iTLB entries (1x 2MB entry vs, 140x 4kB entries), which is more than
> 100% of L1 iTLB and about 10% of L2 TLB.

Using 2M pages saves page table entries. They might be cached in iTLB and
might be not because on a loaded system large part of iTBL will cache
userspace mappings.
 
> It wastes 1.5MB memory, which is 0.0023% of system memory (64GB).
> 
> I believe this is clearly a good trade-off.

The actual trade-off would be for 1.5MB of memory for yet unknown, or at
least unpublished, performance improvement on a loaded system.
 
> Thanks,
> Song

-- 
Sincerely yours,
Mike.
