Return-Path: <bpf+bounces-36765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D85694CE2D
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 12:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203632821B9
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 10:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704921922EE;
	Fri,  9 Aug 2024 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUoONnBX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3654191F9E;
	Fri,  9 Aug 2024 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197757; cv=none; b=mLiFqRelywh7a96iGaHUkoM15d8ZKAdSUmX/SpaN7W26WbkgkesT2stdGF/9SRmfiDgLi+gbXCJLFPv8RqTuxkothrkYWkKN+hZVvzM9av3y97BShFpViUxGof0TOvlj82VcgtpCi4S/Q1+UqU6SQ1m7snBGzJpU73S3jfyc54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197757; c=relaxed/simple;
	bh=Gg6GNVZac8M0fXSanieB/ShknDd6zMF0dQYilGAgcns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2iWMUcJhOPlvUsvc9Mqmt1uFvmOmzuqOqK0AXCKlj7sr1KYpJk8li6lKexJs71YsE0NaMfHtGL75CMNRkr2DU9sNr9SgDBBr2evAa3oIKosSNU7Hvl/p8qanLK6glH18fsWWOb1pgGr9YH0rJ4yJNUHPRTPkA+vtxj1nokmH8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUoONnBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BCBC32782;
	Fri,  9 Aug 2024 10:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723197756;
	bh=Gg6GNVZac8M0fXSanieB/ShknDd6zMF0dQYilGAgcns=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GUoONnBX01q1eTQN5cQcbzN085bC+FZ14Wit95I4McXPw08lryC1W2l5A03EeNGXS
	 66MkwW0pbEcUau4s7QQZIZTH4nj+K7yh6UvrmuPstdNc2rmkhf6CkZbCEZDnH72lcd
	 bY7cN5/FCoDHE3JBUIY3gHszE60p0hBjWMufmzWsGCCO9tVHcqZ9+f/SwRM7638spq
	 F6rDA6I/c2sDuqMYYXjSDYZmpZh/7hRvj0O03A8goY8zn7cA580Q2Ugta25A4X6wWQ
	 rx4OzXqSBR6S/vbILgS7SuD4+NBLbou6OuDXPcvqt5byYWmF/gJEePOIQ2mupRErLr
	 SGsm1F+LZIadw==
Message-ID: <38b31e5b-57a6-44ab-a5ca-8f890bed6074@kernel.org>
Date: Fri, 9 Aug 2024 12:02:29 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to
 GRO from netif_receive_skb_list()
To: Daniel Xu <dxu@dxuuu.xyz>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, "toke@redhat.com"
 <toke@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 John Fastabend <john.fastabend@gmail.com>, Yajun Deng
 <yajun.deng@linux.dev>, Willem de Bruijn <willemb@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xdp-hints@xdp-project.net,
 Stanislav Fomichev <sdf@google.com>, kernel-team <kernel-team@cloudflare.com>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
 <308fd4f1-83a9-4b74-a482-216c8211a028@app.fastmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <308fd4f1-83a9-4b74-a482-216c8211a028@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 08/08/2024 22.52, Daniel Xu wrote:
> 
> On Thu, Aug 8, 2024, at 7:57 AM, Alexander Lobakin wrote:
>>
[...]
>> The only concern for having GRO in cpumap without metadata from the NIC
>> descriptor was that when the checksum status is missing, GRO calculates
>> the checksum on CPU, which is not really fast.
>> But I remember sometimes GRO was faster despite that.
 >
> Good to know, thanks. IIUC some kind of XDP hint support landed already?
> 

The XDP-hints ended-up being called 'XDP RX metadata' in kernel docs[1],
which makes it difficult to talk about without talking past each-other.
The TX side only got implemented for AF_XDP.

  [1] https://www.kernel.org/doc/html/latest/networking/xdp-rx-metadata.html
  [2] https://www.kernel.org/doc/html/latest/networking/xsk-tx-metadata.html

What landed 'XDP RX metadata'[1] is that we (via kfunc calls)  get
access to reading hardware RX offloads/hints directly from the
RX-descriptor. This implies a limitation that we only have access to
this data in the running XDP-program as the RX-descriptor is short lived.

Thus, we need to store the RX-descriptor information somewhere, to make
it available to 'cpumap' on the remote CPU. After failing to standardize
formatting XDP metadata area. My "new" opinion is that we should simply
extend struct xdp_frame with the fields needed for SKB creation.  Then
we can create some kfunc helpers that allow XDP-prog stores this info.


> My use case could also use HW RSS hash to avoid a rehash in XDP prog.
> And HW RX timestamp to not break SO_TIMESTAMPING. These two
> are on one of my TODO lists. But I can’t get to them for at least
> a few weeks. So free to take it if you’d like.

The kfuncs you need should be available:

  HW RSS hash = bpf_xdp_metadata_rx_hash()
  HW RX timestamp = bpf_xdp_metadata_rx_timestamp()

We just need to implement storing the information, such that it is
available to CPUMAP, and make it generic such that it also works for
veth when getting a XDP redirected xdp_frame.

Hoping someone can works on this soon,
--Jesper




