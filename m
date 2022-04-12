Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2AD4FCD83
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 06:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345331AbiDLEUl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 00:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345266AbiDLEUl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 00:20:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8046022B35;
        Mon, 11 Apr 2022 21:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MAGlAnBxD7wyQSz4EwEMb3ZK13YdG90sRwMHnO/9tbg=; b=ATlnpj6dvccFOr4ecTroAQ+0q0
        pqHl6P4OqoGeC+NYqByLkeR1EFVqodIbnCWC1DCWAPhsZKvmubgixvx5GhBFjPB/2pYIdncZBFgQ7
        bz64hBsoNwQEEGdPy25CDvNBIp//U4t2Ex+mlSxSS4VQQPsRrhkvowVIdJRsDbWL1fAmxYbncgAFD
        WXn3jxBWSJSKEMdF7RVJMYJFc9lXYiLVFU01UzQNohPsUyypn2XpNt9tkTJK4vJN9JBX6hEmqTSbD
        6Jb9FTrhIzk15DXbp8uxbDfg4i9wIoNie1tvHkw9bBgDxSp1GcNI+WePACCHlmQrX/VLAwY2Qc+tp
        AR7JTC5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ne7yt-00BVqf-8R; Tue, 12 Apr 2022 04:18:19 +0000
Date:   Mon, 11 Apr 2022 21:18:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, akpm@linux-foundation.org,
        rick.p.edgecombe@intel.com, hch@infradead.org,
        imbrenda@linux.ibm.com, mcgrof@kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 bpf 1/3] vmalloc: replace VM_NO_HUGE_VMAP with
 VM_ALLOW_HUGE_VMAP
Message-ID: <YlT9i9DFvwDx9+AD@infradead.org>
References: <20220411233549.740157-1-song@kernel.org>
 <20220411233549.740157-2-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411233549.740157-2-song@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 11, 2022 at 04:35:46PM -0700, Song Liu wrote:
> Huge page backed vmalloc memory could benefit performance in many cases.
> Since some users of vmalloc may not be ready to handle huge pages,
> VM_NO_HUGE_VMAP was introduced to allow vmalloc users to opt-out huge
> pages. However, it is not easy to add VM_NO_HUGE_VMAP to all the users
> that may try to allocate >= PMD_SIZE pages, but are not ready to handle
> huge pages properly.

This is a good place to document what the problems are, and how they are
hard to track down (e.g. because the allocations are passed down I/O
stacks)

> 
> Replace VM_NO_HUGE_VMAP with an opt-in flag, VM_ALLOW_HUGE_VMAP, so that
> users that benefit from huge pages could ask specificially.
> 
> Also, replace vmalloc_no_huge() with opt-in helper vmalloc_huge().

We still need to find out what the primary users of the large vmalloc
hashes was and convert them.

> +extern void *vmalloc_huge(unsigned long size) __alloc_size(1);

No need for the extern.

> +EXPORT_SYMBOL(vmalloc_huge);

EXPORT_SYMBOL_GPL for all advanced vmalloc functionality, please.
