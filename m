Return-Path: <bpf+bounces-71650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96447BF93FA
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 01:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 810BF4EA4A6
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 23:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E422D2BE620;
	Tue, 21 Oct 2025 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="RXGheFX+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dfg1W+co"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98273272811;
	Tue, 21 Oct 2025 23:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761089659; cv=none; b=ZxVOFMoIK2IS+l4D9gA1iXdk5yTZv3u8pGmmJpgfSzc5sxcgw3ObonwfC0WJkp2DKHPB9HcxvxD7WyQ3AEsRLcaMiZgyLJVGQCV9fctnXIN29fGkXmrow3Nd2fptOnneXtl7vJ3Oqg13GzJt+tkHRilmZRCbz6yJg+77y5aBvUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761089659; c=relaxed/simple;
	bh=iKQ6NZjIVGt6CXrDIvmK58j1AiuGRqwmeZkLZFuYnks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvvqR0+VbS/IEQrdU6B+glPxmNadt8fVny9+fxDnV8GQXnMvbWZskc02MGZqo32LaGYT8nWNaU+ulOfEx5nyPGrMeq2qciLIlZZGwduwTVQJJwNVdikv6NKPUY6daq/cdv7SkpXFrIKQPK5oh4oR7kRtkT2kxp66JossvJAnOVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=RXGheFX+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dfg1W+co; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A9F4314000E6;
	Tue, 21 Oct 2025 19:34:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 21 Oct 2025 19:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761089656;
	 x=1761176056; bh=Kb22k5eTEI944/lmkAd6Z30JOXuRH68q0Ki+lxe8kgs=; b=
	RXGheFX+Ffh9kCWC2hK7JYwYmK3agGq3iCGqemImOwc5fmpL9TwVExu405Di3l0V
	QBANKDCZCAwOQQWVvC73LMcG0WOXBt5ZguEgqvOn3ZEu46sDY+qJzF52j4HCmr1l
	1yWkpeZk8nvvr2eLRxE1253vZhZRGFUAaURlB7hP/RbTZMRWP1Yd6B7y1o1kBiEg
	seUDuZd+yyMEryr7MjabZq4y8XVnT3bJk3jyjyAPCKYPGBpPEuDFKaH4Hfk+r+Ik
	slx+GTK1wmyk+W0OAs727OeDbC9O6MlEE5AncXcDi2hGY6DmhxMtaCwzDILju81M
	kTQq2YbpM9PDBqCP6M0pRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761089656; x=
	1761176056; bh=Kb22k5eTEI944/lmkAd6Z30JOXuRH68q0Ki+lxe8kgs=; b=d
	fg1W+conZcCs7jx5QVJBjXy8NFftwuGcnOUjTOzYqVbJO0Y059IRowK8xwo8kshq
	w6v9CDEkwwoNlFQPiwVszt0tLKjpXiALU2CTRxAdFAlOJ2uGwrXc+zJaNQ3BKssJ
	WLU1qoqQU/Z/FhzDp/XOr0I6u0cjmim8byW9ilc90sNx8/OKRz/xf8arQiORbVSc
	5Zc2h/5nh1vuPoKDe4THJm9RHrrDi9nR5QIccMbYNVSkCIEcAalVkuwRZaAH4JFQ
	4phafeODAsucfNJxzSY6YXRPlAWPlnyYS+2/b0TjyemDMFywJ6r6EiAR/DBOnYBB
	UfbNRKxVGH3ZlfKzykRpA==
X-ME-Sender: <xms:eBj4aK3iNXSfuMJ35rukxGlmt4ifxmsGbqhmb2vV0lNDNdhFH1KD9g>
    <xme:eBj4aI_E-dhbiloGhPVYhrM-xtE2Fh9HLlIVU42Paj_YvJS6RrCvDNzs3FhJNsZfq
    ZfUlem_lIwcnSCz0wyY_XzZ9bwLwFvY8TuYewb-v4A73WZzya3o6g>
X-ME-Received: <xmr:eBj4aP5FkM7gaSX4O27_16y1hWEEgnA4zZjMuTfTk_JwBiyiFQKBhePDmwxZVXFiKkc40qce-pBq0CXGpQwY2g1V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepff
    ffveffieethfdviedthfdvjefhueeiffffheffvdegheeggedvudfggeehgedunecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohep
    uddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhmrgguvghushestghoug
    gvfihrvggtkhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhho
    uhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrnhgurhhiihdrnhgrkhhrhihikhhosehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhgthh
    hosehiohhnkhhovhdrnhgvthdprhgtphhtthhopehlihhnuhigpghoshhssegtrhhuuggv
    sgihthgvrdgtohhmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eBj4aAtsqRlbLqsoBRKIzk8HX6kb1wRnzHyi0yFpkg15QFv4J9aVXA>
    <xmx:eBj4aB0cqhC2FM-hTWCcKtlJXpUMBelC0CMbdj3fV3TJpMUaOIfkFw>
    <xmx:eBj4aJpDGjFu98qwyJGxyby3Fi3ALG3s-kavSezJ5XJkg-FPgy3qjA>
    <xmx:eBj4aBK7baVHPqC6hWb87Cqe7de_d2aq98D8RAUoLYt8So1FiMDiCw>
    <xmx:eBj4aAs56Pxt6s_lz2Zb1jy-rz-80LLFOFLx9kZDY99JqR3-vXo3tGwW>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 19:34:14 -0400 (EDT)
Message-ID: <39116c81-1798-4cc1-945c-a05d0ac7d8d9@maowtm.org>
Date: Wed, 22 Oct 2025 00:34:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] 9p cache=mmap regression fix (for 6.18-rc3)
To: Dominique Martinet <asmadeus@codewreck.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Song Liu <song@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
 v9fs@lists.linux.dev, bpf@vger.kernel.org
References: <20251022-mmap-regression-v1-1-980365ee524e@codewreck.org>
 <CAHzjS_s5EzJkvTqi73XS_9bBsaGuXu1zQ4jOLgcpC9vmJ7FoaA@mail.gmail.com>
 <aPgUaFE1oUq8e1F-@codewreck.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <aPgUaFE1oUq8e1F-@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 00:16, Dominique Martinet wrote:
> Hi Linus,
> 
> We had a regression with cache=mmap that impacted quite a few people so
> I'm sending a fix less than a couple of hours after making the commit.
> 
> If it turns out there are other side effects I'd suggest just reverting
> commit 290434474c33 ("fs/9p: Refresh metadata in d_revalidate for
> uncached mode too") first, but the fix is rather minimal so I think it's
> ok to try falling forward -- let me know if you prefer a revert and I'll
> send one instead (there's a minor conflict)

See the reply to the original patch [1] (posted right after, and before
seeing, this message) - there is indeed more side effects, and I wouldn't
mind a revert for now.  0172a934747f ("fs/9p: Invalidate dentry if inode
type change detected in cached mode") will need to be reverted too.

[1]: https://lore.kernel.org/v9fs/6c74ad63-3afc-4549-9ac6-494b9a63e839@maowtm.org/

