Return-Path: <bpf+bounces-49323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2426AA175BA
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391A07A26D6
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8015573A;
	Tue, 21 Jan 2025 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY63xtts"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52CE155398;
	Tue, 21 Jan 2025 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737423005; cv=none; b=sB0mRIvW5ZWrTwKpFwMPFKDGI4A9mo1FxxObJHAnFVsbVYUE2GC5uw+jgVi+Kz4kuUPFuLSjBegdZybV2vOuA1HBCPqihc0UzWHJBwowpN0PT3k/zq6k7rrfcx7rGvZFjxd+3RXko/TeEbGNVr2LutkHmo/2/MDKYaBnU1o7MP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737423005; c=relaxed/simple;
	bh=WTwZJBx4xbLt6HePgDoqCPofAl9YXcziI5sMZAyORm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pyeMqbZjMhf9yc0bYiOEXiX0nEZqP8a5pRgTina4M1xoxcT/vC9nPnXajA4e6YOi7mgEqXE0Yv112b7OtLHxzFF/3Eju/+hN22n4Epiruz8nsT/onWtapRS8FNdgd7UeVDSFFGgsMiMcon0Ptm169xv1Dmuo3shAWEXFsPJ+zTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY63xtts; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso6801823a91.1;
        Mon, 20 Jan 2025 17:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737423003; x=1738027803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lv3eDUOPZ0dOtmoJgRwt45XM9WOlETTR3Qxn+7dp+c=;
        b=DY63xttsCSstugXkFAFKJDzX0fapDjZJTqvf2+kGtSgoCzC4TxlZNCMC1WJofycCll
         +N00LhCAbjV0vX51jfV4xQx9k5ltvRI+b30hGhLyaXDmeWB9BoXgnk28Pf74U6M0dCIm
         wZwbONyISyKCvIwd1IGknkSd3mVs1EFGk0bcLGWMNZY1LlfVB9aqDmAgRUdVIg3yZ3Tb
         tIzXW0a+P5dHfqPe+hn34uzkwXFa6cF4KgGcwlRuDvTRPRXO9u/tfCwqQY19C9gU4gbx
         YBuRGoBarZpVHhWq8fl2tK6VPEM4+B9MXWQZ42zo2MfBU5NaA3zYU6w+oXaGjBZZ0q+y
         cQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737423003; x=1738027803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lv3eDUOPZ0dOtmoJgRwt45XM9WOlETTR3Qxn+7dp+c=;
        b=baat1OedQ3C38xyvib7vUOSXuNtPbgFby7NudaID4m0dBkb85KIeDJP1bY56oja0+N
         UZvdaEJdBUQw+P9W8QmqLp/KWT7yKatTRi9faGfR3tYOtf2uAFh31sHcFj9VqncQxWcR
         g224U/CxczVbkE8/qxqoArpDknKBKDsCQnSLh5d9uWCA4UpUvcOHdnUOdApz/pTJk2st
         GqPdHW8WaOXkdJy43bLtK3b05Ebqcdd0T++2aUdkICASbztAb0fDcneJpLLqYnC8AEA1
         vihRQ8tJZZ/jWkXU/Ht0H6WCRCJYvGtT4mf/gnHzjRt1vVDCtiTfmKzEohSDIkiLeZMm
         ArLg==
X-Forwarded-Encrypted: i=1; AJvYcCUYZiC8gdrJtFgf5TiYXT3Jmrsd3QuCfP3YO713d/aYofvZryS745JUW8JhZgeMOQ51gFmhRPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt7jQ/rpYbboBuSWnx4SO+HZ652p1dBs7JKyd8J0YasL0Ow4QB
	mNXOQss+FHjJwbfQmV/8bofSAmOI5M2t07WBnQML5j56q0KEzO+pObZ5IAHT
X-Gm-Gg: ASbGncv+ug97oJZ8T4C6YxZg6BlvnMtfPct4kj7RW8ARwb8KY14dIcZ1lmTV0qvrrkN
	tuSEQzF9+3qZr71ANNTh/zNeQ6vIkzT3msbDaQyPNa85c65iYmyFi+LJZ6NcED1KbW6PRPeFxdv
	7tfTdvzMw5ZSp8YRlW1K02OEU69FICyu5WdE3gBIh/TtTn1Y2vjdXmDr0CnTYQ8rp20B4f6iHRY
	gjpGVYQyM/CkMnvrewkdd236k/P0eeZgIW/K3sihhOE+/+ceM+pViGH0S8aUvTqNp3HrguO+aE5
	4UGxVEhvzZawbx3yWQpkOsb2DMwfOemg
X-Google-Smtp-Source: AGHT+IE4ubQ0/xPyRn2tqB80u6F7+pifP3Wu/AiUsya034DHZ3EPUjxgEbUoPUXyyLf+b/DlZne5sQ==
X-Received: by 2002:a05:6a00:2ea8:b0:725:aa5d:f217 with SMTP id d2e1a72fcca58-72daf94f635mr21839147b3a.7.1737423003001;
        Mon, 20 Jan 2025 17:30:03 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba55c13sm7702059b3a.129.2025.01.20.17.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 17:30:02 -0800 (PST)
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
Subject: [RFC PATCH net-next v6 09/13] net-timestamp: support SCM_TSTAMP_ACK for bpf extension
Date: Tue, 21 Jan 2025 09:28:57 +0800
Message-Id: <20250121012901.87763-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250121012901.87763-1-kerneljasonxing@gmail.com>
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
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
index 8936e1061e71..3b9bfc88345c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7037,6 +7037,11 @@ enum {
 					 * It indicates the recorded
 					 * timestamp.
 					 */
+	BPF_SOCK_OPS_TS_ACK_OPT_CB,	/* Called when all the skbs are
+					 * acknowledged when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
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
index f1583b5814ea..b463aa9c27da 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7030,6 +7030,11 @@ enum {
 					 * It indicates the recorded
 					 * timestamp.
 					 */
+	BPF_SOCK_OPS_TS_ACK_OPT_CB,	/* Called when all the skbs are
+					 * acknowledged when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


