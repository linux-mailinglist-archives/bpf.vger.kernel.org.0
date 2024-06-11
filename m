Return-Path: <bpf+bounces-31835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6279A903C7D
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 14:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E081F23BF4
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 12:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB95C17C7AD;
	Tue, 11 Jun 2024 12:55:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B5B17C213;
	Tue, 11 Jun 2024 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110509; cv=none; b=pAu9hPpfZW7VPLruqOjO2cFL+qxlACPjG/SU8p4NCFfDNNsT6KG2ndG+Dla2acVIlGYx2vo+03y+JZgWwhxXfhIqu14xmkQ1ZxBDrFgsrz+zFq1TkMaxjs5EnY9DQ5oCm+qXrrXrJeMNZJHi7miE0G9Na3pi07cuLjhbRV2iCk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110509; c=relaxed/simple;
	bh=eYrvKMxUbrYpLpniWRPV/2AluAC4D7yDbMQ8qAp2zYI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ke1SAR8d27wENgp0422MPOC4hsNrXNkTY/Un3GN5OpvcdyY07IZkgj8XkyI/qOgaAF7uxwe4y9Cm5GJGkXi3i1b2YwVv5mrKp100SJyVrJUyMtwvUgDC+DkvYa1Wsjght8H6IAyz8VvigJhlJq594ZjdEkTZRBinPpMIfY2wP6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Vz7n82Tb6zmZD4;
	Tue, 11 Jun 2024 20:50:20 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C5926140156;
	Tue, 11 Jun 2024 20:55:02 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Jun
 2024 20:55:02 +0800
Subject: Re: [PATCH net-next v7 00/15] First try to replace page_frag with
 page_frag_cache
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>, Alexander
 Duyck <alexander.duyck@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20240607123819.40694-1-linyunsheng@huawei.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <e9b01c2c-5dbb-0c43-49bc-10d31545acda@huawei.com>
Date: Tue, 11 Jun 2024 20:55:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240607123819.40694-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)


On 2024/6/7 20:38, Yunsheng Lin wrote:

...

> 
> CC: Alexander Duyck <alexander.duyck@gmail.com>

Hi, Alexander & Networking Maintainers
   Any suggestion or comment about this version?
   Thanks.

> 
> 1. https://lore.kernel.org/all/20240228093013.8263-1-linyunsheng@huawei.com/
> 
> Change log:
> V7: Fix doc build warning and error.
> 
> V6:
>    1. Fix some typo and compiler error for x86 pointed out by Jakub and
>       Simon.
>    2. Add two refactoring and optimization patches.
> 
> V5:
>    1. Add page_frag_alloc_pg() API for tls_device.c case and refactor
>       some implementation, update kernel bin size changing as bin size
>       is increased after that.
>    2. Add ack from Mat.
> 
> RFC v4:
>    1. Update doc according to Randy and Mat's suggestion.
>    2. Change probe API to "probe" for a specific amount  of available space,
>       rather than "nonzero" space according to Mat's suggestion.
>    3. Retest and update the test result.
> 
> v3:
>    1. Use new layout for 'struct page_frag_cache' as the discussion
>       with Alexander and other sugeestions from Alexander.
>    2. Add probe API to address Mat' comment about mptcp use case.
>    3. Some doc updating according to Bagas' suggestion.
> 
> v2:
>    1. reorder test module to patch 1.
>    2. split doc and maintainer updating to two patches.
>    3. refactor the page_frag before moving.
>    4. fix a type and 'static' warning in test module.
>    5. add a patch for xtensa arch to enable using get_order() in
>       BUILD_BUG_ON().
>    6. Add test case and performance data for the socket code.
> 
> 


