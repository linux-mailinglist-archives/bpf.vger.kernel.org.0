Return-Path: <bpf+bounces-36621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C948E94B182
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 22:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A8D8B24621
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 20:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC5E146A66;
	Wed,  7 Aug 2024 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="E+eKG3g1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b96naOm6"
X-Original-To: bpf@vger.kernel.org
Received: from flow8-smtp.messagingengine.com (flow8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7053B63CB;
	Wed,  7 Aug 2024 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063107; cv=none; b=kCX8YP7bBLLAtG15np1YTFmTi+ELHMFklQXs19Bi1PWjns/ehdn+IcxhLnXMIZQRtbAXiso+zIC/cNaW6FxSEGFYXkh/bMnTE7ChYMNURbvbAu7Bod71DBtu+N8lL1D5xhwbpwOe5oBj0t5e8Mi2P0N06igxLlrSnM3ke4VMY8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063107; c=relaxed/simple;
	bh=uKf+fXnSqFS/bfmB6/2soazJM9laLMq3cqYVbv0cfa4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=okuajIQ20zp8obPLAMl3eXvoRV20L8nC4G8tttPk2vIyfFO6rFHeD3LiqgzeYPpkQEklWAmrF5kYJY5JdXkV8j9Q45is9bDpDReH9mLFJbDP45gRS0WE6VJnwwKt6w35tbcPkuTdPh3X2rOvRccPY99FNxWRm8G0H5TGvvhTuQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=E+eKG3g1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b96naOm6; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailflow.nyi.internal (Postfix) with ESMTP id 6FC3B200CD6;
	Wed,  7 Aug 2024 16:38:24 -0400 (EDT)
Received: from wimap24 ([10.202.2.84])
  by compute3.internal (MEProxy); Wed, 07 Aug 2024 16:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723063104;
	 x=1723070304; bh=jyuTeJGDcuQF3lzGu4CM7mjVX08aa1yYpmFdb0KuMkg=; b=
	E+eKG3g18OxvHvRzsf6ur2aTpQZ9AzI8YfWphmPd0cP/woMQ4Y3QVK1CWtwyfC0y
	cHTeaFxhMH1uSN585hjjDqb87LprAEz9VK+9wE/aaFBd7xWr105XIJW2HiO3CCBT
	YUhe5sKACQ2+4qxt6XjnpRHJuImN2bklW8zmfcEAFP7Lou43NRM5qKq7IDAugdai
	IYwG14dKzFFps6YPHSCr8q3rMVjgC39MnFUcYuPCpyq6euXGEsVrw9WBPuceev/e
	X1NgaLyTbyhKd84J12Ahg8rIJO1jqyZ0gWDxM/DU4rzl1Ec33URQG7nXdRjdZ8vH
	rYKBskImd2bUqczPtF0xdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723063104; x=
	1723070304; bh=jyuTeJGDcuQF3lzGu4CM7mjVX08aa1yYpmFdb0KuMkg=; b=b
	96naOm6Tmp/fSG/qTnRg0+F8M1bkR3E6CbDhH/DghMASO9cQQZXdb+LxscNKRR+9
	7Fk34G4TL+jkTV6cjuk1odFzQ1NlafI85IkaEBBVXbJELeIamzWo5vQoPavmZTfY
	EGzqi+M7c6MwPerN2+6XDk2A51wIsc06LLhESfT3n6f9myyWLNa39joOmjaiSdLt
	SzS10PV4vNew1tgyh0/ihr7Ntoyai8cLMI1B3uhwDG/7G0ganJJiQD826YGpf2KG
	2ihMc9VIedRkjSJ8h41pV7ucNf0knq9CR0h2UorMPi98cUM3wsY95XiAAvnhtdyQ
	Yxn+V/lEX1dz2j6fa+wjQ==
X-ME-Sender: <xms:P9uzZoVoJoJIjaEe5XEiV6Vz5awp6yXK3aNbyHjzzdb688Le77cVyg>
    <xme:P9uzZska1OThlfuL529FWZ7jFVAvlL_-1R36To_6GXNnKTB-FP2Sqy5ZaGcAdLlLS
    9zEmspZ_yWq253PvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdduheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredt
    redttdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucggtffrrghtthgvrhhnpeegleeifffhudduueekhfeifefgffegudelveejfeff
    ueekgfdtledvvdeffeeiudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:P9uzZsZVDPXINqpCub6toZIfUIDIuTh3l6jzddHJgnwx2_r89u3NLg>
    <xmx:P9uzZnXVu3YW6dwEw3EnpmWxOTpqjh1vEfBYofPdY4Wfly-3pdODuA>
    <xmx:P9uzZinF4Mlz89xrmdz6CAXUdJY2qvYf7M_Iu_78yJQ_n0TQTC1o9Q>
    <xmx:P9uzZsdkibaV9xNpNuXB04-0ANSmk58v-xCPvUz-06Pb_akK4WqliA>
    <xmx:QNuzZgtMODcHgERAtcl3T8Em_VIMuS7bsgnj1q6tBLy5D_CdPIoIaSjn>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9567E25E006A; Wed,  7 Aug 2024 16:38:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Aug 2024 13:38:03 -0700
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Alexander Lobakin" <alexandr.lobakin@intel.com>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>
Cc: "Larysa Zaremba" <larysa.zaremba@intel.com>,
 "Michal Swiatkowski" <michal.swiatkowski@linux.intel.com>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
 "Magnus Karlsson" <magnus.karlsson@intel.com>,
 "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>,
 "Jonathan Lemon" <jonathan.lemon@gmail.com>,
 "toke@redhat.com" <toke@redhat.com>, "Lorenzo Bianconi" <lorenzo@kernel.org>,
 "David Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Yajun Deng" <yajun.deng@linux.dev>, "Willem de Bruijn" <willemb@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xdp-hints@xdp-project.net
Message-Id: <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
In-Reply-To: <20220628194812.1453059-33-alexandr.lobakin@intel.com>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
Subject: Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to GRO from
 netif_receive_skb_list()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Alexander,

On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
> cpumap has its own BH context based on kthread. It has a sane batch
> size of 8 frames per one cycle.
> GRO can be used on its own, adjust cpumap calls to the
> upper stack to use GRO API instead of netif_receive_skb_list() which
> processes skbs by batches, but doesn't involve GRO layer at all.
> It is most beneficial when a NIC which frame come from is XDP
> generic metadata-enabled, but in plenty of tests GRO performs better
> than listed receiving even given that it has to calculate full frame
> checksums on CPU.
> As GRO passes the skbs to the upper stack in the batches of
> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
> device where the frame comes from, it is enough to disable GRO
> netdev feature on it to completely restore the original behaviour:
> untouched frames will be being bulked and passed to the upper stack
> by 8, as it was with netif_receive_skb_list().
>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
>  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)
>

AFAICT the cpumap + GRO is a good standalone improvement. I think
cpumap is still missing this.

I have a production use case for this now. We want to do some intelligent
RX steering and I think GRO would help over list-ified receive in some cases.
We would prefer steer in HW (and thus get existing GRO support) but not all
our NICs support it. So we need a software fallback.

Are you still interested in merging the cpumap + GRO patches?

Thanks,
Daniel

