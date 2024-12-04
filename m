Return-Path: <bpf+bounces-46119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B65D9E4741
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 22:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D5E18803C1
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 21:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235B51925B8;
	Wed,  4 Dec 2024 21:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="p+pGhvgX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hv68a2qi"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA0923919F;
	Wed,  4 Dec 2024 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733349108; cv=none; b=m/XEHb0J/tjNxpzdXKVAw+Tjzte/ZRmL8/PA3GJY/g4Is4D4ntI5iz5t7TTrM/c9jo3PY/ZIFQTOpvuMHh1vK90qNPWJ4gF3SPFZVPz4OKHe7878sSFUz4V+ZzsnJlYPED4zBzb1QJ/UZHXKtZ5ZqTaU6kwebSu1BzBAm2nAVJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733349108; c=relaxed/simple;
	bh=/HKw8fVOd9hxl8YjiMKFb/5bYW2ramI7WzJsThdTDx0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FOadCxN5+tvgUFAC/sxaTrAD7gNmYorroiccH5idZNklLDGU9a2bepLfwCQxdEzGi4JQD+ga/K4PjUSHOA/L5jWeI7IOJZZqGmXXJoo5RUw1KwpsGth2s/zwtVyv5us2EehOibPEDzDZhmOb1bU1MVVeaciw8pBRzAzkW0O5XaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=p+pGhvgX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hv68a2qi; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 535AE114010D;
	Wed,  4 Dec 2024 16:51:44 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Wed, 04 Dec 2024 16:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733349104;
	 x=1733435504; bh=TE15c1mpZH7CypQLn1ar+nihRkaQdamdfMzIXkoHuG4=; b=
	p+pGhvgXHAsirYusuAwwvCUKogVt1Bnl0Ax2aBRXCuqKM8JFWXvPfJqBm8SIXDxf
	WA8uhdrIMQjK7sqi/DSHYakcPBkbijr3Pokob2Gg7ptriEin/Dt0iqh2mznJ9zun
	B3Z+Oxzl16quAEzsll5kOmZkSi82oAZMzs5CAsNMmgBkCvIDbNcqepEORYA4Dqw8
	ClTchY+PR053mhAN0iYi3cEXH7fkoYNldhebusJJGqVO+478phlZFIEkt7CLUAOo
	8vXHVFOmprNmepZ1frmsuqLTOKlDpPSaJR+iz85I1LQllD2o8Goaaqo/ngz+CXa+
	VwJ+9NfOpJVabDxBR6PNrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733349104; x=
	1733435504; bh=TE15c1mpZH7CypQLn1ar+nihRkaQdamdfMzIXkoHuG4=; b=H
	v68a2qiovpvri1Gvnsp/jI4ao72O/CXjCUIV9Y26kYU8KTUXu/mIwDXunO0lmB7B
	WbzHWY7UlWrL8p+qc7kyBCuYOWQnsdYPaGaXWFd30BxDvmq5aQhtVe0mpe9vpsw7
	oevgEmrC7def13K35J9z/iAGpVbdr2XwhTQ7gdiuOgyrofRshtAaM8+j+0n6GpaP
	NF7yNwtBW+uwJicniSEqbFLSI/SKNb6UBK6mxv5ZMSANg47O0nSIbet/9fOkK2CF
	jF1BAWZUQarORzoPeFrXSY+mDzUaajf0Qjtnx4Hco37uqLF0WFFr861swIBxsLF7
	4mV2g5ZbSSqQhP7ZCoBJA==
X-ME-Sender: <xms:785QZ-xWbahP2uFDkK5KXajVcWSU3Vp1RqEhA-t8vNJKeY1xB3t8zQ>
    <xme:785QZ6QmLAQQTVqrEVsXdDpIcgwn1lgBXTYcgmJs7GJ3MOXDX3gWkFUasgsImHkxi
    oPPzW96zx2ymxWRxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieehgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthejredtredttdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugi
    husegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeegleeifffhudduueekhfei
    fefgffegudelveejfeffueekgfdtledvvdeffeeiudenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggp
    rhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghn
    ugesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrd
    gtohhmpdhrtghpthhtoheprghlvghkshgrnhguvghrrdhlohgsrghkihhnsehinhhtvghl
    rdgtohhmpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtg
    hpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehhrgifkheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:785QZwUkFEDF_3Zpm5cMM4lsR1T1ToptQ1hleRr8xUn6YXKzyPBNJw>
    <xmx:785QZ0hAbzDWB9EMMzFWJu_f_tLaofTRt4T1fNZ_afh5Tu2jZZRVPA>
    <xmx:785QZwDTwoEj_wEmAmRtyKvIke7eBTecruoyZrhiIaTqq7H5qYE3dw>
    <xmx:785QZ1JzbE5gCxnHtSjM-UTC5_HKTBOCkZ63BfIZ017rgv805pR3nw>
    <xmx:8M5QZ4YPOXyi42i8Hv-AVl9TkhxeUxHERO06-2ARaIZh077oFmkWl9IY>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7D97E18A0068; Wed,  4 Dec 2024 16:51:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Dec 2024 13:51:08 -0800
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Alexander Lobakin" <aleksander.lobakin@intel.com>,
 "Jakub Kicinski" <kuba@kernel.org>
Cc: "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "David Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org
Message-Id: <ad43f37e-6e39-4443-9d42-61ebe8f78c54@app.fastmail.com>
In-Reply-To: <a0f4d9d8-86da-41f1-848d-32e53c092b34@intel.com>
References: <cover.1726480607.git.lorenzo@kernel.org>
 <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
 <ZwZe6Bg5ZrXLkDGW@lore-desk> <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk> <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
 <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
 <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
 <a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
 <6db67537-6b7b-4700-9801-72b6640fc609@intel.com>
 <20241202144739.7314172d@kernel.org>
 <4f49d319-bd12-4e81-9516-afd1f1a1d345@intel.com>
 <20241203165157.19a85915@kernel.org>
 <a0f4d9d8-86da-41f1-848d-32e53c092b34@intel.com>
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Dec 4, 2024, at 8:42 AM, Alexander Lobakin wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Tue, 3 Dec 2024 16:51:57 -0800
>
>> On Tue, 3 Dec 2024 12:01:16 +0100 Alexander Lobakin wrote:
>>>>> @ Jakub,  
>>>>
>>>> Context? What doesn't work and why?  
>>>
>>> My tests show the same perf as on Lorenzo's series, but I test with UDP
>>> trafficgen. Daniel tests TCP and the results are much worse than with
>>> Lorenzo's implementation.
>>> I suspect this is related to that how NAPI performs flushes / decides
>>> whether to repoll again or exit vs how kthread does that (even though I
>>> also try to flush only every 64 frames or when the ring is empty). Or
>>> maybe to that part of the kthread happens in process context outside any
>>> softirq, while when using NAPI, the whole loop is inside RX softirq.
>>>
>>> Jesper said that he'd like to see cpumap still using own kthread, so
>>> that its priority can be boosted separately from the backlog. That's why
>>> we asked you whether it would be fine to have cpumap as threaded NAPI in
>>> regards to all this :D
>> 
>> Certainly not without a clear understanding what the problem with 
>> a kthread is.
>
> Yes, sure thing.
>
> Bad thing's that I can't reproduce Daniel's problem >_< Previously, I
> was testing with the UDP trafficgen and got up to 80% improvement over
> the baseline. Now I tested TCP and got up to 70% improvement, no
> regressions whatsoever =\
>
> I don't know where this regression on Daniel's setup comes from. Is it
> multi-thread or single-thread test? 

8 threads with 16 flows over them (-T8 -F16)

> What app do you use: iperf, netperf,
> neper, Microsoft's app (forgot the name)?

neper, tcp_stream.

> Do you have multiple NUMA
> nodes on your system, are you sure you didn't cross the node when
> redirecting with the GRO patches / no other NUMA mismatches happened?

Single node. Technically EPYC NPS=1. So there are some numa characteristics
but I think the interconnect is supposed to hide it fairly efficiently.

> Some other random stuff like RSS hash key, which affects flow steering?

Whatever the default is - I'd be willing to be Kuba set up the configuration
at one point or another so it's probably sane. And with 5 runs it seems
unlikely the hashing would get unlucky and cause an imbalance.

>
> Thanks,
> Olek

Since I've got the setup handy and am motivated to see this work land,
do you have any other pointers for things I should look for? I'll spend some
time looking at profiles to see if I can identify any hot spots compared to
softirq based GRO.

Thanks,
Daniel

