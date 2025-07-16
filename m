Return-Path: <bpf+bounces-63487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371E3B07F6F
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 23:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF411A47560
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 21:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC7928BA8B;
	Wed, 16 Jul 2025 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jdwznjsd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FA42AE8E;
	Wed, 16 Jul 2025 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700816; cv=none; b=tFPlD9qZmIlXIcQ+D/aaug9NxF34vAj3qtRiyBMXFYGSjxZQB/7Fe+V3UyCKiMcyo9nFq+3uDfDJFtIQpLQ+0CXzz9Ianft+VZ1kGxssVEwbT8mX1h2jKypfa2DX8Zz5FAZHnOFuGdWqsE/1iuIZDTtuho6hqnnBHAyWfx27IfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700816; c=relaxed/simple;
	bh=chUpeeDGgxPJszLbrkeZFF4VVZU5mOnEoefpj04yyA8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbS0IUf3IMHYR49B3eUM0Yz/aVpbwB9MJzhsGc7fGsNt+n2ih1dMPE5jtR0PPIbbjR47CJCMxvdEGFSbl1hjYrvIReGO8WXR7pPNn3ScJp2+M95Wdmez5b3eCypvHanxnIADRt3W2GBaIFzNjvPDxotTH3pAsVbHAF5JgCSG9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jdwznjsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF009C4CEE7;
	Wed, 16 Jul 2025 21:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752700816;
	bh=chUpeeDGgxPJszLbrkeZFF4VVZU5mOnEoefpj04yyA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jdwznjsddwkgb5b6DdMLhIir8bvZ6Ff6dR4gWmvrQxcxcpfsdTByPPG7dpc0ZyQGe
	 WiT/AXPt5CZ3mdy/23hjnOFSHmvfo4Ho/gH2OKSjndrdnRfbaFh1C5iuAFhegtMSPk
	 3l/+3Rcuok+0ZRdntcM1co+rwYrQAZaUqKvp3nm5JVm5gwWFyjSzoQ95lPBN6EBmTX
	 u9N8PBoL6RcCepfl+poAxcOwU80Lur7HeEssQFwbnBKDw8kWHU/TBAfiJb2fpRPlRP
	 CmEft+63S55d36TIzw4ObXPPXIIidcy+U99pRcI93DkotkasEFj2A7uMQwAnFmndjg
	 cjsehFCN5iIzg==
Date: Wed, 16 Jul 2025 14:20:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
Message-ID: <20250716142015.0b309c71@kernel.org>
In-Reply-To: <aHeKYZY7l2i1xwel@lore-desk>
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
	<aGVY2MQ18BWOisWa@mini-arch>
	<b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
	<aGvcb53APFXR8eJb@mini-arch>
	<aG427EcHHn9yxaDv@lore-desk>
	<aHE2F1FJlYc37eIz@mini-arch>
	<aHeKYZY7l2i1xwel@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 13:17:53 +0200 Lorenzo Bianconi wrote:
> > > I can't see what the non-redirected use-case could be. Can you please provide
> > > more details?
> > > Moreover, can it be solved without storing the rx_hash (or the other
> > > hw-metadata) in a non-driver specific format?  
> > 
> > Having setters feels more generic than narrowly solving only the redirect,
> > but I don't have a good use-case in mind.
> >   
> > > Storing the hw-metadata in some of hw-specific format in xdp_frame will not
> > > allow to consume them directly building the skb and we will require to decode
> > > them again. What is the upside/use-case of this approach? (not considering the
> > > orthogonality with the get method).  
> > 
> > If we add the store kfuncs to regular drivers, the metadata  won't be stored
> > in the xdp_frame; it will go into the rx descriptors so regular path that
> > builds skbs will use it.  
> 
> IIUC, the described use-case would be to modify the hw metadata via a
> 'setter' kfunc executed by an eBPF program bounded to the NIC and to store
> the new metadata in the DMA descriptor in order to be consumed by the driver
> codebase building the skb, right?
> If so:
> - we can get the same result just storing (running a kfunc) the modified hw
>   metadata in the xdp_buff struct using a well-known/generic layout and
>   consume it in the driver codebase (e.g. if the bounded eBPF program
>   returns XDP_PASS) using a generic xdp utility routine. This part is not in
>   the current series.
> - Using this approach we are still not preserving the hw metadata if we pass
>   the xdp_frame to a remote CPU returning XDP_REDIRCT (we need to add more
>   code)
> - I am not completely sure if can always modify the DMA descriptor directly
>   since it is DMA mapped.
> 
> What do you think?

FWIW I commented on an earlier revision to similar effect as Stanislav.
To me the main concern is that we're adding another adhoc scheme, and
are making xdp_frame grow into a para-skb. We added XDP to make raw
packet access fast, now we're making drivers convert metadata twice :/

