Return-Path: <bpf+bounces-27324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 228F28ABE93
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 06:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543841C209F0
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 04:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7ADDDBE;
	Sun, 21 Apr 2024 04:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J8w81zC5"
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF886205E23;
	Sun, 21 Apr 2024 04:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713673227; cv=none; b=BTd58dghYxu20176OLuak+LC1y15JnPfIZFIUzNWazmKOFlTiZ6WvCOqli4SbiKm9lAjV2ay5JzyNp3tXYzwrsK4/Kyld/p9531ecnxMweXrJWxVWp9MKZwpYsi3PsOZ/kCRVretA9lX5lw57VnRGlNSJd7RBcRQeL4G3KGGRK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713673227; c=relaxed/simple;
	bh=3CuUe7uL9ymJj/BWja4ZjPVrQ7ZUNi22OJqiT5hei3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IBPteLTMutBZVTFFvnVcIWGewvxs5WJP3JwpwZC/WCH2cQ/qh6Pr/YwBWU5C5LggPdx5ULNCwsIvi6Xmk1Y+iJUO+xGTi3mbxoNO7pzq5ARhEXxLrgIX1Ms2LcLdXqsTyKQ/69BYkg5LRfZGtHY8E4+zrp+fneszX4a74sPhMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J8w81zC5; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713673213; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bO6UyB4BZo2OLU9jk/rODbkslDxInPGNh6ep7lCiazY=;
	b=J8w81zC5MBbNySJxKipyRF55NLxkWbGK9sXkt5gT2PKbBq3Q00pEpb3KMl8IK3b8qtYcL1rBOnR9Ar4hHCA/Vzt/0kpFKvvZ4eoS3bjQKqvpKrSJT1Cd1kJzIwjdR2L4g7jP0tHuIoIKsMUyFrg9aiWtOYNTpWuiXgdOdi4coJw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W4w4xWE_1713673211;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W4w4xWE_1713673211)
          by smtp.aliyun-inc.com;
          Sun, 21 Apr 2024 12:20:12 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	xuanzhuo@linux.alibaba.com,
	fred.cc@alibaba-inc.com
Subject: [PATCH net-next 1/2] tcp: move tcp_skb_cb->sacked flags to enum
Date: Sun, 21 Apr 2024 12:20:08 +0800
Message-Id: <20240421042009.28046-2-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240421042009.28046-1-lulie@linux.alibaba.com>
References: <20240421042009.28046-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the flag definitions for tcp_skb_cb->sacked into a new enum named
tcp_skb_cb_sacked_flags, then we can get access to them in bpf via
vmlinux.h, e.g., in tracepoints.

This patch does not change any existing functionality.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 include/net/tcp.h | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index b935e1ae4caf8..ffc9371fe9dea 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -928,6 +928,19 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
 
+/* State flags for sacked in struct tcp_skb_cb */
+enum tcp_skb_cb_sacked_flags {
+	TCPCB_SACKED_ACKED	= (1 << 0),	/* SKB ACK'd by a SACK block	*/
+	TCPCB_SACKED_RETRANS	= (1 << 1),	/* SKB retransmitted		*/
+	TCPCB_LOST		= (1 << 2),	/* SKB is lost			*/
+	TCPCB_TAGBITS		= (TCPCB_SACKED_ACKED | TCPCB_SACKED_RETRANS |
+				   TCPCB_LOST),	/* All tag bits			*/
+	TCPCB_REPAIRED		= (1 << 4),	/* SKB repaired (no skb_mstamp_ns)	*/
+	TCPCB_EVER_RETRANS	= (1 << 7),	/* Ever retransmitted frame	*/
+	TCPCB_RETRANS		= (TCPCB_SACKED_RETRANS | TCPCB_EVER_RETRANS |
+				   TCPCB_REPAIRED),
+};
+
 /* This is what the send packet queuing engine uses to pass
  * TCP per-packet control information to the transmission code.
  * We also store the host-order sequence numbers in here too.
@@ -950,15 +963,6 @@ struct tcp_skb_cb {
 	__u8		tcp_flags;	/* TCP header flags. (tcp[13])	*/
 
 	__u8		sacked;		/* State flags for SACK.	*/
-#define TCPCB_SACKED_ACKED	0x01	/* SKB ACK'd by a SACK block	*/
-#define TCPCB_SACKED_RETRANS	0x02	/* SKB retransmitted		*/
-#define TCPCB_LOST		0x04	/* SKB is lost			*/
-#define TCPCB_TAGBITS		0x07	/* All tag bits			*/
-#define TCPCB_REPAIRED		0x10	/* SKB repaired (no skb_mstamp_ns)	*/
-#define TCPCB_EVER_RETRANS	0x80	/* Ever retransmitted frame	*/
-#define TCPCB_RETRANS		(TCPCB_SACKED_RETRANS|TCPCB_EVER_RETRANS| \
-				TCPCB_REPAIRED)
-
 	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
 	__u8		txstamp_ack:1,	/* Record TX timestamp for ack? */
 			eor:1,		/* Is skb MSG_EOR marked? */
-- 
2.32.0.3.g01195cf9f


