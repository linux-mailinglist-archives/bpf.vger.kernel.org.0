Return-Path: <bpf+bounces-58994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F552AC51CB
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 17:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A1917FFEF
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A8027A11A;
	Tue, 27 May 2025 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="p/tdLIR3"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20AA1581E0;
	Tue, 27 May 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748358823; cv=none; b=hAn1aDIqVTrT0v+C5+juCgNdO7nth59GFCWHIiqhQt9KLSD1sbbQOLByK78NJAlAoCskEXYnJIGXP7iJpibxRb+jywk1hX3vaMaWjZ/kWwE08HEuoCTLbaAxc/2b+DNCqw+ZKL35+5dR346P/z6UF70hUDIRF4MvF+AZsM8IW4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748358823; c=relaxed/simple;
	bh=Lr4ycjRGxIVA215HiCqKPyJefBbUlB9O/xEQw3qI4Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQ77v62mAInWI8fEex9+9cUysWSWvoSQNBJhSQSkX+L+bdU0S0HF55sOxfzybentjyCJzciiZq1MumQ+AnFOddIze1OdQ+C+qplWA/QNPAqYKui6asUf0xu+u4cddpExbzL6IF3UJJi6LhdRAjlkursBRYJftgQpsMXGqEMQYWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=p/tdLIR3; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=EF8SoNjG8FmyMM3bopcgdRhyTbGXHbwJDRs/8jvOhSM=; b=p/tdLIR3jarBwki6n4VT+HbXl5
	orQe3TiGIUzVbyt8u4VJxCy7x+Ow0H0MJV7Lee8fPBGgfaXJr6DN1D/diIdWZZp6CzZGVIk5bguZb
	doEV+QRBI7o+e6pNrj/zirQC0eeOxt5sdZk5OCA06S2dWN5x5Sgqu1eVVt93uy2EhaBYz9dUzA/kn
	SE1UztE4opAPps8COiTWHkSEQ1yaYUgiLbxLQOiYGQqNH55WxlgIwMPhWjdyY6ublGQkRsUr7O2Ti
	zuthINDtBt0jrOM50k18NF4mpXaF9QNSD1LUfq2W0sJOfwx8b1FL9gSH056t/f4XZvw7rPz659TtW
	TMkqhV2w==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uJvzW-000GJg-2Y;
	Tue, 27 May 2025 17:13:22 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uJvzW-000Md9-0S;
	Tue, 27 May 2025 17:13:22 +0200
Message-ID: <1d235b98-f269-4e0f-95cb-e897c263a4a1@iogearbox.net>
Date: Tue, 27 May 2025 17:13:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: Fix checksum update for ILA adj-transport
To: Paul Chaignon <paul.chaignon@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Tom Herbert <tom@herbertland.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
References: <cover.1748337614.git.paul.chaignon@gmail.com>
 <3735f3bd86717bb22507a05f40b1432ec362138c.1748337614.git.paul.chaignon@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <3735f3bd86717bb22507a05f40b1432ec362138c.1748337614.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27650/Tue May 27 10:36:31 2025)

On 5/27/25 11:48 AM, Paul Chaignon wrote:
> During ILA address translations, the L4 checksums can be handled in
> different ways. One of them, adj-transport, consist in parsing the
> transport layer and updating any found checksum. This logic relies on
> inet_proto_csum_replace_by_diff and produces an incorrect skb->csum when
> in state CHECKSUM_COMPLETE.
> 
> This bug can be reproduced with a simple ILA to SIR mapping, assuming
> packets are received with CHECKSUM_COMPLETE:
> 
>    $ ip a show dev eth0
>    14: eth0@if15: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>        link/ether 62:ae:35:9e:0f:8d brd ff:ff:ff:ff:ff:ff link-netnsid 0
>        inet6 3333:0:0:1::c078/64 scope global
>           valid_lft forever preferred_lft forever
>        inet6 fd00:10:244:1::c078/128 scope global nodad
>           valid_lft forever preferred_lft forever
>        inet6 fe80::60ae:35ff:fe9e:f8d/64 scope link proto kernel_ll
>           valid_lft forever preferred_lft forever
>    $ ip ila add loc_match fd00:10:244:1 loc 3333:0:0:1 \
>        csum-mode adj-transport ident-type luid dev eth0
> 
> Then I hit [fd00:10:244:1::c078]:8000 with a server listening only on
> [3333:0:0:1::c078]:8000. With the bug, the SYN packet is dropped with
> SKB_DROP_REASON_TCP_CSUM after inet_proto_csum_replace_by_diff changed
> skb->csum. The translation and drop are visible on pwru [1] traces:
> 
>    IFACE   TUPLE                                                        FUNC
>    eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  ipv6_rcv
>    eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  ip6_rcv_core
>    eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  nf_hook_slow
>    eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  inet_proto_csum_replace_by_diff
>    eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     tcp_v6_early_demux
>    eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_route_input
>    eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_input
>    eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_input_finish
>    eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_protocol_deliver_rcu
>    eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     raw6_local_deliver
>    eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ipv6_raw_deliver
>    eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     tcp_v6_rcv
>    eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     __skb_checksum_complete
>    eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     kfree_skb_reason(SKB_DROP_REASON_TCP_CSUM)
>    eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_release_head_state
>    eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_release_data
>    eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_free_head
>    eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     kfree_skbmem
> 
> This is happening because inet_proto_csum_replace_by_diff is updating
> skb->csum when it shouldn't. The L4 checksum is updated such that it
> "cancels" the IPv6 address change in terms of checksum computation, so
> the impact on skb->csum is null.
> 
> Note this would be different for an IPv4 packet since three fields
> would be updated: the IPv4 address, the IP checksum, and the L4
> checksum. Two would cancel each other and skb->csum would still need
> to be updated to take the L4 checksum change into account.
> 
> This patch fixes it by passing an ipv6 flag to
> inet_proto_csum_replace_by_diff, to skip the skb->csum update if we're
> in the IPv6 case. Note the behavior of the only other user of
> inet_proto_csum_replace_by_diff, the BPF subsystem, is left as is in
> this patch and fixed in the subsequent patch.
> 
> With the fix, using the reproduction from above, I can confirm
> skb->csum is not touched by inet_proto_csum_replace_by_diff and the TCP
> SYN proceeds to the application after the ILA translation.
> 
> 1 - https://github.com/cilium/pwru
> Fixes: 65d7ab8de582 ("net: Identifier Locator Addressing module")
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

