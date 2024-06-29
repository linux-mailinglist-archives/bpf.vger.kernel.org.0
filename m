Return-Path: <bpf+bounces-33426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1618E91CC4F
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 13:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80F44B21D26
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 11:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDF648CDD;
	Sat, 29 Jun 2024 11:14:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE1C3BB48;
	Sat, 29 Jun 2024 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719659697; cv=none; b=aRQ7X+6aMyGMMWoqgW7aT/s4h5eJXcad9yfDF0HDgMnv3JYoczIg7n3rQF5FLuUr6yD6AXFrnauvg8WviRiVN+iMFPbqljbXKXt3JkcLMN9LTY48cCWQVIeQSb3e21WCSES02ilvGvBrtyJH6H2g7aVQ1L6y0C9RjUddxFUEl+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719659697; c=relaxed/simple;
	bh=62bAkqIehipr1X91QN/MFk4qOyksoC2yLlYJ7VsEHgQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dMentAQSysAHb9BAaUd0M4nnXh7NcPh9N/yfafEDf68PeKEJeyflJ2LMKAZy94al1eRzBc53XPSDUvxOsP7/1Mg3GIj+ZBrderWLwCEetm49+Wqw+gIklbHQDAvg+yyNbNZEBEyjiILg2m6EiYt1w4L1SRrziLB0QSDnJj//8k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WB8jW1PQlz1T4NC;
	Sat, 29 Jun 2024 19:10:23 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 46160180089;
	Sat, 29 Jun 2024 19:14:51 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 29 Jun
 2024 19:14:51 +0800
Subject: Re: [PATCH net-next v9 00/13] First try to replace page_frag with
 page_frag_cache
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <d2601a34-7519-41b6-89c6-b4aad483602b@lunn.ch>
 <a051a277-a901-2cdb-72d0-716002593019@huawei.com>
 <20240627125834.3007120c@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <b200a609-2f30-ec37-39b6-f37ed8092f41@huawei.com>
Date: Sat, 29 Jun 2024 19:14:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627125834.3007120c@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/6/28 3:58, Jakub Kicinski wrote:
> On Thu, 27 Jun 2024 19:16:22 +0800 Yunsheng Lin wrote:
>> On 2024/6/27 1:12, Andrew Lunn wrote:
>>> Silly nitpick, but maybe for the next version you change the Subject:
>>> to Tenth try to replace page_frag with page_frag.... :-)  
>>
>> Yes, it is somewhat confusing for the 'First try' part.
>> I guess I can change it to highlight the effort and commitment behind
>> the trying:-)
> 
> Sorry to ruin the slightly whimsical mood but if you do change it -
> please don't include the version at all. Some automation matches
> versions of patch sets together based on the title of the cover letter.

Ok, perhaps it is more appropriate to change it to something like below:

Replace page_frag with page_frag_cache for sk_page_frag()

As this patchset is large enough that replacing is only done
for sk_page_frag(), there are still other places using page_frag that
can be replaced by page_frag_cache.

> .
> 

