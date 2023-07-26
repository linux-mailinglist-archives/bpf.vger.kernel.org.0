Return-Path: <bpf+bounces-5934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF427634CC
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 13:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92AD1281DE9
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 11:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D719473;
	Wed, 26 Jul 2023 11:23:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0826CA51;
	Wed, 26 Jul 2023 11:23:28 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081DD1982;
	Wed, 26 Jul 2023 04:23:25 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R9s181gh0zTlsy;
	Wed, 26 Jul 2023 19:21:48 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 19:23:22 +0800
Subject: Re: [PATCH net-next v2] page_pool: split types and declarations from
 page_pool.h
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexander H Duyck
	<alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team
	<linux-imx@nxp.com>, Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad
	<hkelam@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne
 Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Kalle
 Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, <linux-rdma@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20230725131258.31306-1-linyunsheng@huawei.com>
 <94272ffed7636c4c92fcc73ccfc15236dd8e47dc.camel@gmail.com>
 <16b4ab57-dfb0-2c1d-9be1-57da30dff3c3@intel.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <22af47fe-1347-3e32-70bf-745d833e88b9@huawei.com>
Date: Wed, 26 Jul 2023 19:23:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <16b4ab57-dfb0-2c1d-9be1-57da30dff3c3@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/26 18:43, Alexander Lobakin wrote:
> From: Alexander H Duyck <alexander.duyck@gmail.com>
> Date: Tue, 25 Jul 2023 08:47:46 -0700
> 
>> On Tue, 2023-07-25 at 21:12 +0800, Yunsheng Lin wrote:
>>> Split types and pure function declarations from page_pool.h
>>> and add them in page_pool/types.h, so that C sources can
>>> include page_pool.h and headers should generally only include
>>> page_pool/types.h as suggested by jakub.
>>>
>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>>> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> [...]
> 
>>> +/* Caller must provide appropriate safe context, e.g. NAPI. */
>>> +void page_pool_update_nid(struct page_pool *pool, int new_nid);
>>> +
>>> +#endif /* _NET_PAGE_POOL_H */
>>
>>
>> This seems kind of overkill for what is needed. It seems like the
>> general thought process with splitting this was so that you had just
>> the minimum of what is needed to support skbuff.h and the functions
>> declared there. The rest of this would then be added via the .h to the
>> .c files that will actually be calling the functions.
>>
>> By that logic I think the only thing we really need is the function
>> declaration for page_pool_return_skb_page moved into skbuff.h. We could
>> then just remove page_pool.h from skbuff.h couldn't we?
> 
> This patch is not to drop page_pool.h include from skbuff.h.
> This is more future-proof (since I'm dropping this include anyway in my
> series) to have includes organized and prevent cases like that one with
> skbuff.h from happening. And to save some CPU cycles on preprocessing if
> that makes sense.

The suggestion is from below:

https://lore.kernel.org/all/20230710113841.482cbeac@kernel.org/

> 
>>
>> Another thing we could consider doing is looking at splitting things up
>> so that we had a include file in net/core/page_pool.h to handle some of
>> the cases where we are just linking the page_pool bits to other core
>> file bits such as xdp.c and skbuff.c.

I suppose the above suggestion is about splitting or naming by
the user as the discussed in the below thread?
https://lore.kernel.org/all/20230721182942.0ca57663@kernel.org/

> 
> Thanks,
> Olek
> .
> 

