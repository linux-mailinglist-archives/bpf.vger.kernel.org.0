Return-Path: <bpf+bounces-50548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0FAA297D3
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 18:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A88B7A2B0E
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 17:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690161FECC9;
	Wed,  5 Feb 2025 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZEKOlpeI"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251181922C4;
	Wed,  5 Feb 2025 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777267; cv=none; b=eTC9r2f2GTXeMVPSjiWK+Lk/T3lgPFz4s+EBCu/w58BVvTIt0t3Wv1uKFIn3WWPyHFI/gU5LScjDZQGD8QPYjccSKncF3p8kvMH/NK+MFI5II0kNZAJh4aPNWuyAIZRUglvOl76YD5XGwVSxBh+KIfEw/xPiIjmU4Ge9AElGjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777267; c=relaxed/simple;
	bh=JviheAOfcGY+fam4/mBliU2Kfgw+lI2qsF7LU6cAtEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+pu9zfQDpn4K3Vt5AMxZrnBbCtmCpJGhasP7iJ3PxOQZzrQC62JIU3P69NTE2II1Q0GfhHh1MTty49P3ceU1n25mF6i71utP1mWxlZQ03UMzQjP2N+J2Ld5j79AaSnwPHz5N90U9+nY5LWo1I9PmSO/lB9O0c3sijVcDeYTRbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZEKOlpeI; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 822C0254016F;
	Wed,  5 Feb 2025 12:41:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 05 Feb 2025 12:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738777264; x=1738863664; bh=JviheAOfcGY+fam4/mBliU2Kfgw+lI2qsF7
	LU6cAtEk=; b=ZEKOlpeIY1hKtAp2dj02SWmILkEsLYGoHFBIhdaBULcWMVoyQpu
	KzfAjF8pvjtTF4lN4dnc+yfrdQ3gu5VmdclWrtk+RRblOTrTs+RV/ySBTzhYrIhs
	We0em8144KiF7E+I59c4mxMgbxGf905v7Sj55jV6FVhrGpOQ3gjipVswyXq/jPQJ
	U5aUj0w2Vc9yCU+OcHLM3WVcEppDYlKD7L5S9IqaEo2pLfRrVcYtAZWqrThiZFx+
	tAGxot3+aNI0zc1jcVV0hAMD+p1ttK0t6u3P/C/MsUJJOKio/tQ8rD+1e6MA/1IP
	4hF07xGbvjG1PH3qhB/QuswNLbOzdldpHkQ==
X-ME-Sender: <xms:r6KjZ7s7MsnLlVFwDXTvWOa1kjYpINM-exd9-U2Mn05ci8nQd6r87w>
    <xme:r6KjZ8eMZ05c9ssWZuaZ48i2jNVhIGMTzfwk88dv3Hq_gRidwDIAHTnzR7ouXzEcX
    ddkZG1IksiVExY>
X-ME-Received: <xmr:r6KjZ-wSZrt9SGKDgAQk8cUrFe9ZeODH2xbU9scCMJso-3E-rggZonmspkZq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpeetudfghfelieetjedvhfevfeduvdetgffgudel
    uefgkeffueeltdejvdettedufeenucffohhmrghinhepihhurdgvughupdhkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopedvhedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhdqmhgrlhhlrgguihesthhirdgtohhmpdhr
    tghpthhtoheprhhoghgvrhhqsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnih
    hshhgrnhifrghrsehtihdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggr
    vhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluh
    hnnhdrtghhpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:r6KjZ6OC6d3nrGjKvfHfIHaG7SURZuoKgzNUQ3ICfgDIzAEcRrQ67w>
    <xmx:r6KjZ7_VUkzrSRTTwpmM_8MYcyk4CA4pzZxMHqSJs75nyLleEP2aLg>
    <xmx:r6KjZ6U4SRoztKmYfzJCF1g0Osm-g593CwyW0FLZ9MPOZ_Khp2xNOw>
    <xmx:r6KjZ8ftyrqq_5yaaFlEazqMapXDZAQ71v9J3gxNSe2pyx39exlAmA>
    <xmx:sKKjZxPbTGyNchIvuM930pj-PPoTOhF2PZ47K3Ks0DY0owW0elyqGulr>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 12:41:02 -0500 (EST)
Date: Wed, 5 Feb 2025 19:41:00 +0200
From: Ido Schimmel <idosch@idosch.org>
To: "Malladi, Meghana" <m-malladi@ti.com>
Cc: rogerq@kernel.org, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, robh@kernel.org,
	matthias.schiffer@ew.tq-group.com, dan.carpenter@linaro.org,
	rdunlap@infradead.org, diogo.ivo@siemens.com,
	schnelle@linux.ibm.com, glaroque@baylibre.com,
	john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH net 1/3] net: ti: icssg-prueth: Use
 page_pool API for RX buffer allocation
Message-ID: <Z6OirBmdSLuY5YkI@shredder>
References: <20250122124951.3072410-1-m-malladi@ti.com>
 <20250122124951.3072410-2-m-malladi@ti.com>
 <Z5J4jjJ4_arvfF9E@shredder>
 <9287a623-5663-4705-b61a-3ab5f5cb2424@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9287a623-5663-4705-b61a-3ab5f5cb2424@ti.com>

On Tue, Feb 04, 2025 at 11:25:02PM +0530, Malladi, Meghana wrote:
> Seems like none of the pages which have been allocated aren't getting
> recycled in the rx path after being used unless its some error case. Will
> try to fix this.

skb_mark_for_recycle() should help with page recycling when an skb that
uses them is freed.

Anyway, I believe that I don't see put call when tearing down the Rx
ring because prueth_rx_cleanup() is using page_pool_recycle_direct()
when it shouldn't. AFAICT, prueth_rx_cleanup() is only called from the
control path (upon ndo_stop()) and not in NAPI context.

> Also I have noticed, in prueth_prepare_rx_chan() pages are allocated per
> number of descriptors for a channel, but they are not being used when a
> packet is being recieved (in emac_rx_packet()) and rather new page is
> allocated for the next upcoming packet. Is this a valid design, what are
> your thoughts on this ?

The new page is possibly a page that was recycled into the pool when a
previous packet was freed / dropped.

[...]

> Yes I will add PP_FLAG_DMA_SYNC_DEV as well.
> I believe page_pool_dma_sync_for_cpu() needs to be called sync Rx page for
> CPU, am I right ? If so can you tell me, in what all cases should I call
> this function.

Before accessing the packet data.

> https://lkml.iu.edu/hypermail/linux/kernel/2312.1/06353.html
> In the above link it is quoted - "Note that this version performs DMA sync
> unconditionally, even if the associated PP doesn't perform sync-for-device"
> for the page_pool_dma_sync_for_cpu() function. So does that mean if I am
> using this function I don't need explicily sync for device call?

It's explained in the page pool documentation:

"Driver is always responsible for syncing the pages for the CPU. Drivers
may choose to take care of syncing for the device as well or set the
PP_FLAG_DMA_SYNC_DEV flag to request that pages allocated from the page
pool are already synced for the device."

https://docs.kernel.org/networking/page_pool.html#dma-sync

