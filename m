Return-Path: <bpf+bounces-6471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C670A76A220
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 22:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0232809CA
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 20:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B85D1DDEB;
	Mon, 31 Jul 2023 20:44:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4436C18C26;
	Mon, 31 Jul 2023 20:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4900DC433C7;
	Mon, 31 Jul 2023 20:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690836271;
	bh=SHDr7peJpsqYjk1YYJ6lesA5un3+gzLXwV6kUuEgO5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U8HewhsYSrMKPEyBouvOQ4rYPL0pes3fz3WzgilKr4glU7Qi0/NKIaGTMucnXoBrR
	 T9X/FNWZx6493vJqv9XEouBmUAR0DchqgHtsAYWz4T1WqgVRaeGKIsJIZPeo9VJlDr
	 VGGwgDK2maHNF8L9U/X6nQkD9bcjepDe+bNdVY3lwxLYsyphIB7yGGSExsGnF/M1B2
	 k3CcXjNFUw0UhQ2S1phVv45HguBh6vzSmr8RvgkXhl4KH7GnOyYS8h+paHAY/zEQWf
	 v5Vh2C0lPasJg2xdGdwHgKHGjuMj72J7XVbJ68RyY1Nvj1J7hVwekm2mwZd69llU+H
	 shPvKxmbuaWFg==
Date: Mon, 31 Jul 2023 13:44:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 gospo@broadcom.com, bpf@vger.kernel.org, somnath.kotur@broadcom.com, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next 3/3] bnxt_en: Let the page pool manage the DMA
 mapping
Message-ID: <20230731134430.5e7f9960@kernel.org>
In-Reply-To: <CACKFLimJO7Wt90O_F3Nk375rABpAQvKBZhNmBkNzzehYHbk_jA@mail.gmail.com>
References: <20230728231829.235716-1-michael.chan@broadcom.com>
	<20230728231829.235716-4-michael.chan@broadcom.com>
	<20230728174212.64000bdc@kernel.org>
	<2eadb48b-2991-7458-16a6-51082ff3ec2c@kernel.org>
	<20230731110008.26e8ce03@kernel.org>
	<CACKFLinHWLMScGbYKZ+zNAn2iV1zqLkNVWDMQwJRZYd-yRiY7g@mail.gmail.com>
	<20230731114427.0da1f73b@kernel.org>
	<CACKFLimJO7Wt90O_F3Nk375rABpAQvKBZhNmBkNzzehYHbk_jA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 13:20:04 -0700 Michael Chan wrote:
> I think I am beginning to understand what the confusion is.  These 32K
> page fragments within the page may not belong to the same (GRO)
> packet.

Right.

> So we cannot dma_sync the whole page at the same time.

I wouldn't phrase it like that.

> Without setting PP_FLAG_DMA_SYNC_DEV, the driver code should be
> something like this:
> 
> mapping = page_pool_get_dma_addr(page) + offset;
> dma_sync_single_for_device(dev, mapping, BNXT_RX_PAGE_SIZE, bp->rx_dir);
> 
> offset may be 0, 32K, etc.
> 
> Since the PP_FLAG_DMA_SYNC_DEV logic is not aware of this offset, we
> actually must do our own dma_sync and not use PP_FLAG_DMA_SYNC_DEV in
> this case.  Does that sound right?

No, no, all I'm saying is that with the current code (in page pool)
you can't be very intelligent about the sync'ing. Every time a page
enters the pool - the whole page should be synced. But that's fine,
it's still better to let page pool do the syncing than trying to
do it manually in the driver (since freshly allocated pages do not 
have to be synced).

I think the confusion comes partially from the fact that the driver
only ever deals with fragments (32k), but internally page pool does
recycling in full pages (64k). And .max_len is part of the recycling
machinery, so to speak, not part of the allocation machinery.

tl;dr just set .max_len = PAGE_SIZE and all will be right.

