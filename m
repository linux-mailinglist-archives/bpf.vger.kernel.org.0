Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD6F63351D
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 07:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiKVGN2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 01:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKVGN1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 01:13:27 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAB12CC97
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 22:13:26 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5535968D06; Tue, 22 Nov 2022 07:13:23 +0100 (CET)
Date:   Tue, 22 Nov 2022 07:13:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Song Liu <song@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        peterz@infradead.org, rick.p.edgecombe@intel.com, rppt@kernel.org
Subject: Re: [PATCH bpf-next v4 1/6] vmalloc: introduce execmem_alloc,
 execmem_free, and execmem_fill
Message-ID: <20221122061323.GA14204@lst.de>
References: <20221117202322.944661-1-song@kernel.org> <20221117202322.944661-2-song@kernel.org> <882e2964-932e-0113-d3cd-344281add3a1@iogearbox.net> <20221121155542.GA27879@lst.de> <CAPhsuW7M3rAa=d4G5kzBCPofgSvKz8+Zcxg7u3+2MLMs2FTX+w@mail.gmail.com> <Y3vXorejgjSCXtt3@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3vXorejgjSCXtt3@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 11:55:14AM -0800, Luis Chamberlain wrote:
> > I added these exports for test_vmalloc.ko. Is there a way to only export
> > them to test_vmalloc.ko but nothing else?
> 
> See EXPORT_SYMBOL_NS_GPL()

No, that is in no way limiting who uses it, it just makes them go
through extra hoops.

The funtionality to allocate exectuable memory is highly dangerous
and absolutely must be limited to built-in code.

So the tests should just be forced to be built-in here as well.
