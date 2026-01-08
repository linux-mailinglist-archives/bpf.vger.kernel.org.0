Return-Path: <bpf+bounces-78237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0E7D040F6
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 16:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C703C30692F5
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 15:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DBB221FC6;
	Thu,  8 Jan 2026 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZsCXQ+q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371DE226D1E;
	Thu,  8 Jan 2026 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887264; cv=none; b=f3oaqmO14f6M24h4cwVjbxY5VHStJLrjKcel94qA1YpE261UC7n4AxHxp2ExrbmV8icgckhj9LxJ10mh4EUMpYrphHS/xdalcev5VU/W6GpZQGaevOwxBsvuhSwRGkTmeVFyt52rbIfH9HisHFYYAq7xHP4x7LgXNDyBb56/I7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887264; c=relaxed/simple;
	bh=rRafGtka+Zehe/QV1cX6sSl/+Pxyy/fwaUZk3pYs55Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Du/cmT6JqNpMjE8JSosoYUrHqyY2NMx5NZqOQLVj3+jIcBFHqPZ+rEFn7vpHAKIe4+/iIewJyc/Bx3Rf8X9vBbOUZvEie1/JZJrLB3CTlbdRPuBnq/Ifu3hAAX8wkSFiMf/MkKPQgaYOf7QMMVXJAUgONQ4TGi4O9Lnr/KbAuKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZsCXQ+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB20DC116C6;
	Thu,  8 Jan 2026 15:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767887263;
	bh=rRafGtka+Zehe/QV1cX6sSl/+Pxyy/fwaUZk3pYs55Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GZsCXQ+qr4G1mL9qEBvyZjVtrMbkDrUDLNLc+WyF5b0Es1yI189MtmWSzSSZQoguW
	 UqvcF4BSDnEqZDdfDdcBGVDrYM3TI538kbyQTNLQHGRG918U8GBPPHeNs1+xdDFbos
	 vc9SjEraU0d9IHkY1sbo8Vl92b3yyGo9gsEopcSTjNS6wxmGPC6QVaYXyTbcrbtjEW
	 0MDNk2S4PvLVn/rL2wHH/SGTjqtdbqvaXlKqVkBPgvMTsY2zmIGR9bVznzhnTEQMAC
	 d1K34JgHKgbPCXRNG97lJ/qSHdZz16k3UgJ6PdfD79sqk8LXA8HTXqv4qjM3M0J9uQ
	 rQn/5WvQjbCYg==
Date: Thu, 8 Jan 2026 07:47:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v3 00/17] Decouple skb metadata tracking from
 MAC header offset
Message-ID: <20260108074741.00bd532f@kernel.org>
In-Reply-To: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 07 Jan 2026 15:28:00 +0100 Jakub Sitnicki wrote:
> This series continues the effort to provide reliable access to xdp/skb
> metadata from BPF context on the receive path. We have recently talked
> about it at Plumbers [1].
> 
> Currently skb metadata location is tied to the MAC header offset:
> 
>   [headroom][metadata][MAC hdr][L3 pkt]
>                       ^
>                       skb_metadata_end = head + mac_header
> 
> This design breaks on L2 decapsulation (VLAN, GRE, etc.) when the MAC
> offset is reset. The naive fix is to memmove metadata on every decap path,
> but we can avoid this cost by tracking metadata position independently.
> 
> Introduce a dedicated meta_end field in skb_shared_info that records where
> metadata ends relative to skb->head:
> 
>   [headroom][metadata][gap][MAC hdr][L3 pkt]
>                      ^
>                      skb_metadata_end = head + meta_end
>                      
> This allows BPF dynptr access (bpf_dynptr_from_skb_meta()) to work without
> memmove. For skb->data_meta pointer access, which expects metadata
> immediately before skb->data, make the verifier inject realignment code in
> TC BPF prologue.

I don't understand what semantics for the buffer layout you're trying
to establish, we now have "headroom" and "gap"?

	[headroom][metadata][gap][packet]

You're not solving the encap side either, skb_push() will still happily
encroach on the metadata. Feel like duct tape, we can't fundamentally
update the layout of the skb without updating all the helpers.
metadata works perfectly fine for its intended use case - passing info
about the frame from XDP offload to XDP and then to TC.

