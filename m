Return-Path: <bpf+bounces-44843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED119C8C71
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 15:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7B4283D75
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 14:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560102B9B7;
	Thu, 14 Nov 2024 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oEbKNCDP"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B1E1172A;
	Thu, 14 Nov 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593244; cv=none; b=t+F92o0TmQ2iHF70/D6cATWHMRcnX2nJKEvkyYrQ5m7bkKBc3FO3Lz9gkaeynU5d7ZpAyXp+ivBFofBgR2bNEVtR6JVN7WN51jaIt0PQs71JPvQ0ceOUMsch2Q495L7VqdPvcKtfkFW5pI2PBv/laT7v9EqoEtqH1UshHnxPXTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593244; c=relaxed/simple;
	bh=cmBTVApJMNcFet7wkNI1x1Ku/qmWQAFhSpIckrpBrmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlGUD1n29Zf2k0mxOmss7tBWRcg1lVMLgKwCkkfRj/oC6C4z4J4442sgiK1wLpuv1lL1fwkhOETBVb3ntmeC6ZhmcnFTdStmkkEPwF7gxQ6nGcuXBzUayJi6t1ntxMwQlcdDcTBXtmfQgFKsg8ydDWPwV6BaX5UHKAzpwyITiOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oEbKNCDP; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 39C1E1380462;
	Thu, 14 Nov 2024 09:07:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 14 Nov 2024 09:07:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731593242; x=1731679642; bh=oc4swEVh3lPUUxMLlORAbc0MG0A5KtUOHZt
	1LGdDUvk=; b=oEbKNCDP1+FuJfZoSF12ZfR7C8tWY/SYAA8t+vYzOORTpRyn8TP
	bHnoKh8iIFVCe82eJfxvL5BOe7esKWhu4/NToLQSbcI0z+7DWCqR13bPHyz+q4jE
	9runIp+FguSnF5CUe4jszuJSgw6ZnKl6Eb3bdfDeOfxID7tv9qTTD4ZHhLNJ4CDJ
	2NxMChz8mTzb6hixYoK0ktciTBpeDctWw8m+u64QagS+IgEjn6nSFVlM8k9f7NUw
	izR3PMMjMRYvz/IK7I+gytV7dezfqllSW8pGr6SzVGEUWJ/Zh3d65Sls1wFeQNgn
	vo30BcV7+GGudzsZcxsUGyHIYx3Q+t9QrmA==
X-ME-Sender: <xms:GQQ2Z-464U_61Q4-E7qRA6_7-T_9FityRoPoY1Gi-WYflNZUF6qYgQ>
    <xme:GQQ2Z34HNl38XS7oYv9Q-DxAmruEhW-SkUK1mUbyIzNuJEEtZSssP2q-nzuXzPZdj
    J7SLRR3JXj-zUA>
X-ME-Received: <xmr:GQQ2Z9e8RF74ht6xL8vWEVrm9cC-Bm6qtVsu0DYXlSBJzwlIj7X6Dg774XvHHmXflLTww0qAjzgG0g8oMolpyT3L-8zTLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefg
    leekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthho
    pedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvghkshgrnhguvghrrd
    hlohgsrghkihhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhokhgvsehrvgguhhgrthdrtg
    homhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghn
    ihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehjohhhnhdrfhgrshhtrg
    gsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:GQQ2Z7L9BLJS2mDM--kuEoQlelbz2e53lSdtauzGD-LCOtxuDAUsZA>
    <xmx:GQQ2ZyK1acC3J7ENhs20Dcw4Gw0o_DZ1WxMtWXVI-mg8PLaEXzgtcw>
    <xmx:GQQ2Z8xH_d3Xw-XA_xVhbwmeYoH55yTcgNK_B1z72J3mJVTJTYxPAA>
    <xmx:GQQ2Z2JrBp7Df2uZDpBienOktUr0B1elquaO7gKMzgGCPJSHvZrWlw>
    <xmx:GgQ2Zz5YZeRjyzCT9PIKcryRfj1vaeIU_eu3CEo-HZcR21ekH2vZMTP0>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 09:07:20 -0500 (EST)
Date: Thu, 14 Nov 2024 16:07:17 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 11/19] xdp: add generic xdp_buff_add_frag()
Message-ID: <ZzYEFb4xK6IquBhI@shredder>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241113152442.4000468-12-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113152442.4000468-12-aleksander.lobakin@intel.com>

On Wed, Nov 13, 2024 at 04:24:34PM +0100, Alexander Lobakin wrote:
> The code piece which would attach a frag to &xdp_buff is almost
> identical across the drivers supporting XDP multi-buffer on Rx.

Yes, I was reviewing such a change when I noticed your patch. We will
use this helper instead. Thanks!

> Make it a generic elegant "oneliner".
> Also, I see lots of drivers calculating frags_truesize as
> `xdp->frame_sz * nr_frags`. I can't say this is fully correct, since
> frags might be backed by chunks of different sizes, especially with
> stuff like the header split. Even page_pool_alloc() can give you two
> different truesizes on two subsequent requests to allocate the same
> buffer size. Add a field to &skb_shared_info (unionized as there's no
> free slot currently on x86_64) to track the "true" truesize. It can
> be used later when updating an skb.
> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

