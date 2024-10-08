Return-Path: <bpf+bounces-41302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51813995AFF
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 00:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A3D1F2360A
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 22:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066E72296F3;
	Tue,  8 Oct 2024 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="TUMCa14O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XrkyO81R"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AB8218D8C;
	Tue,  8 Oct 2024 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427173; cv=none; b=HTNEMIBcGR/OuitkiNEZi2auVOAP1TrtwMvnZz6zAGXo2TsUf+izPIZFSqjJkgqbuwUTLHqCZtVXFOwuuGSZBxLSTg4XYPaunoVLBCEzHWm0tyUEetQJc1eNuAHX+xCIYEgzt92/EEDTCw83V9J19pYXdOY8kOpi3Y82OwSGY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427173; c=relaxed/simple;
	bh=5Ve9Xu+e5nAAGQ0Op7mQCpc3uMDjiWsgGIrPQIqW1iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4esJ5ATGvmOb/vk7hlE48jCSCglFM05y9J+tWfzm43ER2GH3cLEAHuffu7ZXfXSsV270grQPmJiJyVOs6Ykqr8Gmd7iG3/k+3ow7oiO6eHPeMBmuEUQ2DM0MD8/EYLoB5lyIxtfgl72sOPr9YB4gP9nMScnG71jutRJFlTTvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=TUMCa14O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XrkyO81R; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A23D13802C0;
	Tue,  8 Oct 2024 18:39:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 08 Oct 2024 18:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728427170; x=1728513570; bh=D29g4Efbge
	gPzpZloul6/BdCu4yVEHe951RY9rZ+2eU=; b=TUMCa14OLeG57koOu5lnrgGc4c
	cwNI5h9xAcQF65WnriAHI414DyPEwPGjCuZJTOR8SLALU/ktKRMc9BJMgQAKTxk0
	TB9RMYCB98JIiDOc0C2wAvo1Q8+bW4q7pu5E1Zuzw+UJsYDt3ZOzbHTrnQG3yb2C
	orhaXahcvj0hU6vWYd0BgOSQcKrDukIj5/XlEQ/x4XXri4vVGPqJCqJqcD7SXrJb
	SszHqbi8QefUYKlNWhTu4pCkYMjw8SB3/TRXITs40RSQfXFbc7r6Hi3MJE6mTG+n
	UHqSLWd/BlEmdtqoIBNFlbAj4ouFLz8qbjN6Okad0x+67TJsGZRswKvvhKEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728427170; x=1728513570; bh=D29g4EfbgegPzpZloul6/BdCu4yV
	EHe951RY9rZ+2eU=; b=XrkyO81RzZCMjYSIuF2Y6e/c1+hPG/4+MQC4IuUP3hNv
	tLik7hIWiN4y7kHtBZquQoy0ZxKcjz0shd/gJ5gX0eqsgcM03hRMoxO/aPiUB/8Q
	Ka5UkNqSaW3p9BXPU/WX+nAfSG9utoiLe24/T9yG6okaAotYYpmZyFPC+tCDmKB2
	5TYg7nYsnOPEXeeIxEa7lFycTiIL2osD0QXlnEGvxkGCaUfCQBUZv6CXueTJktQH
	2prFqaJs3MYS+lGy9Hy+aXWsZiNgwTtwP6PGaqh/+NYCAX5zm/BEUhml3cOWAi3h
	XQQPm4cA0V0rMSG42m8GhH6rRvhRwWcUnBjUv90nRg==
X-ME-Sender: <xms:obQFZ8Ex37CgpBq3dkfGpHeURXCydsHqWfWgN4jizfdKsRV2kJTW1g>
    <xme:obQFZ1WxnVndhgvDUhqaPBCmL4ZCB7hAY4zo8wfZmZGNG3LdZ8yeg85y2gB6xR_zZ
    pVjn8JJuzMpwgG2ag>
X-ME-Received: <xmr:obQFZ2I3M_0nRcQDi2NPJlBmscnW9l_aE1HgmcOCL6Be4lcSKGOaP-mcCKnefoDHLNLlMv61Rj9NzDDs1qaa9sKgm47mxxRXZ0TG1O5xKbH-jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesug
    iguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffek
    uedukeehudffudfffffggeeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghp
    thhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhrvghniihose
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlh
    gvkhhsrghnuggvrhdrlhhosggrkhhinhesihhnthgvlhdrtghomhdprhgtphhtthhopegr
    shhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsg
    hogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    ephhgrfihksehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:obQFZ-EMzCHAnaY7LKCTyRniArDS9eC8onbPqjK8k4hgCxHq6-A0eg>
    <xmx:obQFZyVmI_EH7OpM3DzdJXZ9gPsh6hpPq0diajY3c9YoD_cVFEOEeQ>
    <xmx:obQFZxNY2jpQERfiG8JPRi2gmS2RllQIIiHSAMsJyV7_cgOul3PjLw>
    <xmx:obQFZ50jOljBMuV1oM5jrT_V3Sm_CGEPdfYiv15DwTVj_EiCjXmYzg>
    <xmx:orQFZ_VvPLaaMTSdW1r66tR9kzHfSpcN2HoP1ijZlPFrKxA4bJOS5qpH>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 18:39:27 -0400 (EDT)
Date: Tue, 8 Oct 2024 16:39:26 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org, kuba@kernel.org, aleksander.lobakin@intel.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	john.fastabend@gmail.com, hawk@kernel.org, martin.lau@linux.dev, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	lorenzo.bianconi@redhat.com
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
Message-ID: <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
References: <cover.1726480607.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726480607.git.lorenzo@kernel.org>

Hi Lorenzo,

On Mon, Sep 16, 2024 at 12:13:42PM GMT, Lorenzo Bianconi wrote:
> Add GRO support to cpumap codebase moving the cpu_map_entry kthread to a
> NAPI-kthread pinned on the selected cpu.
> 
> Changes in rfc v2:
> - get rid of dummy netdev dependency
> 
> Lorenzo Bianconi (3):
>   net: Add napi_init_for_gro routine
>   net: add napi_threaded_poll to netdevice.h
>   bpf: cpumap: Add gro support
> 
>  include/linux/netdevice.h |   3 +
>  kernel/bpf/cpumap.c       | 123 ++++++++++++++++----------------------
>  net/core/dev.c            |  27 ++++++---
>  3 files changed, 73 insertions(+), 80 deletions(-)
> 
> -- 
> 2.46.0
> 

Sorry about the long delay - finally caught up to everything after
conferences.

I re-ran my synthetic tests (including baseline). v2 is somehow showing
2x bigger gains than v1 (~30% vs ~14%) for tcp_stream. Again, the only
variable I changed is kernel version - steering prog is active for both.


Baseline (again)							

./tcp_rr -c -H $TASK_IP -p 50,90,99 -T4 -F8 -l30			        ./tcp_stream -c -H $TASK_IP -T8 -F16 -l30
							
	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
Run 1	2560252	        0.00009087	0.00010495	0.00011647		Run 1	15479.31
Run 2	2665517	        0.00008575	0.00010239	0.00013311		Run 2	15162.48
Run 3	2755939	        0.00008191	0.00010367	0.00012287		Run 3	14709.04
Run 4	2595680	        0.00008575	0.00011263	0.00012671		Run 4	15373.06
Run 5	2841865	        0.00007999	0.00009471	0.00012799		Run 5	15234.91
Average	2683850.6	0.000084854	0.00010367	0.00012543		Average	15191.76
							
cpumap NAPI patches v2							
							
	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
Run 1	2577838	        0.00008575	0.00012031	0.00013695		Run 1	19914.56
Run 2	2729237	        0.00007551	0.00013311	0.00017663		Run 2	20140.92
Run 3	2689442	        0.00008319	0.00010495	0.00013311		Run 3	19887.48
Run 4	2862366	        0.00008127	0.00009471	0.00010623		Run 4	19374.49
Run 5	2700538	        0.00008319	0.00010367	0.00012799		Run 5	19784.49
Average	2711884.2	0.000081782	0.00011135	0.000136182		Average	19820.388
Delta	1.04%	        -3.62%	        7.41%	        8.57%			        30.47%

Thanks,
Daniel

