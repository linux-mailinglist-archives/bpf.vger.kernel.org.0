Return-Path: <bpf+bounces-37010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 975DA95019B
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 11:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B365DB28161
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 09:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3969318C90C;
	Tue, 13 Aug 2024 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ytm7Tvhu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B119D18A94E;
	Tue, 13 Aug 2024 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542712; cv=none; b=WGNIDrPMvVZ4gM98lPcwGTv90QUwu1tOroOBQsoq1qxfae4KNncsUes+XWBODeoExv0mdWEs4SZRT64Ke9Sv5jEg83DCXr6plYNX/eFbO/ih9a9nqW7FUYT2j6Ho0P/JvX2gxnqE7jUaGdUZpWNHKwxEgbqNZ2XZgjqRsmfMcHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542712; c=relaxed/simple;
	bh=uVOY6MUqZfSq5bY4z+orE5FTCDv75mRnwySRQagyf+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwtZFTvTEnB+2xfilhFwlIkgTKNNysVhNGAaPbkIFL4yTJuW1uh/6A9xQQtgKe4teIu8vtYpbn1gzGnvYtSr/3Wh2hm8/iWcgVZBRB7MoNrAJQ8FbgHpEAhBIc8CTfghFp53iV4Ty3QIdKLTmX4gmhuntVWDG3qx88qw918y2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ytm7Tvhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09894C4AF09;
	Tue, 13 Aug 2024 09:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723542712;
	bh=uVOY6MUqZfSq5bY4z+orE5FTCDv75mRnwySRQagyf+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ytm7TvhuuejqWWg1WHrU3jv75npQYgUzDDT5st8BLE2SxX1uDkDV0E2HZLzS8jbC2
	 le65h2j5yY1CN+R5DzTnynWTPTTS+nTJ+loHoZN5Ib+Pja9YJC9jJWboCiM8SwaRUT
	 2+UToawwW62NZcJorDViGjTDo1D050P2H3KTirPlxzuOpu8Yf7Gj9r+p1FqUeQ05v2
	 Ny2NBKHPvom94GNNGVgrANr+ata9umSor01qhB4MlwECY48TOKuc91z6v0F4igIXBJ
	 /+aTwuiv3Ei0jozth6vmA+Xhde3NPflEoXODwfn+cxoxp0QqBKioU+/GNFILu/2aMx
	 e5AAAOwaKTRsA==
Message-ID: <25860d8b-a980-4f04-a376-b9cec03605fb@kernel.org>
Date: Tue, 13 Aug 2024 11:51:45 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to
 GRO from netif_receive_skb_list()
To: Jakub Kicinski <kuba@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Lorenzo Bianconi
 <lorenzo.bianconi@redhat.com>, Alexander Lobakin
 <alexandr.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, "toke@redhat.com"
 <toke@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 John Fastabend <john.fastabend@gmail.com>, Yajun Deng
 <yajun.deng@linux.dev>, Willem de Bruijn <willemb@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xdp-hints@xdp-project.net
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
 <308fd4f1-83a9-4b74-a482-216c8211a028@app.fastmail.com>
 <99662019-7e9b-410d-99fe-a85d04af215c@intel.com>
 <20240812183307.0b6fbd60@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240812183307.0b6fbd60@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/08/2024 03.33, Jakub Kicinski wrote:
> On Fri, 9 Aug 2024 14:20:25 +0200 Alexander Lobakin wrote:
>> But I think one solution could be:
>>
>> 1. We create some generic structure for cpumap, like
>>
>> struct cpumap_meta {
>> 	u32 magic;
>> 	u32 hash;
>> }
>>
>> 2. We add such check in the cpumap code
>>
>> 	if (xdpf->metalen == sizeof(struct cpumap_meta) &&
>> 	    <here we check magic>)
>> 		skb->hash = meta->hash;
>>
>> 3. In XDP prog, you call Rx hints kfuncs when they're available, obtain
>> RSS hash and then put it in the struct cpumap_meta as XDP frame metadata.
> 
> I wonder what the overhead of skb metadata allocation is in practice.
> With Eric's "return skb to the CPU of origin" we can feed the lockless
> skb cache one the right CPU, and also feed the lockless page pool
> cache. I wonder if batched RFS wouldn't be faster than the XDP thing
> that requires all the groundwork.

I explicitly developed CPUMAP because I was benchmarking Receive Flow
Steering (RFS) and Receive Packet Steering (RPS), which I observed was
the bottleneck.  The overhead was too large on the RX-CPU and bottleneck
due to RFS and RPS maintaining data structures to avoid Out-of-Order
packets.   The Flow Dissector step was also a limiting factor.

By bottleneck I mean it didn't scale, as RX-CPU packet per second
processing speeds was too low compared to the remote-CPU pps.
Digging in my old notes, I can see that RPS was limited to around 4.8
Mpps (and I have a weird disabling part of it showing 7.5Mpps).  In [1]
remote-CPU could process (starts at) 2.7 Mpps when dropping UDP packet
due to UdpNoPorts configured (and baseline 3.3 Mpps if not remote), thus
it only scales up-to 1.78 remote-CPUs.  [1] shows how optimizations
brings remote-CPU to handle 3.2Mpps (close non-remote to 3.3Mpps
baseline). In [2] those optimizations bring remote-CPU to 4Mpps (for
UdpNoPorts case).  XDP RX-redirect in [1]+[2] was around 19Mpps (which
might be lower today due to perf paper cuts).

  [1] 
https://github.com/xdp-project/xdp-project/blob/master/areas/cpumap/cpumap02-optimizations.org
  [2] 
https://github.com/xdp-project/xdp-project/blob/master/areas/cpumap/cpumap03-optimizations.org

The benefits Eric's "return skb to the CPU of origin" should help
improve the case for the remote-CPU, as I was seeing some bottlenecks in
how we returned the memory.

--Jesper

