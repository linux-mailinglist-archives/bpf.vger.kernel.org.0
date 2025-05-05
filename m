Return-Path: <bpf+bounces-57377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F28CAA9E23
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AFC3A4D9A
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F812741C0;
	Mon,  5 May 2025 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="reKuU5Jm"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD12701BD
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480530; cv=none; b=TtbhsZ0bQ9vNjCjoFEZV79hxyNgKpUMeQmR/9s/y0pVAP/yiTd4DFerUCiKnDS+zglnp0VZJdBGdqOYyZiRw2OAS0CWTTNLtizKS7lMKUADKajII/jFE0T5/JXuG4jUioaOgG17UT4R05DrxVXqEvNxUtu8xASRMvfj1SXdwp1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480530; c=relaxed/simple;
	bh=X/iNt5SPBw1NxkT1OKCPANnd5Cy5J78Wzaoq9W4AI/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeQSyCRJnhXVgu1Jn4mSxgbwOkpo8hXrhNyaD+iP0mQbjAQv5fYLKCUmDqqB7JWWSYZW5GwBPB3SBk4AqwZQDndaOCRTQVMEC2p08C0A1ReAMK1Wp7ShlzgSSbmaUI1luD8Ewh812QcfunBkthpz28mgqyNfBmYVYnlwJsbNhRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=reKuU5Jm; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8PgbbR+j3fY8/x58UQ4b+XyDf++JdRx33b/0lqil/k4=; b=reKuU5JmoZLyXd5vBXD8/Cmn7v
	oZ08fNO8wCCqgAWEqM+ACZw68yvYMWGu8sTxuBqgxlW+s0q6yDugLHjHS1RQcHzOD9mYK231jEE4Y
	Bya1ZuXOa4H1hWCFPfAGb4WqbzJJ4RF5PcwJjaO/aUep1VFKrDSRbRtx5D72SfmIDv44eqWXrLD9A
	vdDg32gpGUvhd433XIWv1jehK637UuQF+ghyFsrWEfZr94MjKX/kqa9Q0jPqBcLdezkOX1PH9WVaq
	138kTcf6mRdCo2Jb3jLkNRxXwucxz0+MzPoV9n7Chus7TvoVGm4jFdLVQSRKZWZrugR3kUaLE7UkL
	SpylV+6g==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uC3Mg-0008DY-29;
	Mon, 05 May 2025 23:28:43 +0200
Received: from [85.195.247.12] (helo=[192.168.1.114])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uC3Mg-0006SA-2z;
	Mon, 05 May 2025 23:28:42 +0200
Message-ID: <4acbb1b4-8b3b-4347-ac67-7b673e0c17e5@iogearbox.net>
Date: Mon, 5 May 2025 23:28:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/2] bpf: Scrub packet on bpf_redirect_peer
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
References: <1728ead5e0fe45e7a6542c36bd4e3ca07a73b7d6.1746460653.git.paul.chaignon@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <1728ead5e0fe45e7a6542c36bd4e3ca07a73b7d6.1746460653.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27629/Mon May  5 10:35:28 2025)

On 5/5/25 9:58 PM, Paul Chaignon wrote:
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

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

