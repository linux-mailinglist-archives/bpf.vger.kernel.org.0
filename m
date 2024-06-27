Return-Path: <bpf+bounces-33253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D4691A4DA
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 13:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFCB1F21D45
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 11:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FE6148833;
	Thu, 27 Jun 2024 11:16:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A82D7B8;
	Thu, 27 Jun 2024 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486988; cv=none; b=WlxTiv75JrzaER87SrgKYFjVI8u8Dv+q5O8WGWXZ2pfSUUB8DsfUEOdXk7NAJIsXZFtqeVgADTC0l4ToXLEoLBicVfaF9wx2Pevz77Cn1VBMueHtyx+lsQWeo/FAXybiJxqdEqm+mA0mMPxarlVFYrZ5xGKychSD5E2Kf2gH42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486988; c=relaxed/simple;
	bh=pMHGxf/PL51qw2MfQE3siIsDZW3Ft6ZMS5bJo/0MHmw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ia6O2SybR7tByOMXKrcq4sIup/rhm0fN6FoaPjsBF2rCGtKm6RSTHZK2wfMVUPhMfFUspKYCr4oKNmD7cGHTSBjsbDzGVhLm3Na74Psls2LtxgvQPSvlVM8KwVpH+HPdB0i+BQWy+IAHBN2M46hjqxzKW3L7fU3epx79VkHPC1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W8wrF4rhxzZgZ7;
	Thu, 27 Jun 2024 19:11:57 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F53218006E;
	Thu, 27 Jun 2024 19:16:23 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 27 Jun
 2024 19:16:23 +0800
Subject: Re: [PATCH net-next v9 00/13] First try to replace page_frag with
 page_frag_cache
To: Andrew Lunn <andrew@lunn.ch>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <d2601a34-7519-41b6-89c6-b4aad483602b@lunn.ch>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <a051a277-a901-2cdb-72d0-716002593019@huawei.com>
Date: Thu, 27 Jun 2024 19:16:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d2601a34-7519-41b6-89c6-b4aad483602b@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/6/27 1:12, Andrew Lunn wrote:
> Silly nitpick, but maybe for the next version you change the Subject:
> to Tenth try to replace page_frag with page_frag.... :-)

Yes, it is somewhat confusing for the 'First try' part.
I guess I can change it to highlight the effort and commitment behind
the trying:-)

> 
>    Andrew
> .
> 

