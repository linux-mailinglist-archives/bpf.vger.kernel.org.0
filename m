Return-Path: <bpf+bounces-60823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF93EADD379
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 17:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8411942FA5
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 15:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173D42EF298;
	Tue, 17 Jun 2025 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSlY3uv0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D7D2ECD2F;
	Tue, 17 Jun 2025 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175345; cv=none; b=Aw2ng/4ZrYSajn+joKAygEjL14cnkBeagVnkMDnVLJlM5Be5slUwMENVu6VDL3o9BvUVUAPDv+UBkQyS0W8x0mm3GgK6NavKazkdjGpg33JLhdgAVkhoiPR1YsWykI8EwGVHfRIThfOw3Q0TJSfTArwtZXLlAXejZsy88RbGH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175345; c=relaxed/simple;
	bh=u7FqYNkyg1u4LYtVyX/8WL4Ed/FNRZSdS96Nk9McvWA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cc7fbmGFYIbIHhcXC58Glcj+2NXFmhyhhzjsCQ1jvuC/kqRNA5bKlBmNa9bBCeVDMZS7h/Maouq6EDL9WGNbgss8B+66cTFSk7CScmpRjz90ZjSrNIqRS9jmnMo+nM9/BlsHriNNzCRC0W6m60r8kvRWlDk0E/kf+zPzsvQ8rbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSlY3uv0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a522224582so3258993f8f.3;
        Tue, 17 Jun 2025 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750175342; x=1750780142; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NojhxnoucAi7eQWFzqofuaJpbD69O5XMJI55ouW6/lI=;
        b=PSlY3uv0WwsIVEqcg3CsYGMS58hwKrnghnh9NMrQPtOa+AEKgI/CP4HIM2C42ArXH1
         S59UL9uDUEJHrz53bg5Q4SaoMUvbw/AnmcWo+t5nxa6IFDHs755IVv2xHgqFuwnt+zH9
         QXHF/Q0zh2EoM2Cqre5pBmXMQ0gezNe9rY3U4PUbOCBeIq9lVbcJei8SuUYyt6fRD1c0
         6LVUPdDIDZ9bFNYPmuTd2XzjyZEvZml3xWK6NBojZwOBwv4WQryyASTvF8ix3twHbkKS
         MoQzaoKaPtMDJBAUdvpuq5BEFrqdXUlB3GYre9cLlM7sWYA6INwiFXWn+5LjdWEAO+O9
         MkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175342; x=1750780142;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NojhxnoucAi7eQWFzqofuaJpbD69O5XMJI55ouW6/lI=;
        b=k/iDImuVTBhFfWM6AZp/K4E34/h6MhuWY2hJw1XZLGB/iBmX+y7fOF10Amhzy0r1hc
         s+lpIrAo/Uwr1EDgYqgJQEjHLdtFzbPuujkpUSx48JYacf9fol+8NJrg7zVoMZnjvKWg
         nn33O5r808qAFIY1H5N0fGqDEiCdWhhXJtl9wPOixMv/kar0J5ROkbEhVGK+0IQ9D/fb
         BmnPmZF1PfEj+dn0BX6jgwImiW9zWqZ4YGinNcks8+igcUSwRn1PSPkuvLCUNuROFm4Z
         a8xgA4eTHUlqh/Iw2IGa/dIC07TYRcSVIo3SJjXcGicMXchOiGsQvPy3TIMlACnOuek7
         InPw==
X-Forwarded-Encrypted: i=1; AJvYcCUbsS2hp/hKf3Us+CJwJWBTwrjDfmXYZuAaGMvg3wr+Rlt3W8iVOqmqSBdmBnFyrJoCTGo=@vger.kernel.org, AJvYcCXm5O7lGeYM/0e86EgelOEgxxChCIgjH70Wk0dyu1XgW8J+TythrTKGZQFGrvF3tEJjPXz8/ivw@vger.kernel.org
X-Gm-Message-State: AOJu0YxuXpH6dxhfWK48hK34X8rjj+jFi0btCR1tl1knuGtRZiBGbI3U
	b3cs1me8JEIvXdxPUnWXGtKpPJYHEP6l8GrIYH4TjdKftHM/Lby6B3azhC3d9Deb
X-Gm-Gg: ASbGncsNXAS8zzcgIS2V52KCGXBEbLDeVKKHyh4JbFJa5QHkvvzleiNzERgl2SsE9Rf
	9Ex0Mfl9zIOUCfeYI4kr0ldyzCZVjgtiF+HKSKnXUrokKHmLOsE0oLlWmMvUo5Oi9W+1LlxzIF4
	TzBiRL4xavRzRaKSKSUAW32HX/tBXExwdZ6oPPBVKUs3TKWjTySHe4BPfVv+5paNPRL9+hfruCI
	ztdCcwZNesLOr1p956g+2trLEhPlZ2VhzZbAmkINMwgds6ZD91rLX41PKajnIwBj6kHIc0UwV5O
	XM2FzRKXlA17C/GFsvWS/LriSToClliDYpCINqYLLxvmnRW7lJqa9lvPHcF/1X3RI2vJQohBEGC
	YLascxeeIcyrq3VbQK0f0f/H0Dli2Bx8y7Eh51d9mySfhQixgwse8ewj0qPSz0ljZ0lEbgK8=
X-Google-Smtp-Source: AGHT+IEMPk7RiQ93Yl+8O/dQDB/xO6B4X6GnKM5AA7dPFNTEVZcgNhbRH6oCNqonYMFep3mVauYsaQ==
X-Received: by 2002:a5d:64c2:0:b0:3a5:2d42:aa25 with SMTP id ffacd0b85a97d-3a572e55b64mr10612950f8f.50.1750175341625;
        Tue, 17 Jun 2025 08:49:01 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00112ae8a423a3e4b4.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:112a:e8a4:23a3:e4b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54e71sm14136455f8f.1.2025.06.17.08.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:49:01 -0700 (PDT)
Date: Tue, 17 Jun 2025 17:48:59 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Tom Herbert <tom@herbertland.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH stable 5.10,5.15 1/2] net: Fix checksum update for ILA
 adj-transport
Message-ID: <0bd9e0321544730642e1b068dd70178d5a3f8804.1750171422.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ Upstream commit 6043b794c7668c19dabc4a93c75b924a19474d59 ]
[ Note: Fixed conflict due to unrelated change in
  inet_proto_csum_replace_by_diff. ]

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

Link: https://github.com/cilium/pwru [1]
Fixes: 65d7ab8de582 ("net: Identifier Locator Addressing module")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://patch.msgid.link/b5539869e3550d46068504feb02d37653d939c0b.1748509484.git.paul.chaignon@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/net/checksum.h    | 2 +-
 net/core/filter.c         | 2 +-
 net/core/utils.c          | 4 ++--
 net/ipv6/ila/ila_common.c | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/checksum.h b/include/net/checksum.h
index d3b5d368a0ca..c975c76b4dd4 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -154,7 +154,7 @@ void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
 			       const __be32 *from, const __be32 *to,
 			       bool pseudohdr);
 void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
-				     __wsum diff, bool pseudohdr);
+				     __wsum diff, bool pseudohdr, bool ipv6);
 
 static __always_inline
 void inet_proto_csum_replace2(__sum16 *sum, struct sk_buff *skb,
diff --git a/net/core/filter.c b/net/core/filter.c
index 9d358fb865e2..65b7fb9c3d29 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1970,7 +1970,7 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
 		if (unlikely(from != 0))
 			return -EINVAL;
 
-		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo);
+		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, false);
 		break;
 	case 2:
 		inet_proto_csum_replace2(ptr, skb, from, to, is_pseudo);
diff --git a/net/core/utils.c b/net/core/utils.c
index 1f31a39236d5..d010fcf1dc08 100644
--- a/net/core/utils.c
+++ b/net/core/utils.c
@@ -473,11 +473,11 @@ void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
 EXPORT_SYMBOL(inet_proto_csum_replace16);
 
 void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
-				     __wsum diff, bool pseudohdr)
+				     __wsum diff, bool pseudohdr, bool ipv6)
 {
 	if (skb->ip_summed != CHECKSUM_PARTIAL) {
 		*sum = csum_fold(csum_add(diff, ~csum_unfold(*sum)));
-		if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr)
+		if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr && !ipv6)
 			skb->csum = ~csum_add(diff, ~skb->csum);
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


