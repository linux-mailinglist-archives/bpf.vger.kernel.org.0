Return-Path: <bpf+bounces-44045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 597329BCE4D
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 14:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2B66B2147C
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863A41D6DD1;
	Tue,  5 Nov 2024 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vF2fsweU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F261C1D45EA;
	Tue,  5 Nov 2024 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730814768; cv=none; b=Kg8xbaDlgiwYsqmkIAwZx6Hwz8AsHUaGyHETr6xAN3B6QoRTwd1aXzieXBv2KjagKo+1erAmEnFe+77Po6dl674JRGO6s77OdS43O2hnJmutxskwbLeihU+/hJPMmixL9TUoXM9Iu7cDcmCsBIxtRcMQ2kAEcfs63w8gMI7uKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730814768; c=relaxed/simple;
	bh=ewL5AOF1KLQkHhKjQIVNXmFcCdbS42Y8Ld0gyi2lRfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwlwxOEwrxhcP9vbW1mf82wcAIqTuI7+9ciqQ3LWmurAqrWFooYroGjCxTvJ65CcgIJILpO2g6SisVFZDRGpq/rq7GHS5INzVSiiVhsW/MMYt3ebgrQ8aRU71MWxJQcFMv5DxxRzuKaUgG2KYSAQRg1TS0TmmXzvI1EHZoimSRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vF2fsweU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F9FC4CECF;
	Tue,  5 Nov 2024 13:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730814767;
	bh=ewL5AOF1KLQkHhKjQIVNXmFcCdbS42Y8Ld0gyi2lRfQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vF2fsweU0e8Wk5yOUL1FnI8jQzYo4jmCC6+yOMVaGYMpUdD10GSiwzE2NwxeSDC4T
	 ciMqOpcS+KNYx1I5McpWaiBItT6+Z3gHP2tUOLWT62TznxyuXS9sOipFzbHjscgsmt
	 QJz+hLsH7L3Y+mmHrwpNim41d57neUda3rV7c/pF0zeSECUShMRHo00AIq1vA13wUw
	 6mUAC7tbS1WVJAEIMpm20YUV+//jm2wTnW57kk0H5kQt3558nyhrqNHaZXw2n1/dg/
	 E2AbunW5OoZ81a7vrb4NQFDn/k108mvlQNQFOElDlIXrVnxM/AkvupPGugSkRw9u4Y
	 hvdA4sUS1pvQQ==
Message-ID: <84bc09f6-6d3d-4f4b-a10f-a8c552ac65a6@kernel.org>
Date: Tue, 5 Nov 2024 15:52:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] net: ethernet: ti: am65-cpsw: Fix multi queue
 Rx on J7
To: Simon Horman <horms@kernel.org>, =?UTF-8?Q?P=C3=A9ter_Ujfalusi?=
 <peter.ujfalusi@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Md Danish Anwar <danishanwar@ti.com>,
 Govindarajan Sriramakrishnan <srk@ti.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241101-am65-cpsw-multi-rx-j7-fix-v3-0-338fdd6a55da@kernel.org>
 <20241101-am65-cpsw-multi-rx-j7-fix-v3-1-338fdd6a55da@kernel.org>
 <20241105132158.GC4507@kernel.org>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241105132158.GC4507@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Simon,

On 05/11/2024 15:21, Simon Horman wrote:
> On Fri, Nov 01, 2024 at 12:18:50PM +0200, Roger Quadros wrote:
>> On J7 platforms, setting up multiple RX flows was failing
>> as the RX free descriptor ring 0 is shared among all flows
>> and we did not allocate enough elements in the RX free descriptor
>> ring 0 to accommodate for all RX flows.
>>
>> This issue is not present on AM62 as separate pair of
>> rings are used for free and completion rings for each flow.
>>
>> Fix this by allocating enough elements for RX free descriptor
>> ring 0.
>>
>> However, we can no longer rely on desc_idx (descriptor based
>> offsets) to identify the pages in the respective flows as
>> free descriptor ring includes elements for all flows.
>> To solve this, introduce a new swdata data structure to store
>> flow_id and page. This can be used to identify which flow (page_pool)
>> and page the descriptor belonged to when popped out of the
>> RX rings.
>>
>> Fixes: da70d184a8c3 ("net: ethernet: ti: am65-cpsw: Introduce multi queue Rx")
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
>> @@ -764,8 +759,8 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
>>  
>>  fail_rx:
>>  	for (i = 0; i < common->rx_ch_num_flows; i++)
>> -		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, &rx_chn->flows[i],
>> -					  am65_cpsw_nuss_rx_cleanup, 0);
>> +		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, rx_chn,
>> +					  am65_cpsw_nuss_rx_cleanup, !!i);
> 
> Hi Roger,
> 
> I wonder if, as a follow-up, the skip_fdq (last) parameter of
> k3_udma_glue_reset_rx_chn() can be dropped. It seems that all callers
> follow the pattern above of passing i as the flow_num (2nd) argument,
> and !!i as the skip_fdq argument. If so, k3_udma_glue_reset_rx_chn could
> simply derive skip_fdq as !!flow_num.

Added Peter to the discussion.

My understanding is that this is not always the case as some users can still
decide to use separate free descriptor rings per flow. i.e. K3_RINGACC_RING_SHARED
flag not set in rxfdq_cfg.

But we could infer that bit from the flow configuration that is passed into
k3_udma_glue_rx_flow_init() and save this information into k3_udma_glue_rx_channel.

This could then be used internally and we drop skip_fdq argument.

Peter, do you agree?

-- 
cheers,
-roger

