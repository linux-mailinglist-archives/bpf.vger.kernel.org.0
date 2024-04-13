Return-Path: <bpf+bounces-26701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592F88A3A6C
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 04:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE421F2279B
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 02:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5073B1758B;
	Sat, 13 Apr 2024 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8+3BVLR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71D6FC0E;
	Sat, 13 Apr 2024 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712974588; cv=none; b=aLfAB8hUGtvzYspSl1/XQ/V7afymmjp9/sdfmjb1adwqylcow0w+ebFT5QhTwOyTMyKuOlxrh5MBLYZFUb1sDrtZuJHgHrxoLnFyFQnVmkohQnf+Q6lThuJ0drHv3DX0eBldqyJJ7Ox2Wmx0EzmGbFfNp/2YRPHFmiMXwpze1HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712974588; c=relaxed/simple;
	bh=edVYBrCFyItV2d/UveybSyGwsRExQsBBAgMZRGTiSYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srHail2FaPrZ9A3Z1liWZ7ZqbNIU2ufqITtSLFwJf8/r5kaVdG5o3SWYWHVbkv56C0ddTTLs4Wq5vvf2XGKbASwWen6ODk2hZlX7mgkhPDzH7KJx6cQiqTAHbGPdt8OBsGKQg1KlptMX3wyjpul9gyhSbm+xyCu2ao+PJ6Dm4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8+3BVLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1595FC113CC;
	Sat, 13 Apr 2024 02:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712974588;
	bh=edVYBrCFyItV2d/UveybSyGwsRExQsBBAgMZRGTiSYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C8+3BVLRyA53WLwuKA0hZTTf79KRJ8rtny/HmzaGPRxqFvuz2QSCA1zalbiHLREqB
	 RqT+VpzaswsCXZmNXJELAw45yTMpmIxKDzJQfH8fnqIqY1bf/Mgjw7b/q2TVK4YWjc
	 cUNO7FSbDfMbCl0ClGrohxtTHL1Wjva6I05WvxNT3QqkPFdk2t7p/g5CO+sCcg4hUB
	 sNvgDlG2d2FEYOV4zz6Z9ID4nQlo0rht493d1n0T+QZKkw4PZfLYGQYAJyg1grkQkv
	 Gwe3M71KTriLQ3SW6lsTq05SWJpXIgtfcCQMG5HT/rqQcXv/18TLrHqXKcxck6FrUh
	 ivwL/jEOTOuHw==
Date: Fri, 12 Apr 2024 19:16:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: aleksander.lobakin@intel.com, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, elder@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, taras.chornyi@plvision.eu, ath11k@lists.infradead.org,
 ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 geomatsi@gmail.com, kvalo@kernel.org, quic_jjohnson@quicinc.com,
 leon@kernel.org, dennis.dalessandro@cornelisnetworks.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 idosch@idosch.org, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko
 <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH net-next v6 03/10] net: create a dummy net_device
 allocator
Message-ID: <20240412191626.2e9bfb4a@kernel.org>
In-Reply-To: <20240411135952.1096696-4-leitao@debian.org>
References: <20240411135952.1096696-1-leitao@debian.org>
	<20240411135952.1096696-4-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 06:59:27 -0700 Breno Leitao wrote:
> +/**
> + * alloc_netdev_dummy - Allocate and initialize a dummy net device.
> + * @sizeof_priv: size of private data to allocate space for
> + */
> +struct net_device *alloc_netdev_dummy(int sizeof_priv)

Sorry, one more round :)

We started using -Wall for kdoc (./scripts/kernel-doc -Wall $files)
recently and it now complains about missing return values...

