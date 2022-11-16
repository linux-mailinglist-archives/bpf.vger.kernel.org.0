Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367FF62B07B
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 02:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiKPBVL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 20:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiKPBVK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 20:21:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270922A260
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 17:21:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6A6DB81B96
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 01:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CC8C43144
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 01:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668561667;
        bh=HPqSwtnsmvwz/eW+Mmf5+RnJY7HuFktOa5yX14Ed7LM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ogNeepUbx4ycRs7rkijwdNMMjenRJ7ktYqIqBHZ3+8d9pXOYOER27DbiyVxFqzkaf
         sK7dBRdeyDh5WmW6Z1Msj21RLfC/7JZGgPM1VXOZ3bltDMzZKD+1/5bXOF7REtmqPF
         nlY69skj6mwy9QcYAX+hvytwqkCV05dfa3Ypp9AA4fvevz6pbC2dRsMqAL31IaV9qZ
         xT0ReD/xHjIs9uWFLREaWSCSXNEo/EdOZjL4gFUNIVNmOqaCAf9+wSUJtUtqfzFEwn
         h1roVBjh8rIwxp6+e1Egs2gdcoIPQROw/keNZ/eftt7QJR/tlz/IyBBty/EsfESqOY
         k2XkjT0JoT7Kw==
Received: by mail-ed1-f43.google.com with SMTP id u24so24412521edd.13
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 17:21:07 -0800 (PST)
X-Gm-Message-State: ANoB5pnSFpHvuVY3Muk7B4IWFjqqb++MKnn3smIhQQyyAUoYQ49bcu1S
        aWyh4PUC2hlIiXAOYIUhMFqf2uAQtHAcXs06Y4Q=
X-Google-Smtp-Source: AA0mqf7gEknKqMKDRE7Lw2a12ouFxnXF1mlyTLNDq1SQ+e7WcGJ0EcOvuMxWLRCAkNh28uhLFAEQbiIvDlIJX0i3/4A=
X-Received: by 2002:aa7:c6d9:0:b0:462:2c1c:8791 with SMTP id
 b25-20020aa7c6d9000000b004622c1c8791mr17503929eds.29.1668561665575; Tue, 15
 Nov 2022 17:21:05 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
 <c7e9bbf45b2d52253fec16525645bda0887a9cf9.camel@intel.com>
 <CAPhsuW7H95hUUCGEk9etwTT8kYRCKCtD6Lo+8WxHUyGTKSyEFA@mail.gmail.com> <4bf1a1377ea39f287a4fd438d81f314d261f7d7f.camel@intel.com>
In-Reply-To: <4bf1a1377ea39f287a4fd438d81f314d261f7d7f.camel@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 15 Nov 2022 17:20:53 -0800
X-Gmail-Original-Message-ID: <CAPhsuW60U0n-szdD9AO214zk5GHscZ6jnxBoh7_HBcfYw6fdSQ@mail.gmail.com>
Message-ID: <CAPhsuW60U0n-szdD9AO214zk5GHscZ6jnxBoh7_HBcfYw6fdSQ@mail.gmail.com>
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

To clarify, are you suggesting we need this logic in this set? I would
rather wait until we handle module code. This is because BPF JIT uses
module_alloc() for archs other than x86_64. So the fall back of
execmem_alloc() for these archs would be module_alloc() or
something similar. I think it is really weird to do something like

void *execmem_alloc(size_t size)
{
#ifdef CONFIG_SUPPORT_EXECMEM_ALLOC
    ...
#else
    return module_alloc(size);
#endif
}

WDYT?

Thanks,
Song
