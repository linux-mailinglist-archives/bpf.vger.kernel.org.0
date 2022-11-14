Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CB6628AB2
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 21:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbiKNUph (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 15:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbiKNUpe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 15:45:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F96BC03
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 12:45:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C611DB8128D
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 20:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C3EC433C1
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 20:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668458730;
        bh=/eoltmfxhsBQW5kbqj1zICYdalEqwl1ONE/tve5V7AE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IQCgWBHlftUOEBFnnrG/zBegCsdaFFUHrFU4LcjgMbRNhQhwia+oSFePr3A8Jmlv5
         XIlOjrKtLHvNOVxHLQ0s9iYU8OdV/2z+Nj1qbj4kSU75jdQGF9AHe56N/7nk7ijwQt
         LStNFzhA6zuR208290meBL49XG2JI10ALR0nW3OBwrDcDNR50zwkCQVrLs6xmJLbhf
         YswuXiWK25+spdG0cTd+3vlcMn23oTWbpTmyKYb9q8s9p8mh8Tl8N7CZYF1Q49h0iJ
         LPS+jYwixSpYop/fYjky6Vvt6LnVZWSzV2xnONPWW3oUYxMIqcEZjV1oEXZ7v16B+Y
         dyA8QFXKg4LZw==
Received: by mail-ej1-f47.google.com with SMTP id 13so31374616ejn.3
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 12:45:30 -0800 (PST)
X-Gm-Message-State: ANoB5pknv+f/1l7tjq+UrEt67AmvOes0fLeS2gVgsqwlRLf+07Qk9s3c
        hC1/9YvTI4XdLRt8hvGKhFr3VL+b2NWFqdSBkwY=
X-Google-Smtp-Source: AA0mqf427AJW1JzObQrvS6YeAaU43qdBOSBTg00ztEgA6leExZNvsOuD0m2LF5ODPqjC58L5pQzObhvC14C39kr6VSc=
X-Received: by 2002:a17:906:ad98:b0:7a1:e4c2:fb0a with SMTP id
 la24-20020a170906ad9800b007a1e4c2fb0amr11916627ejb.101.1668458728697; Mon, 14
 Nov 2022 12:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <Y2o9Iz30A3Nruqs4@kernel.org>
 <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
 <Y2uMWvmiPlaNXlZz@kernel.org> <CAPhsuW5e8rBnu73DYkyc1L6gC-WBxjTZVwdFC_L12GVyzROR1w@mail.gmail.com>
 <Y3DKKivOwk+5rhNb@kernel.org>
In-Reply-To: <Y3DKKivOwk+5rhNb@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 14 Nov 2022 12:45:16 -0800
X-Gmail-Original-Message-ID: <CAPhsuW48AJiY2OuZb9ZeLS9Bq4aUN2iceD5iUt8=uCpSe95_xw@mail.gmail.com>
Message-ID: <CAPhsuW48AJiY2OuZb9ZeLS9Bq4aUN2iceD5iUt8=uCpSe95_xw@mail.gmail.com>
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

On Sun, Nov 13, 2022 at 2:43 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Wed, Nov 09, 2022 at 09:43:50AM -0800, Song Liu wrote:
> > On Wed, Nov 9, 2022 at 3:18 AM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > [...]
> >
> > > > >
> > > > > The proposed execmem_alloc() looks to me very much tailored for x86
> > > > > to be
> > > > > used as a replacement for module_alloc(). Some architectures have
> > > > > module_alloc() that is quite different from the default or x86
> > > > > version, so
> > > > > I'd expect at least some explanation how modules etc can use execmem_
> > > > > APIs
> > > > > without breaking !x86 architectures.
> > > >
> > > > I think this is fair, but I think we should ask ask ourselves - how
> > > > much should we do in one step?
> > >
> > > I think that at least we need an evidence that execmem_alloc() etc can be
> > > actually used by modules/ftrace/kprobes. Luis said that RFC v2 didn't work
> > > for him at all, so having a core MM API for code allocation that only works
> > > with BPF on x86 seems not right to me.
> >
> > While using execmem_alloc() et. al. in module support is difficult, folks are
> > making progress with it. For example, the prototype would be more difficult
> > before CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > (introduced by Christophe).
> >
> > We also have other users that we can onboard soon: BPF trampoline on
> > x86_64, BPF jit and trampoline on arm64, and maybe also on powerpc and
> > s390.
>
> Caching of large pages won't make any difference on arm64 and powerpc
> because they do not support splitting of the direct map, so the only
> potential benefit there is a centralized handling of text loading and I'm
> not convinced execmem_alloc() will get us there.

Sharing large pages helps reduce iTLB pressure, which is the second
motivation here (after reducing direct map fragmentation).

>
> > > With execmem_alloc() as the first step I'm failing to see the large
> > > picture. If we want to use it for modules, how will we allocate RO data?
> > > with similar rodata_alloc() that uses yet another tree in vmalloc?
> > > How the caching of large pages in vmalloc can be made useful for use cases
> > > like secretmem and PKS?
> >
> > If RO data causes problems with direct map fragmentation, we can use
> > similar logic. I think we will need another tree in vmalloc for this case.
> > Since the logic will be mostly identical, I personally don't think adding
> > another tree is a big overhead.
>
> Actually, it would be interesting to quantify memory savings/waste as the
> result of using execmem_alloc()

From a random system in our fleet, execmem_alloc() saves:

139 iTLB entries (1x 2MB entry vs, 140x 4kB entries), which is more than
100% of L1 iTLB and about 10% of L2 TLB.

It wastes 1.5MB memory, which is 0.0023% of system memory (64GB).

I believe this is clearly a good trade-off.

Thanks,
Song
