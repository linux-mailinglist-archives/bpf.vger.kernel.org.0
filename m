Return-Path: <bpf+bounces-44818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 310879C7EDD
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 00:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87107B243F7
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 23:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFAB18CC1A;
	Wed, 13 Nov 2024 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="bzsrilZB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PlyyzBUg"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA73D18C326;
	Wed, 13 Nov 2024 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731541178; cv=none; b=hKb8FX3p8/Kvxpk0+usXKPLPxnuWKEqc+pJzQjSnOQwAUFNB/WwkJGSWJ7XVuwY6DI9q7ufbaQXqbyfz+xPLbVLlERlTNkYpuuNw9iqkhjnIGFs7UioNJKst8A1Gu2THfwAPAXE7ZYJajXXlJWEAcC57dD7ostGNVYvp9v+k46g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731541178; c=relaxed/simple;
	bh=tneqV0z6/NMAPjQSqSXJz97Pm26dx4gc27w29+7q038=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mNGkqnjiSIn59uIYVuOYQQYqDEMF0FE3iesPLqpaSwv5kuVtCINFQn/0bVJoMDh0NMf+YG3VC3sMAGwBNUcQk6F4X90vJdNYeWw9nesUkOoJRSvkiu/QIq7OSJCL7ihMTVQZZ/B2JEwSjN9GQUDx6duFzi2m4rIy20TwhKyZv/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=bzsrilZB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PlyyzBUg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CB921138041A;
	Wed, 13 Nov 2024 18:39:34 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Wed, 13 Nov 2024 18:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731541174;
	 x=1731627574; bh=useEsnKqznHXM4pU5hBEJUNcfh9usEj2IKw1xbWh/Vg=; b=
	bzsrilZBao6B2qZrs/jzc6/46sVL1grFywM2ApALvR72TJheQBJsg9/O7qGbp087
	Wg664OoT1la/q24O/XAX2GA9Amm2aMXJ2Wld0cNcbxqNTW8RxfyoCprqcP+QTU3n
	ByitoiyuSalfIfO0Ffx98gYrGiLMCyS7bSoLmeXiSuD6iVvI1FfRvX5DC3qC1jqc
	hy3GNM/bhRKnaZ/fUf3yGDy+HiHslCqS4aw6htnwoqkNvvhv1nrgpn160mzVdhEE
	NxzPcr/8zPyrtzFOrhweI+vDkGZpARcjMFKX8P4LL0f+dVSHe2mr2cKnE2DW2seq
	vsus2WAE92+0Yf0oTMr/eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731541174; x=
	1731627574; bh=useEsnKqznHXM4pU5hBEJUNcfh9usEj2IKw1xbWh/Vg=; b=P
	lyyzBUgvCqg7xtIUogfRx+70jOI4DMJyb/NUMDYhcJSPr290Eoilr4/N86yraqoB
	gSyoPMif6EdNxlVjD+98qzuCN1akfjORvfO7BeX9Azd07XAwSuggbjx8BOpY7SdT
	aTpGK8+dIwYsA9NA0QateuO76vrvk9q9VtbWvDn6Co82TBZFExfcVsh7fUH1mgI/
	PCCAUe2oS4rApsm60LEaHYe2t/XD8CkJIdYanfsOuYGgfsJx1jtdZTtz6uvLwKdj
	msRrN0pQsIK9MM76xTqp4q2etm8xoyRNU0unDvebyqDpibhB9r8C7fdlAJyGCc8/
	9p0aVVEVhJQ7UV9ON470Q==
X-ME-Sender: <xms:tjg1Z8fZkgejMzwq3xjHthR3A1OJNtldr3WH5GV46pDDQjE8Sny_ZQ>
    <xme:tjg1Z-OfmcZGrpIpDfyn3kUm_RMBQ76D5GLb6Ft3ALoGGfFnlqyPDIS8QfS0UnM2z
    poUc-Ejh4YxRtYjCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepofggfffhvfevkfgj
    fhfutgfgsehtjeertdertddtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepjedvffdthfejleeltdeigedv
    keetvdffieduteetgeejueffudfhueefvefhvdfgnecuffhomhgrihhnpehgihhthhhusg
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegugihusegugihuuhhurdighiiipdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgt
    phhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtth
    hopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghlvghkshgr
    nhguvghrrdhlohgsrghkihhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivg
    hlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtoheprghnughrihhisehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hhrgifkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:tjg1Z9hds8uzaCuP-hH7eV9aR1_v26Jp1pCfJ6mCOBe0-EoA2ZMNzA>
    <xmx:tjg1Zx9xsvnri4UIkFvxZd_L6-cFWoyXXqGkUYjeXhYA0FjeQFL6IA>
    <xmx:tjg1Z4vIcwnq_m8sp6b4_muunu4Xjq__IZV5nkLxjKbheSPqKhLrAA>
    <xmx:tjg1Z4Hhg_f6XQ5S0HaStNvGPXaA2o-sOV21125FnVbm5wMm6bY0KA>
    <xmx:tjg1Z4E3N0ihltngdsZBupuTkd2OzvICtOtWuTvAN76A4J38epCz2Yb1>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 01E6B18A0068; Wed, 13 Nov 2024 18:39:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 Nov 2024 15:39:13 -0800
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
Message-Id: <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
In-Reply-To: <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
References: <cover.1726480607.git.lorenzo@kernel.org>
 <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
 <ZwZe6Bg5ZrXLkDGW@lore-desk> <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk> <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Nov 12, 2024, at 9:43 AM, Alexander Lobakin wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Tue, 22 Oct 2024 17:51:43 +0200
>
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Date: Wed, 9 Oct 2024 14:50:42 +0200
>> 
>>> From: Lorenzo Bianconi <lorenzo@kernel.org>
>>> Date: Wed, 9 Oct 2024 14:47:58 +0200
>>>
>>>>> From: Lorenzo Bianconi <lorenzo@kernel.org>
>>>>> Date: Wed, 9 Oct 2024 12:46:00 +0200
>>>>>
>>>>>>> Hi Lorenzo,
>>>>>>>
>>>>>>> On Mon, Sep 16, 2024 at 12:13:42PM GMT, Lorenzo Bianconi wrote:
>>>>>>>> Add GRO support to cpumap codebase moving the cpu_map_entry kthread to a
>>>>>>>> NAPI-kthread pinned on the selected cpu.
>>>>>>>>
>>>>>>>> Changes in rfc v2:
>>>>>>>> - get rid of dummy netdev dependency
>>>>>>>>
>>>>>>>> Lorenzo Bianconi (3):
>>>>>>>>   net: Add napi_init_for_gro routine
>>>>>>>>   net: add napi_threaded_poll to netdevice.h
>>>>>>>>   bpf: cpumap: Add gro support
>>>>>>>>
>>>>>>>>  include/linux/netdevice.h |   3 +
>>>>>>>>  kernel/bpf/cpumap.c       | 123 ++++++++++++++++----------------------
>>>>>>>>  net/core/dev.c            |  27 ++++++---
>>>>>>>>  3 files changed, 73 insertions(+), 80 deletions(-)
>>>>>>>>
>>>>>>>> -- 
>>>>>>>> 2.46.0
>>>>>>>>
>>>>>>>
>>>>>>> Sorry about the long delay - finally caught up to everything after
>>>>>>> conferences.
>>>>>>>
>>>>>>> I re-ran my synthetic tests (including baseline). v2 is somehow showing
>>>>>>> 2x bigger gains than v1 (~30% vs ~14%) for tcp_stream. Again, the only
>>>>>>> variable I changed is kernel version - steering prog is active for both.
>>>>>>>
>>>>>>>
>>>>>>> Baseline (again)							
>>>>>>>
>>>>>>> ./tcp_rr -c -H $TASK_IP -p 50,90,99 -T4 -F8 -l30			        ./tcp_stream -c -H $TASK_IP -T8 -F16 -l30
>>>>>>> 							
>>>>>>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>>>>>>> Run 1	2560252	        0.00009087	0.00010495	0.00011647		Run 1	15479.31
>>>>>>> Run 2	2665517	        0.00008575	0.00010239	0.00013311		Run 2	15162.48
>>>>>>> Run 3	2755939	        0.00008191	0.00010367	0.00012287		Run 3	14709.04
>>>>>>> Run 4	2595680	        0.00008575	0.00011263	0.00012671		Run 4	15373.06
>>>>>>> Run 5	2841865	        0.00007999	0.00009471	0.00012799		Run 5	15234.91
>>>>>>> Average	2683850.6	0.000084854	0.00010367	0.00012543		Average	15191.76
>>>>>>> 							
>>>>>>> cpumap NAPI patches v2							
>>>>>>> 							
>>>>>>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>>>>>>> Run 1	2577838	        0.00008575	0.00012031	0.00013695		Run 1	19914.56
>>>>>>> Run 2	2729237	        0.00007551	0.00013311	0.00017663		Run 2	20140.92
>>>>>>> Run 3	2689442	        0.00008319	0.00010495	0.00013311		Run 3	19887.48
>>>>>>> Run 4	2862366	        0.00008127	0.00009471	0.00010623		Run 4	19374.49
>>>>>>> Run 5	2700538	        0.00008319	0.00010367	0.00012799		Run 5	19784.49
>>>>>>> Average	2711884.2	0.000081782	0.00011135	0.000136182		Average	19820.388
>>>>>>> Delta	1.04%	        -3.62%	        7.41%	        8.57%			        30.47%
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Daniel
>>>>>>
>>>>>> Hi Daniel,
>>>>>>
>>>>>> cool, thx for testing it.
>>>>>>
>>>>>> @Olek: how do we want to proceed on it? Are you still working on it or do you want me
>>>>>> to send a regular patch for it?
>>>>>
>>>>> Hi,
>>>>>
>>>>> I had a small vacation, sorry. I'm starting working on it again today.
>>>>
>>>> ack, no worries. Are you going to rebase the other patches on top of it
>>>> or are you going to try a different approach?
>>>
>>> I'll try the approach without NAPI as Kuba asks and let Daniel test it,
>>> then we'll see.
>> 
>> For now, I have the same results without NAPI as with your series, so
>> I'll push it soon and let Daniel test.
>> 
>> (I simply decoupled GRO and NAPI and used the former in cpumap, but the
>>  kthread logic didn't change)
>> 
>>>
>>> BTW I'm curious how he got this boost on v2, from what I see you didn't
>>> change the implementation that much?
>
> Hi Daniel,
>
> Sorry for the delay. Please test [0].
>
> [0] https://github.com/alobakin/linux/commits/cpumap-old
>
> Thanks,
> Olek

Ack. Will do probably early next week.

