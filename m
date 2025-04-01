Return-Path: <bpf+bounces-55052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45955A776ED
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 10:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD173AA89E
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 08:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFDD1EBA16;
	Tue,  1 Apr 2025 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUojYi8Z"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372161EB5F8
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497544; cv=none; b=nk2iXoATsOCpV473+yWUOkF+6vDMNzeCmScMTyEO14/PJEA8IHkXScAU8V+hF+Ii1cl73C2eNU5d59Uu9Ye7kGYy8GaesaiCNnH10BPOYTDQj8IQE86g1osa89TkYqOXY8hulKCjV+Q0daKGkF+z9DfFKUaquNiHK9Wvc79dpCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497544; c=relaxed/simple;
	bh=fNkQvYlNaa3cqbrVMNrNNj9EdtzcFO71fUGvPTgiinQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFgAplBsHJsQOqZi/B3yy5CG1Oz9ZSgmoNrO4dd28QvIP6zSeSGGSQJdd5suqFo0+yGPLWeB3ye2IHSEGOLJlJ9BPiCLdLBgbpJVFOgyuRBbrQC0oeu4ceP//i5CI4ZJl+eOrlyyG0x1wL24mAk6ZP2x3nenHWS26h4kLv3ysYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUojYi8Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743497542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTrzmKHOhipGTrVn6hOCwktriFPfHqZi1ySNcTDYp58=;
	b=YUojYi8ZAMeXoo/HxJ0x0B/DNZk3CljCNCrB/uYtvSkTGDMptoyt/IAVmTS1K3kecys3JU
	akTUhE9MxJdzeznuoxLNwPpQowFoKlkOZ7LZSqBUmA/uL0GnSPqQDI9nfJODc1w8RoiMHH
	AqL1zoGvoiK5VXNNnjhA4xECPLUVH40=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-DFjFjMNENPaP6Ai7LODymg-1; Tue, 01 Apr 2025 04:52:21 -0400
X-MC-Unique: DFjFjMNENPaP6Ai7LODymg-1
X-Mimecast-MFC-AGG-ID: DFjFjMNENPaP6Ai7LODymg_1743497540
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e180821aso23968705e9.1
        for <bpf@vger.kernel.org>; Tue, 01 Apr 2025 01:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743497540; x=1744102340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTrzmKHOhipGTrVn6hOCwktriFPfHqZi1ySNcTDYp58=;
        b=lc/VMHnWmNiIB2WiS8cfM5Hr3fizVLR8I7k2jLpylY8ElWjdD28wTv57vZtIgoY5mo
         ep0knhKfukpcRTVCFI0j/EyeP6CC3tH6s8PV7nMqpGtXQqtTGTTlp/c+GfjIjEvdvhOE
         rSc8qqGnxZ+HG2ht5/15nAkEREwJDDGQtgmMtX3T8szv3Efpj3zOKzy19BLpPL85TTCS
         UcfBoBTK77BCUrLJd0sXoW5xgZSm45/SnW/ecOfG4LfqShN//cnQz3whytXI8FgIxWza
         RW7WPkYPQdrqb3s5aOIAl8/xTc1TfUaPu8QK/kufqJMXN2bcK/+XPkBEjyJUUKTRkA6p
         PL8A==
X-Forwarded-Encrypted: i=1; AJvYcCUPtW7D0wWyLV2smd6VXvwu41/HkXHW8Os/9ySigf5NWAkl0exWJwjs90cSgxPiCF/aGdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ13BmzRobbqKSGLDV6IemO82wRffbjl8sWipEYOQku65RQg7I
	y00CoBmGge9M4dGCWQjrcvz5NFLs/2i/izjlZXQW+ExNVftjX2tjST2XrMzBwqUHdn1DfjJKF1k
	yYmvnaVS/zfo5PHZGEdsbVEMYoidVVjC5NFkB25ZmdwbgSXew/Q==
X-Gm-Gg: ASbGncs2WyWRaPsmeYcdDMHlu+V3QyTu2yMMn9EpyC9pwfsqXj3U/wHglbbenKN1sAi
	vxcDZZB57k6cGfmSBf3Lv5zolKKUB2ZkvN0ETX+pcbyoNirmalzGLucVcddbOCp1vTzMJ4ev/tL
	Ou0t65SYzVo2y9RoPJ9xPLtFII4ulRcHgocBxFD7a6JYvYL+47G79NFhSk/w7oOLvvXe7ZGcn3J
	zuetsofRw/B8e7Zw1UjTVf2Xfsv2F0PPdnDz5rD6GzpJ4mwKNq04743Rcairh0B966JDtn5nV8P
	oL8Dn2GIE9R4U2nWaaEn9kxU2Qun0hqA8kivutriQdBEcQ==
X-Received: by 2002:a5d:6daf:0:b0:391:1222:b444 with SMTP id ffacd0b85a97d-39c120db3f4mr8036371f8f.20.1743497539706;
        Tue, 01 Apr 2025 01:52:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFIwIsFXgnFgUnvUf7GiB0Qo92O2pFQl8WkobeyI6QhVmQ5/bHplaSDVAbQLHpuaV2qU/iLQ==
X-Received: by 2002:a5d:6daf:0:b0:391:1222:b444 with SMTP id ffacd0b85a97d-39c120db3f4mr8036337f8f.20.1743497539288;
        Tue, 01 Apr 2025 01:52:19 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a4351sm13751264f8f.98.2025.04.01.01.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 01:52:18 -0700 (PDT)
Message-ID: <38b9af46-0d03-424d-8ecc-461b7daf216c@redhat.com>
Date: Tue, 1 Apr 2025 10:52:17 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>,
 Yuying Ma <yuma@redhat.com>
References: <20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com>
 <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/28/25 1:19 PM, Toke Høiland-Jørgensen wrote:
> @@ -463,13 +462,21 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
>  			      netmem_ref netmem,
>  			      u32 dma_sync_size)
>  {
> -	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
> -		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
> +	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev)) {

Lacking a READ_ONCE() here, I think it's within compiler's right do some
unexpected optimization between this read and the next one. Also it will
make the double read more explicit.

Thanks,

Paolo


