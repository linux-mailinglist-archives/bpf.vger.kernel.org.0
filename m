Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B26E521EF8
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 17:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243731AbiEJPjg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 11:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346018AbiEJPiu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 11:38:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730DD222C13
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 08:34:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C7576101F
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 15:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F22FC385A6;
        Tue, 10 May 2022 15:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652196872;
        bh=gXpekzy4uBt4nU42ofB5utDj8nYivN+u/Zv2X1uquuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kh1UUMSGkZQA/4LCFg4q9672pKCHz8Kn2mCa5inyzOvzX3mpiDDZd7zQTUHuO35xH
         b8r6TaU8tYCAOL+3XOCN4tzPAlPKU58h1Fcu+CTmlzWyOpxG5lZgMNOjxJUV/2Ao6t
         1pXatPbILLytDClzGW+dWCFFY7x37IZDis7y0LlBKX+GaajpUaLhXs63/Jbcjh2iLm
         JhSxgXLSYTe1W06Kso19DoEq7ETNL2WzD9GBNjKMcv+BeuVyzRxKbkTOMeAuCk/Lf1
         8mV9zZLs47mk/zgH9zC9ctJ4mpAj0f/bB9OCSJY8zX84iXrXpyUG0SesBY4xvQlkE+
         egUXZMsg3o3TQ==
Date:   Tue, 10 May 2022 08:34:30 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next 8/9] libbpf: automatically fix up
 BPF_MAP_TYPE_RINGBUF size, if necessary
Message-ID: <YnqGBmOHIZhrZBFJ@dev-arch.thelio-3990X>
References: <20220509004148.1801791-1-andrii@kernel.org>
 <20220509004148.1801791-9-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509004148.1801791-9-andrii@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

On Sun, May 08, 2022 at 05:41:47PM -0700, Andrii Nakryiko wrote:
> Kernel imposes a pretty particular restriction on ringbuf map size. It
> has to be a power-of-2 multiple of page size. While generally this isn't
> hard for user to satisfy, sometimes it's impossible to do this
> declaratively in BPF source code or just plain inconvenient to do at
> runtime.
> 
> One such example might be BPF libraries that are supposed to work on
> different architectures, which might not agree on what the common page
> size is.
> 
> Let libbpf find the right size for user instead, if it turns out to not
> satisfy kernel requirements. If user didn't set size at all, that's most
> probably a mistake so don't upsize such zero size to one full page,
> though. Also we need to be careful about not overflowing __u32
> max_entries.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

<snip>

> +static size_t adjust_ringbuf_sz(size_t sz)
> +{
> +	__u32 page_sz = sysconf(_SC_PAGE_SIZE);
> +	__u32 i, mul;
> +
> +	/* if user forgot to set any size, make sure they see error */
> +	if (sz == 0)
> +		return 0;
> +	/* Kernel expects BPF_MAP_TYPE_RINGBUF's max_entries to be
> +	 * a power-of-2 multiple of kernel's page size. If user diligently
> +	 * satisified these conditions, pass the size through.
> +	 */
> +	if ((sz % page_sz) == 0 && is_pow_of_2(sz / page_sz))
> +		return sz;
> +
> +	/* Otherwise find closest (page_sz * power_of_2) product bigger than
> +	 * user-set size to satisfy both user size request and kernel
> +	 * requirements and substitute correct max_entries for map creation.
> +	 */
> +	for (i = 0, mul = 1; ; i++, mul <<= 1) {
> +		if (mul > UINT_MAX / page_sz) /* prevent __u32 overflow */
> +			break;
> +		if (mul * page_sz > sz)
> +			return mul * page_sz;
> +	}
> +
> +	/* if it's impossible to satisfy the conditions (i.e., user size is
> +	 * very close to UINT_MAX but is not a power-of-2 multiple of
> +	 * page_size) then just return original size and let kernel reject it
> +	 */
> +	return sz;
> +}

This patch in -next as commit 0087a681fa8c ("libbpf: Automatically fix
up BPF_MAP_TYPE_RINGBUF size, if necessary") breaks the build with tip
of tree LLVM due to [1] strengthening -Wunused-but-set-variable:

libbpf.c:4954:8: error: variable 'i' set but not used [-Werror,-Wunused-but-set-variable]
        __u32 i, mul;
              ^
1 error generated.

Should i be removed or was it intended to be used somewhere that it is
not?

[1]: https://github.com/llvm/llvm-project/commit/2af845a6519c9cde5c8f58db5554f8b1084ce1ed

Cheers,
Nathan
