Return-Path: <bpf+bounces-37052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C871950998
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 17:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F199B24A7A
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77871A08C5;
	Tue, 13 Aug 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdCX8VNJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C1D1A08A3;
	Tue, 13 Aug 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564671; cv=none; b=hAv0TiuCd972aiC1xEsECAXUlB00rP+oFWiZHQwG+6JJzuYtgFtfFMc10peVw7dIVrH35viYlWydleEWcFNr+z5TMPO2EB0fEfmPAvmziL0ew9Akk1jFqg0Tea9iduL8ldY6FamOh26VGH9ygOTYuWbxKEqxVRRRtF/kmeFeRug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564671; c=relaxed/simple;
	bh=0xi5AT6zUg1ZXFT0NFQY+gVhVfp0M/lxZ7XtHuU3RF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXfPvXIT3bPXGgPa6fi6A6KCBZAu1JtGjFAkenUAo9+Js19Wxq0NaqzwFiq0S0fHvTmoiUfGNndW1pWgd5dBN2SORXUieImsGQrpXQjZD+I/n2Eqo4QM8Ckknhaq2rFGyi4IRpWiBAnad58jcMQsGrfLYD+B7MapILDVNnLW4mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdCX8VNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD059C4AF09;
	Tue, 13 Aug 2024 15:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723564671;
	bh=0xi5AT6zUg1ZXFT0NFQY+gVhVfp0M/lxZ7XtHuU3RF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DdCX8VNJe90QKoQX216sdtt9T+80ps80Eq1X5Kbok2xhjLLTd5kRnC/6TXTs7FhyY
	 e4szbm7fiMeU/FI/4p1sYeZdqoTpUZn3GJDa/pvaNjcPg4yoLM4a8C1VEbho087Exp
	 Z8r76OpysB7oRoECbolGR2JsON8f7L+rot3dJsMz5opR5o5UWnPkjROADRbFoZalaX
	 YhCKRj9izVhJRmhDn/VJ7+LWNANMXsjJ1CAjeoAu3K3k/0ahHsQ/KGywOO4mrCZzXv
	 +1ZpuRzL9fDdjupqGtHiWiLZ7vZQG8B+i6o+TjhLq4TAlVbpKzKtBAZcLaNsl/uwUK
	 zX7/+WyGjRf6A==
Message-ID: <34cc17a1-dee2-4eb0-9b24-7b264cb63521@kernel.org>
Date: Tue, 13 Aug 2024 17:57:44 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to
 GRO from netif_receive_skb_list()
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Daniel Xu <dxu@dxuuu.xyz>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
 Yajun Deng <yajun.deng@linux.dev>, Willem de Bruijn <willemb@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xdp-hints@xdp-project.net
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
 <e0616dcc-1007-4faf-8825-6bf536799cbf@intel.com> <874j7oean6.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <874j7oean6.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/08/2024 16.54, Toke Høiland-Jørgensen wrote:
> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
> 
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Date: Thu, 8 Aug 2024 13:57:00 +0200
>>
>>> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
>>> Date: Thu, 8 Aug 2024 06:54:06 +0200
>>>
>>>>> Hi Alexander,
>>>>>
>>>>> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
>>>>>> cpumap has its own BH context based on kthread. It has a sane batch
>>>>>> size of 8 frames per one cycle.
>>>>>> GRO can be used on its own, adjust cpumap calls to the
>>>>>> upper stack to use GRO API instead of netif_receive_skb_list() which
>>>>>> processes skbs by batches, but doesn't involve GRO layer at all.
>>>>>> It is most beneficial when a NIC which frame come from is XDP
>>>>>> generic metadata-enabled, but in plenty of tests GRO performs better
>>>>>> than listed receiving even given that it has to calculate full frame
>>>>>> checksums on CPU.
>>>>>> As GRO passes the skbs to the upper stack in the batches of
>>>>>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
>>>>>> device where the frame comes from, it is enough to disable GRO
>>>>>> netdev feature on it to completely restore the original behaviour:
>>>>>> untouched frames will be being bulked and passed to the upper stack
>>>>>> by 8, as it was with netif_receive_skb_list().
>>>>>>
>>>>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>>>>>> ---
>>>>>>   kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>>>>>>   1 file changed, 38 insertions(+), 5 deletions(-)
>>>>>>
>>>>>
>>>>> AFAICT the cpumap + GRO is a good standalone improvement. I think
>>>>> cpumap is still missing this.
>>>
>>> The only concern for having GRO in cpumap without metadata from the NIC
>>> descriptor was that when the checksum status is missing, GRO calculates
>>> the checksum on CPU, which is not really fast.
>>> But I remember sometimes GRO was faster despite that.
>>>
>>>>>
>>>>> I have a production use case for this now. We want to do some intelligent
>>>>> RX steering and I think GRO would help over list-ified receive in some cases.
>>>>> We would prefer steer in HW (and thus get existing GRO support) but not all
>>>>> our NICs support it. So we need a software fallback.
>>>>>
>>>>> Are you still interested in merging the cpumap + GRO patches?
>>>
>>> For sure I can revive this part. I was planning to get back to this
>>> branch and pick patches which were not related to XDP hints and send
>>> them separately.
>>>
>>>>
>>>> Hi Daniel and Alex,
>>>>
>>>> Recently I worked on a PoC to add GRO support to cpumap codebase:
>>>> - https://github.com/LorenzoBianconi/bpf-next/commit/a4b8264d5000ecf016da5a2dd9ac302deaf38b3e
>>>>    Here I added GRO support to cpumap through gro-cells.
>>>> - https://github.com/LorenzoBianconi/bpf-next/commit/da6cb32a4674aa72401c7414c9a8a0775ef41a55
>>>>    Here I added GRO support to cpumap trough napi-threaded APIs (with a some
>>>>    changes to them).
>>>
>>> Hmm, when I was testing it, adding a whole NAPI to cpumap was sorta
>>> overkill, that's why I separated GRO structure from &napi_struct.
>>>
>>> Let me maybe find some free time, I would then test all 3 solutions
>>> (mine, gro_cells, threaded NAPI) and pick/send the best?
>>>
>>>>
>>>> Please note I have not run any performance tests so far, just verified it does
>>>> not crash (I was planning to resume this work soon). Please let me know if it
>>>> works for you.
>>
>> I did tests on both threaded NAPI for cpumap and my old implementation
>> with a traffic generator and I have the following (in Kpps):
>>

What kind of traffic is the traffic generator sending?

E.g. is this a type of traffic that gets GRO aggregated?

>>              direct Rx    direct GRO    cpumap    cpumap GRO
>> baseline    2900         5800          2700      2700 (N/A)
>> threaded                               2300      4000
>> old GRO                                2300      4000
>>

Nice results. Just to confirm, the units are in Kpps.


>> IOW,
>>
>> 1. There are no differences in perf between Lorenzo's threaded NAPI
>>     GRO implementation and my old implementation, but Lorenzo's is also
>>     a very nice cleanup as it switches cpumap to threaded NAPI completely
>>     and the final diffstat even removes more lines than adds, while mine
>>     adds a bunch of lines and refactors a couple hundred, so I'd go with
>>     his variant.
>>
>> 2. After switching to NAPI, the performance without GRO decreases (2.3
>>     Mpps vs 2.7 Mpps), but after enabling GRO the perf increases hugely
>>     (4 Mpps vs 2.7 Mpps) even though the CPU needs to compute checksums
>>     manually.
> 
> One question for this: IIUC, the benefit of GRO varies with the traffic
> mix, depending on how much the GRO logic can actually aggregate. So did
> you test the pathological case as well (spraying packets over so many
> flows that there is basically no aggregation taking place)? Just to make
> sure we don't accidentally screw up performance in that case while
> optimising for the aggregating case :)
> 

For the GRO use-case, I think a basic TCP stream throughput test (like
netperf) should show a benefit once cpumap enable GRO, Can you confirm this?
Or does the missing hardware RX-hash and RX-checksum cause TCP GRO not
to fully work, yet?

Thanks A LOT for doing this benchmarking!
--Jesper


