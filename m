Return-Path: <bpf+bounces-60814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FDAADCF1E
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 16:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB7A17DAA7
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 14:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145AC2EE5FA;
	Tue, 17 Jun 2025 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF6dU/yU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CC22EE5F0;
	Tue, 17 Jun 2025 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169274; cv=none; b=ZKtX1jibzFLl5pSnQZ7tjvFHER+aevkWtS03oSlgGNwg2dVy3VYLdH2y968+cpUAi28nNVJDhfiY0iUgHn5WiBkIKqe81UD8cSWJvRYb+WK+54QVHKmB9ThPN2sknSuzui0C/oo14FUyZtL7zKotbUYjs7PhAZlWJCAMUUMT1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169274; c=relaxed/simple;
	bh=T9OOKaWhoj7DDQMb3Wq83dKkPhFhOwOHgz5YBg7VX0A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jwsrb/z0QygzZjKXy1wMDmfndyGHGX+/pWKfgYsPojzd8dVuUiGaw3ugHkMRxhn9jKofwvKSPaA1gW+WS8+F2md8H/lH2plmOTQ81lH7lEsnvWrWpdeVJ6r6UL2/devk+/8Rx5Xn47L+48JTGjAvi0CAoSIXMswnr+RSW19E53w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YF6dU/yU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so64713365e9.1;
        Tue, 17 Jun 2025 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169271; x=1750774071; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivq55s2BMYHtBsi6ov4cvhAeXemkfqjF3TqYbcPyrek=;
        b=YF6dU/yUWnMDXH+0iZvNmZRKfWybpeihtFjRaAb9OuIm8+UDO/FTew6ajV2yuGF3RI
         IYxOe4fR1z6AZ+loFp1WxKxrpfxMplk9RexpWSDjAOHwym3ljBtqJrKRYNvaVHPoQ0Y6
         21i/9Nt48EwVPJDQCo6751iBDK5yMKPgPLpwnRSQuWsNm1uNm6Uf+dRXSjLiD/a1AMZU
         eUpYvn3y1r2EC+ivtBdSUCqOMOVmisyKC6dn1EiKteM/qHu/TxLsHtWAN7HXDAlIvcqL
         LV9tuv5Pgn2Mz0UVQw/ovy2aqMsPdLebH2g7Zwr28eg9krL7ciR5OiN3YPh9glEvlRrI
         PZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169271; x=1750774071;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivq55s2BMYHtBsi6ov4cvhAeXemkfqjF3TqYbcPyrek=;
        b=YCAB8qlHwSJX9hRDWqfM9iB64wWFW5SOKE2p+GJYiTYgJ9MNp5P8bBmzINatlBFV25
         +Y0+D60OHTk0irQMTgWDDCaKkwJB23+Oc+27W2TmwZbyxqOuZ8ppM1CxkL0OHA02EXW+
         H6R/nZIa7kyQO51dJ56mX6fsoKJlgN1u6GF5B0LrtzSNp3YjIUiSWVqc0JjD5yZtvz4t
         q910UhORXKDOSNoOB24wWJi44MM+R3ABUjBtXy23OEH/TILOwLv4d55T0XgHkHQyWgqe
         qRduajXgIdRwjAh4jbaG03/uQ+Lg+Xh4O8i5yYcxWMKwVulJ/LXGQTslFH3LjsAHND/L
         KZFg==
X-Forwarded-Encrypted: i=1; AJvYcCUgUBxzlpmG0OfV8qhgE/2XiBwmBGCNqyP7UvdR/gO2wwuyRDpcPEsOzKax7LY+sy+SFcQ=@vger.kernel.org, AJvYcCVTdX1H6WAlXXYn2CtVzhHCMhkbtAHb7Wydr/svRbJuK++QVSnZI3DJ0QSRU5leK4X3/9Qm7yLT@vger.kernel.org
X-Gm-Message-State: AOJu0Yydp/V+6VcYfmYrGebgv/kvyB6R8mLNUDE8e/2cZvRw2o7GhpVj
	7SgunADXGwBh5wICODApxONY6TBoS+hv8p16syq7fWh1KJfDWfHr9vIDdj+LW7oT
X-Gm-Gg: ASbGncvVIxr7tpKYUtalp7Yae7W51ur59M99PZxNMAhS5g38ZhF63ywjWrbKSDc/5v7
	Fc6LrfQIRlTHaRzzk6wymb0Xh/xMdpnhYoOH5B5fJppQFk8ta3sOSy0wjtIRTSPYLbdDvDN1lI1
	titb3/uafr1q60HqmYxK+Y/77C6L3W913J2xJGqYzAvVZu5sZobfxvaemm74z2p+KPp4kfkKU2o
	LMW3RuYzAj+bFUPLB8yLcXOw4EsHN/TCmLP2wEI1btSGE5fCY4tIyUzcu58eBh5DYCsm3XBlp0s
	AsGtV2RYRwFj0iOJgzh/MDMIF5bVcTnnMnHRB1w6BjZ5QCVLgeGnjbFdmHgDd5zmeupcS1Kqpzv
	Kb6dIcWm3nAFRA5WNWo96481dQAWT/PpxTeAXmpQV0JLqkU81KLj/m0tLwuyS
X-Google-Smtp-Source: AGHT+IEn0WTjWbmm00QmPIHfwddk7luUQZW7M2S1aERg6+R2OMINz4LEs0GXI9SJ+s+ic8d5hJwAvQ==
X-Received: by 2002:a05:600c:1e1d:b0:442:ccfa:1461 with SMTP id 5b1f17b1804b1-4533ca6ace2mr140067735e9.13.1750169270591;
        Tue, 17 Jun 2025 07:07:50 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00112ae8a423a3e4b4.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:112a:e8a4:23a3:e4b4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4531fe85260sm167432695e9.0.2025.06.17.07.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:07:49 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:07:48 +0200
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
Subject: [PATCH stable 6.1-6.12 1/2] net: Fix checksum update for ILA
 adj-transport
Message-ID: <6520b247c2d367849f41689f71961e9741b1b7eb.1750168920.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ Upstream commit 6043b794c7668c19dabc4a93c75b924a19474d59 ]

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
index 1338cb92c8e7..28b101f26636 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -158,7 +158,7 @@ void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
 			       const __be32 *from, const __be32 *to,
 			       bool pseudohdr);
 void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
-				     __wsum diff, bool pseudohdr);
+				     __wsum diff, bool pseudohdr, bool ipv6);
 
 static __always_inline
 void inet_proto_csum_replace2(__sum16 *sum, struct sk_buff *skb,
diff --git a/net/core/filter.c b/net/core/filter.c
index 99b23fd2f509..e0d978c1a4cd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1999,7 +1999,7 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
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


