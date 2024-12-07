Return-Path: <bpf+bounces-46357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC8E9E8152
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 18:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA8B1667B2
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729AC1537A8;
	Sat,  7 Dec 2024 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvWKfm7q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F2E14A4DE;
	Sat,  7 Dec 2024 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593129; cv=none; b=YppHwYq0wSQSbK1w2XPSIcfO5ej07aF+YtPOp5ykI40d4yyzxV9+mgccps/eq6/Gn5NyoF8AZsK5g3InT8j2nJxlxGYoiaHgTcs7ZDFE8KynPIAYAlzoK9U74Qm2dcRnoYZUdt8Yau5Ho+ATg0vGWLAMFlxYo0fKYXw6y0dLvSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593129; c=relaxed/simple;
	bh=MV4j6wI8e8wrAsXZA62Wh/CtHWSGABDNgWbeQpwWa18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q5Xwn47ALCVZhF6W1/rDzsALgRjRJ3VCcWTmlq6jqPm2+z6zAUxgTWJvrauwtrEAsBnM41psrUqS5JG1Ut6Kl9Yto701yL6u+aUEXqLCUYcDgWFA6nT7j+dzOqE9lLiWWpy9JsbilWIIBh4QkWvI1oV+TrTFrhsj37z8x6UOI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvWKfm7q; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so1190151a91.0;
        Sat, 07 Dec 2024 09:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733593127; x=1734197927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUK+62+d5NSwoCGpK40FitsW+i1fUQF5wDsDR0pWIio=;
        b=SvWKfm7qMCVFh1t51pBU09L6I1JeC62J8kEfpKx4PhSJ5Ku8EX+VJeYUNmhP6anivE
         ensV5wqs/tXdWs1YXiAyhhHPfLnoL8Kac8BPdR9MvvmBzdYdaZi9cqvpghQxp8rLk23G
         LVxWU+sgjlebODxfK7OdDhIo1Q69WyLdfy0fVpq4IP+RuAn1rEYNaOqBSZ0vPlkDJarB
         RLrG3CUZfAiUQmUqgUACg2RCYz02tzSmeGf5TSCA9BGXh78CyYHFD2Ur/0aOAv5B9XmL
         5sQr2voTe2FOlCFSHJUCTOzz/9nG/5yf/vjSX8AarKf5xbQRhPCwON/YAWdMmNqelMWo
         P72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733593127; x=1734197927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUK+62+d5NSwoCGpK40FitsW+i1fUQF5wDsDR0pWIio=;
        b=BYgQMBC6S4xhHuDOiQetgugxF6qAY/8NETudzK1gSO2QkJDFYTT/P4ZsuMB8aUz+jE
         HhhSKba76Y5UARjlUVF5y/MokWRiDPlHUNiIJmXhFU8zYvSLFqvSZvG+Rx7HyRH4VHG0
         g+Fmmb1tJhglcCfPsqoxqtfa8CI9EphyAE4K6rnv8evwHAYi3d/nK8RSIOVf+2aDrUpY
         S5lA+FHpYvXfQHvkv5iqkaXgxxhKSLaUGTTeuth/tzm8Ki8dazqeKhi9HYYqDrmMD7cI
         g4w1Om5bYFIBgdMmUUZITYjUbkDRdDrpnvGTw4lwHvacOGrrfhsFK0rAc7HLQjfeYx/Q
         SrLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWpqtdsM1Lx7rt9/BItgmeE6HF3DEHeTlleogsU/4B9Rr3po77iXfiUD+bxrGxvsCPpwaq1vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgikDVyQc6Q/ZiN1ONJ8IJvPP+ltm4Q9ngcUEMxM89HvoXzo2
	T523fKGZCMzqtgrxxfNNJooQWZ//uYhzbLkylASyM7V0XUDAZA7ID2rZ7rSZ/bI=
X-Gm-Gg: ASbGncv4SR6JW7XBIPn4jWPdZyQdXb9S0B6PcwA39frFwpeEC/P8/2qiAzgTP+8LJIH
	xq8he1FlvnkZjRANAOaWdbwdiCR7ZzS8oy1NKwtV4aZ9hD0fVppfFHF2jPRdAJLOVN3YRQ9tJR9
	8XAu3S1OlFN+47mbt8vdM+xzL5/i6YchCvzc7X3Q+yHlep7xjhjbIO0LXqQOfNixtnVoNI6m0Rz
	noycft0RJrB5PPPYwaoxkcbYCbanucqxQDNmbA5tR2m+Hc4WKJTGuf7YRrYkM9RKeHVJs/CBnQ2
	3DHGtmLhgOEx
X-Google-Smtp-Source: AGHT+IHN2vEdBQK6rKaMWJPgkc0yBssEJDWOq07NaeydbkjdfABv5wUR6a86z/60jvqmoPTJssvB6g==
X-Received: by 2002:a17:90b:2744:b0:2ea:77d9:6345 with SMTP id 98e67ed59e1d1-2ef6a6c10d9mr10056213a91.22.1733593126878;
        Sat, 07 Dec 2024 09:38:46 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b807sm6963793a91.43.2024.12.07.09.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:38:46 -0800 (PST)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 06/11] net-timestamp: support SCM_TSTAMP_ACK for bpf extension
Date: Sun,  8 Dec 2024 01:37:58 +0800
Message-Id: <20241207173803.90744-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241207173803.90744-1-kerneljasonxing@gmail.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Handle the ACK timestamp case. Actually testing SKBTX_BPF flag
can work, but we need to Introduce a new txstamp_ack_bpf to avoid
cache line misses in tcp_ack_tstamp().

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/tcp.h              | 3 ++-
 include/uapi/linux/bpf.h       | 5 +++++
 net/core/skbuff.c              | 9 ++++++---
 net/ipv4/tcp_input.c           | 3 ++-
 net/ipv4/tcp_output.c          | 5 +++++
 tools/include/uapi/linux/bpf.h | 5 +++++
 6 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index e9b37b76e894..8e5103d3c6b9 100644
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
index 73b15d6277f7..48b0c71e9522 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5553,6 +5553,9 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb, int tstype
 	case SCM_TSTAMP_SND:
 		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
 		break;
+	case SCM_TSTAMP_ACK:
+		op = BPF_SOCK_OPS_TS_ACK_OPT_CB;
+		break;
 	default:
 		return;
 	}
@@ -5632,9 +5635,9 @@ static bool skb_tstamp_is_set(const struct sk_buff *skb, int tstype, bool bpf_mo
 			return true;
 		return false;
 	case SCM_TSTAMP_ACK:
-		if (TCP_SKB_CB(skb)->txstamp_ack)
-			return true;
-		return false;
+		flag = bpf_mode ? TCP_SKB_CB(skb)->txstamp_ack_bpf :
+				  TCP_SKB_CB(skb)->txstamp_ack;
+		return !!flag;
 	}
 
 	return false;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5bdf13ac26ef..82bb26f5b214 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3321,7 +3321,8 @@ static void tcp_ack_tstamp(struct sock *sk, struct sk_buff *skb,
 	const struct skb_shared_info *shinfo;
 
 	/* Avoid cache line misses to get skb_shinfo() and shinfo->tx_flags */
-	if (likely(!TCP_SKB_CB(skb)->txstamp_ack))
+	if (likely(!TCP_SKB_CB(skb)->txstamp_ack &&
+		   !TCP_SKB_CB(skb)->txstamp_ack_bpf))
 		return;
 
 	shinfo = skb_shinfo(skb);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 5485a70b5fe5..c8927143d3e1 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1552,6 +1552,7 @@ static void tcp_adjust_pcount(struct sock *sk, const struct sk_buff *skb, int de
 static bool tcp_has_tx_tstamp(const struct sk_buff *skb)
 {
 	return TCP_SKB_CB(skb)->txstamp_ack ||
+	       TCP_SKB_CB(skb)->txstamp_ack_bpf ||
 		(skb_shinfo(skb)->tx_flags & SKBTX_ANY_TSTAMP);
 }
 
@@ -1568,7 +1569,9 @@ static void tcp_fragment_tstamp(struct sk_buff *skb, struct sk_buff *skb2)
 		shinfo2->tx_flags |= tsflags;
 		swap(shinfo->tskey, shinfo2->tskey);
 		TCP_SKB_CB(skb2)->txstamp_ack = TCP_SKB_CB(skb)->txstamp_ack;
+		TCP_SKB_CB(skb2)->txstamp_ack_bpf = TCP_SKB_CB(skb)->txstamp_ack_bpf;
 		TCP_SKB_CB(skb)->txstamp_ack = 0;
+		TCP_SKB_CB(skb)->txstamp_ack_bpf = 0;
 	}
 }
 
@@ -3209,6 +3212,8 @@ void tcp_skb_collapse_tstamp(struct sk_buff *skb,
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
2.37.3


