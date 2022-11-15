Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914F762A3BB
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 22:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiKOVJT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 16:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbiKOVJL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 16:09:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933F6233BC
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 13:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hgbPXbCYgLBsaW86LPk6uCa9uNA4J884/uF7RVk0T4o=; b=ir/apLSpJxjKbmRtx0X5CXb0L3
        kKLJBc5vH0F8unE4m8uKiLIOJxBVXEZHVS1z/Ywxmpct0NEtAHm2pxd4fQB52r+KWGawAPh349yUx
        /AU3e2xOqSbzZasKV8YW/hHu2paKyrAixKcmoeoN+pgujdkO3+t8nxOwwtYfhKSvq77DAnWdpaDN3
        oL3nzzKY+oqeuH4PkY0Ly7/N18tRAdqy0s7Hrf0/fFBtLauVZCQP+zNfkC5NeEm5tbzNvHpkZDdLg
        aOsvOQbWiVW9YYzkf61d9g+0xfb9Znj1wyycSRXqWMlBzjzQS8ntzZ3afpiF2cvMolUnXYnbwKCK7
        FyJiDoPQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov3B6-00F1BI-IA; Tue, 15 Nov 2022 21:09:08 +0000
Date:   Tue, 15 Nov 2022 13:09:08 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y3P/9DXAjKhmoIvm@bombadil.infradead.org>
References: <20221107223921.3451913-1-song@kernel.org>
 <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 14, 2022 at 05:30:39PM -0800, Song Liu wrote:
> On Mon, Nov 7, 2022 at 2:41 PM Song Liu <song@kernel.org> wrote:
> >
> 
> [...]
> 
> >
> >
> > This set enables bpf programs and bpf dispatchers to share huge pages with
> > new API:
> >   execmem_alloc()
> >   execmem_alloc()
> >   execmem_fill()
> >
> > The idea is similar to Peter's suggestion in [1].
> >
> > execmem_alloc() manages a set of PMD_SIZE RO+X memory, and allocates these
> > memory to its users. execmem_alloc() is used to free memory allocated by
> > execmem_alloc(). execmem_fill() is used to update memory allocated by
> > execmem_alloc().
> 
> Sigh, I just realized this thread made through linux-mm@kvack.org, but got
> dropped by bpf@vger.kernel.org, so I guess I will have to resend v3.

I don't know what is going on with the bpf list but whatever it is, is silly.
You should Cc the right folks to ensure proper review if the bpf list is
the issue.

> Currently, I have got the following action items for v3:
> 1. Add unify API to allocate text memory to motivation;
> 2. Update Documentation/x86/x86_64/mm.rst;
> 3. Allow none PMD_SIZE allocation for powerpc.

- I am really exausted of asking again for real performance tests,
  you keep saying you can't and I keep saying you can, you are not
  trying hard enough. Stop thinking about your internal benchmark which
  you cannot publish. There should be enough crap out which you can use.

- A new selftest or set of selftests which demonstrates gain in
  performance

- Extensions maybe of lib/test_vmalloc.c or whatever is appropriate to
  test correctness

- Enhance commit logs to justify the *why*, one of which to hightight is
  providing an API for memory semantics for special memory pages

  Luis
