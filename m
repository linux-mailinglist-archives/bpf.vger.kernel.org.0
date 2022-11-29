Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FAC63BBCA
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 09:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiK2IhZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 03:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiK2Igw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 03:36:52 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E3F59FDC
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 00:35:24 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 679A068C7B; Tue, 29 Nov 2022 09:35:19 +0100 (CET)
Date:   Tue, 29 Nov 2022 09:35:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, rppt@kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v5 3/6] selftests/vm: extend test_vmalloc to
 test execmem_* APIs
Message-ID: <20221129083518.GA25167@lst.de>
References: <20221128190245.2337461-1-song@kernel.org> <20221128190245.2337461-4-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128190245.2337461-4-song@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> +#if DEBUG_TEST_VMALLOC_EXEMEM_ALLOC
> +EXPORT_SYMBOL_GPL(execmem_alloc);
> +#endif

> +#if DEBUG_TEST_VMALLOC_EXEMEM_ALLOC
> +EXPORT_SYMBOL_GPL(execmem_fill);
> +#endif

> +#if DEBUG_TEST_VMALLOC_EXEMEM_ALLOC
> +EXPORT_SYMBOL_GPL(execmem_free);
> +#endif

Still NAK.  These symbols never have any business being exported
ever.  Just force the test to be built-in if you want to test this
functionality.
