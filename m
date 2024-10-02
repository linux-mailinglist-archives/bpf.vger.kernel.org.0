Return-Path: <bpf+bounces-40732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFBD98CB4D
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 04:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE4F1C221BF
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 02:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D274AD528;
	Wed,  2 Oct 2024 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7Ed9voh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F32FBF6;
	Wed,  2 Oct 2024 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727836489; cv=none; b=VtSusgCH14xuyHcubceFWqhJa5D6jhqxT0iwFC/Y3/UwGnK2AnioHj3VSfbnVU53z9ckfyCdBWzP3yzXlCBKhcZngBNhBrlM2sALQQf/D8bu9t/7FdZrS/8wtJRV2CGyCIKcD3zP/66OrC6VneHnkxkcJECYokxbbP942Q7YyJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727836489; c=relaxed/simple;
	bh=BRm05lZZpfny2NmS9iQrsoYuXNvYjRIeUaz9a8bHb+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRKS4dP20ulJgl1Kj4pnlgp0wJEhlJtwHb9VnkGKDyw7HdlG4SAUF+TOC9N0IWKG4MwIKXhbVkTIRrwq+LtsEEw0unJgCkPyX1Ozv45XE8GMSsKAwQkf7zuHjxvYwwOXLg9XB3n+jIqER+fxxFnJL+AihMOKKjWbG5ct5hDtZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7Ed9voh; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20b833f9b35so25989865ad.2;
        Tue, 01 Oct 2024 19:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727836487; x=1728441287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94naYpv079to4aDULVCz9OCsch+/fu1zXqCOaX8AqZQ=;
        b=W7Ed9vohBJG/6Bj1KVd2iqrN7s0mgn6ckeCFNSe7tG7wVmXhtnCxxxdkcgkR9KElMB
         id4VqA8q675iiBv5BMePqTYb+W1qsfUxWD0LpJLIFOlx9ebAC3xwHsikc9C+YoaF3U8W
         gjXoy0s7z8mCuG+j3FX8efQnDJDa1KlbuiLjorAV68Xzot8xyHXoG+OweD+ExK60sFJ4
         98lcdP9BX2Fnr2GOmI/9suQELefErXhOnzc5UNpFtPQkNx+JyhXtOM6tKOcLhNa6iuW4
         NYpu/j6xx5PSpA4lNL7rmvHGlENhoEZPcI1cjNKbA8W2ITwhf7gHLYbkh3vsgZok4Mzf
         iDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727836487; x=1728441287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94naYpv079to4aDULVCz9OCsch+/fu1zXqCOaX8AqZQ=;
        b=sWnv78zvWZ083qIA5ACqzEjOtNn7DHdAaItk0ecCIh4sxmZEzlT783GcYBZjOatFhA
         bTCIxG9DdRgPMBUNzKXrIn47x5ewx0JewJBk3qH6bw0J9lYeZ310+qaOfLzqD16A22cO
         3sTgLgtf2O5u3L3tUM970TPCismr9mDtZfDK9+NzZIUGe8heCc4QfBUmAF1mlwvFGgVa
         YEh6B7YLGdUo86hsQbCvPyKjpGjo5I07PbhILNHRK4bCsn5RI+na/SD8I0r5B+QiFGMQ
         +QAwwPo7uVg7lx1NgqiDHO07X3m/2RumcaQs95R1CAEAoXJXdIxCp5jnNzCewc3ol1SM
         D9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPrqyk7f/aAIFrrvpki77+qaueSzr8SE2jyBxp0hbBKvdN4a46JjkrytoMb+5+WGA4uGag22GDCOEwvA==@vger.kernel.org, AJvYcCUZjg0GZ24vDxMijDLRRU7jh8teamdEzhNq3SSf21JABYfLNCzsib0ezl+ihewNSrzUJ6oVn0lFQDuIdAmV@vger.kernel.org, AJvYcCUrwmr2LoAzY2vU2A2+HHGsBSysMR2Gg/BSlJgdTY4oLLLiNV4rcBWXm94UoCZr5octF/y9C83Ngv7XmPBtRIU=@vger.kernel.org, AJvYcCVe7ajwKdXNsq5ltiM7K217B+Uwirc3byLlWew08/RI6r9L4TXX/YI/w6fCeaWMHq4gIx8=@vger.kernel.org, AJvYcCXfjfdO24gflsXeX8/LXkm46shoSFQWQQPvpKKea+sMeqyytN8GHggl2tcZwalbDIO5aO2rCP0x@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyd0bk0SEipXGvWtY2TDiKtpSBJpLSTxw4OsWi/GdqF1tdOGeQ
	lnhHZTXmk0pQgBhEUYS7012ZtlyWIfNZAEF5zXpen0ASybfezyzB
X-Google-Smtp-Source: AGHT+IF9UFJBsbcmQi++iX6HKeBG+ku6eNZRFQc3F4zkIg3OMASXuELxeSEfBVyfvWUc3NyPSynvqg==
X-Received: by 2002:a17:902:e844:b0:20b:b132:4df9 with SMTP id d9443c01a7336-20bc5a01fa5mr17029495ad.34.1727836487138;
        Tue, 01 Oct 2024 19:34:47 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:50d1:daaf:4d8b:70e8? ([2409:8a55:301b:e120:50d1:daaf:4d8b:70e8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b5b167128sm58750135ad.283.2024.10.01.19.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 19:34:46 -0700 (PDT)
Message-ID: <33f23809-abec-4d39-ab80-839dc525a2e6@gmail.com>
Date: Wed, 2 Oct 2024 10:34:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Paolo Abeni <pabeni@redhat.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 davem@davemloft.net, kuba@kernel.org
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
 <4968c2ec-5584-4a98-9782-143605117315@redhat.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <4968c2ec-5584-4a98-9782-143605117315@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/1/2024 9:32 PM, Paolo Abeni wrote:
> On 9/25/24 09:57, Yunsheng Lin wrote:
>> Networking driver with page_pool support may hand over page
>> still with dma mapping to network stack and try to reuse that
>> page after network stack is done with it and passes it back
>> to page_pool to avoid the penalty of dma mapping/unmapping.
>> With all the caching in the network stack, some pages may be
>> held in the network stack without returning to the page_pool
>> soon enough, and with VF disable causing the driver unbound,
>> the page_pool does not stop the driver from doing it's
>> unbounding work, instead page_pool uses workqueue to check
>> if there is some pages coming back from the network stack
>> periodically, if there is any, it will do the dma unmmapping
>> related cleanup work.
>>
>> As mentioned in [1], attempting DMA unmaps after the driver
>> has already unbound may leak resources or at worst corrupt
>> memory. Fundamentally, the page pool code cannot allow DMA
>> mappings to outlive the driver they belong to.
>>
>> Currently it seems there are at least two cases that the page
>> is not released fast enough causing dma unmmapping done after
>> driver has already unbound:
>> 1. ipv4 packet defragmentation timeout: this seems to cause
>>     delay up to 30 secs.
>> 2. skb_defer_free_flush(): this may cause infinite delay if
>>     there is no triggering for net_rx_action().
>>
>> In order not to do the dma unmmapping after driver has already
>> unbound and stall the unloading of the networking driver, add
>> the pool->items array to record all the pages including the ones
>> which are handed over to network stack, so the page_pool can
>> do the dma unmmapping for those pages when page_pool_destroy()
>> is called. As the pool->items need to be large enough to avoid
>> performance degradation, add a 'item_full' stat to indicate the
>> allocation failure due to unavailability of pool->items.
> 
> This looks really invasive, with room for potentially large performance 
> regressions or worse. At very least it does not look suitable for net.

I am open to targetting this to net-next, it can be backported when some
testing is done through one or two kernel versions and there is still
some interest to backport it too.

Or if there is some non-invasive way to fix this.

> 
> Is the problem only tied to VFs drivers? It's a pity all the page_pool 
> users will have to pay a bill for it...

I am afraid it is not only tied to VFs drivers, as:
attempting DMA unmaps after the driver has already unbound may leak
resources or at worst corrupt memory.

Unloading PFs driver might cause the above problems too, I guess the
probability of crashing is low for the PF as PF can not be disable
unless it can be hot-unplug'ed, but the probability of leaking resources
behind the dma mapping might be similar.

> 
> /P
> 
> 


