Return-Path: <bpf+bounces-40666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4356198BDC7
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 15:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9061C20DF0
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859141C57B9;
	Tue,  1 Oct 2024 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSSiOv69"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EAD1C3F26
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789564; cv=none; b=PG7jBcPRwWVrjzaZ94cdpmMz9cty3e3Bz9jMZq09QdQl/E3YPQ+HjGDoUlgbcKZ/W6bQfQdZfK2pnI4RXlvtN0t/mX0VYEhMbqh/HZO7/ZXozZowjt69Ln4HPNtJTPfPVD6Xp0G3q97Nxprai5AIs4gBhzOZHryHpgCjsevpBnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789564; c=relaxed/simple;
	bh=PKF8ZVEo8AmNwMLcEwYXeCfaLkhMxlQpxXFFSPA6ZXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmI5KV8Pu2jCS+XMU5KIJl+JtIFGlzqRDXOgq4EoBD4G/Yh627x3GYqL6Xue/zN/Ejj54gg7B1U1TJbDQv2p9OLjsYKwCAAKnoJEEn1oFykdKNuaBAVEO5+allj5NlMRs0CculDmewCX+C2D2CCRFEKO21uO6bWIAKrCtEKhnZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GSSiOv69; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727789561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iojT1xfY/iXMYZ4HclXjt5wJyv9eCNn2RMRvon4kbuU=;
	b=GSSiOv69fNEJVwQ+K86InxXSXuNnKs2jBvWLFV+Ti5gJlurZKFYaUQ/SXfKUgL9gtpi0tx
	SOo9d1m91pGGgF+6dOwfB9KNX/TWKKkrA6DHWIxMiKGSTxjKO8saZ4vYORC8BbP7kSyIuX
	e9SbSCkY6I6j8CTCPMrZvnr4ipbfyM4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-83jhRMU3N3iFppyefzT7qg-1; Tue, 01 Oct 2024 09:32:40 -0400
X-MC-Unique: 83jhRMU3N3iFppyefzT7qg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42caca7215dso31498745e9.2
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 06:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789559; x=1728394359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iojT1xfY/iXMYZ4HclXjt5wJyv9eCNn2RMRvon4kbuU=;
        b=aavAhDwqr0gKt/RFACFBOAOAIi2aza2pT5XyJC04TUzcmwJm7vsn+TUyKaty8HGXSz
         YL2NUNqjzRhluaeWs14DTXzg4IFdaPRtn6DwOlQ8KgOIV1W/QPJ/HWyzVFKzYVExZ1j2
         PmtOPIC0ZHLLghrBQK55SMsCtzFK+lKl5R+5qSqZZtVdsSpj3mfoDYKqU9bZXiNhUtUm
         dGDkWXudqMULTyOZ2Vefx5bxTeyi6f8vOVCydPw6xWVZwvH4xuC5HjbLMyfeqLpfwlCE
         0oqcbWozSTmTKQ+aweZZp4T1DZopZIOWxjF94heaSWcbUXcEt8pXhl+GI3KmTHg3EmTY
         2TDw==
X-Forwarded-Encrypted: i=1; AJvYcCXdonTyoNLNYRIeWfZFQ4XImO8iuIMNbvxQV5XkMsaFBeZX2fsR0S054Zwp7O0XWwIB8B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbspA/qmjAevT5nigX8LlUOVtyGRtS1+EAvXlGqATbkM98z9PE
	kBuVwNwEbbrg3UiLV05TmyqWMa3TwChcw/ztBQ95bj+w3w40ETlxhntpD5OhA5/cnIS5ZH9smmN
	Ko0W7ImF0Z1yhf8lC3EYHX8sVFcEKOPsoXpg+fnjSej/CEubAUw==
X-Received: by 2002:a05:600c:a02:b0:426:66e9:b844 with SMTP id 5b1f17b1804b1-42f584339aemr130160625e9.8.1727789559123;
        Tue, 01 Oct 2024 06:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDiutjjZjFmvjKmZCcGrKni3t0abnQlYsETvEbcK9G6gugyRexKg3WBxo9lrKH5Dul5fJhqA==
X-Received: by 2002:a05:600c:a02:b0:426:66e9:b844 with SMTP id 5b1f17b1804b1-42f584339aemr130159935e9.8.1727789558576;
        Tue, 01 Oct 2024 06:32:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b088:b810::f71? ([2a0d:3341:b088:b810::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e13a1dsm136324005e9.32.2024.10.01.06.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 06:32:37 -0700 (PDT)
Message-ID: <4968c2ec-5584-4a98-9782-143605117315@redhat.com>
Date: Tue, 1 Oct 2024 15:32:34 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-mm@kvack.org
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240925075707.3970187-3-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/24 09:57, Yunsheng Lin wrote:
> Networking driver with page_pool support may hand over page
> still with dma mapping to network stack and try to reuse that
> page after network stack is done with it and passes it back
> to page_pool to avoid the penalty of dma mapping/unmapping.
> With all the caching in the network stack, some pages may be
> held in the network stack without returning to the page_pool
> soon enough, and with VF disable causing the driver unbound,
> the page_pool does not stop the driver from doing it's
> unbounding work, instead page_pool uses workqueue to check
> if there is some pages coming back from the network stack
> periodically, if there is any, it will do the dma unmmapping
> related cleanup work.
> 
> As mentioned in [1], attempting DMA unmaps after the driver
> has already unbound may leak resources or at worst corrupt
> memory. Fundamentally, the page pool code cannot allow DMA
> mappings to outlive the driver they belong to.
> 
> Currently it seems there are at least two cases that the page
> is not released fast enough causing dma unmmapping done after
> driver has already unbound:
> 1. ipv4 packet defragmentation timeout: this seems to cause
>     delay up to 30 secs.
> 2. skb_defer_free_flush(): this may cause infinite delay if
>     there is no triggering for net_rx_action().
> 
> In order not to do the dma unmmapping after driver has already
> unbound and stall the unloading of the networking driver, add
> the pool->items array to record all the pages including the ones
> which are handed over to network stack, so the page_pool can
> do the dma unmmapping for those pages when page_pool_destroy()
> is called. As the pool->items need to be large enough to avoid
> performance degradation, add a 'item_full' stat to indicate the
> allocation failure due to unavailability of pool->items.

This looks really invasive, with room for potentially large performance 
regressions or worse. At very least it does not look suitable for net.

Is the problem only tied to VFs drivers? It's a pity all the page_pool 
users will have to pay a bill for it...

/P


