Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDF16328BE
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 16:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiKUPzs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 10:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiKUPzr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 10:55:47 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A613CD948
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 07:55:46 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 45AEA68CFE; Mon, 21 Nov 2022 16:55:42 +0100 (CET)
Date:   Mon, 21 Nov 2022 16:55:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        peterz@infradead.org, hch@lst.de, rick.p.edgecombe@intel.com,
        rppt@kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v4 1/6] vmalloc: introduce execmem_alloc,
 execmem_free, and execmem_fill
Message-ID: <20221121155542.GA27879@lst.de>
References: <20221117202322.944661-1-song@kernel.org> <20221117202322.944661-2-song@kernel.org> <882e2964-932e-0113-d3cd-344281add3a1@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <882e2964-932e-0113-d3cd-344281add3a1@iogearbox.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 04:52:24PM +0100, Daniel Borkmann wrote:
>> +void *execmem_fill(void *dst, void *src, size_t len)
>> +{
>> +	return ERR_PTR(-EOPNOTSUPP);
>> +}
>
> Don't they need EXPORT_SYMBOL_GPL, too?

None of these should be exported.  Modular code has absolutely no
business creating executable mappings.
