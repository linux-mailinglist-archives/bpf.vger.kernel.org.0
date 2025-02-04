Return-Path: <bpf+bounces-50448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C43EA279D8
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B982C18834FC
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CCB2185BB;
	Tue,  4 Feb 2025 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE17tjrv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C29216E2C;
	Tue,  4 Feb 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693886; cv=none; b=OH1dvi9n0PobpxgOdOZ9OX+uE8jNa7TLFt+ZbyOFz3kRnkmVe0s2TBAZt1a7S+8+jGixe29ETlWyyk7ZLSTaIVSS5YLdtiwdOYGq6D+qmuVgIFhaD4e2UxqMEvwDUxpZJF6A8tPiyKpLRiZacA5LAALnm4wB8LPuQLhpDn4W41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693886; c=relaxed/simple;
	bh=GbF9i/NGoOssMZ+z2pMQC8kaLk08sX+9r+6MbyYAkqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iaQT6MCLXQx1/yI+LtB1z+LBFPXFgrmiyQC7/+vRMiZREu3UGiUX/sYpy31ZCLBjUUrtpklOZx8/9jkcGJzRufjd9QJIbgGx4yfndpgI/JAUemCwYoKS1plqUX6l4uIbMJSOqHCHsZYNLLVfTP6Pwczs+SiHZISV4DR+P/CXVMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE17tjrv; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso7794004a91.1;
        Tue, 04 Feb 2025 10:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738693884; x=1739298684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSJKwhBaTBjXSOqUzx7GMH/QTzRAVzoR3hkZEhBsQ34=;
        b=JE17tjrvN20hTDbmcG6EcjxaM5Uehu5qkEEOXncdItrRCpg57KL1H1bwfmLzMvvImd
         pCLRUvqmb+3hCJ9BdrtpHtc7GcJdFTi0nAQYMx9RIbDTBF3iv0yvUIiOVGTQmfPchYmE
         X4v61XTCH2bzaEeaFh5Zww+en2x7NxGblQ/SDL0hNKiH6cCN8WTcXnWlv/RqzEs6fvmu
         bq6jZCDADJ3gEkQJtkb6j1aRiRQuH7AiuEQw87pwuqEK3l1AaqwVH052DVQWGAFwu/i3
         www+yglKv+XOLRg9fkPSVaLedAaLv9Jo8gsh1SEWlNmxOAjoBnaZLk/Tiyv3MXX6ULZ0
         qVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693884; x=1739298684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSJKwhBaTBjXSOqUzx7GMH/QTzRAVzoR3hkZEhBsQ34=;
        b=suCfBd8CJ0VLcYNsvrJFGXdakJhqUH7zklamhftDUmK0Kl7C8/YzsaV+KYvg9HIqy3
         3MsmC1R0IB4aGjApOrnJ7Y02pjZToSg21wIof4UC1hVceM/rNfbP/WBbPC8rwqiKV5H7
         jKEJHA0MBpOdIy0o+sgqLHSWyKyfRrqsHYgUBOZL2u61jBplrNO8vx8F71+3IDt/A8Xb
         GL0tQg4AdN0Kle104pR4y3ka5KHLgVXRg/0tMj/SYAd2MidzyohMZYdBtM4GqK3BJ3IW
         AwixYGQrMihORfkrCZ3uFSGVGPMJp197dHVD/V6DlUsEmauFhIJyNc2mugUW9GxY9p+P
         qReg==
X-Forwarded-Encrypted: i=1; AJvYcCUu7qHkjI3AluakERoF1+Ni0bJmuoe1O5B0sHA6/gWlusOjQ4b5WwqN+L0V0qRBrBSHE2pWxao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxILJAIgDLo1Y/RNOZ477L5BwTsYgyo5xh1l5iwD+vutxEALNX+
	qwh3wc4wwGp/p3zsr+n3zwhCb+ZRYJkZ0ZN0U4CigjXIFHfXJrL/
X-Gm-Gg: ASbGncspNyAhMqYMclDysQ/TP7336AFukL2CBauSJSes0KwVnLYGEfCNztxF9bX7PL8
	pwTgCpMGKY3lsmXZSFJeyLpMNPt4EvXVysVoOw1O4hz4kFEDS3BvELH65aGayfQiBydIWXinzgn
	Cqzfsk6TL1Yaf7m5dKsIbkqVhScK55RgKjKXC1XJJbQeZffH9VtKU+t1L0WeLB2dlkuPyfeLSL8
	Zspj/mbE2N0aj/ENU9hzun4DIVnivGhrV36OVKJ0qqKR7KIFv5un9xeHv0hdocJVt9LE36UYw1O
	JHtXbYNOwpkqsZ94MgDaM3PsiXjsRP/lWFIYO+39iOgu0hU86yUl+g==
X-Google-Smtp-Source: AGHT+IGTb5RZPksSbgur+iLH3+VpLpb1vlkxAluOSPQrrfVOJgeFolAVqRv5XAuM5wbpvvvMvzikTQ==
X-Received: by 2002:a17:90b:53c8:b0:2ee:c04a:4281 with SMTP id 98e67ed59e1d1-2f83abb3525mr36340628a91.6.1738693884338;
        Tue, 04 Feb 2025 10:31:24 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848a99a45sm11590591a91.38.2025.02.04.10.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:31:24 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v8 09/12] bpf: support SCM_TSTAMP_ACK of SO_TIMESTAMPING
Date: Wed,  5 Feb 2025 02:30:21 +0800
Message-Id: <20250204183024.87508-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250204183024.87508-1-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle the ACK timestamp case. Actually testing SKBTX_BPF flag
can work, but Introducing a new txstamp_ack_bpf to avoid cache
line misses in tcp_ack_tstamp() is needed. To be more specific,
in most cases, normal flows would not access skb_shinfo as
txstamp_ack is zero, so that this function won't appear in the
hot spot lists. Introducing a new member txstamp_ack_bpf works
similarly.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/tcp.h              | 3 ++-
 include/uapi/linux/bpf.h       | 5 +++++
 net/core/skbuff.c              | 3 +++
 net/ipv4/tcp_input.c           | 3 ++-
 net/ipv4/tcp_output.c          | 5 +++++
 tools/include/uapi/linux/bpf.h | 5 +++++
 6 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 293047694710..88429e422301 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -959,9 +959,10 @@ struct tcp_skb_cb {
 	__u8		sacked;		/* State flags for SACK.	*/
 	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
 	__u8		txstamp_ack:1,	/* Record TX timestamp for ack? */
+			txstamp_ack_bpf:1,	/* ack timestamp for bpf use */
 			eor:1,		/* Is skb MSG_EOR marked? */
 			has_rxtstamp:1,	/* SKB has a RX timestamp	*/
-			unused:5;
+			unused:4;
 	__u32		ack_seq;	/* Sequence number ACK'd	*/
 	union {
 		struct {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4c3566f623c2..800122a8abe5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7047,6 +7047,11 @@ enum {
 					 * timestamp that hardware just
 					 * generates.
 					 */
+	BPF_SOCK_OPS_TS_ACK_OPT_CB,	/* Called when all the skbs in the
+					 * same sendmsg call are acked
+					 * when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 264435f989ad..a8463fef574a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5579,6 +5579,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
 		if (!sw && hwtstamps)
 			*skb_hwtstamps(skb) = *hwtstamps;
 		break;
+	case SCM_TSTAMP_ACK:
+		op = BPF_SOCK_OPS_TS_ACK_OPT_CB;
+		break;
 	default:
 		return;
 	}
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 62252702929d..c8945f5be31b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3323,7 +3323,8 @@ static void tcp_ack_tstamp(struct sock *sk, struct sk_buff *skb,
 	const struct skb_shared_info *shinfo;
 
 	/* Avoid cache line misses to get skb_shinfo() and shinfo->tx_flags */
-	if (likely(!TCP_SKB_CB(skb)->txstamp_ack))
+	if (likely(!TCP_SKB_CB(skb)->txstamp_ack &&
+		   !TCP_SKB_CB(skb)->txstamp_ack_bpf))
 		return;
 
 	shinfo = skb_shinfo(skb);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 695749807c09..fc84ca669b76 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1556,6 +1556,7 @@ static void tcp_adjust_pcount(struct sock *sk, const struct sk_buff *skb, int de
 static bool tcp_has_tx_tstamp(const struct sk_buff *skb)
 {
 	return TCP_SKB_CB(skb)->txstamp_ack ||
+	       TCP_SKB_CB(skb)->txstamp_ack_bpf ||
 		(skb_shinfo(skb)->tx_flags & SKBTX_ANY_TSTAMP);
 }
 
@@ -1572,7 +1573,9 @@ static void tcp_fragment_tstamp(struct sk_buff *skb, struct sk_buff *skb2)
 		shinfo2->tx_flags |= tsflags;
 		swap(shinfo->tskey, shinfo2->tskey);
 		TCP_SKB_CB(skb2)->txstamp_ack = TCP_SKB_CB(skb)->txstamp_ack;
+		TCP_SKB_CB(skb2)->txstamp_ack_bpf = TCP_SKB_CB(skb)->txstamp_ack_bpf;
 		TCP_SKB_CB(skb)->txstamp_ack = 0;
+		TCP_SKB_CB(skb)->txstamp_ack_bpf = 0;
 	}
 }
 
@@ -3213,6 +3216,8 @@ void tcp_skb_collapse_tstamp(struct sk_buff *skb,
 		shinfo->tskey = next_shinfo->tskey;
 		TCP_SKB_CB(skb)->txstamp_ack |=
 			TCP_SKB_CB(next_skb)->txstamp_ack;
+		TCP_SKB_CB(skb)->txstamp_ack_bpf |=
+			TCP_SKB_CB(next_skb)->txstamp_ack_bpf;
 	}
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 974b7f61d11f..06e68d772989 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7040,6 +7040,11 @@ enum {
 					 * timestamp that hardware just
 					 * generates.
 					 */
+	BPF_SOCK_OPS_TS_ACK_OPT_CB,	/* Called when all the skbs in the
+					 * same sendmsg call are acked
+					 * when SK_BPF_CB_TX_TIMESTAMPING
+					 * feature is on.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


