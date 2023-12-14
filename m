Return-Path: <bpf+bounces-17894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A959A813E28
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCD61C21ECB
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 23:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF96C6C6CD;
	Thu, 14 Dec 2023 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="KapZNrUP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B48F6C6D0
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 23:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6d9ac148ca3so112164a34.0
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 15:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702595924; x=1703200724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b0oETvX0aTkLzmG8FImfzT7xcxi5q4ncJHmqU5g7274=;
        b=KapZNrUPp1pbkAxaOlTDPs8OaWgB9RAPeg144O5Qs31VdR3J+LcZjFno8NIapaRgVJ
         nZCFXAgR1/kFbvRZERJb5UlFIoXp4wZO4Yr7d5roGfOIgHhkobEYRth/3giT4+eKxSyX
         HkI7NR+dmXLtJUhTRTpXjlNM10oPm3LYI6Xj+jbL5VyAd5lZVIkEuh4EnQUG6TzS2Wwx
         RgZ0f2eYHscqpjJghpvAhCB0dAgIHMMoy/zuaQmKoOnXgmkHF4mZ7zqQ5t5ncoYWizzX
         Yd5KufodsoJ7cNdL3/XfQua921RgSlMSMZgbuq6su4Wascc7ffY5nx5JGCogJCcqihMv
         9JJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702595924; x=1703200724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0oETvX0aTkLzmG8FImfzT7xcxi5q4ncJHmqU5g7274=;
        b=hyqQpFaNwN5ZvT2b5Ikzw+Os+D8c/7uNwsM5Ld7vnHiFcE5XHDXHwo1BVvzEkDB3vh
         597f5R5gjbt4J4XGPn8Ti3V+oAfKEh8woC5gQMsIiDra9k3m7YgGcqjRWFr5AgPfGjvO
         NIJFstAc2zVORhVxA8ATklWF8ah4F1KrL0Sii6o4gMr3a5DYbc6LQndqGeeMtREhN9gc
         kcxblXS15MPZBEThmQrj7lpW/VpLMBoN5heMER9HPC0QdJXchrE1uxTKnmo4TMzibL4K
         UKMdX4kiEICJYUTRcVNywzEwbgJugmN0YRVx5mrwDw5/rD0H4DH2JEOSGOdlOtvDIE0B
         A8+A==
X-Gm-Message-State: AOJu0YxVRU+3SZvOJiQv05RxqC6qhfI/OfPtPfppya/QAOzfnx3aBaHA
	2GhV4c6xWXYPLhNNwLHJH/2zuw==
X-Google-Smtp-Source: AGHT+IHU6o+cki1YVvnE+9X9E/ODNsU7SGC6cfB6JPU4w5tZxS4la3CBRG46Du9+4KZO1hBLz/5XyA==
X-Received: by 2002:a05:6870:d611:b0:203:5cca:4bb with SMTP id a17-20020a056870d61100b002035cca04bbmr962078oaq.69.1702595924074;
        Thu, 14 Dec 2023 15:18:44 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::7:618c])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7870f000000b006cdd507ca2esm12310455pfo.167.2023.12.14.15.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 15:18:43 -0800 (PST)
Message-ID: <2dcfb90d-2cac-4297-aaec-173c559369f3@davidwei.uk>
Date: Thu, 14 Dec 2023 15:18:41 -0800
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
> -
> -		if (unlikely(dma_mapping_error(&pdev->dev, frag_mapping)))
> -			return NULL;
> -
> -		dma_unmap_addr_set(frag_tx_buf, mapping, frag_mapping);

If this is no longer set, what would happen to dma_unmap_single() in
bnxt_tx_int_xdp() that is then reading `mapping` via dma_unmap_addr()?

> -
>  		flags = frag_len << TX_BD_LEN_SHIFT;
>  		txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
> +		frag_mapping = page_pool_get_dma_addr(skb_frag_page(frag)) +
> +			       skb_frag_off(frag);
>  		txbd->tx_bd_haddr = cpu_to_le64(frag_mapping);
>  
>  		len = frag_len;

