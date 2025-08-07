Return-Path: <bpf+bounces-65239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA606B1DD59
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 21:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A74357B3F8B
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 19:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE702737EC;
	Thu,  7 Aug 2025 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9SZRRT4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067B4438B;
	Thu,  7 Aug 2025 19:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593684; cv=none; b=izoNYpE/RAK1reMvZWrgaiKP0h2lql/XcwYY5GFUjGfR77nDbBQOr7nEONitwG+rAjZNdQCjUQYNeU/ak+KYM+NH+O27N0oHAqf864QvrGsx07XwOugViVPhp2hSKnWPmRXnfFDrxoCufSGoxkk2bpKLp66G4r1rz7AqqdCfk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593684; c=relaxed/simple;
	bh=lINnFZ7ww0dKIl+Yla/gKVikbcud51Ye/UUgQcJ+O6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYglLBXtKX+bNH3uLZ5DxHMtkbJX4e1TxK5arsMFPyhLS+MBB5XeyNy/rX0FN5iDLvYhiLE/N+eF6byj4yB2Bt4mLgklL5oK45voRoDnhBxo2OdY/6gR+dWc4Ks9dvscMqgC6mtnv5Is4jef+ttp6AhfcXcLpuua1VeBrDuOyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9SZRRT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406CBC4CEEB;
	Thu,  7 Aug 2025 19:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754593684;
	bh=lINnFZ7ww0dKIl+Yla/gKVikbcud51Ye/UUgQcJ+O6k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D9SZRRT4HcUSutIYyt4k5rVPHIT4OQTkLI96nWEBCRPOjtU7SpOmQAb4VQAN34rdF
	 3g1WtqRcPVYhzS6EyOwQUyACqhixT+gb3Oalr6HbpHELG1+ChE9DtU2zFjgKQAqRA6
	 v5p23B/J9ufWT/csXbO50ZHPXkdlQU1kyF8kRDPrlPiYpKBmY/btBwzdK5AhCMEiye
	 zUh/WIQrkE5jixpdLYjT1XqK5nQY5sxUWElPTkxrDO1+V8EF5T4pHR6QsN7eTw+gC2
	 4Ho9x4ASJ4migAIE6ceWBBDRJyJMbKgWF7fSUJbjzY0L3q44/vVBLZ8DgDLV91x8mm
	 Bz+tNWHo9Izxw==
Message-ID: <20a3558f-43c5-46a2-8395-c6d966ea5caf@kernel.org>
Date: Thu, 7 Aug 2025 21:07:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Stanislav Fomichev <stfomichev@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Andrew Rzeznik <arzeznik@cloudflare.com>
References: <b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
 <aGvcb53APFXR8eJb@mini-arch> <aG427EcHHn9yxaDv@lore-desk>
 <aHE2F1FJlYc37eIz@mini-arch> <aHeKYZY7l2i1xwel@lore-desk>
 <20250716142015.0b309c71@kernel.org>
 <fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
 <20250717182534.4f305f8a@kernel.org>
 <ebc18aba-d832-4eb6-b626-4ca3a2f27fe2@kernel.org>
 <20250721181344.24d47fa3@kernel.org> <aIdWjTCM1nOjiWfC@lore-desk>
 <20250728092956.24a7d09b@kernel.org>
 <b23ed0e2-05cf-454b-bf7a-a637c9bb48e8@kernel.org>
 <4eaf6d02-6b4e-4713-a8f8-6b00a031d255@linux.dev>
 <21f4ee22-84f0-4d5e-8630-9a889ca11e31@kernel.org>
 <20250801133803.7570a6fd@kernel.org>
 <de68b1d7-86cd-4280-af6a-13f0751228c4@kernel.org>
 <baa409d6-e571-4380-b046-5ea54c0e613d@linux.dev>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <baa409d6-e571-4380-b046-5ea54c0e613d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06/08/2025 03.24, Martin KaFai Lau wrote:
> On 8/4/25 6:18 AM, Jesper Dangaard Brouer wrote:
>> Do keep-in-mind that "moving skb allocation out of the driver" is not
>> part of this patchset and a moonshot goal that will take a long time
>> (but we are already "simulation" this via XDP-redirect for years now).
> 
> The XDP_PASS was first done in the very early days of BPF in 2016. The 
> XDP-redirect then followed a similar setup. A lot has improved since 
> then. A moonshot in 2016 does not necessarily mean it is still hard to 
> do now. e.g. Loop is feasible. Directly reading/writing skb is also easier.
> 

Please enlighten me. How can easily give XDP-progs access to the SKB
data-structure.  What changes do we need?
You mentioned XDP returning an SKB pointer, but that will need changes
to every XDP driver, right?


> Let’s first quantify what the performance loss would be if the skb is 
> allocated and field-set by the xdp prog (for the general XDP_PASS case 
> and the redirect+cpumap case). If it’s really worth it, let’s see what 
> it would take for the XDP program to achieve similar optimizations.
> 
>> Drivers should obviously not unconditionally populate the xdp_frame's
>> rx_meta area.  It is first time to populate rx_meta, once driver reach
> 
> afaict, the rx_meta is reserved regardless though. The xdp prog cannot 
> use that space for data_meta. The rx_meta will grow in time.
> 

My view is that we a memory area of minimum 192 bytes available as
headroom, that we are currently not using, that seems a waste.  The
data_meta was limited to 32 bytes for a long time without complaints, so
I don't think that is a concern.  If rx_meta grows, we propose changing
to the traits implementation, which gives us a dynamic compressed struct.


> My preference is to allow xdp prog to decide what needs to write in 
> data_meta and decides what needs to set in the skb directly. This is the 
> general case it should support first and then optimize.
> 

Yan and I have previously[1] (Oct 2024) explored adding a common
callback to XDP drivers, which have access to both the xdp_buff and SKB
in the function call. (Ignore the GRO disable bit, focus on callback)

We named the functions: xdp_buff_fixup_skb_offloading() and
  xdp_frame_fixup_skb_offloading()
We implemented the driver changes for [bnxt], [mlx5], [ice] and [veth].

What do you think of the idea of adding a BPF-hook, at this callback,
which have access to both the XDP and SKB pointer.
That would allow us to implement your idea, right?

--Jesper


[1] https://lore.kernel.org/all/cover.1718919473.git.yan@cloudflare.com/#r

[bnxt] 
https://lore.kernel.org/all/f804c22ca168ec3aedb0ee754bfbee71764eb894.1718919473.git.yan@cloudflare.com/

[mlx5] 
https://lore.kernel.org/all/17595a278ee72964b83c0bd0b502152aa025f600.1718919473.git.yan@cloudflare.com/

[ice] 
https://lore.kernel.org/all/a9eba425bfd3bfac7e7be38fe86ad5dbff3ae01f.1718919473.git.yan@cloudflare.com/

[veth] 
https://lore.kernel.org/all/b7c75daecca9c4e36ef79af683d288653a9b5b82.1718919473.git.yan@cloudflare.com/




