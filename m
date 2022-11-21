Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB6B632D74
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 20:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiKUTzl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 14:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiKUTzY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 14:55:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7A263CEE
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 11:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o7A0f5fhMzFexYyY2uaItIw4YITyd89IESvV+ezjEYs=; b=SyETYHYQ80ABmsXfB0x1k+cFAL
        EmI7nazUgJ27wjE0C2WRLWE0VNiZVEXjEF0VL+/HlbR7p6fKZb/9j65HZbTGnWub9nkmOODCReX8d
        +lgwWBdlF528feYzlOuWJnTSYM4E8YofY7MDnABMVkj3z2KCwLWkoVF4GxehnTpS4rVmQTxkSRulD
        SCLxbaDRG/wysJC0ozX7ekyxVmGY6YjGtIACySiklCYqVAig8ggNzrKT+zTGOUqfPD9F2hO7vVYpD
        PYKc+xYMlhuddbcUAGWmiTo/RwrEnk+mqR2S3HO1uHa76ABZyTkDxxMoTZMop74qD7VGpytDRxSAj
        e5sBcaEw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxCss-00HNOo-Gv; Mon, 21 Nov 2022 19:55:14 +0000
Date:   Mon, 21 Nov 2022 11:55:14 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        peterz@infradead.org, rick.p.edgecombe@intel.com, rppt@kernel.org
Subject: Re: [PATCH bpf-next v4 1/6] vmalloc: introduce execmem_alloc,
 execmem_free, and execmem_fill
Message-ID: <Y3vXorejgjSCXtt3@bombadil.infradead.org>
References: <20221117202322.944661-1-song@kernel.org>
 <20221117202322.944661-2-song@kernel.org>
 <882e2964-932e-0113-d3cd-344281add3a1@iogearbox.net>
 <20221121155542.GA27879@lst.de>
 <CAPhsuW7M3rAa=d4G5kzBCPofgSvKz8+Zcxg7u3+2MLMs2FTX+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7M3rAa=d4G5kzBCPofgSvKz8+Zcxg7u3+2MLMs2FTX+w@mail.gmail.com>
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

On Mon, Nov 21, 2022 at 09:29:20AM -0700, Song Liu wrote:
> On Mon, Nov 21, 2022 at 8:55 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Mon, Nov 21, 2022 at 04:52:24PM +0100, Daniel Borkmann wrote:
> > >> +void *execmem_fill(void *dst, void *src, size_t len)
> > >> +{
> > >> +    return ERR_PTR(-EOPNOTSUPP);
> > >> +}
> > >
> > > Don't they need EXPORT_SYMBOL_GPL, too?
> >
> > None of these should be exported.  Modular code has absolutely no
> > business creating executable mappings.
> 
> I added these exports for test_vmalloc.ko. Is there a way to only export
> them to test_vmalloc.ko but nothing else?

See EXPORT_SYMBOL_NS_GPL()

  Luis
