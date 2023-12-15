Return-Path: <bpf+bounces-17958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7CE814196
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 06:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82EB42824B8
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 05:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732DD7470;
	Fri, 15 Dec 2023 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Hw7CJfrB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2516CCA67
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d347b4d676so2297365ad.2
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 21:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702619643; x=1703224443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fOoHdM5h9bwf4FU75c9JhTdCin+GzT+LCK1gzu+NdQk=;
        b=Hw7CJfrBf3WUSjkK5CZuMc/BhSZsIA/RxnkvygUJP/ZV9xDkojZuYc/mWFjRezZ7VR
         CqgMh36SXnlbPle69g6fSf4lpnQJJQKsim2Hv372YcJTuHLiMOIcDdGV/FvCobPvAf/K
         yA7eVXzgOyo+h3eZsOCXUc/ehSXRztSkLJLape2O3qfVscU0FlEiGFz22jxdNSKrY3q8
         EnX9yfXBd/Ubv2BCI5+WYg3c1dBXCSgyPdm/GVGaJGk4mwFHLCFwnz+nbiYyT+ZTrGHv
         2rCkEs8wsR3W1SjvnqQBqykwEg8LO5KiuoG0LiYkq76wXvwB1Oha9cTF2J3Wizss2Eur
         tyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702619643; x=1703224443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOoHdM5h9bwf4FU75c9JhTdCin+GzT+LCK1gzu+NdQk=;
        b=Taadk5h8bByuSJyjBFr8UBo89KR5RkDNiSK4+EAB+6txQYDteKOYwpgB2BRPtRxh8W
         +rlMWtVUVqIDQiSCK+YatnzhaENzDeHarlFuOYEG1LdkRtWlv6VJt2mu0QmXPQX+F4RI
         ziw0h04NjaDaz20mrgQuEZxwc6ASG8Kob9imZ9SMp82UHfNDSlOrL7Xz+fRbZcDZkx3e
         +ilkJeUAXlcKThnSu81rY2W0sSc7bczbSNmVu6/t7/Z3An8eFyfy4wgcrDr9UNCG4G+B
         KxXbwd+hOg0G62gWq1/ompcxba+FP+cW9lqfURcZAdGvFR7K/ZYVeJhMntyRmcx9TN1p
         w/vQ==
X-Gm-Message-State: AOJu0YzWBxo74cBiljTMqyMm0MBNhd20AVNXjxhpjaPWgtH9NtelhQQs
	yRI4UaewjG97bah8WUdQVaPviw==
X-Google-Smtp-Source: AGHT+IHS5eNnx4eTODXiGFp6VCbig0GK/VsSwcRzlq6iv7RUQFpt8KHA6pNXx5viXRHJRzh+LVMaKQ==
X-Received: by 2002:a17:903:2348:b0:1d0:6ffe:9ef with SMTP id c8-20020a170903234800b001d06ffe09efmr12532549plh.77.1702619643479;
        Thu, 14 Dec 2023 21:54:03 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e1::122b? ([2620:10d:c090:400::4:bb0d])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001d37c19b759sm853058plb.160.2023.12.14.21.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 21:54:03 -0800 (PST)
Message-ID: <e78e0343-6647-4918-bacf-c00abc01a2ba@davidwei.uk>
Date: Thu, 14 Dec 2023 21:54:00 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bnxt_en: do not map packet buffers twice
Content-Language: en-GB
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bpf@vger.kernel.org, hawk@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
References: <20231214213138.98095-1-michael.chan@broadcom.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20231214213138.98095-1-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-14 13:31, Michael Chan wrote:
> From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> 
> Remove double-mapping of DMA buffers as it can prevent page pool entries
> from being freed.  Mapping is managed by page pool infrastructure and
> was previously managed by the driver in __bnxt_alloc_rx_page before
> allowing the page pool infrastructure to manage it.
> 
> Fixes: 578fcfd26e2a ("bnxt_en: Let the page pool manage the DMA mapping")
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: David Wei <dw@davidwei.uk>

> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index 96f5ca778c67..8cb9a99154aa 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -59,7 +59,6 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
>  	for (i = 0; i < num_frags ; i++) {
>  		skb_frag_t *frag = &sinfo->frags[i];
>  		struct bnxt_sw_tx_bd *frag_tx_buf;
> -		struct pci_dev *pdev = bp->pdev;
>  		dma_addr_t frag_mapping;
>  		int frag_len;
>  
> @@ -73,16 +72,10 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
>  		txbd = &txr->tx_desc_ring[TX_RING(prod)][TX_IDX(prod)];
>  
>  		frag_len = skb_frag_size(frag);
> -		frag_mapping = skb_frag_dma_map(&pdev->dev, frag, 0,
> -						frag_len, DMA_TO_DEVICE);

I checked that skb_frag_dma_map() calls dma_map_page() with page set to
skb_frag_page(frag) and offset set to skb_frag_off(frag) + offset where
offset is 0. This is thus equivalent to the line added below:

page_pool_get_dma_addr(skb_frag_page(frag)) + skb_frag_off(frag)

> -
> -		if (unlikely(dma_mapping_error(&pdev->dev, frag_mapping)))
> -			return NULL;

I checked that page_pool_get_dma_addr() cannot fail or return an invalid
mapping. The DMA mapping happens when bulk allocating the pp alloc cache
during __page_pool_alloc_pages_slow(). If DMA mapping fails during
page_pool_dma_map() then the page is not stored in the cache. Therefore
any pages allocated from the pp will have a valid DMA addr.

> -
> -		dma_unmap_addr_set(frag_tx_buf, mapping, frag_mapping);

As discussed with Michael Chan, only XDP_TX will have multiple page
frags. Presumably only XDP_TX will have num_frags > 0 and enter this for
loop. Even though XDP_REDIRECT also calls bnxt_xmit_bd() from
__bnxt_xmit_xdp_redirect(), I assume xdp_buff_has_frags() returns false.

> -
>  		flags = frag_len << TX_BD_LEN_SHIFT;
>  		txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
> +		frag_mapping = page_pool_get_dma_addr(skb_frag_page(frag)) +
> +			       skb_frag_off(frag);

I trust that the page pool DMA mapping management is correct.

Both skb_frag_dma_map() and page_pool_dma_map() call into
dma_map_page_attrs(), but page_pool_dma_map() has flags
DMA_ATTR_SKIP_CPU_SYNC and DMA_ATTR_WEAK_ORDERING set whereas
skb_frag_dma_map() has no flags.

DMA_ATTR_WEAK_ORDERING is optional and ignored for platforms that do not
support it, therefore safe to use.

DMA_ATTR_SKIP_CPU_SYNC is used since presumably there is no sharing of
pages between multiple devices. IIRC there is a single page pool per Rx
queue/NAPI context.

>  		txbd->tx_bd_haddr = cpu_to_le64(frag_mapping);
>  
>  		len = frag_len;

