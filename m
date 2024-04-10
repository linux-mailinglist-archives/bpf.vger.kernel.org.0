Return-Path: <bpf+bounces-26445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E0689FB7B
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 17:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710E7B2BEF6
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EEE16DEB8;
	Wed, 10 Apr 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SNGUDwkX"
X-Original-To: bpf@vger.kernel.org
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953A416C877;
	Wed, 10 Apr 2024 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761558; cv=none; b=A1DlDub83agIsr1T1YkejQwXrshTqYEUXRXDltLuKLzvCkWH8UzexbygWKEu60lQ2aX7+Be/X8aWBkzxnmW2Atk/+bEi6H0BpoTcIAG2v9+a2WFU7jRUrIn7YN6uTt4hvz28bxKgmYiNF0vTo6QcjYRrJlC3/p9y05s8JBxnwZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761558; c=relaxed/simple;
	bh=cUzFDAS3EbYkXdW7wC2mTAuzm+O4VDnkMYMj/YD+Qr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaHShbInXeEJ9YENnC/6jkDq7rvwUNIbe1y4X1JmHzQ/lWQIfKxJIMQ0ZK8f9zcDnhr+7omm0Z1y7h9aeuNnUT7K5V6MvXWfqZMQP0uhjdPu63eXXQ/cyuFOplPxOOoePs5TlDwHil8hbqA4up8ObWOtja3uEUWohXirpx0ynhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SNGUDwkX; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id AF66B18000F0;
	Wed, 10 Apr 2024 11:05:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 10 Apr 2024 11:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712761552; x=1712847952; bh=TDGvkul+Q73nN0fHZOhTAHooDQZw
	t3FC9x/QxxSs3zo=; b=SNGUDwkXjBq6YtQxxM3lA3GMHmXSrT2cy2J4JaBa5KHE
	Hc+xeukLb0K8D1cZxsH4khv3vX5w4V26Ev7YwRBsBzEtfVxXcQG/DDo7Wq92YHEw
	dcfJTEmtqnjPnc9NgFt/el+AJwp41r1btXkQrABaZ7W99StTxiXT58NBJ8p2lltD
	iUKRp+tK1x7+tt/v5GS20dHXtRAxxLkSGlKzr4tdgJHRLM34nG7atn/SqZAqyZjE
	Kghp5JrU2hT2wOiFqGuku2InwpV8r62JpiCDJeaLhY1qurB+4dCCtq3yEjCwQQhp
	exn1cwQNlaGDPugyI06Ob69hDT0wm+lzpi7kihAHuA==
X-ME-Sender: <xms:z6oWZirsV-nMSlBJ_lJHht3gSOq-1b8CG2vrEJEIev3ET7Gg5BIBhw>
    <xme:z6oWZgpmS8OJjlntZPqhKVYsG_Ms_fMU82xVOyAvV8_0Lf8-lfkq0Hq4pN2Xy7GMZ
    deF3Ovb49n63Gc>
X-ME-Received: <xmr:z6oWZnPGX5nP-7JRHmiHleiBxQF-dNbP1wTCXQU8oUbIv9e_gjPq_L4IW_Kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:z6oWZh49-kpbe5t6iou3vs4d-1A5eJnaI5xAIu1_4gCElWtyVPM-Cw>
    <xmx:z6oWZh6-YFeqxhU1DrfRO3jic7Oo4N5ICNItdUDiCIzLDV9VlwEIDQ>
    <xmx:z6oWZhiDjueR4bTXrVLEOVXiuABAM3tjPYq_DnwRZaBQzewPK0MBUA>
    <xmx:z6oWZr7yMr5pEO2Zbdcw9y9CBMvABVOix3FefIk--Aup764a9f9V1w>
    <xmx:0KoWZumSlhW9MHX9P70o-XAB3cMSnYOwHvogsN-suiaqrMuljzfLXBGb>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 11:05:50 -0400 (EDT)
Date: Wed, 10 Apr 2024 18:05:47 +0300
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
	bpf@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH net-next v5 02/10] net: free_netdev: exit earlier if dummy
Message-ID: <Zhaqyyk9CUaUvMDy@shredder>
References: <20240410131407.3897251-1-leitao@debian.org>
 <20240410131407.3897251-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410131407.3897251-3-leitao@debian.org>

On Wed, Apr 10, 2024 at 06:13:43AM -0700, Breno Leitao wrote:
> For dummy devices, exit earlier at free_netdev() instead of executing
> the whole function. This is necessary, because dummy devices are
> special, and shouldn't have the second part of the function executed.
> 
> Otherwise reg_state, which is NETREG_DUMMY, will be overwritten and
> there will be no way to identify that this is a dummy device. Also, this
> device do not need the final put_device(), since dummy devices are not
> registered (through register_netdevice()), where the device reference is
> increased (at netdev_register_kobject()/device_add()).
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

