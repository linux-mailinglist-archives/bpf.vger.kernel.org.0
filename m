Return-Path: <bpf+bounces-46340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027309E7C95
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 00:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EFF188749F
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 23:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94636212FBB;
	Fri,  6 Dec 2024 23:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="dbYh5Sz+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y2S3znRI"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174D61D04A4;
	Fri,  6 Dec 2024 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733528193; cv=none; b=DBsw/s0Yhm2wqNwhW5Acxrxo6Qqrg9LkZvMa+AbbRv8SGGuSbqfIvuuvjV18cGufheQBrD2Ol1EDPRPVSgGUaTSD6J7gO3rMSl/AKxFsbrtdETSzeJhiA3PYCGZZOP6EsE11T9ChUceWK9JX2uONpIsVeUaXdmh0eyvlNafe/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733528193; c=relaxed/simple;
	bh=qfamPJxK40CWkfLZyhDb0ys2AXajeGtAY+7BGyFo7jQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NgQ5/jqX2oVVFKi3W1rFdTp0+Yi1awOf+8FW23uY2eMnWY2XsJjhSQAluunyNZKBorgh8/fa9p/mQIcJmU6+b4CxuVwietopF7dkjKazFcE1gbGIa8rZ45P5fQod9Bjf6PCQYc+rjWWqu7XKhKYut8EE7zy4a3TGXXp+yfsupks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=dbYh5Sz+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y2S3znRI; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F2F021140179;
	Fri,  6 Dec 2024 18:36:29 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Fri, 06 Dec 2024 18:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733528189;
	 x=1733614589; bh=nhgGwoGEspMVY6Q8Uph9fRjohtJ//0w3BgiP2F3gmTk=; b=
	dbYh5Sz+mMRXPyi0yHIIL6Lod8cMh9Kk6QyVdGdGT6RNl09EwyqtRjib/wewSW3G
	TUqWMJroslzE0cLRG7CXaVc9D54Z+A8jZOdFFrCmNNAwLv/JYnIgTdy/c29Zt+i7
	eGZAcb42Rszy2cnSR6BJsVvubw8P9/Lq2Y7pzp2o8sIduJ/9VavM0Zyj6YDqb77y
	y14V6Vx6AL9ApT51dH3cgYsEDnheVaKgci0rsy6BwMbUhMprOVN2VRqI7y+YwYex
	R3hyzrfvtHU/I9ioaUIBszknSBfir9UU5J9ikc+JP9Le/1KunvcBeJnhh6TkbzuZ
	aaR3pO0P+S5rmbL6b3A+1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733528189; x=
	1733614589; bh=nhgGwoGEspMVY6Q8Uph9fRjohtJ//0w3BgiP2F3gmTk=; b=y
	2S3znRIHINg2uFiOalCQtv281STbyd6QDh4AVyagVSKyJRCjC34sFTNajXzWGArp
	jaCp/d+jqq3+ZXk3oSjmCS2+MrbxZwdf3GNDk/xX6XXj8Eb53Gd4d76jjbBxkiJ0
	auu9avEmf5HM3098TIT61n5mXhAoHZRVhRDrdyA2O2nWuZ8U4rl+Wv0DR6/hdXJh
	7P9ufWPUw38MFn123woewL2hPnZ4feLGaTp3asHMvmXxj7NG1/rhUdOxsRKiiTlr
	zf02CG/hST7ydKurTJu5LOFoTAAgZZJaS8rJoXZpyvwny7wzn0zM0jzJel+cz8u0
	Ri5PTwNXk1OdDXh89bNJw==
X-ME-Sender: <xms:fYpTZ6yLDHgxvGokyAX2LGjo2Mej6JRm3HFu6wwnHAgi7WinDltFLQ>
    <xme:fYpTZ2QcWpVmm1fKu-QKg5WQk6P1u_s_oL-E2bt2ESCJ-GgSyQj6MCRkF2Htr8xMN
    NiyyiPmxRm3d9bRDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjedtgddtjecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:fYpTZ8VGcGgPfAOwry1RTGe4OIs__8wKQir3MfZRDbX5b_X3q6ZkMQ>
    <xmx:fYpTZwiM4q8rnVhH2KmLCVFX3iszB9p2kTw2OePN_yA0dajyUGiBFg>
    <xmx:fYpTZ8CT6LAy1FAfnQT5S44Z2KrYxO8C40f6bfDwJ0ACaMhdWxXTSA>
    <xmx:fYpTZxIFrH36tOcE_hEA-tJgcMgyGOV_hMwfNOUd2gZmtHkwM0WT-g>
    <xmx:fYpTZ0bMnhzGtkl9zZE0eDvg-IlbPFpE6kINnbj3CykagZMl52aBfLuV>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1DD6718A0068; Fri,  6 Dec 2024 18:36:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 06 Dec 2024 15:36:08 -0800
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Alexander Lobakin" <aleksander.lobakin@intel.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>,
 "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>,
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
Message-Id: <7b3bbb6f-5533-40ee-a7c5-c68ea7718fbe@app.fastmail.com>
In-Reply-To: <012d8975-13a4-4056-a6bf-f9140878cbdb@intel.com>
References: <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
 <a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
 <6db67537-6b7b-4700-9801-72b6640fc609@intel.com>
 <20241202144739.7314172d@kernel.org>
 <4f49d319-bd12-4e81-9516-afd1f1a1d345@intel.com>
 <20241203165157.19a85915@kernel.org>
 <a0f4d9d8-86da-41f1-848d-32e53c092b34@intel.com>
 <ad43f37e-6e39-4443-9d42-61ebe8f78c54@app.fastmail.com>
 <51c6e099-b915-4597-9f5a-3c51b1a4e2c6@intel.com>
 <27b2c3d4-c866-471c-ab33-e132370751e3@intel.com>
 <yzda66wro5twmzpmjoxvy4si5zvkehlmgtpi6brheek3sj73tj@o7kd6nurr3o6>
 <012d8975-13a4-4056-a6bf-f9140878cbdb@intel.com>
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Dec 6, 2024, at 7:06 AM, Alexander Lobakin wrote:
> From: Daniel Xu <dxu@dxuuu.xyz>
> Date: Thu, 5 Dec 2024 17:41:27 -0700
>
>> On Thu, Dec 05, 2024 at 12:06:29PM GMT, Alexander Lobakin wrote:
>>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> Date: Thu, 5 Dec 2024 11:38:11 +0100
>>>
>>>> From: Daniel Xu <dxu@dxuuu.xyz>
>>>> Date: Wed, 04 Dec 2024 13:51:08 -0800
>>>>
>>>>>
>>>>>
>>>>> On Wed, Dec 4, 2024, at 8:42 AM, Alexander Lobakin wrote:
>>>>>> From: Jakub Kicinski <kuba@kernel.org>
>>>>>> Date: Tue, 3 Dec 2024 16:51:57 -0800
>>>>>>
>>>>>>> On Tue, 3 Dec 2024 12:01:16 +0100 Alexander Lobakin wrote:
>>>>>>>>>> @ Jakub,  
>>>>>>>>>
>>>>>>>>> Context? What doesn't work and why?  
>>>>>>>>
>>>>>>>> My tests show the same perf as on Lorenzo's series, but I test with UDP
>>>>>>>> trafficgen. Daniel tests TCP and the results are much worse than with
>>>>>>>> Lorenzo's implementation.
>>>>>>>> I suspect this is related to that how NAPI performs flushes / decides
>>>>>>>> whether to repoll again or exit vs how kthread does that (even though I
>>>>>>>> also try to flush only every 64 frames or when the ring is empty). Or
>>>>>>>> maybe to that part of the kthread happens in process context outside any
>>>>>>>> softirq, while when using NAPI, the whole loop is inside RX softirq.
>>>>>>>>
>>>>>>>> Jesper said that he'd like to see cpumap still using own kthread, so
>>>>>>>> that its priority can be boosted separately from the backlog. That's why
>>>>>>>> we asked you whether it would be fine to have cpumap as threaded NAPI in
>>>>>>>> regards to all this :D
>>>>>>>
>>>>>>> Certainly not without a clear understanding what the problem with 
>>>>>>> a kthread is.
>>>>>>
>>>>>> Yes, sure thing.
>>>>>>
>>>>>> Bad thing's that I can't reproduce Daniel's problem >_< Previously, I
>>>>>> was testing with the UDP trafficgen and got up to 80% improvement over
>>>>>> the baseline. Now I tested TCP and got up to 70% improvement, no
>>>>>> regressions whatsoever =\
>>>>>>
>>>>>> I don't know where this regression on Daniel's setup comes from. Is it
>>>>>> multi-thread or single-thread test? 
>>>>>
>>>>> 8 threads with 16 flows over them (-T8 -F16)
>>>>>
>>>>>> What app do you use: iperf, netperf,
>>>>>> neper, Microsoft's app (forgot the name)?
>>>>>
>>>>> neper, tcp_stream.
>>>>
>>>> Let me recheck with neper -T8 -F16, I'll post my results soon.
>>>
>>> kernel     direct T1    direct T8F16    cpumap    cpumap T8F16
>>> clean      28           51              13        9               Gbps
>>> GRO        28           51              26        18              Gbps
>>>
>>> 100% gain, no regressions =\
>>>
>>> My XDP prog is simple (upstream xdp-tools repo with no changes):
>>>
>>> numactl -N 0 xdp-tools/xdp-bench/xdp-bench redirect-cpu -c 23 -s -p
>>> no-touch ens802f0np0
>>>
>>> IOW it simply redirects everything to CPU 23 (same NUMA node) from any
>>> Rx queue without looking into headers or packet.
>>> Do you test with more sophisticated XDP prog?
>> 
>> Great reminder... my prog is a bit more sophisticated. I forgot we were
>> doing latency tracking by inserting a timestamp into frame metadata. But
>> not clearing it after it was read on remote CPU, which disables GRO. So
>> previous test was paying the penalty of fixed GRO overhead without
>> getting any packet merges.
>> 
>> Once I fixed up prog to reset metadata pointer I could see the wins.
>> Went from 21621.126 Mbps -> 25546.47 Mbps for a ~18% win in tput. No
>> latency changes.
>> 
>> Sorry about the churn.
>
> No problem, crap happens sometimes :)
>
> Let me send my implementation on Monday-Wednesday. I'll include my UDP
> and TCP test results, as well as yours (+18%).
>
> BTW would be great if you could give me a Tested-by tag, as I assume the
> tests were fine and it works for you?

Yep, worked great for me.

Tested-by: Daniel Xu <dxu@dxuuu.xyz>

