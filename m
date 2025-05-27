Return-Path: <bpf+bounces-58982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 947DBAC4BBE
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 11:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3387D3AA4A5
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28322253947;
	Tue, 27 May 2025 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8lBnD8X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CDF1E3DF2;
	Tue, 27 May 2025 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748339302; cv=none; b=GLUBHLv/Cvt4nCQyH8A31kCKYRGT8dbw0A9H4V7w8M6ZG3lT8+JxggtjTaL6BDLgtKtFKg3ffkPHkwq2sXf3oVUqgZwOmr1EnwdElx5aFE9YDRADNKs3mrhwQ1uFj6j88GKQ33mldtzH60tnsWIIt3/HjA6IB+O7Hk3vJX2IWQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748339302; c=relaxed/simple;
	bh=m1QmiYFWVwHnh02Ip+Ou3TzZjkiSB/M9v7jCMpYvPEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK7559JsjCUbEl3WbO1Wxsb/W0MCQY+ejFEcc/2cEP7ZPYAhz5FKh/bYTFxe/hclrhAFLzOW7L5AxlB9sC9/dHQa/bw6uz3kcQXpWc3XjiRsFKYkS4GKfxArVt3WUma4sQBihJ5wfclKv7CsYLtO6ySyRNHoZ+QuM4czOU2ggig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8lBnD8X; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe574976so24718625e9.1;
        Tue, 27 May 2025 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748339299; x=1748944099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mBgiUJQ5RadDrnm0oBFUkItxig+/jZVDMGkJ7P9tqFo=;
        b=h8lBnD8XnCbO+ct5ktA7oglg5OpSowxBRl3SlzXhFz63tTYmKZJltLgemEhP8aNsF2
         j06+oXC0b6mDJgx6BEgrMA2zWIjFq0zxjQqCkA5NGG0keFFp2GeBvGYaugXYQBAQiRiI
         vuReOdJ3yC2mrjCOBqvDOgsjbkM77DVkoqahk3xOq5M9WpFS6ToxyXuo2JedS3f2Z9vw
         qyY/+4GmPF1fw3sxTp+MVupCr8wrOFjpBu3FtvGZyJ1axBWiUAr9s5ESq/yqw8Gdvky8
         atkfr3OE8Ac41WixiQ8Fm5dKYLPyEKrHNCzVc35eXTOJXxxNhlX250Z3TYi401IUQSFk
         R5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748339299; x=1748944099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBgiUJQ5RadDrnm0oBFUkItxig+/jZVDMGkJ7P9tqFo=;
        b=niSk0O75wK23ihIDWh8xISv5A3cIFbj8ldv6IuyV6zfwmwQk7IhQX/pWQO2uy18P9D
         ZQEVouK6W9mrwfCoGei3TRO7UQ2MR2fEPZeMS5uU/Y86qsBUu0XIeMWLymZPw7FnLqMv
         4PpY7Vg0HWgX1duPNORaG7k3vZBoER7ZKlU20+/dxNb0kvXGD4ax8o9DOzpIKruEft8a
         q3o2HInkyLliiNGdXxLE7y82Ph5cIfxYUswA8s0zUavyISQ3uav1WHDPmOTa4KKTdi0W
         4SCd6drprLY4aozgA8SM+XzwQf62VyY7FvovBWjDTP30vTGp2zoiz/xeyBi/v8bwCNEd
         GFyw==
X-Forwarded-Encrypted: i=1; AJvYcCUDvGxgKA+VbKboWBXfGjJ8MABQZc0iFuTq0Z5ih0X0inw7a7Z0m8QxjvAYP2xi6VoxzG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzztfNNaCvgFUEC28IOPDTNbxgnPYVyww3rndpI7S0M6XNl52Un
	WLPhGuHRjAvf/tbg3jW7Ftb0S+ye5QopCP/egtNtKQf+zpZWhAzmU/c1w3z/gDCd
X-Gm-Gg: ASbGncujDKVKjLeHF8JxuKyfOguIpZrYEgcHOTlASjLzv+M+xtuZOoZedI0nhCavoZR
	+57dn2P3n5gQHeWF+O14bKy0lmZ5X+H1Iy5Dep+z2UwOMX8271xJB/YEubeBnSplZp/AR1Fj/Dd
	Vm3EciNJvxPzPZjkaGsNPM2naMPGmCc7yuNU0WzmLXKWaLdLpsHnCBDmpPwZoSt7hLAq5oCcCzm
	OfV+oxxJDCIMgzGCpqDaT8rblBlIFxCiavJh72gs3qe6HMHcN+CKuhEM7Joaox7QmAFlzXjhv+8
	l4zfqQlQca8fX9+veLLtuGVRkzQpwxElD7La/7JzOYcfriNV9405CPOW0xZDm+BVoohK5dzlbBJ
	JkjinudI/L5dO/0I98TdbK6qkWffuZM7ExiqvINhRDgSLScI1
X-Google-Smtp-Source: AGHT+IEqVmR2jXeWtS/cdRUM/wKot9CHe+dD+u4JF2IqEBjz8AocSKURvGaoHPZKASPWy059ClxKkg==
X-Received: by 2002:a05:600c:3ca1:b0:43c:f81d:34 with SMTP id 5b1f17b1804b1-44c91ad7046mr108790105e9.9.1748339298921;
        Tue, 27 May 2025 02:48:18 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f6e2550003dabfc0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f6e2:5500:3da:bfc0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d3edcsm271163605e9.20.2025.05.27.02.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 02:48:18 -0700 (PDT)
Date: Tue, 27 May 2025 11:48:16 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Tom Herbert <tom@herbertland.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH net v2 1/2] net: Fix checksum update for ILA adj-transport
Message-ID: <3735f3bd86717bb22507a05f40b1432ec362138c.1748337614.git.paul.chaignon@gmail.com>
References: <cover.1748337614.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748337614.git.paul.chaignon@gmail.com>

During ILA address translations, the L4 checksums can be handled in
different ways. One of them, adj-transport, consist in parsing the
transport layer and updating any found checksum. This logic relies on
inet_proto_csum_replace_by_diff and produces an incorrect skb->csum when
in state CHECKSUM_COMPLETE.

This bug can be reproduced with a simple ILA to SIR mapping, assuming
packets are received with CHECKSUM_COMPLETE:

  $ ip a show dev eth0
  14: eth0@if15: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
      link/ether 62:ae:35:9e:0f:8d brd ff:ff:ff:ff:ff:ff link-netnsid 0
      inet6 3333:0:0:1::c078/64 scope global
         valid_lft forever preferred_lft forever
      inet6 fd00:10:244:1::c078/128 scope global nodad
         valid_lft forever preferred_lft forever
      inet6 fe80::60ae:35ff:fe9e:f8d/64 scope link proto kernel_ll
         valid_lft forever preferred_lft forever
  $ ip ila add loc_match fd00:10:244:1 loc 3333:0:0:1 \
      csum-mode adj-transport ident-type luid dev eth0

Then I hit [fd00:10:244:1::c078]:8000 with a server listening only on
[3333:0:0:1::c078]:8000. With the bug, the SYN packet is dropped with
SKB_DROP_REASON_TCP_CSUM after inet_proto_csum_replace_by_diff changed
skb->csum. The translation and drop are visible on pwru [1] traces:

  IFACE   TUPLE                                                        FUNC
  eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  ipv6_rcv
  eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  ip6_rcv_core
  eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  nf_hook_slow
  eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  inet_proto_csum_replace_by_diff
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     tcp_v6_early_demux
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_route_input
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_input
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_input_finish
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_protocol_deliver_rcu
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     raw6_local_deliver
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ipv6_raw_deliver
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     tcp_v6_rcv
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     __skb_checksum_complete
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     kfree_skb_reason(SKB_DROP_REASON_TCP_CSUM)
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_release_head_state
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_release_data
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_free_head
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     kfree_skbmem

This is happening because inet_proto_csum_replace_by_diff is updating
skb->csum when it shouldn't. The L4 checksum is updated such that it
"cancels" the IPv6 address change in terms of checksum computation, so
the impact on skb->csum is null.

Note this would be different for an IPv4 packet since three fields
would be updated: the IPv4 address, the IP checksum, and the L4
checksum. Two would cancel each other and skb->csum would still need
to be updated to take the L4 checksum change into account.

This patch fixes it by passing an ipv6 flag to
inet_proto_csum_replace_by_diff, to skip the skb->csum update if we're
in the IPv6 case. Note the behavior of the only other user of
inet_proto_csum_replace_by_diff, the BPF subsystem, is left as is in
this patch and fixed in the subsequent patch.

With the fix, using the reproduction from above, I can confirm
skb->csum is not touched by inet_proto_csum_replace_by_diff and the TCP
SYN proceeds to the application after the ILA translation.

1 - https://github.com/cilium/pwru
Fixes: 65d7ab8de582 ("net: Identifier Locator Addressing module")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/net/checksum.h    | 2 +-
 net/core/filter.c         | 2 +-
 net/core/utils.c          | 4 ++--
 net/ipv6/ila/ila_common.c | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/checksum.h b/include/net/checksum.h
index 243f972267b8..be9356d4b67a 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -164,7 +164,7 @@ void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
 			       const __be32 *from, const __be32 *to,
 			       bool pseudohdr);
 void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
-				     __wsum diff, bool pseudohdr);
+				     __wsum diff, bool pseudohdr, bool ipv6);
 
 static __always_inline
 void inet_proto_csum_replace2(__sum16 *sum, struct sk_buff *skb,
diff --git a/net/core/filter.c b/net/core/filter.c
index 577a4504e26f..3c93765742c9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1987,7 +1987,7 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
 		if (unlikely(from != 0))
 			return -EINVAL;
 
-		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo);
+		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, false);
 		break;
 	case 2:
 		inet_proto_csum_replace2(ptr, skb, from, to, is_pseudo);
diff --git a/net/core/utils.c b/net/core/utils.c
index 27f4cffaae05..b8c21a859e27 100644
--- a/net/core/utils.c
+++ b/net/core/utils.c
@@ -473,11 +473,11 @@ void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
 EXPORT_SYMBOL(inet_proto_csum_replace16);
 
 void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
-				     __wsum diff, bool pseudohdr)
+				     __wsum diff, bool pseudohdr, bool ipv6)
 {
 	if (skb->ip_summed != CHECKSUM_PARTIAL) {
 		csum_replace_by_diff(sum, diff);
-		if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr)
+		if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr && !ipv6)
 			skb->csum = ~csum_sub(diff, skb->csum);
 	} else if (pseudohdr) {
 		*sum = ~csum_fold(csum_add(diff, csum_unfold(*sum)));
diff --git a/net/ipv6/ila/ila_common.c b/net/ipv6/ila/ila_common.c
index 95e9146918cc..b8d43ed4689d 100644
--- a/net/ipv6/ila/ila_common.c
+++ b/net/ipv6/ila/ila_common.c
@@ -86,7 +86,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&th->check, skb,
-							diff, true);
+							diff, true, true);
 		}
 		break;
 	case NEXTHDR_UDP:
@@ -97,7 +97,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
 				diff = get_csum_diff(ip6h, p);
 				inet_proto_csum_replace_by_diff(&uh->check, skb,
-								diff, true);
+								diff, true, true);
 				if (!uh->check)
 					uh->check = CSUM_MANGLED_0;
 			}
@@ -111,7 +111,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&ih->icmp6_cksum, skb,
-							diff, true);
+							diff, true, true);
 		}
 		break;
 	}
-- 
2.43.0


