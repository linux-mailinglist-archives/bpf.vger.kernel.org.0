Return-Path: <bpf+bounces-30383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A29CC8CD197
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 13:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E01B1F22A31
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 11:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A600013BC35;
	Thu, 23 May 2024 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="3Bei+NqQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hB3LTyjW"
X-Original-To: bpf@vger.kernel.org
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A574113BAFA;
	Thu, 23 May 2024 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465469; cv=none; b=d7XRjwIWtMkwSf1dhYWmLJYIBkrHCNKuSs156Hi2JfSb9mVXQ44R94UgDVJGkzaFsnNWBDnQnAISl3NaetD1vbTU4v6tavDQxRFCYm1FloSrthrHZgbIFWN9A/ZbKNiJ9ItIL4YJux2s8239oZs52Ay8mGcrgy4JChmoGXNDWZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465469; c=relaxed/simple;
	bh=QM5IKcZN5RvrcFQh2uL0RP3WbNIjDxPpRh4An5D/hC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBE3ofnmYBgCsjo9qFGgZ+WBiv1z+H/pRcnrMS1t1wpdGWH/5nYvcZVRLHmtAlfZBvFJ2Ytcmh4y+unKdCis4qc8RW6r63yNOa5H7yeyZ4DWpcK3jR3GsJ2Dg6WvjBCRp5QvnDTw30/XchOQzW2jX9NrIBIk2bRnKI/XZcwyzgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=3Bei+NqQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hB3LTyjW; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id D77EF180017F;
	Thu, 23 May 2024 07:57:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 23 May 2024 07:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716465465; x=1716551865; bh=cdF/5ks+gM
	MxZAFnyrmZUGOhVVo9SQKIKtB3OVCVODA=; b=3Bei+NqQmDoWoGVY0MQphhb+I7
	tzv8g0BS8dh8OEACHJQy3k2e2pyFgueihF/2OjyDrHmsdvvV+FC/CPy29O1rCsH7
	Z0FaE7u8UKUthir76AsFN4qxsc+cRzRhymKh0kRnfi7VqOK7fu0gmT8q1ZiCnJ/V
	Qo6MiEaX9LUKSJtcwoeqWV2k02l+/5TrsHFBaRhMJDF7yDkPK7DrO3O9lEH7+URa
	7rXAvqIx7Pj+C8nQEc1X8BaurMTOl11fnSlYGBYxzSYYxxS5QZyJgYVlN+SpjtUM
	aTJpey7dtm1Z+hBcj5FD+WopEvKjE81eTCczFBYCsHa5vIdrFxXN5PJEYVPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716465465; x=1716551865; bh=cdF/5ks+gMMxZAFnyrmZUGOhVVo9
	SQKIKtB3OVCVODA=; b=hB3LTyjWhjUayDyxwERFyr53FYdxivNpvdrgVLIFtrQs
	Q97T4ENMb/8dHjtKwL0+sHeiP2v88TSDq9x4pWCCRq/fcJy+ZReihKiL2oNdyfzI
	kbkicjwcsYpUUgPLZ6NRYAva3/vP56yw/lM4rUC/0T4KFJmzKQPfSbIWm+OBBqBj
	cEVo1QkP5UAzbozAFMlyxXBJW1n0iEqKirzLyxTtb72T0vxpbvhOxDZj5RXNBkWU
	1gyoiU49/ZE0Z9BD3yS7XxAMpMo+Rx8HRl/WLthptaX6c9T0f2TC5ZJ9kpOQOs3X
	YGe++7ohm4Civh1oCUVqbwFm9ddI+Ol9NDzxD7Vv/g==
X-ME-Sender: <xms:OS9PZoNEL8YIpvYR2RKQSkJYnCiT0JtVBG_2mEA9c8poI0yVia25qg>
    <xme:OS9PZu_5Z-R5qAJZ4ugr0ijfVPjzhB18ss3B0qNfTcmVbOCXF37P9uJzXs6Vimb6z
    Iv0LKsTyEQKpQ>
X-ME-Received: <xmr:OS9PZvR8hkxQ8EBy-ysPJ0AfS6dDxMAeWumgFQaWz7_T9D8BqW51uRNeB4EroK4xFcldU48NqM3yfyRkN366qS5Qd7lr7xhsinQq_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:OS9PZgvYWXcHRCwNgPFWakA-RS2V-9B9eY5MnAivxQhsQtJ25VoGeg>
    <xmx:OS9PZgejwnm0cks63IRSc8Y4cpPsXYYVE-uK0SYRKZWT4R1XrDOarQ>
    <xmx:OS9PZk1QspP1RbVvOlluQNK2AYZ1UQaETCllNbSTVWBgIN51ebYBfA>
    <xmx:OS9PZk_wqlZ6fqYp_c2Rp_Ojg1TUIq1a1Q1Ot-suPx6cjTG699u2Ig>
    <xmx:OS9PZjtIxR4Ppi-r3mhFG5aVY1HhWAuiol9AG_Np5W4oTWegDt-UsW3->
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 May 2024 07:57:44 -0400 (EDT)
Date: Thu, 23 May 2024 13:57:43 +0200
From: Greg KH <greg@kroah.com>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Pengfei Xu <pengfei.xu@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH 6.6.y] bpf: Add missing BPF_LINK_TYPE invocations
Message-ID: <2024052328-squatting-umpire-a826@gregkh>
References: <20240521101826.95373-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521101826.95373-1-ignat@cloudflare.com>

On Tue, May 21, 2024 at 11:18:26AM +0100, Ignat Korchagin wrote:
> From: Jiri Olsa <jolsa@kernel.org>
> 
> commit 117211aa739a926e6555cfea883be84bee6f1695 upstream.
> 
> Pengfei Xu reported [1] Syzkaller/KASAN issue found in bpf_link_show_fdinfo.
> 
> The reason is missing BPF_LINK_TYPE invocation for uprobe multi
> link and for several other links, adding that.
> 
> [1] https://lore.kernel.org/bpf/ZXptoKRSLspnk2ie@xpf.sh.intel.com/
> 
> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
> Fixes: 84601d6ee68a ("bpf: add bpf_link support for BPF_NETFILTER programs")
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Acked-by: Hou Tao <houtao1@huawei.com>
> Link: https://lore.kernel.org/bpf/20231215230502.2769743-1-jolsa@kernel.org
> Cc: stable@vger.kernel.org # 6.6
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---
> Hi,
> 
> We have experienced a KASAN warning in production on a 6.6 kernel, similar to
> [1]. This backported patch was adjusted to apply onto 6.6 stable branch: the
> only change is dropping the BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
> definition from the header as netkit was only introduced in 6.7 and 6.7 has the
> backport already.
> 
> I was not able to run the syzkaller reproducer from [1], but we have not seen
> the KASAN warning in production since applying this patch internally.

Looks good, thanks for the backport, now queued up.

greg k-h

