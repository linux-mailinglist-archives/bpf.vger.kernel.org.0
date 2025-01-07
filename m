Return-Path: <bpf+bounces-48126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ECFA04356
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E96188536F
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799181F2C24;
	Tue,  7 Jan 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJ5a28p5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72425588F;
	Tue,  7 Jan 2025 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261551; cv=none; b=DlsH7ohLPRsqBQw7ngDbBSgObROn70ZQq9xzsD3o7O48LLy1OucvaxYbbPjrN23/AyyN/DlCIG9xNVxrD6vfNH9jk2/4z4g2DcvwID5EqVvN8eeb3BrMdnBo+h4WNk6Qv23ULIUw3hhnDLU7nrpGFQM8Vjo2ncgy3aidyWAxugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261551; c=relaxed/simple;
	bh=WxQAHvKNDf1t1y8WP8kQLuS53Cn56vM/HgaXsAHmZu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IB9H2aFmnYPSxrsIgyDF3gzQqtWC4N13aldCebdlA+FtIqE6+f8xvgUMwjNunFnB4hy9XCpjfTso3u5FXXVD1P+wgc8B0egYLn2Bejowcr6Syy/kxQFl2YSzyeHke4fNAe/ffA7UBKeRPdht1m5w1tHC9nfU6c6KzNRMXjXbki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJ5a28p5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB03C4CED6;
	Tue,  7 Jan 2025 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736261550;
	bh=WxQAHvKNDf1t1y8WP8kQLuS53Cn56vM/HgaXsAHmZu0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DJ5a28p5C1p3qCfa8LQJ394zZ/jabUsHQ9XSSnPY6jxqQjGkXKBNrLbl5sPl1Pitn
	 f20Uxn92kTDumq0VBTngaUAIK0G17qi1lCrL+ztyW/bV13vHfbuVOwxBxhMhZ8a6lw
	 ugnObBQzN6unU3idmrKZnnXPImvquLAWlG4c5DZW1cEJuTrlvbLnlKwar+lal66IAM
	 WvPCehI17rTQ+M5FsSmolNp0pm/VkSzcgGU47LQqUaJQn01r4Q/VSN5CwmSxCZBWil
	 tsNTk4s8VZuG9K8PIlIA4vOrDon6IFavxkSzotHbTbkj6gVLk5FIKt7ihCdc8+eNSD
	 4P7F8SrHOZjVw==
Message-ID: <02896f96-57dd-47d5-8fa0-8a8aed30fa9a@kernel.org>
Date: Tue, 7 Jan 2025 15:52:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/8] page_pool: introduce page_pool_get_pp()
 API
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com,
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Simon Horman <horms@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250106130116.457938-1-linyunsheng@huawei.com>
 <20250106130116.457938-2-linyunsheng@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250106130116.457938-2-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/01/2025 14.01, Yunsheng Lin wrote:
 > introduce page_pool_get_pp() API to avoid caller accessing
 > page->pp directly.
 >
[...]

> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 543f54fa3020..9c4dbd2289b1 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -83,6 +83,11 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
>   }
>   #endif
>   
> +static inline struct page_pool *page_pool_get_pp(struct page *page)
> +{
> +	return page->pp;
> +}

IMHO the function name "page_pool_get_pp" is problematic. As calling it 
"get" indicate to me that we are taking some reference on the pp object. 
Is this you plan in later patches?

If it is simply a dereference of page->pp ... then we could call it 
page2pp ?
... but I'm uncertain why we need this change.

--Jesper


