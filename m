Return-Path: <bpf+bounces-61008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C186ADF93B
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 00:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FB04A05BC
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 22:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253E327EFE8;
	Wed, 18 Jun 2025 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpPaG3Hj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A233085CE;
	Wed, 18 Jun 2025 22:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750284978; cv=none; b=VxWhe+oCT9yc8v3OAkUKPSPnvCVOnyYV4Eo+fZhIzo3DVsGuUDGbOjBvzAd1hSLijuoUSuR0rqNplcoD7UWoXGFVA/v57MecQqBaX8TNZoNyXFQQdVjX+LgW8ZLZm8Gvfni+tDPm1trVl7Z5yHoyMXUOuk4h7BbcAH0rO7JN3R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750284978; c=relaxed/simple;
	bh=Vo7VYqC9atPmpKK5GIJvwBLcV8TQc0xjKdO4cIBRMSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSGXZjNiDAY9iVanzt32ga8q3LGhN+mwDcX+ig0Kqnz8crKtBwMPoWGWx3XlsFUVlTEgVyX966Xoo2/4BDwRGDvpdTtShuRP9FZf/UELqRCyQTMyfURF7YOlCJaHAGD0QAxugpRJsGtAcuShme3bOhrGhYndSknKOHJUNW9T3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpPaG3Hj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747fc7506d4so105511b3a.0;
        Wed, 18 Jun 2025 15:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750284976; x=1750889776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bXXyW8YyKFcv52VvbZL/IMJUOoJuNpl+uHasmSoiSoQ=;
        b=mpPaG3HjbEKB0s6EqV9tLXXGcx15rx5Irckub94+fKeB/4EeInxcIvqZLXpi4wOuHs
         G5Qg5uFvtzLo2w8Rf6KgzEBLRn9I3n907jCMb13+vGiImjo96+e2RNulfpr/smnSTFxg
         OVDREVcprS9qsTbnfROxeCqy/t2Et92wOh3A8+8k/YiBNvQxRpH40+zTrlOMRBJb8g8p
         JVwwEd87gyPLjBCr7+Vw0w+tI126lH4N5xv/P5pTN96gQJGzshbEKUcAv2h9n8TBHecZ
         Ol+jfMtad+AeN3yfb0pJ8SJJrLbSCrsMhMkVeY9vW+G9zO3vcS+XSjlndUHIdxEE34NL
         uyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750284976; x=1750889776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXXyW8YyKFcv52VvbZL/IMJUOoJuNpl+uHasmSoiSoQ=;
        b=X48f9bDhycuHyd0FNfDzRuK9edEp1O7s+I+a2fhYqvY7psKg09BFDPGcDCBG6A1SgR
         5dfwcsayhQYQSArq1Dx1XUWG+npJtoyXhaAPy2l6oQxJrf689C2qwV4XxY/Id08HaW/u
         NGzKgeRcVtd1BLweXHixietWsG3ZfBag682w+LD8Ppry+Vr5M76eaSsuERcMQ8BYg8Op
         +7q6IdZYVtYgRPcr8Qc8mgLoQTmEP/pysKZIUym/n+Ddr0L+t6hfh6tn3ju27tsG8ltD
         hxnWMQHp06QKwDj+CVCp3IROjFvKbcehhgYAp5TZuyoYLY8x6DVda4l+o/XapyPfEnzk
         mckg==
X-Forwarded-Encrypted: i=1; AJvYcCVKUXaYqjuE6I2ryW++TPlXJJTrKQW38LB5/K2Pw3HKLPNsusnVf+GaL5SU5QqrQzX3Tc2G1Zq4m8laTg==@vger.kernel.org, AJvYcCVMpa9YtxKUanB+NFaB8mDIknh4PeAFY4VLTo8aYyy/R2ZFR9acGVAy/dF0JY7Zp2m025Y=@vger.kernel.org, AJvYcCVw4rSA3P7l2mekqHvl+GPL67eAPqJfTwEybvZJ2+AzxIrJdFaOcBFEOiT6dwHRdVCPqPDzrqktxNwfA9+o@vger.kernel.org, AJvYcCW+vkiV4csyfFNh3gsawXNOuY/vpPAHeiVwZOzFn/IS2EGuFFyEZb0cOaNnF3Q7EpUPRFbET6RZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzeM1piEU4upEFX3f3qQPQ6Z9xlNoFrNjGAENFoCy6X/ptUdqng
	0clJfgoYSwNBDYiG5KReRYWm+xGONRgVxUv47uobJZqYq5QLKRReRcs=
X-Gm-Gg: ASbGncvw2fLt5HFCdEHlJmDeqjERroSjcOZ6XN8VFhmDQ2/HZ7v3Nkks7zOdNSsetW4
	4QLEj7XnLl+W4UeVEkJczbObau55WRE1Z62fxHvTbTNtWzbDjKJAWnFFGoD9FLtQ1h/o6iAoPj9
	1cU1f+Uy2i54S7jcS0CY4zOk+A4oqtcRVFGfHu+0wG1uWPPaXUR8+A1WTuVO5Pm6K0y1NB6FGkO
	PdytVl1NcHC7neT+Si5RexroVcv48gnhOd/L4BbBUJFBLThMZCFgUAwe6Tk3n+wVhkyPGlqlX9Q
	2yMob3N5Ee5yqz2xJXX8N6/m/YVqd3VT82dHrnrSD95SLggc2OWbxyAn87WKn4QtJf2wNxMFmsv
	eoYzDvZrzfqLjEj996FTbunQ=
X-Google-Smtp-Source: AGHT+IExSMfGb5fUayBdf0peRgvJAdEA/VgzwPukDOR/vhSvbbVTtarNLjFlaHdPhkauF08P1jVFfQ==
X-Received: by 2002:a05:6a21:8cc6:b0:20f:94bd:eecf with SMTP id adf61e73a8af0-21fbd7ffb6bmr27695976637.42.1750284976452;
        Wed, 18 Jun 2025 15:16:16 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7489000519bsm11673996b3a.38.2025.06.18.15.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 15:16:16 -0700 (PDT)
Date: Wed, 18 Jun 2025 15:16:15 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, saeedm@nvidia.com, gal@nvidia.com,
	leonro@nvidia.com, tariqt@nvidia.com,
	Leon Romanovsky <leon@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>,
	Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net-next v6 12/12] net/mlx5e: Add TX support for netmems
Message-ID: <aFM6r9kFHeTdj-25@mini-arch>
References: <20250616141441.1243044-1-mbloch@nvidia.com>
 <20250616141441.1243044-13-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250616141441.1243044-13-mbloch@nvidia.com>

On 06/16, Mark Bloch wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> Declare netmem TX support in netdev.
> 
> As required, use the netmem aware dma unmapping APIs
> for unmapping netmems in tx completion path.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h | 3 ++-
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> index e837c21d3d21..6501252359b0 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> @@ -362,7 +362,8 @@ mlx5e_tx_dma_unmap(struct device *pdev, struct mlx5e_sq_dma *dma)
>  		dma_unmap_single(pdev, dma->addr, dma->size, DMA_TO_DEVICE);
>  		break;
>  	case MLX5E_DMA_MAP_PAGE:
> -		dma_unmap_page(pdev, dma->addr, dma->size, DMA_TO_DEVICE);
> +		netmem_dma_unmap_page_attrs(pdev, dma->addr, dma->size,
> +					    DMA_TO_DEVICE, 0);

For this to work, the dma->addr needs to be 0, so the callers of the
dma_map() need to be adjusted as well, or am I missing something?
There is netmem_dma_unmap_addr_set to handle that, but I don't see
anybody calling it. Do we need to add the following (untested)?

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 55a8629f0792..fb6465210aed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -210,7 +210,9 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		if (unlikely(dma_mapping_error(sq->pdev, dma_addr)))
 			goto dma_unmap_wqe_err;
 
-		dseg->addr       = cpu_to_be64(dma_addr);
+		dseg->addr = 0;
+		if (!netmem_is_net_iov(skb_frag_netmem(frag)))
+			dseg->addr = cpu_to_be64(dma_addr);
 		dseg->lkey       = sq->mkey_be;
 		dseg->byte_count = cpu_to_be32(fsz);
 

