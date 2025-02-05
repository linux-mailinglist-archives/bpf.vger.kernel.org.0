Return-Path: <bpf+bounces-50549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8112A297F8
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 18:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121A83AA96F
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 17:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0731B1FE461;
	Wed,  5 Feb 2025 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r2luspiz"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A451FC7F6;
	Wed,  5 Feb 2025 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777588; cv=none; b=muJGiBOI2dm/4U0qd0PssKEjinpAPuX+z7GMqWcwMWQET5X28Jr63+TZkZkqgrvKfwIyVMoI4RX4J9fKpz3rnQCWirmKqcbE4oKcqIsUUApKmX56SpCbojS2m8XDyCAkl6FJUfNYUHR5UH7fAnhYoEA7bG6baGmu8PUQhWyvGSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777588; c=relaxed/simple;
	bh=8C1HNH4qVUSwKDMJatvHx29Le0IdvOg84YisPyZytOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUxpHfaIIlh3kzTOP2TE1TPp+lRi2mfsb8pP7qq/K0MluGCCbnzBRqnk89qUztShLEcJc3dqd9raVsn305xRDYUeMyWmnr0iAIfFyr/7aF08sUDFHHNxivbq2EDzWENVthW1pC7AG6NbpYeG/doNggs5DYirTW+7zdLhCCwuEhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r2luspiz; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 243E12540196;
	Wed,  5 Feb 2025 12:46:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Feb 2025 12:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738777584; x=1738863984; bh=HEskk/2SpuLO/Xrp6JjdV4QHbWz2DrijKvj
	/WGpMo98=; b=r2luspizoix2AEF4EaO2ehJhs7Fw4jAPTtpliuS8JBSUfGJyPua
	qLdsjnxyl17PnEZrM4NHbR0U+29fas76j99i19IxBZURQBifLWxhbBqW55hLySrx
	HAVXCsRLmha2HcqHknDjkL9Xeidf4rObORpsZyMfh5Sh3d027iSyZfBz4EzQqP+g
	m01JL38qT4d+2xoffTqqVpTOqa0+KIuGWPiDNHhSa5VLQhJe1yIQwKQapH1D+A2w
	MrEUldAKDRixrRe9FXa1hGt0oYIx1AP3k/BxL5lJIGHjq+LNbgWNgo19+fF9B1a2
	7z4uNy2MiJ6gkm/dGMNt19qfUpvbLRREaDw==
X-ME-Sender: <xms:76OjZxlYzksRscRa_qX5S04h1IkoM8bn-hTsZOcJs7JyXwTEf9lRwA>
    <xme:76OjZ80UBNf8ydUkrTr-5DJ_vaOkIknryww7-2SJIuyzqEUoknba85E7p97tABPvO
    HqhNu5PCTaAYnk>
X-ME-Received: <xmr:76OjZ3phySEI9zZFX2fLzlWk0i1_zAvHzDKe_9rYPI_Jp7XAtN684i8eLv1I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopedvhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhdqmhgrlhhlrgguih
    esthhirdgtohhmpdhrtghpthhtoheprhhoghgvrhhqsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegurghnihhshhgrnhifrghrsehtihdrtghomhdprhgtphhtthhopehprggsvg
    hnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfido
    nhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:76OjZxmJrT1mw4cGC5Z3PVwsGehnoRCjZxYdJ_ABfe7RSiEUpwplPA>
    <xmx:76OjZ_2ZX3nJ9G-5vJnVR0qR9wI4381VmwucynYbHX0TQW3fcgNk8w>
    <xmx:76OjZwt7MG6j-mRcytoklvUnMHVjIFGoXdLvzheatidojseNs3d1tA>
    <xmx:76OjZzXX8eMbKVIFytFckbC4ddt2sHqyb_DKlX_qbpoIeIP9ViJf-Q>
    <xmx:8KOjZ6GI8IvEawqZnrxSUKqmofGTrPSXj8dpIMcsPw-APgDOhhVJr7tK>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 12:46:22 -0500 (EST)
Date: Wed, 5 Feb 2025 19:46:21 +0200
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
Subject: Re: [EXTERNAL] Re: [PATCH net 3/3] net: ti: icssg-prueth: Add AF_XDP
 support
Message-ID: <Z6Oj7eMRV9z9lF2I@shredder>
References: <20250122124951.3072410-1-m-malladi@ti.com>
 <20250122124951.3072410-4-m-malladi@ti.com>
 <Z5J7kGFU_ZgneFAF@shredder>
 <f1cf5bfc-e767-4ced-9aad-76a578c53706@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1cf5bfc-e767-4ced-9aad-76a578c53706@ti.com>

On Tue, Feb 04, 2025 at 11:25:39PM +0530, Malladi, Meghana wrote:
> On 1/23/2025 10:55 PM, Ido Schimmel wrote:
> > XDP program could have changed the packet length, but driver seems to be
> 
> This will be true given, emac->xdp_prog is not NULL. What about when XDP is
> not enabled ?

I don't understand the question. My point is that the packet doesn't
necessarily look the same after XDP ran.

> 
> > building the skb using original length read from the descriptor.
> > Consider using xdp_build_skb_from_buff()
> > 
> 

