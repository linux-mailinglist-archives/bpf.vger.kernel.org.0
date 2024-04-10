Return-Path: <bpf+bounces-26444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1C289FAFA
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 17:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E1A28BA7E
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8605016D9CE;
	Wed, 10 Apr 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WFYVPKzf"
X-Original-To: bpf@vger.kernel.org
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C915958E;
	Wed, 10 Apr 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761407; cv=none; b=oFzSzD/lvZgS9umfgeLShlioiE1f5NtK0YMHbwHBqM1TCBM+DXEzzvoJa+e8JbG/UsHCouvOmW7UnRX6GzzorojpDkHl7t9B1oatOxlmWZM/nosL3uW0vD3yZHHqc21qw++WA0cknEb96PDczYLTS9PbxqalbYAoA9iVz6JqmCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761407; c=relaxed/simple;
	bh=VQyzQjJQejCEPzKQvU827ei9/KK+y+ux8JjA9cJgxVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPxzUOAkJVmZQ2GITtZHmBMVN+kiN1nmgM7VGtLjUtamSwaYnIdNX/x74171kR3eVcTFvrAbt0v/T/42XrGwU5bQkt9PcWiQETLMiHudm4Ml90MLNYTNSXKCxC0oSAuPmpUUVMmpO9HcGfWzlsPEGRGWnilxQONb5ldTXB8j9EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WFYVPKzf; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id C043C1C00081;
	Wed, 10 Apr 2024 11:03:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 10 Apr 2024 11:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712761401; x=1712847801; bh=fDN7LNg3MU1SeI2iaSN0kzB8FZeK
	umLZXWxQhW85B6o=; b=WFYVPKzf+WTlvkgORk5e+JbUnduryZ++mSz035b372fQ
	nuuwL97dI7BBVgjaBXXEKiIFzh1Xyv01xkS/cq15Jf/6yZYpZtPHaLiypshuFuF3
	pdNQ89u0rPhqaZ0v4nEn/rH0Pm4IWN/RmYSgWwTslJtiTZfFs9TnrC1vfw7hS6cS
	slsC7omM+v2bCRAG4tS98FRNeLa9r/PsYaf6q3SMIfjSW26kXJOAuPipp0e1V/1t
	1gSSXfltOJA0rvVU/U6Bt1i1CuIc3N5d2S3+iWEu2lw7ds4BFcIWg5HbAgpKfY7A
	//X3QyB6pnzMMsz5r74VsH5uH5SzoBvlIUGD+3U+Ug==
X-ME-Sender: <xms:OKoWZqnU0_nEs71C46y4upxl7qPl4h1wr0ptDI2N1EkWGPuRowxEOQ>
    <xme:OKoWZh1-A5K0sHS6Pz9MY-Jkcho3tPyb0Ezz3esBLHAFD3WITI1k-Dra9lZtBIzMW
    GnK_CXTzQcXB7M>
X-ME-Received: <xmr:OKoWZooY5673t2tsp3KDlWLQHLuu_S2mDs72czBwe9btkSIQlt6gBKV7kcyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepfeefueegheehleelgeehjefgieeltdeuteekkeefheejudffleefgfeludeh
    hfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:OKoWZunajKgXJvlzXySKL6AtIdjUEocGwBl1aQWCUN20yrdhYwhE6A>
    <xmx:OKoWZo1PtmmB9RkBuY-kuLKW7T5dem6xCJWre-MPRzex3HJzmqr_EA>
    <xmx:OKoWZlsp--rAHoLzaGyDDV9iW1zsiKd9Rl-zswd2O8QO_HZxOI8W5g>
    <xmx:OKoWZkXvmTDOCoYgZzXSBYss2L67git07oFAdqTQjzSm7k4qlvQHtg>
    <xmx:OaoWZt9mVLzcYFfWAX767iMyveSzZBJ9U9WoRGWckea2lIuLxllqdVCr>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 11:03:18 -0400 (EDT)
Date: Wed, 10 Apr 2024 18:03:16 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Breno Leitao <leitao@debian.org>
Cc: aleksander.lobakin@intel.com, kuba@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, elder@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org, taras.chornyi@plvision.eu,
	ath11k@lists.infradead.org, ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org, geomatsi@gmail.com,
	kvalo@kernel.org, quic_jjohnson@quicinc.com, leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH net-next v5 01/10] net: core: Fix documentation
Message-ID: <ZhaqNOCeCFSObcPS@shredder>
References: <20240410131407.3897251-1-leitao@debian.org>
 <20240410131407.3897251-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410131407.3897251-2-leitao@debian.org>

On Wed, Apr 10, 2024 at 06:13:42AM -0700, Breno Leitao wrote:
> Fix bad grammer in description of init_dummy_netdev() functio.  This
> topic showed up in the review of the "allocate dummy device dynamically"
> patchset.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

In case you need to send another version:

s/grammer/grammar/
s/functio/function/

