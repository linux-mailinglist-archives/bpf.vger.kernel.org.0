Return-Path: <bpf+bounces-48234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBCAA05706
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 10:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D3F161E96
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 09:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40DD1F5404;
	Wed,  8 Jan 2025 09:38:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA019F42C;
	Wed,  8 Jan 2025 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329081; cv=none; b=XQd+hKt60fVxUWHKVhzpLJ6RpZMsM3HDI03fNPrfLqr39c+yrZOMYGhDToTEnASK824fcBmZBCRtYxSC1/LRrSnbgYg9rsf1pvgVJyMQZcZ36YKpqjfo0/Xm0USHYhEdYcFjk2O3M13rHsCnYw6ME2+YgrpXQFv/btjCATp1oEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329081; c=relaxed/simple;
	bh=fV3g+YF8NI3cRH3DfRWU4swOQF7pcduVSxTH7G0FkWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dk5Hy4l+8ZvhFy1sOkQ+28EPUjeyE14P3nux8LfrPjD1FmE5yYNMKx0lRI7Xrqfjh07l+naZWQWITPRtH6PSxL3rAP/sBrhL5R+sv27Qo3MZPBX10aK31K9japV8S+O8TiFyY+MMUREhU2mRwBFEjBAekOr9gYGS56S05fKrMeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YSjRV6mV3z1W3jT;
	Wed,  8 Jan 2025 17:34:14 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A9BDB14035E;
	Wed,  8 Jan 2025 17:37:56 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 8 Jan 2025 17:37:55 +0800
Message-ID: <f86d3fe9-f508-4463-8587-b001979d70c4@huawei.com>
Date: Wed, 8 Jan 2025 17:37:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/8] page_pool: introduce page_pool_get_pp()
 API
To: Jesper Dangaard Brouer <hawk@kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Jeroen de Borst
	<jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau
	<nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee
	<ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, Sean Wang
	<sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Simon Horman <horms@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, <imx@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20250106130116.457938-1-linyunsheng@huawei.com>
 <20250106130116.457938-2-linyunsheng@huawei.com>
 <02896f96-57dd-47d5-8fa0-8a8aed30fa9a@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <02896f96-57dd-47d5-8fa0-8a8aed30fa9a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/1/7 22:52, Jesper Dangaard Brouer wrote:
> 
> On 06/01/2025 14.01, Yunsheng Lin wrote:
>> introduce page_pool_get_pp() API to avoid caller accessing
>> page->pp directly.
>>
> [...]
> 
>> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
>> index 543f54fa3020..9c4dbd2289b1 100644
>> --- a/include/net/page_pool/helpers.h
>> +++ b/include/net/page_pool/helpers.h
>> @@ -83,6 +83,11 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
>>   }
>>   #endif
>>   +static inline struct page_pool *page_pool_get_pp(struct page *page)
>> +{
>> +    return page->pp;
>> +}
> 
> IMHO the function name "page_pool_get_pp" is problematic. As calling it "get" indicate to me that we are taking some reference on the pp object. Is this you plan in later patches?

No, this patchset is not going to taking some reference on the pp object.

> 
> If it is simply a dereference of page->pp ... then we could call it page2pp ?

Before this version page_pool_to_pp() is used, this version renamed it to
page_pool_get_pp() as there is an exising netmem_get_pp() in patch 3, which
is also simply a dereference of netmem->pp, using page_pool_to_pp() does not
seem consistent with netmem from API naming point.

> ... but I'm uncertain why we need this change.

This patch is added to make patch 3 more reviewable as page->pp is renamed to
page->pp_item in patch 3. If there is no helper added in this patch, patch 3
might need to touch all the places touched in this patch too.

> 
> --Jesper
> 

