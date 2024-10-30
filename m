Return-Path: <bpf+bounces-43597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565C09B6BF6
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 19:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF8E1F21E73
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 18:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7621C6882;
	Wed, 30 Oct 2024 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m8A9+mrA"
X-Original-To: bpf@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9B21BD9DB;
	Wed, 30 Oct 2024 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312272; cv=none; b=cn6drrL8xqJ8JoIRg3kC+QHcgSwkZqmIhiTuyTo9aWDDBI3i0PeFy/Hr5yoLQidKTv2d+sn+XYc2Tgky3I9q6iqm62YXsbxWuErDDygKqhWJyuFRKjh65pNsx2XkSS1EXgLWZ3AHyMfzqB9L5/Clg24kmJjMr4ac1do3l+q+6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312272; c=relaxed/simple;
	bh=JQ/9P5SeV/Q+Tp83AVedSQbdDe89werZDEcT9MXp4Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8N6a3DX8EgzyxlGDyuD7H6LTzJOYmv2z9adYTWI8L+wMU0JU6o0mnrmiys7a1XwDFhLhflcl8+YVNAlRt97oyqusUFigh888M3tafs1IfJv+aSPdaRs8mTzjIAD1bn2OYB5ogSjiMKQx2hAKbeJzyJB+vVS4s66Rgvg+8itDlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m8A9+mrA; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E1181240002;
	Wed, 30 Oct 2024 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730312261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06tOOHd19QuPRfEvfQXspwA+6KLAkL5zimvRvbwQg8E=;
	b=m8A9+mrAjl/Aj3gcQEM+Gs7ZjaYbcPkepQpEue/BIWjmVOiFNsBlZbCVwsBDK0roLmjC/u
	gYApbs7kEtV4pIC+ibNMleSNeoAlpgYdRSKiYffe10cf/gFN12xeH7n/+STRUb1Ut2akDj
	ikF9Uo2A8Gifzs7LJB/hRWNfqP/Cm8E3ngOtDjCF46TxKuNohJAyrKTMghD48Z7Y6xzZHg
	sHW/SL+a/7gjRJzParROwKtI/+Fy7IjnbpCdjsxXPmpa7pHafOrlNKajUhHz0qymz1VGwZ
	Wo44Wo4BDEB1EeeBeGzCWb0gAbZg4QcApVVJ3mLW6eIjZxZGQJvwnsf9VHo7+w==
Date: Wed, 30 Oct 2024 19:17:38 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Simon
 Horman <horms@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Siddharth
 Vadapalli <s-vadapalli@ti.com>, Md Danish Anwar <danishanwar@ti.com>,
 Govindarajan Sriramakrishnan <srk@ti.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpsw: Fix multi queue Rx
 on J7
Message-ID: <20241030191738.5bd12ccc@fedora.home>
In-Reply-To: <20241030-am65-cpsw-multi-rx-j7-fix-v2-1-bc54087b0856@kernel.org>
References: <20241030-am65-cpsw-multi-rx-j7-fix-v2-1-bc54087b0856@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Roger,

On Wed, 30 Oct 2024 15:53:58 +0200
Roger Quadros <rogerq@kernel.org> wrote:

> On J7 platforms, setting up multiple RX flows was failing
> as the RX free descriptor ring 0 is shared among all flows
> and we did not allocate enough elements in the RX free descriptor
> ring 0 to accommodate for all RX flows.
> 
> This issue is not present on AM62 as separate pair of
> rings are used for free and completion rings for each flow.
> 
> Fix this by allocating enough elements for RX free descriptor
> ring 0.
> 
> However, we can no longer rely on desc_idx (descriptor based
> offsets) to identify the pages in the respective flows as
> free descriptor ring includes elements for all flows.
> To solve this, introduce a new swdata data structure to store
> flow_id and page. This can be used to identify which flow (page_pool)
> and page the descriptor belonged to when popped out of the
> RX rings.

[...]

> @@ -339,7 +339,7 @@ static int am65_cpsw_nuss_rx_push(struct am65_cpsw_common *common,
>  	struct device *dev = common->dev;
>  	dma_addr_t desc_dma;
>  	dma_addr_t buf_dma;
> -	void *swdata;
> +	struct am65_cpsw_swdata *swdata;

There's a reverse xmas-tree issue here, where variables should be
declared from the longest line to the shortest.

[...]

>  static void am65_cpsw_nuss_rx_cleanup(void *data, dma_addr_t desc_dma)
>  {
> -	struct am65_cpsw_rx_flow *flow = data;
> +	struct am65_cpsw_rx_chn *rx_chn = data;
>  	struct cppi5_host_desc_t *desc_rx;
> -	struct am65_cpsw_rx_chn *rx_chn;
> +	struct am65_cpsw_swdata *swdata;
>  	dma_addr_t buf_dma;
>  	u32 buf_dma_len;
> -	void *page_addr;
> -	void **swdata;
> -	int desc_idx;
> +	struct page *page;
> +	u32 flow_id;

Here as well

[...]

>  	rx_chn->rx_chn = k3_udma_glue_request_rx_chn(dev, "rx", &rx_cfg);
> @@ -2455,10 +2441,12 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
>  		flow = &rx_chn->flows[i];
>  		flow->id = i;
>  		flow->common = common;
> +		flow->irq = -EINVAL;

I've tried to follow the code and I don't get that assignment for the
irq field, does it really have to do with the current change or is it
another issue that's being fixed ?

Sorry if I missed the point here.

Thanks,

Maxime

