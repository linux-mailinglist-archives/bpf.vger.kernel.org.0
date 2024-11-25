Return-Path: <bpf+bounces-45601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FF19D8EBF
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 23:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BC5288B7C
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 22:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B571CDA04;
	Mon, 25 Nov 2024 22:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="FStYZvZx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0vMhBEb8"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AA21B78F3;
	Mon, 25 Nov 2024 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732575433; cv=none; b=TJGXKCAPHbJOF+8frcAfjB+QuwkIBGk5cJbS2a1j/bZ76Yn/4yZjmBD3pBWGae8T+Pey1dBX0ltTtz74U/dvFYmRy8N1H9pGd9lrz3EaxBhH2HAsvR8qUNc7OPqnVK+UgXqH7NabiMVnBDvK+6Wi1HgQaOO760IbiCjb/zci+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732575433; c=relaxed/simple;
	bh=YogG0G1TBcHC3lyh02F8CIMiD0AwC3KztSfRE9Rcqgw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lSWLNiD2oH4zTea7yCC1CnCj9B1czLn9iwbBhw3CcTa1lPy36MF/HN88F/Uu8IZ2ZmVGj3Wd3i2MWu9LGMMH4ehk1dFpeZCJSSq0E1eB/CI3hU42BQWJB3oBzrsVrFfTa44LUFKrrxfa0fX7gRNJFLUFHOuX6121lXZHSCxH9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=FStYZvZx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0vMhBEb8; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9618511401D3;
	Mon, 25 Nov 2024 17:57:10 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Mon, 25 Nov 2024 17:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732575430;
	 x=1732661830; bh=ijzTN/SpjyhtGVgqirePfpk41e8BZ9geMcPGTqORSM4=; b=
	FStYZvZxPfm63pvMOwjdrX7o8Sg1p2MdZPgKx2yLH1H0fgf7Zhargnr/VRGQ2r0w
	I+fsBfiCsVnQ9tICL7eAColYXRLOdPWP6OJE8551AGsb8Nq7x7wnK/o8ZZSCUzXr
	JoyuZdFvGMz1bcHlITPMEWZ3vFYtIkU9s9EAcORCxyoaAqlua9Imdq4SvRPt4N7k
	iz7HVQ1+eglpVPXob1NPOWhv5BmPbdEvSXsYzxc6X8MMhIQLddZOldW9HzVco3K9
	ckLMGew8iGCtYaxeTKzofKydfKurcRQnagsOu0fd4OtrpLNS/b/cg9ocm6hKl/Mw
	jtkOBfQHO94e4fLQMEJQoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732575430; x=
	1732661830; bh=ijzTN/SpjyhtGVgqirePfpk41e8BZ9geMcPGTqORSM4=; b=0
	vMhBEb8bsPrafu1pKRRSa+7Rf+HO6KdnbsnU5dBWdMXSKrvo/gDx9aqmL6siUoFW
	NFkyNcFy8iG/2uuowRvT9GE4nMWD/1cDBD6P284vJqchnSp3rqpwuxRDtff720Xl
	FQPlFGQ49DYkkjy1gGXUmbA+RqS6qqNxXQE+oe73SezG/1/sDjV/pK7BHYCJtPka
	YKQyDeWqRpA2EIty8HWvRWMWBJLPCW0XDi3SFt9Gqj1O5ogVel+bapjRSvcWBuEk
	qUFfd/lhMQTI53LQxamUQ8GKBJYpC5YYMVfuPW5XbdJKI/DD/H9RxPu4bb9JBpqh
	DD1FGbsIVu1daD5Xg/ZQQ==
X-ME-Sender: <xms:xQBFZ8bCXDHe0YGi9gdPnGvmcegQwXTiManJ5MSkPtg-79tUGBaVBw>
    <xme:xQBFZ3bu-uXjoJngP2Hl5kTpmxvyUG5ALwnrbPqlZ_Z7Q02X-H21nyNSskfCKH-ei
    VaDdso9H28FdRYfTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepofggfffhvfevkfgj
    fhfutgfgsehtjeertdertddtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgeelieffhfduudeukefhieef
    gfffgeduleevjeefffeukefgtdelvddvfeefiedunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghr
    tghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopegrlhgvkhhsrghnuggvrhdrlhhosggrkhhinhesihhnthgvlhdr
    tghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtph
    htthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xQBFZ2_kPX4C-R6TvriavGWSkr-IssesBKp-JLBd_XvEVXfYt99lJg>
    <xmx:xQBFZ2ppzXg2OPXZ7xCaqYrxvIJqR7Pz_MfyoKEUkANWZa9mgkSpRw>
    <xmx:xQBFZ3riJlLYEzwmCa_sTPxqxst_ujqx2KwN8O5vhfsuddiSxERDtA>
    <xmx:xQBFZ0SmZv-Q0uoOO52-oy8MoW5pFgBv1vHHDEwD1MYdiEV-zelcjA>
    <xmx:xgBFZyDXyRAuqBMjU_WOpuM0U82kiuqneodx4QWc8fKHo2lGsiWc6I_U>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A6C0E18A006E; Mon, 25 Nov 2024 17:57:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Nov 2024 16:56:49 -0600
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Alexander Lobakin" <aleksander.lobakin@intel.com>
Cc: "Lorenzo Bianconi" <lorenzo@kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "David Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
 "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>
Message-Id: <a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
In-Reply-To: <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
References: <cover.1726480607.git.lorenzo@kernel.org>
 <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
 <ZwZe6Bg5ZrXLkDGW@lore-desk> <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk> <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
 <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
 <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Nov 25, 2024, at 9:12 AM, Alexander Lobakin wrote:
> From: Daniel Xu <dxu@dxuuu.xyz>
> Date: Fri, 22 Nov 2024 17:10:06 -0700
>
>> Hi Olek,
>> 
>> Here are the results.
>> 
>> On Wed, Nov 13, 2024 at 03:39:13PM GMT, Daniel Xu wrote:
>>>
>>>
>>> On Tue, Nov 12, 2024, at 9:43 AM, Alexander Lobakin wrote:
>
> [...]
>
>> Baseline (again)
>> 
>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>> Run 1	3169917	        0.00007295	0.00007871	0.00009343		Run 1	21749.43
>> Run 2	3228290	        0.00007103	0.00007679	0.00009215		Run 2	21897.17
>> Run 3	3226746	        0.00007231	0.00007871	0.00009087		Run 3	21906.82
>> Run 4	3191258	        0.00007231	0.00007743	0.00009087		Run 4	21155.15
>> Run 5	3235653	        0.00007231	0.00007743	0.00008703		Run 5	21397.06
>> Average	3210372.8	0.000072182	0.000077814	0.00009087		Average	21621.126
>> 
>> cpumap v2 Olek
>> 
>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>> Run 1	3253651	        0.00007167	0.00007807	0.00009343		Run 1	13497.57
>> Run 2	3221492	        0.00007231	0.00007743	0.00009087		Run 2	12115.53
>> Run 3	3296453	        0.00007039	0.00007807	0.00009087		Run 3	12323.38
>> Run 4	3254460	        0.00007167	0.00007807	0.00009087		Run 4	12901.88
>> Run 5	3173327	        0.00007295	0.00007871	0.00009215		Run 5	12593.22
>> Average	3239876.6	0.000071798	0.00007807	0.000091638		Average	12686.316
>> Delta	0.92%	        -0.53%	        0.33%	        0.85%			        -41.32%
>> 
>> 
>> It's very interesting that we see -40% tput w/ the patches. I went back
>
> Oh no, I messed up something =\
>
> Could you please also test not the whole series, but patches 1-3 (up to
> "bpf:cpumap: switch to GRO...") and 1-4 (up to "bpf: cpumap: reuse skb
> array...")? Would be great to see whether this implementation works
> worse right from the start or I just broke something later on.

Patches 1-3 reproduces the -40% tput numbers. 

With patches 1-4 the numbers get slightly worse (~1gbps lower) but it was noisy.

tcp_rr results were unaffected.

Thanks,
Daniel

