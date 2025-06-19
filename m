Return-Path: <bpf+bounces-61074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ADAAE0527
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 14:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203D73A9D4A
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 12:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123C822DFBE;
	Thu, 19 Jun 2025 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxRBK2Ns"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893C7258A;
	Thu, 19 Jun 2025 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334959; cv=none; b=fCDVu2Ug8dAFmxlEeigDfVUvbP8/ss8wh8qQjbj/6MipLeLtRy5LuWQUclUPTa/MV9Lej/HS5eAWfUjPZKl6zFTTmSoUZ4jw2dL2C8CuYYqXypWNZ+H3bQRnvgSFJLLTgWN7NZMxPBal3al6evxY72n8FNC0ZQLrNspM5XSXpg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334959; c=relaxed/simple;
	bh=yl86KSoo8hswMGhXsp32B/sx36wzzNqUuMUtV6U7f5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4GKwERCDGF1cLKk1Kjhmb5Vgj3DXLF2/3byjly/U33DMg9+Os/ExMlDNyW7F/Jp/4nrWynNFYp7PXUV70eg5oN24id3zbEc3x9imVfdwBVvf3pE982AlBmEhHtwevxSmV1eh9cg6K6kw0x+WQY3keQhu8X0v9FbVgE1z5wKTQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxRBK2Ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0888C4CEEE;
	Thu, 19 Jun 2025 12:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750334958;
	bh=yl86KSoo8hswMGhXsp32B/sx36wzzNqUuMUtV6U7f5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KxRBK2Nsgq6cIFVniLp3F7K9wH1ZvsAtUyrIm19qK9Yol5SOmwYaSsFrM9iHQCGrg
	 lCvDZa2p9wA2Ra/MqvoFqwehcneM7NgyWEPqAefhQfM2f8LjFihVJsLQ0qSQLxVeBA
	 X1iHqnS4iyayDJZDJElSNusWJjul1TLq7F464YruqFdUZHDIUrq54YPm76Ghz+D8ih
	 5k9Fcm1EgsCttteWo8pOeTE+zTgblCrQsl5+zAoIU9tCwvJ4h+Ye19A+1IcQ/8IgvK
	 7d/bIrFn91vzdzAaFpQ5KcweD9E5SY6HGMAyd+vSc6I/5ctdE8aAYcVVCYBpWuWhTT
	 9jObARHrxqv+A==
Message-ID: <cd4f2982-00ff-4e7b-88e1-6f6697da2c2f@kernel.org>
Date: Thu, 19 Jun 2025 14:09:11 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Performance impact of disabling VLAN offload [was: Re: [PATCH
 bpf-next V1 7/7] net: xdp: update documentation for xdp-rx-metadata.rst]
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Stanislav Fomichev <stfomichev@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <borkmann@iogearbox.net>, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 sdf@fomichev.me, kernel-team@cloudflare.com, arthur@arthurfabre.com,
 jakub@cloudflare.com, Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Willem Ferguson <wferguson@cloudflare.com>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net> <87plfbcq4m.fsf@toke.dk>
 <aEixEV-nZxb1yjyk@lore-rh-laptop> <aEj6nqH85uBe2IlW@mini-arch>
 <aFAQJKQ5wM-htTWN@lore-desk> <aFA8BzkbzHDQgDVD@mini-arch>
 <aFBI6msJQn4-LZsH@lore-desk> <87h60e4meo.fsf@toke.dk>
 <76a5330e-dc52-41ea-89c2-ddcde4b414bd@kernel.org> <875xgu4d6a.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <875xgu4d6a.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/06/2025 17.10, Toke Høiland-Jørgensen wrote:
>> Later we will look at using the vlan tag. Today we have disabled HW
>> vlan-offloading, because XDP originally didn't support accessing HW vlan
>> tags.
> 
> Side note (with changed subject to disambiguate): Do you have any data
> on the performance impact of disabling VLAN offload that you can share?
> I've been sort of wondering whether saving those couple of bytes has any
> measurable impact on real workloads (where you end up looking at the
> headers anyway, so saving the cache miss doesn't matter so much)?
> 

Our production setup have two different VLAN IDs, one for INTERNAL-ID
and one for EXTERNAL-ID (Internet) traffic.  On (many) servers this is
on the same physical net_device.

Our Unimog XDP load-balancer *only* handles EXTERNAL-ID.  Thus, the very
first thing Unimog does is checking the VLAN ID.  If this doesn't match
EXTERNAL-ID it returns XDP_PASS.  This is the first time packet data
area is read which (due to our AMD-CPUs) will be a cache-miss.

If this were INTERNAL-ID then we have caused a cache-miss earlier than
needed.  The NIC driver have already started a net_prefetch.  Thus, if
we can return XDP_PASS without touching packet data, then we can
(latency) hide part of the cache-miss (behind SKB-zero-ing). (We could
also CPUMAP redirect the INTERNAL-ID to a remote CPU for further gains).
  Using the kfunc (bpf_xdp_metadata_rx_vlan_tag[1]) for reading VLAN ID
doesn't touch/read packet data.

I hope this makes it clear why reading the HW offloaded VLAN tag from
the RX-descriptor is a performance benefit?

--Jesper

[1] https://docs.kernel.org/networking/xdp-rx-metadata.html

