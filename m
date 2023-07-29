Return-Path: <bpf+bounces-6296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C7A7679A7
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 02:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49C52828CA
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF29264C;
	Sat, 29 Jul 2023 00:35:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAF37C;
	Sat, 29 Jul 2023 00:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E62DC433C7;
	Sat, 29 Jul 2023 00:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690590947;
	bh=swb+QlbOGgdla5kxgH6YKQpX1MeQ8cld4Ca9rdGg4Lo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p09H1ra/6P1mXAOuIAzKkF5Rg96BKcIcf4AI9Y5CDIUV1/LAOGATO+S0cFRb8kddk
	 l9XYGJV4jLIVNgIs2aIgEcnmWM5jK/iXwrVnGbTI9BETTdftFy8S6X3L/2Yyo0K6pc
	 dCkRE1Uz5D9Jr7ta8l4nEPRlKMPL7FdLzzHMH9W3VtpS8OIk9dJTQPDNSMao+TzfBS
	 8yj/EvElSJc7EncwXNTaKYuJte1Ql1d5yqjjNjSlIm2aj9lf2D11XnD8Cg7paUqPA5
	 mHQ847mY6iVQi4UG6aV7kid53hhmuPTLvik6zIqxwFyQdAGvxdpSlGG2ZCrKiVd8Of
	 fZpToutDxep2w==
Date: Fri, 28 Jul 2023 17:35:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, gospo@broadcom.com, bpf@vger.kernel.org,
 somnath.kotur@broadcom.com, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net-next 1/3] bnxt_en: Fix page pool logic for page size
 >= 64K
Message-ID: <20230728173546.122c3135@kernel.org>
In-Reply-To: <20230728231829.235716-2-michael.chan@broadcom.com>
References: <20230728231829.235716-1-michael.chan@broadcom.com>
	<20230728231829.235716-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jul 2023 16:18:27 -0700 Michael Chan wrote:
> From: Somnath Kotur <somnath.kotur@broadcom.com>
> 
> The RXBD length field on all bnxt chips is 16-bit and so we cannot
> support a full page when the native page size is 64K or greater.
> The non-XDP (non page pool) code path has logic to handle this but
> the XDP page pool code path does not handle this.  Add the missing
> logic to use page_pool_dev_alloc_frag() to allocate 32K chunks if
> the page size is 64K or greater.
> 
> Fixes: 9f4b28301ce6 ("bnxt: XDP multibuffer enablement")
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Fix is a fix... Let's get this into net, first.

> -	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, PAGE_SIZE, bp->rx_dir,
> +	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE, bp->rx_dir,
>  			     DMA_ATTR_WEAK_ORDERING);

this

> -	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, PAGE_SIZE, bp->rx_dir,
> +	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE, bp->rx_dir,
>  			     DMA_ATTR_WEAK_ORDERING);

this

> -			dma_unmap_page_attrs(&pdev->dev, mapping, PAGE_SIZE,
> +			dma_unmap_page_attrs(&pdev->dev, mapping, BNXT_RX_PAGE_SIZE,
>  					     bp->rx_dir,
>  					     DMA_ATTR_WEAK_ORDERING);

and this - unnecessarily go over 80 chars when there's already 
a continuation line that could take the last argument.

> @@ -185,7 +185,7 @@ void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
>  			struct xdp_buff *xdp)
>  {
>  	struct bnxt_sw_rx_bd *rx_buf;
> -	u32 buflen = PAGE_SIZE;
> +	u32 buflen = BNXT_RX_PAGE_SIZE;

nit: rev xmas tree here

>  	struct pci_dev *pdev;
>  	dma_addr_t mapping;
>  	u32 offset;
-- 
pw-bot: cr

