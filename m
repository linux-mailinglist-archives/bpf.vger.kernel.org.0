Return-Path: <bpf+bounces-41050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6923A9916D8
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 14:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1BDAB21B99
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 12:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843E3153808;
	Sat,  5 Oct 2024 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMs35McN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982C814AD19;
	Sat,  5 Oct 2024 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728131952; cv=none; b=EGmyP0PvxhYREN5PCTFySf4mxnYslir6XbC/iO6SwJdYzy7/+VFWYmiknIBsxkbKtMVO4NrA/Lc09rkg9+UK+776fOHgN5TaVTB7XX4LCaHNu4CR1lfdtCU0ECeRZg3jSA7KltajMok1ml0ef9jshY8eLWtlQYApITWQk20MinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728131952; c=relaxed/simple;
	bh=YNm3x+D/+uR/yV1OSOY9lGo7cThaljvjLDn81E+MKfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPuvinjrVOwvi6lNfVsAKiUi4CZKoVFUQ2uiUwCsSgqHv7uxfEhCi4jd4iSA1TKuVdow4GJYC7YZQBJ1BaBmAreoScjrosYC+MF67QpEno1WGdvCluAYM+BI5HSWkA9UkAYcQgWLkIKHDLWbyUkubEnE3uUu4aA3knm6+7Y8nPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMs35McN; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7179069d029so2310698b3a.2;
        Sat, 05 Oct 2024 05:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728131950; x=1728736750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbmQWqwf8KLWBh53BpLjJjepp8M5DqLAMepSsUrr8/A=;
        b=PMs35McNWB15k7nicCSjjbeVhDSdcypBjCHkHQHnx2UOwG+/xBcGjLgjuX/4+Ty4zL
         h4zetdTGjh+NLa2Un6mS4lwD57nS7XOC2RNnmpTLax4y9jRcd3AjsUhHaiAeQNjWAvef
         1iuolrKGxvfZRQVoDsk8bRgupkmHcsCY9Vq7EolgnaTkDoiRc9Hldh2k0UunJm377tkQ
         GJny1GpMRBDO3/cafD5NEBc6Iy6MFSVTDfbqoAIm5YVroWM37ylLjwapMDCmD0xO/Luy
         AUW/K+3K+XpH0peCFGJOvexBZnGb+0Tp7BEi2BUs74HoSUg0N1pU++oxD49vzHkVmwwB
         v0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728131950; x=1728736750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbmQWqwf8KLWBh53BpLjJjepp8M5DqLAMepSsUrr8/A=;
        b=UbvxvuxZa0qsJ7Rxgkxriv65PQHnSSUkQXygfhvzHEoopJvgpWnOrv9QuqUTewCXId
         sCUvIPpTwLLGmGU7iPtOthjor6U7aOx7l+R+TzvtHkQiym0qnTXpXtCHjBvoyNb0vgeD
         Ob702YK+UBHVIPTKhcySaQrz7JpkApHjYVIg36X28SPaSK9scUUjzIQvrmO5wXzrTG2h
         S+b/QDv0MGAqR308Iu6fvJS6SMd62XSUxlmWU3Ei2Jtb/IB+gSnxlCGB8t1A+Q5KgWCE
         cb+FKp5GoxP48ox0CF/ZnkMpgWB7QScwyaUU5yE2kR8n4zinYxMlAZSaAOjwh/qWhxxy
         OVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIUht/2HdDXFoRe1cBfgjuUg4xD1tXRCQCLePozHDClZ9FR+C2/jXhurhhzZK9/TumSGChXSoR@vger.kernel.org, AJvYcCUppHcAPkCJ5LDL3dPO7SOTmoHrCQOO5Z7pWqbc6BJZpUUVyfGMSSF2ZvqesFShQXPwA88=@vger.kernel.org, AJvYcCVRM77xwL7GJ/2X39fLG9EwrwPU8ZPFAfnGUfzPrsjdZSp4ct+0HybxXBUTqf1uI5lJpHPFeSD2ceZjSg==@vger.kernel.org, AJvYcCWEMcljify8xelvcV36k/QbrQ/2vR8ZUCJ95sxJOg0K9yeHb9ZXAExO9/+nCoyQJH4uK/M28uAoGu17mmKYJBI=@vger.kernel.org, AJvYcCXKt/WP1EDjEsOIiGJPsb5IzwgUTdfAVDkD/TTZeignWw1wJPChsAw4PucIQkOBklqBPZx6tan8k5m10kx0@vger.kernel.org
X-Gm-Message-State: AOJu0YxGLJauWuWbHekKar0Ear4vjKKbtcC4ZW5j1xrP/rVhFYKD2WNc
	LGT+ajau8xji7+yNPAFrrCCxWoXe2vzz6JpjYKt8V2FHQbW5Owif
X-Google-Smtp-Source: AGHT+IH7TZfPKkqMhF7jhMgZXtf7Pauw1fuqlg17S6ZMnwvz+3KYrvO5e1eqHcfYjc/CJowJUAwQhQ==
X-Received: by 2002:a05:6a00:9a1:b0:70d:3337:7820 with SMTP id d2e1a72fcca58-71de23c72ecmr10006756b3a.8.1728131949813;
        Sat, 05 Oct 2024 05:39:09 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:3c3f:d401:ec20:dbc7? ([2409:8a55:301b:e120:3c3f:d401:ec20:dbc7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd3983sm1408702b3a.87.2024.10.05.05.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 05:39:09 -0700 (PDT)
Message-ID: <6cb0a740-f597-4a13-8fe5-43f94d222c70@gmail.com>
Date: Sat, 5 Oct 2024 20:38:51 +0800
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
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
 Andrew Morton <akpm@linux-foundation.org>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-mm@kvack.org, davem@davemloft.net, kuba@kernel.org
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com>
 <4968c2ec-5584-4a98-9782-143605117315@redhat.com>
 <33f23809-abec-4d39-ab80-839dc525a2e6@gmail.com>
 <4316fa2d-8dd8-44f2-b211-4b2ef3200d75@redhat.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <4316fa2d-8dd8-44f2-b211-4b2ef3200d75@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/2024 3:37 PM, Paolo Abeni wrote:
> Hi,
> 
> On 10/2/24 04:34, Yunsheng Lin wrote:
>> On 10/1/2024 9:32 PM, Paolo Abeni wrote:
>>> Is the problem only tied to VFs drivers? It's a pity all the page_pool
>>> users will have to pay a bill for it...
>>
>> I am afraid it is not only tied to VFs drivers, as:
>> attempting DMA unmaps after the driver has already unbound may leak
>> resources or at worst corrupt memory.
>>
>> Unloading PFs driver might cause the above problems too, I guess the
>> probability of crashing is low for the PF as PF can not be disable
>> unless it can be hot-unplug'ed, but the probability of leaking resources
>> behind the dma mapping might be similar.
> 
> Out of sheer ignorance, why/how the refcount acquired by the page pool 
> on the device does not prevent unloading?

I am not sure if I understand the reasoning behind that, but it seems
the driver unloading does not check on the refcount of the device from
the implementation of __device_release_driver().

> 
> I fear the performance impact could be very high: AFICS, if the item 
> array become fragmented, insertion will take linar time, with the quite 
> large item_count/pool size. If so, it looks like a no-go.

The last checked index is recorded in pool->item_idx, so the insertion
mostly will not take linear, unless pool->items is almost full and the
old item came back to page_pool is just checked. The thought is that if
it comes to this point, the page_pool is likely not the bottleneck
anymore, and adding infinite pool->items might not make any difference.

If the insertion does turn out to be a bottleneck, 'struct llist_head'
can be used to records the old items lockless for the freeing side, and
llist_del_all() can be used to refill the old items for the allocing
side from freeing side, which is kind of like the pool->ring and
pool->alloc used currently in page_pool. As this patchset is already
complicated, doing this makes it more complicated, I am not sure it is
worth the effort right now as benefit does not seem obvious yet.

> 
> I fear we should consider blocking the device removal until all the 
> pages are returned/unmapped ?!? (I hope that could be easier/faster)

As Ilias pointed out, blocking the device removal until all the pages
are returned/unmapped might cause infinite delay in our testing:

https://lore.kernel.org/netdev/d50ac1a9-f1e2-49ee-b89b-05dac9bc6ee1@huawei.com/

> 
> /P
> 


