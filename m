Return-Path: <bpf+bounces-65486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A0BB23EAE
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 05:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D49217C2D4
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 03:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554483FC2;
	Wed, 13 Aug 2025 03:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q5mzUiH5"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165B426FD9A
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755054013; cv=none; b=nir4HpV0nmCCVIlGt/2HY7a5o9eV7VkChwbq8iDe7zUPpNBIeY8BbyGxsIuXzGOO65DMEKq10Yf8kY74clyBwKTPfsnBqc9A2AAVr3QFa1jXth0DYIpJn7/4bwSs1i6SXDrXRlWbVBkMH+Ik3hsFvN4WrO6Wg4AmG76LyBToQyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755054013; c=relaxed/simple;
	bh=GAm+m12xkj6fi5E6D9g63VmarVSsObFEfuuMY3gDfOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Swv9kVsj5j0iVl3I7pvESYvqE4oa2L+yrlJGnAum69dkpUBppY0ZBio3VxP/DqAetq46seVFh5tBUIj4bStfxMEIdeNmGx2wkki51J9AOr0xN35iFE2SNmEhhQ+Kmx7DZbC2E7QiVOX8mmF0Gsga5XAUje9j8Q/CjBJylaFats8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q5mzUiH5; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <86294c15-523e-4ef5-a67c-d4068607da3f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755053998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DrGTejR5G+x+9kTrw/iTa9/3Utlef5BmFPK6HnId7es=;
	b=Q5mzUiH5g2vkSeNl9fnx5PjjhHplW+Skulk+CpJryMEuClwhItjHWNCpeGoLvrk2jXh1SB
	kSVSpM/Nks39GmrqbaCzcSe1y8I3w/X5RC0kIRE9Jyh6ZK726uPXwHT7cwzPjxXDRkE7yN
	dWyVhbyju2MzfKFmTC6Ot0XQMJWzn98=
Date: Tue, 12 Aug 2025 19:59:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
To: Jesper Dangaard Brouer <hawk@kernel.org>
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
 <20a3558f-43c5-46a2-8395-c6d966ea5caf@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20a3558f-43c5-46a2-8395-c6d966ea5caf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/7/25 12:07 PM, Jesper Dangaard Brouer wrote:
> Yan and I have previously[1] (Oct 2024) explored adding a common
> callback to XDP drivers, which have access to both the xdp_buff and SKB
> in the function call. (Ignore the GRO disable bit, focus on callback)
> 
> We named the functions: xdp_buff_fixup_skb_offloading() and
>   xdp_frame_fixup_skb_offloading()
> We implemented the driver changes for [bnxt], [mlx5], [ice] and [veth].
> 
> What do you think of the idea of adding a BPF-hook, at this callback,
> which have access to both the XDP and SKB pointer.
> That would allow us to implement your idea, right?
> 
> [1] https://lore.kernel.org/all/cover.1718919473.git.yan@cloudflare.com/#r
> 
> [bnxt] https://lore.kernel.org/all/ 
> f804c22ca168ec3aedb0ee754bfbee71764eb894.1718919473.git.yan@cloudflare.com/
> 
> [mlx5] https://lore.kernel.org/ 
> all/17595a278ee72964b83c0bd0b502152aa025f600.1718919473.git.yan@cloudflare.com/
> 
> [ice] https://lore.kernel.org/all/ 
> a9eba425bfd3bfac7e7be38fe86ad5dbff3ae01f.1718919473.git.yan@cloudflare.com/
> 
> [veth] https://lore.kernel.org/all/ 
> b7c75daecca9c4e36ef79af683d288653a9b5b82.1718919473.git.yan@cloudflare.com/

It should not need a new BPF-hook to consume info produced by an earlier xdp 
prog. Instead, the same and existing xdp prog can call a kfunc to directly 
create the skb and update the skb fields. The kfunc could be driver specific, 
like the current .xmo_rx_xxx.


