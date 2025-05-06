Return-Path: <bpf+bounces-57557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19254AACDE5
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 21:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973AD1C2064D
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 19:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D951B412B;
	Tue,  6 May 2025 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MRcn4LxB"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C64A32
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 19:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746559062; cv=none; b=UvGhh6bTTinzVxLnBujRfxwoJ7H3jNFnqgx/0utz4mauOW752kIYm09i0Qo1dmmbFbfYhzL5X+4AyanIFcTFKN5AuzGhUkUvfqb7bac63jaBsnRhG1axHsNoimlh4mlNFM9h9PW6tesh17pylET1lcpoF/yix+1FzujRUyqqjL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746559062; c=relaxed/simple;
	bh=VHUqiD05FcopIn9Isg3UQtJIAdEvCJnbRkQXXA6U+9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLhEELPPNj54jGLFPK7eEkkF6Qi2BZ4XRMPOrM+GZC/CbmNSMcxE+wPeSb1IzAe6dDrzMbOU4KNTMAtusgHRG1Q5LZ+CTPY+MuzT5f4ZXXR/kylK7JuvEgRgQ3owAA7ZU8mhPEvljvokVRMVG9BRnvgljEPgK5KszgFJ7UqdsWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MRcn4LxB; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <73cccd5e-de7d-404b-910d-c6a799c28c57@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746559048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCjtMGqu+X6qdS0ItwJy140Bxn7tOeJGMS9JpXz7MB0=;
	b=MRcn4LxBPt75uL26KlkS8uY9EOMoAGGewxejrCdhDqUqglbxCM7G1smGAvIkMrKOeuT5jA
	St6xRz30l7glGQ6VAFoy+aMH3RV1Pu4QDt7xAwXdakD6HVMGtBuXSpIXNVO8KKqHcLLoXl
	4WoyaOH7bNcBKcOo0pmLP5QSjjHa7CU=
Date: Tue, 6 May 2025 12:17:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] bpf: Scrub packet on bpf_redirect_peer
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Network Development <netdev@vger.kernel.org>, bpf@vger.kernel.org
References: <1728ead5e0fe45e7a6542c36bd4e3ca07a73b7d6.1746460653.git.paul.chaignon@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <1728ead5e0fe45e7a6542c36bd4e3ca07a73b7d6.1746460653.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/5/25 12:58 PM, Paul Chaignon wrote:
> When bpf_redirect_peer is used to redirect packets to a device in
> another network namespace, the skb isn't scrubbed. That can lead skb
> information from one namespace to be "misused" in another namespace.
> 
> As one example, this is causing Cilium to drop traffic when using
> bpf_redirect_peer to redirect packets that just went through IPsec
> decryption to a container namespace. The following pwru trace shows (1)
> the packet path from the host's XFRM layer to the container's XFRM
> layer where it's dropped and (2) the number of active skb extensions at
> each function.
> 
>      NETNS       MARK  IFACE  TUPLE                                FUNC
>      4026533547  d00   eth0   10.244.3.124:35473->10.244.2.158:53  xfrm_rcv_cb
>                               .active_extensions = (__u8)2,
>      4026533547  d00   eth0   10.244.3.124:35473->10.244.2.158:53  xfrm4_rcv_cb
>                               .active_extensions = (__u8)2,
>      4026533547  d00   eth0   10.244.3.124:35473->10.244.2.158:53  gro_cells_receive
>                               .active_extensions = (__u8)2,
>      [...]
>      4026533547  0     eth0   10.244.3.124:35473->10.244.2.158:53  skb_do_redirect
>                               .active_extensions = (__u8)2,
>      4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  ip_rcv
>                               .active_extensions = (__u8)2,
>      4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  ip_rcv_core
>                               .active_extensions = (__u8)2,
>      [...]
>      4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  udp_queue_rcv_one_skb
>                               .active_extensions = (__u8)2,
>      4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  __xfrm_policy_check
>                               .active_extensions = (__u8)2,
>      4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  __xfrm_decode_session
>                               .active_extensions = (__u8)2,
>      4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  security_xfrm_decode_session
>                               .active_extensions = (__u8)2,
>      4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  kfree_skb_reason(SKB_DROP_REASON_XFRM_POLICY)
>                               .active_extensions = (__u8)2,
> 
> In this case, there are no XFRM policies in the container's network
> namespace so the drop is unexpected. When we decrypt the IPsec packet,
> the XFRM state used for decryption is set in the skb extensions. This
> information is preserved across the netns switch. When we reach the
> XFRM policy check in the container's netns, __xfrm_policy_check drops
> the packet with LINUX_MIB_XFRMINNOPOLS because a (container-side) XFRM
> policy can't be found that matches the (host-side) XFRM state used for
> decryption.
> 
> This patch fixes this by scrubbing the packet when using
> bpf_redirect_peer, as is done on typical netns switches via veth
> devices except skb->mark and skb->tstamp are not zeroed.
> 
> Fixes: 9aa1206e8f482 ("bpf: Add redirect_peer helper")
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


