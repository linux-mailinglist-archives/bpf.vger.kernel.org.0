Return-Path: <bpf+bounces-47692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713C39FE4BC
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 10:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF2D3A16C4
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 09:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B666B1A254C;
	Mon, 30 Dec 2024 09:15:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA1215B984;
	Mon, 30 Dec 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735550125; cv=none; b=JPRXE0O+Wrnj1SL8XJbtkOJVarKWhrvhgNMt85ClVCtcchsIfFTEYMfw/xmhPwFATpaF5O4k6hqkjeQLRyNnWNGTXFkhBvzXLaoxB56XtMSfRlO/WM7Miqtc2oTszrkgMecnOw3qcNBe1m/TRlJevTOInv4AAYjN79sAClicq6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735550125; c=relaxed/simple;
	bh=mW34OzIcEipYpv+1fB0287jMNmYeJfn2mFWjcuu4MOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T4xPu9wJjcHS3JatKo3FyDsOrjtotusBS8VEhXlCS+GioRC3jJ0cGd7aPMaviPTyipbVQ6fGg8iuhR3whA4D619Kp0IoUug/lu5NKXyGvQEWl+9oPdZ7cO8lCaGtcqgXhrGjony2fgpCx5v8JY+rNQoCbA2eECeHdnCJM7JUI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YM9R84Z9Wz1JGfM;
	Mon, 30 Dec 2024 17:14:44 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 326781A0188;
	Mon, 30 Dec 2024 17:15:20 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Dec 2024 17:15:19 +0800
Message-ID: <354e423e-1111-43d5-accd-17a099690369@huawei.com>
Date: Mon, 30 Dec 2024 17:15:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv5 1/8] page_pool: introduce page_pool_to_pp() API
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<somnath.kotur@broadcom.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
	<edumazet@google.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Kalle Valo
	<kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Simon
 Horman <horms@kernel.org>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<bpf@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
References: <20241213122739.4050137-1-linyunsheng@huawei.com>
 <20241213122739.4050137-2-linyunsheng@huawei.com>
 <CAC_iWj+3Q7CAS3xH9+zWA7nXdFNSJ-XMKQB3ZT0YvUQ-Q2gMCQ@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAC_iWj+3Q7CAS3xH9+zWA7nXdFNSJ-XMKQB3ZT0YvUQ-Q2gMCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/12/20 20:29, Ilias Apalodimas wrote:
> Hi Yunsheng,
> 
> On Fri, 13 Dec 2024 at 14:35, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> introduce page_pool_to_pp() API to avoid caller accessing
>> page->pp directly.
>>
> 
> I think we already have way too many abstractions, I'd say we need
> less not more. I don't know what others think, but I don't see what we
> gain from this

I am not sure how it is related to 'abstraction' here.
Either we don't allow drivers accessing the page->pp directly, otherwise
it seems better to provide a proper API for that as my understanding as it
seems better not to mess with internal detail of page_pool.

> 
> Thanks
> /Ilias

