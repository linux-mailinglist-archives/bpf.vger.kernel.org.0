Return-Path: <bpf+bounces-59283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD04AC7BBA
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 12:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5468C16B988
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E998D258CCE;
	Thu, 29 May 2025 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr1DLfcq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A230A55;
	Thu, 29 May 2025 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748514491; cv=none; b=E13w/5hydUgYPhDthL/0cyP7YI6LrwIxo/lJQ+N5x5wXbAgVRycjgSdNupyiT0Hsg5+hGgISS3lGyG0IdXg6I1CN0mQVIq1TS8lfnzuKa8n9phPQuAUQmYIQ4zAB3DW+hF07GwfeR2Pz9UHpv1ZlIxTyBcIfJ748qmCqWW5q1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748514491; c=relaxed/simple;
	bh=r6IO1j3/kIfXiRW7FQw21r/XVQut23hpf76hG925aI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEPWO4yc14983PWAbW6exRPRiZStOKflMHQq8QoXJat7SUQI7vmyJMCmioCWwyzTY0+LfDLTwPtqN4zFy5+E3k5KuOY8bkaVNxZd4xi9fObbMVdT1gK/1T5GKSPkFahitEhIN5AUIrRrYmZWMleMVLwpPJbjIugvgXg1zZDr+Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nr1DLfcq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a35c894313so656678f8f.2;
        Thu, 29 May 2025 03:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748514488; x=1749119288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fh43oBpZD9M1XLopTWWqZgI7p0yvJH6n9OHWhcWSqD4=;
        b=nr1DLfcqS4cgcZhMxaUtICXzzcCUXRy+WAljQLIzOxFpDJ17y83lsbssMOtN5bmtqP
         zWKk56XsgVNGsVl1/gb1wJ3xAXfT0lMvOIeYIthrxyqiK8xV0a8Mz2cy5ShanZE1FW3b
         GSbs4HA7a2mz9UtrfuH78DEHZdY/6ockoKCekiyQEs+d7bPZLS/KLRsSAMm2rxFVEZyK
         7WjKK4/9DVRekvWEKZVIXtFZvtJAGwW2OQ4nwvzFS50q/1qn/SQCK9W1M4wUPG4H4URW
         cQ665CDp9+zwEqJz9eCePAQFWjb+eeAvHa1SnD4Fj14FkdrtL1z9X7xxHdPECvwZnq60
         KDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748514488; x=1749119288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh43oBpZD9M1XLopTWWqZgI7p0yvJH6n9OHWhcWSqD4=;
        b=lkb1pcFxGOqsBA0OiSO370unqP8OGqkw466QPwKSLz+A9V9SiFYGTK60Ol5E7rI4uk
         nloeA5i4w0vNQ8bc70JnVG6sV+3oUZK6XPs7xZiNN4Me9DU/cliWLxrk+cZCKncl14XA
         S6ZVawURp4qP7mieb19kqQrCPNx2V21RCXL3eq2iGxn+9FtwPx3GQdlBNrZRGmHkWmI0
         qeX3RPytrKuuDBuwAX3SWewyZBdZNYO90UfIGjimKBKcU0v+UbzSwuisZR1ythvnmDXM
         /Wcqra9gKYtV+BicOkJZHiYjT+pcmz1TDeeKwyipGinNgjQFmXPh6OlLD0C6iFIrCXLZ
         927A==
X-Forwarded-Encrypted: i=1; AJvYcCX/882GrD2Ip75/R6YqnxWjfQyjX0B7Od5v7ZGzAiAjnMvr/JEYYJfE3d6TRWLNirX297g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZNPGBvZ5mAycwwzZI2X8KxVvwJmoZ4p2pREiPyklG0flwSebS
	OSGTOaXVnPjLxtob4dx1bPIfPREKTXXcRzi4GXKI3ICz4cPDn4Wz+qG0tONz6yWD
X-Gm-Gg: ASbGncu+auJaaZrsN0DkA0KAUXaavHIYv+kdxSwxGVDQmEfi/vhKeOvGLIqCsl6KoHd
	zw6c2Xa/hcfERF/2OYP/v70yfqyVOsVI8eJk71TvfXls/kMnv/F+OZ60qvybvhtHRi4NaBzBDEO
	ovbymMP5BCljo38qTJQ3Xp84WmLJH91U3g+XyvHxCIAViX0yguAG+ZVanouVFnxDqsJMstYM58Q
	NR0C00D2V0mYQ3n6NRyNoksM5muZLz6mImCKD0WaYUk6LMEPagZj0ma701gt1Bf9zEneuZIVSRn
	CBY0Ac+15ip5vkhuY5TFbe/NC64+KE5UzujWiUl4UkzsCn4qjDaZ7R4LtZ+P8O0Ild29yEVKhnL
	QVirkOTRMdBT1Sx0rXWp1vfWvwOcPpal6UjorMa9sgewqCbpryQ==
X-Google-Smtp-Source: AGHT+IEk1HuuHG29DFeQbE3AlpiZ6BZcaM+te3V32Z8KVttZgJ8/4/Ov3toNZFQlzBGxSTIbjxLfkw==
X-Received: by 2002:a05:6000:4283:b0:3a4:d8f2:d9d with SMTP id ffacd0b85a97d-3a4d8f20e6cmr13329159f8f.38.1748514487591;
        Thu, 29 May 2025 03:28:07 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00bc44bdc1afbcf705.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:bc44:bdc1:afbc:f705])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b7f8sm1552528f8f.3.2025.05.29.03.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 03:28:07 -0700 (PDT)
Date: Thu, 29 May 2025 12:28:05 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Tom Herbert <tom@herbertland.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH net v3 1/2] net: Fix checksum update for ILA adj-transport
Message-ID: <b5539869e3550d46068504feb02d37653d939c0b.1748509484.git.paul.chaignon@gmail.com>
References: <cover.1748509484.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748509484.git.paul.chaignon@gmail.com>

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
---
 include/net/checksum.h    | 2 +-
 net/core/filter.c         | 2 +-
 net/core/utils.c          | 4 ++--
 net/ipv6/ila/ila_common.c | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/checksum.h b/include/net/checksum.h
index e57986b173f8..3cbab35de5ab 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -152,7 +152,7 @@ void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
 			       const __be32 *from, const __be32 *to,
 			       bool pseudohdr);
 void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
-				     __wsum diff, bool pseudohdr);
+				     __wsum diff, bool pseudohdr, bool ipv6);
 
 static __always_inline
 void inet_proto_csum_replace2(__sum16 *sum, struct sk_buff *skb,
diff --git a/net/core/filter.c b/net/core/filter.c
index ab456bf1056e..f1de7bd8b547 100644
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
index e47feeaa5a49..5e63b0ea21f3 100644
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


