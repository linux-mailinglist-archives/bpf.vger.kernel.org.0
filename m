Return-Path: <bpf+bounces-49940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48C4A2067E
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 09:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9A1188A6DE
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 08:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD0C1EEA54;
	Tue, 28 Jan 2025 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHzOQhfn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F61DE4E3;
	Tue, 28 Jan 2025 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054045; cv=none; b=r7rdN49wWkv0ry3lKTZpPDqdU//4dVj1OVt2oilTEEIhda6vjXUn7vbUq/Iu0vCP0a96klhtHhiEF4hv43PG6BamKQX7LQsauack+VTQ09r1O5iBYEP2mGykpTkZfWjhPeabxGhZXUNLouzkdopLJjlviCn2gJ2uDLhu+l9cfVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054045; c=relaxed/simple;
	bh=vWZydBKP59s3FpOObSwDDoUwuCZmN9vaGxIbWHzZSIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qAbnn+vsrh+Aa6qiiYkI+wigONn09q4ApKBOtDy/MgTa8sTFPDgUgiicWnvhQEyepn4FYJqCm6VRevrzS6vBAb95PiHDZS+UPJZeu8jZoueD3zf4ssst7jGyYxCqTGVCKFagLGvwzL1pLiYh2sKIuJDzVmMkOR7Uts4izkqJ/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHzOQhfn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216401de828so97138025ad.3;
        Tue, 28 Jan 2025 00:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738054043; x=1738658843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1I2k2ii3QrIAPoqerPtjO/Qv/9nXmEL2qWUmYgFeL2w=;
        b=KHzOQhfnrVSJO8ZVKWUwdzroOUqrfmv529X48X6LTiqq5Vw1xWWDvQ0Zc1D9j4oQ9X
         VPXjlyeN2znSo9l4BUvxtff+PE1aE1dGAmqBd3WHvesnqdc19jchA1lNNVi92N/elzxL
         MC93XZVUCnRVKyThE7mBpWo6KwHwXPUzzq5pLO9hKM4YDc7Rja08HQHBJ9D0wxLf3pS2
         zZza3LqTUC5kJar8DoYWcTKuPni6DzgzXJoc34xhGAabCGEcr6isGC8ObPOp/vVSs0iv
         6UfhF6ay6cJgpjHqCI2sEPbJ30PdQJn7ZAt4jrmb5tiEWzlpUfnjHdyAXfvRKjIiDg3b
         rISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738054043; x=1738658843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1I2k2ii3QrIAPoqerPtjO/Qv/9nXmEL2qWUmYgFeL2w=;
        b=BIK/FIu3oUwZ9CX61avjUTiBmhV5dIR+Zd8B0GK0lGDp2EgRncRKI5wXFQhiYwjNl+
         M1Tqri/K2YnXUDUTb083cyIGUD0xbYXlSptZObZPXDxdw/v0O8kP7lyotlbNmnAziRGE
         8yCORwWxv6qqHCKYJI5Ut94DIg3pt6WkeU4tFcSZPmQbbKlns0WMnapTpCxdMuaanHAP
         KYyMOwiGy9CuD5NMTlpzgQxGYGC+wkHecOO5cen21oAgz3D/oLtQKN8PEFLN//oUwJh2
         ooSltZG4qP7hxsbedYX0lBZMCRKiX61og+LK2m5PlfT5QwuMUeESi9P2tMDGwNjRqKXn
         6Yvg==
X-Forwarded-Encrypted: i=1; AJvYcCVP8G53uJMyle0AErrRYuGPSOBDqQFbWtJn1YdYZK5vYbMhS3+bC4w9fTyGgb5VeysyAcLcTOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM1zkG4n+IkPmfDsyi3ly1YXWsR2ZZcmOInMMgnbKjFYVNilMc
	vI1/Qvozbgl2xiW5RARfVyWyQNIf6K0mok0IdLAyGNj/CYoy5I3O
X-Gm-Gg: ASbGncsqPX4UqWqpHq92iI/RtWqHhD0xR0LJicjYLcvymnPDJ0glQW573Wxlh7zfJ2c
	RotczdnYwynRWA0rm7OkkrVWcwxDo35IMqlwBldkqhADIAXbq7tVQ6UFuhIAx2yf/1e0Z/AkHoh
	w+ZUfk9cVTYtNYb3n9aBzfpRMyz6tWtWmdwPjSfOmWFGSj6QQcI4JNJkwvoxPCSY9Ni3qtxbkwF
	kNivmwI6F+LI7CNt6UJ/FfhMCeWEQl8hz6o6xc1kISF5dbtfCxo051YtRhemv0tvEvED/o/gJbB
	1CNI+pddUqBis4JdlcnJJsKY6sNtgx12QucUrijUB7szjvRRAMhwaQ==
X-Google-Smtp-Source: AGHT+IEOgpIoxWkHGtV5xl3H/Q4LFOGvxPyFx7ldYG0RAQS5TXEGE+OdRQFP9qOd9i7OF3SRh7gh+w==
X-Received: by 2002:a17:902:ea08:b0:21d:3bd7:afe8 with SMTP id d9443c01a7336-21d3bd7b2acmr469423555ad.49.1738054043149;
        Tue, 28 Jan 2025 00:47:23 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e2b8sm75873275ad.205.2025.01.28.00.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:47:22 -0800 (PST)
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
Subject: [PATCH bpf-next v7 09/13] net-timestamp: support SCM_TSTAMP_ACK for bpf extension
Date: Tue, 28 Jan 2025 16:46:16 +0800
Message-Id: <20250128084620.57547-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250128084620.57547-1-kerneljasonxing@gmail.com>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle the ACK timestamp case. Actually testing SKBTX_BPF flag
can work, but we need to Introduce a new txstamp_ack_bpf to avoid
cache line misses in tcp_ack_tstamp(). To be more specific, in most
cases, normal flows would not access skb_shinfo as txstamp_ack
is zero, so that this function won't appear in the hot spot lists.
Introducing a new member txstamp_ack_bpf works similarly.

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
index c769feae5162..33340e0b094f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5582,6 +5582,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
 		if (!sw)
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


