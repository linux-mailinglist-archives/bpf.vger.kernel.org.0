Return-Path: <bpf+bounces-36809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A261D94D99B
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 02:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B5F283C30
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 00:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F2D22F19;
	Sat, 10 Aug 2024 00:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bq+P52dR"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A4F4E2
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 00:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723251266; cv=none; b=F4+ZxLB8ZYd1uI1pjV7gryh8+qsZAqdKwf0yMM3hEo9B4QNhaTDI3Kpr+k7BuDlrRMnZWNeQejIboXIe0ObTvOhq1vH+aMUgMhkt/MaDrDxXWzuPCtrizWROKLTgychCbuDHAQc4gwj1+Ecdtt1dikCQYEYdzAOYGPybej/HU+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723251266; c=relaxed/simple;
	bh=8w54Lrd7scq6J0HsSFrqqQIva2n5qF6f1A6YRh6HKKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPw+oo4NudxHBYmNa+oW7kVnePrcbpY4rdopaV4MvchnwbJ7K85WgjbV1s6l93jVYXHafijLoAU0F+I4npkf6wsnG4BquMwR5T6eE2OsywWYuC3gogcvFnV96DZrjI60J0ojraiortCtFqYXapRJWKTirwussTOAJdrir99qwRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bq+P52dR; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2396ed77-d359-4082-bcd2-2dd2de0bc214@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723251259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztowT8Y6AISiQZg+J3iUQVw7DYUQ5OBgixq1dBUh9PM=;
	b=bq+P52dRD1bhYXRdLHcxQnbuvmnfN0heFQOmPL7ErQbAz1Wte6Q/Ca4tO9KxTG1iUsmc4S
	Ue3S1uzw7SyekIAV7WR6asqMJGZfCbgKHYZdl40MyOnh4+B80JCIjqqKYsSCBMTjo/CLTV
	36PU1MKzCQ9LNhInMNAd7MBll9HNBSE=
Date: Fri, 9 Aug 2024 17:54:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to
 GRO from netif_receive_skb_list()
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Lorenzo Bianconi
 <lorenzo.bianconi@redhat.com>, Alexander Lobakin
 <alexandr.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
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
 <308fd4f1-83a9-4b74-a482-216c8211a028@app.fastmail.com>
 <99662019-7e9b-410d-99fe-a85d04af215c@intel.com> <875xs9q2z6.fsf@toke.dk>
 <22333deb-21f8-43a9-b32f-bc3e60892661@intel.com> <8734ndq0cd.fsf@toke.dk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <8734ndq0cd.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/9/24 6:42 AM, Toke Høiland-Jørgensen wrote:
> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
> 
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>> Date: Fri, 09 Aug 2024 14:45:33 +0200
>>
>>> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>>>
>>>> From: Daniel Xu <dxu@dxuuu.xyz>
>>>> Date: Thu, 08 Aug 2024 16:52:51 -0400
>>>>
>>>>> Hi,
>>>>>
>>>>> On Thu, Aug 8, 2024, at 7:57 AM, Alexander Lobakin wrote:
>>>>>> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
>>>>>> Date: Thu, 8 Aug 2024 06:54:06 +0200
>>>>>>
>>>>>>>> Hi Alexander,
>>>>>>>>
>>>>>>>> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
>>>>>>>>> cpumap has its own BH context based on kthread. It has a sane batch
>>>>>>>>> size of 8 frames per one cycle.
>>>>>>>>> GRO can be used on its own, adjust cpumap calls to the
>>>>>>>>> upper stack to use GRO API instead of netif_receive_skb_list() which
>>>>>>>>> processes skbs by batches, but doesn't involve GRO layer at all.
>>>>>>>>> It is most beneficial when a NIC which frame come from is XDP
>>>>>>>>> generic metadata-enabled, but in plenty of tests GRO performs better
>>>>>>>>> than listed receiving even given that it has to calculate full frame
>>>>>>>>> checksums on CPU.
>>>>>>>>> As GRO passes the skbs to the upper stack in the batches of
>>>>>>>>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
>>>>>>>>> device where the frame comes from, it is enough to disable GRO
>>>>>>>>> netdev feature on it to completely restore the original behaviour:
>>>>>>>>> untouched frames will be being bulked and passed to the upper stack
>>>>>>>>> by 8, as it was with netif_receive_skb_list().
>>>>>>>>>
>>>>>>>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>>>>>>>>> ---
>>>>>>>>>   kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>>>>>>>>>   1 file changed, 38 insertions(+), 5 deletions(-)
>>>>>>>>>
>>>>>>>>
>>>>>>>> AFAICT the cpumap + GRO is a good standalone improvement. I think
>>>>>>>> cpumap is still missing this.
>>>>>>
>>>>>> The only concern for having GRO in cpumap without metadata from the NIC
>>>>>> descriptor was that when the checksum status is missing, GRO calculates
>>>>>> the checksum on CPU, which is not really fast.
>>>>>> But I remember sometimes GRO was faster despite that.
>>>>>
>>>>> Good to know, thanks. IIUC some kind of XDP hint support landed already?
>>>>>
>>>>> My use case could also use HW RSS hash to avoid a rehash in XDP prog.
>>>>
>>>> Unfortunately, for now it's impossible to get HW metadata such as RSS
>>>> hash and checksum status in cpumap. They're implemented via kfuncs
>>>> specific to a particular netdevice and this info is available only when
>>>> running XDP prog.
>>>>
>>>> But I think one solution could be:
>>>>
>>>> 1. We create some generic structure for cpumap, like
>>>>
>>>> struct cpumap_meta {
>>>> 	u32 magic;
>>>> 	u32 hash;
>>>> }
>>>>
>>>> 2. We add such check in the cpumap code
>>>>
>>>> 	if (xdpf->metalen == sizeof(struct cpumap_meta) &&
>>>> 	    <here we check magic>)
>>>> 		skb->hash = meta->hash;
>>>>
>>>> 3. In XDP prog, you call Rx hints kfuncs when they're available, obtain
>>>> RSS hash and then put it in the struct cpumap_meta as XDP frame metadata.
>>>
>>> Yes, except don't make this cpumap-specific, make it generic for kernel
>>> consumption of the metadata. That way it doesn't even have to be stored
>>> in the xdp metadata area, it can be anywhere we want (and hence not
>>> subject to ABI issues), and we can use it for skb creation after
>>> redirect in other places than cpumap as well (say, on veth devices).
>>>
>>> So it'll be:
>>>
>>> struct kernel_meta {
>>> 	u32 hash;
>>> 	u32 timestamp;
>>>          ...etc
>>> }
>>>
>>> and a kfunc:
>>>
>>> void store_xdp_kernel_meta(struct kernel meta *meta);
>>>
>>> which the XDP program can call to populate the metadata area.
>>
>> Hmm, nice!
>>
>> But where to store this info in case of cpumap if not in xdp->data_meta?

The cpumap has a xdp program. Instead of the kernel's cpumap code building the 
skb, the cpumap's xdp prog could build the skb itself and directly use the 
xdp->data_meta to init the skb.

I recall there was discussion about doing gro in a bpf prog (I may be 
mis-remembering though). If possible, then the cpumap's xdp prog can also do the 
gro?

>> When you convert XDP frames to skbs in the cpumap code, you only have
>> &xdp_frame and that's it. XDP prog was already run earlier from the
>> driver code at that point.
> 
> Well, we could put it in skb_shared_info? IIRC, some of the metadata
> (timestamps?) end up there when building an skb anyway, so we won't even
> have to copy it around...

