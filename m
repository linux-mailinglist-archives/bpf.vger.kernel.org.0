Return-Path: <bpf+bounces-45629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A853D9D9C2F
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 18:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DC9165192
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 17:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169181DA614;
	Tue, 26 Nov 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWqMnIx0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7AC1D9359;
	Tue, 26 Nov 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641153; cv=none; b=OI833DnPFH7TnGPmxsUnttJaliUjethPX0RHlDPlODJ8KG/0R7GwryzSGAzYQeNmG6avq3rtvUW3dTgGiNwWrzmUdRoefXSosXO0RrZf2+rA7Xp8yVwuYyOvGVkKQyJg3Pu+bnoSQa4+mVbr3CoxNa4u9tnFZBf2z9PLB0dTCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641153; c=relaxed/simple;
	bh=GJlLPZYKCywC1S6ZZeuSzTiYuceyGZ+YsCS1nOxtYHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bN6/v2U1vWJHwRZK2VCoXWcb5f2PUwWoLThlSJYOcVV4Gv8PvBe1vdNehGb6bpx3EyxIraDxk2vQLhmXO9mNlwAo1qj9KcA247eK6LEA7lc1PTdaZOi7B5K869TJmXamVkrhPEudNUgBKzm2giVNUSKbY+oJqN8znKG7/qlrfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWqMnIx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038CFC4CECF;
	Tue, 26 Nov 2024 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732641153;
	bh=GJlLPZYKCywC1S6ZZeuSzTiYuceyGZ+YsCS1nOxtYHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KWqMnIx0+sc/mDY2OSaWgggXGwGfXudS+vdFnpKwrXSsF7k75h3KZOxvHtyW+MnNq
	 7KJzQqdvttiYB5oTSecsWiQ4o+zF7H0ybvK3VqLPY2sEu7PIaxUywC3pPuuRSixM6O
	 toeh7l0PKGSca0T2zuw1wXYzYi07RSy/qrrDumKHPQEtMEicqjVhm8HmsWQxD5DSKA
	 suizatGG+fcLkyVK6mJeLcSycPfd8K3KcMC+isZoyfDQSuYYHhPmKBgtvn+9U0XUjC
	 GwPOFNRhcv9633+80+7DHQPcFyIZkfkEAMg+jmPBrrEWgYn1z59SwCdKNZZ8HldQwc
	 hMAtk4rjdA43g==
Message-ID: <3f6e4935-a04c-44fc-8048-7645ae40b921@kernel.org>
Date: Tue, 26 Nov 2024 18:12:27 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Jakub Kicinski <kuba@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk> <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
 <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
 <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
 <a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
 <6db67537-6b7b-4700-9801-72b6640fc609@intel.com> <Z0X_Qv24e-A4Nxao@lore-desk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <Z0X_Qv24e-A4Nxao@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 26/11/2024 18.02, Lorenzo Bianconi wrote:
>> From: Daniel Xu <dxu@dxuuu.xyz>
>> Date: Mon, 25 Nov 2024 16:56:49 -0600
>>
>>>
>>>
>>> On Mon, Nov 25, 2024, at 9:12 AM, Alexander Lobakin wrote:
>>>> From: Daniel Xu <dxu@dxuuu.xyz>
>>>> Date: Fri, 22 Nov 2024 17:10:06 -0700
>>>>
>>>>> Hi Olek,
>>>>>
>>>>> Here are the results.
>>>>>
>>>>> On Wed, Nov 13, 2024 at 03:39:13PM GMT, Daniel Xu wrote:
>>>>>>
>>>>>>
>>>>>> On Tue, Nov 12, 2024, at 9:43 AM, Alexander Lobakin wrote:
>>>>
>>>> [...]
>>>>
>>>>> Baseline (again)
>>>>>
>>>>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>>>>> Run 1	3169917	        0.00007295	0.00007871	0.00009343		Run 1	21749.43
>>>>> Run 2	3228290	        0.00007103	0.00007679	0.00009215		Run 2	21897.17
>>>>> Run 3	3226746	        0.00007231	0.00007871	0.00009087		Run 3	21906.82
>>>>> Run 4	3191258	        0.00007231	0.00007743	0.00009087		Run 4	21155.15
>>>>> Run 5	3235653	        0.00007231	0.00007743	0.00008703		Run 5	21397.06
>>>>> Average	3210372.8	0.000072182	0.000077814	0.00009087		Average	21621.126
>>>>>
>>>>> cpumap v2 Olek
>>>>>
>>>>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>>>>> Run 1	3253651	        0.00007167	0.00007807	0.00009343		Run 1	13497.57
>>>>> Run 2	3221492	        0.00007231	0.00007743	0.00009087		Run 2	12115.53
>>>>> Run 3	3296453	        0.00007039	0.00007807	0.00009087		Run 3	12323.38
>>>>> Run 4	3254460	        0.00007167	0.00007807	0.00009087		Run 4	12901.88
>>>>> Run 5	3173327	        0.00007295	0.00007871	0.00009215		Run 5	12593.22
>>>>> Average	3239876.6	0.000071798	0.00007807	0.000091638		Average	12686.316
>>>>> Delta	0.92%	        -0.53%	        0.33%	        0.85%			        -41.32%
>>>>>
>>>>>
>>>>> It's very interesting that we see -40% tput w/ the patches. I went back
>>>>
>>>> Oh no, I messed up something =\
>>>>
>>>> Could you please also test not the whole series, but patches 1-3 (up to
>>>> "bpf:cpumap: switch to GRO...") and 1-4 (up to "bpf: cpumap: reuse skb
>>>> array...")? Would be great to see whether this implementation works
>>>> worse right from the start or I just broke something later on.
>>>
>>> Patches 1-3 reproduces the -40% tput numbers.
>>
>> Ok, thanks! Seems like using the hybrid approach (GRO, but on top of
>> cpumap's kthreads instead of NAPI) really performs worse than switching
>> cpumap to NAPI.
>>
>>>
>>> With patches 1-4 the numbers get slightly worse (~1gbps lower) but it was noisy.
>>
>> Interesting, I was sure patch 4 optimizes stuff... Maybe I'll give up on it.
>>
>>>
>>> tcp_rr results were unaffected.
>>
>> @ Jakub,
>>
>> Looks like I can't just use GRO without Lorenzo's conversion to NAPI, at
>> least for now =\ I took a look on the backlog NAPI and it could be used,
>> although we'd need a pointer in the backlog to the corresponding cpumap
>> + also some synchronization point to make sure backlog NAPI won't access
>> already destroyed cpumap.
>>
>> Maybe Lorenzo could take a look...
> 
> it seems to me the only difference would be we will use the shared backlog_napi
> kthreads instead of having a dedicated kthread for each cpumap entry but we still
> need the napi poll logic. I can look into it if you prefer the shared kthread
> approach.

I don't like a shared kthread approach. For my use-case I want to give
the "remote" CPU-map kthreads higher scheduling priority. (As it will be
running a 2nd XDP BPF DDoS program protecting against overload by 
dropping packets).

Thus, I'm not a fan of using the shared backlog_napi.  As I don't want
to give backlog NAPI high priority, in my use-case.

> @Jakub: what do you think?


--Jesper

