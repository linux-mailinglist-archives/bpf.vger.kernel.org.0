Return-Path: <bpf+bounces-33154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 488169180C5
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 14:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2701B210B5
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 12:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091A1181B91;
	Wed, 26 Jun 2024 12:16:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A3C180A9F;
	Wed, 26 Jun 2024 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404203; cv=none; b=BsS+H0hJEpDyIGwc4T/2Mlx+XyAW8G9+1t48u9pW0NXse0112SSRIxI9xs6FrO5PPulOynd82U/0RfXpAFPtZVJOLpFv5vgZsGKgrdcAyQ5TBIJ8VC+KIttB/MZVU1Rk53pxUFjTwtKf497hXtXWuGhs3hAb7zXw52vnBemOVTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404203; c=relaxed/simple;
	bh=4DszoVEDIpfg/zVHuUM0BCgw6hDTH3itrr355aASaOY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=f6rAYv/VgzpC7GzCH7Hh1eRWd2kt9xpLhayvILNeOmuTamDMwPr1V2AvNdRVjy6oBK2/KJJd7fnYpRxcuPu81hCO2lloF9DtNB6TDX/1QB1CH2R/ZbfnQgltlIT+ntVCTqdH+laBD3zL2maAiP+/nH4Rhn/jb2FQrGJsdhrGwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W8LDD4WfdzZcJ1;
	Wed, 26 Jun 2024 20:12:12 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 03721180086;
	Wed, 26 Jun 2024 20:16:37 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Jun
 2024 20:16:36 +0800
Subject: Re: [PATCH net-next v9 00/13] First try to replace page_frag with
 page_frag_cache
To: Alexander Duyck <alexander.duyck@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625162700.56587db3@kernel.org>
 <CAKgT0Ud1g+KF4JA51n-wnxFNLW5nNkAx4s=Wm+kd+2og7Nx4MA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <3101f982-f520-ec00-b0ef-d558f208d9a0@huawei.com>
Date: Wed, 26 Jun 2024 20:16:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ud1g+KF4JA51n-wnxFNLW5nNkAx4s=Wm+kd+2og7Nx4MA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/6/26 7:41, Alexander Duyck wrote:
> On Tue, Jun 25, 2024 at 4:27 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Tue, 25 Jun 2024 21:52:03 +0800 Yunsheng Lin wrote:
>>> V9:
>>>    1. Add check for test_alloc_len and change perm of module_param()
>>>       to 0 as Wang Wei' comment.
>>>    2. Rebased on latest net-next.
>>
>> Please do not post a new version until you get feedback from Alex
>> on the previous one. This series consumes all our CI resources,
>> we can't get important patches tested :|
> 
> Sorry, I didn't realize this patch set was waiting on feedback from
> me. I will try to get to it as time permits. Maybe a day or two as I
> have been swamped this week with various fbnic related items.

Ok, it would be good to have some feedback from you, thanks.

> 
> Thanks,
> 
> - Alex
> .
> 

