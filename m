Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F5050259F
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 08:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350471AbiDOGeK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 02:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350458AbiDOGeH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 02:34:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49255BE52;
        Thu, 14 Apr 2022 23:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ejdrnRYNKs4esI1C9c6WhifXIFEiNkcchRuMuxtqQTI=; b=nGhJ36i37YrSYAJH5s45qfv5zb
        Uz8IC8hT6E0pMSVBASG1693ZtpIoJL4GpwQsdNmJIl3s8hq1giBBrc4QdoQ5zc3BZkk3PKL2MKV7e
        e/GU+o1cQiTRSurkOHyJypC0BQeGhfehS97EMEHZ8Zv8nzdMqJbqvrElUDQAxhHzfgLOmGbj8m8C0
        WmiWXIh9rxGyoq+ygXLKegSFd2oBajiIc8phBN2SdZ9mOHXegB5XFYsgRMameAtajEfadX1uPhpxg
        hm8Ytn6KQrtlR8lEdlChxFCLtHYsq+lqSemuCNrkocsGHzhjO6UwiIBPs9lIGasBuO8OPXBfB9M4Q
        2py8GPQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfFUZ-0090bP-GN; Fri, 15 Apr 2022 06:31:39 +0000
Date:   Thu, 14 Apr 2022 23:31:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, akpm@linux-foundation.org,
        rick.p.edgecombe@intel.com, hch@infradead.org,
        imbrenda@linux.ibm.com, mcgrof@kernel.org
Subject: Re: [PATCH v3 bpf RESEND 1/4] vmalloc: replace VM_NO_HUGE_VMAP with
 VM_ALLOW_HUGE_VMAP
Message-ID: <YlkRS36hKDkPtbBN@infradead.org>
References: <20220414195914.1648345-1-song@kernel.org>
 <20220414195914.1648345-2-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414195914.1648345-2-song@kernel.org>
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

On Thu, Apr 14, 2022 at 12:59:11PM -0700, Song Liu wrote:
> +void *vmalloc_huge(unsigned long size)
> +{
> +	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> +				    GFP_KERNEL, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
> +				    NUMA_NO_NODE, __builtin_return_address(0));
> +}
> +EXPORT_SYMBOL_GPL(vmalloc_huge);

It seems like this one isn't actually used in this series, so I'd
suggest to drop it.

> +
> +/**
> + * __vmalloc_huge - allocate virtually contiguous memory, allow huge pages
> + * @size:      allocation size
> + * @gfp_mask:  flags for the page level allocator
> + *
> + * Allocate enough pages to cover @size from the page level
>   * allocator and map them into contiguous kernel virtual space.
> + * If @size is greater than or equal to PMD_SIZE, allow using
> + * huge pages for the memory
>   *
>   * Return: pointer to the allocated memory or %NULL on error
>   */
> -void *vmalloc_no_huge(unsigned long size)
> +void *__vmalloc_huge(unsigned long size, gfp_t gfp_mask)

And I'd just rename this vmalloc_huge.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
