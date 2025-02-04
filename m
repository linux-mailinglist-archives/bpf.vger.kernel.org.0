Return-Path: <bpf+bounces-50385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD112A26DEB
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 10:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A463218876D9
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A2207A0B;
	Tue,  4 Feb 2025 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="zNCoxmRP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MKluuBC0"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B602B206F12;
	Tue,  4 Feb 2025 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738660087; cv=none; b=Aclzr5nbtcDev/yUaEAYrk5ftUxVYsp2IctTBWw4SQeyfXqvXSgTjQ722FgrXZNWY7DoXGnE1aAE3P0yuLI/DaJHnrtOSU+b1VxKDENbSV/Tm3jprCPJq8IKXXErlFedDKlEnEjRZHChKf6Ff4h4aN0VXv0zRpNKRSgPXHNj0dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738660087; c=relaxed/simple;
	bh=3N8rmBt6w6IC+UE2Gj0l+DTcCjz26v0tcDsJCToYJX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/g+qxg2foLD/f7RLh5YMgbNgVInrzhiOOpcZ4nJARTzHBeLbQP6bGY+OrktIqcSKJx/ZM7sXVTHJBnYrDE5Nefm69mO98RCiWrpEH7q2UO7uMtHBwqwX31RyXsEDCSBz2sbARmZxzNamTEGqLeoM/zmxjBbOad1wcDHBHU3STk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=zNCoxmRP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MKluuBC0; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 353FF25401A9;
	Tue,  4 Feb 2025 04:08:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 04 Feb 2025 04:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738660084; x=1738746484; bh=tYEY8qzXf6
	wnHopVhFrMUfqLhkQ0l8tLQeb8HZj4fvw=; b=zNCoxmRPHA2QnazFXQ6xlT/GhU
	MT9fQx2QSPuElIewg/obAPl8nY4wLYjM4tXsx3oynLuBZWTbKiSEaNu7PlzdpZRI
	2kfJJtcqWvXSe7X8mz8KW8AwkJJwLTM5EdUjNukWgC2BUQta7dnfEzCBtwJvwjk4
	dOJzQ7W9+m7L23RpL6eWPn0LQd+zB+brA8HL7pOWPNRSahCBN5kJ3dSsCFNZBQZA
	p/ItPNdOLTSykEtaKHlIkcJxKADcooQt22g+WC9Oo5g1dTM6Sk/xSk3DeVbb2NMd
	WXK/QQ/XxpjPhURfDS0Z27NEDOZt1QgoWaaW6xgdTDY0HVZFQS+VuVF9+VmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738660084; x=1738746484; bh=tYEY8qzXf6wnHopVhFrMUfqLhkQ0l8tLQeb
	8HZj4fvw=; b=MKluuBC0wyYgxhwvW+gcmASnG/kEfm8LKGgFX2GfMgDHMCLmL/w
	3vgWyxXO8fitbkR1v1oGXb5eXdJGhy2949K/HpgJxWNZS8m/oR4VJerpG4KtL/5z
	pDiCNenHFaRdGgHj7fin36Q8S3aUnDz0pIBEKCUJSwcdNGTpJIZ8mWVCFEcpQHhT
	OKX6ifVOrWnRjflqgAvmDUbdSkobE+eVTLaNAmSRl7nisCOF99WBUu1ie6xfF7Ml
	EkXGWhr0hIUN7T/UTEA4C939VqPaCv5cCp63h49BxwTijr+td0cKvkMQO1Mld3Il
	hnBgXlvHwVj6WKJh/pTvo46qZmrdDJ0/rIg==
X-ME-Sender: <xms:89ihZ3N4_l6lIbTb0n62hkbhrLQTgQQGCiNdr1_bUjdqk-VU_6UQ3w>
    <xme:89ihZx-3ih5ae-l9ZQ3JhiK79gfmKIVwaLwAC0ONIolPR1BM4atlk0PVH0UzOuISZ
    IbKFwpoErLIdkgbvA>
X-ME-Received: <xmr:89ihZ2Qqikvk_ojNh0Dc-bNn1h6JzIO_f7KrEv5di4RGvRGfL2qa_RuqaCFUTjoTSi2y07xKP9Sdyc0t-wK7VKi-u4Ex2BvY9AYfs6dfNWHDtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffk
    fhggtggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihuse
    gugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgleetueetkeegieekheethfff
    leetkeeiiefgueffhedvveeiteehkeffgeduveenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepudehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehrshifohhrkhhtvggthhesohhuthhlohhokhdrtghomhdp
    rhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghsth
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohig
    rdhnvghtpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtg
    hpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhnghes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinh
    hugidruggvvhdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:89ihZ7tQ_Vw39PbGyPnjluY_t7Y4sR-9Grgs6v0e0bIABZ_QIlqy9A>
    <xmx:89ihZ_clCwFSrOYzRFRBerHXH7Ghv6Yc9R87aKaHhq4POLXTJmNc2w>
    <xmx:89ihZ32wdShWkQ9-zeTPUpzaUy42o9Nxlv13eNNP7Heqm5BCorSHBw>
    <xmx:89ihZ78EhoIazPHox1T6sfZD37mb2ZmDBAEHEvSq8mTCy-LbRkSPCg>
    <xmx:9NihZ3_7k2pFTAan3rbPyKVJozFfY19x-rm1CKNBVGpH4bSQN1TDvscC>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 04:08:01 -0500 (EST)
Date: Tue, 4 Feb 2025 02:07:59 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: rsworktech@outlook.com
Cc: Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Add comment about helper freeze
Message-ID: <vu3n3wgsuclwv66mnjdkvs4bm76fbyalvgytwn7mpgdyw4u7qs@k4rrcqc7c47b>
References: <20250204-bpf-helper-freeze-v1-1-46efd9ff20dc@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-bpf-helper-freeze-v1-1-46efd9ff20dc@outlook.com>

On Tue, Feb 04, 2025 at 10:00:21AM +0800, Levi Zim via B4 Relay wrote:
> From: Levi Zim <rsworktech@outlook.com>
> 
> Put a comment after the bpf helper list in uapi bpf.h to prevent people
> from trying to add new helpers there and direct them to kfuncs.
> 
> Link: https://lore.kernel.org/bpf/CAEf4BzZvQF+QQ=oip4vdz5A=9bd+OmN-CXk5YARYieaipK9s+A@mail.gmail.com/
> Link: https://lore.kernel.org/bpf/20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com/
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Levi Zim <rsworktech@outlook.com>
> ---
> Put a comment after the bpf helper list in uapi bpf.h to prevent people
> from trying to add new helpers there and direct them to kfuncs.
> ---
>  include/uapi/linux/bpf.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Daniel Xu <dxu@dxuuu.xyz>

