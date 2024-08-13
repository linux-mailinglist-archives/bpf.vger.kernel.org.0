Return-Path: <bpf+bounces-37014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0E295039B
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 13:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB202851D3
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22611990D2;
	Tue, 13 Aug 2024 11:30:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD643190470;
	Tue, 13 Aug 2024 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548611; cv=none; b=h8evIHU6J7XIIyEAZEYxP9oURsftFDiW+8g+2Y8MGJK+JuDxJmh12aHCGQ4+WMf1d8gIDtjZTZdn38GThYxs8ntomF9SR9f6WHxJFnY5PTvXsOCbkK/a2MJ4GX7o0Nv3uqChYWNzgVe71k+lXXssePELoiqnFv3iV7YKkRURbc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548611; c=relaxed/simple;
	bh=r/2AEoj8adaNFww4tePMwm3iY8aha/Lh2iH3JiqZq9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KdIVcxPRdD/kRCuNBXIgo9cJXf/cv0MZKztFovjiEQYAMWn0byLdYPLVHRk54KezV6UognvM78658heW4Nu0SDIKWQ3y7b10c9/tcnfHP1AgybbIkSLzgT0klYeazyQX9GJ+aAIZSShZr6WnKIhS222ExHc/asq+2bYmosvY960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wjq0x5k9pz1T78J;
	Tue, 13 Aug 2024 19:29:37 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A8EAE180087;
	Tue, 13 Aug 2024 19:30:05 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 13 Aug 2024 19:30:05 +0800
Message-ID: <4aba9fae-563d-4a4e-8336-44e24551d9f9@huawei.com>
Date: Tue, 13 Aug 2024 19:30:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 00/14] Replace page_frag with page_frag_cache
 for sk_page_frag()
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>, Alexander
 Duyck <alexander.duyck@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20240808123714.462740-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/8 20:37, Yunsheng Lin wrote:

...

> 
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> 
> 1. https://lore.kernel.org/all/20240228093013.8263-1-linyunsheng@huawei.com/
> 
> Change log:
> V13:
>    1. Move page_frag_test from mm/ to tools/testing/selftest/mm
>    2. Use ptr_ring to replace ptr_pool for page_frag_test.c
>    3. Retest based on the new testing ko, which shows a big different
>       result than using ptr_pool.

Hi, Davem & Jakub & Paolo
    It seems the state of this patchset is changed to 'Deferred' in the
patchwork, as the info regarding the state in 'Documentation/process/
maintainer-netdev.rst':

Deferred           patch needs to be reposted later, usually due to dependency
                   or because it was posted for a closed tree

Obviously it was not the a closed tree reason here, I guess it was the dependency
reason casuing the 'Deferred' here? I am not sure if I understand what sort of
dependency this patchset is running into? It would be good to mention what need
to be done avoid the kind of dependency too.


Hi, Alexander
    The v13 mainly address your comments about the page_fage_test module.
It seems the your main comment about this patchset is about the new API
naming now, and it seems there was no feedback in previous version for
about a week:

https://lore.kernel.org/all/ca6be29e-ab53-4673-9624-90d41616a154@huawei.com/

If there is still disagreement about the new API naming or other things, it
would be good to continue the discussion, so that we can have better
understanding of each other's main concern and better idea might come up too,
like the discussion about new layout for 'struct page_frag_cache' and the
new refactoring in patch 8.

> 


