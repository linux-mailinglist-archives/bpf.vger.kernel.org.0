Return-Path: <bpf+bounces-37173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117E7951A69
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 13:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8729EB21C9E
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 11:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA141AC44E;
	Wed, 14 Aug 2024 11:55:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2F33D8;
	Wed, 14 Aug 2024 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723636518; cv=none; b=q7qOf9nexA0GX5Eta1lCdhEJR+I5/YwinvkHUdXbuB44Yx1M6wf9Q/vmGpnXaImvusBIBXHx9T9PK41ZF55rh1oa35wlwNYM/M63kuq6qEFBBluLzQbSd6tAWFUNyL8A97Kg6UH8qwTgCbQ0jpnI+mOv8PjsKq/OGKD2ER4hcrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723636518; c=relaxed/simple;
	bh=VCi9tNsc5VuFyVQbvBISWKlHjyhF2EFFoW2acglhie0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z7GiN/S+rhQ2tCxAogLITO6yZn7djs8/I0XUT0zO+lowrTrkauy6ccMWgFL8UQ8DsznEw0h4ty0mQx23tS4PTjFDQ0cewkIhJMoUijyPX3AyuAI3da3y1qrq1fl/NCKM/1ztJdhYAucFnS6e7AKpe44F5rlYJrILGpckCnwe5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WkRQH04FVz2CmlL;
	Wed, 14 Aug 2024 19:50:15 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 13E4F180019;
	Wed, 14 Aug 2024 19:55:07 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 14 Aug 2024 19:55:06 +0800
Message-ID: <302315e8-9c0d-433a-a6fd-24b46645179e@huawei.com>
Date: Wed, 14 Aug 2024 19:55:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 00/14] Replace page_frag with page_frag_cache
 for sk_page_frag()
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <4aba9fae-563d-4a4e-8336-44e24551d9f9@huawei.com>
 <CAKgT0UezjgRX9QUWkee_p8KVQQa1va12k2CaGJeOYrr5LGg4YQ@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UezjgRX9QUWkee_p8KVQQa1va12k2CaGJeOYrr5LGg4YQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/13 23:11, Alexander Duyck wrote:
> On Tue, Aug 13, 2024 at 4:30 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/8/8 20:37, Yunsheng Lin wrote:
>>
>> ...
>>
>>>
>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>>>
>>> 1. https://lore.kernel.org/all/20240228093013.8263-1-linyunsheng@huawei.com/
>>>
>>> Change log:
>>> V13:
>>>    1. Move page_frag_test from mm/ to tools/testing/selftest/mm
>>>    2. Use ptr_ring to replace ptr_pool for page_frag_test.c
>>>    3. Retest based on the new testing ko, which shows a big different
>>>       result than using ptr_pool.
>>
>> Hi, Davem & Jakub & Paolo
>>     It seems the state of this patchset is changed to 'Deferred' in the
>> patchwork, as the info regarding the state in 'Documentation/process/
>> maintainer-netdev.rst':
>>
>> Deferred           patch needs to be reposted later, usually due to dependency
>>                    or because it was posted for a closed tree
>>
>> Obviously it was not the a closed tree reason here, I guess it was the dependency
>> reason casuing the 'Deferred' here? I am not sure if I understand what sort of
>> dependency this patchset is running into? It would be good to mention what need
>> to be done avoid the kind of dependency too.
>>
>>
>> Hi, Alexander
>>     The v13 mainly address your comments about the page_fage_test module.
>> It seems the your main comment about this patchset is about the new API
>> naming now, and it seems there was no feedback in previous version for
>> about a week:
>>
>> https://lore.kernel.org/all/ca6be29e-ab53-4673-9624-90d41616a154@huawei.com/
>>
>> If there is still disagreement about the new API naming or other things, it
>> would be good to continue the discussion, so that we can have better
>> understanding of each other's main concern and better idea might come up too,
>> like the discussion about new layout for 'struct page_frag_cache' and the
>> new refactoring in patch 8.
> 
> Sorry for not getting to this sooner. I have been travelling for the
> last week and a half. I just got home on Sunday and I am suffering
> from a pretty bad bout of jet lag as I am overcoming a 12.5 hour time
> change. The earliest I can probably get to this for review would be
> tomorrow morning (8/14 in the AM PDT) as my calendar has me fully
> booked with meetings most of today.

Thanks for the clarifying.
Appreciating for the time and effort of reviewing.

