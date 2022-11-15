Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CA362AE67
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 23:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiKOWfF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 17:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbiKOWdW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 17:33:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAC95FDB
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:32:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF43061A60
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 22:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7EEC43470
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 22:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668551578;
        bh=AkFiT/OCoW830kzddjiNwqOI+WNjgdwDG9nzrCLJXFo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ACdA922TAkKdIEjsll5lT04CRLuFn0MgAextSqEDs9P7SItqXpgjmk7fl2D7Vk4ZI
         BBTUQHm+N7v1CJvCI0hAhFg56jOQXn5IVqDswuLQspK6+j22/RqNwfkJJxV3t9UCWX
         KKyIyFLK30qnvY2xazf8lIHY8Xx5epgPnOdltdEoBLBAPD4Q4YawWXJZumesPAgP1l
         a3DZIuVcWjm3ZSLQcJzOk0N3WOeuG6TRO4OBoxES2VpEtNWhbSVN+sGu/RTxaqp1Gj
         gf0g4v/yHUsW44O4mSxlKacfSmugZ5/TDkS5hh5hvf7sIgdIHdqW3DSQWgX+v1FhMP
         rG9WEs7271A5w==
Received: by mail-ej1-f46.google.com with SMTP id m22so39737254eji.10
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:32:58 -0800 (PST)
X-Gm-Message-State: ANoB5plRNoP0D1fGz7gI/jENm+x4wFu+aDf6IEFTDDkoZ1et2+t4twa9
        6GqoAdsMLmd/v0NGR33rmIM1XPlobl17h63Zq9k=
X-Google-Smtp-Source: AA0mqf7UaOz/LbZTdRJi0rcR1w/zTRJUIJyUUCN1a3JNq/Z2U5hZCJO1WhldHiA+tUTuKdalVa4rQnMIuFT3Hd7M31M=
X-Received: by 2002:a17:906:ad98:b0:7a1:e4c2:fb0a with SMTP id
 la24-20020a170906ad9800b007a1e4c2fb0amr16070128ejb.101.1668551576384; Tue, 15
 Nov 2022 14:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
 <c7e9bbf45b2d52253fec16525645bda0887a9cf9.camel@intel.com>
 <CAPhsuW7H95hUUCGEk9etwTT8kYRCKCtD6Lo+8WxHUyGTKSyEFA@mail.gmail.com> <4bf1a1377ea39f287a4fd438d81f314d261f7d7f.camel@intel.com>
In-Reply-To: <4bf1a1377ea39f287a4fd438d81f314d261f7d7f.camel@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 15 Nov 2022 14:32:43 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4g_qLC84fuFxhfmhmshVtMHVYDDr8PGfkA5WGYk=dsdA@mail.gmail.com>
Message-ID: <CAPhsuW4g_qLC84fuFxhfmhmshVtMHVYDDr8PGfkA5WGYk=dsdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
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

On Tue, Nov 15, 2022 at 2:14 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Tue, 2022-11-15 at 13:54 -0800, Song Liu wrote:
> > On Tue, Nov 15, 2022 at 9:34 AM Edgecombe, Rick P
> > <rick.p.edgecombe@intel.com> wrote:
> > >
> > > On Mon, 2022-11-14 at 17:30 -0800, Song Liu wrote:
> > > > Currently, I have got the following action items for v3:
> > > > 1. Add unify API to allocate text memory to motivation;
> > > > 2. Update Documentation/x86/x86_64/mm.rst;
> > > > 3. Allow none PMD_SIZE allocation for powerpc.
> > >
> > > So what do we think about supporting the fallback mechanism for the
> > > first version, like:
> > >
> > >
> https://lore.kernel.org/all/9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com/
> > >
> > > It helps the (1) story by actually being usable by non-text_poke()
> > > architectures.
> >
> > I personally think this might be a good idea. We will need this when
> > we use
> > execmem_alloc for modules. But I haven't got a chance to look at
> > module code in
> > great detail. I was thinking of adding this logic with changes in
> > module code.
>
> BPF used to have a generic allocator that just called module_alloc().
> If you had a fallback method could you unify all of BPF to use
> execmem()?

Yes, we can use execmem as the unified API for all BPF JIT engines.

Song
