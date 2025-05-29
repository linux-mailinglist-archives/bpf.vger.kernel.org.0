Return-Path: <bpf+bounces-59279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EA8AC79E3
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 09:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021E17B0A17
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 07:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CBD217F27;
	Thu, 29 May 2025 07:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVCCQMg8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DF67483
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748504307; cv=none; b=IP7JYH23CD1/MBbz/9JGFxslM67EnMp6bvdzhbBimjI4j3GLqFTXeN1nyP/dNCN8d1F+X5lhWyXbpCgAJ9xwzHhSlcooeFXhq/PTOEtMsy3ASC+VQhbgoVT8wVEzEzIaSiR3nQlUNxGHdoKQRIEaXy1cCGecBuiWUWUAP/4wduM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748504307; c=relaxed/simple;
	bh=7JYqNlaM+z6Zp+0u7TikFBdCRQA4T3c1mTtgN0EnUCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3f6dI0hE4rnCi9PTqfX68ARnzwYz/tGqRQ/w+uTojByS+J9IAOCnnAwDDG97UDaFyFnsiC29iybDRqR3XY4TTeMx5dKz4GRic2BBET7hooBHC4N6R5vYGVnwPHOTc5lRBCBuz3H36R4M+weuZlFWVOzmcKAeh3tS+Zu484iXN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VVCCQMg8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748504304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blXWwpJ0S+trZnzM7At1CLgsyWQnrAAvxFebkGVwfyM=;
	b=VVCCQMg8nqiPVux1hz8jFdNlFW5MXgFKfRd3Y0ctwkzXZ3YqB44PoprP6WZwnmgnGuwONq
	r7dRHziHEdGN2/wOoV0XsMMqikLUfB3SRxuE4KMr62QxzdeSNaUjtiaog9u5/RG48G1qcV
	PepPOXru9j/dKyA10Mf3m4gQSv0aRu0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-XG8oqwx_POS_jB3r3zzXOg-1; Thu, 29 May 2025 03:38:21 -0400
X-MC-Unique: XG8oqwx_POS_jB3r3zzXOg-1
X-Mimecast-MFC-AGG-ID: XG8oqwx_POS_jB3r3zzXOg_1748504301
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-442cdf07ad9so2404945e9.2
        for <bpf@vger.kernel.org>; Thu, 29 May 2025 00:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748504300; x=1749109100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blXWwpJ0S+trZnzM7At1CLgsyWQnrAAvxFebkGVwfyM=;
        b=wY/rguyzrpT0TCYE7+oibchYwzBXhSAWPI0OeONsgsTBW+iHFJz/wIa/rBJrenRHtt
         Pbai3OGqT9HmLJdbMqcFbu1iGNzdXq3Y6N/YHJ0r/97dOYOBqF2ukz8by/BFJGxdNcCt
         fhst2RLMFUH9hg0aCDAlQnQAr/N2AT1euCoryxytlnRZkQhxcnlTRVeWIKhXUVZrtUJ/
         mtCgLY70OFtvZhqnA/BebgJnyVmAmJc2JPOqDwLsva5w7jUpXeacSIurDsKkw+Y6hMrK
         fcQD5ABb3sZMzBLeyUREpGO9n39CCP1PplzyMc99aYxLR+P75AWt8m3LJ1gqrzsCrXT/
         Moow==
X-Forwarded-Encrypted: i=1; AJvYcCXQv7allJ/IbcciCr95QjT5rB2NebqaiNiZpHNsby+e+TX7HrZxBv+otWbiNuDA2bjAR1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2OHXMY4xuXOYU6QrzehwJidKpo8aYP2C7pm819RMdENvNipJi
	O2shEMO+za5iQwkE7q7XII/MZ2PDKtSIX+pphIhc8byoBWCSaWISArBgWhwP8m2MZudhMOkbJYM
	gJXew9zlBGxL62w3mwf7OYEYY5pOOW7X/pYriPP+Q7P/jHHmIzwXNPg==
X-Gm-Gg: ASbGncvyxnP36GvjdrDjlQzAlH866JAq8tBTiCtc6RS/toZdiCLiUngVmvKQADEOHLm
	Yjevjm4OZtxQxNgdzt3izfAhZ0swbrTYtn1bqs82SQ2wjM/U/lK7SysDMJbGtrG89QnICyCBa6d
	cuGV/7YwhP4T4BedwS9KgQZQPXRPvl2ZQrtKcbiH3+T3XKAZ2/zCrVtewBZCpfan7J9Rvwusn6n
	olgg92OdoXZBFP20JBjbTQYE8Gbz1vbi8Mbfj7SY5MJDpyYnZljgrR7X+2c0/xnYgcSDpUFIPm6
	4l7xp6v7THjDwon1SVwwWvQGHgH4zJ48gXqHZtAnO3hLaVatocpjhdyZ2h4=
X-Received: by 2002:a05:6000:128c:b0:3a4:e6b4:9c4b with SMTP id ffacd0b85a97d-3a4e6b49cdbmr4972165f8f.1.1748504300633;
        Thu, 29 May 2025 00:38:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7cb2kxX141BOz6JcKz1zN+umEGKrnVlgqYHtuQmbfM8gGa0/+JigyP07V6fPF+YqrDlOuLA==
X-Received: by 2002:a05:6000:128c:b0:3a4:e6b4:9c4b with SMTP id ffacd0b85a97d-3a4e6b49cdbmr4972149f8f.1.1748504300182;
        Thu, 29 May 2025 00:38:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4? ([2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00972d9sm1154767f8f.64.2025.05.29.00.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 00:38:19 -0700 (PDT)
Message-ID: <ea2e4ba3-4dd6-4bee-ad26-2ed541f4aeaf@redhat.com>
Date: Thu, 29 May 2025 09:38:18 +0200
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
 David Ahern <dsahern@kernel.org>, Tom Herbert <tom@herbertland.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
References: <cover.1748337614.git.paul.chaignon@gmail.com>
 <3735f3bd86717bb22507a05f40b1432ec362138c.1748337614.git.paul.chaignon@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3735f3bd86717bb22507a05f40b1432ec362138c.1748337614.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

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
>   $ ip a show dev eth0
>   14: eth0@if15: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>       link/ether 62:ae:35:9e:0f:8d brd ff:ff:ff:ff:ff:ff link-netnsid 0
>       inet6 3333:0:0:1::c078/64 scope global
>          valid_lft forever preferred_lft forever
>       inet6 fd00:10:244:1::c078/128 scope global nodad
>          valid_lft forever preferred_lft forever
>       inet6 fe80::60ae:35ff:fe9e:f8d/64 scope link proto kernel_ll
>          valid_lft forever preferred_lft forever
>   $ ip ila add loc_match fd00:10:244:1 loc 3333:0:0:1 \
>       csum-mode adj-transport ident-type luid dev eth0
> 
> Then I hit [fd00:10:244:1::c078]:8000 with a server listening only on
> [3333:0:0:1::c078]:8000. With the bug, the SYN packet is dropped with
> SKB_DROP_REASON_TCP_CSUM after inet_proto_csum_replace_by_diff changed
> skb->csum. The translation and drop are visible on pwru [1] traces:
> 
>   IFACE   TUPLE                                                        FUNC
>   eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  ipv6_rcv
>   eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  ip6_rcv_core
>   eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  nf_hook_slow
>   eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  inet_proto_csum_replace_by_diff
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     tcp_v6_early_demux
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_route_input
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_input
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_input_finish
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_protocol_deliver_rcu
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     raw6_local_deliver
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ipv6_raw_deliver
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     tcp_v6_rcv
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     __skb_checksum_complete
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     kfree_skb_reason(SKB_DROP_REASON_TCP_CSUM)
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_release_head_state
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_release_data
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_free_head
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     kfree_skbmem
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

Patch 2 does not apply cleanly anymore, please rebase. While at it,
please also replace:

1 - https://github.com/cilium/pwru

with a more customary tag:

Link: https://github.com/cilium/pwru [1]

Thanks,

Paolo


