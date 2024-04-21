Return-Path: <bpf+bounces-27323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 824EE8ABE91
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 06:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C69281143
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 04:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EA0D2EE;
	Sun, 21 Apr 2024 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Vz/M4rz0"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4A4431;
	Sun, 21 Apr 2024 04:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713673227; cv=none; b=qqzl0b8oaN5uS9cq7k8HojO10wYUM5jGa6EUNAoBxM5KcJhEPg8yXv4IJTW0tR534MmIKgZ/MWsps6fJAe0B+x208zbYOIrH76XS3EUHZy6ZOMI/zkTjas4orHLpmnfOfauc00WbokgQ2iOqoBNxulIkzqVYWeFYL5xxGLViffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713673227; c=relaxed/simple;
	bh=PbyRkYuJytgE5iCU+AC5a5bJtUe0HIu2Mw1mFTE/GVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JDy3q8BnMekwJ6arVKIyJfHowI4XW1EujUh9bCrElW8SVEnLoI0RnZy5eFpN0y+DuQ1rpkVONI/vMgeJiwWDr/awBP5SQz25TUXdNC+OipQ7y+lxdr9KTb5olzBh6g2UQ28P+Njy5TK3noJeZtBRn36K5dtQIFpJYK764Ws++28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Vz/M4rz0; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713673216; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3Exkxp2sjjjIWtsxU2G5SREfLgBVMfFhoE2jzGKVPAw=;
	b=Vz/M4rz04vZbP9HvFikC1UweAKDw1mobOircSi2iYztYNZ9xOnT08FU2y+4N1odAJtQhMquymb+IBbNtsNukY6QF2jDCckVmR7CUd+rfyG4Mp8Md+dgkm7OD3PWYah19mrLvrV841YQIQQWo+rgXNj6ETNMsmzTvIBGJjbCjJi8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W4w6o4T_1713673213;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W4w6o4T_1713673213)
          by smtp.aliyun-inc.com;
          Sun, 21 Apr 2024 12:20:14 +0800
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
Subject: [PATCH net-next 2/2] tcp: update sacked after tracepoint in __tcp_retransmit_skb
Date: Sun, 21 Apr 2024 12:20:09 +0800
Message-Id: <20240421042009.28046-3-lulie@linux.alibaba.com>
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

Marking TCP_SKB_CB(skb)->sacked with TCPCB_EVER_RETRANS after the
traceopint (trace_tcp_retransmit_skb), then we can get the
retransmission efficiency by counting skbs w/ and w/o TCPCB_EVER_RETRANS
mark in this tracepoint.

We have discussed to achieve this with BPF_SOCK_OPS in [0], and using
tracepoint is thought to be a better solution.

[0]
https://lore.kernel.org/all/20240417124622.35333-1-lulie@linux.alibaba.com/

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 net/ipv4/tcp_output.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 61119d42b0fd2..e19e74e005c1b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3390,11 +3390,6 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 		err = tcp_transmit_skb(sk, skb, 1, GFP_ATOMIC);
 	}
 
-	/* To avoid taking spuriously low RTT samples based on a timestamp
-	 * for a transmit that never happened, always mark EVER_RETRANS
-	 */
-	TCP_SKB_CB(skb)->sacked |= TCPCB_EVER_RETRANS;
-
 	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RETRANS_CB_FLAG))
 		tcp_call_bpf_3arg(sk, BPF_SOCK_OPS_RETRANS_CB,
 				  TCP_SKB_CB(skb)->seq, segs, err);
@@ -3404,6 +3399,12 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	} else if (err != -EBUSY) {
 		NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPRETRANSFAIL, segs);
 	}
+
+	/* To avoid taking spuriously low RTT samples based on a timestamp
+	 * for a transmit that never happened, always mark EVER_RETRANS
+	 */
+	TCP_SKB_CB(skb)->sacked |= TCPCB_EVER_RETRANS;
+
 	return err;
 }
 
-- 
2.32.0.3.g01195cf9f


