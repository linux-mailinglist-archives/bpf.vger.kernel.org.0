Return-Path: <bpf+bounces-48648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9889CA0A8A7
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 12:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8E73A88C4
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 11:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409321B414B;
	Sun, 12 Jan 2025 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDF4AP8l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C961AF0BA;
	Sun, 12 Jan 2025 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681928; cv=none; b=G/UfzesiMVe10kNxS3Taa98Skzl++XPxwURapk0e1n7WasrFgjiDWZvjQeuJjVdnKUqpj74XWSBp6ObhKAVmGdVCyXpvVy6N/Ve0JFySz2CSYyT2O0EMjLw6iQcCeG4CaTfJaJAqL08/4P5rZeCN01BegHkT1M+8j/8jmaFWIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681928; c=relaxed/simple;
	bh=dXZN9OYzbOqKIu9QHhS7XF5V8OQ7EsPNsgPzpvt6EcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/X0CPsUNrarm58v1I8vwJbrvZUm3QS6IWj6sswb7z0Fwz3NA6d5HhgCUqSFXVfHZl0q8JA/7Zup/2uGtH4N+yZpg6z1r5DuFtejncL+yptDy1OgQQFWV2TPk3/q9nRMUkrtFvScHJlr/Cd7jZW+AFFCiUdLL8eW60ZsBK6HLQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDF4AP8l; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21661be2c2dso54955765ad.1;
        Sun, 12 Jan 2025 03:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736681926; x=1737286726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWfVbd6VYo+kf/usUvGD0JCme8UsGRycx3bttXHiKcU=;
        b=gDF4AP8l7AMcVZ6qqhx3mmQlpJudU97iZFZs5jlQOAe396OGKg1kCR+9Ox9DZe9UOU
         SScxCZCj3ckXgDlYsm21HdYIYyOVNL5KyoF3ljlgJMOWhNqOfpJB4IzqobeWjd60AnGi
         OSyaK0XxTVD80n+wwnO/1jDDB5dTIWwOaxp0ZyquguDj7CHMFW4wgubAZCoN6VFRX36d
         tgevY3TKLrY+UEZLqWrIfuZvOXZbV3ZF1WahdSMj9tzR0FlsOkyxgX6S93yIp8UuYVr+
         sCDQrxOZ3cvGPfil8dr+w2Gw5dIKzy85CNU+ViMzBc7CWezHieCfRlq3KOn6+2UF+EsC
         wYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736681926; x=1737286726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWfVbd6VYo+kf/usUvGD0JCme8UsGRycx3bttXHiKcU=;
        b=myFbD4Oyy6uwEL05Fq67E7WcMVQZ5wRC8euYW8SO2fLo1lrOyB1qbZbhMspL5hQ/A/
         ESF2q7gQ5/ZS9GTw8H3ZlcrPpKzjZfygHUqqFwCX/tONgVvxjCE7lcQ+q+QnlKrrN+IB
         gZjMEheTQ3qqHdjWmzYFgX/miT06e9v1XdGFgobC17YsR9EPqN+ZYT/Y2IucqIjhucKO
         0/2YSRM14ZAfYKUjre9t3VFl+ZGEv1M4ehgbxXei62qalhN+bQZkU44YClfl02s/WYCR
         HT+AvZjPaAqwpJtKuF7ZvGSxf0xlnrPXXFjF1GtuA/bzzm874quEZQQW//v1w6C+pGEN
         Wstw==
X-Forwarded-Encrypted: i=1; AJvYcCVui8OWPgYqs54IGqBEFWO6OCatygGrm4h9K1Z2zDqP8vlw0gNWVJlNR3kD9RXHBtRDrZrn6B4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza9zYCSBxlFNYuLJJkqCxmshpBKCZSiAZScilCW7SgrgnbAAvU
	5x6+hJZTGGHupGWoV1ZaS8R0BRfMYQlmY51wUtGqTara8yvxlHMVGcJSiEc7
X-Gm-Gg: ASbGnctO54O/BQurkbcAW5m12XJq6SS2B/tnf89bDQUXUz/Gg90CTmSsUtZX1BUenFa
	Ku9D2OvZ5/1f71RE4kArG3FsD/TDRgZflhmJeRs4UdVFYWHppjAfWntXjPnWQ9eicVj2ik+XqQQ
	5GZZWcIEOQ6KztOg/cxOaLgUF2gDpbn3Gc4ex2zKCJ45cVwmtfks+GnZSYwYDukjqXTuj8cSklV
	kY6z9OhYG1uQMeWiDofDg70Kuu44qzGPv8Zixpw7YAONyARNe17hveAsL+6r9gFuQ7JT9wgWB2a
	zfuLQGnDmfdM5BnxLSo=
X-Google-Smtp-Source: AGHT+IGTNAZiHncEpO5/cQkLzUZ1ckLPMQUcokupwzURAEKXgVgjUjvKIM+MOepLQS9zUccntHpiDg==
X-Received: by 2002:a17:902:d488:b0:215:4394:40b5 with SMTP id d9443c01a7336-21a83fd2700mr283552695ad.43.1736681926540;
        Sun, 12 Jan 2025 03:38:46 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm37353765ad.224.2025.01.12.03.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 03:38:46 -0800 (PST)
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
Subject: [PATCH net-next v5 09/15] net-timestamp: support SCM_TSTAMP_ACK for bpf extension
Date: Sun, 12 Jan 2025 19:37:42 +0800
Message-Id: <20250112113748.73504-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250112113748.73504-1-kerneljasonxing@gmail.com>
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
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
index 5b2b04835688..f00a8e3f9b31 100644
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
index a6d761f07f67..a0aff1b4eb61 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7032,6 +7032,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_ACK_OPT_CB,	/* Called when all the skbs are
+					 * acknowledged when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0fb31df4ed95..17b9d8061f04 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5581,6 +5581,9 @@ static void __skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, int tstype
 	case SCM_TSTAMP_SND:
 		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
 		break;
+	case SCM_TSTAMP_ACK:
+		op = BPF_SOCK_OPS_TS_ACK_OPT_CB;
+		break;
 	default:
 		return;
 	}
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c2cdd0acb504..0f2e6e73de9f 100644
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
index 7b4d1dfd57d4..aa1da7c89383 100644
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
index 73fc0a95c9ca..0fe7d663a244 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7025,6 +7025,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
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


